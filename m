Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265910;
	b=PN4D65pYeUUgA1L8GIFE/J8Es9caNjczqzFgRoyBxcF1tec3P0xbOX2Cy0xJPPOpmYiw
	 F5UvgDZ0EcS8Qv9gb8ge3MD5ArDQLRVp9ObF8SZVescfw40VE4cpYpZlQtHEQ2ozR1CVZ
	 eIVg85J3fRVfZbl73x2OVUYwGFrMh1p86unOaxwD5nLrmHg1MqauKzQQO94W7FJUM5i5l
	 C9yKDY/ienFPZhMqTDwR6bttsYewDNmsB1+sJjGu9DoOj/cAZa9emDOixcd5FV74LHODP
	 AfMplL2mRnW2pkgNu/yZNiw0FjUcpwtfehaeQra3tTecLEOJyKsyZhO5kiFYflTBO/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265910;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=k18szSYQhlE4aJnlADBUPKKWtFMZkAyMkiF2QCd2YiU=;
	b=L9NVZd8/EfzFXQW8tqhVVi7JGM99s6jpTb0Y6DpesdTcGo8XzH6RDtEARLAZwxcll964
	 vnjEkamzGy6+ALu90sNHIzlP+NJbzBq7t5n72NS9IJbKlEePK5mUGRETXg/lpoykt6LbC
	 ZxrmgfegxuzUUUlPk5LoPdLjRo/dVWkKG7mpbi7Hcrxqustmqw2x5gKxwQCq9MJs/ak6d
	 3qKphG+bbhW7puXYgnBsRPBvJ+D7eBf4yOnb+rjbMuVPExd+Lc7KwLhr74INKEwYzSeYj
	 fYxKtVUq4GInHYl45pfvizB3W6E2R+DhYiSP5UsuBj+j+yDhxeYq2+qi8RPfbVfSoYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWOiJ+cq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C5606A31C;
	Mon,  9 Nov 2026 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWOiJ+cq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F081F0089F;
	Mon,  9 Nov 2026 23:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265909;
	bh=k18szSYQhlE4aJnlADBUPKKWtFMZkAyMkiF2QCd2YiU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aWOiJ+cqKbWE834tmGBR9e7uBdJjpXo8CbM5r56NMo5EAiqbFiw2uHzSozNLrCHxu
	 W1kJv0zbY53ArEIqpB30d6+GxQCt27X3s3oaYo6AYXk6qRfVDY8yEf5C6nTWh/VX7K
	 0ru2t25IqoxL6qce0h6eMBRtI1kHerQu865yII+jWXwm3R3erJV4SlNuJtXsXEPR/7
	 h92PB1DWramZEeP7jqkQEvZcNhql8aqVl4PwSCR/IA4w4oEkZXJy3Ascu6P1B6bcKB
	 qvQ4XtLr5ry3wPrbpXpyVTKNAJep8SlWlXl1iagf8AH3edFc9annnPuf0OL2/RDDZl
	 JWrcPddaKgSQQ==
Subject: Re: [PATCH] nfc: digital: check response length in ATR_RES completion
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:11:48 +0000
Message-ID: <179426590897.994134.16082340443849254625@kernel.org>
In-Reply-To: <LyOKCC733hNrBd6iivknR2vV1eGIrrd5XvWeTzpSKHjz0eb_mC3OYTVGmYuGYz7fEdR5vVu2V76xphxku0BWFg5TSVkzd7KD43KN7SqWpWw=@proton.me>
References: <LyOKCC733hNrBd6iivknR2vV1eGIrrd5XvWeTzpSKHjz0eb_mC3OYTVGmYuGYz7fEdR5vVu2V76xphxku0BWFg5TSVkzd7KD43KN7SqWpWw=@proton.me>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit has no Signed-off-by line.
- [Low] There is no Fixes: tag.
- [Low] The new short-frame exits in digital_tg_send_atr_res_complete()
  (net/nfc/digital_dep.c lines 1477-1489) call digital_poll_next_tech()…
