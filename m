Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6038A733;
	Tue, 29 Sep 2026 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653955; cv=none; b=rruKEMWGjg5VOhp31FBhWBa2z7X1VPy0HK9wFR0tPvcL22SN5qJvhOeDTD/aZM5+eGuySYPtGEd9d7YiAjxolwUseVxdkJdaFi6RcsdmwI80LJJjl0rl2H4SAFhO8Z4otAOUBkehNXOTI4oYwHyqY8QIRbmXsDoE7ub6fRqseJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653955; c=relaxed/simple;
	bh=icN1mpFI1DrJ87rs1zndjGJ+YTyXk8g9Q/9nKXEata0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V5tGu14pLhkS+Ak7JqXDc5zNLzpoSWYvql3SiIOb9ILnJgfZQe6fho8XNNrI3aLK+h0uyUNfVS4zz8hZNYl1cX4S37ZPxTc7FabRHD5gnFKXv/pVIkq8+9hjoiGsySckcipHzNB2Yzf5XNrhfTy0Ci/T3H/2AT2Cr+CBug3uGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMAvBlm8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMAvBlm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C777C1F000FF;
	Tue, 29 Sep 2026 03:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790653954;
	bh=Fft2AcEFDphF6PMMDAjg8XfKmBNd9stS3cTZIW7mGLA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fMAvBlm8t+O57xEiDfxspaDe2M1AZe7/vMO4N9pMA9TtqDwiLWJ01xt0HOFj4vPRB
	 l5NSPKh9G+CATen9khtw2ZR4jsFFtxyF3C0/RNnMkTNJq/lViEO7hU+8V8qUdHQfR4
	 p9HFVK9BAXfeyviepo9/e2HEeC8+0Y9sy/tefznkz59iBpLr1IRUOBaZUYPthqBIpc
	 i3HFnVP26yhBgQcjiltrflzLu16NasyDOgsvOlRUEx7VNv4ryqpBFCbHFbR6v5/6U9
	 bf3KfaLqKOYYs2GUMbl7O8RT27ibJdU0bMdNHOD2f02y8RE5ATjBwxM3+7xcLhNaLG
	 nTpaKaq6MbDWw==
Subject: Re: [PATCH] xfrm: esp4: use current ESN high bits for IV and AAD
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org
Date: Tue, 29 Sep 2026 03:52:33 +0000
Message-ID: <179065395333.434549.4778570879815338716@kernel.org>
In-Reply-To: <20260925095128.446450-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260925095128.446450-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch fixes only the IPv4 ESP transmit path.
- [Medium] In esp_xmit() (net/ipv4/esp4_offload.c), the patch stores the
  pre-advance high half only in the local `seq_hi`.
- [Low] The commit message never says which path is affected, and it
  leaves out part of the impact.

--

xfrm: esp4: use current ESN high bits for IV and AAD

This commit makes esp_xmit() save both halves of the current sequence
number before it advances the GSO sequence state, and builds esp.seqno
from that saved value. esp_output_set_extra() now takes the ESN high
bits for the AAD from esp->seqno, not from the offload or skb cb state.

> With AES-GCM, this assigns
> the boundary packet the same nonce as the packet sent one complete
> 32-bit sequence-number cycle later.

[Severity: Low]
This isn't a bug, but could the commit message say which configurations
are affected?

In esp_xmit(), the sequence only advances under XFRM_GSO_SEGMENT.
esp.seqno and the AAD are only used by esp_output_tail() when hw_offload
is false. That seems to limit this to GSO traffic that is segmented in
software and encrypted through the CRYPTO_FALLBACK path.

Two other details also seem to be missing:

With the old code, the boundary packet carried AAD seqhi H+1. The peer
works out H from its replay state, so it would already fail ICV
verification on that packet.

The collision with the packet one cycle later only happens if that later
packet at low 0xffffffff is not itself a software-segmented GSO segment.
Such a segment would get hi H+2.

> diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> index abd77162f5e75..79f7d08325c50 100644
> --- a/net/ipv4/esp4_offload.c
> +++ b/net/ipv4/esp4_offload.c

[ ... ]

> @@ -334,7 +336,7 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
>  	if (xo->seq.low < seq)
>  		xo->seq.hi++;

