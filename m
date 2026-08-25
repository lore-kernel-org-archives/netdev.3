Received: from out198-22.us.a.mail.aliyun.com (out198-22.us.a.mail.aliyun.com [47.90.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE541377EC6;
	Tue, 25 Aug 2026 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638512; cv=none; b=Ww5njllrFTucxk+K9tq8bQoGIUpCFZVciGmWtBgDIwVnoSumbIx9CemTPpKY9l22i6Lr+SE67DDR4O3a3eoG54KQ0lj61ryFk9QBXUWMjGzzo3VeRoIl8gmlj56UuGewuW0YSXySEVWCnf03vMVb5PF/e/eSo2cRYUS4IG9Ng6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638512; c=relaxed/simple;
	bh=iJQWDSBF+rOsnO+1lqeBE04DjIHpmEqaDT1h5sc4FTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPd6fUr8FX1yoZcZA79Lo3OirNj4qGCspkJxjTuYW2gA2TU5jSOXTiY9yzCUhTjWzaU3Se2QLh9lwqI9/3JQDz6KLCpz0jREZtwTdbME63+WAUmFOl/hnbudawQUMrLLMYwALNU2cFv425alNCX6e55jDmbiee8dUlz47wIZ6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07438824|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0288566-0.000202217-0.970941;FP=14618550908345816610|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iwhZPHN_1787638489;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iwhZPHN_1787638489 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 25 Aug 2026 14:14:52 +0800
Message-ID: <3e87da63-420b-4582-956c-2ecd853b0619@motor-comm.com>
Date: Tue, 25 Aug 2026 14:14:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2] net:dsa:yt922x: Add support for Motorcomm
 YT922x
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20260820080542.2017118-1-kyle.switch@motor-comm.com>
 <10c23416-dce1-4ec6-91bd-3e9eda9b18a3@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <10c23416-dce1-4ec6-91bd-3e9eda9b18a3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/20/26 22:47, Andrew Lunn wrote:
>>   drivers/net/dsa/Kconfig  |   7 +-
>>   drivers/net/dsa/Makefile |   2 +-
>>   drivers/net/dsa/yt921x.c | 819 ++++++++++++++++++++++++++++++++++++++-
> That is a lot of new code. Please try to break it up into a number of
> smaller patches, with good commit messages, which are obviously
> correct.
>
> Since this is a new device, it does not need to work with a big
> bang. You can slowly add the needed bits, such that when the last
> patch is merged the device is functional.

Ans: I have now split the original patch into two separate patches

        — one for the tag and the other for the YT922x DSA switch.

>> +#define YT922X_INTERNAL_SDS1_PHYADDR 0
>> +#define YT922X_INTERNAL_UTP0_PHYADDR 4
>> +#define YT922X_INTERNAL_UTP1_PHYADDR 5
>> +#define YT922X_INTERNAL_UTP2_PHYADDR 6
>> +#define YT922X_INTERNAL_UTP3_PHYADDR 7
>> +#define YT922X_INTERNAL_SDS0_PHYADDR 8
> These don't seem to be used. Generally, a MAC driver does not need to
> know the mapping to PHY addresses, the phandles in the DT indicates
> it.
Ans: fix done in v3 to remove the unnecessary macros.
>>   static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
>>   {
>>   	struct yt921x_priv *priv = mbus->priv;
>> +	int max_ports;
>>   	u16 val;
>>   	int res;
>>   
>> -	if (port >= YT921X_PORT_NUM)
>> +	max_ports = priv->series_info->ports;
>> +	if (port >= max_ports)
> This sort of code change would make a nice simple patch. Change all
> current instances of YT921X_PORT_NUM to priv->series_info->ports. Easy
> to review.
>
>> @@ -4748,6 +4766,13 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>>   	struct device_node *child;
>>   	int res;
>>   
>> +	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
>> +		struct yt921x_port *pp = &priv->ports[i];
>> +
>> +		pp->index = i;
>> +		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
>> +	}
> This should be a patch, with an explanation why it is needed. Also
> please take a look at ethtool -c stats-block-usecs, which indicates
> how out of date the statistics are. It is currently not well
> supported, i only learned of it recently, but setting it will help you
> get the self tests passing.

Ans: The initialization logic was already there. I've moved it from probe()

         to yt921x_dsa_setup() because the YT922x doesn't support MIB stats

         in this series, and the MIB support between the two chips is 
different.

>> +static void
>> +yt922x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
>> +			     phy_interface_t interface)
>> +{
>> +	struct dsa_port *dp = dsa_phylink_to_port(config);
>> +	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
>> +	int port = dp->index;
>> +	int res;
>> +
>> +	mutex_lock(&priv->reg_lock);
>> +	res = yt922x_port_down(priv, port);
>> +	mutex_unlock(&priv->reg_lock);
>> +
>> +	if (res)
>> +		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring down",
>> +			port, res);
>> +}
> This appears to be a cut/paste of
> yt921x_phylink_mac_link_down(). Don't do that. Refactor existing
> functions to make them generic.
>
>> +static int yt922x_port_sds_init(struct yt921x_priv *priv, int port,
>> +				phy_interface_t interface)
>> +{
>> +	int addr;
>> +	u16 data;
>> +	int res;
>> +
>> +	addr = yt922x_sds_phyaddr_get(port,
>> +				      YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
>> +				      YT922X_PHY_REG_SPACE_SGMII);
>> +	if (addr < 0)
>> +		return -EINVAL;
>> +	/* write protect */
>> +	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
>> +	if (res)
>> +		return res;
>> +	/* CDR */
>> +	if (interface == PHY_INTERFACE_MODE_100BASEX) {
>> +		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x0);
>> +		if (res)
>> +			return res;
>> +		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x3458);
>> +		if (res)
>> +			return res;
>> +	} else {
>> +		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x800);
>> +		if (res)
>> +			return res;
>> +		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x4558);
>> +		if (res)
>> +			return res;
>> +	}
>> +	/* PLL */
>> +	if (interface == PHY_INTERFACE_MODE_USXGMII) {
>> +		res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x1006);
>> +		if (res)
>> +			return res;
>> +		res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3029);
>> +		if (res)
> What is this function doing?
Ans: Complete some init configuration according to serdes interface mode.
>
>      Andrew
>
> ---
> pw-bot: cr
