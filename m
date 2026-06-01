Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245F3DBD47
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327760; cv=pass; b=hoqE7c8HoU9tQJfEAap3FOyF6Ff+EvcAFx+tg2L16wG2v53ouZL/HuEAaAqSKG6vRjEZd6Q1hpnwtWrDqDdg0BgpLBsD/BteM2V+22cVYxih4SfF+sf6NrFnK51QXBunMDTFmMsuf89FMFsJB73dpckoK+DP50kNC68Uclj/fiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327760; c=relaxed/simple;
	bh=Wj2HjaCmvrNykd7/b89FdO2/xBGB5dAuIyTwzhwlNos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIsPqYB4N0EZ+rHaKByvnnJ/LyxNNNbd4xviObtXNb5mD6m5awI1CoAsOWYgRsIZzDq5kEeBDAxDQjLsP2q8aq95F2CD+wA+MYB6GLk/MQ46FdHNYlmBwyFe4gzjPrQb5HI6fW1cb7Wq7s0RxIMYgYrf+aKS/lPGEIphi/424oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAAJYdYZ; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAAJYdYZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5174a132590so16210571cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780327750; cv=none;
        d=google.com; s=arc-20240605;
        b=fMsXcKPZS3Ra8zZUKBEQlBunSDU8jzvF8Rxh+0VkUNutRrLGE6pottfqkLjQOX1sqz
         I93XYUeVG0eInSfVdHrOXuUSHLAYM6AuS/KNmqUn4RJogUD/JwPZXFvAV4EKfIPRcsJC
         elfzH9taulrflueNsCiK/sfOBESlaxSZNYYT0W3tNeqs0VvEnu0zKXXa3A7Ojv9T4FmU
         Z+kWOzEFLS7f4s6Fc2ahHcgFns3YvphIVAO8QNKPJtUOCkpkIsBHA82erDQy1mdVWTJb
         br1k5PDJ65+TcgoMBcwR8dInxXUIDYHSKvWWU7G5QMn4Bp/tsCcVkbBEv7E6ZjCiHfNv
         nffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7EP5yWJP/oLaBrC33EafyKNZLj+nlCv8r++/P2IFxvE=;
        fh=/cl10EY+o8t93JMihtLNkU+2heV7ZKumCAsWGJSgKy4=;
        b=DvdaG9ebZONvX5mo8A17BPZBPswfZUEkkMyd7tkgAgIUChxCpqn8xIx88xprRR34MG
         r34nAg1MC4jjxyy7dCpEx+tjAu8Uh76GJehe8EQYzvFIp77bLb0zhb3gxzRJ1vDjlkE5
         gypeZoOP6A7PThPDu1ZOmh51+F+8A8PEt2/BEbVGV/6UV5l+1r9SSDMyxiUBaJGb8J8H
         Yt0G91xUZKkhRA0Q1eORMto+URKPRxzzxVjpn2WVLIlA7L7li++iUhxYDmjCI0zDjZYp
         5rTRVMIyXjTp7xE2BRP/MRRjyUjuMi/Mk+8cBCOimtkad7+JUeC6kPYY/knSpHXPbZsX
         ieeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780327750; x=1780932550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EP5yWJP/oLaBrC33EafyKNZLj+nlCv8r++/P2IFxvE=;
        b=ZAAJYdYZV/KGWuFFI74dgcE5AjOOyyiRXII2VV93UrZNpHjLmPIDR3f//rcPmuDdAm
         bZYMZK84P2WA51F/FCWoVDSe80hxKU+FT2kAsJvFTNE1IT3ljY0jkQ5U0vnb3hE249xl
         oxnXysfShracuKeYpx/z49Xqw55KaDOQnm15831kQ33BbUmEYn+QhuIl95pQ06AaHBUc
         PVPvmZcXv8T5//LvHnIXUHvVsBDCutUVpeYRhPY3vDaTIaFKZmTuKy9YZfVIeXWAGxYf
         Ul2B2e9KhGG0XHp5MFmcDz0gPcTr5Oc9CSQObBvmofdPrkKPeCB0A9pw/Cbd08kI/mso
         MJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327750; x=1780932550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7EP5yWJP/oLaBrC33EafyKNZLj+nlCv8r++/P2IFxvE=;
        b=jyCiS7pipKBbqudJyoBxULB9qvtOPAwemVr4yoEEphXP+Jqlb0JCtixMYSADJbHPPZ
         4fmeyTeIc9ByhaheOEIVphWK1B/RA1vbsTZjbdlm6JN0isDPORR4ODA//cLwCXiakOC6
         40fi+5hVjk345r9tdexWMgb3Q68Udy7KMzHDWJi9iu0j58n49mQff3SLctCcpcsWPhaU
         CIPIYTU2EKrvuEaMszgRs0R6jqlRO9+N2a8VnQTPE8jMtd23p83X7xll9pfqW6X1SxdH
         N4YKmOlowalHN7IBmzXzUr15WEX14BRwjSgwfm3OtOkg9hPacztPAMauVMxsDLzX80VS
         jioA==
