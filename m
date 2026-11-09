Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254479;
	b=H/ibGgZSkFea6RS9EeWyYIzSaR+CbBeiiMNC5qoQwy7d/Pno1pXgn4T+g2KdRQyJ5ymT
	 yhGa7PINwsi9mFLeImxvS+7FskmMKoh6jxvANadDmsi9Qcyos81hHyc9efZEKK9tgFja9
	 GSv5lpcX2bqpRJ8naM19/KHr3B0hsKPZ9Wr3zpKYsdXY2pywlvB2WARm3rauCY8lLGWlo
	 nv+vxgxK7dOIzXnY/VO7L4SBIsrYWqSLEnor3Gp6eX/KCfmlxoULg3OAuNmSK8YmDHoYs
	 h86zidF4aIgOdOX7vvH/DLLy551L6Eus2Di1EFA7x95SYqbp0o2rDjSuVRhjUo0aKEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=yA23z4yOnKKRlyyLN3GGBrI/kuieXon5A0VUpF0/2ig=;
	b=dmmLXn1D8SkUFGHLKd+nrzuGGE7gLR6crZBqeOx+NHkdoD9466lnIn4+TogP0By3O2I9
	 6mP+P4wZO6skKlGoAM55aLQ+Oqf7jVpaUW+KFhKGp1lTk7/2PRpglBP8BxSI0r0psnc6+
	 7IOpgnVxELPokbFgjX5xtGiXXHgA5Om30QH7hdt9+bGBYhJPfRejYb7O+s2qaQGgX4Yjo
	 l7f0ybgQBr161dKQar2RYg/XaBaTe2DjYLbfSrQlADsF9dCjAL8kS+xmm/EGnnMncQ94T
	 BOsoz3uy2EtucfT8+bclFtRoJGw/UVk9MwaIb9Si+N1JuR0IpZFvg9fwqA+EGSfT5Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RSP7PjJg;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC38606A333
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDC38606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RSP7PjJg
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so822892a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 12:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794254478; x=1794859278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yA23z4yOnKKRlyyLN3GGBrI/kuieXon5A0VUpF0/2ig=;
        b=RSP7PjJgSKGdEsZIhIntAgjQ7XFA1XLJxkZ+5pkFGSlvYOP2v+iCQmVUHXExBjE3Oo
         WS/iFyWLU8VIE0Z/tHaac+s9mVvB6xEHkjePPZl8FkNhMrCq5oiOVVfPLSClRuUDzuPa
         vSnaIZ5dbWaQ+0/e4GgqIEAF9yYxqW1+ycGai5Q46NGEJUv19Of/PMICfMEdHGStXFMf
         uLlFd8b6m44HofFENfcyn5h9Yja+ydUd20utIP2f1ZFfdPcfCdKArk8PEzS1iBdB6GMU
         x46tznanicGEj7xgEFzYezK1uO5xeUW12j/p5dPsPw6Q4YPFT4G4OgWxlEkno9xK8ke2
         dkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254478; x=1794859278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yA23z4yOnKKRlyyLN3GGBrI/kuieXon5A0VUpF0/2ig=;
        b=hiOANdKw4qAYYqcsPjOJVIKCvaubEOvMy7GIwRiKKRr7aeUU8UP8jE9FIZ+GZbLpvr
         6Y/f9IuoCStqIYq4iFv2FEcgvJ9YZyFsuhJ4/gVsHAPNvl1LmeTNpBXBvIVOBxJt7PBb
         4Do2KZ+llKVNGP7SPpoIvhJGpLFEfnqnEbvmZGOmhJtvdgwnl+Gc9ugaSv6mUQjiyATL
         rquVimLGp4l5kb+e2ZL/lzDJw73Hn6g7ssNzwMEseuJiwkVpR7J5GRY58BRjOSjAVVwT
         zL5Re8Di9wquiRGA015VlK5vpJSRwg3N1J58ZJgnnEZGjk8+g6s3xmTiWaGk8pphnVev
         2Kwg==
X-Gm-Message-State: APuU4Z/+MiJ83bSXwkjJs8ta6R+Acj5RwgGicNvErfKCBnNGWsWhXljg
	ZRn/Ep/1ssZ4qJUR8DsRbscXn2SFqEwkIG94RK28U4PtIjvkeMDIVtATDaoRFJacNNs=
