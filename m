Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628447CC8F;
	Mon, 28 Sep 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584737; cv=none; b=c7zQd/UueBT+MULNUZmFOZsUroaTuSNPs1lEXzCM/c4X9NL4E7Jwr2nSy/uT6fU9xIYrlhk5o7PfvGqaVmJwLiObplGSef4hW0ZyiSdvahQK9+dP44Cm9ToTp/usnPUjmIK1ysY4trb4i9QB464jbpV0/DpTu5/2bL3kPqKfWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584737; c=relaxed/simple;
	bh=EBPcN9KWybxhdzSpNIp3TIgZ5l1MmUwe+U71AToCPsM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmnHJDgEnUUYZuSN87bJhk6vHwz6AuVYZVPZg438sYX+3NeOse97C2Qn1GUJkcwVmdGeyuInJgF7d/BXKjgbcLkdo61Hl9Ub5PMqjQGOdG4D8g4gaMZjiutpnhyDJgeeKZHXHTW3mXEJ5YCFFu4smoWQkB96yckBE4+YkDig4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxzMNotK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxzMNotK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0357C1F000FF;
	Mon, 28 Sep 2026 08:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584735;
	bh=Fv489piPg0jiwdz6p0ErfmqTWCULsyB1QXHKw8+dJ0o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LxzMNotKEzADt6try8Aeq2J1zoLbBnK/xXJYryhMAguBuJOQ9zkUSl0c+qq/wotdV
	 hgj/soWobMAcTxYEw1BAwPajq9NMxDHKs0ekTucOVRg54Tq5SU7J+R7q0ZzqOZWddb
	 Xu3uv4H1rbrB00+xvzurYJzs22p5cYOObL7GtncwDb7ibQH+Omh5uxe6WiAbl7zh2h
	 RklbWnxiBZKsXWFsBwIZoHB9mGKde4oXIHSDWC6Of3aHv0xkxBAWChliOFaIxsHxkh
	 uA8rnycAc1MJ+8zjrUeC3QaQYRudd/jlyj/4sdQgfGise/XpgXEf1nGDaBzAX7gPjR
	 7SN9GmvHwrCxA==
Subject: Re: [PATCH v3 net-next] octeontx2-af: pass devlink switch id and
 cache representor map
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Mon, 28 Sep 2026 08:38:54 +0000
Message-ID: <179058473451.3145.9297107718800202799@kernel.org>
In-Reply-To: <20260924082614.1947742-1-rkannoth@marvell.com>
References: <20260924082614.1947742-1-rkannoth@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 (4) · Medium: 6 (3) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Turning off the eswitch now makes the AF forget the
  representor PF before that PF has freed its hardware resources.
- [Medium] struct esw_cfg_req grows from 32 bytes to 72 bytes:
  switch_id[MAX_PHYS_ITEM_ID_LEN] and switch_id_len are appended after…
- [Medium] The new call to rvu_rep_cache_reset() in __rvu_flr_handler()
  sets rep_mode = 0 when the representor PF goes through FLR.
- [Medium] The patch puts rep_pcifunc, rep_mode,
  rswitch.switch_id/switch_id_len, rep_cnt and rep2pfvf_map under…
- [Medium] Before this patch, rep_pcifunc was only ever set.
- [Medium] rvu_mbox_handler_esw_cfg() reads req->switch_id_len from the
  shared mailbox several times: once for the bounds check, once as the…
- [Low] The switch-id plumbing the commit message describes has no
  consumer.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  copies it into the new cached path and adds a second call site.
- [High] This problem wasn't introduced by this patch, but
  rvu_rep_destroy() calls kfree(rep->flow_cfg) after…
- [High] This problem wasn't introduced by this patch, but
  rvu_rep_get_stats64() schedules rep->stats_wrk with a 100 ms delay,…
- [High] This problem wasn't introduced by this patch, but the patch
  makes it worse.
- [Medium] This problem wasn't introduced by this patch, but failures of
  the ESW_CFG mailbox can still show up as a successful devlink mode…
- [Medium] This problem wasn't introduced by this patch, but each rep-
  mode rvu_switch_enable() -> rvu_rep_install_mcam_rules() allocates…
