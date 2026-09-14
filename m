Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124736B916
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789361816; cv=pass; b=j4XxclSRcGR8ezTD2beVE6yvaIFwXnJupqJTG/oSRx37ExprhgkbJmXJwNJBa2L663DFsta7L8iZpMHHoGEenX/ByelemWqPIA53Ju5AupTrihyNSqZmQcbIWXDp4aqWTPi3LP9fm8zlW/amEY/+Y/ZmBcWQtrKZaf+QoO9U9as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789361816; c=relaxed/simple;
	bh=XJttOucUkwqKV5SIpXoyNSSoVR/yWjRXPTa4zl6qOJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEXyzWWFIcIhlkAgpGVU4ukdipToUKXYV+7rg2Sz0olWXHwo45d5ps5Xq1luyKcP6MNhJe6QCFeeHyUxPG3JQg2D1c3Q/2pdE3HgwzZWhREzJHdqqPxv2KjMNzO8Fcmw4OEMzVnhNRgFA3fm+//uughUrhD1oUXRVY86IDhdjQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHPiqd4U; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHPiqd4U"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86b90133ae8so1238690b3a.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 21:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789361815; cv=none;
        d=google.com; s=arc-20260327;
        b=EPqlAjz0r6E1QBJCvYNfrXIlTOoTYlFkC6UO79Wfy2OCWgn1VZVUxaT/TXNch0fHZq
         FJfKTESQb5KjOniXl5a4Xo4qpzVTjON8stavAByEuEwGhpuDNHxm/jFWBSxo7QYIv5Yy
         Em5qhQzs400NCQzYWQZLeboza9Vg25ajHxYfabsgp1yMFG0le+89ToEkX5dMbtDC035u
         /RthS/qxIdUANDVZ/AVyZM12bDrAi42Ih6LFGU9FgJkoV8C0xfyWMXRey4uoxnsl61tW
         rjja1B9PYe81WJfiudaPmvt9p1GIFEqR/tQK440fWbIZWB6da19L4j+wzP/JTi7xStZw
         WEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/6z8L6rXqNfxAj7abEXiX9kfEbaPtyTmUGq5VEFvzYo=;
        fh=ImxgcnR73ZffMhhhQCHA++QOBSz/x7vjCZa0AEl8TQM=;
        b=oJKXlx4g1wctKlDvcdaN6PHaOoPXMhHv/OU9FDxpYpupF6rOT3pwJMM670MfX5fuRD
         NvtR6hZBwvmBcvYBuf7BJkEtUCU+VtEPlTYwifBhgbJeHsXQ6CSsdlD7+qeyjIyArykD
         cZhbOic5ozO0KOlfwCdXRl9dMpvpTxk4AUq7LCMbsoPYqj4a63JXGijqzsIZgl9i6Yzg
         luNPJ1v/z17kaT5Q05aasGV8adH+dMFdfnxHUiMyO3ts9zEpCv0tEsLKi6ZQoSej7FyL
         t3uL60njebOTQGuf+IKSyw2mYfxWyfWVKhvHPCAwz0ONR6inLVMNwWrOgXTLthtHnyMV
         bz7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789361815; x=1789966615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6z8L6rXqNfxAj7abEXiX9kfEbaPtyTmUGq5VEFvzYo=;
        b=YHPiqd4UDJFcLSim8h6foqhDfLIQ3xRTfHsrqalCtj+JzOgTe/cksF2ThWOCC8Sk/A
         f2+hWx7Zncb8TyBclkIHMsvfYsfb4XLGryppNx5vhgR2ScNW4ilPBA3ZzUkcdzzTAMRd
         Zlen8kemyjWRSChH45qrNnMtUFYL/gmDRP76xJq9tVlfRSLztxLzDsrlA5FI10MmqKzd
         mFMVT3FSKHGNz1Z0kE+NlGUkA5ZtUK6E8vkTe56+08LKufB6pOU39CqLg/EMoghMm5zR
         yoa96SAFbX0pMR+Y8xxY54+OcQljZ9GR4xCpmpqpUXulTyoS1bK+G7j8J4VOyEt5TRl3
         n16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789361815; x=1789966615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6z8L6rXqNfxAj7abEXiX9kfEbaPtyTmUGq5VEFvzYo=;
        b=nmq4M0WpN+urOZJxBpKehY09XW/rZYG4LwG3vJCoBiCgJgjjughTeNbKs5cJsErcaw
         7loyxOFuCZo8Bj4veNeJDNR613yU9a0kyQzyT8hh+4no1xbV3TAxEhQ6MExXO8HX9ASk
         Ex6he9Y0L1Q1UFUmgQBJxTC/+y34fAMaFL0B9M8Xuaem8V8j9rSv0gMxFeETZmtFNm0r
         LZHO8FfeZ4yZDDwfn176Ujog7ZyBKnKTCjPG6qJri5CRTTopXO8YC4rhmozH1hBUWIvW
         LIZh1iv04T2m5iX7CweTd5foh3mZ/lZo9FFQxX/VlDKva+Wuw9Q9yra4E+iCwh17YA6F
         9QaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwToDfCXi6yEi5p++iFl4gr2ESQKGc47cgPO7W4P5Yd8SsIXCdK8UW8SAfkpzbTCIB5VmHdJ+E=@vger.kernel.org
