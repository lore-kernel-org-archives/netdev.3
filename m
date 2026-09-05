Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81733CEA7
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571243; cv=pass; b=QtGsNcibYA9ygYh2fUsluhAT34+7W88siLaWmXbsYv5Eyb8IhDmVn+kAM0VrAzh2QPT3AwstLqCvQHN+xWrQHWlVb+yE4XMCbPA2E6S1Q9aPbcp87TVOi+6VvclwM114tr2/L5YJOMpPMq2R2TSb6IUHYVGBFK7irg1kfyyDrbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571243; c=relaxed/simple;
	bh=P/Hbu0V5Vc4QgElq6BDPyNbu7w0tz8nmjZRMAFRdhVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=na6PxTOUnUClajxwYCVHxZWIZzVvWRfIsDyrucw/bfjSiB/MpjwUB9H7Z5AlqGqQ8Ze7hK2b5QPz2fGu6O7z6RTTBBskWkk+OPROJKpZfTFZDAAoa+ZyIsTKJzzTcx8PinJb4tKVAk7Jgwuyx36BS6QQpqsUkxnqgzqvXGCsa0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfEhKl0I; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfEhKl0I"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-852c481415fso1620445b3a.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 18:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788571240; cv=none;
        d=google.com; s=arc-20260327;
        b=goWIc0Zya4gNb6qIKIBAPD3bXP6gNWkWNDcaJxR9pEe/hsoS2CEBN5LN2tU0HZqM1i
         2bLk0H+r9uSDyqBOKZrpnEHAqwT4FkumvTt7Ej8W3KhRH7KGzZ7ER7l2A6YBUaj45CLE
         HA/FnbZ/mFM5VcY2uF/Tk+BMJLbTOvfoXpz6QBJlOtPkImPr0uuFB5KVbIoz4/kbgy7d
         Dolwn0qKRWiagD29sEywplRsdbVkjHSMEmX7VyXz9MG/vr6LwzfG723Yfx/Gp0MhP8MI
         Fxx7cE0YYeP9WxSunc+8HhLZrBl8zeWKB1CvkNWo5NJaiSLfXvYorsTE8xlJMrsM6x+g
         v25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/Hbu0V5Vc4QgElq6BDPyNbu7w0tz8nmjZRMAFRdhVQ=;
        fh=Ytx07Ovvuqztu+lvG9zwJLhQtMfhkXM+VM1o/P+GPM8=;
        b=RPIOSKakMD5o3B2pKXkfnY4KZqLYpna2tSFuKYQv7ZZhXEHlaFDFkSAQZI+ykefhQ9
         Tb8Y5KV0aAWJySwoMMcgWx58SA1Jp1pRaETcoDEN2zmjs0lS7wSo7TxDROtRji0Qq6xy
         0rJTzWQ45RKubffV2OjOHaszwaLJtYk2JuICje9d7VBlhdB34J+gMmtXnEfexS7Ej9Yg
         tDYrrnCGoE3jlcGk8BE40lS4pE3Sh3+bxo1qxhB94K5aGAUkOCpHI32P8t/jEShgK2rj
         NzClOpOJBW3eniBX8RNfKkKSFlg01ln9ix4sDXMea6avhtBHrCnvNKFOQbbymXxJHb5m
         3oEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788571240; x=1789176040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/Hbu0V5Vc4QgElq6BDPyNbu7w0tz8nmjZRMAFRdhVQ=;
        b=gfEhKl0It9NqgR3w8+wejPtXZN9sOx1oMaFRAYr2TmIgv9zIWWQ0zlN8C9Y+ji8YT/
         xqN3aUaYFp0UwVxtWZ9IqWdp9ADMLkdqiR77ZyZnoxvn6OxkCiBHx50KtjSRIeTYpyeh
         gCSOi2IWF50ArN+eYejmr2Y+bbcfauLDFpOptdZndGV6tSCNETtVadfRiDpUNUzYDiP1
         tB11vRwZrrV6B+t0Ks52C8lzxwaN05WvOhTTkdXcTg1UnS1KV0PhTo6lO+QWPLn+fTw4
         G9xJIvPDgs8P1/DwNdoSjS7Pza6QcQRzaYk0ZYdKrJRVsGiNE5XLpJTCT/qxbz0nD9kG
         kx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788571240; x=1789176040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/Hbu0V5Vc4QgElq6BDPyNbu7w0tz8nmjZRMAFRdhVQ=;
        b=lEzrZ8F/UtsOIVxcAX3ji3sIf5iW3LBoRYOz3jU31gG3isJEVrOg5APYEu+cW/UoYK
         h/yh0040l5fkPTHrYrJ8U0BTKrRuv1oYkWwqxam0l0ul1PXEdEnN8tHsQnS0CVlhGsxJ
         pE5AZLSz6Galp+TNJvfMPem9yzIAVCcKJbNmMWgbpF5w7cOO2Gd6PU53hTv7EbC097HW
         u6TfRA2b6oebl+zbyhxTzFg9NpOLV3OWYyKkyzrQEx58ZMHjJs0LV9y2b71FvUcV8we+
         8oB2n7+/VDSR/LxM51ELYlTRAbjDeKVkkqIkmt2Emkxx2z6MWnnjjmclEUr1iLmWuZXf
         GbmA==
