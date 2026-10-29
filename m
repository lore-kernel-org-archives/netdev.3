Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283329;
	b=QdNeakExSQEmWi46FZbzgeY0PsuNyfxKoY2Qn8myPvPFZnHKoaUpNVBK44qJbQojXMH1
	 na0xFmzl9Lxd047nT0tnjcxiAspdCoWumTWh2qrcxkh4BkY/zTTe/FJAwfLhWDPdE//Bf
	 PrF5dqfdSUrex7+nh7PEzaEPnEznXuaOpXQwYRT3+JC+ZUCvP/erGWW6LynYNlL6pUso4
	 1ynhvk2RXycu/ilXbH2gyv1eDsjSWeZAz3tDPlGFnp4ms65Cj4d6tUEKcY0fUAtzzq3bs
	 V5IZXle6yMf+Lj77POmAXXgeuPSNslUirIQ81ixTlngLbJCkW97BSDe+8ZXUZL0a5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283329;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0AHp3uyFMRdoqAxeWLxWoxQZ4VjkhuHT2XvQu4hNfBg=;
	b=qHFeu53KCqo6akNEbkkb+E82j1m/xQgijaWWktYCRbAVapGGSeG5YCWDM3EkjtBSCwd5
	 Ve1tdlBj5vnDSec2Tua4WCX3GDQhUgd2lGAkVooNNSR6J5O1qzeVcZYmnfa0hIcrwNsFW
	 eswiDHsKcPW2+VhuyeHM6w4UWerXwlddukQ5kISooOaREntl1nO0le2MavVHXRd7JhW5I
	 GneZOtibsv0lH6QgZW2qCd88YfDzjOezglBqipApKmeZHoliFZ7vvZF5H5TmpeCD6IW64
	 HxQsJB/QolWfISMebGW8ZCYu8bYdcqEeliMDDXzdqUYj75CD8j/hBJuHXIiTwaU8Nbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj9qUfs8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F89606A31F
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj9qUfs8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966E81F01825;
	Thu, 29 Oct 2026 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793283329;
	bh=0AHp3uyFMRdoqAxeWLxWoxQZ4VjkhuHT2XvQu4hNfBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tj9qUfs8Z0mvtCM9bv/pM5tze3y51idJ1/qMeBvpFgozVe1CxVnETv17JyXN/qInL
	 gD4pdVGXnlOc+CUirCUaZTB3GZWpQlYrXvlyP6Kxeu6SiPZCC2v57IwxmtJcMghgGb
	 ZCLiWgmFSIVnDj2DgPRftyR1dJhZudMoGIRdqgxw9IlKjLZxkexOjepzsB2nyBkAQd
	 XzKpMi0rQcy/sj1ZxMndY9TtYUjTkGUSvzkfxo2mwUOYMM/5RZrKi6XXFMkkwEHFQI
	 KBa/DUPX0zvNiCdk0G5EXEHd4UPk70LyiwTEMiPfXKkwRB26nR/j3LoYGt/CZ7BvRT
	 36KxtfY0osb+g==
Subject: Re: [PATCH net 1/2] net: gro: do not undo remote checksum offload on
 merged packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, steffen.klassert@secunet.com,
 AutonomousCodeSecurity@microsoft.com, netdev@vger.kernel.org,
 tsgatesv@gmail.com, cenzhang@linux.microsoft.com
Date: Thu, 29 Oct 2026 14:15:28 +0000
Message-ID: <179328332814.3134.7858322712930731649@kernel.org>
In-Reply-To: <20261028141325.2103814-2-edumazet@kernel.org>
References: <20261028141325.2103814-2-edumazet@kernel.org>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Both the commit message and the new code comment give a wrong
  reason for skipping the cleanup in the fraglist case.
- [Low] The new comment in skb_gro_remcsum_cleanup() (include/net/gro.h)
  says "Once merged, skb->data was moved past the headers".

Pre-existing issues:
- [Critical] This only applies to this commit taken on its own.

--

net: gro: do not undo remote checksum offload on merged packets

This patch makes skb_gro_remcsum_cleanup() return early when
NAPI_GRO_CB(skb)->same_flow is set. A merged skb may have had skb->data
pulled past its headers, so the 2-byte undo at grc->offset could land in
payload or in memory freed by a fraglist pull. The commit message says the
non-merged frag0 case is handled in the following patch.

