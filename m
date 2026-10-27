Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070538;
	b=3Je1YauG15sxaiNqKbC9bDmJYjDFaIVIHnVff2H9JBpT5Rvhl3muiXazSYANcetXR9bY
	 v4bP2yLIr7nuvl4QVAmoDD9pXS1l1+LlXUpPL2XJNwM2LdtbXXAtCSlRgKgFyJoRliQ6k
	 wOdj22HmnTr1kuX9ZHu1Wlzew633Pap91NdLjV6hMvuzAyz9IHoRIaiDQ1ZfKLU40e9Bi
	 c17eyh0uIru+p/Oo77JVCHciWYOHCrMZgqzv0ze0hyc39Q6cWILmEW74lOfZi4lFzJDD5
	 YbTU3RR3soQgzqkHDvLTMNyRHNiEjflb+yD6Apzy+4ur1GPvPDxoWomiAx4SosAkWOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070538;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PdnQPdsyhOpvvgJFy4Pjq8S8zsgdfU5diJfPXnQoNNE=;
	b=0BSlcl9IDHyc37s++2F2cCbuVnhAX8XOuLJL9nBGEY6ELAXqDT7fCQ6sjQk9B/EiQdRS
	 lTIdlbo0rGkT2XhZ2buSCkp9+A+dqtOX03/rgr1xj+6Z4vtAz80shYv6gCPWWWvqT2xIM
	 4/8TUkzBNFfoMFHn4pTsDt8NNYieOH8wBSr+V8rkYvZKKtHL3OdwiJRHBr7E208uxmY+K
	 dD1BZXTlcA9jxI8khJk+VlQl8qfjMNATGh/3rSX71MjHjcV3g9rl3zTx0gGbf+sqiGmOf
	 /F2dLf3UmVj1T00siBCIKY/toq4py09usyEqCKJrHPOfMX2jaL+STXKirsIGpcz7Vgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4xaoeCD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E8606A31A;
	Tue, 27 Oct 2026 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4xaoeCD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1521F01825;
	Tue, 27 Oct 2026 03:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793070537;
	bh=PdnQPdsyhOpvvgJFy4Pjq8S8zsgdfU5diJfPXnQoNNE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m4xaoeCDTUR4dgp7JktG/P3IXHtzRTJvBrHGTH6WQbiWuuRoAP704ncSFrX8BFs9g
	 zfijnMDFC2s1E/ReKbVHn34s0uU/3tkVYKGIm6eUmaLzZ2Akz1iXowvit6ZBX4Yhux
	 WW+xhJJe7cdQ75AGMUbyw82PnP2jvkWQ9JjIO4QRkXUHC0UpwJZbZIZfEoou00bs/H
	 inNlhECnVj/Xfg+gnigdHmxWUXY+r9xou/ld9GSMiPUZed/W2Pgi5sNz8Bw214ILX9
	 S++ImuUU51jOLDhKKuv4UmGnT+wfYM6VBDevMYKZsOyrAOPfiOj4TGhhtKt6YgER0p
	 NYKDnYB5MqdFg==
Subject: Re: [PATCH] nfc: pn533: add timeout to USB frame send completion wait
From: netdev-bot+sashiko@kernel.org
To: zhaofeng2@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 linux-kernel@vger.kernel.org,
 syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com, kuba@kernel.org
