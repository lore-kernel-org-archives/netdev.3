Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792680626;
	b=UYc+8h7hYSPTLC6ByKJNV2SktgCGbdmhhaH+QeUpBC1ngKjkxSP/PzS/GCQqdPNwlbj+
	 GtN8uOs5HWDlFhLDAiCL1F6PzwvPKU7whtpVFUJ/SyaSjeSeUEapGGKonfpwqpuhpQa4u
	 LjrCXc14sHsigaFCZY+5ZtH658mmcVfmVB+0T7HjAuVJccNpH/+EB8J7mzsU8i32TEPT4
	 Cr+wKna0vnUkVxP0xIaTeqsyCEKj6h2hz9SFw7CeokzfgQjlisum9Inl6PjDDfeCG/e1j
	 KrLViROA8QIfcEo+pgdBCDnSadnhINA+HLuYhz+vMkFPbk/sXSy0d9faDY5wNEE0n3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fTPl7nX2j8f1ccT/JaBHrgE1Z1eaSsJiiHGLZJRZflE=;
	b=JHhtO8XeAz3Ur6vSCWUQYC+CO0yvGRwtjCYdXq6kwfuJfqGhsXC/QOZcJUJNwD/FRWoU
	 oW54dxlYHuRJq+dJhQBKmILnd3uV8ouwiscRAllHmMmFDAwq0HRm7YVz3RJb8R5dx1TXF
	 Kd0/9R3eTu/NzNYMoPJezUeiNXprEf3skHVPXGZIVET+YMN+mcqcmzpgasSg0rr3sbEup
	 tCGiURctIASjSyuCzYkCDhj8LJ1qQvkDcntmJN/k7/M4CAuIZXDNHS/uInNIME7qLZMPg
	 ccJjHYVVR04w1IhY3Cbpv9lg0Ctq+L+PJONAKNWbm1SuwSePwJSuST1PA1EeGr2KhCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="h7+rpi/a";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267AE606A329
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267AE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=h7+rpi/a
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso11606a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 07:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792680624; cv=none;
        d=google.com; s=arc-20260327;
        b=F0QCCN+NvCwUAAjNLjYCgRcufNjupuAW2u0RNqnEjET0yu+INjrE1mEN0gvTEiL5TT
         ylWglYhHsQSBzIZXV4vYFOpblGhEd4NuRVzocseP3wSRvamLuGBjbFzpiDhdoS50FMUt
         bDa6xgGubjFHI+4EgxUHQ85AiGY+KKrmG2mZJkj3OTwDBc0zr63lDfeCAyENlC3yN2VH
         fGRTgsZXZJtiMg4akXtd1CszWqIQh11/3CQof3938AFOzCvlK/0RP85pRQrDVhML4awD
         bFVZ7Jaa6mk0lTtUVp8HpPtXYIvsLJPxUpOAewHn7EdfrVyGpCDpX62jtru9ltCvOlNP
         RR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fTPl7nX2j8f1ccT/JaBHrgE1Z1eaSsJiiHGLZJRZflE=;
        fh=9Cx8LedUGEK8DViS1cd9NEHn5HbOVlN+eanI4iOTUF0=;
        b=HICRVhdfkT5sfnWxCWfkN82ebchXnwNiujUMaFdSvFd5gNTivuLg88zYlRo5vABiZ1
         PrQNaCuh+0pC/8+MeUKYiMZfNKLruLFJcNXDQhmmPKnB4X/+N++0b282dsz09e9hI2CR
         2wxWoM1NaoiBIX6QWVNLU8E6A02HzFizb+6JKRGqVdWx54Ynz1lz8pmEHeSJcLwNNanW
         Se7pf1IWnVlYAbOSnMZhO/nzbzTXHMRTllYc0vvJF/x46oen0maZTHbPyvfw+poexJli
         b6z5YVAL7MbxX/HwHJiYQ7ihYrkPyh5xgWA7fCwJeV8gYATvEz7eARAn4+IMTd0P+Kp/
         Mn3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792680624; x=1793285424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fTPl7nX2j8f1ccT/JaBHrgE1Z1eaSsJiiHGLZJRZflE=;
        b=h7+rpi/aL3Z0vsNXi5TLNo8MUFo5yPvsjz3SnBlOd7KqX7GgB6hE9A/K90auQGbEfR
         iEYnQoJf+uHDsbPJD0JsT8mhXuWOtfflCW/54aN8FZpjE3NrKasq/FtnFHm/L/ZYE613
         BAgzJp9hPm9Ll8/d1sy/Ott2VrB6hEwO4/dVzWF/++baeUPw/EY42HUx6k+KjkLpg7Yi
         ZXCj1wE4ESLcr/sH3laEcv5UYzgO7+4iVlTPUQyz13rAMCXFUZxXrQDPY7HwA0EVxSXQ
         /dCi7KDfqUsbHRWEz2Oz+ruHFZNccU3loQpTbEfppOiO0j4MA2yILF7uHvEofv75V+n8
         izrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680624; x=1793285424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fTPl7nX2j8f1ccT/JaBHrgE1Z1eaSsJiiHGLZJRZflE=;
        b=OpPpAZHvR4yhcrtMpKRLSpSPKLoBG9Lw2KYqVSbDwZaOMgELiPcWSiTzzZDAcnOd0W
         6zcuaKqOBLOyRwZ2QEsBMZXEs8M/fXZ516JVQI2qGk49kCDiLoKDnAGco+XRahuIRCey
         JUEVRAJNydfqpE239iOt1im2cauPA8jg+l4QaG08P7C62zHSMmSP3GWbO7rWJ8XW2Mo5
         OE4WTWADUTWmKpDUK3GL1+lQUwZoSJmJBFj+V/2dmVBd2y3YtiJqnGMC9oOqq8+J4gTI
         CnmiJoSd5Nq25MKu8OTi3JLv0m949Oi6M9PPkJGyoy1Z5aI264JvvvzmKg7mOIp+TYSC
         df3Q==
