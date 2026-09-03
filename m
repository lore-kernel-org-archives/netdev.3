Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199123F889E;
	Thu,  3 Sep 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463499; cv=none; b=oTpTj67wZzSEfw4M+0YzB3Eav116yrO+zYhsczaqHgvpx4uauzl9z+lZrupSJhcjvpQNHE/fVuhAe85x/YX0wcyTfAuR0zr0YbjJDow7zbApvfA5rLZOV8Jj3Cm2tADOQIBImb3RzUPjJykjmdLXWaNNCdNhUeLgA0i2dHELoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463499; c=relaxed/simple;
	bh=HfexqgJTCmjES206C8x5KnYV6rXQtyVK52AFsLZhXlk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HsnhjsFA19mTG5VntKeFOG2bO73PJlw3gS8ZjOvAjI78dZrE9OBTc8knkgjQbhx3fTaya8+kobJzVV02TpCfPVZaiRelLDNl1WkLZeWTPZrRj3EbzJFdAJvxMkCFPmBG8tYGZ7nL4LprnZyPpmKlzqlr+8SxXkFD+27RUQySmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8jla0GL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8jla0GL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464331F00A3F;
	Thu,  3 Sep 2026 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463487;
	bh=qOoshltNDcR8Ak/3ivJaA0Xxho4fs+bLQC1kfa9NnLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F8jla0GLdUQDuy6+MykJ1po4huDQ8Vpi4VvzTw5Ms7MJax96yHV1QRfnLv35br5xS
	 6Qc1FUvS2tTxTYmAz+nsmK5kxtk+KsxaKAbT0P8AMz+wiNUxem70St7Gljx7kID5T8
	 36NrMwixlAAupUJRNvdqH9VAgqJtODoRnDYHfzBh5Z6KYqPVifhIe9PR4+HWMajZhj
	 T/+OrZxpet1NtD6Rrbo53Tx42RgTLq/JK8KVTpvSkggJeZgC35qznOofg53/xd8wjk
	 glE+D+7rot1Cp1J3cl7jowvtMQLd2ZySR/hL16t0Dj6gRlerBj11K5y8aEaQYC5Oey
	 FU6nLPmtX6Dqw==
Subject:
 Re: [v9,net-next,4/8] octeontx2-af: switch: Representor for switch port
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:24:46 +0000
Message-ID: <178846348684.3394541.6856496868277058175@kernel.org>
In-Reply-To: <20260831131944.2649362-5-rkannoth@marvell.com>
References: <20260831131944.2649362-5-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 2 (2) · Medium: 1 · Low: 1

- [High] esw_cfg_req_has_switch_id()
  (drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:442-455) derives…
- [High] Lockless access to rvu->rep2pfvf_map in rvu_sw_port_id() races
  with GET_REP_CNT mailbox handler updates, leading to a NULL pointer…
- [Medium] struct esw_cfg_req — an existing AF<->PF mailbox wire-format
  message carried in the shared mailbox window — grows a 32-byte…
- [Low] The patch adds rvu_sw_port_id(), RVU_SWITCH_FLAG_FW_READY and the
  rvu_switch.flags/pcifunc fields with no producer or consumer at this…

Pre-existing issues:
- [High] rvu_mbox_handler_get_rep_cnt() (af/rvu_rep.c:474-507, unchanged
  at the end of the series) re-allocates rvu->rep2pfvf_map with…
- [High] The new switch_id ingestion and rvu_sw_port_id() build on
  rvu->rep_pcifunc, rvu->rep_cnt and rvu->rep2pfvf_map, all of which any…

--

octeontx2-af: switch: Representor for switch port

This adds a devlink-derived switch id to the esw_cfg mailbox message, copies
it into rvu->rswitch on the AF side, and adds rvu_sw_port_id() plus an export
of rvu_rep_get_vlan_id().  A few questions below about the new mailbox field
and the state the new helper depends on.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index e45e6e93ed087..8e3850f33751d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1841,6 +1841,7 @@ struct esw_cfg_req {
>  	struct mbox_msghdr hdr;
>  	u8 ena;
>  	u64 rsvd;
> +	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
>  };

