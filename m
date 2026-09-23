Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8E41E6A7
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185593; cv=none; b=QgbQ9kUEGlmMCidwuw+vSVjBoOmjbaCZzZF7NwYPp0Psz8ud7co7ZD6rd2sRy+Cyp0rI0haPdHEnqhSd7Uxlbim4eVFr6lVDOXkNLE+W+Yx2Wf8+7vwsFIoLTqQomoT8S0Ht3uvXQ6GUrEDbv1GBETDzq8nsfO/EEEjq/eeRve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185593; c=relaxed/simple;
	bh=f3YevRKPlnVtTSjlt1kYTG3kL0FTQuzETu7ncmtuDpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RzmgyqdGfJkRAbFqIgOjtJW3D7uMKoRPEw3U+HpPMgjKt5cQ4mKaTxJHQIfZCC76kCGTFB7VG3WRm1PXQbpwN/xHD/jSKU8+i63DIIP9KRipP7pi/a7nt6g6bFDS2j09qbZxttGBRQ/dHpjl+bP/AvzvWQj4Le7JOHZg6GSsLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT/zpSu7; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT/zpSu7"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bef17c191so88728885a.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185590; x=1790790390; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f3YevRKPlnVtTSjlt1kYTG3kL0FTQuzETu7ncmtuDpE=;
        b=QT/zpSu7PHKyQvPMsOlkRTcW3Vav5VLW0SGpwrw+lUwVe5VwPHwqwBeTB6mgJUjR26
         tA5OQfSzn1n9RJXhLhugYU7E3mWwCyagCPm+PsiAAAgYMcEH21HxXqhZeokoMIjQKJEE
         cNuUl2M5RkQe9Bg67nY2KWVxVDiZEO2TQffg6f+ptogKPz3rnN2KJmruEscGgz0zuhgZ
         AvMnoU6kWCJr/XupHeclmn1a41w+9LWUbCUPCEyWmaiT9EomZYb+sobagFbUG63MbiZE
         gMqKzHz0Xn2mrD+KNWV/2UcJywClWJjw4PfNyWrmHE9Pn3srOWXIveTNDLI+6kZc6VrK
         JIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185590; x=1790790390;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f3YevRKPlnVtTSjlt1kYTG3kL0FTQuzETu7ncmtuDpE=;
        b=mDkWrcIUIBwfW4yaZGqy1kHJmLVD1m+nnTHBFUaV7PCWcNvyT61mXzpTJ+F4bRDKZn
         YVPwPARKrLsgVMWQAcKXCGgZF2hYrFpKjDknClPDFGjtTpE1Z6gl9taYMi5iwGazUe0A
         SorZwe5i4X8rzGXXHu7sM/Hdm4QW+/RqiWPFh7hexAlRIUk8Eg7SLNoLDmkPMh3RxXLb
         JxmDfe3KdEJZqvcPwBTOBx2loMAeAoDVJKCB3oe7Vn57EjiqQyYrLvxhp3Gdn6m1+Ql5
         Cw09Z+dBQUqzao0UbszOgq7MSvERqb5yJrVGsUsUYWZL/tFEz8m7/cKyvdI30yrO5xpi
         Nbmg==
X-Forwarded-Encrypted: i=1; AKwUvBzc15FfEtgTCpBacGOysIqox6nc2A/I6wVmh+iEBIemmhUTpvOeBFbFVgWLefP4JhsS3sEMN84=@vger.kernel.org
X-Gm-Message-State: AFuF++mWRZauRdFJB239Rnp5foJwa/QNmGQnL81SkFjkUnVRk/DgxPs4
	S5jLH4Kz8tD85rxxeAHqVeRVZnkl4U3Bfx5okqglTeM3COksHPiX0ejA
X-Gm-Gg: AYBFou35QwnOSy5BSQBb23x9NzV5FkbZ1pyq3EernN/0KK6R01mN5qq5iJMv1GbMOl/
	6p+ckV/Gt5cto1vvAHavJQxrqwNCZcJKC5oI6D6M7JpeDJ1wNI9dNcH1aBzAGGUd8qmM8jXSHaJ
	qxWaDeDa5hKniq52ncElSK19G7thrpmiSqcLi/tUVFWP6qutsl63qpvliZtMf79kGth1d/snaCL
	8SmUPB5mPlO3zAD0ml4h+5WiCTdqxYNkf4koTQ0vkAnJNTd2DIPiv40/SUZM1n5Gb0cfW2EvZVF
	4B38lTCUXtxCw36Fv0FMcUBKJ3LRtbmEZtWGuCYWkv90tt2jllDmxmuK++kOs/I/fQz48Niez5d
	Ke9ZZs7GlJq6kmB62pOlzbLW5kqVhe87rwOREct16nC4xpPf4i7MwP3ccPlMh1/iLC1GjNAr1Bu
	/kBg3LUfvq5MasUuUWc7Pms37auDOwox+j4/UGnA3tQidvPeX/FD28RC0IrVcvuOF+zEGp5xy+Z
	iw=
X-Received: by 2002:a05:620a:4054:b0:939:ff11:5328 with SMTP id af79cd13be357-93c250cc995mr521143685a.24.1790185590396;
        Wed, 23 Sep 2026 10:46:30 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485883asm278842585a.20.2026.09.23.10.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 13:46:28 -0400
Message-Id: <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com>
Cc: <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, <netdev@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>

On Thu Sep 10, 2026 at 10:02 AM EDT, Jakub Sitnicki wrote:
> skb_scrub_packet() drops all skb extensions unconditionally via
> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
> etc.) and cross-netns forwarding (dev_forward_skb).
>
> This makes it impossible for a BPF program to pass metadata via bpf_skb_e=
xt
> through a tunnel or across a netns boundary. The extension is always lost
> at the scrub point.
>
> Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
> deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
> extension slab is shared with clones: deleting an extension only clears t=
he
> per-skb active_extensions bit, and the shared slab payload is released
> lazily by __skb_ext_put() once the last reference goes away.
>
> Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_scrub=
()
> and also switch udp_try_make_stateless() to skb_ext_scrub() as well, so t=
he
> BPF metadata survives queueing onto a UDP socket receive queue and stays
> readable there (e.g. for a sockmap verdict program). Only mark the skb
> stateless when no extension survives the scrub. Otherwise skb_consume_udp=
()
> would take the __consume_stateless_skb() fast path, which skips
> skb_release_head_state(), and leak the extension slab.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Hello Jakub,
What are your current plans for this series? This commit solves the same
problem I have with wanting to preserve the PSP skb extension across
netns forwarding.

Daniel
