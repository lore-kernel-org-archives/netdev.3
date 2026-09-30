Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B600379C50;
	Wed, 30 Sep 2026 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738383; cv=none; b=pmEuHqoFXzNr4tFp/EZ5CdAWLsoe2NNGRuofey4nbtdyalF+p2BqpGZRL5cKWqbmhd8xieWWl5pEI2nz0Avjdae6NjOWYCgrThOn7bA4G6REdn45D1/vvOCErohoyBhBNej0WJeqjicogKjENxdtnMytL8+a3850nXQugIQ9Ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738383; c=relaxed/simple;
	bh=7WqqcVhSuAoMzArz5mYEAXk0EKLMU8zi6cZzKPYhKJE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iLhZJ4UAwGTep7Dr/JiERJB6FKrkpNJdvAkF6t65Sw4eg8l2ntMV9wzBKCzfFBSigNL9Lq65MOjL98WrL+d/fqlkXMK8dHwAJpmDI9Hkjuk1ERUUZIJ0DW+oaH7eQTlDE+fStvxKJ0lTtpo3S55JUka5hp56vIeb+s349Ows3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/ddrxcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/ddrxcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF381F000FF;
	Wed, 30 Sep 2026 03:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790738381;
	bh=iOINwDu40ZZ2qaGpo2z1OlZ4gODP7cITwaeqVb5CEis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D/ddrxcQGLLATSLBseTeJFg4aHM2YZ8NEqgFqJkxUjcSWn2L8IRb+cJLY1U5bWD+0
	 YiujfrpKpIYtyNeMkTTG47f7kRsDGmr34/Vi2Gn0iucw4ZnFeJPIiwOIpQo5E4+XFE
	 LquH6qpZDUKmJ+HFiSmgqpIkELap+WFeJMB/6MjSIpJBdhhldHPZBFnr0CkU7jjRUR
	 sPgtFXJ9NhI6VnBcUWX1lWBpzXHgSg4QRXrrKGye67ymWYhlGMRp+kxY3E3X9f1UvH
	 fDJCCIujmh6QDMzI05XFgH57o9YCphS/WCW8ym7lnghH+wRjfbT3UjrGmAcACkhG8N
	 jtoAhTrOoFpxA==
Subject: Re: [PATCH net-next 5/6] net: dsa: motorcomm: Add limited ACL flow
 statistics support
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 03:19:40 +0000
Message-ID: <179073838013.434549.10766466901438945717@kernel.org>
In-Reply-To: <20260926211813.935723-6-mmyangfl@gmail.com>
References: <20260926211813.935723-6-mmyangfl@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] yt921x_acl_add() (drivers/net/dsa/motorcomm/tc.c:1355-1357) is
  meant to detect whether a rule already has a trap action.
- [Medium] yt921x_dsa_cls_flower_stats() (tc.c:1492) ignores its `port`
  argument.
- [Medium] The patch adds hardware flow statistics for flower rules but
  ignores the per-action hw_stats type the user requested.
- [Medium] yt921x_acl_stat() (tc.c:1177-1179) always passes `jiffies` as
  `lastused` to flow_stats_update(), even when the counter did not…
- [Low] Flow counter slots are released only in the software bitmap,
  without regard to hardware state.

--

net: dsa: motorcomm: Add limited ACL flow statistics support

This commit adds .cls_flower_stats() support to the yt921x driver using
the switch's 64 hardware flow counters. At add time, each flower ACL rule
gets a packet-mode counter, except software-assisted trap rules. The
counter is read back and reported as a delta through flow_stats_update().

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index d919743d89c17..05d4a5957af95 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c

[ ... ]