- [Low] The lines added at the end of digital_tg_send_atr_res_complete()
  in net/nfc/digital_dep.c (lines 1498-1500: `return;`, `exit:`,…

--

nfc: digital: check response length in ATR_RES completion

This patch adds resp->len checks to digital_tg_send_atr_res_complete()
before it reads resp->data[0] and resp->data[offset]. A short frame now
calls digital_poll_next_tech() and frees the skb. Before, it was passed
to the PSL_REQ or DEP_REQ handler.

> Hello,

[ ... ]

> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.
>
> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

[Severity: Medium]

There is no Signed-off-by line here. The Reported-by tag does not count
as the DCO sign-off that Documentation/process/submitting-patches.rst
requires, so the patch can't be applied as it is.

Could this be resent with a Signed-off-by?

Parts of the body read like a bug report rather than a changelog. These
include "Hello,", the "Affected version/commit" line, the note about the
AI-assisted review, and the statement that the patch has not been compiled
or tested.

Could that text go below the --- line so it stays out of git history?
Could the patch also be build-tested before it is resent?

> Longstanding code.

[Severity: Low]

Should this have a Fixes: tag? This patch fixes a read past skb->len that
a remote initiator can trigger. The unchecked reads of resp->data[0] and
resp->data[offset] seem to date back to this commit:

Fixes: 1c7a4c24fbfd ("NFC Digital: Add target NFC-DEP support")

> diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
> index 968547c306a5d..b9b04db1c17e8 100644
> --- a/net/nfc/digital_dep.c
> +++ b/net/nfc/digital_dep.c
> @@ -1474,16 +1474,30 @@ static void digital_tg_send_atr_res_complete(struct nfc_digital_dev *ddev,
>  		return;
>  	}
>  
> +	if (resp->len < 1) {
> +		digital_poll_next_tech(ddev);
> +		goto exit;
> +	}
> +
>  	offset = 2;
>  	if (resp->data[0] == DIGITAL_NFC_DEP_NFCA_SOD_SB)
>  		offset++;
>  
> +	if (resp->len < offset + 1) {
> +		digital_poll_next_tech(ddev);
> +		goto exit;
> +	}

[Severity: Low]

Is digital_poll_next_tech() the intended way to handle these short frames?

When this completion runs, digital_tg_recv_atr_req() has already sent the
ATR_RES, cleared poll_tech_count and called nfc_tm_activated():

net/nfc/digital_dep.c:digital_tg_recv_atr_req() {
    ...
	rc = digital_tg_send_atr_res(ddev, atr_req);
	if (rc)
		goto exit;
    ...
	poll_tech_count = ddev->poll_tech_count;
	ddev->poll_tech_count = 0;

	rc = nfc_tm_activated(ddev->nfc_dev, NFC_PROTO_NFC_DEP_MASK,
			      NFC_COMM_PASSIVE, atr_req->gb, gb_len);
    ...
}

So here, digital_poll_next_tech() only switches the RF off. It returns
without scheduling poll_work:

net/nfc/digital_core.c:digital_poll_next_tech() {
	digital_switch_rf(ddev, 0);

	mutex_lock(&ddev->poll_lock);

	if (!ddev->poll_tech_count) {
		mutex_unlock(&ddev->poll_lock);
		return;
	}
    ...
}

nfc_tm_deactivated() is not called on this path either.

Before this patch, a short frame went to digital_tg_recv_dep_req() or
digital_tg_recv_psl_req(). It failed in skb_check_crc() or
digital_skb_pull_dep_sod() and was simply freed. On that path,
digital_tg_recv_dep_req() also cleared chaining_skb, saved_skb and
atn_count. Neither handler switches the RF off, and neither queues a new
receive.

After this patch, a frame of 3 bytes or less turns the RF off. A longer
malformed frame, such as one with a bad CRC or the wrong command, is still
dropped with the RF left on. The commit message doesn't mention this
change.

Would it be simpler to keep the old behaviour, either by passing short
frames to digital_tg_recv_dep_req(), which already checks the length, or
by just calling kfree_skb(resp)?

> +
>  	ddev->atn_count = 0;
>  
>  	if (resp->data[offset] == DIGITAL_CMD_PSL_REQ)
>  		digital_tg_recv_psl_req(ddev, arg, resp);
>  	else
>  		digital_tg_recv_dep_req(ddev, arg, resp);
> +
> +return;
> +exit:
> +kfree_skb(resp);

[Severity: Low]

This isn't a bug, but the return; and kfree_skb(resp); lines have no tab
indentation. checkpatch.pl will flag them.

>  }
>  
>  static int digital_tg_send_atr_res(struct nfc_digital_dev *ddev,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/LyOKCC733hNrBd6iivknR2vV1eGIrrd5XvWeTzpSKHjz0eb_mC3OYTVGmYuGYz7fEdR5vVu2V76xphxku0BWFg5TSVkzd7KD43KN7SqWpWw%3D%40proton.me
