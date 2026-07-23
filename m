Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A93CBE6D
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789301; cv=pass; b=gnnf+bgIEM4g3cfD/btVHo1/ukOK0KmauY3bWzHDYxjq7Tj2Ixf+lSvxg2gGbGcPD3pIo37IANp5z6vu0bZu6ItzAA2QDavhOQqaIq8HkJWvFgbAp91h0erGzlw7z7hLFJvJKDfNfUUypRrZ+WsE8+S8naNau+EaheSgJAzp5xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789301; c=relaxed/simple;
	bh=4c3hYEcHpyqPmegtbKtV7D8WgaaAL1Hn5tKhB9WAczE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8PfmVfv/yQMcYHnD8Ut3etcokCWFlEFFj1UrRMsYsnTdxLNlt3bJn6+ufzd0U0CFL3B0hhv9rNOYchjgllrfTmMtuEq2NneOhK+IFsW+K+rt8pq6SwLT4fVxqnUVAkavkRBwikSxvxTTg92vKD7JgazvD5emm5Fbw7mO0WLZzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIEDlx3D; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIEDlx3D"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfa429aa6so1166301cf.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 23:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784789298; cv=none;
        d=google.com; s=arc-20260327;
        b=HIrqP1ueQAPwDgqEKJqvPsDVyVxR9MGYwbvET3EKRd5IBNr5OK+e9dkHJZrh1lbV4E
         7G8JIFOQXSA7xikGYhHGPQn3zv/Fsfl15idXbFHI2/o9QrAycZL74mfXv2tsNiVtcFF9
         wLBDDldl3mK1ClCfw5nsl6LZm7yrMzluL9vvr18PCIQSezoSOLo+UVGbr2egs59AB6fP
         uNTVKT4P/6F4vpQAJhbT0hzkR7GF9pRfF5GFVLn7ymUQdEafcdfoHLpFOCw2iL6SYB6Z
         1FHhOfd/G0NDHKgQ/qoFaFlPWsP1CxQTBAbJxuSKf942YwWq1kKuynELHkw9atZTmM6G
         53ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fopt4fHG6AZ8ylrJsUtfBCilhZJrwdqtqno3S8Vh420=;
        fh=097hxZa6Q531Vxep85A19v3J3rMoCG6S0uz/jNX+wrQ=;
        b=EWjC1UPh30F9jsQ2sOX26t3Pv3msuT9xA+Hw+LnxEOkL/6hyTHyv1fxW2e9BZsDm8Y
         ZWcZ6rk2p6kuEra00HSaZSlRWZGv1hzdE89699O/Y1PSMU6ygDs4wlbe9DYe3OcWeIZg
         +Iv/62CbSh1het2xHYsoIj2J4l0oBNYmJ4ajZgR1ht/Cw33CAM/ZnQX7fkT2Tb12bNH0
         BQOc0c/5Ah9qayEamZqqmELBBMqfBSdJddbGJUGaxnqputb941FkuZ7hpu9kgEkdZ9Vd
         xKNOa40F+GG1WfzsgDmlwQ3SOQbdBwKOZi4Z8R/UDqYORtxDRvHOD4KANGXXkT0M+5Cm
         StcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784789298; x=1785394098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fopt4fHG6AZ8ylrJsUtfBCilhZJrwdqtqno3S8Vh420=;
        b=SIEDlx3DgmAi6WhptnT0MjczshdWCyyjJeERZbmF4Yz+Z+TlJLzBhO02GWPmLRoOfu
         4/OFPmvoTH6odaTETpuecDSvVCAixS1tRUbcytuWg2YUkI9YP5XP6nj/gTjFopB6YXYa
         jqv+LPm0EyXHGopL8uQDycQdVMSmGINfhUeVaT5nAjn2HU1qcA1THPmdM1Hy6/NLjEzR
         6LYFzcJ76YbB3dxsRJiQPIRYfd1kUD36TC6NnV8bb8SUPXvORnNK0dthvJz2IBRUH4IS
         UrPB+r1zBhi61C1asGvaoRRCU4yTcfv+/DCAHtlvRvlIK/bcHPG1NXiwBglOCu1dJc+G
         ticA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784789298; x=1785394098;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fopt4fHG6AZ8ylrJsUtfBCilhZJrwdqtqno3S8Vh420=;
        b=aFk5lJVY9VDqfhkqRa15nGqX2wC2DI0FE5oEUd59QwbBYuf3aL6W7b3x5e9fW/iDZD
         kEXr7xdfykfeFOPlgdUyVr2a7yuoQ1ZKFXzPPFTXDyuWwS57kCb23Q4B7R4gz+R1OE1w
         zH9GFClcAOaMulr4PLcCLZW3RGEFdnmcCmIEfYFQJoxsCVFKHX8Hezo1coRtCHBhdGon
         7qzEZL8jId7t7NG9F32V0i5wyIQSO6wBa6nnX0ta5BZ2SWeWSl7zaqPtmHtc9kifsFCp
         WD/c0eZXrbMKekyWh5jigmB2S/7G5T3ztqvzyLs3lvggTsi0MQAI0XOo++4yq1WopaYY
         KOHA==
