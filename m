Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266295;
	b=buyz1F/vQ4/Ojz0OLRueRtggRx8OOhL0q+zY8K5qnCsA8i2ttXmMpmBLUGj64i44gYit
	 erQFF9iueXeLQTqXPPwwMhxSj6QwTqC1WgmBrbxc+dBVGI0TKQRvlEbLquKSIPtVe3G/K
	 TlO2MZ12mEUeON7jEeLFZaejuGISqEL7eYSc3hhWhlMdV8bi2JyKqyemp1I0JS+Oz2E+r
	 JlwPxC+cH+sK6msgmhmXkGQSR1qDA4BfmgTiCd6BgApI0mlVATrG5R9LXMTI7IYbqtjmj
	 x7qcVyjcKyGlCmB87yN0QiWTmOcgrFrUeHGrYD+mBeiA8tpV/TmaKeAKTI4TNgntYQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266295;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vRs05BWdbViarzPJPkHj1pp6TagvH7Hn/qA5RjGhNi8=;
	b=HAq3Zv1HVegZxarxWHMkVaVei98/L6/L9Xh8IGrWsmK9CX2/piKQqKoCJWeEgmJMcWtO
	 ad11WqpJtsx/0yXNyqXXohvaqkN/+QicNN4W/V4rD2zhakGwm4/i4gncuTPFsPtE3Zy8h
	 a50iVDCQXBw2dBaeVqEY1bPXXMw7SjQnyj7lXhE0HZBlyUZfdHr6mwFldLsosG4WOC9Up
	 BdZpWrMuC+ojmr7Evsx5mTFE+fI5TvND6GPsPHsTdNhiSbpGUHHK/3vgtc5zdgXDVNqlF
	 mQGi5lnecGquoEDBYOKrjXHqNxJ3IpjSC1M0LAwnBu1AX24ArjrFPWu/S2Uiome/NsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRSGdYUm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D207606A31C;
	Mon,  9 Nov 2026 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRSGdYUm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775701F0089F;
	Mon,  9 Nov 2026 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266294;
	bh=vRs05BWdbViarzPJPkHj1pp6TagvH7Hn/qA5RjGhNi8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RRSGdYUmTB2v1qaXMC2xNxlQfURJ60UkzQzAbkvqo0t9WkaFtBgAm4sBfQV5Pq+sc
	 8UvwSDkn1IQfIhxXNdjMO3Yn92ViySPvXHmdJFYz+QjpImY9VDVpt7wcuKT0mTmedK
	 hLpiGp8g2ur0Oqk+lEfmWUZIvEpwohJlrhEbxZilLl7YQQha0vFozStilsaXlFuch8
	 hHp/4JgzrpCKKOCdRXr+HYNcXzlDtHS69Wxcol2MnHC4kwXFkomWhhVaGbreQj+mdA
	 YnMZTD7nhi/2BamN6gIpaqdwlqvHYUu+ZTIYQQt9ozSqRZNA9goFA4fLS9mdfr9whD
	 axnjbryO3shYg==
Subject: Re: [PATCH] nfc: digital: check length before reading SENS_REQ
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:18:13 +0000
Message-ID: <179426629399.994134.5894764288944511010@kernel.org>
In-Reply-To: <i69izu1c4hLS_ZLvaL0RVyF5pJt0gkMCEY-87g-j6iGMyCi9WKPGInJF53uwP9q9k4IPeEoBS6RKRCNaavGJlY7G-ifRKqdeMSC0rzYf9Tg=@proton.me>
References: <i69izu1c4hLS_ZLvaL0RVyF5pJt0gkMCEY-87g-j6iGMyCi9WKPGInJF53uwP9q9k4IPeEoBS6RKRCNaavGJlY7G-ifRKqdeMSC0rzYf9Tg=@proton.me>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "nfc: digital: check length before
  reading SENS_REQ" has no Signed-off-by: trailer.
- [Low] The patch is presented as a bug fix ("an empty frame reads one
  byte past skb->len"), but it changes nothing observable.
- [Low] The patch is framed as a fix for an overread in
  digital_tg_recv_sens_req() (net/nfc/digital_technology.c) but has no…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a sibling
  target-mode receive callback has the same read-before-length-check…
- [Low] This problem wasn't introduced by this patch, but
  digital_in_recv_dep_res() (net/nfc/digital_dep.c) reads the RTOX byte…

--

nfc: digital: check length before reading SENS_REQ

This patch reorders the check in digital_tg_recv_sens_req() so that
resp->len is tested before resp->data[0] is read. It also drops the
now-unused sens_req local.

> Hello,
>

[ ... ]

> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), net/nfc/digital_technology.c:1088-1112 (digital_tg_recv_sens_req).
> Longstanding code.
>
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the
> reporter against that tree.

[ ... ]

> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

[Severity: Medium]
Is a Signed-off-by: missing here? The only trailer is Reported-by:, and it
names the author, who is already credited in From:.
Documentation/process/submitting-patches.rst requires a DCO sign-off, so the
patch can't be applied as submitted.

