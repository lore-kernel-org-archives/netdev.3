Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6308C560ADA
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996752; cv=pass; b=inHxNDMiSKhxexEFChhDT6xLKS3ASvF+a9XFQ3p8mJUlC42vO7KSmd9XmYChnWbAeDOlTEdjr3/Kgtv6+w//iGD67rog8QmtyfsZ3UiIObO+JkEpR6mLpDPgwjSb24ycpAyZxTHsidS8PlSWo4Lth92FffPkWSxVweYIsCMeLpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996752; c=relaxed/simple;
	bh=fQ50eGlFnjMQI2C3GaRdlcFw09nmY23Q11yUL7SlD5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaAwBXV5/amnnNKHgTsNgUfUhLZMB5xXwY8GxqEXynk4vZSGuZAW2hNfVNeNLwZ8FonNPprSLSWzA5Gf1wASZrOeGHh3izfsiqHLX6pVzUDnWiz42UBDNvgajWIOivtLvd3rChD+BFdk6tESwtUQVbrAGntkmY6L1yjBZXXKnPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=cIqhkAJt; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="cIqhkAJt"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1290921eec.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996749; cv=none;
        d=google.com; s=arc-20260327;
        b=YahuuGsDjtLjwQNAq8clyEYjabSIy0Niepiw6UpTIf1WCniYMH+vlTMkxrxU2KwEgW
         KhmrQCUfUrYEn96SWzJuKn7fjV3MjBbMBHzq0ayWv0FqqHF9oFx5C2DXbFuflK4VJg8Q
         EJa19UrIHbD5MTQUqjqbbCIJBhew9vMZ11l7OnarDsw1/0yoSsC7twUKKs072ylMvkwC
         ov3BczoGPlCeeFWPj5W1r5TbK4xJ1XxHOkLUrMoH7uWXMZ6GPMB8yFf0FmBzT1Nhwbci
         /5E46sndNFX0YLyAktLfzET8+tk68RHkxq32DcSVlfWtVMgmsd5B2Dyq4f4FVTZnLRfe
         rZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SWLwZ/p70zDk5tHBhgiTHN/1ZMG5p4KgHwoBBSKxoBM=;
        fh=PNsDauZi+l/vd+UP0fo8xNsB5PntbYgVeTEMD6hg5II=;
        b=q544SeVFriFr5If7xb3whjX00trMdbUui0rhreSDDGEDvAx4K81g8alvNiEwpvmVyR
         e4HNkxh6z9BImDNuYWOfscf+BWe/9MNMX3AGWmLvpfoMAL6X4HzaGi+9fd2+3O374yFL
         zDzUXocNAQXuO7eT+wYPhqdn/zd3QvmmD+FVgKFZVW6+8BPaNP7XysOQ9MjZ9z+IfM4R
         dX8IRjceBav+SeldBhMvj1uWBf8c7/zByMxBqJdfdJs8apowHkqLRRMLZ3cGF0w6CWjb
         MMIMK6CY5jrVyIjVnUQoeyLm3KS8MbYdkwAoCawdgmAUVY0vJda4wAG0GEK3bgEs2OuO
         u2XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791996749; x=1792601549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SWLwZ/p70zDk5tHBhgiTHN/1ZMG5p4KgHwoBBSKxoBM=;
        b=cIqhkAJtHmT03n2ZEgG8w4wzPyqXgS0tO+5FPE0Ijiuk5wj2XwI84XFWd0i4Vc7TXg
         kFDiRMoW3XYsxxKDS5EjN84s4sc1+2cceZ1KakpWldZFyeRMMfzl/gV6uTka0p/ks7gI
         H2hGLpArpHVzQrPUuBnAPvsjQJOHIS2HgT8d/fqOLKEnaKfYQb6yaQsCEnAERJSdIDqB
         3uTklSzvtA0WwbMzDPeMUTbDt8c7NVVUqdch7WFB+AhRJP0/3pEKvK4dpT/lDM+0bEPA
         zQ6a5NS2siQjSjLHvhxtR1xI24TbhiHMwCI5s05O8LFtnksRrNU7sRcMgCwksiRPLoMV
         KoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996749; x=1792601549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWLwZ/p70zDk5tHBhgiTHN/1ZMG5p4KgHwoBBSKxoBM=;
        b=XKRWADFIRXkcrxSLybZdBvFRjlhZNaCFH043y3EklOLusiIkB0ZtCZa+162zdIHxvV
         BXafy6BdIQpZ4n29e5df4ZcluWdTvLcFyXKHJ9WNfqIFuw7QUcT4PTN3eTlzLSCnqYn/
         naVRaDlZzXPgN+GVc0EOGQEoYOoeN5R+Sw+m2ZlKAeaGr/P6Ko0WS+2FvTX6T+Z0XIdh
         mPSADVGyXRf1s7Q1dLgesTBT8Fs8iHoKSgCMhZSZ+5+2tJbWidJu02qrp3z1mmMq8bqh
         BPA2OKMiSf3NnJGhQrbmknMJm0uvyY0dq+yBe7efkZxPL6GMaNbc1zi3n+0PI0PW38or
         oHXw==
