Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081535;
	b=pIj66W+f3uPt0egr7HvrkpDEMlPPjUTW2oZQROKN7siXpC4SZY5XRZOh0bneo7Jb/bZm
	 VLXF3XWn5rpcfyws768xglWw/DJJz7u8MTkcVFgbw17QLwUXikQK5xEEc7hh/8dQLxJe1
	 I5g0VRdxlfhQ2mZCTBVZgQD513SAXpGuKRT5wYqD911aQAyr7imEHOeVAnBwFvGh7qifG
	 9uod4Z77KvqbYMJtH2OkdK8HmqXauG+VGyU1uj1Yrp4+xQYYcm7NRI+/bkZyBuTmGAB4l
	 pkwnYgF4ADpv2FYOIWrmgxOFX2uLTOSq7uTcWtnFHHPrGy7ABh2p6+GrahuwGzWsHYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081535;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hgSgLs2bBvsbEokhU33zWYCtHCmVsL0KnjvQIpaRhJ8=;
	b=VOTXW0bRHasl7RXdm9BfO2x+au+Znp13YPbXJ5UoN9NKLnjmFPhQNSGjgHzr9JVLKKzd
	 PDbrN6kZHv1fdnHJf7o9a5OdBsCnItL1grB07j2UUF2VBz8UwiCyYCv1vRIUAvuR7nXsI
	 FyP4/8c4bapWaM0Mo7gGI4wqZtFCIoXTs+GFCQbLEkrcpLpP/39IxJkMEVNBmqS07I3Dh
	 Ebfz77K0T0Mo02YS/PwmVcKqr5mccu1JeR2e2WsZhfVvXt9mQh6wMgb6SWY51zAYpHbnl
	 zgJxX1BjblocYbS0Z0/pbv7yxRDGmPL03Ls709WBn1IBHJBA+Q0W8me95Ao8BgtVotg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PB5FaxbK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432D606A33C;
	Sat,  7 Nov 2026 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PB5FaxbK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BD81F008A3;
	Sat,  7 Nov 2026 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081534;
	bh=hgSgLs2bBvsbEokhU33zWYCtHCmVsL0KnjvQIpaRhJ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PB5FaxbKA8ewEq1APQDbqLtrdeTKZ67fHW1MZRh1VXg1rCDAIu5jmtJzD/8lITRFZ
	 +qFdm5rOqaPE9maHAyklOZJDddXMabGKHTvZK+5xpf80r3rBhAKZ+dGcjdfKfRJWAk
	 GT1i8Jwz1AsdwQImfnk7qyQKrMv0JGao6B+OWkrh/4idW84sxPSmlOqjdEIb5vAVHv
	 4KkUTdF+lKokvRNRmVNI8TuOmhNz/q4atQoV4wiZGpTqIiY9RruMJBfHxtcvU2umU9
	 br3DI4MFyWnnS0RxJJWbbrFQL62fnAaYZKvKaFRjHQb84PsIZVojHBxbST1enRxGTE
	 6Np5MW2c59P5Q==
Subject:
 Re: [PATCH net v5 4/4] bnxt_en: refuse to open a device with stopped DMA
From: netdev-bot+sashiko@kernel.org
To: joe@dama.to
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 prashant@broadcom.com, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 19:58:53 +0000
Message-ID: <179408153359.994134.12098598533748017138@kernel.org>
In-Reply-To: <20261106191423.4194081-5-joe@dama.to>
References: <20261106191423.4194081-5-joe@dama.to>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch blocks driver recovery after a full device reset.
- [Medium] bnxt_en: missing BNXT_STATE_DMA_STOPPED check in
  BNXT_NO_FW_ACCESS()

--

bnxt_en: refuse to open a device with stopped DMA

This adds a BNXT_STATE_DMA_STOPPED bit. bnxt_stop_dma() sets it after
the firmware fails to free rings and bus mastering is cleared. While the
bit is set, bnxt_open(), bnxt_open_nic() and bnxt_half_open_nic() refuse
to open the device, so the user has to rebind the driver.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index b5ef86bf92bf5..eb885fd74064f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7833,9 +7833,20 @@ static void bnxt_stop_dma(struct bnxt *bp)
>  {
>  	netdev_err(bp->dev,
>  		   "Disabling DMA before releasing ring memory, the driver must be rebound to recover\n");
> +	set_bit(BNXT_STATE_DMA_STOPPED, &bp->state);
>  	pci_clear_master(bp->pdev);
>  }

