Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D63C3450;
	Wed, 30 Sep 2026 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804486; cv=none; b=eS87z2CgG8bfRfmD4hsnJgVqRpE8BngpPpiyG8c4s3D2F/HL7fmyuZKQQECMfDKJH/AWB75ZRqc79egnyXb50Ou4TlRptTzxrc+Oee+XeHyk8gCKjZJ2SfzjC9ZjuLRpiCzQsSelsNdaJlzfrrVSJ+Ai0NeyqCswougwBqDW0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804486; c=relaxed/simple;
	bh=Przp1RRJUiv8BWHWcRGZAdMZGLItm6q/TF37U6fsaMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP1j2roGrlFvceXgmE2PYs4jUQAyO9vn0510blKq59X1T2Xg6+h69YoVZLVP5/NwakegVBTBIu7QwR6hYt9vrNnKI7MpbDdE1N8r7piVqMBX0pkIzYpqkaYSUZeuVbGfEdtAGXZyrbR0b39cbck1JKFHx1A4qL8xibjXPPgCaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g5w8pQGr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g5w8pQGr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6CDE04E410DC;
	Wed, 30 Sep 2026 21:41:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2AB6C60749;
	Wed, 30 Sep 2026 21:41:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4954103283B2;
	Wed, 30 Sep 2026 23:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790804478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1M8OyB8j8d3mzm5S3z3TUZEVzDPo4bZj1e56hoXjw/4=;
	b=g5w8pQGrRkfVMlEHUoADxnZ+WIMnb61KciCSvpvSCuJX+12+02Po2iSgYaCApnXUOTZ7Hq
	cX6Zl2Rf2ZR4paghinisarJO1wV22RykRDCwD+jZhawhYPuvM8y81ENsakUfTFLblO6n8y
	YXxodmkyoqgdkx1UoHDd03EN44wbaSCoLDdY7moihoVv4N2xgfabbMdyOHZwkfXJM8cN2n
	ZEsCj0pWo4X4B3fBo2Bq8GajXMJlCoV9rdMJgeKo+rORzDn3n/VO3q0Gw92XoUAk3ucm60
	e8BpZhWPk4UlPHZ1pTbbvLTFIz8LlLuUKIKw8cc32ADtDUbMphvAXBeSVi5Uaw==
Message-ID: <7355f4d7-5f52-49a8-9f81-f9ee722deacb@bootlin.com>
Date: Wed, 30 Sep 2026 23:41:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 3/5] net: stmmac: Rename double VLAN references to
 svlan
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, recv.jo@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, jun.ann.lai@intel.com,
 yi.fang.gan@intel.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260928203441.34876-1-ovidiu.panait.rb@renesas.com>
 <20260928203441.34876-4-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260928203441.34876-4-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/28/26 22:34, Ovidiu Panait wrote:
