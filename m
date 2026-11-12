Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486189;
	b=Msbi612K2CE+Syl42iT5Dj3Nawcr5phdHieIk8Ztwc0ya/rmOxp6uNRGkvK4EkAHVf0x
	 EeCaWcc0a7RG0UcZz5X0A7k3ZKaBPT+0q5+Ljyo/xj3ckRUbFxeAcghoH29jAhpSeAQWy
	 WPlScPmqnu0SZxy7CUGn6jW7sQh8XadxwXklsfnU+jNNxkOa7AREYpzO0KHuga+70yz21
	 rc1fs747BgAPHQdn1jGeFcama0SQmIAPKA/PJVP1YmSxx1828YWu95SRIbd5ujfwXrh7g
	 /pUV9X41hlJL1VaSZgUAareSBWWLjuIMK1oqBeaOt7G0p2zPKFyAgxGIVzgUn4ICsXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486189;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KpzQJ/36NPPoj35pHGGkhA9wZAXFfZpjDBO8olMqC54=;
	b=q5zIRSSonfqvieXFrRDam3694ZIIBOLoTmeye43mXf1tefmyIAo4DmNbLEsz2cwIJhV8
	 /i6jBcocVLkCSdnNCMyHYo8WI+rZ1W85ZEb+3dUnJSK+FUB81IHfM6SbTjmswvY6AEOlb
	 d1YyOiim5KkxzeN9eSsaEbMNtVGYpp9B5if31z9Mf0Ss4Koo2RaTmGBqZuIKvbkIBzWDH
	 KfU8h95tDuxgRFRfs+B1T4T73WJK77TwLA+o17GLkPYRi1xTJviOtQTtxe4z4U8O9Xdu9
	 F2E5ZxsSkfXLKYUwTyPu5K5z0bI+K0B4pb9yJLdM3cNb1bFvkeka6DrE3cLnWL9N2gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKO7aRVE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C40606A898;
	Thu, 12 Nov 2026 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKO7aRVE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D991F00A0B;
	Thu, 12 Nov 2026 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486188;
	bh=KpzQJ/36NPPoj35pHGGkhA9wZAXFfZpjDBO8olMqC54=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jKO7aRVEei7KmvUUMH4cgeh9YIW4Yc0bPR001JkMryQeTs1K1Ecgwy6gQUEv8rOu3
	 PveXAXFXSRoj65abxDRbvSSCoyQG3e5c3/vnnwzVF9hpJtgA+AkIPOj2Guhz1uySRf
	 GitPTyBO16p1xWvLLbc5+eDfAsYw3/6QD7xh9kmIekOtwkpA+vEW8e7Sk+a/Qcyb2j
	 sphCZcfLxoNbe53ecaYfN4BKtQqEQPiyu40FX8VDwbeWfFLNdwHDKesbeUtSRYDc2S
	 opusTsrHhMqSQFdh7+dCa95JsCx+i2+OQsW2gEsHBLz1o2U+cM813YPQQMsZaMILdG
	 a079a1SLwVn2w==
Subject: Re: [PATCH RESEND v2 2/2] nfc: st21nfca: prevent double completion of
 SE APDU request
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, krzk@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 kuba@kernel.org
Date: Thu, 12 Nov 2026 12:23:07 +0000
Message-ID: <179448618760.2199510.8762431754721318647@kernel.org>
In-Reply-To: <20261110-st21nfca-v2-v2-2-cf9102b314cb@gmail.com>
References: <20261110-st21nfca-v2-v2-2-cf9102b314cb@gmail.com>
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

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new -EBUSY early return in st21nfca_hci_se_io()
  (drivers/nfc/st21nfca/se.c:231-234) leaks cb_context.
- [Medium] nfc: st21nfca: race on bwi_active and bwi_timer across SE IO
  and RX paths
- [Low] st21nfca_hci_se_io() sets bwi_active = true (line 237) and arms
  bwi_timer (line 239) before calling nfc_hci_send_event() (line 241).