X-Forwarded-Encrypted: i=1; AKwUvBwqrJt33MGrwcoZa5A3H7IS0UgEPS6FqGU39yeRlu1MBxRHlZOzYPfcVFA7uESiGhts3yKuHuU=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ0F6qbgSP1PCtQpI0FnjGFjExZqk3Qse5VwG7OGBkHUfAh7rZ
	9QmqClVpIp++aAzBX3TE2EGHRld2M5+HWU+AOF7nFyZYiVr7JDuyiSmSTwK146eogoPUAOOsQw/
	tpdfBJ4oO1QaTvFqTPkTPTmLQLuub8gk=
X-Gm-Gg: AYBFou2PxpcGSy6OXuFQtpn/oRM3xpJZ6zWUNCqCGKYs1oixgsGyXwGM0ClmMGZga1q
	/UdulnJOlNx2ktFfMU7zyjKAEKiFcjaFVqqxX6+rLInSoKbJ4IBWnU7RwtJe3OIMSgXXYQYjtMP
	eTMnNkGY56HuFsjavhiCu7i4sW3O27zMWkfvYbWCg5/q51yTQA2Jxd2L2B0KQj9R37yDMGVcuGS
	M2W/lrIIW6bXRvww51ccjGxwIE22nR36gFhI/ZS+14cxUzPlKZ1AhQWFPOeWoy2IkbQx3EAUu4E
	Dm/bjmRwwzVgDbpNAF//aLwt29a5dHsChf8sdfZMgTZzebNQC7EidZoob+yl4woaw4zyRoQr6bx
	bOOKMkB0KOEyPhe6Uv+qIX4C75MSL
X-Received: by 2002:a05:6a20:9f92:b0:3d0:ba81:79b1 with SMTP id
 adf61e73a8af0-3da3980a0f4mr14688710637.0.1788571240105; Fri, 04 Sep 2026
 18:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
 <CAAVpQUC==6KEBs3XgFjZ536mJ23cbHma8HuiWMu1DRc_=YYOHg@mail.gmail.com>
 <20260902155216.4fa23444@kernel.org> <CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com>
 <CAAVpQUATOCCc0N1jnfy2+tkD_zj1su-a-4+bV6qXOSzR7y_iQQ@mail.gmail.com>
In-Reply-To: <CAAVpQUATOCCc0N1jnfy2+tkD_zj1su-a-4+bV6qXOSzR7y_iQQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Sep 2026 18:20:28 -0700
X-Gm-Features: AcwNN1UINzK3524FpZxXYWs5I9-HPFyb-jm4MKb0Vr_8_U4tRNTF9_M_llHPnxY
Message-ID: <CAADnVQKi0yji3iEepgwy6c9cXWhzJqGJ9-gg-7NXJc5Jj+bVeA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix socket leaks around connect(AF_UNSPEC)+listen()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Wed, Sep 2, 2026 at 4:04=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Wed, Sep 2, 2026 at 3:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Wed, 2 Sep 2026 11:58:49 -0700 Kuniyuki Iwashima wrote:
> > > > > Several BPF socket helpers acquire a socket reference only when
> > > > > sk_is_refcounted() =3D=3D true, and release it, independently, by
> > > > > re-evaluating sk_is_refcounted() again at the time the release ru=
ns. TCP
> > > > > connect(AF_UNSPEC)+listen() sets SOCK_RCU_FREE on an established =
socket.
> > > >
> > > > Due to several bug reports, we are now inclined to forbid the
> > > > buggy transformation.
> > > > https://lore.kernel.org/netdev/CANn89i+px52TtJy3S9=3DuHxGj3s-WueguR=
o1Z_4FxO=3D02KLmwmQ@mail.gmail.com/
> > >
> > > Kuniyuki, would you be willing to send a patch to do that?
> > > Not sure if anyone else is planning to, I wasn't..
> >
> > Sure, I'll post one like this with s/synchronize_rcu()/-EINVAL/g
> > https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.c=
om/
>
> and cover IPV6_ADDRFORM.

sounds like the fixes in this patch set won't be needed,
so I tossed them out of patchwork.
