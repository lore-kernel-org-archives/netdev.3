Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D45345731
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262660; cv=pass; b=AZuvliS3PUtVMHWObwxAhDKg3yruciBtCOUezEGyvCRjs4ficxchQC4m+U1HwzkJC/ziKltNAJf4dCUHKLNXT1CRNQ5oalTys7x/Vksl1Fy+0OdA7IIwsDPDCVk21+Hn+CTWGX6fsLhaRtw0SF1WDXRgz6huW9SR6hY92pMoocU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262660; c=relaxed/simple;
	bh=8LicP1czLJf2aaqoZwmEPuDV1Ar8SxP/VgwnKAq8Vr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9akzfoYaecYeGDiwaJ6xnMFzv7hnBHAU4SOY4Y1KLqt922rvgzIKLwvet2ypMkDD0eBNPeHDwK39ufuPTPE8gVrEcP5l41xoGENUwJR6WCGdP1ZUw4aQPTr4+FYAfXmPpM253CQzxHlyRLtQtk3bDMr4wd1m3JESro5HvW1Rk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=smwD0+rm; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="smwD0+rm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84237c55ef9so622879b3a.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781262658; cv=none;
        d=google.com; s=arc-20240605;
        b=NIA5m0aarpkYf1VtfhqSrnIEFZysjjzQZRUQAQdwwEfD4TGGZNv8kIeUK23j+E2lTK
         7ihfEGge4Ecp0PvuPER3dh7gFNMBxZUaI9TAkHFmCQlfsuOgQ0Ci1oj7uzqZGrwnixjS
         ZToZSUaBKeUAxv+hw+GehjbbQsJBq72YhQsC4KF5/SqStqdBqTPGCrMAzTNc+FQWaLZO
         58e3KH6ViOZd0F54LHGJ999vnTex+fiPbnvAZHZnsGWtKqapYEKYtooeeqeAJYkV2dnM
         uSGCEbIAi3v8gdMLgdxvGijQRDuch7LL9rVafDvT1YJpZ0pYXnzudSSExJxX2teC8LMC
         fvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ImqDBhivd0n0cIWvvDVHjeQE96Q+iiAwbS6FRSPYw9A=;
        fh=VQi/ODdPrwpDra7zg4AK7gjYP1nM+XCZ4hKFowRKcZE=;
        b=Qpb9fYl9E0kMX25r1bE2Nit//On87mfHpfYFXfjw/72mxOoPzf5RSW7dvoTHjVVC2f
         bihUhuanSagRmw4yKUsDMeNqkjPLyunxQDcHqoaU1ibjJZ1J2oEtnJVVqG6JLmS3Dr2A
         9xJyepIH4wfsk0st6dGZbzDDl0m7fjm0rukR4LGiy/TkYg5pdb6P7Xf8fjEzO+XNPRWt
         4aLockq+lq7Wyo0Ka42+PGYe6Ce/SdKKwH/zeqJQu+NpDrxCHQPuJAxVsCkhzaamTHD3
         2S85LgzpYJ0dxRryD/V5WTJaYUNnBHLWkW8uJH+OvK6fVTXXav1mf8tP+ScA6tfGZ44Y
         7EuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781262658; x=1781867458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImqDBhivd0n0cIWvvDVHjeQE96Q+iiAwbS6FRSPYw9A=;
        b=smwD0+rmWb605UFEmEsOw9sgV4LrjbrqRwiVnB3rwz88NLO3wWH8CG1yJV4/T1w3dZ
         z0P0U42IWVYIwORx9wdbDsDcMb0XrfIcn6YlGMxH2NSjD8qBaQu4qDP5fM2C7HB6fjfm
         qWRMkJT52gtc6v6xucDcf4cgRpWOwH4mp8UVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781262658; x=1781867458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ImqDBhivd0n0cIWvvDVHjeQE96Q+iiAwbS6FRSPYw9A=;
        b=U3M9bChA23FCSvf/yg+YGvg1S45jLnq1FTLta6zWuJ4EmgJm6NhJearlo5GO+IXlj5
         4TUEhJf4dk0qsaFxKx6eNaDNAMsCK1tcU+xU8JAaTh1ks3XSp7LTYmpGXD7HT3VIUTXg
         Wy7sytU43pDqjID2MTIdk503i647xo2fXddMf0bdEXH0Q6oqSUqupY9TAoH5xIYmNBrF
         DzPDBeWzrINABbznsqP93WPJHRzeGTF/cn6GbGWoAIksrp22UFv84BJ/QCjvxe78IAWW
         ZR8IOGPA18nPExuPaSWtk4f7LoQ1Nmo1QGCicRHMzWwhEa6/WN4yOc0Ro1rpOSqbgTlz
         LIUQ==
