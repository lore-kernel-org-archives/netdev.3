Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0F4B0CA8
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824487; cv=none; b=tWhdfzXIzPB6TtNTEsAC8/brwOUGHoKJwX2d1I/mdXPLhV3A7e71ajhpBMsyEPfoFBa/+e5CGwvCNvm7AMZFn0HO2NfqYN/iIYJ6HsxLvHFynhjoFpADk/gibBzcl5f0XzftFwXKVDGwSFSXMSjqZ4/TOj1TrJvAfUBMgaQ+19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824487; c=relaxed/simple;
	bh=Kvqq3neIcJIOkqhMyaUtzbs0RF3PiUTwxbjEPUgSEgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke94bhrHV22MieuBDomu+BOxwYgnfeDwVkQYTmYm1ymKDWlDCADUYWx0URnhsZmhEmJlG/IAEXrcR9QQyXHcpu57+CveKaPDmueipaqK+RCikqSAC6KB+Xbrpab8z5DTPNz9zCetffLEjLqAw+EDDNAiIksCad8C9rV8s7+90Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=b3ttMi00; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="b3ttMi00"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ccc7a6070b4so929139a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791824485; x=1792429285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LM5URb2lU/tFoGm1eLbE+5hjvfWsMzRWJaYUQC+NzjQ=;
        b=b3ttMi00bItLAuc3jSFfEx105+ftBCL7MibwZ1Sk5WDWSP1PRnFn21Zl/VbbL4Rrb+
         N9NRRUxUrPEgX1GrdOFrPm1Myn7QECd+Mb3DFKcloilEBnwKjjMeQntAXhWaTEQnxuje
         F74DdIAAZ0YIVeqaQ48Ry5zhGHyWU0XDYdGs4wzbrsdUFGRKaXRVXE9enB/+NjUjOnlg
         PhOUnALaHCReieCPdc7P/N3ULo/p9eQ9MjmSmLKxvXFYfTY7OFp6dseuX7BgE8r7jm+G
         mA3g4JzVuEjSMIZvQySawP/r85Zd23jUeM8pABdUZvh5ifE9eEoSSEhMrpZVw1XLZPV3
         oFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824485; x=1792429285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LM5URb2lU/tFoGm1eLbE+5hjvfWsMzRWJaYUQC+NzjQ=;
        b=ZYcBBWxTn8hXiLgAyP6xYEH+pHjE3Pi61xbBd1A1sMp/9sjFHLd/WAcc05xAsIZwda
         M+GMdyNUiPunFgteK50Yxw1j1abUc+QO78Bv3V/EM+3yNSXva5MuTt6R+0fEcYmGvrit
         r390SrN3w6Xw2pR8I948+Yty5sf48lHyWF6rOHislrOm7L8pbwEHenM3eBzkikSfYl8B
         z3H9wAHOGgKXzFWPRPJErn+u3jXq5KdlIXERQQfQN+oCPtX1SEZIP3bTdN+IDOj8FL1q
         lyJxPw1udZt1RWuUv0iI1clrrgWBc24isHn1Z/GaL4StM9zfp8EedbKAxEfiKZt5Vred
         eeYg==
X-Gm-Message-State: AFq9FYIzJLrMkAcOvcipXTds1cbHpuge+bdMpk6FUCtQn5xYU3r6e1fu
	DII5bcP5Ij8exrQfRe2uJFvkuKAburlS2yc6ZxP03OSYp//spG/7wPMs7i4LbbWZSWY=
X-Gm-Gg: AYBFou3rlf19oACbbcq52kGff2oWR63OAH5AVoAorz2biG/9EXPFwqt3HGaERqeokZ5
	8bqHnlPXnQLaVEQS9ipGKEz1YvJPTsVwM9r8P6s+T6p183qIfh//FLWzuCwIo+GwABx41eSl/dK
	Y8GU8U7FKP7od+jTVbf8sJU7TcnRidxwxv/x6YG3RBrKkbznCfxXZkfXJZSRH+49cOxcX3AJJbk
	N05vaHRwRgMUkBhCZpN/JtX9+/AeLZnxrjp8jipuUFF+tjYwXLGCeDU4sbE2CCQviLkmQNymm3C
	jGumGO7x6eJMMx+dy+Nt5+dzNaceF1xZj4Mu1OtC5w5/lea9aQcya7MQ8vzuuvJKcrc98jH2s63
	s/TPX+2g680kvWK3P1/Vj2lzh+rHxtUvwatZ+lgBX0YxCWip92/k02ApL+95FZmHrl4nJhitQkg
	GZzxthQPJw+gGsSfayL2ZsvcW9K9+F7bRpVm9lBY0koMBKInDaIL7Fy3n+8EIFKSJF3pKBd1hEM
	kBCt1wLKH0J
X-Received: by 2002:a17:90b:5807:b0:3a4:9dd7:296f with SMTP id 98e67ed59e1d1-3ab3a9dfda0mr7694579a91.40.1791824484738;
        Mon, 12 Oct 2026 10:01:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38ddac6dsm16340481a91.7.2026.10.12.10.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:01:24 -0700 (PDT)