X-Gm-Message-State: AFq9FYL/Um0xJfEZ7ySF8QG7jcpYOGpQW+t0UcjjDs88xBrBG7vjXo79
	hgMV8fC5wlbsfKa1dkOh0yq1b/r0GzWaycomLgUjej/84vRG6bS6ZaKfESeiNExbxBR0nJNJ39M
	Q+8hcTEI77GH4L8T9at22EZ5M7R8sB0VpoIhHps5T
X-Gm-Gg: AYBFou2CzY9PAfUpKLsnHSYC7G89j2sKFCatgrkVdtLpf8ouw5NfqUQ5TLGJgltXftD
	A3kpUtyPOwLIEObKduZj2tEQg5V2idLxxwZl6frf4h1g5WaB7lKLPl72U4pAo7IIF/Oikhbzuts
	61gMv4lazwPrU7igxmMsIgFRHxSvYR1/Z+1Ypfi+peAFcOb3+0++fh0bUGaPKQxnmmvWI6LjnIh
	Gz1MDOa03Uwa2UvWlAuQvMPn9zu8KhWBCCdrlOBxsbESFoJpt/27huhx/k0SV06dnGR5l5U7MGr
	NVWSvdCStG+xF+QMsUIMG3YpYPYN2l+8yFTvJGRewdp4ewei32Qy/li/e+FMpyxHjhqE1q8h3ji
	sqih7Ix6odNiYErYsUJQMH0LjR7XgBYLDF2kx4fDJkOcxYKBdgqutZlgx1yA2iomcQQ4RSYO0eF
	Hw2HNdcAHRyXdiOBH0oM7rSzciRkB5lS+PlpV24NX/XSe2JMWz
X-Received: by 2002:a05:6402:a54c:10b0:6b3:f12d:7405 with SMTP id
 4fb4d7f45d1cf-6b42036d21fmr48386a12.14.1792680623946; Thu, 22 Oct 2026
 07:50:23 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com> <f97b13ca-90b2-4bac-91bb-70c9d26095f9@linux.dev>
In-Reply-To: <f97b13ca-90b2-4bac-91bb-70c9d26095f9@linux.dev>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 22 Oct 2026 10:50:01 -0400
X-Gm-Features: AclHuK-6EcHqcPlmvEXPLfwRmauh9ZbMdTBp1Y9Jf-G-MgNT2rEI-Eq-Myoux3M
Message-ID: <CADVnQymQ_DDEijpjL1ubo-Oh8SLUTKM+-BY4-5c_U5Q6f0mbXw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: limit tcp_tso_rtt_log to a valid shift count
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 8:51=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
...
> > --- a/net/ipv4/sysctl_net_ipv4.c
> > +++ b/net/ipv4/sysctl_net_ipv4.c
...
> > @@ -778,6 +779,7 @@ static const struct ctl_table ipv4_net_table[] =3D =
{
> >               .maxlen         =3D sizeof(u8),
> >               .mode           =3D 0644,
> >               .proc_handler   =3D proc_dou8vec_minmax,
> > +             .extra2         =3D &tcp_tso_rtt_log_max,
> >       },
> >       {
> >               .procname       =3D "ip_early_demux",
>
>
> Wait a minute, is my tree too old, or did you land tcp_tso_rtt_log_max
> in the wrong place?
>
> It looks like you are adding it to the ip_dynaddr entry.

Agreed. It seems the patch adds the new line in the wrong place.

neal
