Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1537E5EC;
	Wed, 30 Sep 2026 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738383; cv=none; b=JeL5tAPYmUvp6L8iy4ZvNgMvmtPXsK1gLCV10hwS5A+JvMHdQEv8BmIO1MPMCw+3DuNSxmGQT/2dk7O3026Jk35f2zXnNf//ojdMLEeHWyZVOgH8wZeDxGACx91cFKREiJen1qF867MK8g4I8JNGNX/yvS4qPwh8lewSwntIK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738383; c=relaxed/simple;
	bh=VE+UwdQB1HMi8eRvhiMZwf/N0gBu9NchywSLaXL8H9M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZRdKgsvYt+w7TQlhX32NEBzJ2g0O8rb+5WlOzb7voDccEC5FSCiHe6b4lEj9vJD7uxDfw4gYCbDM0GWygCLsioHHkCTXaJ20cj+lYvYZtqN0zx0lZy/mZQgp8eQNMnNS5hzUKVwYSnoFOdLqUkPJrDZO+3GbuhIcfkpgRuawdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osRm060L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osRm060L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCBA1F00893;
	Wed, 30 Sep 2026 03:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790738382;
	bh=DNuYL3APRDBCU29688kDrORwFGj4p3bHGS3SvDfi6EU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=osRm060Lz12mRzcXb6747m+gZvuZ/kQFLmKE5VH6gBlK5KSjX0l12EhnMhh/mZopM
	 r18cjDM5XYKoNSuAwmJVxn1vkyFFkwJGBIsOKGNjeU8TwxvE1PZ6LEwnaK43B1Agxd
	 AYLc11aV7PB/9IeYxBW0tL9D0xtifno+LeQgg5MLjp7NyNjejZJHtqgiV4gmBk8b55
	 ikG5+vJJSqdDZwUHqYDQxT72QzS/mOS7ZFL12x1dHGZLb+nfFcAx/qKTIVOytLGuRE
	 1F04q6vuL3klZKIRzR3Wk/s37elml1Y2Nt/JIBXJvJH6WM1WgIdGJdaVDwEy5O4OSP
	 ub19+5vpelytA==
Subject: Re: [PATCH net-next 6/6] net: dsa: motorcomm: Add broadcast/multicast
 policers via tc police
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 03:19:41 +0000
Message-ID: <179073838123.434549.279584713987633269@kernel.org>
In-Reply-To: <20260926211813.935723-7-mmyangfl@gmail.com>
References: <20260926211813.935723-7-mmyangfl@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 6 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: dsa: motorcomm: cbs calculation erroneously scales burst
  capacity by time
- [Medium] A flower rule that matches a broadcast or multicast dst_mac
  and also a src_mac is still sent to the per-port storm policer, and…
- [Medium] Flower rules offloaded to a storm policer never report
  hardware statistics.
- [Medium] The storm policer bypasses tc priority, and the silent -ENOSPC
  fallback means hardware can police the same frames twice.
- [Medium] yt921x_chip_setup() now writes YT921X_STORM_UNK_MCAST with
  every port bit set (YT921X_STORM_UNK_MCAST_PORTS_M) on every probe.
- [Medium] yt921x_marker_tfm_storm() computes cir = div_u64(slot_ns *
  rate, NSEC_PER_SEC) and cbs = div_u64(slot_ns * burst, NSEC_PER_SEC)…
- [Medium] A non-skip_sw rule with two police actions and a plain
  bcast/mcast dst_mac is installed as a single-rate storm policer, and…
- [Low] yt921x_storm_add() takes a struct netlink_ext_ack *extack that it
  never uses.