X-Forwarded-Encrypted: i=1; AKwUvBzyjxfnlSCR3HcuhTuFVR0me8jgiYwNRw1dyU/m0yQTp96xeCl7EBluyvucl/+mZTvua8oGW8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYK0nzSFRRBOzEG00Bkhcq9f/lWC7a+u8VBrg58c1hBU/f11O/
	IlSUhSvWlkOtKKs6U7SjI1pKeICtfL/ddeMfh2r4pgdj25HAGw88W9qrZOq9XxJMN2bJDaQmo+1
	D3R9MAY010Vxfj6MsbyIKTRbAfe4kss7d2UqszODAGg==
X-Gm-Gg: AYBFou2ypz3Op3X4HGY8DtVz0AEE8yk/46bbdET19BKJRBT787oeuNi6/wRVQ3mOB1M
	82sCdCeZcsyBaRlDIjejJ8sSf8t8F1wBuIVY2p69X5hyEzI892yci5nOsU+ufLfAZgAGquX89Gt
	sz3MIX3N4Jt19EFd0+1CN+l8h4JFmenxWdEuB44CU0El1Ww8cfNGwj7BDRWfxOc1yrG7dvO+2cq
	yGp2q+NXoO8Xu1TePKNSilGbcNmUS9zVsMHk62LWOzkNxp25aOicSyG7w99fMBSV0wKu7jfATy2
	ypc+YhnBbXM7JigE9dVkxU/fHUZzAv60C+Q01Neuz9JNo1aFDvcfBVQ1LpBa9N7ynkfb6V6dqIy
	8yll/HTUueoCPBQ==
X-Received: by 2002:a05:693c:87c7:20b0:351:516f:7576 with SMTP id
 5a478bee46e88-3537e01e8a0mr23272919eec.10.1791996749365; Wed, 14 Oct 2026
 09:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
 <20261014135154.05de968e@pumpkin> <179198668564919.2.10323410751655182155@toxicpanda.com>
 <20261014173042.0a74a25d@pumpkin>
In-Reply-To: <20261014173042.0a74a25d@pumpkin>
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 12:52:17 -0400
X-Gm-Features: AclHuK-GYay-AQwoTupL5qC9wZ92QZPzmV0dk65w2lPnhQBw10ayUmM8aY0IhLk
Message-ID: <CAEzrpqd9Pna32K8i5Ug3tP+ZiRa7-0GmyX+sn=OwbZ_3osEAsQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report
 unreadable frags
To: David Laight <david.laight.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:30=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 14 Oct 2026 14:04:45 +0000
> Josef Bacik <josef@toxicpanda.com> wrote:
>
> > On Wed, Oct 14, 2026 at 01:51:54PM +0100, David Laight wrote:
> > > Can't you use that fact that the csum function should only return
> > > either 0 or ~0 and use the other value to indicate an error.
> > >
> > > ISTR this coming up before with the 'copy_to/from_user_and_csum' code=
.
> >
> > skb_copy_and_csum_bits() returns an unfolded __wsum starting from 0, so
> > 0 is a valid result today.  It would work if it started from ~0 the way
> > csum_and_copy_from_user() does, since that doesn't change the folded
> > result and the sum can never come out as 0.
>
> The result can only be 0 if either the length is zero or all the bytes
> are zero.
> You can probably prove that is never required.
> It is likely better to initialise the csum to either 0xffff or ~0.
>
> IIRC both IPv4 and IPv6 complement the checksum before sending it.
> For IPv6 a zero is invalid (it means checksum not calculated for IPv4),
> I think the best was to achieve that is to initialise the csum to 1
> and then add 1 after inverting it.
>
> > But this is one of those "you have to know the behavior of the function
> > to use it properly." Explicit errors are always better, it removes
> > ambiguity and creates cleaner and less error prone code. I'm happy to
> > change it to start with ~0 as well to add the extra protection, but
> > explicit errors are always best. Thanks,
>
> Look at all the places ERR_PTR() gets used.
> An in-band error indication gives better code and is probably less buggy!
>

...ERR_PTR would be fine too? I'm arguing for explicit return values,
not "0 means failure". But I don't care enough to argue, I'm
respinning. Thanks,

Josef