[Severity: Medium]
Once bnxt_stop_dma() has cleared bus mastering, can any later HWRM
command complete? The firmware writes HWRM responses into host memory
by DMA. With BNXT_FW_CAP_SHORT_CMD it also fetches the request by DMA.
With the master bit cleared, __hwrm_send() should just poll until
each command times out.

BNXT_NO_FW_ACCESS() only tests BNXT_STATE_FW_FATAL_COND and
pci_channel_offline(). The new BNXT_STATE_DMA_STOPPED bit is never
consulted there, so nothing stops these commands from being sent.

After the failed ring free, __bnxt_close_nic() continues into
bnxt_free_mem(), which calls bnxt_free_ntp_fltrs() and
bnxt_free_l2_filters(). bnxt_close() then sends
bnxt_hwrm_shutdown_link() and bnxt_hwrm_if_change(). The netif_close()
teardown after a failed bnxt_open_nic() goes through the same path.

Suppose the user follows the log message and rebinds the driver.
bnxt_remove_one() still sends bnxt_hwrm_func_drv_unrgtr() and the rest
of the teardown commands, and each of them waits for its full timeout
too.

Most of this runs under rtnl_lock and the netdev instance lock. Every
stalled command lengthens how long those locks are held. Close and
unbind of a device that has already failed can therefore take a long
time.

Should BNXT_NO_FW_ACCESS() also test BNXT_STATE_DMA_STOPPED, so that
__hwrm_send() fails these commands immediately? If so, the bit would
have to be cleared wherever bus mastering is turned back on:
bnxt_fw_reset_task(), bnxt_resume() and bnxt_io_slot_reset().
Otherwise the HWRM commands those paths send right after
pci_set_master() would be refused as well.

[ ... ]

> @@ -13505,6 +13521,10 @@ static int bnxt_open(struct net_device *dev)
>  	struct bnxt *bp = netdev_priv(dev);
>  	int rc;
>  
> +	rc = bnxt_check_dma_stopped(bp);
> +	if (rc)
> +		return rc;
> +
>  	if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
>  		rc = bnxt_reinit_after_abort(bp);
>  		if (rc) {

[Severity: Medium]
Nothing in the driver clears BNXT_STATE_DMA_STOPPED. That includes the
paths that fully reset the device and call pci_set_master() again.

This check also runs before bnxt_reinit_after_abort() and
bnxt_hwrm_if_change(). Could that make the firmware reset, resume and AER
recovery paths fail every time?

In a non-fatal firmware reset, bnxt_fw_reset_close()->__bnxt_close_nic()
still sends HWRM_RING_FREE. Ring free is only skipped for FW_FATAL_COND
or when the PCI channel is offline. If ring free fails there:

__bnxt_close_nic()
    if (bnxt_shutdown_nic(bp, irq_re_init))
        bnxt_stop_dma(bp);

bnxt_fw_reset_task() then turns bus mastering back on and waits for the
firmware to come up, but the open is refused:

bnxt_fw_reset_task()
    pci_set_master(bp->pdev);
    ...
    case BNXT_FW_RESET_STATE_OPENING:
        ...
        rc = bnxt_open(bp->dev);
        if (rc) {
            netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
            bnxt_fw_reset_abort(bp, rc);

Suspend/resume looks similar. bnxt_suspend()->bnxt_close() can set the
bit, and then bnxt_resume() does:

bnxt_resume()
    pci_set_master(bp->pdev);
    if (bnxt_hwrm_ver_get(bp)) {
    ...
    rc = bnxt_hwrm_func_reset(bp);
    ...
    if (netif_running(dev)) {
        rc = bnxt_open(dev);

A rebind runs the same pci_set_master() plus HWRM_FUNC_RESET sequence, in
bnxt_init_board() and bnxt_fw_init_one_p1(). Even so, bnxt_open() fails
here and the netdev stays detached.

AER has the same problem. Suppose an earlier failed close left the bit
set. bnxt_io_slot_reset() hard resets the slot, calls pci_set_master()
and then bnxt_hwrm_func_reset(). After that, bnxt_io_resume()->bnxt_open()
and any later ifup are still refused.

With only the preceding commit "bnxt_en: stop DMA before releasing rings
the firmware did not free", these paths turned bus mastering back on and
bnxt_open() succeeded.

The fatal firmware error path already handles a similar case.
bnxt_fw_fatal_close() calls pci_disable_device(), and the reset task
later calls pci_set_master() and reopens the device.

The commit message says "the device needs manual intervention by the
user to become usable again". Does that still hold once the firmware or
the function has been reset?

Should the bit be cleared, or the check skipped, after a firmware reset,
HWRM_FUNC_RESET or slot reset completes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106191423.4194081-1-joe%40dama.to
