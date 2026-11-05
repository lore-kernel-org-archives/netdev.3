Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918868;
	b=mM42AMyteuF9T3iZPofez0P2JSn/WyrxXBtDV2DB7AHFh/T4JqEqvTwj2nMZaAasBWXx
	 jSc4+TuGQrRoZEQgKyHXckBz9KDbkqTqp65mD73Ox/CucshZr8ykKSnlhKr5WVyZ2dkAx
	 ucxY1Gt2J78WG1zy//9TADAHqZlPJwGDyGooKJzfFyYmYo4mOtaDU7sOza64C8WiH5dPX
	 PET26tu0hUvBcVSh1w4OizoNeDiDXKPAvODo7sDze0VN9Z52pvYYFStKouxDOC9kcSdXO
	 RtpzHq1YN1ID2lcbNiIyP9vfcLgEdmFR/2DJH3fWOQjNBgkWuUXDOmuZ6KJEBh/bmYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918868;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FFHWlej+HfzyWeLma4rwcxzLYA1cmN6XfZOTnHYl8RM=;
	b=tZhet5TNEvvpVgoJ+II0nGnb8aTklKNsVPgdEpX7KhEZx1ncbC6w3DjLJv/zNYiMZITp
	 0Oppc2Rh+JZYNE/vymtZaphSGlRxmKlZ72Um0W26LPSyaGK9ddH46iGPg6W1KTW6vA8SZ
	 5K1cEgW4MeVrwCn7olb5qMzMIp/bLvXuvLct4ooERkdz4xV45PzNM/tqkNXjvYYogR6x4
	 unwIVkLZcvLi1jtg4EME+vxugGiuBro67JZBMmS3GB7pG8NxBRpiH3SCIW7QqnkpcvSaI
	 s6CUj2fZb0sltVWXwXTEZVv7BnIrfl96tp+8tp0PqAmlb/OUUMnIwtjVqSCQFKyQFww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=zTAUDSAR;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCB606A31B;
	Thu,  5 Nov 2026 22:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADFCB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=zTAUDSAR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FFHWlej+HfzyWeLma4rwcxzLYA1cmN6XfZOTnHYl8RM=; b=zTAUDSARYr3btC4ZHgGn1mHjlT
	cEVE6q+Nc2TD5QALl1EMaP+i+rgEDEAT0BYENTpRd+22KPA3mkjCisCnQf2Ly04d4omi+gj1mtKjA
	EqFjY2sz6njTbEcMm+ZtiTM5PsDQgZSNytRhSmJC6l3jS2PYVu8HUPsy3RvX0M1DpZNs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xP6Ew-00EeMF-Dt; Thu, 05 Nov 2026 23:47:26 +0100
Date: Thu, 5 Nov 2026 23:47:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 5/6] net: phy: mediatek: add calibration
 logic for AN7581
Message-ID: <028a75a3-b69c-4ae8-8f15-3ef855346a0f@lunn.ch>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-6-ansuelsmth@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103221439.30502-6-ansuelsmth@gmail.com>

> +static int airoha_cal_cycle(struct phy_device *phydev, int devad,
> +			    u32 regnum, u16 mask, u16 cal_val)
> +{
> +	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
> +	struct phy_device *phydev_p0;
> +	int ret;
> +
> +	phydev_p0 = shared->phydev_p0;
> +
> +	phy_modify_mmd(phydev, devad, regnum, mask, cal_val);
> +
> +	ret = mtk_cal_cycle_wait(phydev_p0);


> +static int airoha_rext_cal_sw(struct phy_device *phydev)
> +{

...

> +	phydev_dbg(phydev, "Start REXT SW cal.\n");
> +	first_calib = airoha_cal_cycle(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG5,
> +				       MTK_PHY_RG_REXT_ZCAL_CTRL_MASK, zcal_ctrl);
> +

> +static int airoha_cal_sw(struct phy_device *phydev, enum CAL_ITEM cal_item,
> +			 u8 start_pair, u8 end_pair)
> +{
> +	u8 pair_n;
> +	int ret;
> +
> +	for (pair_n = start_pair; pair_n <= end_pair; pair_n++) {
> +		switch (cal_item) {
> +		case REXT:
> +			ret = airoha_rext_cal_sw(phydev);
> +			break;

> +static int airoha_start_cal(struct phy_device *phydev, enum CAL_ITEM cal_item,
> +			    enum CAL_MODE cal_mode, u8 start_pair,
> +			    u8 end_pair, u32 *buf)
> +{
> +	int ret;
> +
> +	switch (cal_mode) {
> +	case SW_M:
> +		ret = airoha_cal_sw(phydev, cal_item, start_pair, end_pair);


> +static int airoha_phy_calib(struct phy_device *phydev)
> +{
> +	phy_package_lock(phydev);
> +	if (!shared->rext_sw_calib_done) {
> +		ret = airoha_start_cal(phydev, REXT, SW_M, NO_PAIR, NO_PAIR, NULL);
> +		if (ret) {
> +			phy_package_unlock(phydev);
> +			return ret;
> +		}
> +
> +		shared->rext_sw_calib_done = true;
> +	}
> +	phy_package_unlock(phydev);
> +
> +	ret = airoha_start_cal(phydev, TX_R50, SW_M, PAIR_A, PAIR_D, NULL);


> +static int an7581_phy_config_init(struct phy_device *phydev)
> +{
> +	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
> +	struct phy_device *phydev_p0;
> +	u8 phy_offset;
> +	int oldpage;
> +	int ret;
> +
> +	phydev_p0 = shared->phydev_p0;
> +	phy_offset = phydev->mdio.addr - phydev_p0->mdio.addr;
> +
> +	if (phy_package_init_once(phydev)) {
> +		ret = an7581_phy_package_config_init_once(phydev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = airoha_phy_calib(phydev);

> @@ -88,6 +1610,7 @@ static struct phy_driver mtk_socphy_driver[] = {
>  	{
>  		PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7581),
>  		.name		= "Airoha AN7581 PHY",
> +		.config_init	= an7581_phy_config_init,

> > There are 4 phys in total, only the phy with mdio address 9 has the
> > calibration capability. Thus only one phy at the time can perform
> > the calibration sequence.

config_init -> airoha_phy_calib -> airoha_start_cal -> airoha_cal_sw
-> airoha_cal_cycle

I cannot say i looked at all the details closely, maybe i missed an ==
9 somewhere, but to me, it looks like two config_init can run in
parallel.

	Andrew
