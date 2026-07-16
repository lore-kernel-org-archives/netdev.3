Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F911386455
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784175419; cv=pass; b=IcK65vzMTYtu5RFlE1T9ihJJSVLVpw1O4NFAudxX5ptvTcd7MFCRasFn7u9RhksyLMzoDlEbeptm+1zu3CRTSNxAYGkihMtsjys/vemKNDxdQyvwwLfjcB2o9JoAPMPYZoY0UYSta62M9vAS/IplTC+SNh1bckgJwZ7CdrFTem8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784175419; c=relaxed/simple;
	bh=ACqkZZar0qD7F3xYJO0+xYeFLQyPaoZMcoWwITkOYWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=islycajFaEdzn0yIdCTQBOY41Zfyei83cHNQq50z1P8NMWJNMv4O8TcDvYV7T8YMGC4myh+H05Xrfgapr+DiO5YuoS/4LQuiUpAaXK2o5KEf6+97+Wliaa4gaYaWfxuMRgVqZYjopOAbkvWCRgXyQPbdmWb1Pjzg7k62ji9+EE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+ej7Bf7; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+ej7Bf7"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3997a448ecbso28224511fa.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 21:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784175415; cv=none;
        d=google.com; s=arc-20260327;
        b=lY8bSR8GRZc5pC/iO+6HcHxjStjdfepOW2rpvfZviXL2qUgtjzpzay3tBq8FsWoI3C
         E9vXoU9LrBNkGHbJzVyDIzCt620qJ/Nfum+1bl75oKtA8yN5VKi2hHznhWOBbpIizLGc
         v8DXAsH0eABnRif96Lee+PFT275Kwz2Pspj2lBdWgty+7G0tAwk48lRPhmUF3kUGuW6s
         lxNtvaCgJOPlHERTquX2B2g0q1JQCsRvYsy6z0P+6ys3/YihPgI/TbK7Bm8EiPia7Zco
         sSm4Lgf/d8pf718K5/BEA8BJULbi7GuIoilEC2OfNnUDd/zKgquDbQP96Qu2RQv+OjCf
         oBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMID0AA9JmIG/mAaLhghqWlpSrLxpgy5qYg2kv3FHAw=;
        fh=NoqOuOIoqYudd+mcPi69VOVI3LiJ06PiyEzNUK7iWWE=;
        b=COX3iiE8zeUnmWRMiImVss2ckgjkgdajT3GN9NujDcopla+rdC757C8z4adkLo/OGT
         JXusS+hYp4lYqbODvKHat3/RFaVVumQ/I6WrhcVzMAqkzLgfImlLZPALRbemTHEiR/g7
         t2rsosUo+7tZuFFxcFSrHO9Y6g2gffUO13YUM3H0n6SY1R1LabJbqtx/KHsqYmPZilCC
         1p0RomPRyula5drMr8cQmRAHNUTzhjDCqWou9ceFzOEYAvc7kwJaYOZ105RldWYggzO2
         uHZJFlMr1EnYkxwHxRiROcLAgxD6xiCXWI+nmCXUV6Sbd5X4Q3p4TdMibNgUosm8XwFS
         MH4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784175415; x=1784780215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FMID0AA9JmIG/mAaLhghqWlpSrLxpgy5qYg2kv3FHAw=;
        b=A+ej7Bf7+OnbVudwyj0deK7JJQ6wAF7HLi9t6lBMVYcG+k1vOrWf1QP+kWbqcgd0/U
         04dITX8o+o/6ybB/PMb1HfLFrhd0aIQ3lj1OvRn6MbNLJpqW4Yg8fZkbiusgssI1/imI
         JDVU5+KxwVn3fNxtp584viUD65CQE/5GfKOmRaP7a2tckfI0IUEYE1ZVsUMkSlSSOf37
         NBfZYBq5SX0mqDfJRnjbtPiK0GJKBHnJPJbgrcweoCqCHiU6dHBI72+gfW89YvxyLVyr
         qU0od1phJfCgTuvmBTl4ncXXRafSisQ3ZI1m02pSO7udLHrRxYVVR9+0vXl4sd7A9w57
         P1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784175415; x=1784780215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMID0AA9JmIG/mAaLhghqWlpSrLxpgy5qYg2kv3FHAw=;
        b=cn3n0rkwhOWA+eX/kMeK7+j1VvUglnhsrqF+WLhm7/zOW71q4aZjtMf1i8qhJ2pe/t
         ktVetg92p3mI02VYZKbqfzc1A75SKQgX6nk/F1A3mQavc7r9cCke64MeHZJieNRxjfGY
         lu5W5xKf3rEIeyn+UqMU7AnVOFcQdq+Xb/6k5pmb4OlF0AFMx35p5HIzekFrL18MABJj
         tvFBI23MV5Rop3WjXoax7JsCBgIYHO+VkOgfYfLkU0EE0tFfqop9NPSuCj2G2x1s0Rxh
         wV3AlxGXA6HItC/KNeQ1o0crcphyy8dAwQD7yDJlNeVRycXyctiII9ppTAoHr9IIEw2h
         oOUw==
