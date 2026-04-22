%% task 1.1
% Generate a three samples 
% (N,N2,N3) of size 2000 from a standard normal distribution

N = normrnd(0, 1, 1, 2000);
N2 = normrnd(0, 1, 1, 2000);
N3 = normrnd(0, 1, 1, 2000);

% Create a sample
% Z = N2+N2^2+N3^2

Z = N.^2+N2.^2+N3.^2;

% Create a subplot with two panels.
% 1. Upper plot should compare the empirical cumulative 
% distribution functions (ecdf) of variables
% Z and the analytic cdf of χ2(3). Make the analytic curve dotted 
% and black. Set the limit of the x-axis to run from 0 to 8

figure;
subplot(2, 1, 1);
ecdf(Z);
hold on;
x = 0:0.01:8;
y = chi2cdf(x, 3);
plot(x, y, 'k:', 'LineWidth', 3, color='b'); % czarnego koloru nie widac
xlim([0 8]);
title('ECDF of Z and Analytic CDF of \chi^2(3)');
xlabel('Value');
ylabel('Cumulative Probability');
legend('Empirical CDF of Z', 'Analytic CDF', 'Location', 'Best');
hold off;

% 2. Lower plot should consist of empirical cumulative distribution 
% functions of variables N, N2 and N3. Add a legend in 'best' position

subplot(2, 1, 2);
ecdf(N);
hold on;
ecdf(N2);
ecdf(N3);
legend('Empirical CDF of N', 'Empirical CDF of N2', 'Empirical CDF of N3', 'Location', 'Best');
hold off;

% Calculate the basic statistic of variable Z (mean,median,var,skewness)
% and compare it in one table with analytic statistics of χ2(3) dist.

meanZ = mean(Z);
medianZ = median(Z);
varZ = var(Z);
skewnessZ = skewness(Z);

k = 3; % degree of freedom
meanX = k;
medianX = chi2inv(0.5, k);
varX = 2*k;
skewnessX = 2 * sqrt(2/k);

Zetki = [meanZ; medianZ; varZ; skewnessZ];
Chi = [meanX; medianX; varX; skewnessX];
nazwawierwszy = {'Mean'; 'Median'; 'Variance'; 'Skewness'};
tabela = table(Zetki, Chi, 'RowNames', nazwawierwszy);
disp(tabela)

%% task 1.2
% Load the data lab3 consisting of three data samples and plot its 
% kernel estimator

load("lab3.mat");
bandwidth1 = 0.5;
bandwidth2 = 1;
bandwidth3 = 1.5;

figure;
hold on;
ksdensity(x1, 'Bandwidth', bandwidth1);
hold on;
ksdensity(x2, 'Bandwidth', bandwidth2);
hold on;
ksdensity(x3, 'Bandwidth', bandwidth3);

title('Kernel Density Estimator for three samples: x1, x2 and x3');
xlabel('Value');
ylabel('Density');
legend(['Bandwidth = ' num2str(bandwidth1)], ['Bandwidth = ' num2str(bandwidth2)], ['Bandwidth = ' num2str(bandwidth3)], 'Location', 'Best');
hold off;

% For each sample use two kernel functions with two bandwidth 
% values (for each function) and plot them on one figure
% (one figure per sample)

bandwidthh1 = 0.5;
bandwidthh2 = 1.5;
kernel1 = 'normal';
kernel2 = 'epanechnikov';

figure;
hold on;
ksdensity(x1, 'Kernel', kernel1, 'Bandwidth', bandwidthh1);
ksdensity(x1, 'Kernel', kernel1, 'Bandwidth', bandwidthh2);
ksdensity(x1, 'Kernel', kernel2, 'Bandwidth', bandwidthh1);
ksdensity(x1, 'Kernel', kernel2, 'Bandwidth', bandwidthh2);
title('Kernel Density Estimator for Sample x1');
xlabel('Value');
ylabel('Density');
legend([kernel1, ' (BW=' num2str(bandwidthh1) ')'], [kernel1, ' (BW=' num2str(bandwidthh2) ')'], [kernel2, ' (BW=' num2str(bandwidthh1) ')'], [kernel2, ' (BW=' num2str(bandwidthh2) ')']);
hold off;

figure;
hold on;
ksdensity(x2, 'Kernel', kernel1, 'Bandwidth', bandwidthh1);
ksdensity(x2, 'Kernel', kernel1, 'Bandwidth', bandwidthh2);
ksdensity(x2, 'Kernel', kernel2, 'Bandwidth', bandwidthh1);
ksdensity(x2, 'Kernel', kernel2, 'Bandwidth', bandwidthh2);
title('Kernel Density Estimator for Sample x2');
xlabel('Value');
ylabel('Density');
legend([kernel1, ' (BW=' num2str(bandwidthh1) ')'], [kernel1, ' (BW=' num2str(bandwidthh2) ')'], [kernel2, ' (BW=' num2str(bandwidthh1) ')'], [kernel2, ' (BW=' num2str(bandwidthh2) ')']);
hold off;

