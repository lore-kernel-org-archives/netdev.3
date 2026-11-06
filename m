Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793981020;
	b=IrKy1aLCzSKUdOYgLrMdKz7WKtciW4L52qSvJPTAPXhz4P3oVM69v7D86NHSGeNjoYTQ
	 tHHR3D5aLbHGPcArDirdk/UiNnz28YZh/wwwEm4tbhbfgefajbOHT64pkgIYeVJfC+cgl
	 Ay0u2yw61W5aFG2Nv7xWjDejgm8An5ASaPlf4UMot0Jm5MfmyYaz0FMmFig8xbDffiofc
	 /N8td5IJX6ZGv3LswBRzPeLAXpUckol07/7tIbU8odBXcxhXsWHxoVAVGFUHNdztxAgyd
	 fPGCi5pA3ux4j8Hg/R6NdRaffbeJwdpn47e/ZB9nhW5u5eOwXiC7Gx/jepyScpeNFmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DGR5YjEm685OZ/rx88bvzwn+cjlOF1BBljJDBEoYuYc=;
	b=xoF84NCdhQW1zCeYuJqJaxDge5uOyQxeXp2FtxKV0dI8enH1HreodaXhOzJ7oVgJzOx4
	 9G2AgC+satjpuJstUo00w689cYlYraULET0nUCXoaajs6y0Z9Kpu/VpFYHul7zUd3gC9r
	 actoeDKxHgALYNgj84a60Z/3B2+yObZmlZ/iDjJjAeiOgHAC5pnjirldw8GyNIAL3xlH7
	 Zga4OgUhsCG9bzxmnvk2ARbT1jYidti+L5w5MOHvj5mMzahZEdq7zbHQdaGR7t8e6bPOZ
	 t+WqsQ5esFwNwTNhhR4BTF9SGYN6YTKUeLvptU2/yfO3Ccb/cfsC1wkIW2X3WbL/z7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLjPWfoH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73916606D801
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73916606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLjPWfoH
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bff8fc7cf2so870526e87.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 08:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793981019; cv=none;
        d=google.com; s=arc-20260327;
        b=rEIMVun6EWRNJEJNiUwrUGr52412kOusLEjAJQVESUQrlraUHF7RbqKDOZbZAvW9YP
         ZzZydBkqV7HKfZuGyVEeidQYd3SukKSw0qG3LJpjEfiuUpqNMOKgHwKBk4fSvuRdFEov
         YF6348Z2KIfNTBIdmIr0deA9Sigm+y93kQBElyyCy+wiBqf3pZx/Lvz4iApph6eYkt//
         dcTwdM9waaY0v4uTSShgApg/sBYKZVOVm8nSvl8kQGWdsbKBx3Vd7QWowQN97jeTwaiY
         SsbR0JaiJhdIZDMzh2cLdzeGL4T3013HrUQd6zjIyNJ9L6drIwaBwbQ61ncr4LvT7/+9
         IPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DGR5YjEm685OZ/rx88bvzwn+cjlOF1BBljJDBEoYuYc=;
        fh=ktyEDT0lj+Y1fW7a6Akoae1W1GxFrljAJagOdo/n9eE=;
        b=j1iAuFM0X+oNIhs6txKLkNnK7W9JS+OS3tA9dLBusyxWB4YNBlLdXX0ZEJu22l4k2n
         otKOd0RikDptM42HaXV7YHRGPKG0qf9xi2GC7VZJlYztK0CJBUgShK3QNyKZuWWN8kzb
         qoENCoZPsoADfq5gvG0WI7lI0Pr3yQC/6mJMebM689ih5za5YsS3htEDXX8P2KVsu5YJ
         EF/QDXgY7Q/fsrz61X05XDy4TwwyizK9eKdsX2mx2QGG0FKeEiKnUpBqWU5hOb6SIpHG
         JJpwiCw7JmSAo5XZiVJcDm8DEepksWKFOVe5G+oEW9L8nl/Q7jlsjyPAnTBb5g5cv1J6
         IwwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793981019; x=1794585819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DGR5YjEm685OZ/rx88bvzwn+cjlOF1BBljJDBEoYuYc=;
        b=KLjPWfoHPR8YuR6I81A+kxVo1jfpM6dV+oelSWVT8OloAyzX5GoJLDNkIhwvBSJh37
         tZwvJZwZkX4peEenNCipsHAs7ISHxSIA2o+4YTqybeIzo7Kcksal2X00E54sS+dkOajK
         T0PNemq25JOBFTyhPJvbgPx3QJBMCLii1hhBXctBV1ngpHwGfD8lV3zaEZAOz+prJSdZ
         vAz2HTASWcZZm8BVrjZwYeEB8FP6YjMoGQAaxWBVb9zD3/VE3UQBBlhZHH/OzWdToYve
         iNin+4UdnqJIXuPW2pH53hD1gQr0grprOm6u1AmzXIwoHXF/jeE36AiaCMWQPxaISGWK
         3lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981019; x=1794585819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGR5YjEm685OZ/rx88bvzwn+cjlOF1BBljJDBEoYuYc=;
        b=Stjft3uc5TyrlWxJ8ryWMnbB7jI7Mij11o+rABCAMrIINZx3Tt135vfiPcbepz+RJA
         jm3nt6HRKkU+7uD5LwpmWhhvVbHO85bVTEfuhpJocqjoaqP3DSujK8Tvj/zIQ1xFAy9p
         cxRKF42RSx2W8JqwCUVnYcR6c7sYNv+0j6Edqb+7XUlJxNyv/np9D5ptubMv7FqeFy3J
         gCyxIlGuJhEZpmwvrD5jpmo1ttheqYlw0SBVTjroG+VTXHtmPj4tL4yI7GlHGBDh7Qgt
         cKN7hMX/8ir8VqRWlkKr2P0bpGwD3XFZc5NtunRuz35Bp3T9LW2ws9h7vVLcmXhiZ0Gr
         snTQ==
