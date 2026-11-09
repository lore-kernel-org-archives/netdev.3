Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221588;
	b=cnEL+FeYT8oTW1PXnyk33jCcOIXrufQFZIAjODX5Hnvg7bdHs8q6tmI8End2/Xfm7juQ
	 3opEGAAJ1TusxkT2ElAAfGoR/P0ieiX45vBZQMTPLdbILVDBDDyf7x4IENWv0qgteYUzo
	 qQxO8DCMdIZJbuspgGoydTQ+YwMr7+qFfKsebSLRqcFPntBcP2Sj7s5Mr0mHXzMxI++3/
	 dgeJ3qK8zk1pIkat9pyHjgk4fmgErzGcUcWwR56lhtbgxPt0qe158chlSCnZqMbTDyWs3
	 2l11U4+WnLBD0wb2HzBX/gDTAFcYE1DxOfkcx3pUexqHC+Q4AiSNleprU/HYzP45NbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221588;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ffg4TKcQl3uV6/e6YuRYjc279RK9okacKE3VQneItDs=;
	b=IIeQ19EnFds+WVN8/mX5jTn30o3ZMnpnrPRfsDZWswlJh+YUqxmo1lgZj2b9j/8B/nlP
	 pT41vF5YFTrHvxmqr6ceUVpB8zq03ykty7Vwfix50/pfaE4NFekEocSPVwahxW9pEf0dH
	 v+BQKgOVrcrLg9kFS9mQEBl5d++P2pafnX3jq+Ldg8SZpxVXTEbbIRn0tix2CXQPuuQ/M
	 BRHFYXvw6Igl/LMkCTqBCypphHAoYx4aZEor7GbUIc2fhDfKCQNx4YKqjbBjAwCJI2Nlr
	 JpJshDulS28hm8LdimbHdf1mFqS2Qk78vbvefviT/SethQlt3npC2rIPEXGiWlK+RVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1qW4RSY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D604606A32A;
	Mon,  9 Nov 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1qW4RSY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836F71F008BC;
	Mon,  9 Nov 2026 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794221587;
	bh=ffg4TKcQl3uV6/e6YuRYjc279RK9okacKE3VQneItDs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g1qW4RSYYyqv40Dmp9rNLsyVEwAlbhYqSQvpDllfaFsSJqVVp26OOvtP//gN9hxlo
	 SKve7rFNn9exxY1NgtIuIbzMkvzJBrmk3NUJsx3+cGnbBDv1qGX59IHv1AkCs4zjaZ
	 NS/C9iQQjMVPaLjxCOKohlZJ4PBZcW8qxmKFiFTEilLkbH7La29uX/5ExbzvcmIgDT
	 LYhDYRAU+/a9UpwO3h+lldru+jR2XFxgQLaytN0NmNva70ZaO+eX9WlMDYDvCVrEom
	 IQ0eMJ0rcUYgEovaebCDimKqypehuzOfDZobeqETkLTMEbsxrON6VWabD4Zi9b9QfQ
	 PBizbRud/8uxA==
Subject:
 Re: [PATCH] nfc: pn533: validate response length before parsing DEP ATR_RES
From: netdev-bot+sashiko@kernel.org
To: hj351016@gmail.com
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 09 Nov 2026 10:53:06 +0000
Message-ID: <179422158699.994134.3116496415821822388@kernel.org>
In-Reply-To: <20261105103903.1440114-1-hj351016@gmail.com>
References: <20261105103903.1440114-1-hj351016@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In pn533_poll_dep_complete() (drivers/nfc/pn533/pn533.c, new
  check at line 1313) and pn533_in_dep_link_up_complete() (line 1936),…
- [Low] The commit message says 'pn533_rf_complete()-style handlers in
  this file already length-check resp->len before use'.