X-Gm-Message-State: AFuF++m71RaCzXCsBJobVlXtaWJ3iry7KehjI4y8RhGOWgminiROUROq
	np0bQ2X6+sKTClz+IG2cgdg6s2+CVnZQiarkMd1M7eo6MXLLf84yTGi0wL4Yp9Bs9U7yfci6S0P
	mozIaJRekyy+ljfeoA4v9294O2DkNl4E=
X-Gm-Gg: AYBFou3PvvuD4yDoUeMUMTmhb/y2HrR9J/ypLlF3SkquGRczvTOiezRgIIrfv1DNysy
	QVdYDsFlBIP2+2H3d9xHdIj9JycO2Fa9JbITYdwRAdfjTZ6OUJRfnEV6fu8xjSWRYH9WeJFzaN0
	AntCy8hF24suaXVctB8rwegiWGDTtxCOANLHDAQwlZ8mbNYzfqkgaecb90+JpYgSSDceLq6riaK
	bk3RZ33T3u0DuUjkAjN4osT0039fD/DerMOAlFpQRskIX1JycjyNzHS5bzorEa4x7MswC69OTyp
	JNDozvcdvBrRbbFmYACyygdXcKizHbURshixypL5LwEOUU5P1KJSLgYHbrEQRpAcOtvlO+Ps69g
	EB+21piLh5nPfcc3hZDhRNOp3unfR+V2dIz1BkkK2Tvq2FB22hA==
X-Received: by 2002:a05:6a00:1916:b0:86c:52fd:fbdf with SMTP id
 d2e1a72fcca58-86f863bb784mr1977203b3a.20.1789361814478; Sun, 13 Sep 2026
 21:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910142522.45014-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20260910142522.45014-1-cenzhang@linux.microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 21:56:42 -0700
