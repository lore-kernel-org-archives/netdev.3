Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCD3E49E6;
	Thu, 23 Jul 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838264; cv=none; b=kCsI/mUe87Yf6KJe5yOQ2C1WYE6nCMlV2QaDdyOBdSsil79HhCRXAN9Wa+phbWvEObgREMkqmqGSNDbfT7cZndAwCngkaCvgXIHpd3e6P0YlQ4wUl/IjW/u6Tl798iBfI3jzdUsNXBHOmkz5sttC1cKcSGcLnnd+DdOUAp3D3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838264; c=relaxed/simple;
	bh=g2neCyLoLFNVrcLtSsHWhdIyxaxfjyUesBtMnhvXhuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpjuRo763YqiIkdlMwoJaKI8IIN1w45gQ2qgmnZVZSJYTm/+PSwaRO7nJJlt+JKELNoT+7bwKwh3Pwq1zyAydPjIXJ2vS8CmDMpXjF+pNeDLX/YpWddkB2HuM4tcMPFo+/q8IldiIucC4cPAMF5P+JfQzawVqQyCg/3eEjbRWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=vdPj8v66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5B6/Eqi; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="vdPj8v66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5B6/Eqi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB9897A0220;
	Thu, 23 Jul 2026 16:24:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 16:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784838260;
	 x=1784924660; bh=6aFnQXEm9TrsdDTj1E/xgPwhwGan4/+djoVhNQoCfeE=; b=
	vdPj8v66IarCaLm0M5cXK9WpWEpg4H9SFCrUYzdZmfm50UEw58NqGV0k5JJRHNeN
	c0xuspmiimWHO0XysN7+4iq8pBT06mwfbGbPoBiy2ks1j/0OMVzuodx8IbDfZz5R
	zSIU8vjsHTck+KL0EuHSvQ2M0P3pyC3rvmP0ysvvd/4/jzRuOs1UcU6c7z5vNjC5
	RtAKUkjF1cef02+XVtf8fVULBmizxW10TYQK+hxXp33/PC8iUCvvTy0vfId0YsaD
	IN2FjnOvoVmx7WyPSAwT8bzMfXd65QmR8rVbDrEGxZLK0o0jELIByHZvXQngIci7
	88wNZzARpYPZnie4K6C6PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784838260; x=
	1784924660; bh=6aFnQXEm9TrsdDTj1E/xgPwhwGan4/+djoVhNQoCfeE=; b=O
	5B6/Eqi8AK1cSOlaVkxefKvXX00HWpBp2wGXXn+rtn35KsD50zK684s8IeWcXnZY
	wcQdQxdBz0kc8cN/9Mh1Je8NBoqybhJkuNXX6N1jNtvGK1NlitD+QiioQWg7mZju
	8D5gFBvqbv7UJN9eqZvF10ms5OTFNc0RxbhkYlD3K0mVtcOC1lRYXW+DAXbRJwgi
	HbeBWR8tz42oqcG/mA5qtHNkmYOZvDpCl0uD7kMH9Cg+VZc31cQr3Zzk4RYLnNV9
	p3EzjuIq74MYRWKnaNaIyoJMP3w69fyGLENx5kawdQGttkcU+76dzb2gF2kVnqfs
	I9vojI4xXmqKoMPG7/FAA==
X-ME-Sender: <xms:c3hiam342YGxZhdWLPJ7zpUVuDFw5YtVxXXYwbDKyaG8XkMpVOyRLQ>
    <xme:c3hiagJL2GmU-8-BwhNiiibVfyhMseOhwbj5_3MwZ17cM6QkFxWT1SaOKJwrd2P3q
    Q8GcHovkF5J05NQCoPDp30OAzy0ybeXnz9nfM7-7s-LgyZPlUo>
