Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168061;
	b=00n3LIEln/ecBtLyTQYRBearEvJDfqeW4VoNIwKsUmN0eSjVIeYHaybO0DkagHGvdEJP
	 3vPBVPU2ZsnIvgoSypYj7fgjwwTitfo67b+yU1tbr7wbdCO6uiNp4Sg0HrKq9y7t8gaXF
	 imntUydAxqDlOXEUoKRoOGDP/n4cM8SRzJHKv8Bn5SaBaGj1s18g6HO3nOSu+oFEomXT5
	 l97UrHqDPOGuee+niS6YV8dtk0YQyLG6Tt4gbKEaufcC15hQGq1ypmGcVwZtPwoJV908s
	 GfCrMSRR6FziErurOWVFKhgO8RvFIuSrJ8I+GxxFXmAZSdSQ8BbJ4MNjlpLDQ6XT7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168061;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=txAOUqQ06QZgQ3/jJh6sUCYv1k+COj2KdCLkCq4D5Co=;
	b=K6pB/yMj6wA13C9FRM86+qltfkeL5vbRS+Ji7PLnFSNIXXFgpSsC2IUkbnZTIr2pyUFU
	 pAFqGgms+a4sQXuX+WRVW1Uxt511JbmCUH8CHgzBPDfbokmS6XcW8K0VBhd9VAIoK2t3W
	 bIcBaJlO9G6KMh7pHFgrdNaTkR9d14zjInsqo0JyR5+T5L/TIhV5dePzBOFVQ3poeXlGI
	 IscTYPXwVltsQOHGVlJFtAaaxM2WpcSTuNeAt2sRODb9+OAM0NXnWanNxcBiOtnt3kzyl
	 sk5SPOi4zJRZuoC+g5v5Yz8RO1j0TBe2p+d82vppX/5mVSiPL+hgpVDXkW320l41img==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJGvdT5v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D8606A323
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJGvdT5v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DAD1F0089F;
	Sun,  8 Nov 2026 20:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168060;
	bh=txAOUqQ06QZgQ3/jJh6sUCYv1k+COj2KdCLkCq4D5Co=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NJGvdT5v9LaxYebBhqf0ItqgGuLc1yjRNExdrvX7CONWihYHfFygTfPR+rFwRN1tT
	 jMlbd38Wste/xh7V9a9kHE4M3Y1sHddJNgg1mE4VbQz9gjur/eQU+EkEr+sLZBT2IV
	 +oS/SDN9DrjL1+lA5bvsxn1ZC1mN4V++Xo4Vf2aXG+gA1aiKu93vmbjKBCN7b40CNH
	 93CRt/0mfrhWak5v+XTOGEEdU0fH+iPmySp0oAQ/rJTt1vA0pZw8gnN4hu0JLMxppD
	 a4L74b9GsRNv+ID9Dnh1Y/DclhhgtfCkUqi47m+6Cf/GLFOTG10pvU8fk7WCffxSt7
	 Ty5KudcQa7rqQ==
Subject:
 Re: [PATCH net v6 2/2] enic: require DEVCMD2 and set the V2 VF mailbox source
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Sun, 08 Nov 2026 20:00:59 +0000
Message-ID: <179416805960.994134.14518780539667557481@kernel.org>
In-Reply-To: <20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-2-155d64f802e9@cisco.com>
References: <20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-2-155d64f802e9@cisco.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message and the code disagree about how the
  firmware VF index from CMD_SRIOV_STATS_GET is encoded, and that…
- [Low] enic_mbox_fill_hdr() now always sets an explicit src_vnic_id.
- [Low] The patch changes the DEVCMD2 completion poll for every command,
  not only the new status-observing callers.

--

enic: require DEVCMD2 and set the V2 VF mailbox source