X-Forwarded-Encrypted: i=1; AHgh+RpUaIgk6Mk1kHpqMo+N1EV6FVk0O5GwkCuSWPW7EKFKm+Xl/R5RwOKIBLv2iQ8JZNDA4pv2PjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69bimgJJSZLFKnP+IfYZNzxmS6DicaC7PhDJviYjdN38klCMf
	AoVy27cVWTzNd7wvqcD/BBpAtVgfhRRk/FWESdoLXHPv3/nqVovmIbJvKXDaiVuZ4r9z18TxPtd
	OrVqZXn40WqZfmK2nbMBuk5Ea5o3lvP78aI/XyMjM
X-Gm-Gg: AR+sD12zlVaYgUeOr3zQAdmDLgJ+F6D6nBEvLoGKV9lXar6lzZa7aA45wdxOz4y0KRR
	1u7qrFkk+8Cp7d3YdZtrmhgec1KM1pIW8cNuE4Z9B3OU88W4Qd+LtfCDL9ZzkXzOlwAfpFLqY7K
	XExk2dRPF7lUzWsGIZJ9RoOUAhREugrP3WU9ULGjM90Q4l9SQHMkdL/XFCcjWUIuLKKJcrZ3UL+
	kuikrbSrqVfcEfUKD21M3LlVMbpFiF8GTMu/zGjF7mpjCDQJCz6posAYw2yDS+hZR2m5/OxPpnr
	53EHRDhxgeI5gtc/pR8AcNY8M7o/ELZjdcFUuEN2tlhasFs7FPeUSsSdGQmvxndEZMpWeeDFhfG
	gcv0nbw==
X-Received: by 2002:a05:622a:588f:b0:51c:7aa7:e0eb with SMTP id
 d75a77b69052e-5283ee29359mr11912951cf.40.1784789297090; Wed, 22 Jul 2026
 23:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722101605.2868548-1-edumazet@google.com> <b16aec0f-a90f-4132-820e-239ddadbe8f0@linux.dev>
In-Reply-To: <b16aec0f-a90f-4132-820e-239ddadbe8f0@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jul 2026 08:48:06 +0200
X-Gm-Features: AUfX_mzfwjmTNyJFDDWM3usED32OxNE4Kw8gwv9kJEeTjMZwSCqsswLX5fagY3Y
Message-ID: <CANn89i+E=JBRGj3cK+6mfVEX+PUjYrpkkWk1dB3VswnW4X_KGw@mail.gmail.com>
Subject: Re: [PATCH net] ppp: annotate data races in ppp_generic
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	linux-ppp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 8:24=E2=80=AFAM Qingfang Deng <qingfang.deng@linux.=
dev> wrote:
>
> Hi,
>
> On 2026/7/22 18:16, Eric Dumazet wrote:
> > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generi=
c.c
> > index ef54e0a0462a175bb989db8dda895e9ae755965f..cacc4c3a37d2cda0aea2e17=
6e5d0638f959e18a3 100644
> > --- a/drivers/net/ppp/ppp_generic.c
> > +++ b/drivers/net/ppp/ppp_generic.c
> > @@ -866,16 +870,16 @@ static long ppp_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
> >               break;
> >
> >       case PPPIOCGIDLE32:
> > -                idle32.xmit_idle =3D (jiffies - ppp->last_xmit) / HZ;
> > -                idle32.recv_idle =3D (jiffies - ppp->last_recv) / HZ;
> > -                if (copy_to_user(argp, &idle32, sizeof(idle32)))
> > +             idle32.xmit_idle =3D max(0L, (long)(jiffies - READ_ONCE(p=
pp->last_xmit))) / HZ;
> > +             idle32.recv_idle =3D max(0L, (long)(jiffies - READ_ONCE(p=
pp->last_recv))) / HZ;
> In the original code, the difference will wrap around on a 32-bit kernel
> with HZ=3D1000 if the session sits idle for 4,294,967.295 seconds
> (approximately 49.7 days). With this change, as the difference is cast
> to a long, it will be negative after 2,147,483.647 seconds
> (approximately 24.9 days) and then clamped to zero by max(), making the
> situation worse.

I do not think the code was ready to handle long idle sessions to begin wit=
h.

Can you elaborate on the 'worse' part, because I do not get it,

We perform a max(0L, delta) quite often in the kernel, in lockless contexts=
.

delta =3D jiffies - ppp->last_recv ; can be ~0UL if another cpu was able
to update last_recv to (jiffies+1).

We prefer in this case returning 0 instead of ~infinity.
