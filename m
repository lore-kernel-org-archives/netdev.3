Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D336AB6B
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616329; cv=pass; b=Naw4vXE5Wy4cWoXe38EqLYcgbnot035bQ6mB+F8Im1kkse+h7KtiRKbrUR2Pp/+JnU6m0MEKacGxsqnIWa7ZgX9ciMyY4gLx9y9Tyt35xVsQrQCx0ZLWaTZC/KbGpbHITI6LnkFWocQ5EUu5ksSVDFHllMYqk7K0GngWvIShQXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616329; c=relaxed/simple;
	bh=q6b2vnEW6gmgGqn37doa+1EHERmxuss61ucDoR9NBTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4V5UJTJMZ5yHiAxtGlJWdL4wctGsL5nWt/S6kZBXyGdTM3kki3Z23hDwGRSk2OrGCHi7LQkFsYZHNwO2RcAEmvxQxNidguhBfIw1Px5ZTvXyd3lMa+zgfwjUWpordup3IDRs7F9S7sLn2Bm8YIppiwryq/CwLpmH92HAsUAIzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVBkjAg1; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVBkjAg1"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b4afc8465eso2812475e87.2
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 06:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788616326; cv=none;
        d=google.com; s=arc-20260327;
        b=jkpGMn3TcyqfRmA6p17X4EVv9kiumFzMngtkrB0Qt+sqQAc6gWYKiirZacFLMph5I2
         3y+1uXotWuSYEHTYLZyISgTLT75qSrTdU3rWqXZFr16RS20jKyW7/+UVCTFleH6ncVFr
         Ny2SBN9zWXXXLuV3XhFOK191ShaSTGLDW0AaoITBsi4fZdXh/fl/SQMcs60YUVh48473
         1kecWqPfvo5/13yaTQZ5oCPmh7NVrCpkjYkFp/zsTUySA/ttHEsHkv0ZOiejTNjL+yTg
         7RtE9Wsb7L3abb3/dJIBAtDBPePEUUdLA10NY98caRVpzZGatrqcu973oxBQsOAGgGep
         Z//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FASFZHPkb88MmeM9l6XoukYHewl/de7+IodmZ3h6dzs=;
        fh=Z7w/W97xxTcK2qITGMaTImPBc2XXcuOf3uFU04G1vDM=;
        b=HY//62c0u/ikn/eKDm85C0RmAAM6Tm2AbknWXQyTbOB7TjZXezLj3VlhqwBkgCLk5P
         jWm5Dwb0zugJcbIMvdib1uW8gpf8iZNHLXwcP4uZ3sn5tRBVhGrV1RWUs7LGTcRlzgp2
         8XDiAWYDg5Dly7LM4KACfkF1q6+cVPvwr+w/WCBkSqoGpXWix3bRGMS1L2wg3xREk2r0
         btNqY2UoUHZjhOVVaBp8mDB/C+ugPnET5mjmd4td3/1jW6jnYW8MTWY6p3f8eY4Mdn2S
         iGMEp/HV4rD1Ou3WPlGhdBBUx3OWmBsvNkfm1h9UcAV0XLF6OAPRpTh7G+5J34+JRTaq
         00iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788616326; x=1789221126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FASFZHPkb88MmeM9l6XoukYHewl/de7+IodmZ3h6dzs=;
        b=kVBkjAg1SXUctcBAjLBZBgWU28FcBRSSLss5frvfB9x58FLCObnJgANxc0Ppcfcwde
         hvhv84Mo/9nNCE1pJcInv7Ts4rn/OaaubCbq4wPJyVGgc0RC47Y1CRTWkv5MrwdCAZ4N
         iFj7MEbyA7UxaIpxnU5Pngxvh5GXT7A8XHcUD5A2gNfDPaBlEbCitTKkBaEEjVUIOyNY
         vBIQZp6Fl7kPZexp2BsDxoSf15R7qTa3X6uAORsLc1dOnuQFNe91XZIoEQRJoBjbN2la
         AQ8rX1JvynYfQBu1WG5W+70EkNBB/0NRQ9d/GYgkcUIlNrXZOrvGhB2UfimXYCmnBD2B
         Czfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616326; x=1789221126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FASFZHPkb88MmeM9l6XoukYHewl/de7+IodmZ3h6dzs=;
        b=DBey4LdTQThGTN5Dq++0xlOxZreCgGDGWSn5viAl61AuZqbqn/ao+tntNTXWZNQasp
         V9TH6ocUZodddZzXiM/IibnFDV0Dtv1ZI9ytFvCLNksx9elhagF3aoS7ePg4B/t8KtZv
         4Zcgrb96AhZSVXjvOBXnVXkdpeE0fmAKnH2ehVpALHIcmIVhgaze4x7oFG2S+eEUUtJz
         F+4NYQ1CxxxVkVEmrbfOgLyPyMrt6Cl4ybLgcu3QoIUDiNTB66MzmLfPeQofweJ7sZJq
         4ucuNZEWd6ZlY5sbEqWT+b67pk5dX7znJxgf27DXplkPSn4OdoKZTTmFvQONP61/B66x
         iwEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsJvCryT5URZzQzmtmBY2OtKUKyz1RQXoREIZz8D5RlcnUvzkfLPGnwZnHFfFGb+Hb2zCjXZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++nRIKrTCCdOlxHKtvq0QtgnpBo3iEto4+7TTqe3yHfG838KywKD
	psLGtGBI6c6pCw4nuor1nd82sTVDnLwWI4OF5kpVDlQ9rrslBHFAVG2TGXSJ8sr4hssMljf1ZKe
	U+nExJo0byZjZO88ShKyHO0BfEmkbEQ0=