[Severity: Medium]

This changes the layout of an existing AF<->PF mailbox message, growing
struct esw_cfg_req from 32 to 64 bytes, but OTX2_MBOX_VERSION in the same
header stays at 0x000a.

The existing precedent in this driver for a message layout extension is to
gate on the header version, for example in af/rvu.c:

	if (attach->hdr.ver < RVU_MULTI_BLK_VER)

and rvu_process_mbox_msg() only validates req->sig, never req->ver.  With
the version unchanged, an old PF and a new AF both advertise ver = 0x000a
for two incompatible layouts.  Should OTX2_MBOX_VERSION be bumped and
checked here instead?

Two related points on the field itself:

The on-the-wire size of this message is now derived from
MAX_PHYS_ITEM_ID_LEN, a core netdevice constant outside this driver's
control.  Is it intentional that the mailbox layout follows that constant?

No length accompanies the value.  rvu_rep_devlink_set_switch_id() in
nic/rep.c sets ppid->id_len = sizeof(u64), and rvu_eswitch_config() copies
only that many bytes:

	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);

while the AF stores and would compare all MAX_PHYS_ITEM_ID_LEN bytes.  How
does the AF recover the meaningful prefix, i.e. should an id_len companion
be carried in the message and in struct rvu_switch?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 2876c76ae61b6..9174b879850a2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -576,6 +576,10 @@ struct rvu_switch {
>  	u16 *entry2pcifunc;
>  	u16 mode;
>  	u16 start_entry;
> +	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
> +#define RVU_SWITCH_FLAG_FW_READY BIT_ULL(0)
> +	u64 flags;
> +	u16 pcifunc;
>  };

[Severity: Low]

This isn't a bug, but rvu_sw_port_id(), RVU_SWITCH_FLAG_FW_READY and
rvu_switch.pcifunc have no producer or consumer at this commit; they do gain
users in the later patches of the series, which reads like normal series
decomposition.

The one field that stays unused through the end of the series is
rvu_switch.switch_id: it is written by rvu_mbox_handler_esw_cfg() and never
read anywhere.  Would it be clearer to add that store together with the code
that consumes it?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index a2781e0f504e3..672d54847c7b1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c

[ ... ]