> @@ -1138,6 +1141,45 @@ yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
>  	return UINT_MAX;
>  }
>  
> +static int
> +yt921x_acl_stat(struct yt921x_priv *priv, enum tc_setup_type type,
> +		unsigned long tag, struct flow_stats *stats)
> +{

[ ... ]

> +	diff = stat - aclrule->laststat;
> +	aclrule->laststat = stat;
> +	flow_stats_update(stats, aclrule->stat_pkt_mode ? 0 : diff,
> +			  !aclrule->stat_pkt_mode ? 0 : diff, 0,
> +			  jiffies, FLOW_ACTION_HW_STATS_IMMEDIATE);

[Severity: Medium]
Should lastused be set to jiffies even when diff is 0?

flow_stats_update() updates lastused whatever the packet and byte
deltas are:

include/net/flow_offload.h:flow_stats_update() {
    ...
	flow_stats->lastused	= max_t(u64, flow_stats->lastused, lastused);
    ...
}

tcf_gact_stats_update() then copies that into tm->lastuse. As a result,
every offloaded rule with a counter looks just used on every stats
poll, and tc -s filter show always reports it that way.

Userspace that ages out idle offloaded flows by tc lastuse, such as the
OVS tc-offload revalidator, would never see these flows as idle.
sja1105_vl.c has the same pattern. The "Align with sja1105" comment only
covers stat_pkt_mode.

Could jiffies be passed only when diff is non-zero?

> +	return 0;
> +}

[ ... ]

> @@ -1270,9 +1312,13 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
>  	}
>  
>  	if (aclrule->action[0] & YT921X_ACL_ACTa_METER_EN)
> -		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
> -				    aclrule->action[0]),
> -			  priv->meters_map);
> +		__clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
> +				      aclrule->action[0]),
> +			    priv->meters_map);
> +	if (aclrule->action[0] & YT921X_ACL_ACTa_FLOWSTAT_EN)
> +		__clear_bit(FIELD_GET(YT921X_ACL_ACTa_FLOWSTAT_ID_M,
> +				      aclrule->action[0]),
> +			    priv->flowstats_map);

[Severity: Low]
Can a statid be reused while the hardware still references it?

Earlier in yt921x_acl_del(), the commit result is saved, but a failure
does not stop the resources from being released:

	aclblk->rules[binid] = NULL;
	ret = yt921x_acl_commit(priv, entid, aclrule->mask);
	/* the kernel never rolls back on failure */

Suppose the first write in yt921x_acl_commit(),
yt921x_reg96_write(YT921X_ACLn_ACT(entid), zeros), fails on a bus error.
The old ACT word with FLOWSTAT_EN | FLOWSTAT_ID(statid), plus the
entry's key and mask, stay live in hardware.

The statid is still cleared here. The next yt921x_acl_add() can then
pick it with find_first_zero_bit(), zero the counter and set
laststat = 0. Hits on the orphaned entry would then show up in the new
rule's stats.

Also, YT921X_FLOWSTATn_CTRL(statid) is never cleared, either here or on
the yt921x_acl_add() error paths after the CTRL write. Those paths are
a STAT zeroing failure, a kvzalloc_obj() or kvmemdup() failure, and a
yt921x_acl_commit() failure. Is it intended to leave those counters
armed while flowstats_map treats them as free?

This needs a bus failure to trigger. The same pattern already exists
for meters and ACL slots.

>  	priv->acl_masks[blkid] &= ~aclrule->mask;
>  	kvfree(aclrule);

[ ... ]

> @@ -1305,6 +1352,10 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  	if (entid == UINT_MAX)
>  		return -EOPNOTSUPP;
>  
> +	use_trap = (ruleext->r.action[2] & YT921X_ACL_ACTc_FWD_EN) &&
> +		   (FIELD_GET(YT921X_ACL_ACTc_FWD_M,
> +			      ruleext->r.action[2]) == YT921X_ACL_ACTc_FWD_TRAP);

[Severity: Medium]
Can this comparison ever be true? The definitions are:

drivers/net/dsa/motorcomm/tc.h:
#define  YT921X_ACL_ACTc_FWD_M			GENMASK(22, 21)
#define   YT921X_ACL_ACTc_FWD(x)			FIELD_PREP(YT921X_ACL_ACTc_FWD_M, (x))
...
#define   YT921X_ACL_ACTc_FWD_TRAP			YT921X_ACL_ACTc_FWD(3)

FIELD_GET() returns a value in 0..3, but YT921X_ACL_ACTc_FWD_TRAP is
the shifted value 0x600000.

That would leave use_trap false for explicit FLOW_ACTION_TRAP rules. It
would also be false for rules that fell back to trap in
yt921x_acl_rule_ext_parse_flow_action(). Only the meter exhaustion path
further down sets it.

