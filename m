Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEEF4D9F6A;
	Mon, 19 Oct 2026 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404536; cv=none; b=SeGbYHL+TMpsTQed0bMsPM3L9oTg1qo6aAOeYEAMmAbieWkfwFXHohnqAVNDtlXH3uVSi4RFYMLFM3l2gmhkrUnGjdsLz50R9HQFtm9FTZziB90snD3jmuK0nZNbR4/6VyM9HBt97eYRpL0DOdrm3dfUXVX/rMlvUVcqd6QwqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404536; c=relaxed/simple;
	bh=e4M5GIVHRKJleKxwEFL10u3DdioDxRxmWP8f9Ju2vLo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/A5LJpBvulBIEFYkGevT7D6wm6kSl/vNxHlhDaWsGhji0dZuCE5RUObEU4NFwxcZBZhn17L4wGL5rVF/QPEiBD7rt0BW6heSVmQWUcnMYRQycn9JP3FAQO20z0VkynMzdsnaSgFk28caZ4jXt4Tx91g5URmy+6NQTb2+q68amg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8C4+uhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8C4+uhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794691F000C5;
	Mon, 19 Oct 2026 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792404534;
	bh=if/r576nCJveP9pEbWDHZQui6hukAF4UhYA2QYWeDXE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S8C4+uhvJw0yvIP1nCu0HUXdFKmwKY+A1Zxvy9bSXOwszU9YzIn4ZzCc8T1irXaly
	 2Aij6KHnms6nJ9YP6c9Sxn8OetPaY8bhueWvmDw9r1BKHP8+Ey/wxHeZTcBQzGyfV7
	 rUF1lHEF57a90V9Jh3Ayg53tFQAleaipU04dNBO4fQxx6qh3TSvaNxHtTLo5QeI3r9
	 jxUXWHt7yduz/e7ZgK3yDMoIDrcxR5EN3KGUCLBpjXlhUgFV96WI/r4D8qnKqBixFJ
	 wxVrsLDTEyPfp11mJvbJ5xBUFdTyTtD0XgW28hJ2OpR+bqL++rfavIWpiIPyTjpFGl
	 dUom/HUMVDOMg==
Subject: Re: [PATCH net-next v15 9/9] net: dsa: lan9645x: add port statistics
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, edumazet@kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Mon, 19 Oct 2026 10:08:53 +0000
Message-ID: <179240453307.3135.2065386937763476332@kernel.org>
In-Reply-To:
 <20261015-dsa_lan9645x_switch_driver_base-v15-9-562f316f78b9@microchip.com>
References:
 <20261015-dsa_lan9645x_switch_driver_base-v15-9-562f316f78b9@microchip.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] lan9645x_stats_get_stats64()
  (drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c) counts error…

--

net: dsa: lan9645x: add port statistics

This adds port statistics support to the lan9645x DSA driver. The 32 bit
hardware counters are polled into a 64 bit software cache, and the pMAC
counters are summed into the aggregate source. The cache is exposed through
ethtool -S, the standard ethtool groups and ndo_get_stats64.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> new file mode 100644
> index 0000000000000..a21afb4d98532
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> @@ -0,0 +1,854 @@

[ ... ]

> +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> +				struct rtnl_link_stats64 *stats)
> +{

[ ... ]

> +	stats->rx_packets = c[SCNT_RX_SHORT] +
> +			    c[SCNT_RX_JABBER] +
> +			    c[SCNT_RX_SZ_64] +
> +			    c[SCNT_RX_SZ_65_127] +
> +			    c[SCNT_RX_SZ_128_255] +
> +			    c[SCNT_RX_SZ_256_511] +
> +			    c[SCNT_RX_SZ_512_1023] +
> +			    c[SCNT_RX_SZ_1024_1526] +
> +			    c[SCNT_RX_SZ_JUMBO] +
> +			    c[SCNT_RX_LONG] +
> +			    c[SCNT_RX_PMAC_SHORT] +
> +			    c[SCNT_RX_PMAC_FRAG] +
> +			    c[SCNT_RX_PMAC_JABBER] +
> +			    c[SCNT_RX_PMAC_SZ_64] +
> +			    c[SCNT_RX_PMAC_SZ_65_127] +
> +			    c[SCNT_RX_PMAC_SZ_128_255] +
> +			    c[SCNT_RX_PMAC_SZ_256_511] +
> +			    c[SCNT_RX_PMAC_SZ_512_1023] +
> +			    c[SCNT_RX_PMAC_SZ_1024_1526] +
> +			    c[SCNT_RX_PMAC_SZ_JUMBO] +
> +			    c[SCNT_RX_PMAC_LONG];
> +
> +	stats->multicast = c[SCNT_RX_MC] + c[SCNT_RX_PMAC_MC];
> +
> +	stats->rx_errors = c[SCNT_RX_SHORT] +
> +			   c[SCNT_RX_JABBER] +
> +			   c[SCNT_RX_CRC] +
> +			   c[SCNT_RX_LONG] +
> +			   c[SCNT_RX_PMAC_SHORT] +
> +			   c[SCNT_RX_PMAC_JABBER] +
> +			   c[SCNT_RX_PMAC_CRC] +
> +			   c[SCNT_RX_PMAC_LONG];

[Severity: Medium]
Should short, jabber and oversize frames be counted in rx_packets in
lan9645x_stats_get_stats64()?

rx_packets and rx_errors both add SCNT_RX_SHORT, SCNT_RX_JABBER and
SCNT_RX_LONG, plus their pMAC versions. JABBER and LONG are also added to
rx_length_errors. So every malformed frame received on a user port counts
once as a good packet and once as an error.

The rtnl_link_stats64 kernel-doc in include/uapi/linux/if_link.h says:

  @rx_packets: Number of good packets received by the interface.

The v5 changelog also says CRC and symbol error frames "are already counted
in SZ_* buckets". Since those buckets feed rx_packets, frames with a bad CRC
would be counted as good packets as well.

This also gives a different answer from lan9645x_stats_get_eth_mac_stats(),
which counts good received frames as UC + MC + BC only:

	m->FramesReceivedOK = c[SCNT_RX_UC] +
			      c[SCNT_RX_MC] +
			      c[SCNT_RX_BC] +
			      ...

As a result, rx_packets is larger than FramesReceivedOK by the number of
errored frames. ocelot_port_get_stats64() uses a similar rx_packets formula,
but that does not match the uAPI description either.

Could rx_packets be derived the same way as FramesReceivedOK?

A separate point: c[SCNT_RX_PMAC_FRAG] is added to rx_packets but not to
rx_errors. The comment in lan9645x_stats_get_rmon_stats() says:

	/* ... Only SCNT_RX_PMAC_FRAG counts runts with an invalid
	 * CRC, so fragments is left unset rather than reporting the pMAC alone.
	 */

Going by that comment, a pMAC runt with a bad CRC would be counted as a
good packet and left out of the error total. Is that intended?

v12 removed the eMAC SCNT_RX_FRAG from rx_packets, but the pMAC version is
still there. Since the pMAC gets no traffic without MAC merge, this has
little effect today.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip.com