X-Gm-Gg: AYBFou3q7Cb8PcjgV5wx9d7FhtR52PkJs8TqEoB+iyLbeh0sCwlX13RQs7lsci7nwjm
	bgIUZ+b+nOM/X5zMc5ulhxLVh516F9AVkUz/M+InFI7MxdvSm2p6BLkkRei1lRbnJtgo0kdyC17
	EpTRE5Bm/rUJALOBIMiA/zwtIGEkhWxi98Pr6QJLqlrDYnJwQMatnSITYSZuPoKc0W1PsFa9AnI
	o5cyw2aaXOlGJ3Xv5rUw+IwPGOxmpTFZjNBmLA9WXCCIzyOEmo0Ho3+YCVZ4vmX89J09u2PkgnZ
	qoHVANTAoqFPB0mb7FluBtwSryWtBCfQ7O1HtfDrNZyWX+ZiF2IAkwcjkqxlAmDGAQr6lrgJGzw
	3zSRSMXAyJl9e1+18F8PHEpbhl0Qk9JtDGMfAoC5l1LSeSrrVP8MQKvWlKQrUcs1v6q7iVmld8+
	fluV/1Yj1R7R/vBt4PZikkJ9NHnfm3Zi55qJ/C4Zol9t8fEW1Q6m8kojIPtbrsyRmyZqHHRJPvH
	cclxMkCY56+gKJOEcece6oiYWKOcLbQbX28SkgTzSO+BnSULJsYfTYltfM67lsoHq+aWX/c77LG
	nC8viCDV6RV7DO9jdTF34jVGepWK8JnxJT+8XNd4
X-Received: by 2002:a17:90b:57ec:b0:3b0:9fbf:894c with SMTP id 98e67ed59e1d1-3b166cde77dmr665628a91.17.1794254478070;
        Mon, 09 Nov 2026 12:01:18 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16790ff7esm743210a91.9.2026.11.09.12.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 12:01:17 -0800 (PST)
Date: Mon, 9 Nov 2026 12:01:16 -0800
From: Joe Damato <joe@dama.to>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, prashant@broadcom.com, edumazet@google.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 4/4] bnxt_en: refuse to open a device with stopped
 DMA
Message-ID: <avImjJ+PNQBhGwXT@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, prashant@broadcom.com, edumazet@google.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
References: <20261106191423.4194081-5-joe@dama.to>
 <179408153359.994134.12098598533748017138@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179408153359.994134.12098598533748017138@kernel.org>

On Sat, Nov 07, 2026 at 07:58:53PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch blocks driver recovery after a full device reset.
> - [Medium] bnxt_en: missing BNXT_STATE_DMA_STOPPED check in
>   BNXT_NO_FW_ACCESS()
> 
> --
> 
> bnxt_en: refuse to open a device with stopped DMA
> 
> This adds a BNXT_STATE_DMA_STOPPED bit. bnxt_stop_dma() sets it after
> the firmware fails to free rings and bus mastering is cleared. While the
> bit is set, bnxt_open(), bnxt_open_nic() and bnxt_half_open_nic() refuse
> to open the device, so the user has to rebind the driver.
> 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index b5ef86bf92bf5..eb885fd74064f 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -7833,9 +7833,20 @@ static void bnxt_stop_dma(struct bnxt *bp)
> >  {
> >  	netdev_err(bp->dev,
> >  		   "Disabling DMA before releasing ring memory, the driver must be rebound to recover\n");
> > +	set_bit(BNXT_STATE_DMA_STOPPED, &bp->state);
> >  	pci_clear_master(bp->pdev);
> >  }
> 
> [Severity: Medium]
> Once bnxt_stop_dma() has cleared bus mastering, can any later HWRM
> command complete? The firmware writes HWRM responses into host memory
> by DMA. With BNXT_FW_CAP_SHORT_CMD it also fetches the request by DMA.
> With the master bit cleared, __hwrm_send() should just poll until
> each command times out.
> 
> BNXT_NO_FW_ACCESS() only tests BNXT_STATE_FW_FATAL_COND and
> pci_channel_offline(). The new BNXT_STATE_DMA_STOPPED bit is never
> consulted there, so nothing stops these commands from being sent.
> 
> After the failed ring free, __bnxt_close_nic() continues into
> bnxt_free_mem(), which calls bnxt_free_ntp_fltrs() and
> bnxt_free_l2_filters(). bnxt_close() then sends
> bnxt_hwrm_shutdown_link() and bnxt_hwrm_if_change(). The netif_close()
> teardown after a failed bnxt_open_nic() goes through the same path.
> 
> Suppose the user follows the log message and rebinds the driver.
> bnxt_remove_one() still sends bnxt_hwrm_func_drv_unrgtr() and the rest
> of the teardown commands, and each of them waits for its full timeout
> too.
> 
> Most of this runs under rtnl_lock and the netdev instance lock. Every
> stalled command lengthens how long those locks are held. Close and
> unbind of a device that has already failed can therefore take a long
> time.
> 
> Should BNXT_NO_FW_ACCESS() also test BNXT_STATE_DMA_STOPPED, so that
> __hwrm_send() fails these commands immediately? If so, the bit would
> have to be cleared wherever bus mastering is turned back on:
> bnxt_fw_reset_task(), bnxt_resume() and bnxt_io_slot_reset().
> Otherwise the HWRM commands those paths send right after
> pci_set_master() would be refused as well.

