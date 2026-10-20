Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792464168;
	b=F7Q/KtaQQsyl+5oqu2tuEvgxpl2CyVCoX7mcC50CV4KkFHb8BgszC/WMJn586u83Db+c
	 1sA0I2tjQpBpXRciGsitl096mxa7FnU0T4XjzQsEOecX4vIcJQtaZoKOaWFQLTIK1YECt
	 v+pssxjUkEORI85nNECgLIEqfy0uWDlGkc7X/eyKFQY7EUSWbkpnADLpH5AjnL9NQr7+c
	 HJl6eH8Qtxg+UBBG/dQu5NCu0YURJVU3pQ5OXQin/cWX9qeoxd9UnaKf5YsZtA1p/s7vB
	 2qa+IDs+BAnG9nvsMszRcaRwPVCeWTdon18nk8LGDSFgEt59Dv5ApKzHM6mOcdBVNnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8OYBYLm+3KIQaLQWB50G+yMGf6VXI81nazyohmh2FJM=;
	b=yd4IVHJJyaRqkI6dUd5yQr8j++VRrtSCLAi+VCLJLin8ruT2sdpmO1YpbvagceQCjUFj
	 A1lxI5BTlmy3BPbH50VOTa266oYOiRo58OmgjSN/zGELmXin66jup3PMxxnFWxRTdG7So
	 0FuzeUrFDKU1/NfmtQGFqTt3/xyDmgP0mSYsEE/LPnWHQjvCIbBnMAVrsuUMLEfWZMkrh
	 RBn8EI1rPIGDmrBmFoR1hK1CjCUAPnWLfD8SaUJnOH48BlSL23IySUHLDB3MIhdb1d3M8
	 qlNDvgi0/LU7VXk1Dbv6eHdk4xtJFImAFnq/36iV0PV41/DNavT97yVAb9NmXWQ1OfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kjcm+Odz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212A606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1212A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kjcm+Odz
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-486f013db83so916702fac.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 19:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792464167; cv=none;
        d=google.com; s=arc-20260327;
        b=W7NFZoS8kLTSFqa+Ql0iyz5xdCqg2T+Cxx14Kh7lfWK2Ybvwd5wHTSOQInxgtEvVZ9
         4i4g40EmbcP4gUG0DHdjAlUx7I0ohN7Zfflak0eDCS8T+0S+vmJw0wIrLPW1Xh7NgTY5
         NtwBi+PFkl2Oy9T5n9HiHzqFAR8jAaAA1UVeeBRHttlIyjLj5qA9C6nTtVv/WyDCI1jY
         33PepPuAw5Q0hONXpvGstt58RLfCmS7HvN7qphV1Ddcl5jF6Mbmumuptp+eVeEegwExa
         pRFtvLFyeoCG2VGwT/HsbGJJU+DCrudx+AuSPrz0slHWdZiQFREOkgAnlN9wZWAk+hwj
         WVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8OYBYLm+3KIQaLQWB50G+yMGf6VXI81nazyohmh2FJM=;
        fh=cl4WukvAj07XA3erRX6oFt+ghX0ll2iYUtWgxr8EVeI=;
        b=XOMHibCsKOqtDupKcjCID9z1WRqDSpRMpW4Pbm2Z1exUQ3q9zseCmbPscNi6dzpT8l
         2EDrxl4ayCQhdOnpnjGZ0OjwdeG1X6blP3dbUldvkvUBonQxN52CT31GXdgd0vLcUtf9
         V18H4jgHxZ45sWoGkWeBoPGLDgCpqgKPbrvx38pqmtcARxAdK2gSXxU0+9na9vX4KOD2
         ZgmtDgrhgWzhfDcuASgyqZC5ToJTkD6u/a5VBVaIvtXU2Cmk+T/hVo3obCnt3PLnFh6D
         RkdYRrBISeVNFUhN37ML2rKkjuvJzyfg4fbMnBZJLs0oIOwaf2Y/kd2947WPSfiZQrSh
         1VQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792464167; x=1793068967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8OYBYLm+3KIQaLQWB50G+yMGf6VXI81nazyohmh2FJM=;
        b=kjcm+Odzv6zxqutyfnR50l9AiphFnUwJXezUB7Lw4Xo9T7q3daidTG8VfofH0p3c1d
         sZIJBAskARDPOuvNHgoB89/i1q4Fwbj6zcVT9OSm3QXzwsRtcF/cPg/qdpJYAO/4XJw5
         XUnhuwGLMRUbHWu9rUhfFKA/RnsgJ/jhBu72j1ca4NZQDOYdmWzdUrkUYptCRKbMLO7C
         dRif4RxMJeibshd+MB+f1X3q7hEBuqDFMIfxv0cC9nYDJ2dttxGXMWBpgro7PK4Xaj6f
         XW6CaXA3gRTmBx1lGImD2gel2u0dbLKQQdKqXWwlQlH+dW8/K6SM9jVoaBaD0D+9TUHj
         y6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792464167; x=1793068967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8OYBYLm+3KIQaLQWB50G+yMGf6VXI81nazyohmh2FJM=;
        b=ipQkE45fAVSDPROsFnmCGgnPCzKjjmAHz2dPc17V5kjiHPLiKafZIHZpUFEn0jIlFG
         I4OzixYNK372sFuCjikKFTcHpj5jPg825gex5W/d73HXWHigIOSUEXnbvNSv7v6CK7sM
         OoTSwJK5DgBgvSCyWlL80NIybN2PXoB78fi8CDv8hrsLfb28OrO1Xrj1Pft05xRBaMoj
         9Sj2AZFSVPOo3JdvuD4DssdynZI0XkKg6D9NBlt/RqOq4Riuwe1Kdp9H65Kfx0Zjz0mb
         kMcGjBSnyueUHZpS5ql7yEz+Lt+OKOTHS/rMrNXVLeRjnVq3hAnvwXC3c/PnTP/esB6I
         onVg==
