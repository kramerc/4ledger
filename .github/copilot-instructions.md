# Copilot Instructions for Honeyledger

## Project Overview
Honeyledger is a personal finance management application built with Ruby on Rails 8.1.2. It integrates with the SimpleFin API to automatically sync financial transactions from banks and other financial institutions.

## Core Technologies
- **Framework**: Ruby on Rails 8.1.2
- **Database**: PostgreSQL
- **Authentication**: Devise (~> 5.0.0.rc)
- **Frontend**: Hotwire (Turbo Rails + Stimulus)
- **Asset Pipeline**: Propshaft
- **Deployment**: Kamal (Docker-based deployment)
- **Testing**: Minitest with Capybara for system tests
- **Code Quality**: RuboCop with Rails Omakase styling

## Coding Standards

### Ruby Style Guide
- Follow the **Rails Omakase** style guide (configured via `.rubocop.yml`)
- Use RuboCop for linting: `bin/rubocop`
- Auto-fix style issues when possible: `bin/rubocop -a`
- All code must pass RuboCop checks before committing

### Rails Conventions
- Use Rails conventions for file structure and naming
- Models go in `app/models/`
- Controllers go in `app/controllers/`
- Views follow the `app/views/[controller]/[action].html.erb` pattern
- Use concerns for shared behavior (`app/models/concerns/`)
- Follow RESTful routing conventions

### Database
- Use PostgreSQL-specific features when beneficial
- Write database migrations carefully - they must be reversible
- Include appropriate indexes for foreign keys and frequently queried columns
- Use Active Record validations and associations

## Testing Practices

### Test Framework
- Use **Minitest** (not RSpec)
- All new features must include tests
- Test files go in `test/` directory matching the source structure:
  - `test/models/` for model tests
  - `test/controllers/` for controller tests
  - `test/system/` for system/integration tests
  - `test/helpers/` for helper tests

### Running Tests
- Run all tests: `bin/rails test`
- Run specific test file: `bin/rails test test/models/user_test.rb`
- Run system tests: `bin/rails test:system`

### Coverage
- Code coverage is tracked with SimpleCov
- Coverage reports are uploaded to Codecov
- Aim to maintain or improve coverage with new code

### Test Structure
- Use Minitest's default `test "description" do ... end` syntax
- Use fixtures for test data when appropriate
- Use `minitest-mock` for mocking external dependencies

## Security Practices

### Security Tools
- **Brakeman**: Static analysis for security vulnerabilities
- **Bundler Audit**: Audits gems for known security defects
- Run security checks before committing: `bin/brakeman` and `bundle audit`

### Security Guidelines
- Never commit secrets, API keys, or credentials
- Use Rails credentials/secrets management for sensitive data
- Validate and sanitize all user inputs
- Use strong parameters in controllers
- Follow OWASP guidelines for web security

## SimpleFin API Integration

### Models
- `SimplefinConnection`: Stores user's SimpleFin API connection details
- `SimplefinAccount`: Represents a financial account from SimpleFin
- `SimplefinTransaction`: Represents transactions imported from SimpleFin

### Integration Patterns
- Use HTTParty for API requests to SimpleFin
- Handle API errors gracefully with proper error messages
- Respect API rate limits
- Store minimal sensitive data; use tokens appropriately

## Authentication & Authorization

### Devise
- User authentication is handled by Devise
- User model is in `app/models/user.rb`
- Customize Devise views in `app/views/devise/`
- Use `before_action :authenticate_user!` in controllers requiring authentication

### Authorization
- Ensure users can only access their own data
- Filter queries by `current_user` in controllers
- Use scopes in models to restrict data access

## Frontend Development

### Hotwire (Turbo + Stimulus)
- Use Turbo Frames for partial page updates
- Use Turbo Streams for real-time updates
- Keep JavaScript minimal with Stimulus controllers
- Stimulus controllers go in `app/javascript/controllers/`

### Assets
- CSS and JavaScript are managed via Propshaft
- Use import maps for JavaScript dependencies
- Keep assets organized in `app/assets/`

## Development Workflow

### Setup
- Prerequisites: Ruby (see `.ruby-version`), PostgreSQL
- Bootstrap: `bin/setup`
- Database: `bin/rails db:create db:migrate`
- Start server: `bin/dev`

### Code Quality Checks
Always run before committing:
1. `bin/rubocop` - Code style
2. `bin/rails test` - All tests
3. `bin/brakeman` - Security scan
4. `bundle audit` - Dependency vulnerabilities

### Deployment
- Application is deployed using Kamal
- Configuration in `.kamal/` directory
- Docker configuration in `Dockerfile`
- Deploy with: `kamal deploy`

## Models & Domain

### Core Models
- **User**: Application users (Devise)
- **Account**: User's financial accounts (manual or synced)
- **Transaction**: Financial transactions
- **Category**: Transaction categories
- **Currency**: Supported currencies
- **SimplefinConnection**: SimpleFin API connections
- **SimplefinAccount**: Synced SimpleFin accounts
- **SimplefinTransaction**: Synced SimpleFin transactions

### Associations
- Users have many accounts, transactions, and connections
- Accounts have many transactions
- Transactions belong to accounts and categories

## Pull Request Guidelines

### Before Creating PR
- All tests pass
- RuboCop checks pass
- Security scans (Brakeman, Bundler Audit) pass
- Code coverage maintained or improved
- Commit messages are clear and descriptive

### PR Requirements
- Clear description of changes
- Reference related issues
- Include screenshots for UI changes
- Update documentation if needed

## Common Tasks

### Adding a New Model
1. Generate: `bin/rails generate model ModelName`
2. Update migration as needed
3. Add validations and associations to model
4. Write model tests
5. Run migration: `bin/rails db:migrate`

### Adding a New Controller
1. Generate: `bin/rails generate controller ControllerName`
2. Define actions following RESTful conventions
3. Add authorization checks
4. Create corresponding views
5. Write controller tests

### Adding Dependencies
- Add gem to `Gemfile`
- Run `bundle install`
- Run `bundle audit` to check for vulnerabilities
- Document usage in this file if significant

## Troubleshooting

### Common Issues
- **Database errors**: Ensure PostgreSQL is running, try `bin/rails db:reset`
- **Asset issues**: Clear cache with `bin/rails assets:clobber`
- **Test failures**: Check fixtures and test database state

## Resources
- [Rails Guides](https://guides.rubyonrails.org/)
- [Rails Omakase Style Guide](https://github.com/rails/rubocop-rails-omakase/)
- [Devise Documentation](https://github.com/heartcombo/devise)
- [Hotwire Documentation](https://hotwired.dev/)
- [Kamal Documentation](https://kamal-deploy.org/)
