Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104B47255A;
	Mon, 12 Oct 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804291; cv=none; b=OuT120H+8gKkC/GxLDWjhfDcr/+NuyIKw+Gf23Gqc/XJFy0Ce2d7bU/o0Kq+I8qK2Mg7cVr55ojETbsfduCCsK02f1N7JiCDNMN73gy5PNHN3TKt6n5xtAoDOsA/86bcm87CZzfs8y7q5Mqo/WZm4RI05hZijcyQ0P+5AincsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804291; c=relaxed/simple;
	bh=g4qevxVz3AcnTU/97rt3xsS9O47PFPuJdtQLDJuY5R8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kZEF8Ki0SyAHmYTVKHCdcCNQ49rEuutDixF0cQBesx+QSLQw1KCAsjLjxbTC3QrjzfYY30Iw96awxWHNmVVbiUappi/knGm2HS0o6uDvLrlFamQlfzYQ0C4StE0HLsmOrppqqiESUCEdo7G2TrhhIHEYZRQI39Al3BVI5xHt9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+MJvNBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+MJvNBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D441F0089B;
	Mon, 12 Oct 2026 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804289;
	bh=ddz8Bd0JqmYgGYTNHVNCIiwClFYJwEhG2zPnAVwxs1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F+MJvNBU0/1xkQJUVJ03hSahp37H6nfPse8hPLR5orEz0ctkxfSRjYKTr/TzHBbbQ
	 SwkUG3f9OsvACEbTb0tTSfOlOX6pT7OTDuk1OGSBNNG/0LksrBai5xPnFvLWzRVFV2
	 hehSxSW3SzM2iwKpD7LTKxKtXEZ1F0MRTyipsmLcpgaOaciG/rAoAvYpGlxXCD4Fw8
	 gpJIvbagibxG2X474AFpF1aFGxGN2NXHCrrM+fu6DjRXGyKmIm3vTbJ5O6Dow3sgPF
	 Np+ck3lX0rYOYlANJyx0spr4zhFQjcfPXMF2N51dUTK9RC2Z3ixFA0LRHA94WAtMMs
	 OngqjWS/OB2KQ==
Subject: Re: [PATCH net-next v14 9/9] net: dsa: lan9645x: add port statistics
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
Date: Mon, 12 Oct 2026 11:24:47 +0000
Message-ID: <179180428793.434549.2970303377957273063@kernel.org>
In-Reply-To:
 <20261008-dsa_lan9645x_switch_driver_base-v14-9-3d2a72661213@microchip.com>
References:
 <20261008-dsa_lan9645x_switch_driver_base-v14-9-3d2a72661213@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] lan9645x_stats_get_stats64() counts bad frames in
  rtnl_link_stats64.rx_packets.
- [Low] In lan9645x_stats_get_stats64(), rx_errors is the sum
  c[SCNT_RX_SHORT] + c[SCNT_RX_JABBER] + c[SCNT_RX_CRC] +…
- [Low] __lan9645x_stats_view_idx_hw_read() selects the port with
  lan_wr(SYS_STAT_CFG_STAT_VIEW_SET(idx), lan9645x, SYS_STAT_CFG).

--

net: dsa: lan9645x: add port statistics

This commit adds port statistics support to the lan9645x DSA driver. A
delayed work polls the 32-bit hardware counters every 3 seconds and
accumulates them into 64-bit software counters. The counters are exposed
through ethtool -S, the standard ethtool stats groups and get_stats64, with
the pMAC counters summed into the aggregate source.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> new file mode 100644
> index 0000000000000..a21afb4d98532
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> @@ -0,0 +1,854 @@

[ ... ]

