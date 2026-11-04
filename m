Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755764;
	b=k2rElfE4hrcGPIvinS0NjpBIgesfeYgrDmMpakpcd9VFFWr5q49qmhmKrlKby/LiQjo+
	 1XLYGgUCwIddTiRzLEZQIXn2xPgaMYkKFVJpTGmCPRImcF65g86CedvmyfbgAvNQljhAx
	 Znej//D2dsvlyTQuGypG62WWYdWBE1Utg2K++JBmmcmY1dGZCRyW6RbvJBZ0Lo1lPerb3
	 uq+szBoM93nyQZnbuaQi1uiRqzeds5+RL4EoDh2aPfH3hwKUJ1VV4ZNsWXYqgrAXndB/M
	 o7bXm3CDsX6e/gypiLIIqSb1/42Lh42ENTLnCs+7aAb5SHV9dC3Ah+sTkmBpRhPBkmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755764;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7YNjFeSZLRe8iuNqdLIZAFL9s0rXyoUr/FeoHtfoBoo=;
	b=2kYyOAOCL0DIoyu/tfJU+kuHEGXlKf1qk0h368RuGT5f1hALb50AGn1KceAqrTbG1iHI
	 mLhpOG0sbNFgxWnEX/6ssspAO5ebbnNns1U24ep0hFFCIL8lbc4fWFXJleuTMcJSqc4ym
	 m8nr2p4qejBBk7nbdd+D0hJnC2vebftiev53hiuykZzpojuwyCwb/VVTg7M5owV1fixv8
	 Cn+lwNdSElbgpckF0Ay1NncPpKayAz4Wt3HiZjgJ/SI6n3sEHTvDdmymrUMml5/ewM6Ke
	 N5zgSyC82nfWxkqzE8SsUr8BOATjEzOmEQxGxEqe7vd3gbm2spZwfiR6KoEa4GKhm2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXGkOWfo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C9606A33E;
	Wed,  4 Nov 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXGkOWfo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF1E1F00A15;
	Wed,  4 Nov 2026 01:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793755763;
	bh=7YNjFeSZLRe8iuNqdLIZAFL9s0rXyoUr/FeoHtfoBoo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lXGkOWfoAnGynFjfY3Q8Vg6xBtRq/37wMwSC6tlE+w/Zmz1+flXb+1Q6Ev6nPk0U8
	 MbTndQlkMjNGU8Un9CtSzse0BcVi8OoL7YEIPWEg4JJu9XCz1aUgNZny43HZB9gRz6
	 T6cZvUhaJasd3GytSeo6Jt0luRcZlHS23XCm10rzYGBP8FH9pTYYJcQSAKb2wQQzhd
	 qGldGeJGeoLwBD2Z7UanQuYjxBGaIghSOBxeMBE7DeRnqafun894csFljJ1LD/HOwJ
	 uwT1BhTu0gA8Xrff3lz1NyPGMRfFUwC9Vr5OYKa79tp5AxaWTcMfEAc6U5Q5a36Wb1
	 mbPyO4vb4pZhA==
