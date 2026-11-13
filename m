Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794537713;
	b=1U+uR6Fd+5f/1qk3tkWoHtpixC5CTlhk+Ph4MAvgodNTifAIlhvEAvgP29rq4KanuUKf
	 YsX6MS/NEYFm5xuCT78q6GibjIwf7R+G+dxpC3+xkyibUhlTix+EyoFFBYy+VkpS6Anju
	 fU7PXRqce6eOLdaxJJUxE/0uRK5QZHlE1Itzg6Dh+aik5EB6HhqIZgZnj5XkXW6UssDdr
	 qmFItNKEsOIxjBsbiLiggCL4qGSOnux+Wcs5U6GtRH8R4RO0IjLouuHZYtMVQjFxmlHkA
	 tz9Zmvd7uiz0NbdU9Ws+lel4ZBTWogtdYzQztajq71AeSZB+y9uc8xgvi1n87p4z2zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pdpzle6Pnt8E8dwB1kIvSCTQN8Cx81DzaLJMeHbIudE=;
	b=zrBMG0LxANcH6bJpduYXRX4E/5TKtytc5RoffS4fKqje1IgDHLORDPefVn2LUYyt1MWr
	 egEhMtXK9MKTEJGuujK9k/khJ9p6o25BDqKVgPOB6r5teVdS9Id66xxog+s/UYoVOxjEG
	 AUAbja8aO8pIPyTb+eMhaSr+Y82YHOsTRpDoOKVG1aMhL1S6Rjg0g0+Zsobb5o5dBDSwV
	 ANKcO5cGCOmReCKmerDWX2n6sZbu3h1wXbUySjNGk8y8smNGhkNIRVeaZWehZxpYPw66H
	 9NXstYKJoYSHP9QngolXj8xhHE3lrd9WsdusS+imZ09wu/fYpxW6j3eAasV6ugE4rEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NnrIOimF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3A606A8B1
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B3A606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NnrIOimF
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b791a4b732so3024a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:41:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794537712; cv=none;
        d=google.com; s=arc-20260327;
        b=Xz5r6Hf/JtLVRnxDHaWP+pD4gTsYpPohI7kc7HXEsRYOwNxf2HAoHWl+Wng2UlM0cg
         1ybcuL+8DOUwh9qsZcZke81znw4TSN7fkmclgq8LZyXkm7EI/o0q8ECDICwTBckAqPbF
         QjhPXTv/h4/RWxPHsaGJAAMqc7ybMpkDorIeyfTbHbvbWO3IAxZ4iEUo/hmJEYWMwl7q
         aLyWB4v5Q9RWYE9beiQXDjSmp7X/mMkZ78BWqkxTmUGG+vJ1PpfOt8m3QK5rfSnGQTy8
         rykTccMOWkI3IrwQ3s0DCaZw7uZzVbB8GcaDdwAAXU/e2OZMyDhpZI/s3wi9Z+QW3pCk
         eygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pdpzle6Pnt8E8dwB1kIvSCTQN8Cx81DzaLJMeHbIudE=;
        fh=e2Iw+gSoIDwqVtW8xcxhI0/oLlgq33q79tAmEdm2/pU=;
        b=jEp++q7Mm9+dlcCzAsdKBwY5pkryR3QThmeviCzjD/X0OufTvIMvvikzALqpfBm13U
         S2gIAUmQy4g4mW/V9xD88O5wVq/tmE+zi89rrXRFYj2kGfbnrVFRiq9C8KhM/qLUddXt
         3X1bwYCmEl7FiTp2mg8sf2iYdGQF8YhmLM/ebuAK4rVBKa8ObH35l2C6SpAMBUp0O2MG
         7oVz8GQXZqlU7y6QF7FdhuHnXFR6/IMRjDBurRZCvHlE7uBhWc7DOaoyk26TUhnEytz7
         0aY/NI1nE8NZ9jsihN3VFEa+XlIkGmCIY519ERuZFZ2uWOyQfkrWAhlZk+zExhGuBl59
         YHEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794537712; x=1795142512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pdpzle6Pnt8E8dwB1kIvSCTQN8Cx81DzaLJMeHbIudE=;
        b=NnrIOimF3BI6vGC40SM09d5EV9oJFLM/21Pyes2NMjsOCDgrJIGlA3VWzfqmofzG+h
         cNelntrcx7+Tcc8TfhGlDqMrfc5CZCjuGIV7Cn7xiWVs4SK/V7lHWOzXaH0zHsqaGk/a
         QXQZrYGyMYw2pfI6B/xMhdYGacPetltGjTrzGB8bWLA3vylY8oHnk3rHVTtNBn/kCaSg
         Tgqfi8UnW1bOaplq002o6euKMEKO0m1OTVvOSE+njk8/HU/Pn5C/xROr9iEEMwb0u+xL
         n6FWevJeZbm49XDifK+VQAwfcNv9eEEXHld1FByXSuUDMBc6QXYUvkq4GhYfdMJJcq0n
         5lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537712; x=1795142512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pdpzle6Pnt8E8dwB1kIvSCTQN8Cx81DzaLJMeHbIudE=;
        b=1lXFfzz6+cLWzRNEToNijULz6cfjhJ3e+rzS2hbglEvIrfMRMM9+kmxaqNhTNAe5Ei
         q2buiIC2QIlFeXFS80gB9EqmgwB1VzLe6itVBMJTpSS3y2X6VJTzAlSzYxTEgGZoq//p
         hd3iIGdxH0vY37i9Wvnv5MFafk9FFpblDzHr9cfd5Qp0JdWkrertfj1Y+D2HjHEw0Ips
         HZw2JMfnTXNlZQsv2e8/vUXTP/h3X1TXFt9qzyi+FL1yC61dfSWRMe9ewYFuLdDVRsFN
         2Lr4CCRfUdYkcUZGD+a8jznujMBg+2k6kB3+7+z/hhisMaH8zquJMX8r66w18O+Pb+Ra
         D0Nw==
