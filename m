Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889846;
	b=2VDV+ZcXrJ7uOvOeQmwvqcyDBp5Butayo2Gxx76wJxHzz1Epe5Pj2IFauQcXhwXv/9qP
	 MHhpTeOZTYKoCbAswdd2AddESupT3eM88l9q+WdtOhh0TAl+ISNgi3EeGOvVBb9nB+dGq
	 Ox9jA7ybYAevTVjVJhH62E9+fJRkqhPOgYYX8lxWqZV00FwVhOX3XdNVNd4SAVojeWVEb
	 xoFizY5FNsXXuPoVCk/IZz9uHzJBIRlleE3SHFIx6Wl77jT3/pv1+/QZzXN+HjDeB8kGF
	 dfo/rWJo4f3UaRDr8/oHUiU94wFRQUpuydyVP9sfZzWWFll1FkMA59jdGIaAtn96TSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=pDZtqYShA9M719qMGZwkbAW0j/mSC/jo/m1vw8SlLFI=;
	b=VFJ8i9USzTYzFLgyTc+/PayqAxziaoATp28y8qA7iovvS5h5tmHjNHy2Tinbwj9/Xyw8
	 UzImSYKN/VElZpmOr+a5ygWHT003mKsCkou+stn+1Ikvva6WcpegHyUKT4C5R5ml4k1pq
	 mqvWVJ8l1ozI75egO6TLHodyUYjI1ru237m9WCwLysTPVyi8NPN91H2n6NBpQM0EbB+bm
	 sw6uosKTnqCk4RbRViFDFf35WDoFVH3Zqv5DN/hX5DLNwffUdvYdLGT67JRH6nse1mZ/l
	 pkl79tQNlg9YGC2lllpbBZ+MRAb+7nq+zcqYNyJPguBAUwtDUSRj19d7qV/q8KHWK1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qKsNu/69";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172CD606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 00:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172CD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qKsNu/69
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1451124a91.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792889844; x=1793494644; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pDZtqYShA9M719qMGZwkbAW0j/mSC/jo/m1vw8SlLFI=;
        b=qKsNu/6948Hunxjb+ZiPcCoy8vD07ngMxyBeqYhcVGd0kSBlIWIr0A+QkJfC/3XKff
         Nim4mZCvYuRrO1ToKilZoYqvzekm0+zxxszmXCjZzJs+AF54HB9pMmXfNL8GnPdCm+d5
         H5WCH7qEkEXTfH7I8wo6m4eDd4DLloyaaZB/QSV7nZuBZHkxhjmxApW+Dg26xP/s+umN
         NxdWtARZ4S7KlqqoPMTrXgxGhNXqPaR+4JQsVdIzZsmLeZEIPFvGPnquJ9W9hfJNH/ue
         TjPS7NFLMMBVkQ0cLgFP+0KfjGyaYdC+JWWvp4Kf6c/uuZUiOB6OogkvX8bwgxlUs2Fl
         WGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792889844; x=1793494644;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDZtqYShA9M719qMGZwkbAW0j/mSC/jo/m1vw8SlLFI=;
        b=O9GCMKsXtd9E5zvvML3WMLjNRQrP3B58vHKs7nsEXF7vxhRQ4kjgvNYlP/2oPPKPAd
         0jh678MtN92Fpc5C7tmvaEDLSxmjO+YoU11NxJURL1pdSzCnhCXl7mSEXUCk9QI1pxak
         UsN/1VSW1L5ST867bRTGc6tJCToz1PXQMufshYASbE6LndkP9roUjb2/O0SjziZoSjF5
         tHejo0etbYLXQa3xsMECaB6ubF1EwxXPcJTHC47+wwQ8kn+N5HvJw0yFz+qkUSyvql0Y
         BrZALbiTHRMTrUAJA9FVx8j5Pgp294MjDV/ubIWstKF2aPQpv2Mt5XeaWQlgVVhGZOb/
         9tZw==
X-Forwarded-Encrypted: i=1; AKwUvBysg91P3+YEFZ3EVahvvt5VmPt+qvU6Jh+t1Q1TZBF6Jduy7Jex3cXDUbGd3zMOctw9zaQEYUU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/RZbLfa52/eZiVcARNrP3bI+9GjpmX1n5F33fhqnMq8H9GsiJ
	OYLWw3ZQXOO9VhRYxshHgZ5kt7XBWEpA8MuUz34xs/bFSkAd40FnHFJx
