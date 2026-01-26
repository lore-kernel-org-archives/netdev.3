Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248326299
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769470656; cv=pass; b=lpmZlwJcpgLXa6NMun6W24pZe+HkzJkRbACZovbhgjzC32Kgn17gL9dAK0zniA1X0hGHEjAsIyrLh0OVwFvYW9VxOsOm53UMMDhRKwp7Hnlnahl8AhZUgPFeP9tMRgMl5lL3GO3BVIQj12nHi8HpXwB3kPSNMtOfST8/3SD7u7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769470656; c=relaxed/simple;
	bh=MpH5HfQqqOP4vgM6v8cVHc8HKf+ehzZ58Vny6IWtl9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPdiiRCAXLGY40sd/7h3hLUHzL5S3R4HNpjEOhHs/9JwyuSKMntoIQK56s+Ge6Qcl7HZw8kQKCwN2ENtjWgS+CLN2AiHkTBPdg1RsXLY6GcTl/CU2wqf3XVOH92DjP5qCcBPXE9EL/tCsNjo3cs2KFv/19lw/KBrjAVEgu4m3dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FnDNDkjp; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FnDNDkjp"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5f54d6b4047so3034726137.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769470654; cv=none;
        d=google.com; s=arc-20240605;
        b=a/m/7KnF9ZZNwgNSZ2spVjZUX6UmzyM9HPvRLRMuBWGQGGdJxZ9s+Pogd1Kx0D0a3g
         PMwjU8ZXyY4cm7wSSwwmqnIcDCE400hM7FAR54GW07b8VRyAyZbmnVVh3M+OW8QvQb3s
         3sy15Pr4q0RpMkZboGB3Lo/ed3sE2j+W7vJ1c+dCJBzuwhTvE8KqTIbK42Zq/GZZQhcF
         AvdWy/pg7zDGynuPfA3lkMGjnyzapGoS8HUma6R7pvCzf1OA62uMtP+YmEQ/MfFUDTIc
         jtzJK59hU7eYTgW9XoUJHnqvSrtwgXlg947ACzjXbCuuE9SZDERjEcbXVlap3ZZtt1uL
         bgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wV6g5Kunqs0fqAq5CF6kHS+zlhoiN8KJDdska3kpk28=;
        fh=S+f6avFf+T3+/lD7i7470lZiUwELamk31lmm9MUv4nw=;
        b=kbjff6nsHcqGDISh9k72lzCfyrkNaV5UYd94tKAJzF1omyNleyum36bnBwAZTWDb2M
         Hz19HnuvcrsnBDyUWCNz+F6y+uHYtB7lkWTz9kc8vuvVMq0ZNJiRQ7kA4pBXujvN7D6f
         ZW1+akAUoMjtDvgTNy5eqWutCH1+1UanPzS0d5VxUcDjia2QANNObRCoAJBspTaP/U51
         AnvkqVmMsy4keFCDMl3q6gKa0EARV4LJL2lrGckWjBZQhJF/I/4fUabL1EC2xo1zR/iJ
         2EmgZSa7MvMI6ZeNScOOXbgbbe+oGkE8EunMnEUG0OaO6Z+K6juZ3OIFeun7vJ2Nr95B
         1Bxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769470654; x=1770075454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV6g5Kunqs0fqAq5CF6kHS+zlhoiN8KJDdska3kpk28=;
        b=FnDNDkjp4G2izkd3SCPOGLvOa8oHonaY+qcs+TDDLuEqnB4SHwczV1tFxTn6lgiGGE
         2TNC9p8SZLOdNx5f1fK4zXO5hUkbqrw6Td+l/VUJ52Y4rip2KwKir4Z/hOmfUgBz/PEv
         ZFXoMU2jmepEpaAp/vT+dPN0Q7oQJPy2PihaUYMXZSVPRwnDgs4OH10XfrZ9Qu92tZCN
         7qyh1ug7bXfEfNGoTf+5+4CP44Altlxzel+c+QX0+oRlypX3wmceh65RaV3jAiLAk5fN
         4BJ/UgHemxHFzvgot2UtZAzqaPDgywMswCE4y8QY6fIUT0lb23bTr/zpqadFycZ0DSsd
         7Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769470654; x=1770075454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wV6g5Kunqs0fqAq5CF6kHS+zlhoiN8KJDdska3kpk28=;
        b=G2kGASiTOzprezznssIMMJglLnRGa990DoTRvPnnrdmQ2iUX1G0lPABuTWiRTozhTi
         7gDVxmsUKDqk06CT4qfS7ztzWpQCd3Zab2v6f9Q8pvQ5R9ZZLt3y+tZwR01H8JZnJZ47
         Xv8SxO83yx2BU0MLJAuGWchx+s72V67RapO68oSLRqtGvUsFSF0e28DcuJZCq/IIl8O7
         wu0iud013cdwIXbf4i4fzyjSPaQuHQ20m5H09N55VOIAgJtb5zdxrGW4pyF1pgJ/wA3x
         jHLytMPuCR/Y061gRymAO0jecfgfMciGkt7Yyyy8QEP8e9IbLe9qFHp1X7WhpJMuqBgh
         GXhQ==
