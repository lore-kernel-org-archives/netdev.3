Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53F26ED46;
	Sun, 18 Oct 2026 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792293072; cv=none; b=Dw6eKs0CBWsOfHs5QuT/fRgmBNriaz5leoU4vHhrK5L7X+q1dsyXYDx1X39WV3QBVkUk1GZSmYrpgIoOzDohAhWXn6Z+V9OTWxUqz5YwL9z+2wC/8PbbDyDVcrY5OTuVLEAJrD48D5jR3XWD+1DKbwl2cG57vYngu3ZhG1IDSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792293072; c=relaxed/simple;
	bh=c3dMSeY6NkPwVb1KgPnj6xDwxPaqTPAV1JowATUGAPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXMUAyDD8dgf8s5ZnLmhtNrFDj121tjiKyDIQNeDhp758/Wso6ZR8WxL471wc6w8+0ppREXm7toV/cAU/DXnj2QJJRuUEqGzasR8P+uHQX+D8XJvoqFMTDR2MojYY8aUDsSkLkoG3PO4SIhtXBsFFBxCmRHqmvVZfA2ew4arteQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439663|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00751529-0.00102491-0.99146;FP=14571262836432657470|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jicrdg8_1792293055;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jicrdg8_1792293055 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 18 Oct 2026 11:11:05 +0800
Message-ID: <0ce7a944-4a12-47be-a413-4706f8eb8258@motor-comm.com>
Date: Sun, 18 Oct 2026 11:10:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20261013011122.1889766-1-kyle.switch@motor-comm.com>
 <20261013011122.1889766-6-kyle.switch@motor-comm.com>
 <bc293fd1-4414-4d0e-9247-a5a91db90f15@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <bc293fd1-4414-4d0e-9247-a5a91db90f15@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/26 09:51, Andrew Lunn wrote:
>> +++ b/drivers/net/dsa/motorcomm/mdio_bus.c
>> @@ -299,3 +299,42 @@ int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
>>   
>>   	return 0;
>>   }
>> +
>> +/* intif extend register read/write api */
>> +int
>> +yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 val)
>> +{
>> +	int res;
>> +
>> +	if (port > priv->series->max_ports)
>> +		return -ENODEV;
>> +
>> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
>> +	if (res)
>> +		return res;
>> +
>> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE, val);
>> +	if (res)
>> +		return res;
>> +
>> +	return 0;
>> +}
>> +
>> +int
>> +yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
>> +{
>> +	int res;
>> +
>> +	if (port > priv->series->max_ports)
>> +		return -ENODEV;
>> +
>> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
>> +	if (res)
>> +		return res;
>> +
>> +	res = yt921x_intif_read(priv, port, YT92XX_PAGE, valp);
>> +	if (res)
>> +		return res;
>> +
>> +	return 0;
>> +}
> Why are these in mdio_bus? They don't have anything to do with MDIO.
>
> Since they build on yt921x_intif_read they seem to fit in yt921x.c
> better? Or am i missing something?

These two interfaces access the extend registers of the Phy/serdes.

Following the existing code style-where the PHY/SerDes MII registers

were placed in the mdio_bus.c,these two interfaces are also placed

in the mdio_bus.c.

>> +static void yt922x_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>> +				 struct phylink_link_state *state)
>> +{
>> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
>> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
>> +	int port = pp->index;
>> +	int res = 0;
>> +	u16 data;
>> +	int addr;
>> +	u16 lp;
>> +
>> +	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
>> +	if (addr < 0) {
>> +		state->link = false;
>> +		return;
>> +	}
>> +
>> +	mutex_lock(&priv->reg_lock);
>> +	switch (state->interface) {
>> +	case PHY_INTERFACE_MODE_SGMII:
>> +	case PHY_INTERFACE_MODE_1000BASEX:
>> +	case PHY_INTERFACE_MODE_2500BASEX:
>> +		res = yt921x_intif_read(priv, addr, MII_BMSR, &data);
>> +		if (res)
>> +			goto err;
>> +		res = yt921x_intif_read(priv, addr, MII_LPA, &lp);
>> +		if (res)
>> +			goto err;
>> +		phylink_mii_c22_pcs_decode_state(state, neg_mode, data, lp);
>
> Rather than data, call it bmsr. It then fits:
>
> void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
> 				      unsigned int neg_mode, u16 bmsr, u16 lpa)
Okay.
>
>> +static void yt922x_pcs_an_restart(struct phylink_pcs *pcs)
>> +{
>> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
>> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
>> +	struct device *dev = to_device(priv);
>> +	int port = pp->index;
>> +	u16 data;
>> +	int addr;
>> +	int res;
>> +
>> +	mutex_lock(&priv->reg_lock);
>> +	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
>> +	if (addr < 0) {
>> +		res = addr;
>> +		goto err;
>> +	}
>> +	res = yt921x_intif_read(priv, addr, MII_BMCR, &data);
>> +	if (res)
>> +		goto err;
>> +	data |= BMCR_ANRESTART;
>> +	res = yt921x_intif_write(priv, addr, MII_BMCR, data);
> Again, bmcr. It then looks a lot like
> phylink_mii_c22_pcs_an_restart().
Okay.
>> +	if (res)
>> +		goto err;
>> +	mutex_unlock(&priv->reg_lock);
>> +	return;
>> +
>> +err:
>> +	mutex_unlock(&priv->reg_lock);
>> +	if (res)
>> +		dev_err(dev, "Failed to %s PCS port %d: %i\n", "an restart",
>> +			port, res);
>> +}
>> +
>> +static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>> +			     phy_interface_t interface,
>> +			     const unsigned long *advertising,
>> +			     bool permit_pause_to_mac)
>> +{
> advertising does not appear to be used here. Does this pcs not support
> it? That would be odd, because you looked at lpa in earlier functions.

advertising and neg_mode will been handled in next patch version.

>
> 	Andrew