X-Forwarded-Encrypted: i=1; AL+hErHYwT1zR96h+p3PGAmPVWa08w08gWMAihUubIcAXSR6TOguQWIvlNGWsyamPKMlLgrTgINJ320=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DEL7MODqPdBiv4tXh7HlNhCg3Uuoq5yvc8ge38TU2qhYeuwsi
	zH5Gsds4QOv9X3nW3GaFRYHcLnE4XoK0LSi8D65zvCTEluD1z0JOcpnvHVPNtaS80j/UZam9RZA
	4hTUFsnqCprlMuyPM6jA/tuY548jzoTwt6GIouRv9
X-Gm-Gg: AYBFou318W4+5oI1e1BM9CCagLcJHpqGd0JV16POiz4V3WOquEBmJsV/3NEQnj/v55o
	o9382fiVTtPVLAgTSrxy1c8+0+xDnFYR/femtB5eBnLhSBoech0kE3tMoOuUb8J8cNThLgxfbBp
	qWdznuJrUbnwO8uElWTizAJa+1+1f20XqPMK/zsQjE/BlE/S/Nis6hnthAXJqgMqU9TFKwxnvYK
	2xOSTrb7w0YXv2uvtqDjUqwnU32FJeDsfKXNVnVqh7RgLmyNkTonDehZOd6tKzDtTYPf/C4uv8c
	qGIMvli/keG+ORCmKGOnn82+vX1CJCBZ3yb/2w9yYmV9tw+e4rjMHxeEtDpDJMvFq2EacB3Lh/m
	0zlo7gxXMNZUxGtmhWeFPZqnjXJXOjSFp1p0=
X-Received: by 2002:a05:6402:a552:20b0:6b6:ee14:5096 with SMTP id
 4fb4d7f45d1cf-6b7c82e0da5mr36007a12.10.1794537711496; Thu, 12 Nov 2026
 18:41:51 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111224740.2744522-1-sdf@fomichev.me> <1b764043-2efd-4e65-adb9-a47c0136446b@redhat.com>
 <avZC2hp_0ODMQ4SG@devvm16445.scu0.facebook.com> <avZZ-6GGciPC0Lti@devvm16445.scu0.facebook.com>
In-Reply-To: <avZZ-6GGciPC0Lti@devvm16445.scu0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Nov 2026 18:41:40 -0800
X-Gm-Features: AclHuK-OyJCj_r8mEljFvPh0-So51lXB-i51m2hOI2a_HBIhEdaQi3z8QXgIG40
Message-ID: <CAHS8izOp2BpO7WnrNZRUryGQg=L3xreF8nSFp5S2_sO8HGhqpg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/5] net: devmem: size TX net_iovs from the
 dmabuf layout