X-Gm-Gg: AYBFou2o9sCFxm98gXGMRO+vJ1UsuLvwKiEL6Zv/Jz7PVHgatg2EU8n/gkPEXFy/Hjq
	sM/H/J8/yVmEmc7iZMtmkLXSVHg4txeyMCGyoZ0vL/5S+hhktOsMlEownqDVz/KMCHne74kWmS7
	DKmsJ/tLQbzNqZCpO9fmYu6iQJ1UKvLcIzaGVqFdjOqn39X9j6PaAm6Zfa25PtxjbPriV5VMCtX
	QdTAUvzbyBVCab2R/pch9U2yZciLwGh+H8AM7lDZfTX3rlifsXAD3DJlogX4HL9hvyx6UOeH5Mt
	/w9IAeMaXcRU5B0t58qBA6kSSpwVY9OBOZT2zy+Cqu6On/xxq4YEwyfElncI3BnFVtxS7hSRRoP
	lZAQTDba2fUqD4On0T8Ku9hRYZmLwl7dNmvK+EnmmJOH/mPFgwD4/6XteYbk=
X-Received: by 2002:a05:6512:b91:b0:5b6:1a7c:fd82 with SMTP id
 2adb3069b0e04-5b61a7cfecamr1735598e87.40.1788616325802; Sat, 05 Sep 2026
 06:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905100608.42539-1-kmehltretter@gmail.com>
In-Reply-To: <20260905100608.42539-1-kmehltretter@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 5 Sep 2026 21:51:27 +0800
X-Gm-Features: AcwNN1VFNjvinWtFmEAw0uVhDt_WQkwg3jj28A6TmL0Em-Z3FJ3Y_4uwckPLdkE
Message-ID: <CAL+tcoDRtj7ktruEoiY-+AZ9uXhmgDk1yPF1ZtosqONjagcK+Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update the so_txtime selftest path in SOCKET TIMESTAMPING
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Xing <kernelxing@tencent.com>, 
	netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 6:06=E2=80=AFPM Karl Mehltretter <kmehltretter@gmail=
.com> wrote:
>
> Commit 5c6baef3885c ("selftests: drv-net: convert so_txtime to
> drv-net") moved the test to tools/testing/selftests/drivers/net/, but
> the SOCKET TIMESTAMPING entry still lists the old path and
> scripts/get_maintainer.pl --self-test=3Dpatterns reports it as matching
> nothing.
>
> Point the pattern at the new location.
>
> Fixes: 5c6baef3885c ("selftests: drv-net: convert so_txtime to drv-net")

Thanks for catching this!

However, I'm not so sure if it deserves a fixes tag which represents
that the patch will be backported to the stable kernel.

> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I'm fine with the change.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 903e73ec4611..2ba35f12c46e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25332,8 +25332,8 @@ F:      Documentation/networking/timestamping.rst
>  F:     include/linux/net_tstamp.h
>  F:     include/uapi/linux/net_tstamp.h
>  F:     tools/testing/selftests/bpf/*/net_timestamping*
> +F:     tools/testing/selftests/drivers/net/so_txtime.*
>  F:     tools/testing/selftests/net/*timestamp*
> -F:     tools/testing/selftests/net/so_txtime.c
>
>  SOEKRIS NET48XX LED SUPPORT
>  M:     Chris Boot <bootc@bootc.net>
> --
> 2.53.0
>
>