> @@ -189,7 +190,7 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
>  	return 0;
>  }
>  
> -static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
> +u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
>  {
>  	int id;
>  
> @@ -429,6 +430,30 @@ int rvu_rep_pf_init(struct rvu *rvu)
>  	return 0;
>  }
>  
> +/* ESW_CFG is always the sole message in a mailbox transaction.
> + *
> + * The otx2 mailbox API does not batch multiple messages per sync: the
> + * representor driver allocates only ESW_CFG before calling
> + * otx2_sync_mbox_msg() (see rvu_eswitch_config()), and the AF processes
> + * one message per dispatch. next_msgoff is therefore the end offset of this
> + * message, not a cumulative offset across batched messages, so the length
> + * check below is safe. Batching is not supported; do not flag this path.
> + */
> +static bool esw_cfg_req_has_switch_id(const struct esw_cfg_req *req)
> +{
> +	u16 hdr_len = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
> +	u16 next_off = req->hdr.next_msgoff;
> +	u16 msg_len;
> +
> +	if (next_off < hdr_len)
> +		return false;
> +
> +	msg_len = next_off - hdr_len;
> +
> +	return msg_len >= offsetof(struct esw_cfg_req, switch_id) +
> +			  MAX_PHYS_ITEM_ID_LEN;
> +}
> +
>  int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
>  			     struct msg_rsp *rsp)
>  {
> @@ -436,6 +461,9 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
>  		return 0;
>  
>  	rvu->rep_mode = req->ena;
> +	if (esw_cfg_req_has_switch_id(req))
> +		memcpy(rvu->rswitch.switch_id, req->switch_id,
> +		       MAX_PHYS_ITEM_ID_LEN);

[Severity: High]

Is the premise of the comment above esw_cfg_req_has_switch_id() correct?
otx2_mbox_alloc_msg_rsp() in af/mbox.c derives next_msgoff from the running
total of the whole mailbox region:

	mdev->msg_size += size;
	mdev->rsp_size += size_rsp;
	msghdr->next_msgoff = mdev->msg_size + msgs_offset;

and __rvu_mbox_handler() in af/rvu.c walks a batch of messages per doorbell
using it:

	for (id = 0; id < mw->mbox_wrk[devid].num_msgs; id++) {
		msg = mdev->mbase + offset;
		...
		offset = mbox->rx_start + msg->next_msgoff;
	}

So if ESW_CFG is not the first message in a transaction, wouldn't
msg_len = next_msgoff - hdr_len exceed this message's real size and let the
check pass for an old 32-byte esw_cfg_req?

Beyond batching, next_msgoff lives in the shared mailbox window and is
written by the peer.  rvu_process_mbox_msg() checks only req->sig, and
otx2_pfvf_mbox_handler() in nic/otx2_pf.c forwards a VF's headers after
rewriting just pcifunc:

	if (msg->sig != OTX2_MBOX_REQ_SIG)
		goto inval_msg;
	msg->pcifunc &= ~RVU_PFVF_FUNC_MASK;
	msg->pcifunc |= (vf_idx + 1) & RVU_PFVF_FUNC_MASK;
	offset = msg->next_msgoff;

with otx2_forward_vf_mbox_msgs() handing the VF's own mailbox memory to the
AF verbatim (dst_mdev->mbase = src_mdev->mbase).

Can a VF that writes next_msgoff >= 80 and sends a 32-byte ESW_CFG make the
memcpy above read 32 bytes past the end of its message, picking up the
following message's header and payload, or bytes past the last message and
potentially past the per-device mailbox window, and persist them as the AF's
switch identity?

Since hdr.ver / OTX2_MBOX_VERSION exists to signal exactly this kind of
layout skew, would a version check be the safer bound here rather than a
peer-supplied offset?

One more note on the comment: the closing sentence "Batching is not
supported; do not flag this path" instructs readers not to inspect this
code.  Could that be dropped?

>  
>  	if (!rvu->rep_mode)
>  		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
> @@ -449,6 +477,9 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
>  	int pf, vf, numvfs, hwvf, rep = 0;
>  	u16 pcifunc;
>  
> +	/* Called once from representor driver probe during devlink eswitch
> +	 * SWITCHDEV bring-up; not re-run during switch device operation.
> +	 */
>  	rvu->rep_pcifunc = req->hdr.pcifunc;
>  	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
>  	rvu->rep_cnt = rsp->rep_cnt;

[Severity: High]

This isn't a bug introduced by this patch, but the new comment states this
handler is called once, and the new rvu_sw_port_id() is documented as relying
on that.  Is the invariant enforced anywhere?

rvu_mbox_handler_get_rep_cnt() re-runs on every MBOX_MSG_GET_REP_CNT:

	rvu->rep_cnt = rsp->rep_cnt;

	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
					 sizeof(u16), GFP_KERNEL);
	if (!rvu->rep2pfvf_map)
		return -ENOMEM;

Each repetition drops the previous pointer without devm_kfree(), and the old
buffer is devres-managed against the AF device, so it is only released when
the AF itself is removed.  Does a representor PF unbind/rebind or module
reload, or a VF repeating the message, grow the devres list without bound?

On the -ENOMEM path, rvu->rep_cnt is already published while
rvu->rep2pfvf_map is NULL, and rvu_rep_get_vlan_id() dereferences the map
with no NULL check:

	for (id = 0; id < rvu->rep_cnt; id++)
		if (rvu->rep2pfvf_map[id] == pcifunc)
			return id;

Can that NULL-dereference in the pre-existing AF callers of
rvu_rep_get_vlan_id() after a failed re-initialization?  Note that
rvu_sw_port_id() checks rvu->rep2pfvf_map itself, but its callee does not.

[Severity: High]

This is a pre-existing issue, but the new switch_id ingestion and
rvu_sw_port_id() build on rvu->rep_pcifunc, rvu->rep_cnt and
rvu->rep2pfvf_map, all of which this handler sets with no capability or
identity check:

	rvu->rep_pcifunc = req->hdr.pcifunc;