Date: Tue, 27 Oct 2026 03:08:56 +0000
Message-ID: <179307053679.3134.14492885629623051321@kernel.org>
In-Reply-To: <20261023025602.1746-1-zhaofeng2@cmss.chinamobile.com>
References: <20261023025602.1746-1-zhaofeng2@cmss.chinamobile.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch gives the device a new way to trigger a failure
  (-ETIMEDOUT from pn533_usb_send_frame() when OUT stalls for more than…
- [Medium] On timeout, pn533_usb_send_frame() calls
  usb_kill_urb(phy->out_urb) and returns -ETIMEDOUT unconditionally.
- [Low] Missing Fixes: tag (and Cc: stable).

--

nfc: pn533: add timeout to USB frame send completion wait

This patch replaces the unbounded wait for the out URB in
pn533_usb_send_frame() with a 1 second timeout. On timeout the URB is
killed and -ETIMEDOUT is returned, so a device that never completes the
transfer no longer hangs probe or the command in progress.

Closes: https://syzbot.org/bug?extid=1c5368988052dc2d8201

> Reported-by: syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=1c5368988052dc2d8201
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

[Severity: Low]
Should this have a Fixes: tag and Cc: stable? The unbounded
wait_for_completion(&arg.done) and the context save/restore around it
came from:

Fixes: 9dab880d675b ("nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()")

> diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
> index efb07f944fce2..60e80e818d2e6 100644
> --- a/drivers/nfc/pn533/usb.c
> +++ b/drivers/nfc/pn533/usb.c

[ ... ]

> @@ -184,7 +187,12 @@ static int pn533_usb_send_frame(struct pn533 *dev,
>  	if (rc)
>  		return rc;
>  
> -	wait_for_completion(&arg.done);
> +	if (!wait_for_completion_timeout(&arg.done,
> +					 msecs_to_jiffies(PN533_USB_SEND_TIMEOUT_MS))) {
> +		usb_kill_urb(phy->out_urb);
> +		phy->out_urb->context = cntx;
> +		return -ETIMEDOUT;
> +	}
>  	phy->out_urb->context = cntx;
>  
>  	if (dev->protocol_type == PN533_PROTO_REQ_RESP) {

[Severity: Medium]
Is it safe to return -ETIMEDOUT here without checking the final status
of out_urb?

The OUT transfer can complete between wait_for_completion_timeout()
returning 0 and the call to usb_kill_urb(). In that case usb_kill_urb()
returns at once because pn533_out_complete() has already run. The device
has the whole command, but the caller is told the send failed.
usb_start_wait_urb() looks at the URB status after killing it on timeout
for this reason.

A PN533 frame can also span several 64-byte bulk packets. The device may
accept part of the frame before it stalls, which leaves a partial frame
in its parser.

In both cases the early return skips pn533_submit_urb_for_ack() and
pn533_submit_urb_for_response(), so the device's ACK or response is
never read. __pn533_send_async() then does:

	rc = pn533_send_cmd_frame(dev, cmd);
	if (rc) {
		dev->cmd = NULL;
		goto error;
	}

This leaves cmd_pending at 0, so the next command is sent right away.
Its pn533_recv_ack() would see the stale ACK, and its in_urb would get
the abandoned command's response. pn533_recv_frame() only compares the
command code:

	} else if (!pn533_rx_frame_is_cmd_response(dev, skb->data)) {
		nfc_err(dev->dev, "It it not the response to the last command\n");
		dev->cmd->status = -EIO;
	}

When two commands in a row share a code, such as repeated InDataExchange
from pn533_transceive(), could the stale response be accepted as the
reply to the new request? The driver would then stay one response
behind. Commands with different codes would fail with -EIO instead.

The driver already has a protocol-level abort, pn533_usb_send_ack(),
which pn533_usb_abort_cmd() uses. The comment in pn533_usb_abort_cmd()
also says ACR122U sends broken responses when URBs are cancelled before
the chip responds.

Should the timeout path send the ACK abort or reset the device so that
the two sides stay in step?

[Severity: High]
Does the commit message claim that "the command in progress fails
gracefully instead of hanging the task" hold for queued commands?

When dev->cmd_pending is set, __pn533_send_async() adds the command to
dev->cmd_queue and returns 0. pn533_send_cmd_sync() then sleeps in:

	wait_for_completion(&arg.done);

Later pn533_wq_cmd() takes the command off the queue and sends it. If
pn533_usb_send_frame() now returns -ETIMEDOUT, the error path in
pn533_wq_cmd() is:

	rc = pn533_send_cmd_frame(dev, cmd);
	if (rc < 0) {
		dev->cmd = NULL;
		dev_kfree_skb(cmd->req);
		kfree(cmd);
		return;
	}

This path never calls cmd->complete_cb, never clears cmd_pending and
never re-queues cmd_work.

Could the pn533_send_cmd_sync() caller then sleep in
TASK_UNINTERRUPTIBLE forever? That is the same hung task, just moved to
the nfc netlink caller.

One way to reach it:

nfc_dev_down()
  pn533_stop_poll()   (abort_cmd is a no-op on ACR122U, poll stays pending)
  pn533_dev_down()
    pn533_rf_field()
      pn533_set_configuration()
        pn533_send_cmd_sync()   (queued behind the pending command)

Async callers are affected too:

- The pn533_data_exchange_arg allocated by pn533_transceive() would
  leak, and its data_exchange callback would never run. For rawsock this
  also leaks the sock_hold() reference.
- With cmd_pending stuck at 1, every later command is queued and never
  sent until unbind.
- pn53x_common_clean() then frees the queued cmds without freeing their
  cmd->req skbs.

The pn533_wq_cmd() error handling is older than this patch, but this
patch lets the device trigger it. Should pn533_wq_cmd() call
cmd->complete_cb with ERR_PTR(rc) and keep the queue moving as part of
this fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023025602.1746-1-zhaofeng2%40cmss.chinamobile.com