Date: Mon, 12 Oct 2026 10:01:23 -0700
From: Joe Damato <joe@dama.to>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] bnxt_en: Pad short SW USO segments to
 BNXT_MIN_PKT_SIZE
Message-ID: <as0SY35kyZ0Tkjv1@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	linux-kernel@vger.kernel.org
References: <20261009215426.2377946-3-joe@dama.to>
 <179167292595.434549.1613365899561738680@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179167292595.434549.1613365899561738680@kernel.org>

On Sat, Oct 10, 2026 at 10:55:25PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

[...]

> 
> [Severity: Medium]
> Should this have a Fixes: tag and Cc: stable, and go to net?

I mentioned this in the cover letter but Jakub specifically asked me to send
this to net-next since this issue cannot be triggered by ipv4 UDP and I have
not seen this issue in production,

If the maintainers change their mind and want me to resend to net, please let
me know.

> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > index ef04c9d08066d..80d5c4f963a95 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> > @@ -82,11 +82,19 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> >  	if (unlikely(num_segs <= 1))
> >  		goto drop;
> >  
> > +	/* bnxt_features_check() makes the stack segment these, but paths
> > +	 * that skip validate_xmit_skb() (e.g. generic XDP_TX of a GRO'd
> > +	 * skb) can still get here. Padding every segment would need more
> > +	 * BDs than bds_needed reserves below, so drop instead.
> > +	 */
> > +	if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
> > +		goto drop;
> 
> [Severity: Low]
> Could the commit message mention this new drop?
> 
> The changelog only says that bnxt_features_check() clears the GSO features
> so the stack segments these skbs. That covers callers that go through
> validate_xmit_skb(), but not callers that skip it, for example:
> 
>   generic_xdp_tx()
>     netdev_start_xmit()
>       bnxt_start_xmit()
>         bnxt_sw_udp_gso_xmit()
> 
> On these paths, when hdr_len + gso_size is below BNXT_MIN_PKT_SIZE, the skb
> is now freed and tx_dropped is incremented. Before this patch the skb was
> sent as short segments. The comment in the code explains this, but the
> changelog does not mention it.

I think mentioning it in the comment is sufficient, but up to the maintainers
if they want a respin for me to add this to commit message.

> > @@ -133,12 +141,14 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> 
> [ ... ]
> 
> >  		last = (i == num_segs - 1);
> > +		pad = bnxt_sw_gso_pad_len(hdr_len, seg_payload);
> >  		offset = slot * TSO_HEADER_SIZE;
> >  		this_hdr = txr->tx_inline_buf + offset;
> >  		this_hdr_dma = txr->tx_inline_dma + offset;
> 
> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch. Is hdr_len
> ever checked against TSO_HEADER_SIZE before tso_build_hdr() copies the
> header into this slot?
> 
> Each slot is TSO_HEADER_SIZE (256) bytes. They sit in tx_inline_buf, which
> bnxt_alloc_tx_inline_buf() allocates with kmalloc() as
> BNXT_SW_USO_MAX_SEGS * TSO_HEADER_SIZE bytes. tso_build_hdr() then does:
> 
> net/core/tso.c:tso_build_hdr() {
> 	int hdr_len = skb_transport_offset(skb) + tso->tlen;
> 	...
> 	memcpy(hdr, skb->data, hdr_len);
> 	...
> }
> 
> The driver then writes uh->check at skb_transport_offset(skb).
> 
> If hdr_len is larger than 256, can this overwrite the next slots? For the
> last slot, can it write past the end of the tx_inline_buf allocation?
> 
> The validate_xmit_skb() path seems safe. bnxt advertises NETIF_F_IPV6_CSUM,
> so gso_features_check() removes NETIF_F_GSO_UDP_L4 from IPv6 skbs with
> extension headers.
> 
> The paths that skip validate_xmit_skb(), which the new comment above
> mentions, do look reachable. One example is a remote peer sending IPv6/UDP
> datagrams with large hop-by-hop or destination options headers, which
> ipv6_gro_pull_exthdrs() merges. The skb then takes this path:
> 
>   __netif_receive_skb_core()
>     do_xdp_generic()   /* XDP_TX */
>       generic_xdp_tx()
>         netdev_start_xmit()
>           bnxt_start_xmit()
>             bnxt_sw_udp_gso_xmit()
> 
> Neither bnxt_features_check() nor bnxt_exthdr_check() runs on this path.
> 
> A generic XDP program that prepends bytes with bpf_xdp_adjust_head() can
> also make the transport offset larger. bpf_prog_run_generic_xdp() only
> resets the network header.
> 
> Would it make sense to drop skbs with hdr_len > TSO_HEADER_SIZE next to the
> new bnxt_sw_gso_pad_len() check?

I think this is real, but this is not specific to bnxt and it affects any
other drivers that use the tso helpers (I think).

My suggestion would be to send a followup that fixes this in the core code
instead of patching bnxt and every other driver that uses the tso helpers.

Maybe the correct fix here is to call validate_xmit_skb in the generic XDP
path and solve this for all drivers and also solve "low severity" issue
mentioned above (?)

Maintainer input would be welcome here, but IMHO, this seris is good as as-is
and a followup series could be sent to try to fix this in core.