> diff --git a/include/net/gro.h b/include/net/gro.h
> index 2300b6da05b27..b560e866683b0 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -351,7 +351,10 @@ static inline void skb_gro_remcsum_cleanup(struct sk_buff *skb,
>  	void *ptr;
>  	size_t plen = grc->offset + sizeof(u16);
>  
> -	if (!grc->delta)
> +	/* Once merged, skb->data was moved past the headers, and

[Severity: Low]
Is this true for every merge path? In skb_gro_receive(), only the merge:
frag_list path calls __skb_pull(skb, offset). The frag-steal and head-steal
branches set same_flow without moving skb->data:

net/core/gro.c:skb_gro_receive() {
    ...
	if (headlen <= offset) {
		...
		skbinfo->nr_frags = 0;
		...
		NAPI_GRO_CB(skb)->free = NAPI_GRO_FREE;
		goto done;
	} else if (skb->head_frag) {
		...
		NAPI_GRO_CB(skb)->free = NAPI_GRO_FREE_STOLEN_HEAD;
		goto done;
	}
    ...
done:
    ...
	NAPI_GRO_CB(skb)->same_flow = 1;
}

On those paths the cleanup is skipped for a different reason: the skb's
frags or head now belong to p, and the skb is about to be freed.

The commit message says skb->data "might have been moved", but the comment
says it always was. Could the comment describe both cases?

> +	 * the headers of this skb will not be used anymore.
> +	 */

[Severity: Low]
Is this accurate for fraglist members? The commit message has a similar
claim:

  Headers of a merged skb are not used anymore: the skb is either freed,
  or its headers are rebuilt from the head skb in skb_segment() or
  skb_segment_list().

Before calling skb_gro_receive_list(), udp_gro_receive_segment() sets the
member's network header to the inner network offset:

	skb_set_network_header(skb, skb_gro_receive_network_offset(skb));

skb_segment_list() then copies only the link-layer and tunnel headers from
the head skb:

net/core/skbuff.c:skb_segment_list() {
    ...
		skb_push(nskb, -skb_network_offset(nskb) + offset);
    ...
		nskb->transport_header += len_diff;
		skb_copy_from_linear_data_offset(skb, -tnl_hlen,
						 nskb->data - tnl_hlen,
						 offset + tnl_hlen);
    ...
}

The member keeps its own inner IP and UDP headers. When addresses and
ports match, __udpv4_gso_segment_list_csum() returns early without touching
them. So the inner checksum written by skb_gro_remcsum_process() is what
gets sent for those segments.

The behavior still looks correct. The retained value is the full
remote-checksum result, the same value the non-GRO skb_remcsum_process()
path would write. Only the stated reason seems wrong.

Could the comment and commit message say that fraglist members keep their
adjusted inner headers, and that this adjusted checksum is the intended
value?

> +	if (!grc->delta || NAPI_GRO_CB(skb)->same_flow)
>  		return;
>  
>  	ptr = skb_gro_header(skb, plen, grc->offset);

[Severity: Critical]
This isn't a bug introduced by this patch, but the same_flow check does not
cover a non-merged skb whose frag0 has gone stale. In
udp_gro_receive_segment(), the is_flist branch pulls first and can then
still reject the packet:

net/ipv4/udp_offload.c:udp_gro_receive_segment() {
    ...
			if (NAPI_GRO_CB(skb)->is_flist) {
				if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
					NAPI_GRO_CB(skb)->flush = 1;
					return NULL;
				}
				if ((skb->ip_summed != p->ip_summed) ||
				    (skb->csum_level != p->csum_level)) {
					NAPI_GRO_CB(skb)->flush = 1;
					return NULL;
				}
    ...
}

pskb_may_pull() can drop frags[0] if it holds only headers. If headlen is
non-zero, pskb_expand_head() can instead free the old head that frag0
points to. Neither NAPI_GRO_CB(skb)->frag0 nor frag0_len is updated.

If the checksum-state check then fails, or skb_gro_receive_list() returns
-E2BIG, same_flow stays 0. vxlan_gro_receive(), vxlan_gpe_gro_receive() and
gue_gro_receive() then call:

skb_gro_flush_final_remcsum()
  skb_gro_remcsum_cleanup()
    skb_gro_header()   <- frag0 fast path, stale frag0_len >= plen
    remcsum_unadjust() <- 2-byte read-modify-write

Can that write land in a page or head the skb no longer holds a reference
on?

The commit message says this case is handled in the following patch, "net:
gro: invalidate frag0 after a pull". In the final series state, that patch
adds skb_gro_frag0_invalidate() after this pskb_may_pull(), after the pull
in skb_gro_receive_list(), and inside skb_gro_header_slow(). So the issue is
gone by the end of the series.

The two patches carry different Fixes: tags. Should they be marked so that
stable backports take both together?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028141325.2103814-1-edumazet%40kernel.org
