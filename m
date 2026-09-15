Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8946D0B8;
	Tue, 15 Sep 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474852; cv=none; b=Uiy7xdIeQTlJHXBEP06Myk/1Myr/l8rM2k/SwcnZTnFYyNwAdanXiVDQlDNvcKkdW7vjtUvyyjEM5pdwEO+wAMa7GZmd311J62Os9sGDkJOK1ZCtTOWcmgBRiLCHlXJZjJAlrkW3erGM72RPuYY3znVjj//MMTJAb2y7Vf3RI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474852; c=relaxed/simple;
	bh=OBZ6tYCjoCzQR69kl8GIIzWBrngNn/CUNFzlE3260KI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=psTw+9AtjXpYAeYokgn6Nya6Lp191cVMrAV0Tk5VK0wE9ne+YyEABvX/OO61xjyhUNvfQhCbVda8jdbNfvu1uvCKzoTm585pU7fkg/UtYuQ/o9TQllOsRyC4rIBYmo7ms8djxTgxmeESqIPl+q9Wfw4sBA0L0PSIIa9HvH/ovGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5noZ9Ow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5noZ9Ow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869041F00893;
	Tue, 15 Sep 2026 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474851;
	bh=h6IvHvMsrseFQ1El8XWi6NUTZFRq5zGozAsPhP/hNq8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P5noZ9Ow/g++J/HMImAeosLwuKCjGUHSctFQg5aVn91vklagSOhoVnv/nM38S1Wkc
	 E+qitYKlrvWQhduRL5MhulGEGQQc42Vbqfe/UEfUGLkjIPmUB+iWab7khz6XpALoK3
	 ySlxKKNUsOkddgrni4Idm4YEVnxnfsJuApJzbVjiL7tCrHDjOoOFU/0Ly1WxdTbAmq
	 TtoU4noCp3dN1+pX6rGD0bXb8y5F1vIvfQu0c1lMJs0VOmde7aVTD/Zl/fZLKLPNfX
	 5OsRkd4SkqyqO4xTCfJCEDb/kuiKsr71t4DNr1R5tOfBeWxFG0fsfkq9KXJE40jlNC
	 hDdno/HB8zzIQ==
Subject:
 Re: [PATCH net v2] nfc: digital: check DEP_REQ length before reading DID byte
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 12:20:50 +0000
Message-ID: <178947485008.22033.3730814162554887880@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001F45C42BBD0D16D7B30ABC8BD2=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001F45C42BBD0D16D7B30ABC8BD2=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

- [Medium] The patch closes the 1-byte read past valid skb data in
  digital_tg_recv_dep_req(), but the identical unchecked-read pattern on…
- [Low] Commit message rationale is factually wrong, and the retained
  check it justifies is now dead code.

Pre-existing issues:
- [Medium] DEP wire-format mismatch for the optional DID byte in the
  target transmit path.

--

nfc: digital: check DEP_REQ length before reading DID byte

This reorders the DID check in digital_tg_recv_dep_req() so that the
resp->len test runs before resp->data[size] is dereferenced, avoiding a
one byte read past the valid skb data for a 3-byte DEP_REQ with the DID
bit set in the PFB.

No Link: tags present in the commit header.

A question about this part of the changelog first:

>     Reorder the condition so that the length check (resp->len < size + 1)
>     comes first and short-circuits before resp->data[size] is accessed.
>     The existing fallthrough to the later "size > resp->len" check is
>     preserved for the NAD case.

[Severity: Low]
Is that last sentence accurate?  In digital_tg_recv_dep_req() the NAD
branch never falls through to the later test, it returns immediately and
leaves size untouched:

	if (DIGITAL_NFC_DEP_NAD_BIT_SET(pfb)) {
		rc = -EIO;
		goto exit;
	}

	if (size > resp->len) {
		rc = -EIO;
		goto exit;
	}

Also, after this change, can "size > resp->len" ever be true?  Without the
DID bit size stays at sizeof(struct digital_dep_req_res) and the earlier
"resp->len < size" test already guaranteed resp->len >= size.  With the DID
bit the new guard requires resp->len >= size + 1 before size++.  So the
check that the changelog says is being preserved looks unreachable now.

Could the changelog be reworded to describe what the retained check
actually covers, and could the check itself be dropped or kept with a
comment saying why?

> diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
> index 3982fa084737f..ae5407fca12d4 100644
> --- a/net/nfc/digital_dep.c
> +++ b/net/nfc/digital_dep.c
> @@ -1117,12 +1117,12 @@ static void digital_tg_recv_dep_req(struct nfc_digital_dev *ddev, void *arg,
>  	pfb = dep_req->pfb;
>  
>  	if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
> -		if (ddev->did && (ddev->did == resp->data[3])) {
> -			size++;
> -		} else {
> +		if (resp->len < size + 1 || !ddev->did ||
> +		    ddev->did != resp->data[size]) {
>  			rc = -EIO;
>  			goto exit;
>  		}
> +		size++;
>  	} else if (ddev->did) {
>  		rc = -EIO;
>  		goto exit;

[Severity: Medium]
Does this leave the same read pattern open in the direct caller?  The
first DEP_REQ after ATR_RES arrives in digital_tg_send_atr_res_complete(),
which touches resp->data[0] and then resp->data[2] or resp->data[3] with
no resp->len check at all before dispatching:

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

For a frame shorter than offset + 1 bytes, those reads happen before the
new guard in digital_tg_recv_dep_req() runs, and the stale byte also picks
which handler is called.  That short frames do reach this layer is what
the sibling handler already assumes:

net/nfc/digital_dep.c:digital_tg_recv_atr_req() {
	...
	if (!resp->len) {
		rc = -EIO;
		goto exit;
	}

	if (resp->data[0] == DIGITAL_NFC_DEP_NFCA_SOD_SB) {
	...
}

The initiator side has the same shape in digital_in_recv_dep_res().  Only
"resp->len < size" with size == sizeof(struct digital_dep_req_res) is
validated, then skb_pull(resp, size) leaves resp->len == 0 for a 3-byte
DEP_RES, and the RTOX path reads resp->data[0]:

net/nfc/digital_dep.c:digital_in_recv_dep_res() {
	...
	skb_pull(resp, size);
	...
	case DIGITAL_NFC_DEP_PFB_SUPERVISOR_PDU:
		...
		if (ddev->atn_count || ddev->nack_count) {
			PROTOCOL_ERR("14.12.4.4");
			rc = -EIO;
			goto error;
		}

		rtox = DIGITAL_NFC_DEP_RTOX_VALUE(resp->data[0]);
	...
}

atn_count and nack_count are both cleared earlier in that same function,
so the PROTOCOL_ERR("14.12.4.4") test does not block a 3-byte supervisor
DEP_RES with the timeout bit set, and the value read then feeds
digital_in_send_rtox().

Since this is a stable-tagged fix for reads past the valid skb data on
crafted DEP frames, would it make sense to cover these two sites in the
same series rather than only the DID byte?

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the DID
handling here, the transmit side appears to place the DID byte in a
different position than the parser above expects.

digital_tg_recv_dep_req() treats the byte right after DIR/CMD/PFB as the
DID and increments size before skb_pull(), i.e. it expects
[DIR][CMD][PFB][DID][payload].

digital_tg_send_dep_res() pushes the header onto an skb that already
holds the payload and then appends the DID with skb_put_data(), which
extends the tail:

net/nfc/digital_dep.c:digital_tg_send_dep_res() {
	skb_push(skb, sizeof(struct digital_dep_req_res));

	dep_res = (struct digital_dep_req_res *)skb->data;
	...
	if (ddev->did) {
		dep_res->pfb |= DIGITAL_NFC_DEP_PFB_DID_BIT;

		skb_put_data(skb, &ddev->did, sizeof(ddev->did));
	}
	...
}

So a session that negotiated a non-zero DID (ddev->did = atr_req->did in
digital_tg_recv_atr_req()) transmits [DIR][CMD][PFB][payload][DID] for
every non-empty DEP_RES, and digital_send_dep_data_prep() then chains
that buffer.  digital_tg_send_atn() and digital_tg_send_ack() happen to
produce the right layout only because their skb is empty when
skb_put_data() runs.

Is the target really supposed to emit the DID after the payload here, or
should digital_tg_send_dep_res() reserve the DID byte in the skb_push()
and write it directly after the PFB?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001F45C42BBD0D16D7B30ABC8BD2%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
