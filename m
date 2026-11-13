Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549080;
	b=Hb8YCrKhNP5xfadFQJvZy136pusubkke/6MNznkuInUcFiI8ae7Er8a1C7xCs3O3fBT1
	 1P7tUyX49uZ5+tlqHjffwFJTudN8ND9AEWW1pLRvvhl8sjQsqtwyD6zAp/bpBx5yWN9V0
	 mhOD0lwgavzoOarLW7mZtxRShFh/Hv9GLx7TKZoXUvi8UGN/hOjzFEZWS7PHQO90aamqx
	 vMkbNDTZ5b16tC6vMaAfcrkwZX2rs9eq7Rl65pb23BEcRm0+u1LVFMRpPSP+hDVU+U1s3
	 +yuziLhnzOMEn/Q0SGooafAvg1GolxrNGNYz+4qlhNTksSEW8ALD3Fq1lEr/Dw3nkkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549080;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l0WoN34knT+NLDw2syaUA1McmMkTTpOg+RnQ9PosWrU=;
	b=2TP6OGLFCnnkDB+BvL3Z4vTAA7TqQxsrMyN15hXKt8V2p51DXCaTqPGeNwbY1GaM7AOL
	 ZSf7Mrt+hc1UXHR0oXSbofEHKcwqWu/aI4y0p0T5OkCz3McmB8Hcgn9iQD40diSGZtsIm
	 p3EoS1QS/jRU/dbVwbwrPLc8Ob33vQIvzGO7hyXqhQhvANPvMmSxQJXwQv9l1HFpvZ8a3
	 XG9Luplj3M0tPbgAy9vQa286akADVlgcG3nmQQJ98KY0GrtioztwY09z308zEDgQsRcuh
	 QXXR+TkZN8DURoygsOcVxGY1tXPcbp1rnfjo//T3wI51M0OP3Nay4fPhOXvSVOkaYow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htgOrZSY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6A606A321;
	Fri, 13 Nov 2026 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htgOrZSY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791651F000C4;
	Fri, 13 Nov 2026 05:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549080;
	bh=l0WoN34knT+NLDw2syaUA1McmMkTTpOg+RnQ9PosWrU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=htgOrZSYyhQjK8JsRwbRMnbjPU85kWVpzG/UekeuXCBGrv+IGwPhLroJpwPr2NlZP
	 4vq1/s632R2fh7zspZm3S5pv6E1Z5TBaSqFFp+zAG7qwzSMP435D0vZIyxPeCOZ65w
	 gLlKYdCyGDf47YfA/nCE9X+6TujGd1YU3+wAh5E8CIV+yWqk+5uUHO8erIThzuECFl
	 3iy5PWaVPcDYfHrYp9o0kxyP8UnB2+bT6KPqIdcqI6MGJIbih2dBcxb2YWlwUp1BF2
	 GV67WjCAsVk6gsnmYAJz8+Gi0bBCrP7sZtv7paSp8nIj96VBaVd0dQyQjsocuhsvqq
	 SuKVmlELUp7NA==
Subject:
 Re: [PATCH net-next v3 1/3] ethtool: add PHY receive frame and byte totals
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Fri, 13 Nov 2026 05:51:18 +0000
Message-ID: <179454907898.2199510.14049135165340239195@kernel.org>
In-Reply-To: <20261109-submit-acx00-phy-stats-v1-v3-1-fbc6327c5be4@gmail.com>
References: <20261109-submit-acx00-phy-stats-v1-v3-1-fbc6327c5be4@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In Documentation/networking/ethtool-netlink.rst, the stats-group
  table row for ETHTOOL_STATS_PHY (line 1668) changes the documented…
- [Low] The patch defines exactly which bytes rx_bytes_total /
  RxOctetsTotal counts: Ethernet header, padding and FCS, but not…

--

ethtool: add PHY receive frame and byte totals

This patch adds optional rx_packets_total and rx_bytes_total counters to
struct ethtool_phy_stats. They are exposed in the phydev statistics group
as ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL and ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL.
Both totals include frames with errors, the byte total is defined to
include the Ethernet header, padding and FCS, and the netlink documentation
is updated to match.

> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index eba226c79ec36..5528d0f7afdd9 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1665,7 +1665,7 @@ the ``ETHTOOL_A_STATS_GROUPS`` bitset. Currently defined values are:
>   ETHTOOL_STATS_ETH_PHY  eth-phy  Basic IEEE 802.3 PHY statistics (30.3.2.1.*)
>   ETHTOOL_STATS_ETH_CTRL eth-ctrl Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*)
>   ETHTOOL_STATS_RMON     rmon     RMON (RFC 2819) statistics
> - ETHTOOL_STATS_PHY      phy      Additional PHY statistics, not defined by IEEE
> + ETHTOOL_STATS_PHY      phydev   Additional PHY statistics, not defined by IEEE

[Severity: Low]
This isn't a bug, but this hunk changes the documented group name for
ETHTOOL_STATS_PHY from "phy" to "phydev", and the commit message does not
mention it.

The new name is correct and matches the kernel:

net/ethtool/stats.c:stats_std_names[] {
    ...
	[ETHTOOL_STATS_PHY]			= "phydev",
    ...
}

The new paragraph below refers to the phydev group, so keeping the fix in
this patch seems reasonable. Could the commit message mention the
correction, or could it go in a separate patch?

[ ... ]

> +The ``phydev`` group provides separate counters for successfully received
> +traffic and total received traffic. ``ETHTOOL_A_STATS_PHY_RX_PKTS``
> +(``RxFrames``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES`` (``RxOctets``) count
> +successfully received frames and bytes. ``ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL``
> +(``RxFramesTotal``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL`` (``RxOctetsTotal``)
> +include frames with errors. The total byte count includes the Ethernet header,
> +padding and FCS, but excludes the preamble and start frame delimiter. These

[Severity: Low]
Should these byte boundaries also apply to RxOctets?

This paragraph says which bytes RxOctetsTotal counts, but it gives no
such rule for RxOctets. The kernel-doc for rx_bytes in struct
ethtool_phy_stats in include/linux/ethtool.h still only says:

 * @rx_bytes: Total successfully received bytes

A driver could report rx_bytes without FCS and rx_bytes_total with FCS,
and both would match the documentation. In that case, RxOctetsTotal minus
RxOctets would not be the number of bytes in errored frames.

No PHY driver in drivers/net/phy sets ethtool_phy_stats.rx_bytes yet. Can
the definition be made the same for both counters now, before a driver
depends on it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4%40gmail.com