X-Forwarded-Encrypted: i=1; AL+hErFDOK+FhtUkmW1fXgosJlj4JoJqX/e4avabzl+d1j2FCgnUlowf2Ehx5zUS26Y31B1ofXEXSl8=@vger.kernel.org
X-Gm-Message-State: APuU4Z87JAw/kSGjTGlj+UDV465Fy8EU0bc+x3vGAHI8Dh0a3vYCJkmX
	V+GQgoQ6Egfm0LI7pdbjkMxkiVDPuHDN2+di2KKX2FlrSAGYrmX55WjLqWzy8W3+cyjFt5gBYG7
	l8s0x6eZaQCO3nZT8t1eGHv2npS9C3eiKBPfKNzGS
X-Gm-Gg: AYBFou0n1+44Dn9eU2691MoDZDcmHo/Iie3kIbxq+HuBmLYW/NY/ifDXQCRTvIMfAdy
	jIym6zJ/YmlNG0b3nCJ6OasIJ1ZouO8axRculJB20YHDvLrahg5Ce4mK1EAUhn7p3aLs2mn63+Y
	6uqGzrD4IrCy5eqQrssbEYALkQvPOzE1X4+M5TSS2r+SeN7Loqy8tsAkfPA0OyV+YuTE6537zBy
	q7WCpzlzhBcP7uYPr381KBzMis1+6hp6xQekofHFBZXiNBeW8RfhKP1D4Jh9dxFX9T0Ug9sn4fj
	vC7J4609e5qNLzNKSzUzYHv+qPG2nrIYCR38QgpCgwLQLLo0sCkGjmopnsU7oG1H4ZFc0ahVva5
	FDyPmWFbF4/FaZgLCHcRtjRYfN4BzkU9tPAaxlT3TeOje2csdgHWRLgQL8afqmsqX16eaXYiH6K
	SZnD7DbqZOVKND2abc4OltiZPWVV0X+g9Il1bHaGZ69Ky7Xo4ObqW+wjBgpz/QmV7BrzsjwogD4
	G6mJ48QP6oOeY9r