> +static void lan9645x_stats_update_counter(u64 *sw, u32 hw)
> +{
> +	if (hw < (*sw & U32_MAX))
> +		*sw += (u64)1 << 32; /* value has wrapped */
> +
> +	*sw = (*sw & ~(u64)U32_MAX) + hw;
> +}
> +
> +static int __lan9645x_stats_view_idx_hw_read(struct lan9645x *lan9645x,
> +					     enum lan9645x_view_stat_type vtype,
> +					     int idx)
> +{

[ ... ]

> +	lan_wr(SYS_STAT_CFG_STAT_VIEW_SET(idx), lan9645x, SYS_STAT_CFG);

[Severity: Low]
What happens to the counters if this lan_wr() fails?

lan_wr() returns void and only does WARN_ON_ONCE(regmap_write(...)), so
this function never sees a failed STAT_VIEW select. The SYS_CNT window
read by the lan_bulk_rd() calls below is the same for every port. If the
reads still succeed, buf holds the counters of the previously selected
port.

__lan9645x_stats_view_idx_transfer() then passes those values through
lan9645x_stats_update_counter() into the requested port's shadow. If the
wrong value is larger, the shadow takes it. On the next correct poll,
this check:

	if (hw < (*sw & U32_MAX))
		*sw += (u64)1 << 32; /* value has wrapped */

adds 2^32. That counter then stays about 4G too high until the next
setup.

lan9645x_stats_clear_view() has the same unchecked write:

	lan_wr(SYS_STAT_CFG_STAT_VIEW_SET(idx) |
	       SYS_STAT_CFG_STAT_CLEAR_SHOT_SET(groups),
	       lan9645x, SYS_STAT_CFG);

If that write is dropped, the poll for !CLEAR_SHOT passes at once and a
clear that never happened is reported as success. That case looks
harmless, since the shadow later takes the uncleared hardware value.

ocelot_port_update_stats() follows the same pattern, and every other
lan_wr() in this driver also ignores write errors. Fixing this would
probably mean having the helper return the regmap_write() result.

> +
> +	/* Each region for this index contains counters which are at sequential
> +	 * addresses, so we can use bulk reads to ease lock pressure a bit.
> +	 */
> +	for (int r = 0; r < vstats->num_regions; r++) {
> +		region = vstats->regions[r];
> +		err = lan_bulk_rd(&vstats->buf[region.cnts_base_idx],
> +				  region.cnt, lan9645x,
> +				  SYS_CNT(region.base_offset));

[ ... ]

> +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> +				struct rtnl_link_stats64 *stats)
> +{

[ ... ]

> +	stats->rx_bytes = c[SCNT_RX_OCT] + c[SCNT_RX_PMAC_OCT];
> +
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

[Severity: Medium]
Should rx_packets include the error counters?

The rtnl_link_stats64 documentation in include/uapi/linux/if_link.h
describes rx_packets as "Number of good packets received by the
interface". It describes rx_errors as "Total number of bad packets
received on this network device".

SCNT_RX_SHORT, SCNT_RX_JABBER and SCNT_RX_LONG, plus their pMAC
versions, are added to both rx_packets and rx_errors. Each runt, jabber
and oversize frame is therefore counted as good and as bad.

The SZ_* buckets also seem to include CRC-errored frames. The v5
changelog removed rx_crc from rx_packets "as they are already counted in
SZ_* buckets". So rx_packets ends up counting every frame received.

This also does not match FramesReceivedOK in
lan9645x_stats_get_eth_mac_stats(), which is UC + MC + BC. The two
standard interfaces would report different good RX counts for the same
port.

ocelot_port_get_stats64() uses a similar formula. Is that the intended
meaning of rx_packets for this new driver?

Separately, c[SCNT_RX_PMAC_FRAG] is added to rx_packets but not to
rx_errors, while c[SCNT_RX_PMAC_SHORT] is added to both. The comment in
lan9645x_stats_get_rmon_stats() says SCNT_RX_PMAC_FRAG counts runts with
an invalid CRC.

Should SCNT_RX_PMAC_FRAG go into rx_errors too, or be removed from
rx_packets? This has no effect until MAC merge sends traffic to the pMAC.

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
> +
> +	stats->rx_length_errors = c[SCNT_RX_JABBER] +
> +				  c[SCNT_RX_LONG] +
> +				  c[SCNT_RX_PMAC_JABBER] +
> +				  c[SCNT_RX_PMAC_LONG];
> +
> +	/* SCNT_RX_CRC counts CRC errors, alignment errors and RX_ER events at
> +	 * any frame size, so a short frame with a bad CRC is counted here.
> +	 */
> +	stats->rx_crc_errors = c[SCNT_RX_CRC] + c[SCNT_RX_PMAC_CRC];

[Severity: Low]
Is a jabber frame counted twice in rx_errors?

This comment says SCNT_RX_CRC counts CRC errors "at any frame size". The
v12 changelog describes SCNT_RX_JABBER as "the too-long-with-bad-CRC half
of the event".

If both are true, an oversize frame with a bad FCS increments both
SCNT_RX_CRC and SCNT_RX_JABBER. rx_errors above adds the two together.

If the hardware keeps these two counters disjoint, is the "any frame
size" wording in this comment accurate?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip.com
