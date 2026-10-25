Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792930080;
	b=D6iwPnxExzOd5JpoFPBrGMZ3q13UTdQ7QcvS7fDhKuhd0kjVq8ZhaqvxufJGe0UpJIVV
	 QIqp3IN636YSc2dhbhgjX23QuTXN+Wl/j6xrpLl4VNrlP6BD+CbvStzYJgMihgiory/v3
	 EB7FpUjPTbZM/8MSOb5clP3r43MnPMRyCKPNyA4Sx7ZZq9zMXSd8BwoZNYoWFidXBsJKt
	 mtPfYFyX2iK8yj8tf0YF7FIVYc8yBo5EuCaeeuhQex5P0ChBCTfylV1TJVlowoWs48+1Y
	 3RyfSrJjPzvFa+81uxD7uIqG0s03QkOd9rE/0O3XB/YnndGN8WTeGe6ZQygkXDkvx3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792930080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=M3JXNvpeQJ0Bux3cVAUHFgm4T0P8AxWV1g4g0cgJ8l4=;
	b=KrreLw01G7lOsehjib8jVtD6FpOAF0dDteF5BU/+/n7jC0rbgDmTZJ9dJzj7NESDJQOJ
	 q2JVAQfyPJtFruHhXrSOgg/ejB0iv0v2hX2Syh7yZWL5eRS9Zo0OpEnlBdUmkePv8wgSS
	 vrKDfEf8xnfBeBROHYQNVfDCvwIB5WVyZxDXNcJ4cZZNr3Q0dVxS/gW9h/74Po5s6J2rg
	 NLeXO5nrhsKT+X80RPu4jsm7ObANjZuIoSlg7/uJp3MaAsrqgx4C2xcEhjx45bYlXTwIZ
	 N6IUazGPKaSYgdVZSA70fcqgM2NKzFxCzuhn9uqBwns3t7vwkSy6GOJj7RYtfkfYXCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oU2AjoXy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE58606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 12:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE58606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oU2AjoXy
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-156cbe59622so1395082c88.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 05:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792930079; cv=none;
        d=google.com; s=arc-20260327;
        b=aeDo8GPlP6Qgur0HgNSnWCJfHFHumkUqHIGPuMlE3hXXBx+WKOINGG6zFQCsdqtrOi
         HtoC5l1SS9pz+AHAMKZ7XyUHr3SvP57CJmbSx4r9vjvj+hj5X3O6HZeiNG+Mmm2iROyW
         78u4ewrBk5G4KISZ4qOm2ibPR25ESnJHW3kDBhgnH7GYSsGPgya378EGoHpt2D6lyQ7Y
         Zoa93OTiPJ5k2WXgBcM6+SQxZjIAiIHSaMWxlqNksEpzBKIQ1pmCRiHIcf5eeijYOnub
         +xoKh5poXf5Tc6dyV0n6i+APGPQrapnKcevppjB9xoZQ7JqHppBfRwzWBV5Hge0rhtEi
         vliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M3JXNvpeQJ0Bux3cVAUHFgm4T0P8AxWV1g4g0cgJ8l4=;
        fh=2qrJLVc9pyd6IaGu4jFLwsZ6ZQYxgXRl8cn9ZeHTsTM=;
        b=AYTuBxi4J16T80TgLYYuyXcDtzJ8kott2fsfZcX5xZQEK0vTkzcoM2dLMLA6al9D4w
         BZvRSO0Wcpw+TlVhn0BArSZhmAglT5+dddRF/1q5pLMRhFbQ6lw+R2CFV6EvJ51SVduE
         PKz0EeBjWsshZOqQns32VW6mtE41RoiRYkZrl/SJg8Sh1fv2CEE3YUEBUjh/opXHEPxk
         N8+Y0uDjiOD4+5FirZ4WCoa6x008M1oVh2N/FieY0GPUqhpwVvkJtoUakmeCNYQLsonu
         ULCrMn0pBoL7uCvvskXaDcEH+nxAXSycESB0lo3uW1WAfTlxszJqEyg7z7/HzmINzEcG
         IQYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792930079; x=1793534879; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3JXNvpeQJ0Bux3cVAUHFgm4T0P8AxWV1g4g0cgJ8l4=;
        b=oU2AjoXyOh4AFN4s1Bn7mmT9HgFQjpfEbr4mHT3Uy07uCDtbGd6Ay27PHXlO7gwxfr
         TBrJhd7fkOfA2nEHRIQ3648B4Ta0MDjYwX5aS1GWiN7MDaYqB/L6sAYeIDvk+6LwgbM3
         BOWEkMGY63mxxGu41R3+I3D9AJMTzBXpzthgkkS9EOeUnaEV1dLoYdqs02Gq26GcUcTY
         z5gBpSIVMVGopw5TtCMS6AIMghMKiQI+C7y3LS99WLsOk+UPv0W1zx+mE0jxOLjGuGwh
         DKEC0cP30Q6PoTQr1mh99Bt/ZZRaMYCKekOJ9SaVu7uZLM6LqnrBp3CSoG419L+1H6pn
         wNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792930079; x=1793534879;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M3JXNvpeQJ0Bux3cVAUHFgm4T0P8AxWV1g4g0cgJ8l4=;
        b=tp3bmgI1nX4Zt12KOkLhCd4ZYIF8k4uIWUGEFBZ+Qlv5hnrOcAuiI7oO084TSsSVcv
         2bczmfHxAV6BadKSDrLKuniuiiRNDogkQ0jjhsz/59WLGUoMHrHpjPmMpnWPQlNi6dbi
         80AhH3C3TC7pEfk5ytlO3MEouaiLPexuq30ICe1369EyC3tMRutYhRjALRAZLp+S9bUw
         3dklJ3Yz1NwN+bKfo+WYlCkeaFWZald8aVN3ch2oKEimB9FDzv7aUQeUgkLS8ZSBpMkj
         L+iRxPDqRgdDMmxheGHzv+s0BVC3ZlPS5awOFMpVXrDD4+A8Sv7dB9CF3sVl6BbOnvTh
         1ncw==