X-Gm-Features: AcwNN1Wb5k6vxqdzIM7sidRn28OXJvGl-UnASr4hD185qUY-L8N3wMNZHMnDeEQ
Message-ID: <CAADnVQJceTGftun8NfbyQdWe1FqLDsd6Ut5mrQFxuVkAvrAAEg@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix non-linear SRH access in bpf_update_srh_state()
To: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mathieu Xhonneux <m.xhonneux@gmail.com>, David Lebrun <dlebrun@google.com>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	AutonomousCodeSecurity@microsoft.com, Xiang Mei <xmei5@asu.edu>, 
	tgopinath@linux.microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 7:25=E2=80=AFAM Cen Zhang (Microsoft Security FORGE
Labs) <cenzhang@linux.microsoft.com> wrote:
>
> bpf_update_srh_state() locates an SRH with ipv6_find_hdr() and caches
> skb->data + srhoff in the per-CPU SEG6 BPF state. This assumes that the
> returned offset is within the skb linear head.
>
> That assumption is wrong because ipv6_find_hdr() uses skb_header_pointer(=
)
> and can locate an SRH in non-linear data. The direct srh->hdrlen read and
> the cached SRH pointer can therefore access memory outside the linear are=
a.
>
> BUG: KASAN: slab-use-after-free in bpf_update_srh_state+0x1bc/0x200
>  net/core/filter.c:7027 bpf_update_srh_state()
>  bpf_lwt_seg6_action()
>  input_action_end_bpf()
>  seg6_local_input()
>  ipv6_rthdr_rcv()
>
> Fix this by using seg6_get_srh(), which pulls and validates the complete
> SRH and reloads its pointer afterwards. Pulling can reallocate skb->head,
> so refresh the BPF data pointers inside bpf_update_srh_state() immediatel=
y
> after the call.
>
> For End.DT6, make the inner IPv6 base header linear before removing the
> outer headers. Pulling only the outer headers can leave the inner header =
in
> non-linear data, while ipv6_find_hdr() and the nexthop lookup access it
> directly. The helper parameter may point into packet data, so copy the
> table ID before pulling and potentially replacing skb->head. Clear the
> cached SRH pointer and refresh the BPF data pointers if the pull fails.
>
> End.B6 and End.B6.Encap can insert a new SRH and reallocate the skb befor=
e
> a later HMAC calculation or nexthop lookup returns an error. Rebuild the
> SRH state when the skb length changes, which indicates that the new SRH w=
as
> inserted. Failures before insertion leave the existing state unchanged.
>
> Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action help=
er")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/bpf/20260901183151.16648-1-cenzhang@linux.m=
icrosoft.com/
> Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
> Link: https://lore.kernel.org/bpf/CABFh=3Da5iLOEJdPhoaWUhLc0eEqAuhnd83_jJ=
r9MVZZG6gSJAEw@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/CABFh=3Da4VyzxsQqsayWpTKjxY3HL2C072u=3D=
pbecEpNDbL9eBNKA@mail.gmail.com/
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.=
microsoft.com>
> Assisted-by: Copilot:gpt-5.6-sol
> ---
> Changes in v3:
> - Copy the End.DT6 table ID before pskb_may_pull() can replace skb->head
>   and invalidate a packet-backed helper parameter.
> - Rebase onto the current bpf master branch.
>
> Changes in v2:
> - Rebuild the SRH state after End.B6 and End.B6.Encap only when the skb
>   length changes, avoiding selection of a spent Routing Header on errors
>   before insertion.
> - Rebase onto the current bpf master branch.
>
> Please queue this fix for stable kernels.
>
> Testing:
> - Built net/core/filter.o with CONFIG_IPV6_SEG6_BPF=3Dy.
> - checkpatch.pl, diff --check and exact-base patch replay.
> - No targeted runtime selftest was added. BPF LWT test-run does not suppo=
rt
>   non-linear skbs, and the existing SEG6 netns test does not create a
>   split inner IPv6 header for End.DT6.
>
>  net/core/filter.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2a84f9d01131..06a748c07747 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7017,15 +7017,16 @@ static void bpf_update_srh_state(struct sk_buff *=
skb)
>  {
>         struct seg6_bpf_srh_state *srh_state =3D
>                 this_cpu_ptr(&seg6_bpf_srh_states);
> -       int srhoff =3D 0;
> +       struct ipv6_sr_hdr *srh;
>
> -       if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)=
 {
> -               srh_state->srh =3D NULL;
> -       } else {
> -               srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srh=
off);
> -               srh_state->hdrlen =3D srh_state->srh->hdrlen << 3;
> -               srh_state->valid =3D true;
> -       }
> +       srh =3D seg6_get_srh(skb, 0);
> +       bpf_compute_data_pointers(skb);
> +       srh_state->srh =3D srh;
> +       if (!srh)
> +               return;
> +
> +       srh_state->hdrlen =3D srh->hdrlen << 3;
> +       srh_state->valid =3D true;

This is not equivalent.
Pls tell your clanker to be think xhigh.

pw-bot: cr
