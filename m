Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021801;
	b=ZI8QtiqUPR6/+/obrClN7sgnMr3FT5Nz74iLJ9EeA8KjObdHEKd2ElVkaNigUO/UhTuu
	 4HR7gjfWAxfpJFuyHdHZ08fiLeQ27M7OjatT8mPWv15A0ogNxSZ2mIpIXjIkVq2ikX8JY
	 YVnGS2RxHTX47zzYf6iM/0AtBSlUQ6UOuTHDXTBaPZbbuVnxfRuB+d2me8T6Izdd/JFBx
	 RhcwObQ4px8TQEBEKUlUH7StgM6JAZ9CG3W9UVCz1FAhj3myHuVO37LBt3EoJhfKuhff+
	 lkuYXPRwbcOguHjCoo7u2d8vbOWRjU8XmnjuDK7iy15Vxu/OKqWDdMdSAo//hSG4I9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021801;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zxwmtrsC/po3OGrfo16K49WV6xayWvBaG2dVbJUY3I8=;
	b=JxpUEC7pJVLVdb060SLPMw5NEYG0H8NcZD/yzghCkYL9zRO0t4cZeKrWZk1vV5+ACDdP
	 vuNmnSILKVYhTtJXjvr9KTPKekNYXXINeqa8rjMbQ9h5SmgyW1A1DA9QIRAoNs134XsqJ
	 2r8LnIxuO02glp5/NSo7w97pGJ/mC0BTlzHkARGLkvX9wDJmZhx+O47tOxjy8gxloj7pj
	 bK0k3g5N/J0crMjrmEPHxqcztOWaR8BA6FWZSsaUQB7zigod8FAMrq3ZajIEJwt35EP43
	 LtfOvBU6xv9rListUG0IirqJiCE0UHDzVVOowyxZ9q4omShoqHgzzlHVqyUSlZeTpKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ul7ymH/r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EA606A33B;
	Sat,  7 Nov 2026 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ul7ymH/r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52EA1F0089F;
	Sat,  7 Nov 2026 03:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794021801;
	bh=zxwmtrsC/po3OGrfo16K49WV6xayWvBaG2dVbJUY3I8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ul7ymH/rTkN3e8cnrMdwbHiLAi6ycnSv+h+1GuKYzSO9PLMZX/P95r4GSEIkpCy2h
	 lf09ub8opp1u6wW2q+Op4sTXo0RSu7rhuqgq+l1imjwa+rKi1srzxAp7JS6PHTu4iR
	 mWIazRuRQ2a1OMGWuWsNrn7d5hHF2xea1x2E0I7uxZ/Pczbb8FZH4xZ0knCamLmRSI
	 PvpnF6Rymrqc/EOOmA8cXZxI9up+lzODis7eweaDPY42SPpu1/BfP9xTi6Gz+9Icxa
	 gNF85AWuOsBXP419AdvLKzsryblGiNi5PFQce8I3jh3MsvTZmMmTgJzvBxZmWDx5Lt
	 8nX8fa+t2ohww==
Subject:
 Re: [PATCH net v7 3/3] nfc: nfcmrvl: stop firmware work before unregistering
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, david@ixit.cz,
 horms@kernel.org, gio@octane.security, kuba@kernel.org
Date: Sat, 07 Nov 2026 03:23:20 +0000
Message-ID: <179402180045.994134.13635756935686970887@kernel.org>
In-Reply-To: <20261104062026.80599-4-shubham@octane.security>
References: <20261104062026.80599-4-shubham@octane.security>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new -EBUSY return in nfcmrvl_fw_dnld_start()
  (fw_dnld.c:595-600) leaves the NFC core's fw_download_in_progress flag…
- [Medium] The reset-pulse hold-off is enforced only when work is queued,
  not inside the worker.
- [Low] The commit carries a Fixes: tag but bundles several changes
  beyond the teardown UAF fix, and some of them are not in the commit…
