Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266668;
	b=4/JtazDacM2DwaZYHw0bqvnY8aChpcLQMUKEWNY4CBEnMBhiOOy7NPACERH3QV5FdknH
	 AmaD6l15I/xcncbsnulXIdEYUTYeBiNPr23pNGS3JCgh9Sxa9y7ZQ/v5BSmbKwMuADeN3
	 XPc4P2L3ypRXQSVMMY68awiWVQN2YcbBCruKHHX09yDUwTkiuk4QTgBfq2Yl+1L5FezTZ
	 3U+IhYVcK4JSeCf9SuE+Uqr3O4x7XjYVJXJ381638PbfXYOSlqeRuC1eJ+PhVMVa0cKPE
	 FsGbslWzqNelQs2OC9bFEu9uGz66eoPtChRS+SpoCfpzyK5//UKuNjjHx6mqep6GpGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266668;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9C2s1QNFolN3kugJfyD+5SXr39r+c73y9g8wz+xyicY=;
	b=OqfbjLyswy3xDGykIlKjO12XM5/lhnNvwjH8+OnbYBwd8OqoMtkffaOHt/ZerMLEtDO7
	 cvWwr8M/SmbYGE6q/lavNi+PSHNaT5OaDKK9pSXT0Sd1F8aN1+MaaZ/vreLpI5tzm2+fa
	 N3WYicZunAEdZS8UIkbMapNXX9oJ/2stcC98XzmDCemTjK79sk2gaacFR0YbA/a4gJUfB
	 fiz1KJRk8FiJ3M+xNpfzVu1/KQqPqAIczf2H8HUpYpsFFzVOc8l7KAcdLsSy54fre2RWE
	 oxvR9xPWNHku6SWcRxNQAMNQ5wRk+/WBnx0LP0t4CNdYhVBb1hMvQaXYqf1f5jDDIpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPLbb08n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03675606A335;
	Mon,  9 Nov 2026 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPLbb08n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163241F0089F;
	Mon,  9 Nov 2026 23:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266667;
	bh=9C2s1QNFolN3kugJfyD+5SXr39r+c73y9g8wz+xyicY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nPLbb08nvVW6XhAA6j6TFjx5qGvOTysLNsJ4VUEvCFvfWGI2OXHUkwV1IYxzv5evH
	 P5WQcHNgiCW+I4ymWmmeiiSt95Bayyxztxu1FdU3gTsEdyS4ZcmQTExHqbeLWhGvh6
	 H6i4Jl88zJcyPrYFaj4DwVQKXCoxBE8OCp66sxXz9ToJvi+zSY1VJHm27Qwg/te16a
	 QsIfovLs/zUtP+YWvkCa4cr1IEjshv9Povp29f9wwnOsMJC1PpT+aYudFXcHLtFhZu
	 dpI7KXuzoOjvUFVpeyYUPrF7PUMDEbqjAuPN+mDrl0JmnceXWbjj3sLPomeFpdjcin
	 cSdS3ewM4ZOuQ==
Subject:
 Re: [PATCH] net: dsa: sja1110: pull meta timestamps before reading them
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 23:24:26 +0000
Message-ID: <179426666660.994134.10642884311879085983@kernel.org>
In-Reply-To: <mnJ9l2Ebi69wyTB5k6FBEnjRESb0SmEnlqwaQAOEJ1x5qRQJ3ZMVAdX7Bn9-yWEnQ0iv_3KLoI1yUVCc88IJOVGGow9rOyG6Y54sPMeW0zQ=@proton.me>
References: <mnJ9l2Ebi69wyTB5k6FBEnjRESb0SmEnlqwaQAOEJ1x5qRQJ3ZMVAdX7Bn9-yWEnQ0iv_3KLoI1yUVCc88IJOVGGow9rOyG6Y54sPMeW0zQ=@proton.me>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In sja1110_rcv_meta() (net/dsa/tag_sja1105.c), the patch adds a
  pskb_may_pull() but leaves `buf` stale.
- [Low] The commit message is not fit to apply.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the trailer
  branch of sja1110_rcv_inband_control_extension()…

--

net: dsa: sja1110: pull meta timestamps before reading them

The patch adds a pskb_may_pull() to sja1110_rcv_meta(). The pull covers
the (n_ts + 1) ten-byte timestamp records before they are parsed. The goal
is to harden the SJA1110 meta frame parser against truncated or non-linear
skbs.

> net: dsa: sja1110: pull meta timestamps before reading them
>
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

[Severity: Low]
This isn't a bug, but the changelog has a few problems for an applied
commit.

There is no Signed-off-by: line. The only trailer is a Reported-by: that
names the author.

The "Hello," greeting, the AI-assisted review note, the "has NOT been
compiled" disclaimer and the reference to the reporter's tree read like
cover letter text. Should they go below the --- line?

