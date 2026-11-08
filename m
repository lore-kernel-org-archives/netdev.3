Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168060;
	b=RxXygCRNUmUvCUnpBvkjrIbOZDnv7Lm3B4Mydmoki282TevgJLplbdJiiT5p1Yg+mJLa
	 aPNvA8aYWslzaimocAoPIxE6Qy8FTqnyH451STXSVkys3sYYmhghzMQMJffDGztoDs8+Q
	 qiSwmEqz5nhXMPZ6aWx36uiisVh3aN8WLqiTbyifmInoaadP31uQF4pg/LV9Sha+AuMCC
	 QiJlvsOLNorbs4JY2sJ4Ugodomoz28oRMrYxkFkc1YYVBj5TQ+yjpsz+3LdQ6jKzZqZ6n
	 l/zQq8fhGI8NBZVSDD0QRfIh3P/yIV4A6hHbqHavCzK3D/c8cFgxJsmm/N7cQ3ZpO8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168060;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bZD9WxQLC7rKJWVcR8n1dH1v0AeuRODCN3NKYMnO9VA=;
	b=G2nT9nhkaN5MDqu/L7037tzcAwFsGdOr8ukIH8Y9ZD4mxqJrPF8tmIOiDBMi+M1P70Zh
	 3mjIRL+ZYmsVPyMzekoTEKldArjO7vRQlmuKNJDNxF/gdaj/npPeh8jhp+WJ6P4z+t4yR
	 r8pnM1K60Y743SheG4W4aDVE8xUaj0e/j8RK/F9bCciJW2U2Bbgdt+lIgglCl90h3Lgyo
	 6PrYiUFKaexAIdnxL2NiijjerpEExS/OwrLrF7iPo0gXKGAG8/xV6E9SsgUdNeZRLFNMQ
	 clUiw6oplyUTq104mmIq61KtAKtG+3V9n/94YRv+EeGLfMWungSZpgFMsUa7gErHp4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djHpkVFI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7719606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djHpkVFI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5431F008A1;
	Sun,  8 Nov 2026 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168059;
	bh=bZD9WxQLC7rKJWVcR8n1dH1v0AeuRODCN3NKYMnO9VA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=djHpkVFIFn8L227NSk3UA8vh3XQR0/N3X6IlbmYiFAon3lZMArl/AVdYjitL64QSI
	 5ChEXkhw5TQlDFlSnp0EZGU1r0F4AJbqM0laoKys2qDmEeGNu9XCLZh8xjJZ3gwb6Q
	 puroMMNknXllAqkZrRkpgj6jbOmw8w5J3/lXj+/KGEhOPrQcucRgfeitZi7C8262Sg
	 rQtgq+b5s7GQGqgmAXtk1ULLKrqlcqbKmdLOl+dx6dPzflC8ng4B/302IzYvdf71IJ
	 GBRUqKmPA2skX0qkZ+Ypge57tS+GxCLPo1cXblkce1kngrDK328lJgjI+dEzWA3xGD
	 Yw0+np/0TSAJQ==
Subject:
 Re: [PATCH net v6 1/2] enic: retain admin-channel DMA until queues stop
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Sun, 08 Nov 2026 20:00:58 +0000
Message-ID: <179416805837.994134.11428485393774392132@kernel.org>
In-Reply-To: <20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-1-155d64f802e9@cisco.com>
References: <20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-1-155d64f802e9@cisco.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Surprise removal of a V2 VF now permanently retains the
  driver's objects, and each removal cycle leaks a new set.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  edits the exact lines involved and leaves it in place.

--

enic: retain admin-channel DMA until queues stop

This commit tracks the SR-IOV admin channel as DOWN, LIVE or QUARANTINED.
The admin WQ/RQ/CQ DMA allocations are freed only after both queues report
RUNNING == 0; otherwise the channel is quarantined, reset workers close the
netdev, and probe unwind and removal keep the netdev, vnic_dev and admin
allocations until reboot. It also checks the enic_open() return value in
the reset workers and detaches the netdev during removal.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 61c82b48044d0..8a063c563a41e 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -600,60 +608,51 @@ int enic_admin_channel_open(struct enic *enic)

[ ... ]

> +static int enic_admin_wq_disable(struct enic *enic)
>  {
> -	int err;
> +	struct vnic_wq *wq = &enic->admin_wq;
> +	u32 running;
>  

[ ... ]

> +	iowrite32(0, &wq->ctrl->enable);
> +	return read_poll_timeout(ioread32, running, !running, 10, 500000,
> +				 false, &wq->ctrl->running);
> +}