- [Medium] This problem wasn't introduced by this patch, but in
  rvu_rep_create(), if kzalloc_objs() for priv->reps fails after…

--

octeontx2-af: pass devlink switch id and cache representor map

This commit adds the representor devlink switch_id to the ESW_CFG
mailbox message and stores it in the AF. It builds rep2pfvf_map once on
GET_REP_CNT under rsrc_lock, resets that cache on eswitch disable and on
representor FLR, and adds rvu_sw_port_id() on top of a shared
representor index lookup.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index cece197d1074..45c03f9294a5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1788,6 +1788,8 @@ struct esw_cfg_req {
>  	struct mbox_msghdr hdr;
>  	u8 ena;
>  	u64 rsvd;
> +	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
> +	u8 switch_id_len;
>  };

[Severity: Medium]
The new fields are added after rsvd, so struct esw_cfg_req gets bigger,
but OTX2_MBOX_VERSION stays at 0x000a. What happens when a sender built
against the old layout sends a 32-byte ESW_CFG?

rvu_process_mbox_msg() only checks the signature:

	if (req->sig != OTX2_MBOX_REQ_SIG)
		goto bad_message;

Nothing checks msg->ver or the message length. In that case
rvu_mbox_handler_esw_cfg() reads switch_id_len and switch_id from
whatever follows in the shared mailbox region. Any stale value from 1 to
MAX_PHYS_ITEM_ID_LEN would then be stored as the switch ID.

Should the version be bumped, or should the new data reuse rsvd?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 30e148291581..aeb6b4917f45 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -2924,6 +2924,9 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
>  	if (rvu->mcs_blk_cnt)
>  		rvu_mcs_flr_handler(rvu, pcifunc);
>  
> +	if (is_rep_dev(rvu, pcifunc))
> +		rvu_rep_cache_reset(rvu);
> +

[Severity: Medium]
When the representor PF goes through FLR, this clears rep_mode. Does
anything tear down the rep-layout MCAM entries and the rswitch state
that rvu_switch_enable()->rvu_rep_install_mcam_rules() created?

Those entries are AF-owned, so the earlier
rvu_npc_free_mcam_entries(rvu, pcifunc, -1) in this handler does not
free them. rswitch->used_entries and entry2pcifunc also stay populated.

Later, nix_lf_start_rx/stop_rx from a represented PF/VF calls
rvu_switch_update_rules():

	if (rvu->rep_mode)
		return rvu_rep_update_rules(rvu, pcifunc, ena);

With rep_mode now 0, it takes the legacy path. That path picks the first
entry2pcifunc slot, which is a rep-layout RX slot, and writes a legacy
TX rule into it. Meanwhile the rep TX rules that force traffic to LBK
chan 63 stay in hardware. rvu_switch_disable() would also choose the
non-rep branch for rep-layout entries:

	if (rvu->rep_mode)
		goto free_ents;

Can this leave the MCAM table with a mix of rep and legacy rules? ESW_CFG
disable could already reach the same state before this patch, but FLR is
a new way to get there.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index fb4870cd18e9..d5f69cba6d41 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h

[ ... ]

> @@ -577,6 +578,11 @@ struct rvu_switch {
>  	u16 *entry2pcifunc;
>  	u16 mode;
>  	u16 start_entry;
> +	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
> +	u8 switch_id_len;
> +#define RVU_SWITCH_FLAG_FW_READY BIT_ULL(0)
> +	u64 flags;
> +	u16 pcifunc;
>  };

[Severity: Low]
This isn't a bug, but are any of these new fields ever read? In
drivers/net/ethernet/marvell/octeontx2/, rswitch.switch_id and
switch_id_len are only written, in rvu_mbox_handler_esw_cfg() and
rvu_rep_cache_reset(). flags, pcifunc and RVU_SWITCH_FLAG_FW_READY are
not used at all.

rvu_sw_port_id() and RVU_SW_INVALID_PORT_ID also have no callers.
rvu_rep_get_vlan_id() is now exported in rvu.h, but it is still only
called from rvu_rep.c. On an ena=0 request, the switch_id is copied and
then cleared right away by rvu_rep_cache_reset().