The message calls this "Longstanding code" but has no Fixes: tag. The meta
frame parsing seems to come from commit 566b18c8b752 ("net: dsa: sja1105:
implement TX timestamping for SJA1110"). The buf initialization was later
reworked by commit 5d928ff48656 ("net: dsa: create a helper for locating
EtherType DSA headers on RX").

The changelog also says the non-linear skb read is fixed. See the comment
below on buf: that claim may not hold.

> diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
> index bfe1f746f55be..caa66596a0840 100644
> --- a/net/dsa/tag_sja1105.c
> +++ b/net/dsa/tag_sja1105.c
> @@ -537,6 +537,12 @@ static struct sk_buff *sja1110_rcv_meta(struct sk_buff *skb, u16 rx_header)
>  	struct dsa_switch *ds;
>  	int i;
>  
> +	if (!pskb_may_pull(skb,
> +			   2 + (n_ts + 1) * SJA1110_META_TSTAMP_SIZE)) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +

[Severity: High]
Can buf end up pointing into freed memory after this pull? buf is set at
the top of sja1110_rcv_meta(), before the new check, and is never
reloaded:

	u8 *buf = dsa_etype_header_pos_rx(skb) + SJA1110_HEADER_LEN;

If the meta payload is not fully linear, pskb_may_pull() calls
__pskb_pull_tail(). When there is not enough tailroom, that function
reallocates the head:

	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))

pskb_expand_head() copies the data into a new head and frees the old one
with skb_free_head(). The kernel-doc for both functions says header
pointers must be reloaded after the call.

The loop further down still reads through the old pointer:

		ts_id = buf[0];
		source_port = (buf[1] & GENMASK(7, 4)) >> 4;
		dir = (buf[1] & BIT(3)) >> 3;
		tstamp = be64_to_cpu(*(__be64 *)(buf + 2));

Those values then go to tagger_data->meta_tstamp_handler().

dsa_switch_rcv() calls skb_unclone_full() before ->rcv(), so skb_cloned()
should not trigger the realloc. The eat > 0 case still can, for example
on a conduit that builds small fixed-size heads and puts the rest in
frags.

In the non-linear case the commit message describes, would this turn the
out-of-bounds read into a use-after-free read?

In sja1110_process_meta_tstamp(), a garbage ts_id that matches nothing
hits WARN_ON(!skb_match). A ts_id that does match would pass 8 bytes of
freed memory to skb_complete_tx_timestamp() as the TX timestamp.

Would it work to recompute buf after the pull succeeds, or to move the buf
initialization below the pskb_may_pull() check?

>  	cpu_dp = conduit->dsa_ptr;
>  	ds = dsa_switch_find(cpu_dp->dst->index, switch_id);
>  	if (!ds) {

[Severity: High]
This isn't a bug introduced by this patch, but the commit message's threat
model ("buggy or compromised switch silicon" and "short-skb conduit
paths") also applies to the caller, sja1110_rcv_inband_control_extension().
Its trailer branch looks like it can reach BUG() on a malformed header.

start_of_padding comes straight from the 12-bit header field and is never
checked:

	if (rx_header & SJA1110_RX_HEADER_HAS_TRAILER) {
		int start_of_padding = SJA1110_RX_HEADER_TRAILER_POS(rx_header);
		u8 *rx_trailer = skb_tail_pointer(skb) - SJA1110_RX_TRAILER_LEN;
		...
		if (pskb_trim_rcsum(skb, start_of_padding - ETH_HLEN)) {
			kfree_skb(skb);
			return NULL;
		}
	...
	/* Advance skb->data past the DSA header */
	skb_pull_rcsum(skb, SJA1110_HEADER_LEN);

If start_of_padding is between 14 and 17, the trim leaves skb->len at 0 to
3 and returns success. The unconditional skb_pull_rcsum(skb, 4) would then
hit BUG_ON(len > skb->len) in skb_pull_rcsum(). Should start_of_padding be
checked against ETH_HLEN + SJA1110_HEADER_LEN and skb->len?

The same branch reads the 13-byte trailer from skb_tail_pointer(skb) with
no check on skb->len or linearity. On a non-linear skb, would that parse
the end of the linear area instead of the real trailer?

In VLAN-filtering mode the taggers accept hardware-stripped VLAN tags. If
a conduit strips the 802.1Q tag from a front-port frame whose inner
EtherType is ETH_P_SJA1110, could rx_header contain bytes from the wire?
That has not been confirmed.

sja1105_meta_unpack() has a similar issue. It reads 8 bytes from
skb_mac_header(skb) + ETH_HLEN without a pskb_may_pull() or length check:

	u8 *buf = skb_mac_header(skb) + ETH_HLEN;

Should these sites be hardened as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/mnJ9l2Ebi69wyTB5k6FBEnjRESb0SmEnlqwaQAOEJ1x5qRQJ3ZMVAdX7Bn9-yWEnQ0iv_3KLoI1yUVCc88IJOVGGow9rOyG6Y54sPMeW0zQ%3D%40proton.me
