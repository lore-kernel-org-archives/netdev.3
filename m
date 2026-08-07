Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734A2147E5
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123034; cv=pass; b=pEi3a/VIOJJ8H2oUuJwLDuaaDGcVvQV3U7VH3z/y2GlKwN6Lhy3v0bY8z1UWgbFW4ttr08sv298YJqHzBj3onmGwlUwv2jwHFWF2prI1Jlp7msQ+Ji3G9TgXHUWfuMGNxQTZkMoQqNjdNdf87W6w2Q9sfCLv2eX1yG3PTQXRooE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123034; c=relaxed/simple;
	bh=i47WQ9GFeZllq7B/0YQcfrc/SYXGwZtoW9sPuaP9cCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBoDcAmY4iPB1f6j2vWmNz5p22aoVAbtVSKL8mgszf/HwZPW14qQj586tPxrkMYRN2+19kInsbFWnuThPZwamnJWvLb7qdI38Z1qSa0J92L02guSDRnSR/QttyZ9FpuCLquKpyawwcHBej2XdSAf35HRDyaS+Qhq53T7FuegAhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0HvmdmU; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0HvmdmU"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10ed63c0so1841cf.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786123032; cv=none;
        d=google.com; s=arc-20260327;
        b=QHPWP8fZXNW6ax5bUz7DNcOmOTc9p9RbgDV4T+G4/1mQl1QcMAenqcQJRjFqOhV0/+
         zbDHNWOnjRlVkvv9Bx4bLnZoED0AzVgtOR0zz1Wv8GHe4FItGcY+SQOnaJC0usKB3Oa5
         TphtA1GQU8WSiIinXrWo/qJM7Droq2JHsiSAaeyfjWTQrxky/Swe8w39Td7Wl2aOLh/N
         Ke4RI76PLDPu3BYq1p8nlcyaqMzM+fTuG8fAJSeyTVSSgAxylw/bkoV/19bLoq4L1sY3
         G8/GjVorUujSpial8xDbmQyiGSWpPu0Gr5BCWTB53on/wiKW99d0sfsfbum2ltIMPf1t
         XI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i47WQ9GFeZllq7B/0YQcfrc/SYXGwZtoW9sPuaP9cCI=;
        fh=/c6bgAoY88bpqpNSa//5zi9PjsTn/KvyT3Yu8w3SDGw=;
        b=TlSYJfuc32juvv9+0hGSMvZTvHkXOR0bYKIxeviFz/xQtB32WFKF//psqx/oeGA4y4
         QxWRTSS/zsQ+fgjEHCf0JvVvC3JHpK1wSChm9/yXf9pu/44ffwDL0oBW6uhd57Z4/Om4
         TGKCDroksNNgiPTpdkkO2+WAmH9HV+kNisua85CoAjfFCZDcoWw06JDyrPKBUSL018/U
         oOsbsKVDSHmDpW7cFF/Uvqa3AWsTe3/nqxYas9DmuohupVKLqpZDwf+jB9Gbt/43pYQa
         uchgMW9VhPqmNEkyTxfVE958c39awpusGzYief1zs2QEZfTIxrmJl2QXUQWnf1bbJ+Ha
         hgww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786123032; x=1786727832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i47WQ9GFeZllq7B/0YQcfrc/SYXGwZtoW9sPuaP9cCI=;
        b=h0HvmdmUfNAtTxJhUwmCywmKHyUxEBCpFJ4JAWXQ8zfwfHzABv5jXMs90MxW1x1OxH
         NEH49BDmZKFXJOsoe0oLxgje8n4MgCrnjh9ep2i2+rS9/j8Xo5IpGcNxQ5+SVPFbRGg0
         /M3lDctMEqkRIU7H2SFUcVOjpzWjTb4ckP2UVfNMYnCUvpG/DbSPonhGLtXXKBNtniXN
         kxVvsLeKLTcHGJAC/Mzda0LgqkRGfBfeeesHdlAurA0OxMzUWw64dQR4VmVe8kAZGSbM
         Rgk82Avj+ee1Y0DKIaoRqj1kK+pfs11+VravV56LixG24L5nNr8tpHJAKiVfalSzL+Ga
         Fq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786123032; x=1786727832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i47WQ9GFeZllq7B/0YQcfrc/SYXGwZtoW9sPuaP9cCI=;
        b=KB5INLk4Y+ugB5UtTSdPI0BN16VG569JgqA79IvIYkMoUTQExAWUsImrnJnIfVSsh4
         yLc4wrOOEkbVbzXpIxehWEboTMwFcVR2l94Nyokq0FOU25VyrqFy2taGcLkyWChCJgYJ
         SVTMxVpnt0NpUk7ajpjPIxGTPXZoKaaD+l3IpPoSIqm4pCcDZtFHdn9UJwd7HsYkPI9I
         2E/CUuRhzi2eDS/usXD9bFnaXOSKhaVqLy3KYjcoG2U0YidVln6eE5Us6zJEdDZuwTde
         2qzDcX3gZ57zlcYFY+xp+OKE/y5VnmodYXtFQwc9d/mc1UVc4nuPSm/x5t88DgRMPXZ1
         3nZA==
