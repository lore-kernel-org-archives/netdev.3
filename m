Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1323DDAE0
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416144; cv=pass; b=GXkDe8V2/EVmg+46L/D+egfd8RRHKJ6cmexcTEgROHoeSAlu++EW1+7ck+BnAisyXWTR6ynEbe5RBJzYAzjdW+izdftCL/CS0gLvJ1L+l2G4lhu+3l59KFywHVKKopFBSZbCFzBXJYyO1zOabWE9SfilPN4BPyf3ptc3+843624=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416144; c=relaxed/simple;
	bh=3krlvESeTeqW1LbTGBHOjP5Xw2Leu/UdOwvAxLOMU1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkoErItFwluaT78l7bCEj93+maqu1I1YXod807rWNXYvQL3ydaCTqYIYvmIDG4hgz5/X1GhxiwfnudWnNsAvEsxcvjyn2vMri/Y8Lt1JstRWgLF4B6I/7xgmXopfzAz/ey03rHWt5gxD7lFLp5TH+Egh1icUVWj5uE5X37Y3L2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qYpOUq7C; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYpOUq7C"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530fa0716f6so19413751cf.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 02:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790416141; cv=none;
        d=google.com; s=arc-20260327;
        b=XOZ63hLt/RbXLeaN/ez5wobh3JlUQV8JxMGsBSgwYE7TxTJWNO/sO54ZUlR/UDaf75
         02veUiBIe8bIYvL4tqB80ohIZwpqPn9jR0iz/7Vawr87NFclAguP45ZM/WPSJpbdkr7B
         k+L/WkCkd2w4xGh/FxeeGoHZkBfzajB98PEqZd6DsMJgcbIf6xPfocWP6icG1er13HDy
         oTEydXFk76Xh6fqdttjNJsjvuQtlXS22LtxFcr3UsS+fSVz7jr50eVJ4xXnS4eB/rv/N
         PMWgQ7WY1TbXpTQiGZ0Ip8rUO2ZlxB2T/8t/vtBFDohFpDY3NdcegsZQjknhC12VJszE
         /GOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VJHCiEE6B7SORIu1DmvPEaacqHWzUP/kLOJfzWbkTTc=;
        fh=Axf+vK9fvVdJ3cWk9wJbfsFotuhnqBG57tV3qUVWNC0=;
        b=HUzWPGRdwXqDKFqINmzqk/0dAP1+EzAh1TxCKGOM4HI+Z6GIB9LBUuC1WE+KcQl3fp
         HECug7X7+UuOQHGNDRYiJUc7yMKXQkErVHbZdph8beXr1STYlzFZ90malwTy0j/YVkKZ
         MntSJCF1iVgLsiDKh3Le0wupmyplMqFod7+O3GJZhLsfk7X7uYeTwbHjiX9/iH2wi+/8
         iCqvWuH7zcPXUiHZm1/a3WXfe4r5gJVNvqfay3n89LPKlakFttIfmw0RgjTJmYTuTHbq
         ABp774hUaJuGOhYdCxyic8u7bDoGNCikgGPlDv4ctS9QEMMzwG7nMB1HasLs1p7mkKTl
         kR7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790416141; x=1791020941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VJHCiEE6B7SORIu1DmvPEaacqHWzUP/kLOJfzWbkTTc=;
        b=qYpOUq7CKL5zhhKR6zYOzVLlYn5NSAM7ivtJ0CEqQO88Nw/ArDNqBvKqk3+CRgRbKb
         yI3gKQ0mxdPEEJqnIDbb5ZNQCeL1cM3OfNp2tHmAsVuCa4Cw79A/UqwtLF1fRxZ32DHB
         26ZFG23K1Q8Pre+1OzidzpnpFEMlIBNzYOSoNND9Aef22DlfPC74D+QlY+bA/Run5B3Y
         Ngvpvkk7ZtE4NkXRv/K6V3JIgPoq2VEusHAP4kpjandc7jd8hOgEv0G31Q3/AihBQfAn
         0tKTEFm+4zG22m0JfRyptoa5XIbzg1ExgTAw57MGK9+PQ4rFq2kD+ykGK85mghHMUPov
         Z4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790416141; x=1791020941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VJHCiEE6B7SORIu1DmvPEaacqHWzUP/kLOJfzWbkTTc=;
        b=A59YcO01goi606z5PJg6qDwaLsm5TTY49zFcBohmojF+Myw68zXYO2BnbWp7ahCfFj
         2AOt5Vs8P0/uRj/jwd2Am3QjUfHK7Dg+YXr7wm/6OVY9vHY/Na5eyrhM7/nkdxdEPDSK
         1XLyARKp3n+zyhqyr8RsKPxVGaeae9pM6kFMXkWSavA/64Uh94Z0JeIgixfBikUHiZut
         0AxiNXy0qvALfy36W5w3moylQLflf0I9dZvP1oHnxPjqrpd1jgQtEMiOk+izU977yrCZ
         HO75YYpuj5jeedtHoIBghzhyFUNG7mp5dXruIXDDIRyOeghImvVweyU8X5vtn5sbnEK7
         /tpg==
