Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003443D51A
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445967; cv=pass; b=XOp6cw9cNpIdiST5aylgWIABGGRsDk+1OQfeeLytTXNRXnPcyrrMv5tKoZ/Vo+lZGHNYSmy7l4B0XXDO1lhcUirmDE+RyEVfLHW7ZR8p4m4i8aiZfuFOQjoIInYORS3TxkToYaiGKQ5bPlQYUA9BuUKV8xrbZm3z1qGfdxJo0xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445967; c=relaxed/simple;
	bh=Lgz/27RWrkMuWAGAkwj01RzzBg9p0OsDjQWbL5vth+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHIu1a4d5JFEB/p0G/bLt33eWYJmkv4ecDlWfcbonbUQgx3BLAd+mfZhyq54lSD3pc9h0RKaeaxYkE+b7RAEXXH328UDaEH+Sil2mUBM31Hv0xcsb5RaPkYgSDm/sVSIZZ0KGzkQ/hi1aBBgF2O8dInOgZM3sCdaZjEoZsSNX1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+ixc5kX; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+ixc5kX"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2a818fc4so18914661cf.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786445965; cv=none;
        d=google.com; s=arc-20260327;
        b=ZqsPGkVcFiCR63ROEkF4jbhopP8WZwMtFIJde3kGajoG6wl/jvyk0qigNe7+AT4aFr
         NdqMJ43y9toi9Bl8IaVxUWnwW1J58xkqEbJKbz6Ux1i1gTh/KKeo+vDs/J4VkzKCDcFb
         wtOpC2Jc/XGlvCIxkyTJ8kPlYhbM2L/KPIGsPSmNMiSJfJaozeMk5lQaxZzSI8P8LBx3
         7iHHgcmZB9vown6cM6O/B2MoYxhad9UxBEKKdPfqT/56mWSVRvXL3yp9NtoEF90+7xL0
         dh9F2PBmBWfJHDMQMVgMhk8PX4f+elnkWFyyYB76EREfRqdDNPPPzoPUpESLYQju82+W
         5faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1LoOdfE6FqjcrDPCizJZ+AsE7iWqaxgoP+VfWz/UvBQ=;
        fh=mm2C1oQQaZp/iM9FNBiB0tedjLfFZViky3v24AFRJy0=;
        b=iARE9/Tu0udCyoWTCkqSniFQlXQWPD8aQsG7rQBkbImZeM3SKECgdaNaN29SQUeJGP
         yKo3/zDdzN8KavilimnmQ6El28Q7pIv6/Y9zi5S0odayCeYKJYTO/R6Wsz+XAC7v4rfm
         YAAV7UASVs9ZFqtu2cPwVdsR/Ti0cptng/ObRwVyuqY114hRkWjUN7gLet8xJsAtGS4Y
         Wv0kBTmZp6dZmGgwAiLpGw46z4XI6Usibi7fLZgm60nhmZVC59T22o/OlwBL8xGGS1Wd
         PnkefpPLZyDW+yjCr8+P/5OXLGk4R+qYgnbpUl/EqHvsZv3/MiXvK46YSjvT+wn6lYC7
         x8mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786445965; x=1787050765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1LoOdfE6FqjcrDPCizJZ+AsE7iWqaxgoP+VfWz/UvBQ=;
        b=d+ixc5kXmug16jIMy4QkaHyf2NleB6CqWm5OCIAPCXV4z/yt7mqpXg7JTEghPRuJFT
         CIk6l+AbQ2BM0w5dYvDdCoQS05+z0p+M/QzcAT2POapeZkwjHm6uaVLaBOtSC3Cbyry8
         pezwROoSADONVTBP+oAvL6y8ktnMPjsHVM1ybhmlaRk7UQdFtb6lc3OPjk+J5vS1r04b
         nDg1hNnnb8Rs8KYVE9V5VL0crwVqal5KEQKso6IBnOW4SwWubKchkYjh634Hh8o6VKZU
         7987xgRysxkDmuvch4+5SlcB4dZtWbhKiaAUWgdvmHqtHk+0Ilx4dDw7myKAoW5HcOEV
         DeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786445965; x=1787050765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1LoOdfE6FqjcrDPCizJZ+AsE7iWqaxgoP+VfWz/UvBQ=;
        b=UKH0nzOnWKL0cFgG2u8bOUrH8PtLGu1y6Od72BRkkax0a3prWUZofdonZeMSBTBnvq
         3vsKYBTvM4rtv0Xj1w2fRLlTepdTLPmk/bn4M1GLKDzwyBEZVJ5Uf7xS1+wZauwD7sE1
         9SZSOi1sFv9ZJTLqmgIJMt/pr+yidMHjSsC9CEIRuYQv8IAqTkNLhOV0Km+L1IIaSFlD
         RemoHRiDnnxhz3rzJEROxnS81krDjVR0L1HXLzQOKreMQn3oFfFOO6pUKoKfxkSN+OLb
         dhRkuOn5C/XHnd+wpe09ykob3tCz63/ylwzHFqk+PxLg2rgVH2DTFMv1O+NmcVk/S0pu
         9uTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqakxoXMMt5rw+dmiiaEZIpJ0inp47tLvc/dxB7Om5Dd77w5uoDz1l8o1ZrAMcp+6FpP5wT9d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYq7Nu9SfofdjAEsToLVQ9XK0y86aXQhQxZ411SWDsT9en0aX
	CbpmAp16lftrWmK9Kuitm4X7qrJSqdP6Zh6BwcZmVMErP4RCM7+p+GDKVWIo1Ug7Fh4hsQL3wTO
	HGIrjtsPjoB7MmZ3Og8UOzfZHVHRjlfn0vnnohIJD