- [Low] fw_dnld_over() calls nfc_fw_download_done() (fw_dnld.c:145)
  before it clears fw_dnld->completing under rx_lock (lines 147-149).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the firmware-
  download state machine the patch reworks trusts a 16-bit chunk length…
- [Low] Frames that arrive while nfcmrvl_chip_reset() holds reset
  asserted are queued in rx_q (nfcmrvl_fw_dnld_recv_frame(),…

--

nfc: nfcmrvl: stop firmware work before unregistering

This patch adds active, stopping, starting and completing state, protected
by a new rx_lock, to the nfcmrvl firmware download path. It moves timeout
completion onto the firmware workqueue and drains the firmware and NCI
command machinery before nci_unregister_device(). It also rejects
concurrent downloads, holds frames received during the reset pulse, and
reports completion with a positive errno.

> diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
> index 8b9d5257320dc..6e8608655710d 100644
> --- a/drivers/nfc/nfcmrvl/fw_dnld.c
> +++ b/drivers/nfc/nfcmrvl/fw_dnld.c
> @@ -90,22 +90,50 @@ static struct sk_buff *alloc_lc_skb(struct nfcmrvl_private *priv, uint8_t plen)
>  	return skb;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but this patch reworks the
firmware receive path, and that path trusts the chunk length the
controller sends.

In process_state_fw_dnld(), SUBSTATE_WAIT_COMMAND only checks len against
its complement before storing it:

	len = get_unaligned_le16(skb->data);
	...
	priv->fw_dnld.chunk_len = len;

so chunk_len can be as large as 0xFFFF. SUBSTATE_WAIT_ACK_CREDIT then does:

	out_skb = alloc_lc_skb(priv, priv->fw_dnld.chunk_len);
	...
	skb_put_data(out_skb,
		     ((uint8_t *)priv->fw_dnld.fw->data) + priv->fw_dnld.offset,
		     priv->fw_dnld.chunk_len);

alloc_lc_skb() takes uint8_t plen, so the skb is sized for
chunk_len & 0xff, but skb_put_data() copies the full chunk_len. Can a
controller that sends a chunk_len above 255 trigger skb_over_panic() here?

Separately, SUBSTATE_WAIT_DATA_CREDIT does:

	priv->fw_dnld.offset += priv->fw_dnld.chunk_len;

Neither offset nor binary_config->offset from the firmware header is ever
checked against fw->size. Can repeated chunks of 255 bytes or less read
past the end of fw->data?

Those bytes go out through nci_send_frame() and nfc_send_to_raw_sock().
On UART the controller can be a pty attached with N_NCI, which has no
capability check. A CAP_NET_ADMIN user still has to start the download
with NFC_CMD_FW_DOWNLOAD.

[ ... ]

> @@ -114,7 +142,11 @@ static void fw_dnld_over(struct nfcmrvl_private *priv, u32 error)
>  		nfcmrvl_chip_halt(priv);
>  	}
>  
> -	nfc_fw_download_done(priv->ndev->nfc_dev, priv->fw_dnld.name, error);
> +	nfc_fw_download_done(priv->ndev->nfc_dev, name, result);
> +
> +	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
> +	fw_dnld->completing = false;
> +	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
>  }

[Severity: Low]
Can a new download get a spurious -EBUSY because of this ordering?