X-Forwarded-Encrypted: i=1; AKwUvBxKTtzVrfX3fGM378ZYBMV4c2mr5bdqF9j7KSXOaYKlySGrrbJ5lhItLl9nxaxdOSthmWcMSiw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFYQCAuq6tg/p/FBZhL7e7JDK2mM2n5LqfbHtBo789c/T1KrRt
	CQOKh/k6U6yLGbzCwmkcV9YrlBZhcRebEjo8ZPx+y43cwOPsiSQnFrUjnC6PBKBQSGZnRqGKJpD
	eeRWz0thF3Pvu6SAvGt73qwKATl3e/PeVXIhZGZ0=
X-Gm-Gg: AYBFou3He5ZxOsrUIXTLC/oLf/Fa2m+4TnkIb9Ru5wJ1yU94AMTTn7plYV8I/vOguO6
	v3sng11lA9Xd6NbtkI7a0x6SuCHJlyJ9POyKAI8r81tW0VdBOJ8UuttWcgQT2EpWNelQ1xSsKga
	XNHP/onahc0x3g5xI0sb97U6JDJ55+3w5fhwTeUc7kwL9X8ybuTIs7efiGEPgOMDkT7WhkqfnCl
	Ra8T0Y6y4SPvJmIpOS+eqTfTDKwi5bimy+leQFAs7qaKBPHe+Ct/BFWPu61HSTtZOLIzehUSAmy
	An+vgxfHmPksVtl0D/+8I985WmhoU9vgV9w1DOj/+uhdG3f4rOSJ3+6D
X-Received: by 2002:a05:6871:e014:b0:475:a112:1270 with SMTP id
 586e51a60fabf-4a757a3d072mr7064152fac.29.1792464167002; Mon, 19 Oct 2026
 19:42:47 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016-wedfix-v5-0-8b02e78fd34f@gmail.com> <179214234859.408196.13768026652794039093@kernel.org>
In-Reply-To: <179214234859.408196.13768026652794039093@kernel.org>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Tue, 20 Oct 2026 10:42:36 +0800
X-Gm-Features: AclHuK_uSJLvIyJgGxf5INrqsdVDsAIH1iMF8upEY8ZK_RGHk9iIGwKJao2ZKNo
Message-ID: <CAHGaMk_gjN5v0HBQ8U-8FoS--nWCS-8j1M6LUSSma=rY6pYFKg@mail.gmail.com>
Subject: Re: [PATCH net v5 0/5] net: ethernet: mtk_wed: misc fixes
To: netdev-bot+sinfo@kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sujuan Chen <sujuan.chen@mediatek.com>, Rex Lu <rex.lu@mediatek.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 5:19=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Patch 1,2,3,5 were found by Sashiko

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

Patch 1 compiled test only since I don't have a WEDv3 board.

The rest were tested on a mt7986 + mt7916 board.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I will send a new revision addressing issues found by review.

Best regards,
Zhi-Jun

pw-bot: cr
