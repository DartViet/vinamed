import { useTranslation } from 'react-i18next';
import { useState } from 'react';
import './language-switcher.css';

function LanguageSwitcher() {
  const { i18n } = useTranslation();
  const [activeLang, setActiveLang] = useState(i18n.language);

  const handleLanguageChange = (event: React.MouseEvent<HTMLButtonElement>) => {
    const lang = event.currentTarget.value;
    i18n.changeLanguage(lang);
    setActiveLang(lang);
  };

  return (
    <div>
      <button
        className={`language-switcher-btn${activeLang === 'en' ? ' active' : ''}`}
        value="en"
        onClick={handleLanguageChange}
      >
        English
      </button>
      <button
        className={`language-switcher-btn${activeLang === 'vi' ? ' active' : ''}`}
        value="vi"
        onClick={handleLanguageChange}
      >
        Tiếng Việt
      </button>
    </div>
  );
}

export default LanguageSwitcher;