figure;
hold on;
ksdensity(x3, 'Kernel', kernel1, 'Bandwidth', bandwidthh1);
ksdensity(x3, 'Kernel', kernel1, 'Bandwidth', bandwidthh2);
ksdensity(x3, 'Kernel', kernel2, 'Bandwidth', bandwidthh1);
ksdensity(x3, 'Kernel', kernel2, 'Bandwidth', bandwidthh2);
title('Kernel Density Estimator for Sample x3');
xlabel('Value');
ylabel('Density');
legend([kernel1, ' (BW=' num2str(bandwidthh1) ')'], [kernel1, ' (BW=' num2str(bandwidthh2) ')'], [kernel2, ' (BW=' num2str(bandwidthh1) ')'], [kernel2, ' (BW=' num2str(bandwidthh2) ')']);
hold off;

% One of the samples comes from normal distribution. Based on the 
% generated plots, try to recognize which one? Prepare a q-q plot 
% to verify your assumption

% moim zdaniem sample x1 pochodzi z rozkładu normalnego, ponieważ jego 
% wykresy z poprzedniego podpunktu (kernela) prawie idealnie odwzorowują
% wygląd krzywej Gaussa
% ewentualnie x2 bo wygląda podobnie - ale i tak stawiam na x1, bo czubek
% wykresu nie jest aż tak pokrzywiony w jednym przypadku

figure;
subplot(1, 3, 1);
qqplot(x1);
title('x1 qq');
hold on;
subplot(1, 3, 2);
qqplot(x2);
title('x2 qq');
hold on;
subplot(1, 3, 3);
qqplot(x3);
title('x3 qq');
hold off;

% qq plot potwierdza poprawność wyboru próbki x1 jako tej pochodzącej
% z rozkładu normalnego

%% task 1.3
% Load the 'data4' file

load("data4.mat")

% Choose a suitable normality test and decide which vector x or y1 is 
% normally distributed

testx = lillietest(x) % 1 - nienormalne
testy1 = lillietest(y1) % 0 - normalne

% test lilliefrosta pokazuje ze probka y1 pochodzi z rozkladu norm.
% a x nie. Mozemy to sprawdzic na qq plots

figure;
subplot(1, 2, 1);
qqplot(x);
title('x qq');
hold on;
subplot(1, 2, 2);
qqplot(y1);
title('y1 qq');
hold off;

% qq plots potwierdzaja wczesniejsze testy

% Using the subplot, plot the cdf and pdf estimator of not normal 
% vector (x or y1). Name the distribution

figure;
subplot(1, 2, 1);
[f, xi] = ksdensity(x);
plot(xi, f, 'LineWidth', 1.5)
title('PDF x');
xlabel('Value');
hold on;

subplot(1, 2, 2);
cdfplot(x);
title('CDF x');
xlabel('Value');
hold off;

% Test the correlation between pairs (x,y1), (x,y2) and (x,y3). 
% For each pair test both Pearson and Spearman correlation. 
% For each correlated pair decide whether correlation is positive or 
% negative

pearson_1 = corr(x', y1', "Type", "Pearson")
spearman_1 = corr(x', y1', "Type", "Spearman")

% Pearson_1 = 0.0187 ; Spearman_1 = 0.0249
% X i Y1 są w bardzo małym stopniu pozytywnie skorelowane

pearson_2 = corr(x', y2', "Type", "Pearson")
spearman_2 = corr(x', y2', "Type", "Spearman")

% Pearson_2 = -0.9110 ; Spearman_2 = -0.9685
% X i Y2 są definitywnie negatywnie skorelowane

pearson_3 = corr(x', y3', "Type", "Pearson")
spearman_3 = corr(x', y3', "Type", "Spearman")

% Pearson_3 = 0.8709 ; Spearman_3 = 1
% X i Y3 są definitywnie pozytywnie skorelowane

%% task 1.4 - ADDITIONAL TASK

avgo = readtable("avgo_us_d.csv");
stt = readtable("stt_us_d.csv");

% ceny zamkniecia gieldy w danym czasie 
koniec_avgo = avgo.Zamkniecie;
koniec_stt = stt.Zamkniecie;
% działa

% d a d-1 -> diff()
diff_avgo = diff(koniec_avgo);
cena_avgo = koniec_avgo(1:end-1); 
zwroty_avgo = (diff_avgo ./ cena_avgo) * 100;