X-Gm-Gg: AR+sD12dVKpFgGRHaCdanu/QMbZqaVfB76VxYqGq1NRmWbTPEuHsmcqoJUji+m2UDr8
	9m0E0pJCY7LnycbEtl5qUq4ZqJQlYcYm407u635uLicCLWZwLG2ZZTrZ9gEQV/J027wdbDl3N39
	QUz0E3zfi4SpGgNjG6/8m8zwysL3C7ZTYD7M3p2/S8+ho5dh9YqwztM39SES2U/gvwqqJDxPy5U
	yAoGshAst1ggolC0rU6lECETy82K1VCLZX3biCdGqaLGsLM8fMvLyq91s68Yq29uGC1ZcO60L9A
	5BgZG351MriOeJY0mWQ5W5rM1VJ6AXp+NtCeOINxT2p1O1XOH19ye7H03bG9lTRCcu+6SzHOni7
	zc8r9iSgY/U12ocaznkVd5LvTZYDZ1RHXZLMTzfCmA9zor4Ia8KkNHjO4Zh+DMu0XZnN29koADj
	CiDYgLpWkPqWQ/m8o=
X-Received: by 2002:a05:622a:1393:b0:51c:1532:ae84 with SMTP id
 d75a77b69052e-52d584abfcbmr16229571cf.6.1786445964000; Tue, 11 Aug 2026
 03:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810141125.1176545-1-edumazet@google.com> <4821130f-2416-42f6-b3cc-c0cfc12ffaa0@redhat.com>
In-Reply-To: <4821130f-2416-42f6-b3cc-c0cfc12ffaa0@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Aug 2026 12:59:11 +0200
X-Gm-Features: AUfX_my6jMXHsHqlMFhz_geMEulD416qJnODF2joMVZhxh1w0YVwTSpDatU0Yyw
Message-ID: <CANn89i+Y5hiD=-ifXroaZ=f8U68NbSW=b6MeWQG472iSDBC3Tg@mail.gmail.com>
Subject: Re: [PATCH v2 net] l2tp: fix tunnel and session refcount leak on
 seq_file release
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com, 
	James Chapman <jchapman@katalix.com>, Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 12:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 8/10/26 4:11 PM, Eric Dumazet wrote:
> > @@ -1608,8 +1655,8 @@ static __net_init int pppol2tp_init_net(struct ne=
t *net)
> >       struct proc_dir_entry *pde;
> >       int err =3D 0;
> >
> > -     pde =3D proc_create_net("pppol2tp", 0444, net->proc_net,
> > -                           &pppol2tp_seq_ops, sizeof(struct pppol2tp_s=
eq_data));
> > +     pde =3D proc_create_data("pppol2tp", 0444, net->proc_net,
> > +                            &pppol2tp_proc_ops, net);
>
> It looks like the above does not build with CONFIG_PROC_FS=3Dn:
>
> net/l2tp/l2tp_ppp.c: In function =E2=80=98pppol2tp_init_net=E2=80=99:
> net/l2tp/l2tp_ppp.c:1659:33: error: =E2=80=98pppol2tp_proc_ops=E2=80=99 u=
ndeclared (first use in this function); did you mean =E2=80=98pppol2tp_chan=
_ops=E2=80=99?
>  1659 |                                &pppol2tp_proc_ops, net);
>       |                                 ^~~~~~~~~~~~~~~~~
>       |                                 pppol2tp_chan_ops
>

For some reason, proc_create_net() is a NOP for CONFIG_PROC_FS=3Dn, but
proc_create_data() is not.

Oh well.