rvu_process_mbox_msg() applies no per-message privilege filter, and
otx2_pfvf_mbox_handler() forwards raw VF message IDs after checking only
sig.  Can a guest-owned VF send MBOX_MSG_GET_REP_CNT to become
rvu->rep_pcifunc, and then pass the gate in rvu_mbox_handler_esw_cfg():

	if (req->hdr.pcifunc != rvu->rep_pcifunc)
		return 0;

	rvu->rep_mode = req->ena;

thereby setting the AF-global rvu->rep_mode, driving
rvu_npc_free_mcam_entries(), and reaching the new switch_id memcpy?

Also, rvu_afvf_mbox_handler() does not take rvu->mbox_lock while the AFPF
worker does.  Can the AFVF path replace rvu->rep2pfvf_map concurrently with
the new lockless readers?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> index fe143ad3f9449..2451eb57ec4c8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> @@ -5,7 +5,33 @@
>   *
>   */
>  
> +#include <linux/bitfield.h>
> +
>  #include "rvu.h"
> +#include "rvu_sw.h"
> +
> +/*
> + * rep_cnt and rep2pfvf_map are populated once when the representor driver
> + * probes via GET_REP_CNT (see rvu_get_rep_cnt() in rep.c), as part of
> + * devlink eswitch SWITCHDEV bring-up. They are not updated during switch
> + * device mailbox handling, so this lockless lookup cannot race with a
> + * concurrent rep2pfvf_map resize.
> + */
> +u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
> +{
> +	u16 rep_id;
> +
> +	if (!rvu->rep2pfvf_map || !rvu->rep_cnt)
> +		return RVU_SW_INVALID_PORT_ID;
> +
> +	rep_id = rvu_rep_get_vlan_id(rvu, pcifunc);
> +	if (rep_id >= rvu->rep_cnt ||
> +	    rvu->rep2pfvf_map[rep_id] != pcifunc)
> +		return RVU_SW_INVALID_PORT_ID;
> +
> +	return FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
> +	       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
> +}

[Severity: High]
The comment above this helper asserts that rep_cnt and rep2pfvf_map
cannot change under a reader, but rvu_mbox_handler_get_rep_cnt() runs
for every MBOX_MSG_GET_REP_CNT, and it publishes the new count before
the matching array exists:

	rvu->rep_cnt = rsp->rep_cnt;

	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
					 sizeof(u16), GFP_KERNEL);
	if (!rvu->rep2pfvf_map)
		return -ENOMEM;

So there is a window in which rvu->rep_cnt describes the new topology
while rvu->rep2pfvf_map still points at the previous, smaller buffer.
A reader that passes the entry test here then walks id < rvu->rep_cnt
in rvu_rep_get_vlan_id() and indexes rvu->rep2pfvf_map[rep_id] past the
end of the old allocation.  The rep_id >= rvu->rep_cnt bound added in
this helper does not help, since rep_cnt is exactly the value that has
already been advanced.

The allocation failure path looks worse: rvu->rep2pfvf_map is
overwritten with NULL while rvu->rep_cnt stays non-zero, and nothing
re-checks the pointer after this function's own test - rvu_sw_port_id()
validates rvu->rep2pfvf_map on entry, but rvu_rep_get_vlan_id()
dereferences it unconditionally, so a store that lands between the two
turns the lookup into a NULL dereference.

Neither side takes a lock: rvu_afvf_mbox_handler() does not hold
rvu->mbox_lock, so a VF-originated GET_REP_CNT can execute the
reallocation in parallel with these reads on another CPU.

What is the intended serialization here?  If GET_REP_CNT really can only
arrive once, could that be enforced (reject the message when
rvu->rep2pfvf_map is already set) rather than documented in a comment?
Otherwise the map and its count need to be published together under a
lock or as an RCU-swapped object, and rvu->rep_cnt should not be updated
before the allocation succeeds.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131944.2649362-1-rkannoth%40marvell.com