- [Low] yt921x_chip_setup_tc() programs YT921X_STORM_SLOT with the
  constant YT921X_STORM_SLOT_DEF (100) and interprets it as `ctrl * 10 *…
- [Low] In yt921x_acl_rule_ext_parse_flow_entries(), `static const u8
  mcast_addr[ETH_ALEN] = {0x01};` is passed to…

--

net: dsa: motorcomm: Add broadcast/multicast policers via tc police

This patch recognizes tc flower filters that match a broadcast or
multicast destination MAC and carry a police action. It offloads them
onto the per-port storm control blocks instead of an ACL rule with a
meter. It also programs the storm slot register at setup and tracks the
owning cookie per port and storm type.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 0405f1441f2ba..fb2514e01f919 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -2676,6 +2676,12 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
>  		return res;
>  	priv->port_shape_slot_ns = ctrl * op_ns;
>  
> +	ctrl = YT921X_STORM_SLOT_DEF;
> +	res = yt921x_reg_write(priv, YT921X_STORM_SLOT, ctrl);
> +	if (res)
> +		return res;
> +	priv->storm_slot_ns = ctrl * 10 * NSEC_PER_USEC;

[Severity: Low]
Is a 10 us tick the right unit for YT921X_STORM_SLOT?

The other two slot registers set up earlier in yt921x_chip_setup_tc()
are scaled by the core clock and clamped to a minimum:

	op_ns = 8 * priv->cycle_ns;

	ctrl = max(priv->meter_slot_ns / op_ns, YT921X_METER_SLOT_MIN);
	res = yt921x_reg_write(priv, YT921X_METER_SLOT, ctrl);
	...
	priv->meter_slot_ns = ctrl * op_ns;

YT921X_STORM_SLOT (0x220100) sits next to YT921X_METER_SLOT (0x220104)
and has the same GENMASK(11, 0) field. Here, though, it gets a fixed,
clock-independent time base and no minimum clamp.

If the storm slot is clocked like the others, then with an 8 ns cycle
storm_slot_ns would be 100 * 8 * 8 ns = 6.4 us, not 1 ms. Every CIR/CBS
computed in yt921x_marker_tfm_storm() would then be off by about 150x.

Could a comment or datasheet reference explain the different unit?

> @@ -2781,6 +2787,11 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
>  	if (res)
>  		return res;
>  
> +	res = yt921x_reg_write(priv, YT921X_STORM_UNK_MCAST,
> +			       YT921X_STORM_UNK_MCAST_PORTS_M);
> +	if (res)
> +		return res;

[Severity: Medium]
What does YT921X_STORM_UNK_MCAST select? This sets every port bit on
each probe, and neither the commit message nor a comment says what that
changes. The commit message also doesn't mention the YT921X_STORM_SLOT
write in yt921x_chip_setup_tc().

A related question is how the multicast storm class lines up with the
software filter. yt921x_acl_rule_ext_parse_flow_entries() maps the
group-bit match onto the MCAST class:

	} else if (ether_addr_equal(match.mask->dst, mcast_addr) &&
		   is_multicast_ether_addr(match.key->dst)) {
		ruleext->storm_type = YT921X_STORM_MCAST;

In software, dst_mac 01:00:00:00:00:00/01:00:00:00:00:00 also matches
broadcast frames. In hardware, broadcast has its own storm block
(YT921X_STORM_CTRLnm() type 0 vs type 1). Depending on UNK_MCAST, the
multicast block may also cover only unknown multicast.

Could the hardware MCAST policer then police a different set of frames
than the software filter, for example leaving out broadcast or known
multicast?

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 05d4a5957af95..3a0c6e0fbc52e 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c
> @@ -182,6 +182,41 @@ yt921x_marker_tfm_shape(struct yt921x_marker *marker, u64 rate, u64 burst,
>  				 priv, port, extack);
>  }
>  
> +static int
> +yt921x_marker_tfm_storm(struct yt921x_marker *marker,
> +			const struct flow_action_police *police,
> +			struct yt921x_priv *priv, int port)
> +{

[ ... ]

> +	/* 1 token = 1 rate */
> +	cir = div_u64(slot_ns * rate, NSEC_PER_SEC);
> +	if (cir > YT921X_STORM_CIR_MAX)
> +		return -ERANGE;
> +	cbs = div_u64(slot_ns * burst, NSEC_PER_SEC);
> +	if (cbs > YT921X_STORM_CBS_MAX)
> +		return -ERANGE;

[Severity: High]
Why is the burst scaled by the slot length here?

burst is a bucket capacity in bytes, or in packets in pkt_mode. It is
not a rate. Multiplying it by slot_ns / NSEC_PER_SEC treats it as if
it were bytes per second.

With storm_slot_ns = 1 ms, this divides the configured burst by 1000.
Take the example from the commit message:

  police rate 8mbit burst 64k

That gives cbs = 65. The cir calculation just above implies that one
token is one byte. If so, the hardware bucket holds 65 bytes, which is
smaller than a minimum-size Ethernet frame.

Wouldn't that drop almost every broadcast or multicast frame on the
port, instead of allowing the configured 64k burst? pkt_mode has the
same problem, because the extra factor of 1024 is applied to both rate
and burst.

The meter path does not do this. In yt921x_marker_tfm(), only the rate
goes through rate2token() with slot_ns. The burst is converted with
burst2token(burst, unit, C) and no slot scaling.

On the other hand, if CBS really is in bytes, YT921X_STORM_CBS_MAX
limits the bucket to 1023 bytes. That cannot hold a full-size frame
either. Dropping the slot scaling would then make the -ERANGE check
reject most realistic bursts, so these filters would always fall back
to the ACL meter.

Could you say what unit the CBS field of YT921X_STORM_CTRLnm() uses,
and how a byte or packet burst should map onto it?

[Severity: Medium]
What happens when cir or cbs rounds down to zero here?

With storm_slot_ns = 1 ms, a byte-mode rate under 1000 B/s (for example
police rate 4kbit) gives cir = 0. A burst under 1000 bytes gives
cbs = 0.

Only the upper bounds are checked, so marker_storm_set becomes true.
yt921x_storm_add() then writes YT921X_STORM_CTRL_EN with a CIR or CBS of
zero.

Wouldn't that block nearly all broadcast or multicast traffic on the
port? Software police with the same parameters still passes traffic at
the configured rate.

The meter path in yt921x_marker_tfm() clamps these values:

	m.cir = rate2token(rate, slot_ns, m.unit, C);
	if (!m.cir)
		m.cir = 1;
	...
	m.cbs = burst2token(burst, m.unit, C);
	if (!m.cbs)
		m.cbs = 1;

That path also warns when the burst is smaller than one frame. Should
the storm path clamp, warn, or fall back to the ACL meter in the same
way?

[ ... ]

> @@ -684,21 +735,40 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,

[ ... ]

>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> +		static const u8 mcast_addr[ETH_ALEN] = {0x01};

[Severity: Low]
This isn't a bug, but mcast_addr is later passed to ether_addr_equal().
include/linux/etherdevice.h says both addresses must be u16 aligned, and
a plain u8[6] only guarantees byte alignment.

Would static const u8 mcast_addr[ETH_ALEN] __aligned(2) work here? Or
ether_addr_equal_unaligned()?

>  		struct flow_match_eth_addrs match;
>  		u32 mask;
>  
>  		flow_rule_match_eth_addrs(rule, &match);
>  
> +		if (!ruleext->non_storm) {
> +			if (is_broadcast_ether_addr(match.mask->dst) &&
> +			    is_broadcast_ether_addr(match.key->dst)) {
> +				ruleext->storm_type = YT921X_STORM_BCAST;
> +				ruleext->storm_type_set = true;
> +			} else if (ether_addr_equal(match.mask->dst, mcast_addr) &&
> +				   is_multicast_ether_addr(match.key->dst)) {
> +				ruleext->storm_type = YT921X_STORM_MCAST;
> +				ruleext->storm_type_set = true;
> +			} else {
> +				ruleext->non_storm = true;
> +			}
> +		}

[Severity: Medium]
What happens to a src_mac match here? Storm eligibility is decided from
the dst MAC alone.

The source MAC entries built just below never set non_storm, unlike
every other match key in this function:

	mask = ethaddr_hi4_to_u32(match.mask->src);
	if (mask) {
		entry = yt921x_acl_entries_new(entries, &size,
					       YT921X_ACL_TYPE_MAC_SA0);
	...

The MAC_DA1_SA1 entry works the same way.

Take this filter:

  flower skip_sw dst_mac ff:ff:ff:ff:ff:ff src_mac 00:11:22:33:44:55 \
      action police rate 8mbit burst 64k

non_storm stays false. yt921x_flower_add() then installs the rule
through yt921x_storm_add(), and the ACL entries that carry the SA match
are never installed.

Wouldn't that rate-limit broadcast from every source on the port, with
no extack warning? For comparison, sja1105_flower_parse_key() rejects
this case with "Matching on source MAC not supported".

[ ... ]

> @@ -996,6 +1081,16 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
>  			if (res)
>  				return res;
>  
> +			if (!ruleext->non_storm) {
> +				res = yt921x_marker_tfm_storm(&ruleext->marker_storm,
> +							      police, priv,
> +							      port);
> +				if (!res)
> +					ruleext->marker_storm_set = true;
> +				else
> +					ruleext->non_storm = true;
> +			}

[Severity: Medium]
How does this work with a second police action? non_storm is set only
for actions other than FLOW_ACTION_POLICE:

	if (act->id != FLOW_ACTION_POLICE)
		ruleext->non_storm = true;

Take a rule without skip_sw that has a plain broadcast or multicast
dst_mac and two police actions. The first police action sets
marker_storm_set. The second hits:

	if (seen_police) {
		action[0] &= ~YT921X_ACL_ACTa_METER_EN;

		reason = "Multiple police actions";
		goto fallback;
	}

It then falls through to FLOW_ACTION_TRAP so that software can apply
both policers. But non_storm is still false.

yt921x_flower_add() therefore installs only the first policer via
yt921x_storm_add() and returns 0. The trap action in ruleext->r.action
is dropped.

Doesn't that leave the second policer unenforced for frames forwarded
in hardware?

[ ... ]

> @@ -1488,6 +1587,76 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  	return res;
>  }
>  

[ ... ]

> +static int
> +yt921x_storm_add(struct yt921x_priv *priv, int port, unsigned long cookie,
> +		 unsigned int type, const struct yt921x_marker *marker,
> +		 struct netlink_ext_ack *extack)

[Severity: Low]
This isn't a bug, but yt921x_storm_add() never uses extack, and
yt921x_marker_tfm_storm() doesn't take one. So the storm path never
reports the rate and burst it programs or warns about truncation. It
also says nothing when it falls back to an ACL on -ENOSPC.

yt921x_marker_tfm_police() still runs during parsing and can emit its
"Consider match rate X with burst at least Y" message. That value is
computed for the meter slot, though, not for the storm policer that
actually gets installed.

[ ... ]

> +static int
> +yt921x_flower_add(struct yt921x_priv *priv, int port,
> +		  const struct yt921x_acl_rule_ext *ruleext,
> +		  struct netlink_ext_ack *extack)
> +{
> +	int res;
> +
> +	if (!ruleext->non_storm && ruleext->marker_storm_set &&
> +	    ruleext->storm_type_set) {
> +		res = yt921x_storm_add(priv, port, ruleext->r.tag,
> +				       ruleext->storm_type,
> +				       &ruleext->marker_storm, extack);
> +		if (res != -ENOSPC)
> +			return res;
> +	}
> +
> +	return yt921x_acl_add(priv, ruleext, extack);
> +}

[Severity: Medium]
Does this keep tc priority semantics?

The storm register is port-wide and ignores cls->common.prio and any
installed ACL rules. In software, cls_flower stops at the first matching
filter, because police with conform pipe/ok returns >= 0 from
__tcf_classify().

Suppose two dst_mac ff:ff:ff:ff:ff:ff police filters are added on one
port with different prios. The first takes the storm slot. For the
second, yt921x_storm_add() returns -ENOSPC, and the filter is silently
installed as an ACL meter.

Would hardware then apply both the storm policer and the ACL meter to
the same broadcast frames? Software applies only the higher-priority
filter.

The commit message says this follows "the sja1105 broadcast/multicast
policer approach". sja1105 has only a broadcast policer, and
sja1105_setup_bcast_policer() rejects a second one instead of falling
back:

	NL_SET_ERR_MSG_MOD(extack,
			   "Port already has a broadcast policer");
	rc = -EEXIST;

> +
>  int
>  yt921x_dsa_cls_flower_stats(struct dsa_switch *ds, int port,
>  			    struct flow_cls_offload *cls, bool ingress)

[Severity: Medium]
Should yt921x_dsa_cls_flower_stats() be storm-aware as well? Add and
delete now go through yt921x_flower_add() and yt921x_flower_del(), but
stats still calls yt921x_acl_stat() directly:

	res = yt921x_acl_stat(priv, TC_SETUP_CLSFLOWER, cls->cookie,
			      &cls->stats);

A storm-offloaded cookie exists only in pp->storm_tags[] and has no ACL
rule. So yt921x_acl_find() returns UINT_MAX and yt921x_acl_stat()
returns -ENOENT.

fl_hw_update_stats() ignores the error, so tc -s filter show never
shows hardware counters for these filters.

The patch also adds YT921X_STORM_STATnm() in tc.h, but nothing reads
it. Was it meant to be used here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926211813.935723-1-mmyangfl%40gmail.com