X-ME-Received: <xmr:c3hiamndHVBET1X4u6SyitEjOwSnGiep7FvBF86jdKeFmFdAi4lR49e8L26hYK9pAswSYkJSpTVQQbSrQhfrK0rR6BF1cnI>
X-ME-Proxy-Cause: dmFkZTGGMEev6dKv4UlCPj6XliuA/xQS1IWIXC6IlxAZ+QnJEaoji/7RoCIeC01ofKpxth
    ohf8Nv+dO5poKFdV4crp0Gr2/tqJtucOlqVWHiFd1a8QjMJVqrlokVXUXIpmig454d2Qo+
    vvmBOz7L7O/QeaMgWDD4JIZ9UyejEPJ4apV7ZEqnQm4E9HSPXbH9Jklc/2Gi6tGLIgQ8CB
    zZG/Zuh2+YzEnhTnumOd//3hHX8puHAQmVpt1mz7x9Lwss76ekv4bgs6plE3vK4w4Z3IEp
    /vM/EESSO7PBegwXKhXAYhh+idjD834+4Q4Ab70bRPVknovFAQYIEudIMzFB5gR3Fzn0PB
    OXSSSutlBs2XxKk8nwGhMF0wZgJXHTe3TCVv7jFXNd5sflKc5ghq5UWFndPYWbcmnqypjf
    oPRKnVgJKqLYzs0g0wH3iTejoLyZ/9GYJlyxLhmhVdbijsXh5C1pYfrX8So+OKUE24W2AS
    DYoJKhIhN3i1TvvjG0uff/YI3iMfh8/TSrjSASgrCBz2I6wukQ8HQ6VesoRdgrfJ4cCD9B
    FX4xFbGHsGX1JIPxJ0aZKPEd/KHAxX9FXNY4d3JoR+fv19acR6gRTPIzFLMtn+rjuDldjB
    sn+f5iuWDcq8NUmTTxQMYI6J1WMLsWtexP0oMDtr/v5gYUlXTV8/TUwohnLw
X-ME-Proxy: <xmx:c3hiauNPfuY0oppbemzAp3CORNwZMGXN3N1U0lDNPl01Z-2sX6PCTg>
    <xmx:c3hialwDjJ1lb9PpOt07VeBUnrYcXykGjKuHLsPtKihqh9wxE4dEiA>
    <xmx:c3hiamnHQ175QGVLQOmcKLn_fmx3lMrUDzZSIiXPa4GfxjfEifIPpg>
    <xmx:c3hiaj9C_4WYsev1fBgHUeC6Wi3TnmwHAipTXhExdFmwHYYKn2cfSQ>
    <xmx:dHhials9WoqpaRiRD7Qay-2oaZx60AJnFVa3cGsRbRp0Y5Mo6NVaqp8->
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 16:24:19 -0400 (EDT)
Date: Thu, 23 Jul 2026 22:24:16 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	Shahed Shaikh <shshaikh@marvell.com>,
	Sabrina Dubroca <sd@queasysnail.net>, cocci@inria.fr,
	GR-Linux-NIC-Dev@marvell.com, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 07/36] net: ethernet: remove conditional return with no
 effect
Message-ID: <20260723202416.GD2273555@ragnatech.se>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-8-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260723184538.3888637-8-ekffu200098@gmail.com>

Hello Sang-Heon,

Thanks for your work.

On 2026-07-24 03:45:09 +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c          | 6 +-----
>  drivers/net/ethernet/aquantia/atlantic/aq_macsec.c    | 6 +-----
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 6 +-----
>  drivers/net/ethernet/freescale/gianfar.c              | 6 +-----
>  drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    | 7 +------
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 6 +-----
>  drivers/net/ethernet/renesas/rtsn.c                   | 7 +------

