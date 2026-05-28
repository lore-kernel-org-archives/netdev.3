Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99A3F888F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987408; cv=none; b=NcyOe9TXkwUzFQL3Y0EceZ4EyM0ajYWx7WO8XbLG+4CcUGTNnK8tLm+NaIcgg70mhqc5PAaAybj4TAoLPJ4LR2lamggvDzqG5Eg2ZrN9pCrUWYF8ArsxDRGrNSJGhURzSnxGq7S8p4WpUAkX1iWzr2YOUTX0zRGnVBnj28dgc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987408; c=relaxed/simple;
	bh=6yK9PVlDDIgDMQmLycFl727fzcLZwKatMCdJoI8J+rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFyaXBVje7CeVZkuVKIFkMOYW9VAj36u0flOWb17LCZf302QRdQPqx4ggROq3p9HQ8A68f1APA+l6Wn9Oh/5AtfLVtzYWJKmGpvxAVK6/bPX1kvDfu3ZWsNqJUybXgLfDRzxxD1Qr9xEs0pBElUmNyUpeWOty9v+zS3oBbc/vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=CxpEG8EX; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="CxpEG8EX"
Received: (wp-smtpd smtp.wp.pl 6164 invoked from network); 28 May 2026 18:56:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1779987397; bh=9phiFk1N9gGgTXvASxDCHCEuz3hDvkxQEeUhFOLcPsU=;
          h=Subject:To:Cc:From;
          b=CxpEG8EXVjrQzZNb9wHxMRV7L9+DbWeVMbEBL8FcUSm05QpzBbNNXk4eUCevo55RE
           NDGOdRVurFMG9S4tvgts0Y3GkJ6oQkwC0t9kIVFQT82QQRy28+P0GZIqD31FxPvBhC
           mQyygTHD+YOLqBKKNAl+QFxvvm3dTaiFCqelVLKWT49ld6JfDEEfv+0GEd2XqI1L9K
           DKhfvnSR7mTqhJPWrLQ8sg+92W2vUM9JZJ9FJhOM+QLd1PGcjhw89t85sr37IYS4Ea
           VzZMr+EBLlHHijV/KjA8vtaZPib+VLv15ZZWu3iZ+MLvG3AxpWOWsivL6vRuQ/vz5B
           0Fh+Jw9Ehr95Q==
Received: from 83.24.39.212.ipv4.supernova.orange.pl (HELO [192.168.3.246]) (olek2@wp.pl@[83.24.39.212])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <javen_xu@realsil.com.cn>; 28 May 2026 18:56:37 +0200
Message-ID: <17fd1f36-2f98-4c79-8b67-e407de599350@wp.pl>
Date: Thu, 28 May 2026 18:56:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
To: javen <javen_xu@realsil.com.cn>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, vladimir.oltean@nxp.com
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-2-javen_xu@realsil.com.cn>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260528075226.1054-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: c2214496b0e7c23dc4088acaf9e7d537
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [QeMM]                               

Hi Javen,

On 28/05/2026 09:52, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
>
> This patch adds support for Realtek phy chip RTL8261. Its PHY id is
> 0x001cc898 and 0x001cc899.
>
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>   drivers/net/phy/realtek/realtek_main.c | 315 +++++++++++++++++++++++++
>   1 file changed, 315 insertions(+)
>
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 27268811f564..fe743fd0421b 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> +static int rtl8261x_config_aneg(struct phy_device *phydev)
> +{
> +	u16 adv_1g = 0;
> +	int ret;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return genphy_c45_pma_setup_forced(phydev);
> +
> +	ret = rtl8261x_config_master_slave(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_c45_config_aneg(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			      phydev->advertising))
> +		adv_1g = BIT(9);

		adv_1g = ADVERTISE_1000FULL;

> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
> +				     RTL8261X_GBCR_REG,
> +				     BIT(9), adv_1g);

This is the C22 register mapped in VEND2 page. You can replace it with:

	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
				     RTL822X_VND2_C22_REG(MII_CTRL1000 ),
				     ADVERTISE_1000FULL, adv_1g);


Best regards,
Aleksander

