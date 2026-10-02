Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E04FDA7E;
	Fri,  2 Oct 2026 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975670; cv=none; b=HBKZUsIiQiT4ppAtsdDnwOJ9Yms50vcI0UArlYlDIClyNEBLrv+2mqIFycVVf0WrFeU/qSd/vU6XhhvGSMesBp8b3PhFXu+kWI1Y9ecl99nTMcb/9dxYex/78QxYNmEL+Un8SUa/7c5EUqf3jlHiWJEp6Wq8ZXLjPCEgBNKBfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975670; c=relaxed/simple;
	bh=+jv31ccIhOb8FrXhXWahI2VF/WjBW/tpQ4MtIQMg45M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQA6BTaKfGbQ1gqkzsWxfsbOgEI+aK2XUSb7Vmxh5XNa8G2KQmgBA3/Bz0C767Vt2kNgdCFdRT7jmGltRalWFSl6mY5O362wb81rpKnfPU0TCyoSk9stXDtPkbpurWiGWysX923WfLRKq0EmD7vwvWhWlUBRmAqYeXMNsrsW2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul9T1K0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul9T1K0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1713A1F00899;
	Fri,  2 Oct 2026 21:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975668;
	bh=DC/qKm6b/6853KuyCaBbJha6FdHLb8zcxHwijeIilGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ul9T1K0MoAoeWKYm1iO9f4SqGWmP01CeCq7Gpz38tKQmczSQRH0qEYyNKdOP/6yU9
	 DbQnbzbqzDMn2jWehKB8VTtS5GQoN6j1iFkndLDjzB4l3G+f8qteHlFIFaOU7szpyQ
	 MCrSRbNzaxijbpgzPwZQkZkgLRvaTpMqxCNlWKQTm9c2Ms+SWna/JlGCstGP23PQnt
	 eVEz3V6HN4cUrpwCbVbK5JcEi2j5yJW/I+2JQ/4sIR9YZJa1A1vkzCqkDpkLlujV7G
	 8iKroEQXm9jjqcA+wa3KEdDNCGvuy+M3dl8S5K/aE1p4gZ3FaiS8suESzAFhX5Iqgp
	 fszcM0+lkLzvw==
Subject: Re: [PATCH net-next v13 9/9] net: dsa: lan9645x: add port statistics
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 02 Oct 2026 21:14:26 +0000
Message-ID: <179097566660.434549.17651613804901292493@kernel.org>
In-Reply-To:
 <20260929-dsa_lan9645x_switch_driver_base-v13-9-827c2d3617f2@microchip.com>
References:
 <20260929-dsa_lan9645x_switch_driver_base-v13-9-827c2d3617f2@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] lan9645x_stats_get_sset_count() returns -EOPNOTSUPP (-95) for
  every string set other than ETH_SS_STATS.
- [Medium] lan9645x_stats_get_stats64() counts bad frames in rx_packets.
- [Medium] The eMAC and pMAC FRAG counters are handled inconsistently.
- [Low] The commit message says 'The eMAC and pMAC counter sources are
  decoded, but only the aggregate source is reachable for now'.

--

net: dsa: lan9645x: add port statistics

This adds port counter support to the lan9645x DSA driver. The 32 bit
hardware counters are copied into 64 bit software counters by a poller
that runs every three seconds. They are reported through ethtool -S, the
standard ethtool statistics groups and ndo_get_stats64.

> The eMAC and pMAC counter sources are decoded, but only the aggregate
> source is reachable for now, until MAC merge support is added.

[Severity: Low]
Is this sentence still accurate? None of these read the ->src field of the
structure they fill in:

  lan9645x_stats_get_eth_mac_stats()
  lan9645x_stats_get_rmon_stats()
  lan9645x_stats_get_pause_stats()
  lan9645x_stats_get_eth_phy_stats()
  lan9645x_stats_get_eth_ctrl_stats()

All of them always return the eMAC plus pMAC sum.

The v12 changelog says "Drop the unreachable mac merge related code", so
the per-source decoding seems to have been removed. This has no runtime
effect today, because without .get_mm ethtool only allows the aggregate
source.

Could the message say instead that the pMAC counters are summed into the
aggregate, and that per-source reporting is not implemented yet?

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> new file mode 100644
> index 0000000000000..1253f77489931
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> @@ -0,0 +1,856 @@

[ ... ]

