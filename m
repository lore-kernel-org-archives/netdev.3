Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937018;
	b=JPyBmg1vBw9xBVVt6iKJ33QoCRa/VsM0NTR43pDJNNPYhFN1wfiri2AbpXAfdfyxn2Pw
	 F5Q2wrY3m9f19x8gjvx0z+y9OoUekJ+c4dSOkUQfJlp5rJ0jZverYOiAmI26L5E3w5NxH
	 IiDo0x45oBnrZDzz68rSk3MojN+8g5ntxZgXQIWsmMhkjwgPf/f8gSaTE3alCuu/Hblo+
	 T8rqPqgIdPQ3qIW8bKNi/iuaPs8RPH9yC1XqWwwx/pjQIShFsriPXOeK0ZleWmAGcNPJN
	 aLQx2TEXE08z/eGgH30hqsS2g+pMWXUGRZj15W8FbSM/AlOMdn2MAqkfXB8pi4HBh0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=mzWNIgox/w4qNjiRIlcPQMIvLrmBH31myx/g/3s6wQA=;
	b=lRDgY34cesdMBuDcZAMjondvpkXbmFoUQzyQfBKWuBfet+trIyHUAOHThJX0OfA4y29L
	 ZXdJCTsFL0gZgaCnqVHRCa1exHKiYayLJGxmQyFyPiF763mczIh3FIgWvO83M/y4fVs+3
	 t51mtycwDdOFQDj+2u/yyeO8ESsUKxqrrNVLIW9tOEJ3ZqOvYugxneSFbWfoRfNRIAk7l
	 AwyQ7eKivh1LonnsIFafTy2tgdUBv6ju7SQC0Vt0+XNRr5vJTInBHJiaV60b56tkzrgnh
	 cFi0QMx3Z5yxKvTcdWkbZoAtCRbtsduxOp9TbTxCliJjXKEJlxyLTCj1e1Em7JpZQYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvSH5nMQ;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E7606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 03:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 295E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvSH5nMQ
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so141512a91.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 19:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937016; x=1794541816; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mzWNIgox/w4qNjiRIlcPQMIvLrmBH31myx/g/3s6wQA=;
        b=qvSH5nMQv96uu/Fnl0su+/LAaZ43VJiHaYCmYpPGAOk/Ju+NE8lTdad4+eQf5vvj4u
         26iatJElu7RIlaEovBJHVBFuGUSan5FxnyPCy7cs7x+oKwV039X0z6pBuFmCHc1LNWh9
         +lkXwrg9feV46Ai91AmE4xkEupWH5sZb71NKbVklp/uvJ0JUqGxhMjBw116wEmK3piLq
         3OFeNqq01y8QJkWdh0XtlUBNNa6gpWXsTdjLrLYG/c4deRHZM1cnsWlX9ETk2E4knqe5
         gb2wENguyDUMV3nrvMw/JP/BWdpSS9P++c7ti9U6ruN2jdp2ksw/dW70uHw8Rkmm8C9F
         Ivow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937016; x=1794541816;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzWNIgox/w4qNjiRIlcPQMIvLrmBH31myx/g/3s6wQA=;
        b=z3Nnj6G5nv8KnyK10knjEVLuOSlDVlPgcTwHTJFmg4Ke1TRyqX+M1WCo8PA+xDtdS3
         uI4kt5+6cmWYAP8RClCr2jtK2sEBPPO8VIs4p3af/OxkSJtI4r0pJ6spu7uvWV71I9rw
         vyM0ELv0kd0e8J4mFlV7scSiBD2/qnIKchQOHyvTiigYnGgpSAOo/ddWT0pkeSMeVSdB
         O9IAm4jxNAQ/6mNHq2dECTC9TeThfZN5wpOq7ay0pobqWNLPc7T8/FeDMIY/BpTmyfC5
         dOGDid1IQTzVTQg1ISznk3R6qHK0FdWQY2mEPGXxyr2lfXPv2nzg2G9PhgVjiVPCPXLu
         bTrA==
X-Forwarded-Encrypted: i=1; AL+hErE1fBvc+caoIpyqdUp2da0gVVCsrQ0sy1hVHaC4MRZYJyLHVhhAgw8hEbiXJTYku4QY2guQOog=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yZo2BRY058/sdZL+Cs4QjPKTkZzH8LUKqvZHtqLcrW1LuSaxC
	GYS8Bt9p/0p7C4fSmTUt58qVQ7DxVE/ArCwTtwJDUhDjCp8NJCeOVoH8