X-Forwarded-Encrypted: i=1; AFNElJ/MemRwgU+Fr6BLvW+yh4EetyugXFg7dq+9sU17AjxOOhPdkOapx0UcA829+0gph0Y9/3x377w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx1BFp8Xx1ibZKqCuMwCMsnK/onfcCD5IWPbaaPlKRN1xEhjY9
	B0QqOcljAi8dzEwxxQYjtKUaa2UCKjAnqoUONTJj/Epm3G+06aHQwoDYRGFsH/XPZZyPKq0Z5oK
	f21nwXj/o0i0ep6C9NesUXGMr5Xo8rGaYR9z0mcSc
X-Gm-Gg: Acq92OEvZrTKOdGDMjQiyGeK9hkwnwt+aEhi36aURD5FTRDxb2hx7Mm1qVzLq8H7b/j
	QRqYIvSW/zWfmvr8u9kHOeYoFTr9qXPbKG1nk5LrVjzF1fafkIa1jACDbkkwRVvQevOxPPGR+Nw
	8g42/Ra9VsPc6q8XAKMR/doikw5rDC9daIP8drj1shidIbpWtz6Wa/5K49a87m2Iv0p88mIkzkU
	1UDrMPCEttlLf/iLNhS4ajtcTZJzDXYE6QwW7nJ0J8qEVWbWKWY8tEbUzEpkqnFxBFGmTanLPIi
	qAnsS19GHsvBN4kRVyw09KerLOsVGzpXXFLoBjES/mV3Be1MLoccG5z6R+qLxvLiSWVSVeok0a9
	nI//LZ8J9uoCXjWhnozYhfcIhJqRk
X-Received: by 2002:ac8:5fd4:0:b0:516:daff:7f7e with SMTP id
 d75a77b69052e-5173a80ffb6mr163432151cf.48.1780327749316; Mon, 01 Jun 2026
 08:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601150203.20352-1-leon.hwang@linux.dev> <20260601150203.20352-2-leon.hwang@linux.dev>
In-Reply-To: <20260601150203.20352-2-leon.hwang@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 08:28:58 -0700
X-Gm-Features: AVHnY4KtmX48lQbX-Wzhm_U2p70Q1h5Y6tSbTyXB_2Lu_Z88IMHeMo5GbIX4esw
Message-ID: <CANn89iLJgBxx=NaZDHy4s1_U9LKp9dqUDd1v9LR3CQPNo7DxEQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com, Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:03=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
> When a driver, e.g. ice, reuses the stale skb->transport_header to
> offload checksum computation to NIC hardware, VxLAN packets encapsulated
> by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.
>
> Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
> encapsulated packet uses UDP, so checksum offload works correctly.
>
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_pus=
h_encap")
> Cc: Leon Hwang <leon.huangfu@shopee.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  net/core/lwt_bpf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..65d1dfbf3312 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool=
 ipv4, int encap_len)
>
>  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool =
ingress)
>  {
> +       bool is_udp_tunnel;
>         struct iphdr *iph;
>         bool ipv4;
>         int err;
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void=
 *hdr, u32 len, bool ingress)
>                 ipv4 =3D true;
>                 if (unlikely(len < iph->ihl * 4))
>                         return -EINVAL;
> +               is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> +               if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof=
(struct udphdr)))
> +                       return -EINVAL;
>         } else if (iph->version =3D=3D 6) {
>                 ipv4 =3D false;
>                 if (unlikely(len < sizeof(struct ipv6hdr)))
>                         return -EINVAL;
> +               is_udp_tunnel =3D ((struct ipv6hdr *)iph)->nexthdr =3D=3D=
 NEXTHDR_UDP;
> +               if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6hdr=
) + sizeof(struct udphdr)))
> +                       return -EINVAL;
>         } else {
>                 return -EINVAL;
>         }
> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>         if (ingress)
>                 skb_postpush_rcsum(skb, iph, len);
>         skb_reset_network_header(skb);

iph might point to freed memory after skb_cow_head(), leading to UAF in iph=
->ihl

This issue is already there in the skb_postpush_rcsum(skb, iph, len) call a=
bove.

> +       if (ipv4 && is_udp_tunnel)
> +               skb_set_transport_header(skb, skb_network_offset(skb) + i=
ph->ihl * 4);
> +       else if (!ipv4 && is_udp_tunnel)
> +               skb_set_transport_header(skb, skb_network_offset(skb) + s=
izeof(struct ipv6hdr));
>         memcpy(skb_network_header(skb), hdr, len);
>         bpf_compute_data_pointers(skb);
>         skb_clear_hash(skb);
> --
> 2.54.0
>