Subject: Re: [PATCH net] net: stmmac: rebuild VLAN priority steering when
 filters change
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 piotrwejman90@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Nov 2026 01:29:22 +0000
Message-ID: <179375576232.488856.8160594272005799972@kernel.org>
In-Reply-To: <20261102-submit-stmmac-vlan-prio-v1-v1-1-2b37767e4e08@gmail.com>
References: <20261102-submit-stmmac-vlan-prio-v1-v1-1-2b37767e4e08@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tc_add_vlan_flow()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c:764-765) now runs `if…
- [High] tc_add_ethtype_flow() (stmmac_tc.c:801-871) can take over an in-
  use VLAN entry found by cookie.
- [Medium] The new check `tc >= priv->plat->rx_queues_to_use` in
  tc_add_vlan_flow() (stmmac_tc.c:748) runs only when a rule is inserted.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but VLAN-
  priority steering programmed into RXQ_CTRL2/3 (PSRQn) for tc-flower…
- [Medium] This problem wasn't introduced by this patch, but
  tc_add_ethtype_flow() (stmmac_tc.c:820) still checks only `tc < 0`…

--

net: stmmac: rebuild VLAN priority steering when filters change

This patch puts each VLAN tc-flower rule's priority on a new per-device
list. After every insert and delete, it rebuilds the full RX queue
priority masks from the platform assignments plus that list. It also
makes the GMAC4/XGMAC rx_queue_prio callbacks replace the target queue's
mask, and checks hw_tc against rx_queues_to_use in tc_add_vlan_flow().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 10b61fa2c27c5..6707f7621f3b8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -685,6 +687,41 @@ static struct stmmac_rfs_entry *tc_find_rfs(struct stmmac_priv *priv,
>  
>  #define VLAN_PRIO_FULL_MASK (0x07)
>  
> +static void tc_update_vlan_prio(struct stmmac_priv *priv, u8 prio)
> +{
> +	u8 prios[MTL_MAX_RX_QUEUES] = {};
> +	struct stmmac_rfs_entry *entry;
> +	unsigned int queue, i;
> +

[ ... ]

> +	list_for_each_entry(entry, &priv->vlan_prio, vlan_node) {
> +		for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++)
> +			prios[queue] &= ~entry->vlan_prio;
> +		prios[entry->tc] |= entry->vlan_prio;
> +	}

[Severity: Medium]
The tc >= rx_queues_to_use check in tc_add_vlan_flow() only runs when a
rule is inserted. What happens to an installed rule after ethtool -L
reduces the RX queue count?

stmmac_reinit_queues() does:

	priv->plat->rx_queues_to_use = rx_cnt;

It does not revalidate or remove the installed VLAN rules. Take a rule
installed with hw_tc N, then run ethtool -L with rx <= N. On the next
unrelated VLAN rule add or delete, this loop clears that rule's
vlan_prio from every active queue. It then sets the bit in
prios[entry->tc], which neither programming loop below reaches, since
both stop at rx_queues_to_use.

Does that leave the PCP mapped to no RX queue at all? That would
override both the platform rx_queues_cfg[].prio assignment and any older
rule. There is no out-of-bounds access, because entry->tc is still below
the old rx_queues_to_use.

The commit message says "Validate the selected RX queue before indexing
the masks", but that only holds at insertion time.

> +
> +	/* Install the new assignment before clearing the previous queue. */
> +	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++)
> +		if (prios[queue] & prio)
> +			stmmac_rx_queue_prio(priv, priv->hw, prios[queue], queue);
> +	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++)
> +		if (!(prios[queue] & prio))
> +			stmmac_rx_queue_prio(priv, priv->hw, prios[queue], queue);
> +}

[Severity: Medium]
This isn't a bug introduced by this patch, but is the VLAN priority
steering programmed here lost every time stmmac_hw_setup() runs?

stmmac_hw_setup() runs on stmmac_open(), on resume, and on the ethtool
-L/-G reinit path. stmmac_init_dma_engine() calls stmmac_reset(), which
clears RXQ_CTRL2/3. After that, stmmac_mtl_configuration() calls
stmmac_mac_config_rx_queues_prio(), which only reprograms the platform
masks:

	for (queue = 0; queue < rx_queues_count; queue++) {
		if (!priv->plat->rx_queues_cfg[queue].use_prio)
			continue;

		prio = priv->plat->rx_queues_cfg[queue].prio;
		stmmac_rx_queue_prio(priv, priv->hw, prio, queue);
	}

priv->vlan_prio is never replayed there. Software still treats those
rules as installed, while the hardware steers by the platform defaults.

With this patch, the lost rules only come back as a side effect of the
next unrelated VLAN rule add or delete. A rule added while the interface
is down is wiped by the next open.

Could stmmac_mtl_configuration() use the new list to restore the rules
after a reset?

> +
>  static int tc_add_vlan_flow(struct stmmac_priv *priv,
>  			    struct flow_cls_offload *cls)
>  {

[ ... ]

> @@ -708,7 +745,7 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
>  	if (!dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_VLAN))
>  		return -EINVAL;
>  
> -	if (tc < 0) {
> +	if (tc < 0 || tc >= priv->plat->rx_queues_to_use) {
>  		netdev_err(priv->dev, "Invalid traffic class\n");
>  		return -EINVAL;
>  	}

[Severity: Medium]
This is a pre-existing issue, but tc_add_ethtype_flow() still only
checks tc < 0 before it uses tc as the RX queue:

	if (tc < 0) {
		netdev_err(priv->dev, "Invalid traffic class\n");
		return -EINVAL;
	}
	...
	stmmac_rx_queue_routing(priv, priv->hw,
				PACKET_DCBCPQ, tc);

The same point about tc_classid_to_hwtc() only bounding by
netdev_get_num_tc() applies there. Can an LLDP or PTP rule with
hw_tc >= rx_queues_to_use send those frames to an RX queue that isn't
enabled, so they are never received?

Should tc_add_ethtype_flow() get the same bound?

> @@ -724,13 +761,18 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
>  		}
>  
>  		prio = BIT(match.key->vlan_priority);
> -		stmmac_rx_queue_prio(priv, priv->hw, prio, tc);
> +		if (entry->in_use)
> +			list_del(&entry->vlan_node);
> +		else
> +			priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN]++;

[Severity: High]
Can this list_del() run on an entry that was never linked on
priv->vlan_prio?

tc_find_rfs() matches on cookie only:

	if (entry->cookie == cls->cookie)
		return entry;

So the entry returned here can be an in-use LLDP or 1588 entry.

tc_add_flow_cls() falls through to tc_add_vlan_flow() whenever
tc_add_ethtype_flow() fails. For an LLDP cookie that is already
installed, tc_add_ethtype_flow() returns -ENOENT because the entry
counts against itself:

	case ETH_P_LLDP:
		if (priv->rfs_entries_cnt[STMMAC_RFS_T_LLDP] >=
		    priv->rfs_entries_max[STMMAC_RFS_T_LLDP])
			return -ENOENT;

An LLDP/1588 entry's vlan_node is either still zeroed from
devm_kcalloc() in tc_rfs_init(), or holds LIST_POISON1/2 if
tc_del_vlan_flow() released the slot earlier. In both cases __list_del()
writes through a NULL or poison pointer here, with rtnl held.

One way to reach this with CAP_NET_ADMIN:

1) Bind a shared ingress block to eth0 and to a second device.

2) Add "protocol 802.1Q flower vlan_prio 3 vlan_ethtype 0x88cc hw_tc 1"
   to the block. tc_add_flow() fails, and tc_add_ethtype_flow() installs
   the rule as an LLDP entry with cookie C.

3) Run "ethtool -K eth0 hw-tc-offload off". "rxhash on" also works,
   since tc_setup_cls() then returns -EBUSY.

4) Run "tc qdisc del dev eth0 ingress". FLOW_CLS_DESTROY fails in
   stmmac_setup_tc_block_cb(), and tcf_block_playback_offloads()
   ignores errors on removal. The LLDP entry stays in use with
   cookie C.

5) Turn hw-tc-offload back on and re-bind the block. fl_reoffload()
   replays FLOW_CLS_REPLACE with cookie C. tc_add_ethtype_flow()
   returns -ENOENT, and tc_add_vlan_flow() reaches this list_del() with
   entry->in_use set.

tc_del_vlan_flow() checks entry->type != STMMAC_RFS_T_VLAN before its
list_del(), but the add path doesn't. Should the entry only be unlinked
and reused when entry->type == STMMAC_RFS_T_VLAN, with the request
rejected otherwise?

The commit message says "Reoffloading an existing cookie reuses its
entry without incrementing the rule count", but that only covers
reoffloading a VLAN cookie as VLAN. Before this patch the same type mixup
only threw off the counters.

>  
>  		entry->in_use = true;
>  		entry->cookie = cls->cookie;
>  		entry->tc = tc;
>  		entry->type = STMMAC_RFS_T_VLAN;
> -		priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN]++;
> +		entry->vlan_prio = prio;
> +		list_add_tail(&entry->vlan_node, &priv->vlan_prio);
> +		tc_update_vlan_prio(priv, entry->vlan_prio);
>  	}

[Severity: High]
Can a VLAN entry stay linked on priv->vlan_prio after it has been
re-typed to LLDP or 1588?

tc_add_ethtype_flow() can also take over an in-use entry found by
cookie, including a VLAN rule that is linked here. It overwrites
entry->type and entry->tc but never calls list_del(&entry->vlan_node):

	entry->type = STMMAC_RFS_T_LLDP;
	priv->rfs_entries_cnt[STMMAC_RFS_T_LLDP]++;
	...
	entry->in_use = true;
	entry->cookie = cls->cookie;
	entry->tc = tc;

Later, tc_del_ethtype_flow() frees the slot (in_use = false,
cookie = 0) while vlan_node is still linked. It also never decrements
rfs_entries_cnt[STMMAC_RFS_T_VLAN].

The next VLAN rule that gets that slot from tc_find_rfs(priv, cls, true)
takes the !in_use branch. It then calls list_add_tail() on a node that
is already on the list.

Depending on the list layout, the node either ends up pointing to
itself, or other nodes drop out of the list and a later list_del()
leaves a self-loop. Would list_for_each_entry() in tc_update_vlan_prio()
then loop forever with rtnl held?

The same stale-cookie mechanism as above gets here:

1) Install LLDP rule L.

2) Install R = "protocol 802.1Q flower vlan_prio 3 vlan_ethtype 0x88cc
   hw_tc 2". The LLDP slot is full, so R becomes a VLAN entry.

3) Delete L.

4) Make R's entry stale with hw-tc-offload off plus unbind, then turn
   it back on and re-bind. fl_reoffload() replays R, and
   tc_add_ethtype_flow() re-types the linked VLAN entry.

5) Delete R.

6) Add VLAN rules until one of them reuses that slot.

While a re-typed entry is on the list, tc_update_vlan_prio() also does:

	prios[entry->tc] |= entry->vlan_prio;

prios[] is a u8 [MTL_MAX_RX_QUEUES] array, and tc_add_ethtype_flow()
only checks tc < 0. Suppose a new LLDP/1588 filter takes a stale VLAN
cookie (a freed filter address reused by slab) with hw_tc >= 8. That
needs num_tc > 8, for example taprio with overlapping TXQs. Could this
then write past the end of prios[]?

Should tc_add_ethtype_flow() unlink a VLAN entry before re-typing it,
or refuse to take over an entry of a different type?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102-submit-stmmac-vlan-prio-v1-v1-1-2b37767e4e08%40gmail.com