Could these be added together with the code that uses them? That way
the new mailbox fields and the rep_id << 16 | pcifunc port id encoding
would not be fixed before anything consumes them.

> @@ -1194,9 +1200,12 @@ void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena);
>  void rvu_mcs_exit(struct rvu *rvu);
>  
>  /* Representor APIs */
> +void rvu_rep_cache_reset(struct rvu *rvu);
>  int rvu_rep_pf_init(struct rvu *rvu);
>  int rvu_rep_install_mcam_rules(struct rvu *rvu);

[Severity: Medium]
This is a pre-existing issue, but rvu_rep_install_mcam_rules() allocates
a new workqueue every time it runs:

	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_PERCPU, 0);

There is no destroy_workqueue(rvu->rep_evt_wq) anywhere. Does each
rep-mode rvu_switch_enable() cycle leak the previous rep_evt_wq?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index a2781e0f504e..a3ad45f46742 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c

[ ... ]

> @@ -189,14 +190,47 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
>  	return 0;
>  }
>  
> -static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
> +static bool rvu_rep_lookup_id(struct rvu *rvu, u16 pcifunc, u16 *rep_id)
>  {

[ ... ]

> +u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
> +{
> +	u16 rep_id;
> +
> +	if (!rvu_rep_lookup_id(rvu, pcifunc, &rep_id))
> +		return 0;
> +	return rep_id;
> +}

[Severity: Medium]
The lookup now runs under rsrc_lock, but callers still read
rvu->rep_pcifunc without the lock. rvu_rep_cache_reset() can now clear
rep_pcifunc at any time, from the FLR worker or from ESW_CFG disable.
Can a caller end up mixing two different states?

In rvu_rep_install_rx_rule():

	rep_id = rvu_rep_get_vlan_id(rvu, pcifunc);
	if (rte) {
		vlan_tci = rep_id | BIT_ULL(8);
		req.vf = rvu->rep_pcifunc;

rvu_rep_notify_pfvf_state() reads it twice:

	pf = rvu_get_pf(rvu->pdev, rvu->rep_pcifunc);
	...
	req->hdr.pcifunc = rvu->rep_pcifunc;

If a reset lands between these reads, could the up-notification go to
devid 0, or to the old rep PF with hdr.pcifunc = 0? Could an MCAM rule
be built that steers to pcifunc 0? Before this patch, rep_pcifunc was
only ever set and never cleared.

[ ... ]

> @@ -429,16 +463,48 @@ int rvu_rep_pf_init(struct rvu *rvu)
>  	return 0;
>  }
>  
> +void rvu_rep_cache_reset(struct rvu *rvu)
> +{
> +	u16 *map;
> +
> +	mutex_lock(&rvu->rsrc_lock);
> +	rvu->rep_mode = 0;
> +	rvu->rep_pcifunc = 0;

[Severity: Medium]
On eswitch disable, does clearing rep_pcifunc here make the AF forget
the representor PF before that PF has freed its NIX LF?

rvu_rep_destroy() sends ESW_CFG disable first and frees the hardware
resources afterwards:

	rvu_eswitch_config(priv, false);
	priv->flags |= OTX2_FLAG_INTF_DOWN;
	rvu_rep_free_cq_rsrc(priv);
	...
	rvu_rep_rsrc_free(priv);

rvu_rep_rsrc_free()->otx2_free_hw_resources() sends NIX_LF_FREE with
NIX_LF_DISABLE_FLOWS. By then rep_pcifunc is already 0, so is_rep_dev()
returns false in rvu_mbox_handler_nix_lf_free() and the rep shortcut is
skipped:

	if (is_rep_dev(rvu, pcifunc))
		goto free_lf;

	if (req->flags & NIX_LF_DISABLE_FLOWS)
		rvu_npc_disable_mcam_entries(rvu, pcifunc, nixlf);

rvu_npc_disable_mcam_entries() disables every RX rule whose
rx_action.pf_func is the rep PF. That includes the AF-owned
representor steering rules, which rvu_npc_free_mcam_entries() in
ESW_CFG left in place.

nix_interface_deinit() would also run on an LF that was allocated
through the rep branch of nix_lf_alloc. That branch used LBK chan 63 and
never called nix_interface_init().

The other is_rep_dev() checks would also treat the rep PF as a normal
function until the next GET_REP_CNT: nix_get_txschq_range(),
rvu_nix_tx_tl2_cfg(), and from_rep_dev in npc_install_flow.

The commit message calls this a cache reset. Should it also say that
the reset clears the representor identity and mode?

[ ... ]

>  int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
>  			     struct msg_rsp *rsp)
>  {
>  	if (req->hdr.pcifunc != rvu->rep_pcifunc)
>  		return 0;
>  
> +	if (rvu->rep_mode && req->ena)
> +		return 0;
> +
> +	if (!rvu->rep_mode && !req->ena)
> +		return 0;
> +
>  	rvu->rep_mode = req->ena;

[Severity: Medium]
rvu_rep_cache_reset() and rvu_mbox_handler_get_rep_cnt() now update
rep_pcifunc, rep_mode, switch_id and the map under rsrc_lock. This
handler checks and writes the same fields without taking the lock. Is
that intentional?

With the new FLR caller running on flr_wq, this ordering looks possible:

esw_cfg(ena=1)                       __rvu_flr_handler()
  passes rep_pcifunc/rep_mode checks
                                     rvu_rep_cache_reset()
                                       rep_mode = 0, rep_pcifunc = 0,
                                       rep2pfvf_map = NULL
  rvu->rep_mode = 1

That leaves rep_mode = 1 with rep_pcifunc = 0 and no map. A reset
between the memset() and the memcpy() of switch_id below could also
leave switch_id and switch_id_len out of sync.

> +	memset(rvu->rswitch.switch_id, 0, sizeof(rvu->rswitch.switch_id));
> +	rvu->rswitch.switch_id_len = 0;
> +	if (req->switch_id_len && req->switch_id_len <= MAX_PHYS_ITEM_ID_LEN) {
> +		memcpy(rvu->rswitch.switch_id, req->switch_id,
> +		       req->switch_id_len);
> +		rvu->rswitch.switch_id_len = req->switch_id_len;
> +	}

[Severity: Medium]
req points straight into the shared mailbox memory (mdev->mbase), which
the sending function can write. req->switch_id_len is read three times
here. Could a sender change that byte after the bounds check, so that
rvu->rswitch.switch_id_len ends up as large as 255?

memcpy() may alias *req, so the compiler has to reload the length for
the final store. It is also allowed to reload it for the memcpy()
length, which would overflow rswitch.switch_id[].

Would reading switch_id_len once into a local variable avoid this?

[ ... ]

> @@ -447,31 +513,48 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
>  				 struct get_rep_cnt_rsp *rsp)
>  {
>  	int pf, vf, numvfs, hwvf, rep = 0;
> -	u16 pcifunc;
> +	u16 pcifunc, rep_cnt;
> +	u16 *map;
> +
> +	mutex_lock(&rvu->rsrc_lock);
>  
>  	rvu->rep_pcifunc = req->hdr.pcifunc;

[Severity: High]
This is a pre-existing issue, but the patch makes it worse. Any PF or
AF-VF can send MBOX_MSG_GET_REP_CNT, and this assignment makes the
sender the representor without any authorization check. It now also
happens on the cached path.

Once a function holds that identity, is_rep_dev() is true for it, and
rvu_mbox_handler_npc_install_flow() lets it choose any target:

	} else if (from_rep_dev && req->vf) {
		/* Representor device installing for a representee */
		target = req->vf;

With this patch, the same function can also set rvu->rswitch.switch_id.
It can send ESW_CFG(ena=0), or trigger its own FLR, to run
rvu_rep_cache_reset(), which frees the real representor's map and
clears rep_mode.

Could a PF or VF assigned to a guest use this to install flows for
other functions or to tear down representor state?

> -	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> -	rvu->rep_cnt = rsp->rep_cnt;
>  
> -	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
> -					 sizeof(u16), GFP_KERNEL);
> -	if (!rvu->rep2pfvf_map)
> +	if (rvu->rep2pfvf_map) {
> +		rsp->rep_cnt = rvu->rep_cnt;
> +		for (rep = 0; rep < rvu->rep_cnt; rep++)
> +			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
> +		mutex_unlock(&rvu->rsrc_lock);
> +		return 0;
> +	}
> +
> +	rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;

[Severity: High]
This isn't a bug introduced by this patch, but the patch copies the
unbounded loop into the new cached replay path.

rep_cnt is cgx_mapped_pfs + cgx_mapped_vfs. rvu_map_cgx_lmac_pf() sums
cgx_mapped_vfs from the firmware-provisioned numvfs with no cap. Struct
get_rep_cnt_rsp only has:

	u16 rep_pf_map[64];

When more than 64 PFs and VFs are CGX mapped, can both loops here
overflow rsp->rep_pf_map[]?

On the NIC side, rvu_get_rep_cnt() is now called from both
rvu_rep_probe() and rvu_rep_create(). It copies rsp->rep_cnt entries
into priv->rep_pf_map[RVU_MAX_REP], which has 64 entries, with no
bound check:

	priv->rep_cnt = rsp->rep_cnt;
	for (rep = 0; rep < priv->rep_cnt; rep++)
		priv->rep_pf_map[rep] = rsp->rep_pf_map[rep];

That would overwrite esw_mode, ipsec and af_xdp_zc_qidx in struct
otx2_nic.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7..80b47bb333b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c

[ ... ]

> @@ -408,6 +413,8 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
>  		return -ENOMEM;
>  	}
>  	req->ena = ena;
> +	req->switch_id_len = attrs.switch_id.id_len;
> +	memcpy(req->switch_id, attrs.switch_id.id, req->switch_id_len);
>  	otx2_sync_mbox_msg(&priv->mbox);
>  	mutex_unlock(&priv->mbox.lock);
>  	return 0;