diff_stt = diff(koniec_stt);
cena_stt = koniec_stt(1:end-1); 
zwroty_stt = (diff_stt ./ cena_stt) * 100;

% disp() dziala jak print w pythonie z tego co czytam;)
disp('Piec zwrotow z inwestycji dla AVGO (sprawdzam czy dziala)');
disp(zwroty_avgo(1:5));

disp('Piec zwrotow z inwestycji dla STT (sprawdzam czy dziala)');
disp(zwroty_stt(1:5));

% Create a subplot with data visualization. 
% In upper plot you should depict original data for year 2022 
% (ommit the one day from 2021). 
% In lower plot present the percentage return of the index.

daty_avgo = datetime(avgo.Data, 'InputFormat', 'yyyy-MM-dd');
daty_stt = datetime(stt.Data, 'InputFormat', 'yyyy-MM-dd');

daty_avgo_2022 = daty_avgo(2:end);
ceny_avgo_2022 = koniec_avgo(2:end);

daty_stt_2022 = daty_stt(2:end);
ceny_stt_2022 = koniec_stt(2:end);

kwartaly_ticks = datetime({'2022-01-01', '2022-04-01', '2022-07-01', '2022-10-01'});
kwartaly_etykiety = {'Q1 (Jan 1)', 'Q2 (Apr 1)', 'Q3 (Jul 1)', 'Q4 (Oct 1)'};

figure;
subplot(2, 1, 1);
plot(daty_avgo_2022, ceny_avgo_2022, 'b', 'LineWidth', 1.5);
title('AVGO');
ylabel('Price [$]');
xlabel('Date');
xticks(kwartaly_ticks);
xticklabels(kwartaly_etykiety);
hold on;

subplot(2, 1, 2);
plot(daty_avgo_2022, zwroty_avgo, 'r', 'LineWidth', 1.2);
hold on;

title('Zwrot procentowy');
ylabel('[%]');
xlabel('Date');
xticks(kwartaly_ticks);           
xticklabels(kwartaly_etykiety);
hold off;

figure;
subplot(2, 1, 1);
plot(daty_stt_2022, ceny_stt_2022, 'b', 'LineWidth', 1.5);
title('STT');
ylabel('Price [$]');
xlabel('Date');
xticks(kwartaly_ticks);
xticklabels(kwartaly_etykiety);
hold on;

subplot(2, 1, 2);
plot(daty_stt_2022, zwroty_stt, 'r', 'LineWidth', 1.2);
hold on;

title('Zwrot procentowy');
ylabel('[%]');
xlabel('Date');
xticks(kwartaly_ticks);           
xticklabels(kwartaly_etykiety);
hold off;

% Calculate the basic statistic (Mean, Standard Deviation, Median, MAD, 
% Skewness, Interquartile range) of returns and display the results 
% in one table. Remember to name both columns and rows.

mean_avgo   = mean(zwroty_avgo);
std_avgo    = std(zwroty_avgo);
median_avgo = median(zwroty_avgo);
MAD_avgo    = mad(zwroty_avgo);
skewness_avgo   = skewness(zwroty_avgo);
iqr_avgo    = iqr(zwroty_avgo);

mean_stt   = mean(zwroty_stt);
std_stt    = std(zwroty_stt);
median_stt = median(zwroty_stt);
MAD_stt    = mad(zwroty_stt);
skewness_stt   = skewness(zwroty_stt);
iqr_stt    = iqr(zwroty_stt);

tabela_avgo = [mean_avgo; std_avgo; median_avgo; MAD_avgo; skewness_avgo; iqr_avgo];
tabela_stt  = [mean_stt;  std_stt;  median_stt;  MAD_stt;  skewness_stt;  iqr_stt];

nazwawierszy_gielda = {'Mean'; 'Standard Deviation'; 'Median'; 'MAD'; 'Skewness'; 'IQR'};
tabela_gielda = table(tabela_avgo, tabela_stt, 'RowNames', nazwawierszy_gielda);
disp(tabela_gielda)

% Using the T test check whether the mean of the returns is significantly 
% different from 0. Use the 1% significance level of the test.

alfa = 0.01;

[h_avgo, p_avgo] = ttest(zwroty_avgo, 0, 'Alpha', alfa);
disp(['P-value to ', num2str(p_avgo)]);
disp(['Jaka decyzja = ', num2str(h_avgo)]);

% P-value = 0.84375 ; Decyzja = 0

[h_stt, p_stt] = ttest(zwroty_stt, 0, 'Alpha', alfa);
disp(['P-value to ', num2str(p_stt)]);
disp(['Jaka decyzja = ', num2str(h_stt)]);