- [Low] In st21nfca_apdu_reader_event_received(), when
  ST21NFCA_EVT_TRANSMIT_DATA arrives with bwi_active == false (a…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the sibling ST
  driver drivers/nfc/st-nci/se.c still has the same double-completion…
- [High] This problem wasn't introduced by this patch, but
  st21nfca_se_deinit() (drivers/nfc/st21nfca/se.c:462-474) reads…

--

nfc: st21nfca: prevent double completion of SE APDU request

This commit checks bwi_active under se_lock in both the timeout work
handler and the EVT_TRANSMIT_DATA handler, so that an SE APDU request is
completed only once. It also makes st21nfca_hci_se_io() return -EBUSY
when a request is already in progress.

> diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
> index 03a30f797ff8f..3be77420e9569 100644
> --- a/drivers/nfc/st21nfca/se.c
> +++ b/drivers/nfc/st21nfca/se.c
> @@ -228,6 +228,10 @@ int st21nfca_hci_se_io(struct nfc_hci_dev *hdev, u32 se_idx,
>  	switch (se_idx) {
>  	case ST21NFCA_ESE_HOST_ID:
>  		spin_lock(&info->se_info.se_lock);
> +		if (info->se_info.bwi_active) {
> +			spin_unlock(&info->se_info.se_lock);
> +			return -EBUSY;
> +		}

[Severity: Medium]
Does this early return leak cb_context?

After nfc_se_io() in net/nfc/netlink.c calls the driver op, it returns rc
without freeing cb_context, whatever rc is:

net/nfc/netlink.c:nfc_se_io() {
    ...
	rc = dev->ops->se_io(dev, se_idx, apdu,
			apdu_length, cb, cb_context);

	device_unlock(&dev->dev);
	return rc;
}

The default branch of this same function frees the context before it
returns an error:

	default:
		/* Need to free cb_context here as at the moment we can't
		 * clearly indicate to the caller if the callback function
		 * would be called (and free it) or not. In both cases a
		 * negative value may be returned to the caller.
		 */
		kfree(cb_context);
		return -ENODEV;

The new -EBUSY path does not call cb and does not free cb_context. A
second NFC_CMD_SE_IO for the eSE, sent while an earlier APDU is still
outstanding, would then leak the struct se_io_ctx that nfc_genl_se_io()
allocated.

Should this path also call kfree(cb_context) before returning -EBUSY, the
same way the -ENODEV branch does?

>  		info->se_info.cb = cb;
>  		info->se_info.cb_context = cb_context;
>  		info->se_info.bwi_active = true;

[Severity: Low]
What happens to bwi_active if the send that follows fails? Right after
this hunk, st21nfca_hci_se_io() continues with:

		spin_unlock(&info->se_info.se_lock);
		mod_timer(&info->se_info.bwi_timer, jiffies +
			  msecs_to_jiffies(info->se_info.wt_timeout));
		return nfc_hci_send_event(hdev, ST21NFCA_APDU_READER_GATE,
					ST21NFCA_EVT_TRANSMIT_DATA,
					apdu, apdu_length);

nfc_hci_send_event() can fail without queueing anything to the
controller. It returns -EADDRNOTAVAIL for an invalid pipe, and
nfc_hci_hcp_message_tx() returns -ENOMEM or -ESHUTDOWN. In those cases
bwi_active stays true and the timer stays armed.

With the new -EBUSY check, every later eSE APDU request would be rejected
until the BWI timer expires. That takes 3.2 s by default and up to about
6553 s for an ATR-provided BWI of 15. Each rejected request would also
leak its ctx, as described above.

When the timer fires, st21nfca_se_wt_work() sees bwi_active == true. It
then sends EVT_SE_SOFT_RESET, or EVT_SE_HARD_RESET if xch_error is set,
to an SE that never received a command.

The missing rollback predates this patch, but before it a retry
overwrote the stale state. The -EBUSY blocking is new.

Could the failure path clear bwi_active under se_lock and call
timer_delete_sync() on the timer? It would also need to decide
explicitly who frees cb_context in that case.

> @@ -269,6 +273,10 @@ static void st21nfca_se_wt_work(struct work_struct *work)
>  						se_info.timeout_work);
>  
>  	spin_lock(&info->se_info.se_lock);
> +	if (!info->se_info.bwi_active) {
> +		spin_unlock(&info->se_info.se_lock);
> +		return;
> +	}

[Severity: High]
This is a pre-existing issue, but this check shows that bwi_timer can be
armed while bwi_active is false. Does st21nfca_se_deinit() handle that
case?

void st21nfca_se_deinit(struct nfc_hci_dev *hdev)
{
	...
	if (info->se_info.bwi_active)
		timer_delete_sync(&info->se_info.bwi_timer);
	...
	cancel_work_sync(&info->se_info.timeout_work);
	info->se_info.bwi_active = false;
	...
}

There are two ways to end up with an armed bwi_timer and bwi_active ==
false:

ST21NFCA_EVT_WTX_REQUEST in st21nfca_apdu_reader_event_received() calls
mod_timer() without checking bwi_active. A WTX that arrives after the
request has completed therefore re-arms the timer.

The previous patch in this series ("nfc: st21nfca: add spinlock to
serialize SE APDU request state") also opened a window.
st21nfca_hci_se_io() now sets bwi_active under se_lock but calls
mod_timer() only after dropping the lock. A late EVT_TRANSMIT_DATA can
complete the request inside that window. se_io then arms a timer for a
request that has already finished.

At teardown, st21nfca_se_deinit() reads bwi_active without se_lock, sees
false, and skips timer_delete_sync(). The cancel_work_sync() call does not
help if the timer fires after it. st21nfca_hci_remove() then frees info:

	st21nfca_se_deinit(hdev);
	nfc_hci_unregister_device(hdev);
	nfc_hci_free_device(hdev);
	kfree(info);

The pending timer would then run st21nfca_se_wt_timeout(), which calls
schedule_work(&info->se_info.timeout_work) on freed memory.

st21nfca_se_deinit() also runs before nfc_hci_unregister_device(), so rx
processing could still re-arm the timer after deinit. Deinit also clears
bwi_active without the lock, and it drops an active request's cb_context
without calling cb.

Would it be safer for st21nfca_se_deinit() to call timer_shutdown_sync()
unconditionally, then cancel_work_sync(), and to handle bwi_active and
cb_context under se_lock?

[ ... ]

> @@ -395,6 +403,10 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
>  		cancel_work_sync(&info->se_info.timeout_work);
>  
>  		spin_lock(&info->se_info.se_lock);
> +		if (!info->se_info.bwi_active) {
> +			spin_unlock(&info->se_info.se_lock);
> +			break;
> +		}

[Severity: Medium]
Can a late response to a timed out request complete the next request
instead?

st21nfca_apdu_reader_event_received() runs from hdev->msg_rx_work
without device_lock(). st21nfca_hci_se_io() is called from
nfc_se_io() with device_lock() held. That leaves se_lock as the only
thing ordering the two paths.

The rx path calls timer_delete_sync() and cancel_work_sync() before it
takes se_lock. The new bwi_active check then only tells it that some
request is active, not which one:

1. bwi_timer for request 1 fires. st21nfca_se_wt_work() clears
   bwi_active under se_lock and drops the lock. It then sends the
   soft reset and calls cb(ctx1, NULL, 0, -ETIME).

2. A late EVT_TRANSMIT_DATA for request 1 is processed on
   msg_rx_work. timer_delete_sync() finds nothing pending, and
   cancel_work_sync() waits for step 1 to finish.

3. Userspace gets -ETIME and issues request 2.
   st21nfca_hci_se_io() sees bwi_active == false and installs
   cb2/ctx2. It sets bwi_active, arms bwi_timer and sends APDU 2.

4. The rx handler takes se_lock, sees bwi_active == true and clears
   it. It then calls cb(ctx2, skb->data, skb->len, 0) with request
   1's response.

Request 2 is then reported as successful with the wrong APDU response.
Its bwi_timer stays armed while bwi_active is false, so the timeout
work bails out on the new check. When the real answer to APDU 2
arrives, the new check in the rx path drops it.

Step 3 can also land after cancel_work_sync() returns and before
spin_lock(). The -EBUSY check does not close the race, because
bwi_active is already false at that point.

The leftover armed timer with bwi_active == false is the same state
that st21nfca_se_deinit() does not handle, as described above. This
is therefore another way to reach the timer use-after-free on remove.

This interleaving is not new. However, the commit message says a
request is now completed only once. Because the check runs after the
sync cancels, it can still claim a request that was submitted after
the response arrived.

Is there any way to tell which request an EVT_TRANSMIT_DATA belongs
to? If not, could st21nfca_hci_se_io() keep returning -EBUSY until
the timeout recovery in st21nfca_se_wt_work() has finished? Could the
rx path also decide under se_lock whether there is a request to
complete, before it touches bwi_timer?

[Severity: Low]
Is it intended that this break also skips the end-of-transfer event to
the CLF? After the request state is claimed, the handler goes on to:

		r = nfc_hci_send_event(hdev, ST21NFCA_DEVICE_MGNT_GATE,
				ST21NFCA_EVT_SE_END_OF_APDU_TRANSFER, NULL, 0);
		if (r < 0)
			goto exit;

		cb(cb_context, skb->data, skb->len, 0);

Before this patch, a response that arrived after the BWI timeout still
caused ST21NFCA_EVT_SE_END_OF_APDU_TRANSFER to be sent. Now a late or
unsolicited EVT_TRANSMIT_DATA skips both the stale callback and that
event.

Depending on CLF firmware behaviour, this might leave the CLF/SWP link in
APDU reader state. It is not clear whether the soft or hard reset sent
earlier by the timeout path already clears that state.

Would it be safer to skip only the callback here and still send
END_OF_APDU_TRANSFER?

>  		info->se_info.bwi_active = false;
>  		cb = info->se_info.cb;
>  		cb_context = info->se_info.cb_context;

[Severity: High]
This isn't a bug introduced by this patch, but the sibling driver
drivers/nfc/st-nci/se.c appears to have the same double completion
problem with no guard at all. Should it be fixed as well?

drivers/nfc/st-nci/se.c:st_nci_hci_apdu_reader_event_received() {
    ...
	case ST_NCI_EVT_TRANSMIT_DATA:
		timer_delete_sync(&info->se_info.bwi_timer);
		info->se_info.bwi_active = false;
		info->se_info.cb(info->se_info.cb_context,
				 skb->data, skb->len, 0);
    ...
}

drivers/nfc/st-nci/se.c:st_nci_se_wt_timeout() {
    ...
	info->se_info.bwi_active = false;
    ...
	info->se_info.cb(info->se_info.cb_context, NULL, 0, -ETIME);
}

If the BWI timer fires first, se_io_cb() frees the ctx. A later
ST_NCI_EVT_TRANSMIT_DATA then passes the freed ctx to se_io_cb() a second
time, which reads ctx->dev_idx and calls kfree(ctx) again.

ST_NCI_EVT_WTX_REQUEST also re-arms the timer unconditionally. A WTX that
arrives after a completed request would make the timeout complete the
dead request again.

st_nci_se_io() has no in-flight check and takes no lock. An unsolicited
TRANSMIT_DATA that arrives before any se_io would call a NULL cb.

In st-nci the timeout completion also runs directly in timer (softirq)
context, where se_io_cb() calls nlmsg_new() with GFP_KERNEL.

The commit message does not say whether st-nci was considered.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-st21nfca-v2-v2-0-cf9102b314cb%40gmail.com