[Severity: Medium]
This is a pre-existing issue, but rvu_eswitch_config() ignores the
return value of otx2_sync_mbox_msg() and always returns 0.
rvu_rep_create() also ignores the return value of rvu_eswitch_config(),
including the new -EINVAL, and returns 0:

	rvu_eswitch_config(priv, true);
	return 0;

otx2_devlink_eswitch_mode_set() then records the new mode:

	if (!ret)
		pfvf->esw_mode = mode;

Can devlink report switchdev mode as set when the AF never enabled rep
mode? A retry with the same mode would then return early.

> @@ -645,6 +652,41 @@ void rvu_rep_destroy(struct otx2_nic *priv)
>  	rvu_rep_rsrc_free(priv);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but rvu_rep_destroy() has
this sequence:

		unregister_netdev(rep->netdev);
		rvu_rep_devlink_port_unregister(rep);
		free_netdev(rep->netdev);
		kfree(rep->flow_cfg);

rep is netdev_priv() of the netdev. Is rep->flow_cfg read after
free_netdev() has already released that memory?

[Severity: High]
This is also a pre-existing issue. rvu_rep_get_stats64() does:

	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

Nothing cancels stats_wrk before free_netdev() in rvu_rep_destroy().
Suppose a stats read happens within 100ms of a switchdev to legacy
transition or a driver remove. Can rvu_rep_get_stats() then run on the
freed rep?

	rep = container_of(del_work, struct rep_dev, stats_wrk);
	priv = rep->mdev;

[ ... ]

> @@ -653,6 +695,10 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
>  	int rep_id, err;
>  	u16 pcifunc;
>  
> +	err = rvu_get_rep_cnt(priv);
> +	if (err)
> +		return err;
> +
>  	err = rvu_rep_rsrc_init(priv);
>  	if (err)
>  		return -ENOMEM;

[Severity: Medium]
This is a pre-existing issue, but the next allocation after a
successful rvu_rep_rsrc_init() returns without cleanup:

	priv->reps = kzalloc_objs(struct rep_dev *, rep_cnt);
	if (!priv->reps)
		return -ENOMEM;

Does this leak the NIX/NPA hardware resources and the queue memory set
up by rvu_rep_rsrc_init(), since rvu_rep_rsrc_free() is never called
here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924082614.1947742-1-rkannoth%40marvell.com