X-Gm-Message-State: AOJu0Ywem5tQIVN+eg2C7b1yQW5qoo2DAcmJxpPyroZ0f14gnRWCtzok
	8spzISwuxwsdCKGnpnTfkmpSSW10Fc7a2l0R3n7op5PqBVwa2I8sGeyV27ORzfrAcchNdfoD0Jk
	KvVHGRaZ3RREOiD6ae51d3HXtTCCLLSjtlg==
X-Gm-Gg: AfdE7cnXGnN1ylRiFqo/Zo160Z4tzLhdYOLC0jnfnh80RQyZpjKTfx8AfUEGuebxCaf
	DNXzJg/aReEPUQEFwEXYthKidNWI4YSp5J4Ga7tKzGtuuEhC0ikrwaiVFrcg/+OP6C7q8qAGCj3
	H5P19E4l1wIc26Qx4lIMApT67tWOHJP8JjDN5YOIavqKd+EoNrfu86srlSTq637pJqlkzr9gjvF
	VRXhhT/T5/wGKGg64c3FYK6vQU3Mz4PLFK/VepiczLAa5sG9jcTZIrH7o/InMA=
X-Received: by 2002:a05:651c:198b:b0:39a:e7f6:49aa with SMTP id
 38308e7fff4ca-39caa1480a2mr46340111fa.2.1784175415190; Wed, 15 Jul 2026
 21:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711030733.48567-1-sigefriedhyy@gmail.com> <01009484-2a68-4b44-b742-bee13bbb08b2@kernel.org>
In-Reply-To: <01009484-2a68-4b44-b742-bee13bbb08b2@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Thu, 16 Jul 2026 13:16:43 +0900
X-Gm-Features: AUfX_mw6qAm0YZ94gjSzHMeAAKnbq-Qua6c6c1sjnP9yEbYbUFZNHLRP0DJw8ZQ
Message-ID: <CA+7S2v+BUmfHQpS7U8xhdiHr=EMt-S5F+oEPFiBLXQUOuX6Z6A@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] ipmaddr: use RTM_GETMULTICAST to list
 multicast addresses
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 12:03=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 7/10/26 9:07 PM, Yuyang Huang wrote:
> > +static int accept_maddr(struct nlmsghdr *n, void *arg)
> > +{
> > +     struct maddr_dump_ctx *ctx =3D arg;
> > +     struct ifaddrmsg *ifm =3D NLMSG_DATA(n);
> > +     int len =3D n->nlmsg_len - NLMSG_LENGTH(sizeof(*ifm));
> > +     struct rtattr *tb[IFA_MAX + 1];
> > +     struct ma_info *ma;
> > +
> > +     if (n->nlmsg_type !=3D RTM_GETMULTICAST &&
> > +         n->nlmsg_type !=3D RTM_NEWMULTICAST)
> > +             return 0;
>
> From claude (and I agree with the finding)
>
> > +static int accept_maddr(struct nlmsghdr *n, void *arg)
> > +{
> > ...
> > +     if (n->nlmsg_type !=3D RTM_GETMULTICAST &&
> > +         n->nlmsg_type !=3D RTM_NEWMULTICAST)
> > +             return 0;
>
> The kernel replies to a RTM_GETMULTICAST dump request with
> RTM_NEWMULTICAST messages =E2=80=94 it never sends RTM_GETMULTICAST in a
> response.  Including RTM_GETMULTICAST in the guard is dead code and is
> confusing; it inverts the usual convention used everywhere else in
> iproute2 (e.g. ipaddress.c always checks RTM_NEW* / RTM_DEL*, never
> RTM_GET*).
>
> Should be:
>
>         if (n->nlmsg_type !=3D RTM_NEWMULTICAST)
>                 return 0;
>
>

Thanks for the code review, I will fix this in patch v2.

Thanks,

Yuyang
