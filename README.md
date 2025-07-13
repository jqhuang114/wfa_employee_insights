# Table of Contents

* [Project Background](#project-background)
* [Data Structure & Initial Checks](#data-structure--initial-checks)
* [Executive Summary](#executive-summary)
* [Insights Deep Dive](#insights-deep-dive)
* [Recommendations &  Next  Steps](#recommendations--next-steps)
* [Assumptions & Caveats](#assumptions--caveats)
* [Tools Used](#tools-used)

# Project Background

In 2024, a mid-sized US-based technology company transitioned to a work-from-anywhere model to attract more diverse and skilled talent. While the shift initially increased job satisfaction and attracted more talent to the company, leadership has observed a concerning trend in recent quarters where employee turnover has spiked, especially among experienced staff.

The Human Resources (HR) team has reached out to the Data team to investigate patterns in employee compensation, job satisfaction, and career growth opportunities that may be contributing to the rising trend. They suspect that inconsistencies in pay, promotion timelines, and job flexibility might be leading to disengagement.

The HR team provided a curated dataset of anonymized employee records and asked the Data team to perform an analysis on job satisfaction, compensation, and promotion trends to support talent retention initiatives.

The inspected and cleaned data for this analysis can be found here.

Targeted SQL queries regarding various business questions can be found here.

An interactive Tableau dashboard used to report and summarize trends can be found here.

[Back to Top](#table-of-contents)

# Data Structure & Initial Checks

The dataset contains 500 anonymized records of employees from a range of industries, roles, and geographies. Each row represents an individual employee, with the following details:

| Column Name | Description |
|-------------|-------------|
| company | Employer name |
| job_title | Employee's role |
| industry | Sector based on employee's role or function |
| location | City and/or country of job or the headquarters |
| employment_type	| Full-time, Part-time, Contract or Internship |
|	experience_level | Entry, Mid, Senior, or Lead |
| remote_flexibility| Remote, Hybrid, or Onsite |
| annual_salary | Annual gross salary before tax |
| currency | Currency in which the salary is paid |
| years_of_experience | Total years of professional experience the employee had |
| job_satisfaction | Self-reported using scale from 1 to 10 |
| tech_skills | List of technologies used in role |
| perks | Non-monetary benefits provided |
| years_since_last_promotion | Number of years since employee's last promotion |

The dataset was checked for any nulls, duplicates, and blanks. The columns were renamed using snake case to improve code readability and consistency.

[Back to Top](#table-of-contents)

# Executive Summary

### Overview of Findings

Employees still prefer to work remotely, but they are more open to being onsite than we previously assumed. Faster promotions or higher salaries did not consistently increase job satisfaction, but employees did value perks, specifically stock options, gym memberships and flexible work hours. Every industry, except for technology, did not show a consistent increase in salary as experience increased, which may indicate less competitive industries and lower risk of job switching after a certain number of years of experience.

[Back to Top](#table-of-contents)

# Insights Deep Dive
### Job Satisfaction and Retention:

* Remote work is still the most favored job arrangement, providing the most job satisfaction with an average score of  5.82. Interestingly, an onsite work arrangement scored very similarly at 5.79, suggesting that employees may not be opposed to onsite arrangements as previously assumed - though the difference is minimal.
  
* Employees valued stock options, gym memberships, and flexible work hours the most. Stock options had an average job satisfaction score of 5.96 while gym memberships received an average job satisfaction score of 5.92. Flexible hours were also associated with higher job satisfaction, averaging a score of 5.72. The data also shows health insurance as the lowest ranked perk to increase job satisfaction, with a score of 5.4. This does not necessarily mean that employees don't value health insurance. Instead, employees might have viewed it as a benefit and not necessarily a perk.
  
* The data doesn't support a strong trend that faster promotion cycles might increase job satisfaction.  In fact, employees with the highest job satisfaction score of 10 were promoted on average in 2.56 years, but employees with a job satisfaction score of 3 or 6 were promoted on average in 2.1 years. This suggests that promotion timing alone is not a reliable indicator of job satisfaction and other factors may provide a stronger trend.

* A higher salary does not necessarily mean higher job satisfaction but more data is recommended to make a more accurate conclusion. For each experience level, the highest median or average salary never received a perfect job satisfaction score of 10. In fact, some of the lower paid employees for their experience level, still ranked their job satisfaction to be greater than 7. However, as previously noted and indicated in the dashboard, the sample size for USD salaries is relatively small — making up only about 16% of the total dataset — so it is recommended that more data for USD salaries are provided to draw better conclusions.

<img width="3276" height="1536" alt="Job Satisfaction" src="https://github.com/user-attachments/assets/1392d1b2-4151-4f01-a176-299abfacf6b0" />

### Salary Benchmarking:

* The technology industry is the highest paid across all years of experience. It is also the only industry where salaries increase consistently as experience increases. This could indicate more frequent job switching or competitive compensation strategies that reward experience. In other industries, the highest earners tend to have mid-level experience (i.e. 6 - 12 years), with less consistent increases after 12 years. This may suggest that longer-tenured employees may be more likely to stay, even if salary growth plateaus. However, further analysis and turnover data would be needed to confirm.

* The highest paid skills are Tableau and R. This suggests that these skills are currently the highest in demand and could indicate employees who may receive better offers from other firms, increasing their chances of leaving the firm.

<img width="3276" height="1536" alt="Salary Benchmarking" src="https://github.com/user-attachments/assets/7ecc6bdc-a008-4729-8532-7d0526c4733a" />

[Back to Top](#table-of-contents)

# Recommendations & Next Steps

Based on the insights and findings above, we would recommend the HR team to consider the following: 

* **Work Arrangement Flexibility:** Remote work still creates the highest job satisfaction but employees are open to being onsite. Consider requiring employees to come in once or twice a week to get more in-person interactions with their team and colleagues. We would recommend allowing each team to select their own days and specific hours they should be in the office so that employees can be more satisfied with flexible working hours.

* **Perks & Benefits Strategy:** Assess the current perks the company offers and compare them to our competitors. If our competitors are offering any perks that we don't offer or if gym memberships aren't included in our perks, we recommend doing a cost analysis and consider offering them to increase job satisfaction and retention while remaining competitive in the market.

* **Salary & Promotion Review:** There were no strong trends with higher salary or faster promotion cycles increasing job satisfaction. However, we would recommend doing a salary analysis to ensure our employees are being paid competitive market rates and trying to keep the promotion cycles between 2 - 3 years to retain our talent.
  
* **Further Analysis:** Gathering more USD salary data to do a more detailed analysis and additional data to see if there are other factors such as work-life balance or team culture that may have a better correlation with job satisfaction.

[Back to Top](#table-of-contents)

# Assumptions & Caveats

Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

* Data is based on a sample of ~450 respondents. Please use caution when interpreting categories with small sample sizes (n < 10).

* Due to inconsistent use of 'remote' in both remote flexibility and location fields, entries with 'remote' in the location field were excluded unless the remote flexibility field was also 'remote'. This assumption may undercount some hybrid or onsite roles.

* As to not skew results of the salary analysis, it was done using only USD salary data. We opted to not convert non-USD salaries to USD as generally, salaries take other factors into consideration like the cost of living. This assumption may result in small sample sizes for certain factors. We recommend using caution when interpreting categories with small sample sizes and increasing the sample size of USD salary data for more accurate results.

[Back to Top](#table-of-contents)

# Tools Used

* **Excel:** data cleaning and exploration

* **SQL:** data querying and aggregation

* **Tableau:** dashboard design and visualization

[Back to Top](#table-of-contents)
