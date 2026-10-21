Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604439;
	b=034IkmKhkQ5Fd2rnHUhWWK7uJxUPul/zIcWF73MSEY9tPlJHe9aNH43p3kX05BdpJ7J3
	 0rc69z3gZ4rW4D1fSBbJejjWqCtQqqFT79kBtnblcyLSqWUK6HLQBczj7l1xS4FTnjvxB
	 MBYvqy2icaQDxTY1RqYqWXSBRSWm2Rxl4GNJPFfht3QgDIubNjicPFx9kMd4XDDVY+6yn
	 dgwy7vHbiiYuJYoLN8k1Zk6Lug51Hrc9JgSo1ft6KNTMloXQfr6iq1VDjFvFcK1UrcXdS
	 wpgY6tYt3fOQsbUeodu0Cwu68eYwgcyNq/smeO3fJ9/eJS9ZelBmLqzQ+Xx0q+YEE2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=00X3tkeYEageGUPFxKdI7i9tn0PnsQa8KK7nyWnisf4=;
	b=FVBOVs4mbl70BcVSd0zbNuluIBIe6btl5o/LHT1TuebuWlHFuUhlvQiUI4qBkV9slZjn
	 IkAh+miFV31PCqpPlV7MnGCSfOIiwDubVIw9zEDTOHWarRabY5cNjpGVb9yrrxS6GEY2k
	 V2zqdIlm5q13OgzVjouoYmGc0obvgrOcobfR4ec50xkLgYIAjyH5kSuEnWfg2KXSyuoUe
	 87fCkhytqMudyMhxyyVt9SfgndoR+XLPayYD6OWfH34s4Hv5Cl1zmY1ziliQvNVHvmzeY
	 lNOSWlHTLnv9MnNiqpQXNeVnsHtMRt7WHSHQeHTSmF3SwAnqSWHBWSrmhnJ6PPj5RYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a6mbPh4b;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65234606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65234606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a6mbPh4b
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e5fb79ce82so5617195ad.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792604439; x=1793209239; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=00X3tkeYEageGUPFxKdI7i9tn0PnsQa8KK7nyWnisf4=;
        b=a6mbPh4baF5S+XvtoMt5BFfbKPeHhZgNSoYnmMmhUBYT/dBZf9DU/4q53r43EndSXP
         RWGdz0dw7Rj23sSAJO2BH+cHasq9kNE4O3omu26ENerB4UwfTAYubhTV5YdUM5Tosk44
         I+AMoABrAg8C0wPPjaRPy7Tqtw7mA6OBewbE7AEYXqzNXCGAKiBcby1XI46dtyWQ1eQ9
         7k6AGOu+X3E1mOcXLPdyuwxZnG+Kk1YhwneMsV5kNqQPv9EhusXK/6tJhdcMXnkHvOjn
         dDiUJICzxLAlqaNUdU8n8LlOcTssNrg4KM5TFqTVaZHr/HlNdg1IX6XUNfAqXQKeagyO
         HgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604439; x=1793209239;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=00X3tkeYEageGUPFxKdI7i9tn0PnsQa8KK7nyWnisf4=;
        b=1JvZW/cOsRmVHP6lufvE6az7SWxvfz4q1A4cAfqyQaHAe72JwkzDaPg9RhDJefbKb/
         IRIuZKz83RI/3VVEL8zN3DF0XcmrM4Fp4kDIRLA6uQ5Z5BHmEp0byqLRgHUWoPIbJe8r
         OCkwl5WvuBPjkZCJEJFFLBbNvqaorCNKvguHIgjuI0qgaESLI4RKe5hYCjzcqCUHt24G
         Hy+y89fJs6tOT4XyCLEKAKJyDK/KTlMay29YC+W0IJTjD9R/FZuXaQZnW3bd3UWw6YUK
         kyM9e2ojKcs4pVPjAOpWG7jIDyZWfAd26C7hOM+AF2ipN5byS1PnGvX2A5sVgdmRN58U
         UbRA==
X-Gm-Message-State: AFq9FYJwCg+kKkfyoiljbYwSLRmSyuFghYZVapMteKts2PDPlByHb2jq
	liqbfeN0tYdqHRhJ0cHsAAuD2YMhm82nPTbCyC8M9pGwwRttoptUvsE2
