Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486187;
	b=yWSd/vNZ0LRYwi04L+p2exCkxc26oclh4YFwyjzephfFdbsbMkKB65/f4s9B84B74jTZ
	 YKFHRg3XgptEp9LbxIA/TufduhdiDXiBny+ahtdU23zPIm3zD9wedks9H7yPxRabOA5Me
	 X44voh5jwIj9ECLDx9q2Kewf8CGP7u8mJBgZXwEogg8dE3jHTEIsfXbUzbI6ZdFHZUpp8
	 mm22daITCTlr6OVwzz3YV+Xfp0rE2cnc73W7UCz0Q4fdPUF821uzqZfXUvuQmfO5z1zoV
	 utrnBC+7ZALpT2ajs14TtlAr35aL8x0HFqVrMoPvKrjoBNRHrQ66/m9D47GcbiHDtEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486187;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R3NCPpjqsEVxOgXaSumxV30alDceqliOD1vt6yLUpjQ=;
	b=ysyKqR+vz/tFG1x0CjKQ4myS+J5x+XpTCcdW27jF98oUJztHPAydo5urUMr+Ky2WvDZW
	 0V+Gfo5GJZiZzeIinQNx/Y4FUU+4mvsIGFZMUwupz/y/PYE5OJz8ZvWPq5TWSmyxd/dhk
	 WJlfLHSY34DG5J34YxGAAZH9H1yn3cZK6iaXivATa1Exc74C4UZ5L66TvmxJbhEn04wBL
	 SSzaKYNOuPSEjncBEoaJ9xGrG+PrNQ62jPXyBGyZUF0nagS7u/Dw2r0LABEToXUvZ0YLY
	 IAbuSQDqjgvyttOIeso3ABth19S0kJIuWReOzBSLW3B2hBuGLoPOWxXxO14XGp0Vk9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5ybGsuv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FA606A32A;
	Thu, 12 Nov 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5ybGsuv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F077E1F00A05;
	Thu, 12 Nov 2026 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486187;
	bh=R3NCPpjqsEVxOgXaSumxV30alDceqliOD1vt6yLUpjQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X5ybGsuvKOkN6pfe6N2mRvdV32DmLucp6C+OUX0qIuViTJ4dWmZ2t66uFAKa7RNQl
	 leYXoGwNkpfo4FmvJHiJKHtp7aFw/cG9yQm8NNjWKj4wcPGL3A831KiCdG37L1KwFK
	 tcfuuBDmvHBA4ok7xHsfPLVnbUDPNPawXKxuY3TPnkk2Xdmn6YmsTVdr+gjeoExPZ3
	 6vgXtAIGTSA1SON9sZ4/UVugRZCiJIK/K0J53uCBf5MrtSehlGOKVH4943cLYQy6DF
	 o2YFv84W5AhRu7DrRJ5RL41iVQWMyzwwbKgigN1Rq5TXAsKqkFnaXP0mK52LO0cDzo
	 q3TuWCi4tk2zQ==
Subject: Re: [PATCH RESEND v2 1/2] nfc: st21nfca: add spinlock to serialize SE
 APDU request state
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, krzk@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 kuba@kernel.org
Date: Thu, 12 Nov 2026 12:23:06 +0000
Message-ID: <179448618651.2199510.14576038310762047846@kernel.org>
In-Reply-To: <20261110-st21nfca-v2-v2-1-cf9102b314cb@gmail.com>
References: <20261110-st21nfca-v2-v2-1-cf9102b314cb@gmail.com>
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At the end of the series, st21nfca_hci_se_io() leaks the
  netlink se_io_ctx every time it rejects an overlapping request.
- [Low] The commit message says se_lock was added "to serialize access to
  these fields" (bwi_active, cb, cb_context).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but teardown can
  leave bwi_timer armed when the struct st21nfca_hci_info is freed.
- [High] This problem wasn't introduced by this patch, but the sibling
  driver drivers/nfc/st-nci/se.c has the same SE APDU completion bug…

--

nfc: st21nfca: add spinlock to serialize SE APDU request state

This patch adds se_lock to struct st21nfca_se_info. The lock protects
bwi_active, cb and cb_context in st21nfca_hci_se_io(),
st21nfca_se_wt_work() and st21nfca_apdu_reader_event_received(), and
the callback is copied under the lock and called after it is dropped.
It also sets bwi_active before mod_timer() in st21nfca_hci_se_io().

> diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
> index 7154bc1d644ae..03a30f797ff8f 100644
> --- a/drivers/nfc/st21nfca/se.c
> +++ b/drivers/nfc/st21nfca/se.c
> @@ -227,11 +227,13 @@ int st21nfca_hci_se_io(struct nfc_hci_dev *hdev, u32 se_idx,
>  
>  	switch (se_idx) {
>  	case ST21NFCA_ESE_HOST_ID:
> +		spin_lock(&info->se_info.se_lock);
> +		info->se_info.cb = cb;
> +		info->se_info.cb_context = cb_context;
> +		info->se_info.bwi_active = true;
> +		spin_unlock(&info->se_info.se_lock);

[Severity: Medium]
This comment is about the follow-up commit in this series, "nfc:
st21nfca: prevent double completion of SE APDU request". That commit
adds a bwi_active check here:

    spin_lock(&info->se_info.se_lock);
    if (info->se_info.bwi_active) {
        spin_unlock(&info->se_info.se_lock);
        return -EBUSY;
    }

Does that -EBUSY path leak cb_context?

Once dev->ops->se_io() has been called, the driver owns cb_context.
nfc_se_io() in net/nfc/netlink.c only frees it when one of its own
pre-checks fails. When the driver returns an error, it does this:

    rc = dev->ops->se_io(dev, se_idx, apdu,
                         apdu_length, cb, cb_context);

    device_unlock(&dev->dev);
    return rc;

nfc_genl_se_io() doesn't free it either. The default branch of
st21nfca_hci_se_io() calls kfree(cb_context) for exactly this reason,
as its comment explains.

So each NFC_CMD_SE_IO that gets -EBUSY while an APDU is in flight would
leak one struct se_io_ctx. The window lasts at least wt_timeout (3200
ms by default). EVT_WTX_REQUEST can keep extending it. A failed
nfc_hci_send_event() can too, since it leaves bwi_active set until the
timer fires.

Before the series, a second request overwrote cb and cb_context and
leaked the first context. The follow-up fixes the double completion,
but the leak now happens on the rejected request instead.

Should the -EBUSY path call kfree(cb_context), like the default branch?

>  		mod_timer(&info->se_info.bwi_timer, jiffies +
>  			  msecs_to_jiffies(info->se_info.wt_timeout));
> -		info->se_info.bwi_active = true;
>  		return nfc_hci_send_event(hdev, ST21NFCA_APDU_READER_GATE,
>  					ST21NFCA_EVT_TRANSMIT_DATA,
>  					apdu, apdu_length);

[ ... ]

> @@ -383,14 +393,19 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
>  	case ST21NFCA_EVT_TRANSMIT_DATA:
>  		timer_delete_sync(&info->se_info.bwi_timer);
>  		cancel_work_sync(&info->se_info.timeout_work);
> +
> +		spin_lock(&info->se_info.se_lock);
>  		info->se_info.bwi_active = false;
> +		cb = info->se_info.cb;
> +		cb_context = info->se_info.cb_context;
> +		spin_unlock(&info->se_info.se_lock);
> +
>  		r = nfc_hci_send_event(hdev, ST21NFCA_DEVICE_MGNT_GATE,
>  				ST21NFCA_EVT_SE_END_OF_APDU_TRANSFER, NULL, 0);
>  		if (r < 0)
>  			goto exit;
>  
> -		info->se_info.cb(info->se_info.cb_context,
> -			skb->data, skb->len, 0);
> +		cb(cb_context, skb->data, skb->len, 0);

[Severity: High]
This isn't a bug introduced by this patch, but the sibling driver
drivers/nfc/st-nci/se.c looks like it has the same double completion
problem, and the series doesn't touch it.

st_nci_se_wt_timeout() always calls the stored callback:

    info->se_info.bwi_active = false;
    ...
    info->se_info.cb(info->se_info.cb_context, NULL, 0, -ETIME);

st_nci_hci_apdu_reader_event_received() calls it for
ST_NCI_EVT_TRANSMIT_DATA without checking bwi_active:

    timer_delete_sync(&info->se_info.bwi_timer);
    info->se_info.bwi_active = false;
    info->se_info.cb(info->se_info.cb_context,
                     skb->data, skb->len, 0);

se_io_cb() in net/nfc/netlink.c frees its context on every call. If
the SE answers after the BWI timeout has already fired, se_io_cb()
could run twice on the same context:

nfc_genl_se_io()->nfc_se_io()->nci_se_io()->st_nci_se_io()
    arms bwi_timer
st_nci_se_wt_timeout()->se_io_cb()
    kfree(ctx)
st_nci_hci_apdu_reader_event_received()->se_io_cb()
    reads ctx->dev_idx, ctx->se_idx, then kfree(ctx) again

Would that be a use-after-free followed by a double kfree()? A
duplicate EVT_TRANSMIT_DATA would do the same thing. So would a WTX
request that re-arms the timer after an exchange has finished.
st_nci_se_io() also overwrites cb and cb_context without checking for
an outstanding request.

st_nci_se_wt_timeout() is a timer callback and runs in softirq
context. se_io_cb() allocates with nlmsg_new(NLMSG_DEFAULT_SIZE,
GFP_KERNEL). Can that sleep in atomic context?

Should st-nci get an equivalent fix?

>  		break;
>  	case ST21NFCA_EVT_WTX_REQUEST:
>  		mod_timer(&info->se_info.bwi_timer, jiffies +

[Severity: High]
This is a pre-existing issue, but can bwi_timer still be pending when
st21nfca_hci_remove() frees info?

    st21nfca_se_deinit(hdev);
    nfc_hci_unregister_device(hdev);
    nfc_hci_free_device(hdev);
    kfree(info);

st21nfca_se_deinit() only deletes the timer when an unlocked read of
bwi_active returns true, and it never shuts the timer down:

    if (info->se_info.bwi_active)
        timer_delete_sync(&info->se_info.bwi_timer);

There seem to be three ways the timer can stay armed:

- The HCI rx work is only cancelled later, in
  nfc_hci_unregister_device(). A queued ST21NFCA_EVT_WTX_REQUEST can
  reach the mod_timer() above after st21nfca_se_deinit() has run.

- A WTX request handled while bwi_active was false (for example just
  after a timeout) arms the timer, and st21nfca_se_deinit() then skips
  timer_delete_sync().

- The nfc_dev is still registered while st21nfca_se_deinit() runs, so
  NFC_CMD_SE_IO can reach st21nfca_hci_se_io(). It can set bwi_active
  and call mod_timer() after st21nfca_se_deinit() has read the flag,
  because the remove path doesn't take the device_lock that nfc_se_io()
  holds.

In each case, st21nfca_se_wt_timeout() would run on the freed info
when the timer expires. It would then call
schedule_work(&info->se_info.timeout_work) on freed memory.

st21nfca_se_deinit() also clears bwi_active without calling the
pending cb, so an outstanding cb_context would leak.

The new se_lock doesn't change any of this. Would it work to stop the
rx work and se_io first, and then unconditionally call
timer_shutdown_sync() on bwi_timer and cancel timeout_work?

[ ... ]

> diff --git a/drivers/nfc/st21nfca/st21nfca.h b/drivers/nfc/st21nfca/st21nfca.h
> index ae6771cc9894a..abcef1ee48f25 100644
> --- a/drivers/nfc/st21nfca/st21nfca.h
> +++ b/drivers/nfc/st21nfca/st21nfca.h

[ ... ]

> @@ -131,6 +132,7 @@ struct st21nfca_se_info {
>  	struct timer_list bwi_timer;
>  	int wt_timeout; /* in msecs */
>  	bool bwi_active;
> +	spinlock_t se_lock;

[Severity: Low]
The commit message says se_lock is added "to serialize access to these
fields". However, st21nfca_se_deinit() still reads and writes
bwi_active without it:

    if (info->se_info.bwi_active)
        timer_delete_sync(&info->se_info.bwi_timer);
    ...
    info->se_info.bwi_active = false;

st21nfca_se_deinit() runs before nfc_hci_unregister_device(), so the
HCI rx work and netlink se_io can still run at the same time. Should
these accesses take se_lock as well?

Taking the lock around this read alone wouldn't fix the teardown
problem above, because the timer can still be armed after the read.

>  
>  	struct timer_list se_active_timer;
>  	bool se_active;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-st21nfca-v2-v2-0-cf9102b314cb%40gmail.com