To: Stanislav Fomichev <sdf.kernel@gmail.com>, Octavian Purdila <tavip@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@kernel.org, 
	horms@kernel.org, shuah@kernel.org, sdf@fomichev.me, leitao@debian.org, 
	dtatulea@nvidia.com, asml.silence@gmail.com, bobbyeshleman@meta.com, 
	daniel@iogearbox.net, razor@blackwall.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 4:42=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 11/12, Stanislav Fomichev wrote:
> > On 11/12, Paolo Abeni wrote:
> > > Hi,
> > >
> > > A few (late) questions/comments to check I'm not missing relevant
> > > points,
> > >
> > > On 11/11/26 23:47, Stanislav Fomichev wrote:
> > > > TX bindings use PAGE_SIZE net_iovs, so a frag covers at most a page=
.
> > > > A 64KB skb needs 16 frags, and MAX_SKB_FRAGS caps devmem skbs at ab=
out
> > > > 68KB, which makes BIG TCP ineffective for devmem TX.
> > >
> > > ... with default .config. You could set MAX_SKB_FRAGS to 45 and reach
> > > ~180K...
> > > > This series picks the TX net_iov size from the dmabuf sg table inst=
ead:
> > > > the largest power of 2, up to 2MB, which aligns every DMA segment. =
With
> > > > a 2MB hugepage-backed udmabuf a BIG TCP skb takes a few frags. Ther=
e's
> > > > no UAPI change since TX addresses are dmabuf offsets.
> > >
> > > ... still this option should be more effective because the limit woul=
d be
> > > higher and the skb would use less cachelines for the shared_info,
> > >
> > > I'm wondering if making a comparison vs MAX_SKB_FRAGS=3D=3D45 would b=
e
> > > complex and if you could do that, too.
> >
> > Originally I did not want to include bigtcp to keep it apples to apples=
:
> > same tso size, just 16 frags in skb vs 1 (in ideal case).
> >
> > I just tried running mlx5 with 45 frags configured and it fails to star=
t with
> > the following error:
> > mlx5e_attach_netdev() warns "MLX5E: Max SQ WQEBBs firmware capability: =
16, needed 23" and returns -EIO.
> >
> > (fwiw quick review with llm claims that mlx5 only supports up to 20 skb=
 frags)
> >
> > What I also tried just now is `gso_max_size 524280` (on top of this ser=
ies)
> > and it ups single flow throughput from 200Gbps to 240Gbps (presumably
> > by making the receiver go faster with 512K TSOs vs 64K TSOs) and halves
> > the sender softirq..
> >
> > I hope this gives you more data, not sure running with 20 frags is wort=
h
> > it (vs 16)? LMK if you disagree or want me to run something else.
>
> Fun fact, also setting gro_max_size on the receiver gets line rate over
> single flow:
>
> I   client.c: Connected 1:cpu 39 | 1:cpu 118
> client: =3D=3D Source 2401:db00:255a:4a:bace::b
> client:   Tx389.448 Gbps (2921248849920 bytes in 60008026 usec)
> client:   Rx  0.000 Gbps (0 bytes in 60008026 usec)
> client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
> client:             2   125  86      2    0 15300608 10142
> client:   net CPU 39: usr: 0.03% sys: 0.06% idle:67.39% iow: 0.00% irq: 5=
.69% sirq:26.81%
> client:   app CPU 40: usr: 0.05% sys: 2.91% idle:95.67% iow: 0.00% irq: 0=
.21% sirq: 1.14%
> client: =3D=3D Target 2401:db00:255a:44:bace::b
> client:   Tx  0.000 Gbps (0 bytes in 60009306 usec)
> client:   Rx389.438 Gbps (2921238435008 bytes in 60009306 usec)
> client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
> client:             0     0 210    122    0  999424   10
> client:   net CPU118: usr: 0.00% sys: 0.00% idle: 1.60% iow: 0.00% irq: 0=
.33% sirq:98.05%
> client:   app CPU119: usr: 2.75% sys:77.46% idle:18.95% iow: 0.00% irq: 0=
.47% sirq: 0.34%
>
> 4200MTU, 32K rx-buf-len, this patch series, gso/gro_mas_size of 524280,
> still the default number of frags (enough on rx to fill 512K GRO with 32K
> chunks).

With 'devmem' over udmabuf? Is this possible without devmem on your
setup? How much is devmem helping I wonder.


--=20
Thanks,
Mina
