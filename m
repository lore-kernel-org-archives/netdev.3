Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017131;
	b=MElRq6q4MtgNmEXTjLfz+HiFeqB6tSQ3SEB3Yu00cHvRM9ir5c+yvB88szknAtRZIJUi
	 tSZU6m7qhHS0CU1QBNP3LLCKrr4dP6rWcT2c4Ljb0xJMfffBdexR6rcIFdL4paIlSlSmr
	 n3aV2uMO+W/44x1xD5PdGic35V2Va6h6PdIvwg7gHXzvRf66sycoqIu0fknfHG/1bQXPG
	 bLuro6yK030uKYsGWF0L+YUwn8ytl2opsmnqLVDpCc+n0UYjxLupp9iRJ7ougSve/9v08
	 SodDUT/4aJSjyN8ntpGjtfDmH2PjmwOwYs2/MfSxhFwE6ICzi38Fhef91uGLAHUGN9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017131;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YhHYY9mGEJDotp7qT8axD79zzEAz+Ft2iS5mjfVR2Jo=;
	b=f9y2U3kUsw4anpEKM20hWGf7VfCE9aA2ZNTYjpbCrIT/P/4CWmYO5fDh0ijJXJbZWYz5
	 403HCXqfuEv1ePbu2QNEdxVr+zjzaMmLh+NwbQwCk2XnFLmIOk6xe59eBV283f5vjG6uz
	 gcSQ5Qxzvr3+6Sj5wNkyj7YDQemBzITn94qVK2yIAtAVLmQ+imSrlwQLBt/T6+BlEw9A3
	 EBmqCI8tXhOXoegHhtkRlRk5KCqJamu5tPx3Pw0QMyH5EyHe8r/cXU8RGZLNNnzDddXrS
	 11o1C8z6ySzfWAprOqoXEjvUDCAI6YvS5/3K1Zs04RkLw6qK8AUzCzAgIwkx5T/+1EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3G1fGh9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC9606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3G1fGh9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3401F01825;
	Mon, 26 Oct 2026 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793017131;
	bh=YhHYY9mGEJDotp7qT8axD79zzEAz+Ft2iS5mjfVR2Jo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G3G1fGh9rjekiSk68DZW3gGpRNJ8BJwjxMogg3w+2d0qjAQyDwBKq0Zm2FBAjBqBc
	 D3X45ZB7ca2ejRfOdV4XMvzdOaskE8fUqBzW/2qWsTP5f1rZg0cKQonRQJrfN859w7
	 d+2YC9cl0vuI1iAdkqU6PIVEEDwjIwuMQdPA28wIKYj1258WC00I51zNcQXsNyn4D5
	 M/ozgiNfZkiI099zs0rfDxypyQixxzs/toXjYeMlgjNE0dWQwO1CL2lzxpkrxhSenJ
	 jxDx7a8+NeaWc3Qap4UenqWHXn0CluJEhP6uAYQ8HbWqVdyGIztuWpf9Zjjk9rzvy6
	 aVu2yGRWNTXTQ==
Subject:
 Re: [PATCH net v2 2/2] enic: require DEVCMD2 and set the V2 VF mailbox source
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, kuba@kernel.org
Date: Mon, 26 Oct 2026 12:18:50 +0000
Message-ID: <179301713031.3134.10446859443252530952@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261022-b4-enic-dma-vf-index-net-generic-first-v1?=
 =?utf-8?q?-20261010-v2-2-8db19b4a714e=40cisco=2Ecom=3E?=
References: =?utf-8?q?=3C20261022-b4-enic-dma-vf-index-net-generic-first-v1-?=
 =?utf-8?q?20261010-v2-2-8db19b4a714e=40cisco=2Ecom=3E?=
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

- [Medium] Only one place clears sriov_stats_dma_unresolved:
  enic_admin_qp_type_set() (enic_admin.c:416-417), and only when…
- [Low] The retention branches in enic_probe() (enic_main.c:3456-3465)
  and enic_remove() (enic_main.c:3530-3543) now trigger on…
- [Low] The VF's mailbox source identity is set only after the admin
  channel is already live.

--

enic: require DEVCMD2 and set the V2 VF mailbox source

