Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583771;
	b=ghLkfcR5hk6FAdydEj8um6Tyz1BreesipbHonqGU9EADP/bI38aSdIYlqEiNKTAGWfsJ
	 wNV5iyU/Vmv7osxBCOHyyLgAtds6uNehB2wBexzlTiBuc0dQXPg4Y09Vmnxa44/bB9b0m
	 75m3IoLQacz5gOJ5WPRcvwDmuZu9nZrXh21L2BONpZkpMYDhTRs7LqxKFOv0wG8J+5GVV
	 TePnw250SPuqobCPJ4sEqaAuBB6CuCDzMXvy9K+OqsbuFT0pXPiRRIYq3vfyPW0DPkQVU
	 FvmXZsHvPCql612/bKYimWC9cc0WClIepEkwokHRwn2XEWmDdLmW4BrWV+y15YF3dVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583771;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BTkJC8s4WBUQSv2ioKOXw+pm/DZEGYvHG+GtGNfDTus=;
	b=1jpKpkAbE2bj1r6BcA1NWsN6lqVwN6BCxx/HJ2csSxSccXJdU7EeSjivJ2LmwxfzLtzP
	 qu5xTT2iGPX+hgbc1nW/VLTwXEMApVpVLHGjB/3XZcjxYKeaXlYxUydBLpetwXjNqbQW8
	 jFbrFuTlbC1NpudVm3hlvPdJbA2H5PNb1nZytox3zQzBdYgrIrlkQraYdXtEwhGNb21Y7
	 J1x2w1lpYU8vNpnx6GXRXQPmIEM5821YTmJHR1BpCHtZy1mFK6hWbrb7gRauEqfcdzczC
	 IPIlx3BJlig4dnoytlEyKeyTwgCRH6Y2mY3HR657BZ75g6JKJtTdP7kBPmci36N9zLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkIrD3F4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0EA606A319;
	Wed, 21 Oct 2026 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkIrD3F4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C722F1F000C4;
	Wed, 21 Oct 2026 11:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583771;
	bh=BTkJC8s4WBUQSv2ioKOXw+pm/DZEGYvHG+GtGNfDTus=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lkIrD3F48e8ap5N3y3FBbxPBKmdbtT5xKeij5K2S9jZpLc0x2dMeWkWf4Rmnqp9l+
	 BYPgS2yiDCzY62xVinrqjkYzuLf/6D3RKksiLEiMOyl56BkPCjURqSOlyVa9d2ugYp
	 KV5jGgOLkYrylOSq1F6+Lz5xKG2W3pHK/8wnb9kRzl6+bkRCas4qGJYLjIrxl/ZtBG
	 0eY8OBAyvSJUE+w1Ls4mngKIG2yiyXQRdayzNFkrwTOM20scNS0Gxs1lmxMdYHsXPI
	 SmV54p6g/zNNxYozOtVYRwaAVniXh2pkX5OI7GeAhNytCoXIfVXh/V129JTygHGoMv
	 uiI2MI6UTFPcA==
Subject:
 Re: [PATCH] nfc: pn533: bound the OUT URB wait in pn533_usb_send_frame()
From: netdev-bot+sashiko@kernel.org
To: ngocthang2710.1999@gmail.com
Cc: david@ixit.cz, netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
 linux-kernel@vger.kernel.org, linuxlovemin@yonsei.ac.kr,
 syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com, kuba@kernel.org
Date: Wed, 21 Oct 2026 11:56:10 +0000
Message-ID: <179258377031.3135.2890064388846476479@kernel.org>
In-Reply-To: <20261019145505.176036-1-ngocthang2710.1999@gmail.com>
References: <20261019145505.176036-1-ngocthang2710.1999@gmail.com>
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

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only bounds the bulk OUT stage, so probe() can still
  hang forever under the USB device lock.
- [High] The new -ETIMEDOUT return from pn533_usb_send_frame()
  (usb.c:188-191) is not unwound correctly when the command was queued.
- [Medium] The timeout path in pn533_usb_send_frame() (usb.c:188-191)
  returns -ETIMEDOUT without checking what actually happened to the OUT…

--

nfc: pn533: bound the OUT URB wait in pn533_usb_send_frame()

This patch replaces the unbounded wait_for_completion() on the bulk OUT
URB in pn533_usb_send_frame() with a 5000ms wait_for_completion_timeout().
When the timeout expires, it kills the URB and returns -ETIMEDOUT. The
goal is to stop probe() from hanging with the USB device lock held when
the device never completes the OUT transfer.

Closes: https://syzkaller.appspot.com/bug?extid=1c5368988052dc2d8201

> diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
> index efb07f944fce..569b1915afc9 100644
> --- a/drivers/nfc/pn533/usb.c
> +++ b/drivers/nfc/pn533/usb.c
> @@ -184,7 +184,12 @@ static int pn533_usb_send_frame(struct pn533 *dev,
>  	if (rc)
>  		return rc;
>  
> -	wait_for_completion(&arg.done);
> +	/* device may never ack the OUT transfer: don't hang probe() */
> +	if (!wait_for_completion_timeout(&arg.done, msecs_to_jiffies(5000))) {
> +		usb_kill_urb(phy->out_urb); /* waits for the handler, so &arg can't outlive us */

[Severity: Medium]
Can this report a failure for a transfer that actually succeeded? The HCD
can give back out_urb with status 0 after wait_for_completion_timeout()
returns 0 but before usb_kill_urb() runs. In that case usb_kill_urb() does
nothing, and the function still returns -ETIMEDOUT.

__pn533_send_async() or pn533_wq_cmd() then frees the cmd and clears
dev->cmd, and no in_urb gets submitted. The chip still sends an ACK and a
response for the command it received. Those would then be read as the
reply to the next command. That command would fail with -EIO, or get
stale data if its command code is the same.

The commit message cites usb_bulk_msg() as precedent. Its helper,
usb_start_wait_urb(), checks the real completion status after the kill:

drivers/usb/core/message.c:usb_start_wait_urb() {
    ...
	if (rc <= 0) {
		usb_kill_urb(urb);
		if (ctx.status != -ENOENT)
			retval = ctx.status;
		else if (rc == 0)
			retval = -ETIMEDOUT;
    ...
}

Could the same be done here? For example, pn533_out_complete() could
record the URB status in struct pn533_out_arg.

The kill could also land after some max-packet chunks of a multi-packet
frame have already been accepted. That would leave the chip holding a
partial frame, or an ACR122 CCID message shorter than dwLength. Should the
timeout path resync the chip? pn533_usb_abort_cmd() and
pn533_usb_send_ack() already send an ACK abort frame for non-ACR122
devices.

> +		phy->out_urb->context = cntx;
> +		return -ETIMEDOUT;

[Severity: High]
The commit message says -ETIMEDOUT is something "__pn533_send_async()
already unwinds". Is that accurate for every caller? It holds for the
direct send path. A queued command, though, is sent from pn533_wq_cmd(),
and its error branch looks like this:

drivers/nfc/pn533/pn533.c:pn533_wq_cmd() {
    ...
	rc = pn533_send_cmd_frame(dev, cmd);
	if (rc < 0) {
		dev->cmd = NULL;
		dev_kfree_skb(cmd->req);
		kfree(cmd);
		return;
	}
}

That branch never calls cmd->complete_cb and never clears
dev->cmd_pending.

Queuing can happen during probe. pn533_wq_cmd_complete() wakes the sync
waiter before cmd_work runs:

	rc = pn533_send_async_complete(dev);
	if (rc != -EINPROGRESS)
		queue_work(dev->wq, &dev->cmd_work);

dev->cmd_pending is only cleared in pn533_wq_cmd(), and only when the
queue is empty. So the probe thread can issue its next sync command from
pn533_setup() (for example via pn533_set_configuration()) while
cmd_pending is still 1. __pn533_send_async() then queues that command
instead of sending it.

If that command's OUT URB then hits this new timeout, can the probe
thread get stuck forever in wait_for_completion(&arg.done) inside
pn533_send_cmd_sync()?

Outside of probe, would async callers leak their complete_cb_context?
And would cmd_pending stay at 1, so every later command is queued and
never sent?

Before this patch, the pn533_wq_cmd() error branch was only reachable
when usb_submit_urb() failed.

> +	}
>  	phy->out_urb->context = cntx;
>  
>  	if (dev->protocol_type == PN533_PROTO_REQ_RESP) {

[Severity: High]
Does this fully stop probe() from hanging? pn533_out_complete() calls
complete() for any URB status. Once out_urb completes, nothing here checks
out_urb->status. The function submits in_urb for the ACK or the response
and returns 0.

The probe thread then waits here:

drivers/nfc/pn533/pn533.c:pn533_send_cmd_sync() {
    ...
	rc = pn533_send_cmd_async(dev, cmd_code, req,
				  pn533_send_sync_complete, &arg);
    ...
	wait_for_completion(&arg.done);
    ...
}

That completion is only signalled from cmd_complete_work. cmd_complete_work
is only queued when in_urb completes, via pn533_recv_ack() or
pn533_recv_frame(). The USB transport has no command timeout, and
abort_cmd is only called from the poll and listen paths.

So a device that accepts (or stalls) the bulk OUT transfer but never sends
anything on bulk IN could still hang this chain:

pn533_usb_probe()
  pn533_finalize_setup()
    pn533_get_firmware_version()
      pn533_send_cmd_sync()
        wait_for_completion(&arg.done)

That would happen inside hub_event() with the USB device lock held. Isn't
that the same hang the commit message describes? Would the wait need to be
bounded, or the command aborted, at the pn533_send_cmd_sync() level
instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019145505.176036-1-ngocthang2710.1999%40gmail.com