X-Gm-Message-State: AFq9FYJMp5ijs0YSbfQkZSZnScUdgS3sjbSa9gXmgClTpVpvB7J3nYCt
	Stf1gSUSWAOLowpEA2f4YBgEq1BEdEnxb9qBBR+wUjDpQ2psHAq40/B4MOzIO6ZTvio1b1UwjCo
	WM3iwNNZgTWpHqIEZQwVw66lMFbz+3lg=
X-Gm-Gg: AYBFou1NK7BBYkW1OQvaB2bQyhkCpELGWcRKE3IQ2/7GSvZEJoFkwqZDwb0kxDEYoiu
	Sh+sY7za3HXuBqbhkgSw0hn9BU4C/O6eMKesNnjh3l/T/3xI7ZdU8YpnCXbHl61J3PQ9imtA08p
	4qF7Z9Wchu2ce9jkwWbbtTfv+dbkg/SbLY40jiYrALm1buDZrQSjuIefY0n2HkH62kLW30hxdKz
	PpiSfxA2CJbTr9oHC+BIMPFER48mU9Vn8Vksz3e2DZqLkRWiFE4oTc/eKvIkD+TPND0UmRSE5lc
	HyJzDPBHffKLxdmjLHcUwW1xH0OxKbYnBLM672pC4YIY+e41pEG8Ac8iumt8Q9RKWC1HtmTplw1
	6a6iof1bJ9iaZYGkQPhTSyQtQ22hSaBGIqOPOcjZETbbN9gFjYu4rBJayrNI=
X-Received: by 2002:a05:7022:7e8b:b0:16a:1fa:58cb with SMTP id
 a92af1059eb24-199290fe419mr6619027c88.1.1792930078752; Sun, 25 Oct 2026
 05:07:58 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com> <53031.1792761889@vermin>
In-Reply-To: <53031.1792761889@vermin>
From: Timur Stukan <timur.stukan.linux@gmail.com>
Date: Sun, 25 Oct 2026 14:07:47 +0200
X-Gm-Features: AclHuK_WZtfyfMlagRSV_k6VkUA0k3YKf5SpRSOG-2I9O3pGGcYq2gny_lQ8D3U
Message-ID: <CAF+_u5C0AAzR90Fqy8EW0EQg25=ntgpxhwxqh0rDif6d46qK6Q@mail.gmail.com>
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 16:24, Jay Vosburgh <jv@jvosburgh.net> wrote:
>         Reading the description and patch, I'm concerned that this patch
> is introducing the same sort of issue that 1899bb325149 was solving: two
> state variables that end up becoming unsynchronized.
>
>         For example, here you set link_prev_state in one place, inspect
> it in another, but never clear it.  Thus, once set, it will remain set
> forever, raising the possibility of false matches in the future.  Not
> necessarily from this patch, which appears to always set then check in
> that order, but from subsequent changes down the road that inadvertently
> break this guarantee.
>
>         Yes, that can be resolved by clearing it after use, but I'd
> first ask whether there is an effective solution that does not require
> keeping additional state?
>
>         -J


Hi Jay,

Thanks for the review.

Yes, I think it can be solved without additional state. The previous
link state is only needed when link_new_state is BOND_LINK_UP, so
bond_mii_monitor() could skip committing just that state and leave it
to bond_miimon_commit(), which already sets the link UP after the
speed/duplex check. Then slave->link still holds FAIL, BACK or DOWN at
that point, so no new field is needed.

This also seems more correct to me: a slave becomes BOND_LINK_UP only
after the speed/duplex check, so other slaves processed earlier in the
same pass never see it as up before that.

If this approach is acceptable to you, I'll send a v2.

Thanks,
Timur