% P-value = 0.85205 ; Decyzja = 0

% Test the correlation between return of both indices. 
% If they are correlated decide whether the correlation is positive 
% or negative

figure;
scatter(zwroty_avgo, zwroty_stt, 15);
title('Scatter - Zwroty AVGO i STT w pojedynczych punktach w czasie');
xlabel('Zwroty AVGO [%]');
ylabel('Zwroty STT [%]');

pearson_gielda = corr(zwroty_avgo, zwroty_stt, 'Type', 'Pearson');
spearman_gielda = corr(zwroty_avgo, zwroty_stt, 'Type', 'Spearman');

disp(['Pearson Correlation: ', num2str(pearson_gielda)]);
disp(['Spearman Correlation: ', num2str(spearman_gielda)]);

% Pearson = 0.60036 ; Spearman = 0.62908
% Wyniki zwrotów z obu spółek są pozytywnie skorelowane
% W tym samym czasie obie spółki zazwyczaj zyskują

% Wybrałbym korelację Spearmana, ze względu na to że jest odporna
% na outliery, a to jest bardzo ważne na giełdzie, żeby przewidywać
% skutecznie wartości akcji, zwrotów itp.

% Check whether the return of those two indices have the same distribution

[h_ks, p_ks] = kstest2(zwroty_avgo, zwroty_stt);

disp(['P-value to ', num2str(p_ks)]);
disp(['Jaka decyzja = ', num2str(h_ks)]);

% P-value = 0.88109 ; Decyzja = 0

% p-value znacznie przewyzsza przyjety poziom istotnosci, dlatego
% nie ma powodu do odrzucenia hipotezy zerowej zalozonej w zadaniu
% W zwiazku z tym mozna przyjac ze zwroty z obu spółek maja ten sam
% rozkład!

% Choose a suitable normality test and decide are the index returns 
% are normally distributed. Is K-S test suitable in this example? Why?

% literatura i AI podpowiada o zastosowaniu testu Jarque-Bera
% Który jest bardzo dobry do danych finansowych
% Test kolmgorova-smirnova nie jest odpowiednim do zastosowania w tym
% przypadku, ponieważ stosuje się go w przypadku znanych z góry
% parametrów startowych. Tutaj nie ma takiej sytuacji, bo te parametry
% obliczamy na bieżąco w kodzie

[h_jb_avgo, p_jb_avgo] = jbtest(zwroty_avgo);
[h_jb_stt, p_jb_stt]   = jbtest(zwroty_stt);

disp(['P-value AVGO to ', num2str(p_jb_avgo)]);
disp(['P-value STT to ', num2str(p_jb_stt)]);

% P-value AVGO = 0.43707 ; P-value STT = 0.0013374
% W przeciwienstwie do AVGO, P-value spolki STT jest ponizej poziomu
% alfa, dlatego w jej przypadku mozemy odrzucic hipoteze zerowa i przyjac,
% ze rozklad dla tej spolki NIE JEST NORMALNY.

% For the index with higher p-value of the normallity test 
% create another subplot

% robimy to dla AVGO, bo ma wyzsze p-value

mu = mean(zwroty_avgo);
sigma = std(zwroty_avgo);
x_grid = linspace(min(zwroty_avgo) - 2, max(zwroty_avgo) + 2, 1000);
figure('Position', [100, 100, 1000, 400]); 

% lewy
subplot(1, 2, 1);
hold on;
histogram(zwroty_avgo, 'Normalization', 'cdf', 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', 'w');
[f_emp, x_emp] = ecdf(zwroty_avgo);
plot(x_emp, f_emp, 'b-', 'LineWidth', 2);
cdf_analit = normcdf(x_grid, mu, sigma);
plot(x_grid, cdf_analit, 'r--', 'LineWidth', 2);

title('CDF AVGO');
xlabel('Zwrot [%]');
ylabel('CDF');
legend('Histogram (CDF)', 'Empirical CDF', 'Analytical Normal CDF', 'Location', 'best');
grid on;
hold off;


% prawy
subplot(1, 2, 2);
hold on;
histogram(zwroty_avgo, 'Normalization', 'pdf', 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', 'w');
[f_kde, x_kde] = ksdensity(zwroty_avgo);
plot(x_kde, f_kde, 'b-', 'LineWidth', 2);
pdf_analit = normpdf(x_grid, mu, sigma);
plot(x_grid, pdf_analit, 'r--', 'LineWidth', 2);

title('PDF AVGO');
xlabel('Zwrot [%]');
ylabel('PDF');
legend('Histogram (PDF)', 'Kernel Density', 'Analytical Normal PDF', 'Location', 'best');
grid on;
hold off;