> The ESVL and DOVLTC bits control S-VLAN tag processing and have
> nothing to do with the double VLAN feature, which only provides a way
> to process an additional inner VLAN tag. However, the driver code
> that handles them always refers to "double VLAN", which is unrelated
> and makes the implementation confusing. The driver does not use any
> of the inner VLAN tag features, and the networking core does not
> support offloads for the inner tag anyway.
> 
> To reduce the confusion regarding S-Tag vs double VLAN handling,
> rename double -> svlan.
> 
> No functional change intended.
> 
> Suggested-by: Joseph Steel <recv.jo@gmail.com>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> v6 changes:
> - Rebased on top of latest net.
> 
> v5 changes: New patch.
> 
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++++++++----------
>  .../stmicro/stmmac/stmmac_selftests.c         | 30 ++++++++--------
>  .../net/ethernet/stmicro/stmmac/stmmac_vlan.c |  8 ++---
>  5 files changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index df2126d71c2f..5e2654c91b41 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -633,7 +633,7 @@ struct stmmac_est_ops {
>  struct stmmac_vlan_ops {
>  	/* VLAN */
>  	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
> -				 bool is_double);
> +				 bool is_svlan);
>  	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
>  	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
>  			   struct sk_buff *skb);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 7582fca63741..d2d387f45c10 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -344,7 +344,7 @@ struct stmmac_priv {
>  	void __iomem *ptpaddr;
>  	void __iomem *estaddr;
>  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
> -	unsigned int num_double_vlans;
> +	unsigned int num_svlans;
>  	int sfty_irq;
>  	struct stmmac_msi *msi;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 14183f92663a..0d70eb452af7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6835,7 +6835,7 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
>  	return crc;
>  }
>  
> -static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
> +static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_svlan)
>  {
>  	u32 crc, hash = 0;
>  	u16 vid = 0;
> @@ -6849,7 +6849,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
>  	if (!netif_running(priv->dev))
>  		return 0;
>  
> -	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_double);
> +	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_svlan);
>  }
>  
>  /* FIXME: This may need RXC to be running, but it may be called with BH
> @@ -6858,8 +6858,8 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
>  static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	unsigned int num_double_vlans;
> -	bool is_double = false;
> +	unsigned int num_svlans;
> +	bool is_svlan = false;
>  	int ret;
>  
>  	ret = pm_runtime_resume_and_get(priv->device);
> @@ -6867,11 +6867,11 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
>  		return ret;
>  
>  	if (be16_to_cpu(proto) == ETH_P_8021AD)
> -		is_double = true;
> +		is_svlan = true;
>  
>  	set_bit(vid, priv->active_vlans);
> -	num_double_vlans = priv->num_double_vlans + is_double;
> -	ret = stmmac_vlan_update(priv, num_double_vlans);
> +	num_svlans = priv->num_svlans + is_svlan;
> +	ret = stmmac_vlan_update(priv, num_svlans);
>  	if (ret) {
>  		clear_bit(vid, priv->active_vlans);
>  		goto err_pm_put;
> @@ -6881,12 +6881,12 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
>  		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
>  		if (ret) {
>  			clear_bit(vid, priv->active_vlans);
> -			stmmac_vlan_update(priv, priv->num_double_vlans);
> +			stmmac_vlan_update(priv, priv->num_svlans);
>  			goto err_pm_put;
>  		}
>  	}
>  
> -	priv->num_double_vlans = num_double_vlans;
> +	priv->num_svlans = num_svlans;
>  
>  err_pm_put:
>  	pm_runtime_put(priv->device);
> @@ -6900,8 +6900,8 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
>  static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	unsigned int num_double_vlans;
> -	bool is_double = false;
> +	unsigned int num_svlans;
> +	bool is_svlan = false;
>  	int ret;
>  
>  	ret = pm_runtime_resume_and_get(priv->device);
> @@ -6909,11 +6909,11 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
>  		return ret;
>  
>  	if (be16_to_cpu(proto) == ETH_P_8021AD)
> -		is_double = true;
> +		is_svlan = true;
>  
>  	clear_bit(vid, priv->active_vlans);
> -	num_double_vlans = priv->num_double_vlans - is_double;
> -	ret = stmmac_vlan_update(priv, num_double_vlans);
> +	num_svlans = priv->num_svlans - is_svlan;
> +	ret = stmmac_vlan_update(priv, num_svlans);
>  	if (ret) {
>  		set_bit(vid, priv->active_vlans);
>  		goto del_vlan_error;
> @@ -6923,12 +6923,12 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
>  		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
>  		if (ret) {
>  			set_bit(vid, priv->active_vlans);
> -			stmmac_vlan_update(priv, priv->num_double_vlans);
> +			stmmac_vlan_update(priv, priv->num_svlans);
>  			goto del_vlan_error;
>  		}
>  	}
>  
> -	priv->num_double_vlans = num_double_vlans;
> +	priv->num_svlans = num_svlans;
>  
>  del_vlan_error:
>  	pm_runtime_put(priv->device);
> @@ -6944,7 +6944,7 @@ static void stmmac_vlan_restore(struct stmmac_priv *priv)
>  	if (priv->hw->num_vlan)
>  		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
>  
> -	stmmac_vlan_update(priv, priv->num_double_vlans);
> +	stmmac_vlan_update(priv, priv->num_svlans);
>  }
>  
>  static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index c25dc9f89270..c485217ba880 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -243,7 +243,7 @@ struct stmmac_test_priv {
>  	int (*func)(struct sk_buff *skb, struct net_device *ndev,
>  		    struct packet_type *pt, struct net_device *orig_ndev);
>  	bool capture_all;
> -	int double_vlan;
> +	int svlan;
>  	int vlan_id;
>  	int ok;
>  };
> @@ -285,7 +285,7 @@ static int stmmac_test_loopback_validate(struct sk_buff *skb,
>  	}
>  
>  	ihdr = ip_hdr(skb);
> -	if (tpriv->double_vlan)
> +	if (tpriv->svlan)
>  		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
>  
>  	if (tpriv->packet->tcp) {
> @@ -936,7 +936,7 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
>  	struct iphdr *ihdr;
>  	u16 proto;
>  
> -	proto = tpriv->double_vlan ? ETH_P_8021AD : ETH_P_8021Q;
> +	proto = tpriv->svlan ? ETH_P_8021AD : ETH_P_8021Q;
>  
>  	skb = skb_unshare(skb, GFP_ATOMIC);
>  	if (!skb)
> @@ -963,7 +963,7 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
>  	}
>  
>  	ihdr = ip_hdr(skb);
> -	if (tpriv->double_vlan)
> +	if (tpriv->svlan)
>  		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
>  	if (ihdr->protocol != IPPROTO_UDP)
>  		goto out;
> @@ -1080,7 +1080,7 @@ static int stmmac_test_vlanfilt_perfect(struct stmmac_priv *priv)
>  	return ret;
>  }
>  
> -static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
> +static int __stmmac_test_svlanfilt(struct stmmac_priv *priv)
>  {
>  	struct stmmac_packet_attrs attr = { };
>  	struct stmmac_test_priv *tpriv;
> @@ -1092,7 +1092,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
>  		return -ENOMEM;
>  
>  	tpriv->ok = false;
> -	tpriv->double_vlan = true;
> +	tpriv->svlan = true;
>  	init_completion(&tpriv->comp);
>  
>  	tpriv->pt.type = htons(ETH_P_8021Q);
> @@ -1155,15 +1155,15 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
>  	return ret;
>  }
>  
> -static int stmmac_test_dvlanfilt(struct stmmac_priv *priv)
> +static int stmmac_test_svlanfilt(struct stmmac_priv *priv)
>  {
>  	if (!priv->dma_cap.vlhash)
>  		return -EOPNOTSUPP;
>  
> -	return __stmmac_test_dvlanfilt(priv);
> +	return __stmmac_test_svlanfilt(priv);
>  }
>  
> -static int stmmac_test_dvlanfilt_perfect(struct stmmac_priv *priv)
> +static int stmmac_test_svlanfilt_perfect(struct stmmac_priv *priv)
>  {
>  	int ret, prev_cap = priv->dma_cap.vlhash;
>  
> @@ -1171,7 +1171,7 @@ static int stmmac_test_dvlanfilt_perfect(struct stmmac_priv *priv)
>  		return -EOPNOTSUPP;
>  
>  	priv->dma_cap.vlhash = 0;
> -	ret = __stmmac_test_dvlanfilt(priv);
> +	ret = __stmmac_test_svlanfilt(priv);
>  	priv->dma_cap.vlhash = prev_cap;
>  
>  	return ret;
> @@ -1372,7 +1372,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
>  	proto = svlan ? ETH_P_8021AD : ETH_P_8021Q;
>  
>  	tpriv->ok = false;
> -	tpriv->double_vlan = svlan;
> +	tpriv->svlan = svlan;
>  	init_completion(&tpriv->comp);
>  
>  	tpriv->pt.type = svlan ? htons(ETH_P_8021Q) : htons(ETH_P_IP);
> @@ -1960,11 +1960,11 @@ static const struct stmmac_test {
>  		.name = "VLAN Filtering (perf)      ",
>  		.fn = stmmac_test_vlanfilt_perfect,
>  	}, {
> -		.name = "Double VLAN Filter         ",
> -		.fn = stmmac_test_dvlanfilt,
> +		.name = "SVLAN Filtering            ",
> +		.fn = stmmac_test_svlanfilt,
>  	}, {
> -		.name = "Double VLAN Filter (perf)  ",
> -		.fn = stmmac_test_dvlanfilt_perfect,
> +		.name = "SVLAN Filtering (perf)     ",
> +		.fn = stmmac_test_svlanfilt_perfect,
>  	}, {
>  		.name = "Flexible RX Parser         ",
>  		.fn = stmmac_test_rxp,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
> index 200b34588c7f..fb9aad748cb3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
> @@ -162,7 +162,7 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
>  }
>  
>  static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
> -			     bool is_double)
> +			     bool is_svlan)
>  {
>  	void __iomem *ioaddr = hw->pcsr;
>  	u32 value;
> @@ -173,7 +173,7 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
>  
>  	if (hash) {
>  		value |= VLAN_VTHM | VLAN_ETV;
> -		if (is_double) {
> +		if (is_svlan) {
>  			value |= VLAN_ESVL;
>  			value |= VLAN_DOVLTC;
>  		} else {
> @@ -235,7 +235,7 @@ static void vlan_set_hw_mode(struct mac_device_info *hw)
>  }
>  
>  static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
> -				      bool is_double)
> +				      bool is_svlan)
>  {
>  	void __iomem *ioaddr = hw->pcsr;
>  
> @@ -251,7 +251,7 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
>  		value = readl(ioaddr + VLAN_TAG);
>  
>  		value |= VLAN_VTHM | VLAN_ETV;
> -		if (is_double) {
> +		if (is_svlan) {
>  			value |= VLAN_ESVL;
>  			value |= VLAN_DOVLTC;
>  		} else {