nfc_fw_download_done() clears dev->fw_download_in_progress and multicasts
the genl download-done event before completing is cleared. fw_dnld_over()
does not hold device_lock. An NFC_CMD_FW_DOWNLOAD sent in response to that
event can therefore reach nfcmrvl_fw_dnld_start() while completing is
still true:

	if (fw_dnld->stopping || fw_dnld->active || fw_dnld->completing) {
		res = fw_dnld->stopping ? -ENODEV : -EBUSY;

Userspace has been told the download finished, but the next request fails
with -EBUSY. Swapping the two steps doesn't look safe either: the old
completion could then clear fw_download_in_progress for the new download.

[ ... ]

> @@ -395,62 +439,74 @@ static int process_state_boot(struct nfcmrvl_private *priv,
>  
>  static void fw_dnld_rx_work(struct work_struct *work)
>  {

[ ... ]

> +	skb = skb_dequeue(&fw_dnld->rx_q);
> +	if (!skb)
> +		return;
>  
> -		kfree_skb(skb);
> +	nfc_send_to_raw_sock(priv->ndev->nfc_dev, skb,
> +			     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
> +	switch (fw_dnld->state) {
> +	case STATE_RESET:
> +		ret = process_state_reset(priv, skb);
> +		break;

[Severity: Medium]
Should this worker check starting, active and stopping under rx_lock
before it dequeues?

The reset-pulse hold-off is only enforced where work is queued: in
nfcmrvl_fw_dnld_recv_frame() and in the requeue at the end of this
function. A pending rx_work left over from an earlier download can still
run. fw_dnld_over() cancels timeout_work and purges rx_q, but it never
cancels rx_work:

	cancel_work(&fw_dnld->timeout_work);
	fw_dnld_stop_cmds(priv->ndev);
	skb_queue_purge(&fw_dnld->rx_q);

rx_work can be left pending in two ways:

  - recv_frame queues it behind timeout_work on the ordered rx_wq.
  - recv_frame requeues it while rx_work itself is inside fw_dnld_over(),
    called from process_state_boot() or an error.

If userspace then starts a new download:

nfcmrvl_fw_dnld_start()
    active = true; starting = true;
    nfcmrvl_chip_reset()
        reset asserted, usleep_range(5000, 10000)

        frame arrives, recv_frame queues it without queue_work()
        stale rx_work runs fw_dnld_rx_work()
            skb_dequeue() -> process_state_reset() returns -EINVAL
            fw_dnld_over() -> nfcmrvl_chip_halt()

        reset deasserted
    active == false, so no timer is armed, and start returns 0

Isn't this the case the commit message says it prevents, where an error
path asserts reset and the start path later deasserts it?

Would either of these close it:

  - checking the flags in fw_dnld_rx_work() before skb_dequeue(), or
  - calling cancel_work_sync(&fw_dnld->rx_work) in
    nfcmrvl_fw_dnld_start() before setting starting?

[ ... ]

> @@ -497,6 +592,14 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
>  	if (!firmware_name || !firmware_name[0])
>  		return -EINVAL;
>  
> +	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
> +	if (fw_dnld->stopping || fw_dnld->active || fw_dnld->completing) {
> +		res = fw_dnld->stopping ? -ENODEV : -EBUSY;
> +		spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
> +		return res;
> +	}
> +	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);

[Severity: Medium]
What happens to the NFC core's fw_download_in_progress flag when this
returns -EBUSY for a second download?

nfc_fw_download() does not check for a download that is already running,
and it clears the flag on any driver error:

net/nfc/core.c:nfc_fw_download() {
	...
	dev->fw_download_in_progress = true;
	rc = dev->ops->fw_download(dev, firmware_name);
	if (rc)
		dev->fw_download_in_progress = false;
	...
}

So a second NFC_CMD_FW_DOWNLOAD sent while download A is active gets
-EBUSY. The core then records that no download is in progress, even
though A's state machine and timer are still live.

nfcmrvl_nci_recv_frame() decides where frames go based only on that
flag:

	if (priv->ndev->nfc_dev->fw_download_in_progress) {
		nfcmrvl_fw_dnld_recv_frame(priv, skb);
		return 0;
	}

With the flag cleared, A's frames are dropped and A stalls until the
timeout. On UART, nfcmrvl_nci_uart_tx_start() and
nfcmrvl_nci_uart_tx_done() also stop skipping the BREAK handling partway
through the download.

nfc_dev_up() rejects only on fw_download_in_progress, so the NCI device
can be brought up while A is still active. Later, A's timeout_work reaches
fw_dnld_over() and does two things to the running device:

  - fw_dnld_stop_cmds() sets cmd_cnt to 0, cancels cmd_work and purges
    cmd_q.
  - nfcmrvl_chip_halt() asserts reset underneath it.

Before this patch the second request returned 0 and the flag stayed set.

[ ... ]

> @@ -546,8 +645,24 @@ int nfcmrvl_fw_dnld_start(struct nci_dev *ndev, const char *firmware_name)
>  
>  	/* First, reset the chip */
>  	priv->fw_dnld.state = STATE_RESET;
> +
> +	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
> +	fw_dnld->active = true;
> +	fw_dnld->starting = true;
> +	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);
> +
>  	nfcmrvl_chip_reset(priv);
>  
> +	spin_lock_irqsave(&fw_dnld->rx_lock, flags);
> +	fw_dnld->starting = false;
> +	if (fw_dnld->active) {
> +		mod_timer(&fw_dnld->timer,
> +			  jiffies + msecs_to_jiffies(FW_DNLD_TIMEOUT));
> +		if (!skb_queue_empty(&fw_dnld->rx_q))
> +			queue_work(fw_dnld->rx_wq, &fw_dnld->rx_work);
> +	}
> +	spin_unlock_irqrestore(&fw_dnld->rx_lock, flags);

[Severity: Low]
This is a pre-existing issue, but should frames that arrive while reset is
asserted go to the STATE_RESET handler at all?

nfcmrvl_fw_dnld_recv_frame() keeps frames that arrive during the pulse in
nfcmrvl_chip_reset() in rx_q, and they are processed here once the pulse
ends. A frame received while reset is held is unlikely to be the
post-reset CORE_RESET_NTF. If it doesn't match, process_state_reset()
returns -EINVAL and fw_dnld_over() halts the chip.

Before this patch, the same frames were processed in STATE_RESET straight
away. Purging them may not be right either: the real CORE_RESET_NTF could
arrive between the reset deassert and the spin_lock_irqsave() above.

[ ... ]

> diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
> index 81c760534cf68..02ea3356b2abb 100644
> --- a/drivers/nfc/nfcmrvl/main.c
> +++ b/drivers/nfc/nfcmrvl/main.c
> @@ -185,13 +185,12 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
>  {
>  	struct nci_dev *ndev = priv->ndev;
>  
> +	nfcmrvl_fw_dnld_abort(priv);
>  	nci_unregister_device(ndev);
> +
>  	if (priv->if_ops->nci_quiesce)
>  		priv->if_ops->nci_quiesce(priv);
>  
> -	if (priv->ndev->nfc_dev->fw_download_in_progress)
> -		nfcmrvl_fw_dnld_abort(priv);
> -
>  	nfcmrvl_fw_dnld_deinit(priv);

[Severity: Low]
This isn't a bug, but nfcmrvl_fw_dnld_abort() now runs unconditionally
here, and nfcmrvl_fw_dnld_deinit() calls it a second time a few lines
later:

void nfcmrvl_fw_dnld_deinit(struct nfcmrvl_private *priv)
{
	nfcmrvl_fw_dnld_abort(priv);
	destroy_workqueue(priv->fw_dnld.rx_wq);
}

The deinit call also runs on the nfcmrvl_nci_register_dev() error path,
where no download was ever started. Are both calls needed?

The commit message also doesn't mention two other changes in this patch:

  - fw_dnld_rx_work() no longer drains rx_q in a loop. It processes one
    skb per run and requeues itself.
  - The bad magic/phy path in nfcmrvl_fw_dnld_start() now also clears
    fw_dnld->fw.

The message does describe these changes, which land in the same patch:

  - a positive errno in the download status userspace sees
  - -EBUSY for a second download
  - holding frames during the reset pulse
  - moving timeout completion to a workqueue

That is a lot of behaviour change in one Fixes-tagged patch. Could some of
it be split out so the teardown fix can be reviewed and backported on its
own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104062026.80599-1-shubham%40octane.security