X-Gm-Gg: AYBFou37p/T68xJkzokqbYcVqC7OMwVp+1e+xmIl0fO/P175TrdYkBkuklAS9Yt8tTP
	bbk7WYl4A7u1S9PsKKVShzwTiFzizPE3pgvKym9kNzAnpACHpLGsohIN7g+7wRxAekJgiPSvdzc
	TVp44nRcHxV6K6/pf6kKPerpduBa/TBCR4NGfl/ducFTyT0cOszdRxtM/njosAj4PkRVPGnXPWv
	tZsePPrSr0HD3PWZIq4eD1L+VCnf0zYkbMsEbx9LlxG4HEvP3MU2sOB219hcNia1mOzkaxzatBZ
	W44DdaxAZQcQfowQzsv2sWtC+ci9nNAxtFb2l8B9VzkbUVoK7yG416kMB3kSPUFyjFHYiBhZ4Os
	PGzIym79iTC8PuCL+rO45dp4USg3WLcsTvxOi+6U6lFS58zQ8KBZc7cmdSI8C7nx23zW9D3468x
	F5XkV2Wm3s8tKt4KLyTMWb0YpE4sJDX6l3WWgDgOmVlV3ZYZGrYmYwgY2Rf64mgeV9H6vDIewnN
	bLB59vaDJDExgQDX8tVKaacntMZM6cfq9N1151C+ssiG6tFq9ADrJ+/+Leiwgl/WXW1HsMZGVLl
	s9LiCdtqPwdJYXmjgnyMMIOl4wCuaCKVjmZH23Ym2UMHJuTOqDbOU/FQVv2Cpw==
X-Received: by 2002:a17:90a:dfcb:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3adeae7763bmr2959846a91.42.1792889844176;
        Sat, 24 Oct 2026 17:57:24 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm3951459a91.17.2026.10.24.17.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 17:57:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 00:57:22 +0000
Message-Id: <DMDIENB8G58I.3IFV81HSBAA8H@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Daniel Rosenberg" <drosen@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/3] bpf: Fix bpf_xdp_copy_buf() when the buffer
 overlaps the packet
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ayushman Rout" <ayushmanrout27@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261024092659.76422-2-ayushmanrout27@gmail.com>
References: <20261024092659.76422-1-ayushmanrout27@gmail.com> <20261024092659.76422-2-ayushmanrout27@gmail.com>
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

On Sat, Oct 24, 2026 at 02:26 AM Ayushman Rout <ayushmanrout27@gmail.com> wrote:
> +	for (pass = 0; pass < 2; pass++) {

[...]

> +				bool self = orig >= ptr_buf && orig < ptr_buf + ptr_len;
> +				bool turn = pass == flush;
> +
> +				if (self == turn) {

This is too clever for what it fixes.
Every load, store and bpf_xdp_output() that crosses into a frag now
walks the frags twice, to look for a buf that is on the stack, in a map
or in the perf buffer.

memmove() in bpf_xdp_load_bytes() and bpf_xdp_store_bytes() was a one
liner. This is not.
bpf_dynptr_copy() is there to move bytes within a packet, and it's the
only realistic way to get here with a slice: when one range fits into
a segment and the other one doesn't, it passes the slice of the first
as a buffer to __bpf_dynptr_read() or __bpf_dynptr_write().
With patch 2 the chunk loop copes with any overlap. Use it for every
copy within one packet and leave bpf_xdp_copy_buf() alone.
bpf_dynptr_read() and bpf_dynptr_write() with a slice as a buffer and
a range that crosses into a frag stay as they are. I don't think anyone
needs that.
The read and write tests of patch 3 become bpf_dynptr_copy() tests
where only one of the ranges crosses into frag0.
Something like this instead of patches 1 and 2 (compile tested only):

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1..b74c036 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3291,8 +3291,10 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 {
 	const struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
 	const struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
+	bool same = src->data == dst->data;
 	void *src_slice, *dst_slice;
 	char buf[256];
+	bool rev;
 	u64 off;

 	src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
@@ -3303,25 +3305,31 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 		return 0;
 	}

-	if (src_slice)
+	/* The other range is copied piece by piece. A slice of the same packet
+	 * may overlap with it, so it cannot be the buffer for that.
+	 */
+	if (src_slice && !same)
 		return __bpf_dynptr_write(dst, dst_off, src_slice, size, 0);

-	if (dst_slice)
+	if (dst_slice && !same)
 		return __bpf_dynptr_read(dst_slice, size, src, src_off, 0);

 	if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
 	    bpf_dynptr_check_off_len(src, src_off, size))
 		return -E2BIG;

+	/* like memmove(): from the end if the destination is above the source */
+	rev = same && dst->offset + dst_off > src->offset + src_off;
 	off = 0;
 	while (off < size) {
 		u64 chunk_sz = min_t(u64, sizeof(buf), size - off);
+		u64 pos = rev ? size - off - chunk_sz : off;
 		int err;

-		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
+		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + pos, 0);
 		if (err)
 			return err;
-		err = __bpf_dynptr_write(dst, dst_off + off, buf, chunk_sz, 0);
+		err = __bpf_dynptr_write(dst, dst_off + pos, buf, chunk_sz, 0);
 		if (err)
 			return err;


pw-bot: cr