The new check below then goes to the else branch for software-assisted
trap rules:

	if (ruleext->r.sw_assisted && use_trap) {
		statid = YT921X_FLOWSTAT_NUM;
	} else {
		statid = find_first_zero_bit(priv->flowstats_map,

So these rules get a hardware counter, which is the case the patch
meant to exclude. The software flower filter also counts the trapped
packets, so tc stats count them twice. The rules also use up counters
from the 64-entry pool.

Would comparing the masked value work instead?

	(ruleext->r.action[2] & YT921X_ACL_ACTc_FWD_M) == YT921X_ACL_ACTc_FWD_TRAP

> +
>  	if (!(ruleext->r.action[0] & YT921X_ACL_ACTa_METER_EN)) {
>  		meterid = YT921X_METER_NUM;
>  	} else {

[ ... ]

> @@ -1336,6 +1387,35 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  			return res;
>  	}
>  
> +	if (ruleext->r.sw_assisted && use_trap) {
> +		statid = YT921X_FLOWSTAT_NUM;
> +	} else {
> +		statid = find_first_zero_bit(priv->flowstats_map,
> +					     YT921X_FLOWSTAT_NUM);
> +		if (statid >= YT921X_FLOWSTAT_NUM) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "No more flowstats, HW stats disabled");
> +		} else {

[Severity: Medium]
Should the per-action hw_stats type be checked here?

tc_setup_action() copies the requested type into each action entry:

	entry[k].hw_stats = tc_act_hw_stats(act->hw_stats);

Nothing under drivers/net/dsa/motorcomm/ reads act->hw_stats or calls
flow_action_hw_stats_check() or flow_action_basic_hw_stats_check().
Drivers such as ocelot, sparx5, lan966x, bnxt and mlx5 do. This has
three effects.

A rule added with "hw_stats disabled" still takes a counter from the
64-entry flowstats_map. There are 384 ACL entries, so such rules can use
up the pool and leave later rules that want stats with none.

A rule that explicitly asks for "hw_stats immediate" is still accepted
when the pool is empty. Only the extack message is set, and 0 is
returned. Later stats queries get -EOPNOTSUPP from yt921x_acl_stat(),
which the core ignores, so the user sees no stats and no error.

yt921x_acl_stat() always reports FLOW_ACTION_HW_STATS_IMMEDIATE, even
for "hw_stats delayed" requests.

The commit message says:

    As there is no interface for statistics preference for now, we pick
    one on our own initiative.

That covers byte vs packet mode. The enabled, disabled, immediate and
delayed preference does exist in the uAPI.

Could the driver reject unsupported hw_stats types and skip counter
allocation when stats are disabled?

> +			u32 zeros[2] = {};

[ ... ]

> @@ -1403,6 +1488,21 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  	return res;
>  }
>  
> +int
> +yt921x_dsa_cls_flower_stats(struct dsa_switch *ds, int port,
> +			    struct flow_cls_offload *cls, bool ingress)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_acl_stat(priv, TC_SETUP_CLSFLOWER, cls->cookie,
> +			      &cls->stats);

[Severity: Medium]
What happens when a shared block offloads the same filter on several
ports?

The port argument is dropped here. yt921x_acl_find() matches only on
tag and type and returns the first match:

	if (aclblk->rules[i] && aclblk->rules[i]->tag == tag &&
	    aclblk->rules[i]->type == type)
		return YT921X_ACL_ENT_PER_BLK * blkid + i;

For example:

    tc qdisc add dev swpA ingress_block 1 clsact
    tc qdisc add dev swpB ingress_block 1 clsact
    tc filter add block 1 flower ... skip_sw

yt921x_acl_rule_ext_parse_flow() creates one ACL rule per port, with
SPORTS = BIT(port) and tag == (unsigned long)f. Each rule has its own
flowstat counter. fl_hw_update_stats() -> tc_setup_cb_call() then calls
each port's callback with the same cookie.

Each of those calls finds the same first rule. The first call reports
its delta and updates laststat, and the later calls report about zero.
The other ports' counters are never read, so their hits never reach
tc -s filter show.

Would matching on the port avoid losing those hits? The port is already
encoded in the SPORTS field of entries[0].key[1].

> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926211813.935723-1-mmyangfl%40gmail.com