X-Gm-Message-State: AOJu0Yy79NBt/Zy5huQI6INEWCZr3npg1zkrL0Tqwq5Q8R5syVHr8vR2
	giUrECr8sm08prO0Bwc/FP9Pq5ioCsPqGsnQ9/ZyEspmKfy8YZfIN7spaS02psaLaDfShbO0RjZ
	+F3L8zStjktBZMbjBDf1F4SmB1ah5Z1d4zFefva96
X-Gm-Gg: AR+sD12kGLUJw0kmtkVzAHOy2oLk2Ue3/KumTuJBd3uvdAJojixsN1wW8HpHRzZZ93f
	QndFTuNCELl3U5i+4DdqGas0cSw9EzMpi5F7HUx+UTh1mtmyKBYpDqtdxK8v1CeycU/PthAPO2m
	2Ad7m02b0DFxWKxZeRF/cxAeC9E5TN2P0MY2Tg01+FPffiQUVe7kFd7CvB2owOmswkLouWUUQAx
	xDe5Owsvw/cdm0HTofml2XGVp731p8jOokWv/7hQ+m6M3Fq56zUgNnSBUxaW+jEywazCq/uTipa
	8Nb0UujOQyatpDXwlYbxaeVhF98wgYgUyirIMSf0V5B5Er4KqeHXXvI2UlLD82ZbdEH5bp9SFJo
	s
X-Received: by 2002:a05:622a:1e14:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-52d23c4d2c0mr38791cf.8.1786123031289; Fri, 07 Aug 2026 10:17:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807014437.36687-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260807014437.36687-1-jiayuan.chen@linux.dev>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 7 Aug 2026 13:16:52 -0400
X-Gm-Features: AUfX_mwXGuVekHWGc0LFWm7JQHzyrnpjaN4MWC4Yq1YFHtEsdI34AxyoM78qrn8
Message-ID: <CADVnQynLVAzSdOGmrc4NE2dMWsyj_J89_xCqQ-504G6fOa4vXQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix icsk_ack.ato bitfield overflow
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Morley <morleyd@google.com>, Yuchung Cheng <ycheng@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 9:45=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> On cross-region connections we observed delayed ACKs suddenly turning
> into immediate ACKs plus a TCP_MAX_QUICKACKS burst, as if the
> connection had just received its first data segment.
>
> Commit 95b9a87c6a6b ("tcp: record last received ipv6 flowlabel")
> squeezed icsk_ack.ato into 8 bits, sized for TCP_DELACK_MAX. But both
> writers still bound ato by icsk_rto, which can be well above 255
> jiffies, so the bitfield assignment silently wraps mod 256: repeated
> delack timer misses double ato up to icsk_rto, storing 320 as 64 and
> 256 as 0, and ato =3D=3D 0 is the "first data packet" sentinel in
> tcp_event_data_recv().
>
> Clamp both writers to TCP_DELACK_MAX, which the static_assert already
> guarantees to fit and tcp_send_delayed_ack() effectively caps ato at
> anyway.
>
> Fixes: 95b9a87c6a6b ("tcp: record last received ipv6 flowlabel")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks for the fix!

neal