X-Received: by 2002:a05:6512:318b:b0:5bc:c325:1260 with SMTP id
 2adb3069b0e04-5c003af2fe5mr885526e87.55.1793981018177; Fri, 06 Nov 2026
 08:03:38 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101094847.664612-1-ahmadag1001@gmail.com>
In-Reply-To: <20261101094847.664612-1-ahmadag1001@gmail.com>
From: Willem de Bruijn <willemb@google.com>
Date: Fri, 6 Nov 2026 11:02:57 -0500
X-Gm-Features: AclHuK_Ym5wgDgAVOxJuUoiUSTWdscx9Oqcd2h1sVKKBXEnrl9lAZPSG4NlRiU0
Message-ID: <CA+FuTSeFzFC7PODaQMAXHCg4ZKzvjhHXHbLD6MnNB8BxO5Sq4g@mail.gmail.com>
Subject: Re: [PATCH net v4] net/packet: account user-triggered allocations to memcg
To: Ahmad AG <ahmadag1001@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, kuba@kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 4:50=E2=80=AFAM Ahmad AG <ahmadag1001@gmail.com> wro=
te:
>
> A packet socket makes allocations whose size or count its user chooses
> without charging them to the user's memory cgroup: the blocks and block
> array of a PACKET_RX_RING or PACKET_TX_RING ring and the rx_owner_map
> of a TPACKET_V1/V2 RX ring, the PACKET_FANOUT group (about 1 MB with
> max_num_members =3D 65536), and one packet_mclist per
> PACKET_ADD_MEMBERSHIP entry. CAP_NET_RAW in a user namespace is enough
> to pin memory far beyond memory.max this way.
>
> Allocate them with GFP_KERNEL_ACCOUNT, as the AF_XDP rings do since
> commit b0057c68df71 ("xsk: account ring allocations to memcg"), and with
> __GFP_NOWARN where the size comes from user space, so that a ring or
> group that does not fit prints no allocation warning. Fixed-size
> per-socket state is left unaccounted.

That commit was sent without a fixes tag, probably to next.
As this change can cause regressions, it seems correct to send it to net-ne=
xt,
or to net, but without stable. As the patch already suggests with noautosel=
.

> Reproducer, as uid 1000 in a memory cgroup with memory.max 16M, after
> unshare(CLONE_NEWUSER | CLONE_NEWNET): open 64 AF_PACKET sockets, give
> each a TPACKET_V2 RX ring of 8 blocks of 1 MB, mmap the rings and touch
> every block. MemFree drops by 526052 KB while memory.current grows by
> 1280 KB. 256 fanout groups with max_num_members =3D 65536 (265144 KB used=
,
> 512 KB charged) and 100 sockets with 2000 PACKET_MR_PROMISC entries each
> on lo (45220 KB used, 124 KB charged) behave the same. With this change
> all three are stopped by the cgroup's OOM killer. psock_fanout,
> psock_tpacket and psock_snd.sh pass before and after. Found by code
> inspection with the help of an LLM and reproduced on an unmodified
> kernel without error injection; tested in a QEMU guest with KASAN on
> net.

Can drop this iff respinning, or move below three-dash line.

> The ring pages and rx_owner_map were never charged, the rest not since
> commit a9bb7e620efd ("memcg: only account kmem allocations marked as
> __GFP_ACCOUNT"). The Fixes commit let the user size the fanout array.
>
> Fixes: 9c661b0b8544 ("net/packet: make packet_fanout.arr size configurabl=
e up to 64K")
> Cc: <stable+noautosel@kernel.org> # changes memcg charging of existing pa=
cket rings; not stable material
> Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
> Tool use: an LLM coding assistant (Claude Code) found the missing
> charges by code inspection, drafted the patch, the test program and this
> message, and ran the tests in the QEMU guest; I reviewed every hunk, the
> results and this message before sending.
>
> v4:
>   - trim the commit message
>   - add __GFP_NOWARN to the fanout group allocation
>   - use __vcalloc() for the vmalloc fallback and bitmap_zalloc() for
>     rx_owner_map

Agreed on the response to the bot: some allocations are purposely skipped.

If a respin is needed, worthwhile to capture that choice explicitly in
the commit
message.