> +int lan9645x_stats_get_sset_count(struct lan9645x *lan9645x, int port, int sset)
> +{
> +	if (sset != ETH_SS_STATS)
> +		return -EOPNOTSUPP;

[Severity: Medium]
Can this negative return value corrupt the sset counts that the conduit
netdev reports? DSA replaces the conduit's get_sset_count with
dsa_conduit_get_sset_count(). For every sset, that function calls:

net/dsa/conduit.c:dsa_conduit_append_port_sset_count() {
	if (ds->ops->get_sset_count)
		*count += ds->ops->get_sset_count(ds, port, sset);
}

Nothing checks for a negative value. For ETH_SS_TEST, ETH_SS_PRIV_FLAGS
and ETH_SS_PHY_STATS, the conduit therefore reports its own count minus
95.

If the conduit has fewer than 95 entries, the count is negative. Then
ethtool -t, the netlink priv-flags path and ETHTOOL_GSTRINGS on the
conduit fail with a bogus errno. The conduit's self-tests and private
flags also drop out of ethtool -i and the netlink strset reply.

If the conduit has 95 or more entries, the result is zero or a smaller
positive value. ethtool_self_test(), ethtool_get_phy_stats_ethtool() and
strset_prepare_set() size their buffers from that value, but the
conduit's own callbacks still write their full number of entries. No real
NIC has that many entries, so this part is theoretical.

Most other DSA drivers (hellcreek, lan9303, gswip, mt7530, qca8k, a5psw,
vsc73xx, and others) return 0 for unsupported ssets. Should this return 0
as well?

> +
> +	return ARRAY_SIZE(lan9645x_port_ethtool_stats);
> +}

[ ... ]

> +	r->undersize_pkts = c[SCNT_RX_SHORT] +
> +			    c[SCNT_RX_PMAC_SHORT];
> +	r->oversize_pkts = c[SCNT_RX_LONG] +
> +			   c[SCNT_RX_PMAC_LONG];
> +	/* SCNT_RX_FRAG counts frames received after the port is paused, and
> +	 * increments when pause frames arrive from the link partner.
> +	 * It counts neither undersize frames nor errors, so it is left out here
> +	 * and out of rx_packets, unlike lan966x which adds it to rx_errors.
> +	 * SCNT_RX_PMAC_FRAG does count number of runt frames with invalid CRC.
> +	 */
> +	r->fragments = c[SCNT_RX_PMAC_FRAG];

[Severity: Medium]
Can fragments be non-zero without MAC merge support? The pMAC receives no
traffic until MAC merge is supported, so RMON fragments always reads 0 in
lan9645x_stats_get_rmon_stats(). That includes the case where runts with
a bad CRC arrive on the eMAC.

Documentation/networking/statistics.rst says drivers should leave fields
they do not report at ETHTOOL_STAT_NOT_SET, not overwrite them with 0. If
no accurate eMAC fragment count exists, would it be better to leave
fragments unset?

The two MACs are also treated differently in lan9645x_stats_get_stats64().
rx_packets includes c[SCNT_RX_PMAC_FRAG] but not c[SCNT_RX_FRAG]. As a
result, a bad-CRC runt is counted in rx_packets only when the pMAC
receives it.

Does the hardware really use different meanings for the counters at
offset 0x5 and offset 0x35, which is the same position in the pMAC block?
If not, could both MACs be handled the same way?

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

[Severity: Medium]
Should rx_packets include SCNT_RX_SHORT, SCNT_RX_JABBER and SCNT_RX_LONG,
and their pMAC equivalents? The same function counts all of them in
rx_errors below, and counts JABBER and LONG in rx_length_errors too.

include/uapi/linux/if_link.h describes rx_packets as "Number of good
packets received by the interface".

The SZ_* buckets also include frames with a bad FCS. The v5 changelog
says: "remove rx_crc, rx_symbol_err from rx_packets, as they are already
counted in SZ_* buckets".

So when a link partner sends a runt, jabber, oversized or bad-FCS frame,
it shows up in both rx_packets and rx_errors. ocelot and lan966x use a
similar formula.

Would the RX_UC, RX_MC and RX_BC good frame counters, which already feed
FramesReceivedOK, be a better source here?

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
> +
> +	stats->rx_length_errors = c[SCNT_RX_JABBER] +
> +				  c[SCNT_RX_LONG] +
> +				  c[SCNT_RX_PMAC_JABBER] +
> +				  c[SCNT_RX_PMAC_LONG];

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip.com