X-Gm-Message-State: AOJu0Yxw+KstJU35VR9KZJvAh/PDoRlxc3KE2SPNqqePzLJnmPeBRlpD
	998X9j25/u4J/BsEgAvrgb6aQ3gwAtiLB4HRZHgOD2GJYn3JvQCP2B6OhJyCq5yzhkk6AhbSgp4
	uoxIYmPlvEXyXHbBXWJsZUNSp2auIURnq3/rqjFBDcg==
X-Gm-Gg: AZuq6aLlQ3r2PnuJcGEpWWvr0bREl0Cnh2Pw1CH6Y25g9RBizZPijbb45EOTQx7fI/A
	k4fasBc/MfxNLiABmytZkSrAXZe4YuX/K0ZmJKwK0DbywCcZlNI8fq1tDUFgWEHA8EiryoC05aS
	4KJ59yrHbyzsSCreUJZP3g4u+9xtNA3T+7oDcvosvRQQhKAmhuXhHaAxr8zD2Yagfgp2nSgWZlM
	OH3WoSVdzXKiBs+wPbWsndolg/Lcj4/efMKWbT89Tb+Veo9J1EM/5Put8F0M+seid4gP4U=
X-Received: by 2002:a05:6102:1614:b0:5db:cec7:810b with SMTP id
 ada2fe7eead31-5f7237aaf4bmr279443137.29.1769470653975; Mon, 26 Jan 2026
 15:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121215727.3994324-1-rjethwani@purestorage.com>
 <58fe1908-48de-4bca-ad4e-4976d24581e6@gmail.com> <CAKaoeS2Jnaekdx2dXfBV91LhbaLU6SenBRkNqmRB3-1EhSCbYg@mail.gmail.com>
 <CAKaoeS1Ykr9E0URiasMy9j0Jw6R7AbXLbSgMV=KHyfrCakp48w@mail.gmail.com>
In-Reply-To: <CAKaoeS1Ykr9E0URiasMy9j0Jw6R7AbXLbSgMV=KHyfrCakp48w@mail.gmail.com>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Mon, 26 Jan 2026 15:37:23 -0800
X-Gm-Features: AZwV_QjYVkpXTDSM_c6DOMx7V_svIs4qvK_f_ZJTtiJfphGGjmK0h3bidbpZzrw
Message-ID: <CAKaoeS0ngukLaNKT8q6zsykRbFARTDw-QZgbrk7gjnE_Bf9Xcg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] tls: Add TLS 1.3 hardware offload support
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 11:05=E2=80=AFAM Rishikesh Jethwani
<rjethwani@purestorage.com> wrote:
>
> On Thu, Jan 22, 2026 at 11:22=E2=80=AFAM Rishikesh Jethwani
> <rjethwani@purestorage.com> wrote:
> >
> > > Hi Rishikesh,
> > >
> > > This version doesn't compile for us.
> > > A few comments that we wanted to share on V3, but I'll share here as
> > > this is the latest:
> > >
> > > We tested V3 and a few issues were spotted.
> > > We did not debug them though...
> > >
> > > We run a server/client test with nginx and wrk.
> > >
> > > a.
> > > When requesting 128-bit key, ss output shows "cipher: aes-gcm-256" fo=
r
> > > the respective connection.
> > > For TLS 1.2 it works fine.
> > >
> > > b.
> > > On the wrk side, the mlx5 rx_tls_ctx did not increase (meaning no
> > > offloaded connections were opened). It works fine on the nginx side
> > > however...
> > > For TLS 1.2 it works fine.
> > >
> > > We can share more info if needed.
> > >
> > > Regards,
> > > Tariq
> > >
> > Hi Tariq,
> >
> > I have fixed the typo leading to compile errors in V5.
> > Could you please share more info. about the setup and test, so that I
> > can try to reproduce the issue?
> >
> > Thanks,
> > Rishikesh
>
> HI Tariq,
>
> Did you run SW TLS 1.3 in your environment?

Hi Tariq,

I tested TLS 1.3 hardware offload with nginx and wrk. The ss output
shows the correct cipher, and hardware counters confirm TX/RX offload
is working as expected.

AES-256-GCM:
nginx.conf:
    ssl_protocols TLSv1.3;
    ssl_conf_command Ciphersuites TLS_AES_256_GCM_SHA384;
    ssl_conf_command Options KTLS;

# ss -tnei 'sport =3D :16443 or dport =3D :16443' | grep -i cipher
version: 1.3 cipher: aes-gcm-256


AES-128-GCM:
nginx.conf:
    ssl_protocols TLSv1.3;
    ssl_conf_command Ciphersuites TLS_AES_128_GCM_SHA256;
    ssl_conf_command Options KTLS;

# ss -tnei 'sport =3D :16443 or dport =3D :16443' | grep -i cipher
version: 1.3 cipher: aes-gcm-128

Both ciphers report correctly. I suspect there may be a configuration
issue on your setup. Let me know if you need help debugging.

Regards,
Rishikesh
