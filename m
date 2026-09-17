Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDE5A5120;
	Thu, 17 Sep 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657704; cv=none; b=ey1hGzYMUNGjrtVUvXZM2KaDutJa7pOSZmRGgkupTb3KxidT8UaYXPOOay7cyrGKHrI7CXkaHWbji9c8t6Sqn/YNMpHR5BaO3+t4JEg4l/iSPbFENCPV5TcP3575XUByct+RhFaFOEpOFxPwYRIsnG3PWAJ+Z9VnoUD0rs2GKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657704; c=relaxed/simple;
	bh=TshFgpYU0IOD0UdJn0hXk290a5HcNvV5UdjmYmWG2/8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZ4cUKrxBUJqTx+YpJ5CAqvyaMZkjZ9jv62VWnxSAaoQJQOESEE0TXjqDNI9Os117jtAbI5JhxPa6UE6WnnGCJUgUZJLmt/8sGtgM8NfcGhl2uFkZ2C+C/JD+v1KS7PdftdPELI7yaDBd898ZxypkLw7roWx9DCHUwMEo5J+Hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl9qAJD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl9qAJD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B671F000FF;
	Thu, 17 Sep 2026 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657699;
	bh=2iGhgSepTfMvTest9R2671rFzQ55p8ybqQp29LxKFTc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jl9qAJD3FmxNKwOaalSgcsSphrCK9ND2fSQ70tv01efnCKfqh5cn27jfjw/u4Ov+t
	 4+i21OUJJHtmKAvZrAKtmKfDMUdSybA2Afg8Camf5k7K5vFU5r9WesMPzBejE6Qulr
	 d+JieLRmXDXhN0PI+SoWMdEeHSE+Ziu5FxXrC5rRSKB8xJlZ+k7MVX8jpHFjujCsZH
	 y/dm+bGpg5alcjOMW3nHXrJhIppNPGNO+lmdnrea6GANJJ1xxoVK6wqiKW7F+VkAJL
	 GiTeTG/oRdKjQHJSDlb8fnw8OsWJB/nz+OU7h0uOpJO1I0FMgnc1BPzToCbbf5u1WK
	 U9NdQNcH3OLGg==
Subject: Re: [PATCH net v7 1/2] net: stmmac: selftests: Prevent RXC from being
 disabled in LPI
From: netdev-bot+sashiko@kernel.org
To: peilinhe2020@163.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 he.peilin@zte.com.cn, jiang.kun2@zte.com.cn, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, pabeni@redhat.com, vbridgers2013@gmail.com,
 xu.xin16@zte.com.cn
Date: Thu, 17 Sep 2026 15:08:17 +0000
Message-ID: <178965769776.22033.13374439300724313005@kernel.org>
In-Reply-To: <20260914150612.9798-2-peilinhe2020@163.com>
References: <20260914150612.9798-2-peilinhe2020@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The last paragraph of the commit message describes the
  `eee_rx_clk_stop_enable` precondition backwards.

--

net: stmmac: selftests: Prevent RXC from being disabled in LPI

The patch wraps the selftest loop in stmmac_selftest_run() with
phylink_rx_clk_stop_block() / phylink_rx_clk_stop_unblock() so the PHY
does not stop the receive clock while the MAC is in loopback. The code
change itself looks balanced and is a no-op when the phylink config does
not allow RX clock stop.

The question below is only about the changelog, so the diff hunk is not
quoted.

>     As the NETIF_F_VLAN_FEATURES may be empty on some platforms once the
>     software vlan stripping is removed, the phylink config attribute
>     'eee_rx_clk_stop_enable' may no longer be inconditionnally set to
>     true, hence allowing RXC to be disabled during LPI on platforms
>     that don't have any VLAN features.

[Severity: Medium]
Is the true/false direction here inverted?

include/linux/phylink.h documents the field as:

 * @eee_rx_clk_stop_enable: if true, PHY can stop the receive clock during LPI

So true is what permits the PHY to stop RXC, which makes "may no longer
be inconditionnally set to true, hence allowing RXC to be disabled"
read as its own opposite.

The code in stmmac_phylink_setup() also goes the other way, setting the
flag when the VLAN feature mask is empty:

	/* Disable EEE RX clock stop to ensure VLAN register access works
	 * correctly.
	 */
	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI) &&
	    !(priv->dev->features & NETIF_F_VLAN_FEATURES))
		config->eee_rx_clk_stop_enable = true;

In the current tree __stmmac_dvr_probe() sets, under
STMMAC_VLAN_TAG_USED:

	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;

so with CONFIG_VLAN_8021Q=y the flag is never true today, and it only
becomes true once the software VLAN stripping removal drops that
assignment. Would it be clearer to say that the flag starts being set to
true, thereby letting the PHY stop RXC?

Related to that, should the changelog also mention that
CONFIG_VLAN_8021Q=n builds are already affected today? With
STMMAC_VLAN_TAG_USED undefined in common.h, no VLAN features are ever
set, so eee_rx_clk_stop_enable is already true on platforms without
STMMAC_FLAG_RX_CLK_RUNS_IN_LPI and the selftests can already fail there.

As written it is hard to tell whether this fixes a live failure or is a
prerequisite for the following patch in the series, which also makes the
Fixes tag range hard to check.

There is also a spelling slip in the same paragraph: "inconditionnally"
should be "unconditionally".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914150612.9798-1-peilinhe2020%40163.com