For rtsn.c,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  7 files changed, 7 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 5d05020a6d05..ea89619039d8 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -2303,11 +2303,7 @@ static int ena_open(struct net_device *netdev)
>  		return rc;
>  	}
>  
> -	rc = ena_up(adapter);
> -	if (rc)
> -		return rc;
> -
> -	return rc;
> +	return ena_up(adapter);
>  }
>  
>  /* ena_close - Disables a network interface
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
> index 3ca072360ec7..fd4ee6212234 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
> @@ -735,11 +735,7 @@ static int aq_set_rxsc(struct aq_nic_s *nic, const u32 rxsc_idx)
>  	sc_record.valid = 1;
>  	sc_record.fresh = 1;
>  
> -	ret = aq_mss_set_ingress_sc_record(hw, &sc_record, hw_sc_idx);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return aq_mss_set_ingress_sc_record(hw, &sc_record, hw_sc_idx);
>  }
>  
>  static int aq_mdo_add_rxsc(struct macsec_context *ctx)
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 33e7a99d3e49..79d4a77f72bd 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -3935,11 +3935,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
>  	if (err)
>  		return err;
>  
> -	err = dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
> -	if (err)
> -		return err;
> -
> -	return err;
> +	return dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
>  }
>  
>  static void dpaa2_switch_ctrl_if_teardown(struct ethsw_core *ethsw)
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 89215e1ddc2d..cf636fc5aafa 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -2877,11 +2877,7 @@ static int gfar_enet_open(struct net_device *dev)
>  	if (err)
>  		return err;
>  
> -	err = startup_gfar(dev);
> -	if (err)
> -		return err;
> -
> -	return err;
> +	return startup_gfar(dev);
>  }
>  
>  /* Stops the kernel queue, and halts the controller */
> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
> index fff8dc84212d..e96a268067f2 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
> @@ -2478,7 +2478,6 @@ static int netxen_parse_md_template(struct netxen_adapter *adapter)
>  static int
>  netxen_collect_minidump(struct netxen_adapter *adapter)
>  {
> -	int ret = 0;
>  	struct netxen_minidump_template_hdr *hdr;
>  	hdr = (struct netxen_minidump_template_hdr *)
>  				adapter->mdump.md_template;
> @@ -2486,11 +2485,7 @@ netxen_collect_minidump(struct netxen_adapter *adapter)
>  	hdr->driver_timestamp = ktime_get_seconds();
>  	hdr->driver_info_word2 = adapter->fw_version;
>  	hdr->driver_info_word3 = NXRD32(adapter, CRB_DRIVER_VERSION);
> -	ret = netxen_parse_md_template(adapter);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return netxen_parse_md_template(adapter);
>  }
>  
>  
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> index 45ed8705c7ca..47cd9ec665ee 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> @@ -1618,11 +1618,7 @@ static int qlcnic_83xx_check_hw_status(struct qlcnic_adapter *p_dev)
>  	if (err)
>  		return err;
>  
> -	err = qlcnic_83xx_check_heartbeat(p_dev);
> -	if (err)
> -		return err;
> -
> -	return err;
> +	return qlcnic_83xx_check_heartbeat(p_dev);
>  }
>  
>  static int qlcnic_83xx_poll_reg(struct qlcnic_adapter *p_dev, u32 addr,
> diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
> index ee8381b60b8d..f7beeb73eb16 100644
> --- a/drivers/net/ethernet/renesas/rtsn.c
> +++ b/drivers/net/ethernet/renesas/rtsn.c
> @@ -685,7 +685,6 @@ static void rtsn_set_rate(struct rtsn_private *priv)
>  static int rtsn_rmac_init(struct rtsn_private *priv)
>  {
>  	const u8 *mac_addr = priv->ndev->dev_addr;
> -	int ret;
>  
>  	/* Set MAC address */
>  	rtsn_write(priv, MRMAC0, (mac_addr[0] << 8) | mac_addr[1]);
> @@ -702,11 +701,7 @@ static int rtsn_rmac_init(struct rtsn_private *priv)
>  
>  	/* Link verification */
>  	rtsn_modify(priv, MLVC, MLVC_PLV, MLVC_PLV);
> -	ret = rtsn_reg_wait(priv, MLVC, MLVC_PLV, 0);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return rtsn_reg_wait(priv, MLVC, MLVC_PLV, 0);
>  }
>  
>  static int rtsn_hw_init(struct rtsn_private *priv)
> -- 
> 2.43.0
> 

-- 
Kind Regards,
Niklas Söderlund