I think this is legit and BNXT_NO_FW_ACCESS should test
BNXT_STATE_DMA_STOPPED. So, I'll do that in the next version.

> [ ... ]
> 
> > @@ -13505,6 +13521,10 @@ static int bnxt_open(struct net_device *dev)
> >  	struct bnxt *bp = netdev_priv(dev);
> >  	int rc;
> >  
> > +	rc = bnxt_check_dma_stopped(bp);
> > +	if (rc)
> > +		return rc;
> > +
> >  	if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
> >  		rc = bnxt_reinit_after_abort(bp);
> >  		if (rc) {
> 
> [Severity: Medium]
> Nothing in the driver clears BNXT_STATE_DMA_STOPPED. That includes the
> paths that fully reset the device and call pci_set_master() again.
> 
> This check also runs before bnxt_reinit_after_abort() and
> bnxt_hwrm_if_change(). Could that make the firmware reset, resume and AER
> recovery paths fail every time?
> 
> In a non-fatal firmware reset, bnxt_fw_reset_close()->__bnxt_close_nic()
> still sends HWRM_RING_FREE. Ring free is only skipped for FW_FATAL_COND
> or when the PCI channel is offline. If ring free fails there:
> 
> __bnxt_close_nic()
>     if (bnxt_shutdown_nic(bp, irq_re_init))
>         bnxt_stop_dma(bp);
> 
> bnxt_fw_reset_task() then turns bus mastering back on and waits for the
> firmware to come up, but the open is refused:
> 
> bnxt_fw_reset_task()
>     pci_set_master(bp->pdev);
>     ...
>     case BNXT_FW_RESET_STATE_OPENING:
>         ...
>         rc = bnxt_open(bp->dev);
>         if (rc) {
>             netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
>             bnxt_fw_reset_abort(bp, rc);
> 
> Suspend/resume looks similar. bnxt_suspend()->bnxt_close() can set the
> bit, and then bnxt_resume() does:
> 
> bnxt_resume()
>     pci_set_master(bp->pdev);
>     if (bnxt_hwrm_ver_get(bp)) {
>     ...
>     rc = bnxt_hwrm_func_reset(bp);
>     ...
>     if (netif_running(dev)) {
>         rc = bnxt_open(dev);
> 
> A rebind runs the same pci_set_master() plus HWRM_FUNC_RESET sequence, in
> bnxt_init_board() and bnxt_fw_init_one_p1(). Even so, bnxt_open() fails
> here and the netdev stays detached.
> 
> AER has the same problem. Suppose an earlier failed close left the bit
> set. bnxt_io_slot_reset() hard resets the slot, calls pci_set_master()
> and then bnxt_hwrm_func_reset(). After that, bnxt_io_resume()->bnxt_open()
> and any later ifup are still refused.
> 
> With only the preceding commit "bnxt_en: stop DMA before releasing rings
> the firmware did not free", these paths turned bus mastering back on and
> bnxt_open() succeeded.
> 
> The fatal firmware error path already handles a similar case.
> bnxt_fw_fatal_close() calls pci_disable_device(), and the reset task
> later calls pci_set_master() and reopens the device.
> 
> The commit message says "the device needs manual intervention by the
> user to become usable again". Does that still hold once the firmware or
> the function has been reset?
> 
> Should the bit be cleared, or the check skipped, after a firmware reset,
> HWRM_FUNC_RESET or slot reset completes?

IMHO, this behavior is intentional. If ring free fails for some reason the
device is intentionally left unrecoverable without manual intervention.

It's not clear to me if other paths should be able to clear the bit and
re-enable DMA.

So, I think I'm going to disagree with Sashiko on this one.

pw-bot: cr