[Severity: Medium]
The saved seq_hi only goes into esp.seqno, and only esp_output_tail()
reads that, on the !hw_offload path. On the hw_offload path, xo->seq.hi
is still incremented here for the segment whose on-wire low seq is
0xffffffff. skb_ext_add() keeps that value and it goes to the driver
with XFRM_XMIT.

Can the advanced high half still reach the device AAD for ESN SAs?

ch_ipsec sets NETIF_F_HW_ESP but not NETIF_F_GSO_ESP. So TCP GSO over an
offloaded SA is split in software by esp4_gso_segment(), which sets
XFRM_GSO_SEGMENT. xmit_xfrm_check_overflow() in validate_xmit_xfrm()
only runs for skb_is_gso() skbs, so it does not run for these segments.

ch_ipsec supports ESN, and copy_esn_pktxt() builds the AAD like this:

drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c:copy_esn_pktxt() {
    ...
	seqlo = ntohl(esphdr->seq_no);
	seqno = cpu_to_be64(seqlo + ((u64)xo->seq.hi << 32));
	memcpy(aadiv->seq_no, &seqno, 8);
    ...
}

For the boundary segment, the device would authenticate over
(H+1, 0xffffffff). The peer expects H and would fail ICV verification.
The AAD would also match the packet one cycle later.

nfp_net_ipsec_tx_prep() also copies xo->seq.hi, but NFP rejects ESN
states at add time, so only ch_ipsec seems to be affected. I could not
confirm whether this also leads to nonce reuse, because ch_ipsec takes
the IV from the packet's IV field.

>  
> -	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
> +	esp.seqno = cpu_to_be64(seq + ((u64)seq_hi << 32));

[Severity: Critical]
Commit 4b549ccce941 (the Fixes target) added the same wrap handling to
both esp_xmit() and esp6_xmit(). Is the IPv6 side still affected after
this patch? The commit message does not mention IPv6.

net/ipv6/esp6_offload.c:esp6_xmit() {
    ...
	seq = xo->seq.low;
    ...
	if (xo->flags & XFRM_GSO_SEGMENT) {
		esp.esph->seq_no = htonl(seq);

		if (!skb_is_gso(skb))
			xo->seq.low++;
		else
			xo->seq.low += skb_shinfo(skb)->gso_segs;
	}

	if (xo->seq.low < seq)
		xo->seq.hi++;

	esp.seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
    ...
}

esp_output_set_esn() in net/ipv6/esp6.c also still takes the AAD high
half from the advanced offload state:

	if (xo)
		seqhi = xo->seq.hi;
	else
		seqhi = XFRM_SKB_CB(skb)->seq.output.hi;

For the boundary segment with on-wire seq (H, 0xffffffff), that gives
IV (H+1, 0) and AAD seqhi H+1. This is the same problem this patch fixes
for IPv4.

esp6_xmit() also builds the IV from the advanced low half. A
software-segmented packet with header seq S is therefore encrypted with
IV S+1, even when there is no wrap.

xfrm_replay_overflow_offload_esn() reserves exactly gso_segs numbers
(S..S+n-1) for a GSO skb, so the next packet gets S+n. Suppose that
packet is not GSO: it goes through esp6_xmit() without
XFRM_GSO_SEGMENT, or through esp6_output(). Its IV is then S+n, the
same IV the last segment of the previous batch used.

esp6_output_tail() copies esp->seqno straight into the AEAD IV.

Could this give AES-GCM nonce reuse within a single sequence cycle?
xfrm_dev_offload_ok() returns true when x->xso.dev is NULL. Non-offloaded
SAs with esp6_offload loaded would then go through:

xfrm_output()
  xfrm_replay_overflow_offload_esn()
validate_xmit_xfrm()
  esp6_gso_segment()
    esp6_xmit()   /* CRYPTO_FALLBACK */
      esp6_output_tail()

Should esp6_xmit() also save both halves before the advance and build
esp.seqno from them? Should esp_output_set_esn() then take seqhi from
esp->seqno?

>  
>  	if (hw_offload && encap_type == UDP_ENCAP_ESPINUDP) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925095128.446450-2-Jeremy.Jean%40oss.cyber.gouv.fr