X-Forwarded-Encrypted: i=1; AKwUvByJAQ7+QG8uHREnb9yUv3oJmUoNKJNziB6qF5nx+9R2CWZg8gTAsFYGZhfF81+XnEdI6IM3iTQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mQ5BFefahpcW+TXYH4b4/2WnhPaMF3m6bDdKWVvKNTNxBUTTGs
	T4JfFNWSqCY8DwcMd7Rl8a5jRK38Xw8hqTUBN9y6UVz5/TClidnWqB4kA8qmg21qtCFhkl+LGpU
	pcw2FwXzvU6AnzPPhnWUdluxUrpvjFd8r/UlX/zQd
X-Gm-Gg: AYBFou3VAh7RBRS/ZEro+aJqkJWSLfDelbo5I59JACfZctzuvzeRrwSbpJBxaxxBX0h
	A1FtmH7AEH7GrcNH3ZyWd6AKtPgWADPe8jgoRTok9z0wiayZMAUSQWTYfdxXXNo728ASX4DJeUN
	Kp+HzThiTipsVPaZcSPLYfNYXmGZjntlfKOrPZu3KBGy5IEgeHCD+oV/A8IMS7yHpK824aOvQU7
	7eELMKRm3awn1jojm0J8mNJVLwwGUE3xIvsh0dpB0VcVHZsZrstIucDeDZ33hIsA4UPKtbUr37w
	PN+FAei9nM1xi0YGN404qjfxb5d2YeKFVnLN6++HwXtVrdRo7hqleUKS7pnGZi3UzolYZPUfQqy
	lkrB6zjs72zjmUgcCXYUb5ii6VFQ5rOPYAk/wysOuWmE38+ZCFc/64epPRFbybc8Cr7Fp
X-Received: by 2002:a05:622a:6817:10b0:533:2042:d2cf with SMTP id
 d75a77b69052e-5332042d7bemr26218071cf.25.1790416140592; Sat, 26 Sep 2026
 02:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v1.20260922092618@mojatatu.com> <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
 <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
 <CANn89iL3jBMczB4txC4oDusfpDoem-wdTOFVrujTbC0ArNhGqQ@mail.gmail.com>
 <68BE1514-828D-4184-84E4-90F2EB3F035D@gmx.de> <CANn89iJtHuwybsSLy32GzH2c9cGmP1bL7ardxPjxPOj2xGLZPA@mail.gmail.com>
 <67EA1744-69D7-4A64-9117-D6A79A3A93E4@gmx.de> <CAAFAkD_U8PGfdJAgSLsh3ku+tTBvQYB012k7jEUacfm6HothyQ@mail.gmail.com>
In-Reply-To: <CAAFAkD_U8PGfdJAgSLsh3ku+tTBvQYB012k7jEUacfm6HothyQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 26 Sep 2026 11:48:49 +0200
X-Gm-Features: AclHuK_w1FQlChQEGY0IuXMjVYw96kNJy13bxK2p1kNzk_pT6EmrMxUFQIqXDeo
Message-ID: <CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com>
Subject: Re: [Cake] [PATCH net-next] net/sched: fq_codel, cake: widen backlogs
 to u64
To: Jamal Hadi Salim <hadi@mojatatu.com>
Cc: Sebastian Moeller <moeller0@gmx.de>, Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	cake@lists.bufferbloat.net, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 11:43=E2=80=AFAM Jamal Hadi Salim <hadi@mojatatu.co=
m> wrote:
> I am working on a v2 that drops at enqueue once the accounted backlog
> crosses  (U32_MAX - QDISC_PKT_LEN_MAX), so no counter can wrap.
> That is Eric's original suggestion which preserves the point you raised.
>
> While looking at this closely for this update i noticed more qdiscs
> which for different reasons also suffer from ((u64)backlog + len <=3D
> limit idiom.
> So far it's clear from bfifo, gred and plug are the only ones safe
> because their limit is in bytes (as opposed to others which are packet
> counting)
>
> Eric: Unless i hear otherwise from you, the configurable byte ceiling
> you mentioned (a good noun seems to be CONFIG_NET_SCH_BACKLOG_CEILING)
> is a follow-up;

SGTM, thanks Jamal.