- [Low] pn533_activate_target_nfcdep() (drivers/nfc/pn533/pn533.c:1777)
  parses the InATR ATR_RES (struct pn533_cmd_activate_response, 16-byte…
- [Low] The patch says it fixes an out-of-bounds read whose bytes reach
  userspace through netlink (nfc_targets_found() ->…

--

nfc: pn533: validate response length before parsing DEP ATR_RES

This commit adds a check that resp->len is at least
sizeof(struct pn533_cmd_jump_dep_response) to pn533_poll_dep_complete()
and pn533_in_dep_link_up_complete(). The check runs before the response
status is read. It is meant to stop the handlers from reading the fixed
17-byte ATR_RES header, including nfcid3t[], past the end of a short
response.

> A valid ATR_RES always carries the full 17-byte fixed header (the
> general bytes, if present, start at offset 17), so reject any response
> shorter than sizeof(*rsp) before parsing it. pn533_rf_complete()-style
> handlers in this file already length-check resp->len before use (e.g.
> the ATR_REQ_GB_OFFSET check in pn533_init_target_complete()).

[Severity: Low]
Is this description of the other handlers accurate? pn533_rf_complete()
only checks IS_ERR(resp), then queues poll_work and frees the skb. It
never looks at resp->len or resp->data:

drivers/nfc/pn533/pn533.c:pn533_rf_complete() {
	...
	if (IS_ERR(resp)) {
		...
		return rc;
	}

	queue_delayed_work(dev->wq, &dev->poll_work,
			   msecs_to_jiffies(PN533_POLL_INTERVAL));

	dev_kfree_skb(resp);
	...
}

pn533_start_poll_complete() also reads the response without checking its
length:

	nbtg = resp->data[0];
	tg = resp->data[1];
	tgdata = &resp->data[2];
	tgdata_len = resp->len - 2;  /* nbtg + tg */

pn533_autopoll_complete() also walks the response without bounds checks.
Of the handlers mentioned, only pn533_init_target_complete() checks the
length.

Could this sentence be reworded so it doesn't suggest the rest of the
file already has these checks?

> Found by code review; not reproduced.
>
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

[Severity: Low]
The commit message describes an over-read whose bytes reach userspace
through nfc_targets_found(). Should the patch carry Fixes: tags so the
fix reaches stable kernels? The unchecked parsing in
pn533_in_dep_link_up_complete() and pn533_poll_dep_complete() appears to
come from these commits:

Fixes: 361f3cb7f9cf ("NFC: DEP link hook implementation for pn533")
Fixes: 673088fb42d0 ("NFC: pn533: Send ATR_REQ directly for active device detection")

> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
> index f5a6a7c20d5af..63b6032692184 100644
> --- a/drivers/nfc/pn533/pn533.c
> +++ b/drivers/nfc/pn533/pn533.c
> @@ -1310,6 +1310,11 @@ static int pn533_poll_dep_complete(struct pn533 *dev, void *arg,
>  
>  	rsp = (struct pn533_cmd_jump_dep_response *)resp->data;
>  
> +	if (resp->len < sizeof(*rsp)) {
> +		rc = -EINVAL;
> +		goto error;
> +	}
> +
>  	rc = rsp->status & PN533_CMD_RET_MASK;
>  	if (rc != PN533_CMD_RET_SUCCESS) {
>  		/* Not target found, turn radio off */

[Severity: High]
Can this check stop NFC polling whenever no DEP peer is in the field?

As far as I can tell, a PN53x returns the ATR_RES fields (Tg, NFCID3t,
DIDt, BSt, BRt, TO, PPt, Gt) only after a successful InJumpForDEP. If no
ATR_RES arrives, for example on a timeout, the chip replies with
D5 57 <Status> and nothing more. After pn533_send_async_complete() strips
TFI and CC, resp->len is 1.

The old code handled this case by reading only rsp->status. With the new
check, 1 < 17 jumps to error and returns -EINVAL, so this branch never
runs:

	if (rc != PN533_CMD_RET_SUCCESS) {
		/* Not target found, turn radio off */
		queue_work(dev->wq, &dev->rf_work);

pn533_wq_rf() sends RFConfiguration. Its completion, pn533_rf_complete(),
is the only place that re-arms poll_work after a DEP attempt.
pn533_wq_cmd_complete() ignores the -EINVAL:

	rc = pn533_send_async_complete(dev);
	if (rc != -EINPROGRESS)
		queue_work(dev->wq, &dev->cmd_work);

So nothing restarts the poll loop. poll_mod_count and nfc_dev->polling
still report that polling is active.

Since commit 673088fb42d0 ("NFC: pn533: Send ATR_REQ directly for active
device detection"), pn533_send_poll_frame() sends a DEP poll between
passive cycles whenever NFC_DEP is requested:

	if ((dev->poll_protocols & NFC_PROTO_NFC_DEP_MASK) && dev->poll_dep)  {
		dev->poll_dep = 0;
		return pn533_poll_dep(dev->nfc_dev);
	}

So any poll that includes NFC_DEP and finds nothing on its first passive
cycle would stall after the first DEP attempt. It stays stalled until
userspace stops and restarts polling, and then it stalls again the same
way.

pn533_in_dep_link_up_complete() gets the same status-only reply and now
returns -EINVAL without logging anything. The "Bringing DEP link up
failed (error 0x%x)" message with the chip's status code is never
printed.

The commit message says "A valid ATR_RES always carries the full 17-byte
fixed header", but that seems to hold only for successful replies.

Would it work to check resp->len >= 1 before reading the status, keep the
existing failure handling, and require resp->len >= sizeof(*rsp) only on
the success path, before nfcid3t is copied and target_gt_len is computed?

> @@ -1928,6 +1933,11 @@ static int pn533_in_dep_link_up_complete(struct pn533 *dev, void *arg,
>  
>  	rsp = (struct pn533_cmd_jump_dep_response *)resp->data;
>  
> +	if (resp->len < sizeof(*rsp)) {
> +		rc = -EINVAL;
> +		goto error;
> +	}
> +
>  	rc = rsp->status & PN533_CMD_RET_MASK;
>  	if (rc != PN533_CMD_RET_SUCCESS) {
>  		nfc_err(dev->dev,

[Severity: Low]
pn533_activate_target_nfcdep() parses the InATR ATR_RES (struct
pn533_cmd_activate_response, which has a 16-byte fixed header) the same
way, and this patch leaves it unchanged:

drivers/nfc/pn533/pn533.c:pn533_activate_target_nfcdep() {
	...
	rsp = (struct pn533_cmd_activate_response *)resp->data;
	rc = rsp->status & PN533_CMD_RET_MASK;
	...
	/* ATR_RES general bytes are located at offset 16 */
	gt_len = resp->len - 16;
	rc = nfc_set_remote_general_bytes(dev->nfc_dev, rsp->gt, gt_len);
	...
}

rsp->status is read without checking that resp->len is at least 1. If the
reply carries only TFI and CC (resp->len == 0), the trimmed checksum byte
is read as the status.

The gt_len underflow is rejected later in nfc_llcp_set_remote_gb(). That
is the same mitigation the commit message describes for target_gt_len.

Should this third ATR_RES parser get the same status length check as the
other two?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105103903.1440114-1-hj351016%40gmail.com