This patch requires DEVCMD2 for V2 SR-IOV PF support and for V2 VF probe.
After opening the admin channel, the VF now queries CMD_SRIOV_STATS_GET to
get its logical VF index and uses that index as the mailbox source. The
patch also adds a per-call DEVCMD2 completion status, so an unresolved
statistics DMA target can be tracked and kept alive when probe fails.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 4325c6d9c30e3..4eb17e88d368e 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
> @@ -401,12 +401,23 @@ static void enic_admin_teardown_intr(struct enic *enic)
>  
>  static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
>  {
> +	enum vnic_devcmd2_status status;
>  	u64 a0 = QP_TYPE_ADMIN, a1 = enable;
>  	int wait = 1000;
>  	int err;
>  
>  	spin_lock_bh(&enic->devcmd_lock);
> -	err = vnic_dev_cmd(enic->vdev, CMD_QP_TYPE_SET, &a0, &a1, wait);
> +	if (vnic_dev_uses_devcmd2(enic->vdev)) {
> +		err = vnic_dev_cmd2_status(enic->vdev, CMD_QP_TYPE_SET,
> +					   &a0, &a1, wait, &status);
> +		/* Ordered completion fences the earlier statistics DMA target,
> +		 * including an error result. Admin queues still need RUNNING == 0.
> +		 */
> +		if (status == VNIC_DEVCMD2_COMPLETED)
> +			WRITE_ONCE(enic->sriov_stats_dma_unresolved, false);

[Severity: Medium]
Is enic_admin_qp_type_set() meant to be the only place that clears
sriov_stats_dma_unresolved?

The new comment in struct enic says the target stays device-owned "until a
later serialized command completes". The commit message also relies on
command ordering for the fence. By that reasoning, any later blocking
DEVCMD2 command that completes should fence the statistics target too.

Consider this probe failure path for a V2 VF in enic_probe():

enic_dev_sriov_stats()
  CMD_SRIOV_STATS_GET posted, times out -> sriov_stats_dma_unresolved = true
goto err_out_admin_close
  enic_admin_channel_close()
    CMD_QP_TYPE_SET(QP_DISABLE) posted, times out -> flag stays set
    (WQ/RQ RUNNING checks pass, admin channel is released)
err_out_dev_close:
  vnic_dev_close()
    vnic_dev_cmd(CMD_CLOSE) -> _vnic_dev_cmd2(), status == NULL
err_out_vnic_unregister:
  enic_control_dma_unresolved() -> true

CMD_CLOSE is a blocking _CMDC command. If it completes, the same ordering
has fenced the statistics target. However, its return value is ignored and
its completion status is never seen, so the flag stays set.

Does this send probe into the "retaining resources until reboot" branch?
That branch keeps the netdev, vdev, BAR mappings and PCI regions, takes an
extra pci_dev reference and blocks reprobe until reboot, even though the
device can no longer write vdev->sriov_stats.

Could the CMD_CLOSE completion in vnic_dev_close(), in both enic_probe()
and enic_remove(), also clear the flag?

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 838b6dc837ee4..846221937ab10 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -3238,6 +3258,9 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 * unmasks the admin interrupt so an early completion is not dropped.
>  	 */
>  	if (enic_is_sriov_vf_v2(enic)) {
> +		u32 stats_ver;
> +		u16 vf_id;
> +
>  		enic_mbox_init(enic);
>  		err = enic_admin_channel_open(enic);
>  		if (err) {
> @@ -3245,6 +3268,23 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  				"Failed to open admin channel: %d\n", err);
>  			goto err_out_dev_deinit;
>  		}
> +		err = enic_dev_sriov_stats(enic, &sriov_stats);
> +		if (err) {
> +			dev_err(dev, "Failed to get SR-IOV statistics: %d\n", err);
> +			goto err_out_admin_close;
> +		}
> +		/* Snapshot the coherent fields after the command's DMA barrier. */
> +		stats_ver = le32_to_cpu(sriov_stats->ver);
> +		vf_id = le16_to_cpu(sriov_stats->vf_index);
> +		if (stats_ver != VNIC_SRIOV_STATS_VERSION ||
> +		    vf_id == ENIC_MBOX_DST_PF) {
> +			dev_err(dev,
> +				"Invalid SR-IOV statistics version %u VF index %#x\n",
> +				stats_ver, vf_id);
> +			err = -EINVAL;
> +			goto err_out_admin_close;
> +		}
> +		WRITE_ONCE(enic->vf_id, vf_id);

[Severity: Low]
Can a mailbox message go out with src_vnic_id = 0xFFFF in this window?

enic->vf_id starts as ENIC_MBOX_DST_PF. Before enic_dev_sriov_stats() runs,
enic_admin_channel_open() has already unmasked admin_intr and cleared
mbox_send_disabled. The statistics query can then busy-wait for up to
1000 x udelay(100) while holding only devcmd_lock.

A PF_LINK_STATE_NOTIF can arrive during that wait, for example from a PF
that still has this VF registered because an earlier driver instance did
not unregister cleanly. enic_mbox_vf_process_msg() has no vf_registered
check, so on another CPU:

admin_msg_work
  enic_mbox_recv_handler()
    enic_mbox_vf_handle_link_state()
      enic_mbox_send_reply(enic, ENIC_MBOX_PF_LINK_STATE_ACK, ...)
        enic_mbox_fill_hdr()
          src_vnic_id = READ_ONCE(enic->vf_id);   /* still 0xFFFF */

enic_mbox_send_reply() takes mbox_lock, not devcmd_lock, so it is not
serialized against the statistics query.

The commit message says the index is queried "before the first VF
request", but that does not cover replies and ACKs. Would a PF that checks
src_vnic_id against the CQ metadata sender reject this ACK?

Should replies be held off until enic->vf_id has been set?

>  		err = enic_mbox_vf_capability_check(enic);

[ ... ]

> @@ -3412,7 +3453,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  #endif
>  err_out_vnic_unregister:
> -	if (enic_admin_channel_is_quarantined(enic)) {
> +	if (enic_control_dma_unresolved(enic)) {
>  		/* Normal generic cleanup and CMD_CLOSE have already run. Retain
>  		 * only the inert admin/control owners and their PCI reservation.
>  		 */

[Severity: Low]
This isn't a bug, but enic_control_dma_unresolved() now also covers
sriov_stats_dma_unresolved. Both this retention branch in enic_probe() and
the one in enic_remove() still print:

    "Admin DMA unresolved; retaining resources until reboot\n"

When only the statistics flag is set, enic_admin_channel_close() has
already released the admin channel and admin_chan_state is DOWN. The memory
actually being kept is vdev->sriov_stats.

Could the message also name the SR-IOV statistics target, so it points at
the right resource?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v2-0-8db19b4a714e%40cisco.com