This patch makes DEVCMD2 mandatory for V2 PF support and V2 VF probe. At
admin channel open, a V2 VF queries CMD_SRIOV_STATS_GET to learn its VF
index and publishes that index as the mailbox source ID. The DEVCMD2
transport also gains an optional NOT_POSTED/POSTED/COMPLETED status, used to
track whether the coherent statistics target can still be written by the
device.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 8a063c563a41e..d4f3f58a0ec2d 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -590,15 +604,41 @@ int enic_admin_channel_open(struct enic *enic)
>  		goto disable_queues;
>  	}
>  
> -	vnic_intr_unmask(&enic->admin_intr);
> +	if (enic_is_sriov_vf_v2(enic) &&
> +	    READ_ONCE(enic->vf_id) == ENIC_MBOX_DST_PF) {
> +		struct vnic_sriov_stats *stats;
> +		u32 version;
> +		u16 vf_id;
> +
> +		/* Keep received notifications queued until their ACK can use
> +		 * the VF source ID. The statistics query needs QP_ENABLE first.
> +		 */
> +		err = enic_dev_sriov_stats(enic, &stats);
> +		if (err) {
> +			netdev_err(enic->netdev,
> +				   "Failed to get SR-IOV statistics: %d\n", err);
> +			goto disable_queues;
> +		}
> +		version = le32_to_cpu(stats->ver);
> +		vf_id = le16_to_cpu(stats->vf_index);
> +		/* Later versions preserve the version-1 prefix used here. */
> +		if (version < VNIC_SRIOV_STATS_VERSION ||
> +		    vf_id == ENIC_MBOX_DST_PF) {
> +			netdev_err(enic->netdev,
> +				   "Invalid SR-IOV statistics version %u VF index %#x\n",
> +				   version, vf_id);
> +			err = -EINVAL;
> +			goto disable_queues;
> +		}
> +		WRITE_ONCE(enic->vf_id, vf_id);

[Severity: Medium]
The commit message says:

  "Reject VF index 0 because it identifies the PF."

This check compares vf_id with ENIC_MBOX_DST_PF, and enic_mbox.h defines
that as 0xFFFF:

  #define ENIC_MBOX_DST_PF	0xFFFF

So a vf_index of 0 passes the check. The raw value is then stored in
enic->vf_id, and enic_mbox_fill_hdr() sends it unchanged as src_vnic_id.

Which encoding does CMD_SRIOV_STATS_GET use for vf_index?

The rest of the driver treats mailbox IDs as 0-based.
enic_admin_rq_cq_service() derives the sender identity from the CQ VLAN:

  hdr->src_vnic_id = (sender_vlan == 0) ?
          cpu_to_le16(ENIC_MBOX_DST_PF) :
          cpu_to_le16(sender_vlan - 1);

enic_mbox_send_msg_id() routes with vlan_tag = dst_vnic_id + 1. The
commit message also says source zero "would identify only VF zero
correctly", which points the same way.

Suppose firmware reports 0 for the PF and 1-based indices for the VFs, as
the commit message implies. Wouldn't every V2 VF then publish a source one
higher than the identity the PF derives from the CQ VLAN? That would break
registration for every VF, including VF zero, which works today.

If vf_index is 0-based, the code is right and the commit message is not.

Could the base of vf_index be documented in the CMD_SRIOV_STATS_GET comment
in vnic_devcmd.h? Then either this check or the commit message could be
adjusted to match.

> +	}
>  
>  	/* Only now that the admin WQ/RQ/CQ and interrupt are fully allocated,

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index 5c93ca49552ac..a1f8138d0bbd8 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> @@ -18,10 +18,17 @@
>  #define ENIC_MBOX_POLL_TIMEOUT_US	5000000
>  #define ENIC_MBOX_POLL_INTERVAL_US	100
>  
> -static void enic_mbox_fill_hdr(struct enic_mbox_hdr *hdr, u8 msg_type,
> +static void enic_mbox_fill_hdr(struct enic *enic, struct enic_mbox_hdr *hdr,
> +			       u8 msg_type,
>  			       u16 dst_vnic_id, u16 msg_len, u64 msg_num)
>  {
> +	u16 src_vnic_id = ENIC_MBOX_DST_PF;
> +
> +	if (enic_is_sriov_vf_v2(enic))
> +		src_vnic_id = READ_ONCE(enic->vf_id);
> +
>  	memset(hdr, 0, sizeof(*hdr));
> +	hdr->src_vnic_id = cpu_to_le16(src_vnic_id);

[Severity: Low]
This also changes the PF side. Before this patch, src_vnic_id kept the 0
from the memset. Now any sender that is not a V2 VF writes 0xFFFF.

That changes the on-wire source of every PF-originated message, including
PF_LINK_STATE_NOTIF and the CAPABILITY, REGISTER and UNREGISTER replies.
The commit message only describes setting the V2 VF mailbox source.

The in-tree VF overwrites src_vnic_id from the CQ VLAN on receive, and
0xFFFF matches the PF identity, so this looks harmless here.

This patch exists to interoperate with deployed peers that check the header
source field. Could the commit message mention this PF-side change?

>  	hdr->dst_vnic_id = cpu_to_le16(dst_vnic_id);
>  	hdr->msg_type = msg_type;
>  	hdr->msg_len = cpu_to_le16(msg_len);

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
> index c8d657e97094e..92eec1455ceb8 100644
> --- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
> +++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c

[ ... ]

> @@ -340,7 +346,10 @@ static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
>  	}
>  
>  	for (delay = 0; delay < wait; delay++) {
> -		if (result->color == color) {
> +		if (READ_ONCE(result->color) == color) {
> +			dma_rmb();

[Severity: Low]
This isn't a bug, but this poll loop is shared by every DEVCMD2 command.
_vnic_dev_cmd2() is now a wrapper around _vnic_dev_cmd2_status(), so the
READ_ONCE() and dma_rmb() ordering of result->color against result->error
and result->results applies to all existing DEVCMD2 users.

The commit message describes the transport change only as "an optional
per-call observation of NOT_POSTED, POSTED or COMPLETED".

Should this ordering fix be stated in the commit message, or split into its
own patch, so it is visible for review and stable backporting?

> +			if (status)
> +				*status = VNIC_DEVCMD2_COMPLETED;
>  			if (result->error) {
>  				err = result->error;
>  				if (err != ERR_ECMDUNKNOWN ||
> @@ -363,6 +372,31 @@ static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
>  	return -ETIMEDOUT;
>  }
>  
> +static int _vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
> +			  int wait)
> +{
> +	return _vnic_dev_cmd2_status(vdev, cmd, wait, NULL);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-0-155d64f802e9%40cisco.com