X-Gm-Gg: AYBFou1s/haat9nbu00Mcl5z9pVqf16Jelko1bQnbX2U971qcQxWHrLKhHuHnfz8eRL
	Dc3hO3qGBgr0A23TqWNhkbOTm8ra+TSG5QhiyNnGSEVfxi9x7uqf8FAssOOA+kSDmrL0w6OIzvU
	KzwBW3P3Xv3gqlRmJPsnX+mKgG8EK3htmAcUzDz4jm0k+YLCm9Mol1113IpvDLsVdPb0m7liZqW
	volZJ3WNRgP6W8tIlBMyTxF4raPCgMr2hHVzjqlIzF7G2rGpDgVza8N3Qb3EdAmf21oMYo/5WyV
	OCLhk7x1zppL6Kzc3m8Y7btGurYwqPTEatZFn+5qqjkFzTb9tcatX/W2jC2h/6AKV/3etnhUsA+
	oqj4hYba/E5l3eJPTeu7JLlnXFPzlPTzzbA0CGvf4fxgzSwXOnnGpRdB9jcnjpd5MOcR8qorRGE
	5NlTWLljdFyjFcCS5W/kIleEk0QOLwraA32om+86wXxUayganDo8pFonQ/LT/Yr7gYXO7jl/8ol
	d1MWteKx7THN+YRDuJasbVR5WKRs4V0z9emRg3OHhPNAAMyDfvVg/ELuXHpgxYbOOsamNXPGgyS
	cM/ii8tJRmE+42PsKC+KW0J8Jmw3NvrnE/3/KoeNglJH4yqSvOmOvdgZn/mt
X-Received: by 2002:a17:903:26c4:b0:2e8:2d05:9780 with SMTP id d9443c01a7336-2ea437a6be4mr22440335ad.8.1792604438573;
        Wed, 21 Oct 2026 10:40:38 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b41096bsm15144615ad.26.2026.10.21.10.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:40:37 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 17:40:36 +0000
Message-Id: <DMAP8LNBJRPN.2THUHLKURP25G@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] net: return page_pool frags to the pool in
 bpf_xdp_shrink_data()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Dudu Lu" <phx0fer@gmail.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <20261021155645.69120-1-phx0fer@gmail.com>
References: <20261021155645.69120-1-phx0fer@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Wed, Oct 21, 2026 at 08:56 AM Dudu Lu <phx0fer@gmail.com> wrote:
> Before falling back to __xdp_return(), try the page_pool path: if the
> frag really is a page_pool page, napi_pp_put_page() recycles it through
> the pool and we are done.

This makes it worse.
netmem_is_pp() says that the page is still in a pool. It doesn't say
what kind of reference the frag holds.

On XDP_TX and XDP_REDIRECT veth_xdp_rcv_skb() does get_page() on every
frag in veth_xdp_get(), consume_skb() drops the page_pool references
and the frame leaves as MEM_TYPE_PAGE_SHARED. A frag of 2k or less
shares its page with other frags, so the page is still in
rq->page_pool when the prog of the peer trims that frag in
veth_xdp_rcv_one(). Today page_frag_free() drops the reference that
get_page() took. With this patch napi_pp_put_page() drops pp_ref_count
for the second time and the page reference is leaked.

Jiayuan's v1 in August had the same check in the same place.
See why looking at the page doesn't work:
https://lore.kernel.org/bpf/01fd251d-1134-4251-9c11-79943e367ffe@linux.dev/

rxq->mem.type has to be right when the prog runs.
v3 of that series adds a flag to xdp_buff for that:
https://lore.kernel.org/bpf/20260911135711.109338-1-jiayuan.chen@linux.dev/
I think rxq on stack, like in cpu_map_bpf_prog_run_xdp(), is enough.
dev->_rx[i].xdp_rxq never has a mem model and in
bpf_prog_run_generic_xdp() the frags of a nonlinear skb always come
from skb_pp_cow_data().
Below leaves out veth. It needs the same for skbs, plus
https://lore.kernel.org/bpf/20260917185814.0f944e78@kernel.org/

Something like this (compile tested only):

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e..ecdac67 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5542,6 +5542,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	void *orig_data, *orig_data_end, *hard_start;
 	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
+	struct xdp_rxq_info rxq;
 	u32 mac_len, frame_sz;
 	__be16 orig_eth_type;
 	struct ethhdr *eth;
@@ -5565,6 +5566,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	if (skb_is_nonlinear(skb)) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
+		/* The frags came from skb_pp_cow_data(). xdp_rxq is shared
+		 * with other CPUs and with BPF_PROG_TEST_RUN, so use a copy.
+		 */
+		rxq = rxqueue->xdp_rxq;
+		rxq.mem.type = MEM_TYPE_PAGE_POOL;
+		xdp->rxq = &rxq;
 	} else {
 		xdp_buff_clear_frags_flag(xdp);
 	}
@@ -5577,6 +5584,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_eth_type = eth->h_proto;

 	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	xdp->rxq = &rxqueue->xdp_rxq;

 	/* check if bpf_xdp_adjust_head was used */
 	off = xdp->data - orig_data;

xdp fixes go via net tree.

pw-bot: cr