The body also has text that probably doesn't belong in git history:

  - the "Hello," greeting
  - the "Affected version/commit:" line with file:line ranges
  - "every code path cited below was re-verified", although nothing is
    cited below
  - the note that the patch has not been compiled or runtime tested
  - the request to treat this as a report for verification

Could these move below the --- line or into a cover letter?

> diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
> index ae6487c10a254..d9a8e9fc3d846 100644
> --- a/net/nfc/digital_technology.c
> +++ b/net/nfc/digital_technology.c
> @@ -1088,7 +1088,6 @@ static int digital_tg_send_sens_res(struct nfc_digital_dev *ddev)
>  void digital_tg_recv_sens_req(struct nfc_digital_dev *ddev, void *arg,
>  			      struct sk_buff *resp)

[Severity: Low]
If this stays framed as a fix, should it have a Fixes: tag? git blame shows
that digital_tg_recv_sens_req(), including the read before the length
check, came from:

Fixes: 1c7a4c24fbfd ("NFC Digital: Add target NFC-DEP support")

If it is reworded as a cleanup instead, no Fixes: tag is needed.

>  {
> -	u8 sens_req;
>  	int rc;

[ ... ]

> @@ -1097,10 +1096,8 @@ void digital_tg_recv_sens_req(struct nfc_digital_dev *ddev, void *arg,
>  		goto exit;
>  	}
>  
> -	sens_req = resp->data[0];
> -
> -	if (!resp->len || (sens_req != DIGITAL_CMD_SENS_REQ &&
> -	    sens_req != DIGITAL_CMD_ALL_REQ)) {
> +	if (!resp->len || (resp->data[0] != DIGITAL_CMD_SENS_REQ &&
> +	    resp->data[0] != DIGITAL_CMD_ALL_REQ)) {

[Severity: Low]
Does this change any behaviour? In the old code, when resp->len is 0 the ||
short-circuits on !resp->len. So the byte loaded into sens_req never
affects control flow, and both versions return -EINVAL and call
digital_poll_next_tech().

For a linear skb with len == 0, data == tail <= end. The old load stayed
inside the head allocation and could not fault.

The commit message says "so an empty frame reads one byte past skb->len".
Together with the "Affected version/commit:" line, this reads like a
memory-safety fix. Could the changelog say plainly that this is a cleanup
with no functional change?

>  		rc = -EINVAL;
>  		goto exit;
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but a sibling target-mode
callback in net/nfc/digital_dep.c has the same read-before-length-check
pattern. There, the byte it reads is actually used:

net/nfc/digital_dep.c:digital_tg_send_atr_res_complete() {
	...
	offset = 2;
	if (resp->data[0] == DIGITAL_NFC_DEP_NFCA_SOD_SB)
		offset++;

	ddev->atn_count = 0;

	if (resp->data[offset] == DIGITAL_CMD_PSL_REQ)
		digital_tg_recv_psl_req(ddev, arg, resp);
	else
		digital_tg_recv_dep_req(ddev, arg, resp);
}

Only IS_ERR(resp) is checked before these reads. A remote initiator can
send an empty or 1-3 byte frame after ATR_RES. That reads up to 4 bytes
past skb->len, and the result decides which handler runs.

The reads stay inside the skb head allocation. Both handlers later reject
short frames through skb_check_crc() and digital_skb_pull_dep_sod(). So the
visible effect seems to be a branch on uninitialized tailroom, which KMSAN
could report as uninit-value.

Should this function get a length check too, like the !resp->len check in
digital_tg_recv_atr_req()?

[Severity: Low]
This is a pre-existing issue, but digital_in_recv_dep_res() in
net/nfc/digital_dep.c reads the RTOX byte without checking that a byte is
left after the header pull:

net/nfc/digital_dep.c:digital_in_recv_dep_res() {
	...
	if (size > resp->len) {
		rc = -EIO;
		goto error;
	}

	skb_pull(resp, size);
	...
		rtox = DIGITAL_NFC_DEP_RTOX_VALUE(resp->data[0]);
		if (!rtox || rtox > DIGITAL_NFC_DEP_RTOX_MAX) {
	...
}

Here size is sizeof(struct digital_dep_req_res), which is 3. If a remote
target sends a header-only RTOX DEP_RES with the timeout supervisor bit
set, resp->len is 0 at the read.

With software CRC, data[0] is the first CRC byte that was just trimmed.
With driver-side CRC (NFC_DIGITAL_DRV_CAPS_IN_CRC), it may be
uninitialized tailroom.

If that byte & 0x3F falls in 1..DIGITAL_NFC_DEP_RTOX_MAX, can the malformed
frame be accepted as a valid RTOX request and lead to a call to
digital_in_send_rtox()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/i69izu1c4hLS_ZLvaL0RVyF5pJt0gkMCEY-87g-j6iGMyCi9WKPGInJF53uwP9q9k4IPeEoBS6RKRCNaavGJlY7G-ifRKqdeMSC0rzYf9Tg%3D%40proton.me