X-Gm-Gg: AYBFou2ieS6/wNcKqYl6Xn6EI2Ka00KPA+NzLXLR6TW3/FxS/I5tm0wZGiK85K09VZa
	icynYYl9C5H73NbeDFSUyuIdg4oTuvIETf3e9igN8APe2Y7NYJ6aRuawXxCjJRzhtQOJ/81gs/t
	NiDi+b9JlmUE4iwY85iZme94oQqNeKtFctfC85DTraBUAFEhXGMXSXjvkM+N3MrQlSTQujpkOiC
	EBz6CmuLEMDaC8H5bSx+rtVKhqC7KbIz6ZH0zrji9UBG7diUUI/M0/0UhEWXW0Ky1YKIBraofNj
	rPgyjHQGRCI1oQ9jWU70k0kFCtZtRSfkT2M0Fxln+dxDvZ9TvS9UdSUXZG36YrRK8uj9l9NcRU1
	Z+SihLrQ/FSOmiK177MI/KDjOsGs5+IrH6/d+uwhCOBXNrKu7vLUza4BF4REj3iBTwu0PmtKi8M
	18A1Y93X6XqplPTfQOy0ATXSYllAueBqQSXx/pKe4SMvprGvU/xR9+MDo6EvLUxwLmc2GhwFUls
	dbxB7/Q2v3+h6lBWaU6fXFOjAeShfNN8tk3VxxW//RdWt9cgyPzWSVQ6N8xh1fNzsWjwZpeRXBm
	UJimYXc1HXjWyHO7qGvpMft/bgqvd2/geaLKsd8+156KcvMCgWSnqei3a/iCDCvN4RYdW2pkvGW
	QuHm8y1s5dVvfE6nLC1wewvb0t8wH0+P9rQ==
X-Received: by 2002:a17:90b:4ece:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3b0db705fd7mr1132135a91.33.1793937016161;
        Thu, 05 Nov 2026 19:50:16 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e57a8031sm5076a91.4.2026.11.05.19.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 19:50:15 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 03:50:15 +0000
Message-Id: <DMNTLJOZ13N4.2LG5MIRML7XOZ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sariorkunemin@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Josef Bacik"
 <josef@toxicpanda.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: lwt: Don't let bpf_lwt_push_encap() wrap
 gso_size
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261105-bpf-lwt-gso-v1-1-cda5e19d321a@gmail.com>
In-Reply-To: <20261105-bpf-lwt-gso-v1-1-cda5e19d321a@gmail.com>

On Thu Nov 5, 2026 at 1:23 PM UTC, Orkun Emin Sar=C4=B1 via B4 Relay wrote:
> From: Orkun Emin Sar=C4=B1 <sariorkunemin@gmail.com>
>
> When bpf_lwt_push_encap() adds an IP header to a TCP GSO skb in
> BPF_LWT_ENCAP_IP mode, handle_gso_type() lowers gso_size by the length
> of the header. Nothing checks the result. gso_size has 16 bits, so a
> gso_size smaller than the header wraps, and one less than the header
> length gives GSO_BY_FRAGS. skb_segment() then takes the segment lengths
> from a frag_list that the skb does not have.
>
> This is the problem that commit 12d07c38e1b0 ("bpf: Don't let
> bpf_skb_adjust_room() use up the MSS") fixed for bpf_skb_adjust_room().
> As there, gso_size comes from the peer if GRO built the skb, or from the
> virtio header if it came from a tun device or a packet socket, so it can
> be as small as TCP_MIN_GSO_SIZE.
>
> Refuse the encap if less than TCP_MIN_GSO_SIZE would be left, before the
> skb is changed. Return -ENOTSUPP, as handle_gso_encap() does for GSO
> skbs it cannot handle.
>
> Found with AI-assisted code review (Claude Code).
>
> Fixes: ca78801a81e0 ("bpf: handle GSO in bpf_lwt_push_encap")
> Signed-off-by: Orkun Emin Sar=C4=B1 <sariorkunemin@gmail.com>
> ---
> No reproducer was run and the fix is not runtime-tested. Build-tested
> with LLVM=3D1 W=3D1 and CONFIG_LWTUNNEL_BPF=3Dy. checkpatch prefers
> EOPNOTSUPP; ENOTSUPP is kept to match the other errors of this helper.
> ---
>  net/core/lwt_bpf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index da49364ec6..c151a013a8 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -13,6 +13,7 @@
>  #include <net/gre.h>
>  #include <net/ip.h>
>  #include <net/ip6_route.h>
> +#include <net/tcp.h>
> =20
>  struct bpf_lwt_prog {
>  	struct bpf_prog *prog;
> @@ -632,6 +633,14 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * The MSS is lowered by len. Leave the least that the stack lets a
> +	 * TCP GSO packet have, or gso_size can wrap.
> +	 */
> +	if (skb_is_gso(skb) &&
> +	    skb_shinfo(skb)->gso_size < len + TCP_MIN_GSO_SIZE)
> +		return -ENOTSUPP;

I think it was fixed already. If not pls share a repro
that does so on bpf and bpf-next.
pw-bot: cr