[Severity: Medium]
What happens here after a surprise removal of the VF, for example through
pciehp or when the VF is pulled out from under a guest? MMIO reads then
return 0xffffffff, so !running never becomes true and read_poll_timeout()
returns -ETIMEDOUT on every pass. enic_admin_rq_disable() behaves the same
way.

On removal the sequence looks like this:

enic_remove()
  enic_admin_channel_close()
    enic_admin_qp_type_set(QP_DISABLE)       fails fast
    enic_admin_wq_disable()/rq_disable()     time out, retried once
    admin_chan_state = ENIC_ADMIN_CHAN_QUARANTINED
  unregister_netdev(), enic_dev_deinit(), vnic_dev_close()
  enic_admin_channel_final_recheck()         times out again
  quarantine branch:
      pci_dev_get(pdev);
      pci_clear_master(pdev);
      pci_disable_device(pdev);
      pci_set_drvdata(pdev, NULL);
      ...
      return;

That return skips vnic_dev_unregister(), enic_iounmap(),
pci_release_regions() and free_netdev(). Does every surprise removal of a
V2 VF now keep the following until reboot?

  - the netdev
  - the vnic_dev and its coherent buffers
  - the admin rings and RQ buffers
  - a pinned pci_dev

Removal also gets a few seconds of extra polling. Before this patch, all
of these were freed.

The kept BAR reservation also doesn't seem to block a re-added device.
pci_destroy_dev()->pci_free_resources() detaches the old resource from the
iomem tree. A device re-enumerated in the same slot could then probe a new
enic instance and leak another set of objects on its next removal.

The probe unwind at err_out_vnic_unregister behaves the same way if the
device disappears during probe.

The commit message says:

  An all-ones MMIO read or a recoverable PCI channel-offline state is not
  accepted as queue-stop proof.

However, nothing in drivers/net/ethernet/cisco/enic/ checks
pci_dev_is_disconnected(), pci_channel_offline() or
pci_channel_io_perm_failure. Should a permanently removed device, which
can no longer bus-master, count as stopped so that normal teardown runs?

The later commit "enic: require DEVCMD2 and set the V2 VF mailbox source"
changes the retention check to enic_control_dma_unresolved(), but it does
not change this behaviour.

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 6b5824f45a14c..899e0b1e14be2 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -2264,17 +2276,27 @@ static void enic_reset(struct work_struct *work)

[ ... ]

> +	if (enic_admin_channel_is_quarantined(enic)) {
> +		/* Core close excludes netpoll and clears __LINK_STATE_START first. */
> +		dev_close(enic->netdev);
> +		goto reset_out;
> +	}
>  
>  	enic_stop(enic->netdev);
>  	if (enic_is_sriov_vf_v2(enic))
> @@ -2287,7 +2309,8 @@ static void enic_reset(struct work_struct *work)
>  	enic_dev_set_ig_vlan_rewrite_mode(enic);
>  	enic_ext_cq(enic);
>  
> -	enic_open(enic->netdev);
> +	if (enic_open(enic->netdev))
> +		goto reset_out;

[Severity: High]
This isn't a bug introduced by this patch, but this patch changes these
exact lines. If enic_open() fails here, the netdev keeps IFF_UP and
__LINK_STATE_START. By then, enic_stop() above has already disabled every
NAPI, freed the IRQs and destroyed the page pools.

enic_open() can fail in any of these:

  - enic_request_intr()
  - enic_dev_notify_set()
  - page_pool_create()
  - the RQ fill
  - enic_dev_enable()

Each of those failure paths leaves NAPI disabled.

A later dev_close(), or unregister_netdev() from enic_remove(), then runs
enic_stop() a second time:

enic_stop()
  napi_disable()
    napi_disable_locked()
        while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
            usleep_range(20, 200);
            val = READ_ONCE(n->state);
        }

The first disable left those bits set. Could this loop spin forever while
holding rtnl_lock and the netdev instance lock? Even if the loop exited,
enic_free_intr() would call free_irq() on vectors whose msix[i].requested
flag was never cleared.

Should the netdev be closed with dev_close() on this failure, as the
quarantined case just above already does? The same applies to
enic_open() in enic_tx_hang_reset().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-0-155d64f802e9%40cisco.com
