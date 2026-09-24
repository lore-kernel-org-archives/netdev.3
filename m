Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F344238A;
	Thu, 24 Sep 2026 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252404; cv=none; b=gEbzyFbeTT/uXr85yPUAlhwKfcthIHFb4z8c0oHJN89mH5M6t4rCMALre8FcYpiuZnvkUkAZOmgXvT2YKtcDOyuC1V+bbSJTOTUaCDcQUc+TAL/OR+Myhq76OjHi5Lpmw29g/g8gAHLjiiUDwmDhK182ttiv9QcujyK5hXQyQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252404; c=relaxed/simple;
	bh=mCDGIhgL5YgoDNhrEuHNH0FqQnLMupcxNHyB/VlcsRA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRst49Hg72JN3CH7i9Qzfa1tCg0KVgqv4kh5QSmjWrFxFIv8uTjDPq6gDoM+oCtrHy/bMp5HAo2a+oZkW7u7q3JnwY5vrFOjWwSWscWnVTRUUfXTTNnMoh+4mEl+ku32G0XCbO8anvwLax7KmWLXEGjI2z3u0cuz4eqU/vJjJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhqFWrLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhqFWrLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3A71F000FF;
	Thu, 24 Sep 2026 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790252402;
	bh=VpXn1ri2/l5+8sDmLQVWGe+Xu8dfgiYtuX1ZX27BjLU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XhqFWrLiFF8fdEkWiHFilpj/MMiNDw0nOw9vS1MafwIQtsqjhb5LID1i5eFnxhOQl
	 wYAuSNaJvrkd2bMBGzMHCh1NqMU2ThYxsnI0iuo508RImmobapS8zaF63tkdxX/edS
	 OkNDv/cwX/jPvsLPKmHQpURZvO0IpZDojQyDLkJeKDlyqh7mRDweylxdNsVVDydIZJ
	 pmphzM8b7PhUza/kup8SYp11NxodYbbOjrMpg07cKJ89DOJwhBdPRutWWQE6irNFzw
	 V+E+usF/dV5AQJ4WU1t66zV6hZua+EydPdthhpDUsZlBoOD754+pELM3DISi1E42TI
	 e9RyIbQC7RbNQ==
Subject: Re: [PATCH net v2 1/2] net: ethtool: don't match a hwtstamp provider
 on a device without a PHC
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kory.maincent@bootlin.com,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 12:20:01 +0000
Message-ID: <179025240177.2160803.17736204487729550368@kernel.org>
In-Reply-To: <20260923121644.2194183-2-nb@tipi-net.de>
References: <20260923121644.2194183-2-nb@tipi-net.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] The patch deals with the 0xFFFFFFFF/-1 aliasing through an
  open-coded check at one comparison site instead of rejecting the value…

--

net: ethtool: don't match a hwtstamp provider on a device without a PHC

This patch adds a phc_index >= 0 check to ethtool_net_get_ts_info_by_phc().
A requested provider index of 0xFFFFFFFF becomes -1 when stored in an int,
and with this check it no longer matches a netdev that reports no PHC.

> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 23db40618fed1..23e8282563cc3 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -980,7 +980,7 @@ int ethtool_net_get_ts_info_by_phc(struct net_device *dev,
>  	if (err)
>  		return err;
>  
> -	if (info->phc_index == hwprov_desc->index &&
> +	if (info->phc_index >= 0 && info->phc_index == hwprov_desc->index &&
>  	    net_support_hwtstamp_qualifier(dev, hwprov_desc->qualifier))
>  		return 0;
>  

[Severity: High]
Can the same -1 == -1 match still happen in the PHY half of the lookup?

ethtool_phy_get_ts_info_by_phc() in net/ethtool/common.c still compares on
equality alone. It does this in the link topology loop:

	xa_for_each(&dev->link_topo->phys, phy_index, pdn) {
		...
		ethtool_init_tsinfo(info);
		err = phy_ts_info(pdn->phy, info);
		...
		if (info->phc_index == hwprov_desc->index)
			return pdn->phy;
	}

It does the same in the dev->phydev fallback:

	if (info->phc_index == hwprov_desc->index)
		return dev->phydev;

ethtool_init_tsinfo() sets phc_index to -1. So a PHY whose ts_info callback
succeeds without reporting a PHC would match a request for 0xFFFFFFFF.

With this change, the netdev matcher always returns -ENODEV for index -1.
tsconfig_set_hwprov_from_desc() then falls back to the PHY matcher:

	ret = ethtool_net_get_ts_info_by_phc(dev, &ts_info, hwprov_desc);
	if (!ret) {
		/* Found */
		source = HWTSTAMP_SOURCE_NETDEV;
	} else {
		phy = ethtool_phy_get_ts_info_by_phc(dev, &ts_info, hwprov_desc);
		...
		source = HWTSTAMP_SOURCE_PHYLIB;
	}

That builds a hwprov with desc.index = -1, source = HWTSTAMP_SOURCE_PHYLIB,
and phydev pointing at the PHY that has no PHC. ethnl_set_tsconfig() then
installs it in dev->hwprov.

Wouldn't a provider still be selected on hardware that has no PHC, just a
PHYLIB one instead of a NETDEV one? The commit message says "only match a
real PHC index".

One in-tree example looks to be ines_ts_info() in drivers/ptp/ptp_ines.c.
It never writes phc_index and returns 0. The INES timestamper is attached
as phy->mii_ts from the device tree in fwnode_mdiobus_register_phy(), so
phy_has_tsinfo() is true for that PHY.

With CONFIG_PTP_1588_CLOCK=n, bcm-phy-ptp and mscc_ptp also install mii_ts
and report ptp_clock_index(NULL), which is -1.

micrel's lan8841_ts_info() can also report -1. However, its probe only sets
phydev->mii_ts when ptp_clock is non-NULL, so it doesn't seem to be a
trigger.

Here is a possible sequence on a MAC with a real PHC N and a PHY with an
INES mii_ts:

  ETHTOOL_MSG_TSCONFIG_SET provider {N, PRECISE}
    dev->hwprov = {N, PRECISE, NETDEV}
  ETHTOOL_MSG_TSCONFIG_SET provider {0xFFFFFFFF, PRECISE}
    ethnl_update_u32() sets hwprov_mod since N != 0xFFFFFFFF
    ethtool_net_get_ts_info_by_phc() returns -ENODEV
    ethtool_phy_get_ts_info_by_phc() matches -1 == -1
    dev->hwprov = {-1, PRECISE, PHYLIB, INES phy}

TSCONFIG GET only emits the provider when index >= 0, so userspace would
not see this selection afterwards.

The next patch in this series, "net: ethtool: let tsconfig reach a
PHY-only timestamp provider", doesn't change either PHY match site or the
policy. It also drops the ndo_hwtstamp_set/get requirement, so more
devices could reach this fallback.

Should the same >= 0 check also go into both PHY match sites?

[Severity: Medium]
Would it be better to reject 0xFFFFFFFF at the netlink boundary instead of
adding an open-coded check at one comparison site?

The policy in net/ethtool/ts.h leaves the index unbounded:

	[ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX] = { .type = NLA_U32 },

Documentation/netlink/specs/ethtool.yaml also describes the index as a
plain u32. ts_parse_hwtst_provider() copies it into the int
hwtstamp_provider_desc.index, where -1 is also the "no provider requested"
sentinel.

This aliasing is still visible in ETHTOOL_MSG_TSINFO_GET after the patch.
tsinfo_parse_request() starts with:

	req->hwprov_desc.index = -1;

A user-supplied index of 0xFFFFFFFF overwrites that with the same value, so
tsinfo_prepare_data() skips the provider lookup:

	if (req->hwprov_desc.index != -1) {
		ret = ethtool_get_ts_info_by_phc(dev, &data->ts_info,
						 &req->hwprov_desc);
		...
	}

It then returns the default provider's tsinfo instead of an error, even
though the request named a provider.

NLA_POLICY_MAX(NLA_U32, INT_MAX) for ETHTOOL_A_TS_HWTSTAMP_PROVIDER_INDEX
would stop -1 from ever arriving from userspace, for both tsconfig SET and
tsinfo GET. It would cover the PHY match sites too, and the bad attribute
would be reported through extack.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923121644.2194183-2-nb%40tipi-net.de