X-Gm-Message-State: AOJu0YwODFyotG2ZgZzzNPVUoRGtyaISMNRPCLCO/zoyVbCeDOHVH3pe
	m4IjQadmof6VxDxET1I+H+LAk3rVF7YwXLbNLnIVKaVV7hbHZlEYMDUTbvEqXvEgXO9uwUSAnSe
	Fe3EI4ZKhJ1My6gWhcC7kiyh1PX638s8KgVxM0coE
X-Gm-Gg: Acq92OEQ+hhIPUnZ5Zrzxl9JcLK8x2Sh9MvsjO9PWDpxcYj+mujcZfKQ2dvfIjGG5cd
	PXquM0wuruIxML7NdxenQZUenwYr43cZXJtJPYpng7KNbf2KBJIZndv5hBf58RU7pnKCjzHufLc
	snrZT+DIsVGTOWInjYjRC6/Bn/FCri51Q8SKobzseGspVdHjy9fpB4Ao6nizDjYCP4tAJXKsRiv
	XHkoJ/QkoLr8d3M7PpHzvDtX/AJx3ax6eUZaPOVDchjsHpEfEh9Uy8QrqrLrOdXrv2oHiwfhPnc
	4zTqGN7N
X-Received: by 2002:a05:6a00:80e:b0:824:a22c:c6d7 with SMTP id
 d2e1a72fcca58-8434cd47333mr2634927b3a.18.1781262658061; Fri, 12 Jun 2026
 04:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780651977.git.xizh2024@lzu.edu.cn> <20260611154939.2615919-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260611154939.2615919-1-n05ec@lzu.edu.cn>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Jun 2026 07:10:46 -0400
X-Gm-Features: AVVi8CefXDSvjCiULoq8lshurbia4IsPa5Woc82E05HwWDFz-9PRaAnyul_i1ww
Message-ID: <CAM0EoM=x9UXzpwWZXB=XvBazzpxQ+twfR5qw7C-_YVjkjqHzCQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: act_ct: preserve tc_skb_cb across defragmentation
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, paulb@nvidia.com, 
	kuba@kernel.org, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, xizh2024@lzu.edu.cn, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 11:49=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zihan Xi <xizh2024@lzu.edu.cn>
>
> tcf_ct_handle_fragments() calls nf_ct_handle_fragments() without saving
> and restoring skb->cb. The defrag helper clears IPCB/IP6CB, which aliases
> the tc_skb_cb/qdisc_skb_cb control buffer. Fragmented traffic through
> act_ct therefore loses qdisc metadata such as pkt_segs and can trigger
> WARN_ON_ONCE() in qdisc_pkt_segs() when panic_on_warn is enabled.
>
> Save and restore the full tc_skb_cb around nf_ct_handle_fragments(),
> matching the pattern used by ovs_ct_handle_fragments().
>
> Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc contr=
ol block")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sched/act_ct.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 6158e13c98d3..ebd40daf05a6 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -845,10 +845,10 @@ static int tcf_ct_handle_fragments(struct net *net,=
 struct sk_buff *skb,
>  {
>         enum ip_conntrack_info ctinfo;
>         struct nf_conn *ct;
> +       struct tc_skb_cb cb;
>         int err =3D 0;
>         bool frag;
>         u8 proto;
> -       u16 mru;
>
>         /* Previously seen (loopback)? Ignore. */
>         ct =3D nf_ct_get(skb, &ctinfo);
> @@ -862,12 +862,13 @@ static int tcf_ct_handle_fragments(struct net *net,=
 struct sk_buff *skb,
>         if (err || !frag)
>                 return err;
>
> -       err =3D nf_ct_handle_fragments(net, skb, zone, family, &proto, &m=
ru);
> +       cb =3D *tc_skb_cb(skb);
> +       err =3D nf_ct_handle_fragments(net, skb, zone, family, &proto, &c=
b.mru);
>         if (err)
>                 return err;
>
>         *defrag =3D true;
> -       tc_skb_cb(skb)->mru =3D mru;
> +       *tc_skb_cb(skb) =3D cb;
>
>         return 0;
>  }


The fix is reasonable (although i note you just added 48B on the stack)
It is unfortunate we have this cross-layer violation of the metadata -
the life of the tc cb should be maintained within the tc layer but
this call into nf_ct_handle_fragments() seems to over-write it

Can you add a tdc test case as well as patch 2?  if you dont know how
Victor or myself can create one for you.

cheers,
jamal
