Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792615527;
	b=UKpsCouDSD4KLwyxNf0Ac0zFuBN4Pe7KxdMWfHG9xoHS9VMWatDXUqeMbMmDYqLJDS7d
	 gYy6N8iTpqBYqZYI/YnTSLz1MMDM6rbCVrOMBwtRGu1BscO85byxoJwUBaJxm4mRzpMpN
	 pJJPv6Km+ApkrMMnyOmKDFiNN/HAc76trCC/ISgBwIMvzv+0zEV4nUZ+oCzcWh/hEEx+O
	 QzgH0xThRL15UH5rVMOTNImhB+fLdly4chbqLuYDwUAm2JenqUig7sqRh1rVThYbjdDeB
	 c7I5Mh8ZhHtPaXgcpnsgrCKwJjwubtzgA6YoIVpcQ9g/8GLv2nP1zuvseO1cAS5KZyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nnIUuPzYQicGUZpybEaz6HenxwpcqBgX6YEGmj74Tzs=;
	b=YyQ1nkA33w5H+KKfuWFiK2GUIGAWO6AY/iIri1R3Lx9EaOHAqGN4zVCs8FXPQwiFPVlp
	 r3n/yh0cAvCp7UZnc3gVR7ytpb/XDcBXtNscuDN5KUmpk8cxjNG8j4AlAU7bkvk6tGLX8
	 eWmSQ1PPZwDuImaCDxPEeEogOPH+o6rJPPdtj0otM171qV4HiD6KRMPw0S4lOnoSEimwf
	 BOGZ2g6YgYsALDW7oroUpaB6QMTMjenZRRVmVN7XxAZJ496Vey4I9zHEYf5M84Qrnu1Gc
	 4YlxshqgnPr19pDbJtusBUQYu6J6bONZRTl9D6vt2R6giUF/Y5rGe0PLygMQ36MvwFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2GTVLdo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FCC606A320
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05FCC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2GTVLdo
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67489c8202cso1047799d50.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615526; cv=none;
        d=google.com; s=arc-20260327;
        b=O2oI8N1ne+xAsv/BzVxVhx/LkHYc4ilgdFvEXQdWbZyBI8AH7Fr9Nb0YFXEEI4+I8Y
         v8w3jyZp8G2aif5jJhHNU0UnbjW5dHjWRKkHnwCIvfynRh+z8X1c+nxi9UntUkNZz9Tt
         Ca5G+HoPkfSI3pFwY0cfUQnQ51FzeK5KD7kvxg1g1cnN4kASfsd2ifvz3+LTzVuXUvCk
         PXYXFkgFuWNuh7CHuKkmdw5+D4jegigw4Z/RmjZvtEitkTbneIZu97BM9B8NM6WFI2ic
         toDRVlW/vLMAe/OSo1A4zS6O0Qqidf41QB7STWPacvC5fQpe6Ocpt3MimcW2mv8Sunwb
         sDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nnIUuPzYQicGUZpybEaz6HenxwpcqBgX6YEGmj74Tzs=;
        fh=wylqyYqKvM3lOQvs4edtTjYw4JXfxx6RMbBXrk4rD/A=;
        b=arpzZzkZ3+G1TBWjIGy+7b19KDai15RB9Smaa7TUSqDHabUbwl3JntN+Q1kFdVMDsR
         D/V1zPA3Feh9SVKhKM9T8OyjfjXxCqgWOcIsfjocoqn/JpwbQMkWkMo4kQgHnw4+kP9P
         AxHRsXJG1IJLP3b8ne0JroKKo5/5ThIrP/jJuynb5LevsziG/YWEsiS2lMCOz++faQ5h
         iZwNgYJYX3L5IJbhPow1Qfp3PWk6TSXRuQpuXmyazNoos11q12kS48WcQfOEIVtLwM1P
         HdlvW4D7uZF28O7zxaCGtUS+lLN60iSiG7S9YWT0eHt/8FgDXrOvYSVXFA7oAbYI6GFu
         DDEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792615526; x=1793220326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nnIUuPzYQicGUZpybEaz6HenxwpcqBgX6YEGmj74Tzs=;
        b=E2GTVLdoEoKP4/36dM6Rt+ujq8xHjhA72Dki1Ri7kLFvWK+VxAEg+MLJX98lJ4ED5/
         ve3Ei8uNci1YteC/PxUpHGMQi6gBts5H5BmOQ5Q8S01U3waEOAUaBXC7PdH4sYyKbrBb
         85gL+hDJPSnI07vs4QEFIaQiipQiHJIdr6bOTAv5di46twuhRyfJrQBkvSP8hvNVqswR
         gG9VjRrhmJSEJdTpyhMtkYVbYyu6KGvnxxP3kVOt8mwo2oQYQaOZOHLTEXcLQsO12WO6
         DK7kU9vJZ7UryCuXiJjzb8OgEU846DLsJ90OvMM4vBlnKBOpWhUhvSePck1umrje15jn
         K4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615526; x=1793220326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnIUuPzYQicGUZpybEaz6HenxwpcqBgX6YEGmj74Tzs=;
        b=01izDoJLL+EbVnkuHKE75N2veU47pLxnVps7NCJ1RE2j7QGoWtxhTgxbsSNi2Cll4Q
         8KUybDUJQEQLZGTKiKw0bnc6GURTO6NgJtvyGegHcGVlT5VTh0DjASNrfMvpa1/wWa+w
         icn44pm2isMHlLifelBkyZlrpDFxmebiQOSXKJnnl9PHNqNFfTiGqzIAylm2JW0PBG66
         FVWmcnTOcARX3BCIUTqXGp05c5VzqKw+s+FtHvevZ2C34qIXA50zaIG704EoYB7aP8J2
         Y+8w8sQEEyYm62IHrg0rVLy6MsLmXow5IEBcyzNFsVcQMeRoBe59uVSCKUcdh7ACvHc0
         tdrA==
X-Forwarded-Encrypted: i=1; AKwUvBxjyszuTpvRBB4y2/uQcFoVxld8Zdts8+ySOOJ5a2O5McZBpacm1DLTbhKfeP2TsiYvEoF9LCQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIroV2+Wau6oQkdCIa+R4Dscv3ORsOFGfbYuKpW7G/PeahHfV8r
	asRfLuAib8BDutwC2Go+a9SDDMRrdKE/+rAMC8hanIfM7kbZaJvCVL1e8Nws90lUDdO5h2k9POE
	TGeQ/aFGosE6bnZgGZSpduuEajidJnco=
X-Gm-Gg: AYBFou03zu9jhtVYy91OT2jBdj4Zrw5qxwsD4VtxaP2iYMPCzROdMtbhw3SU05ZBc1Y
	2UOVZ6LiBGN59K8yxm+6OMi/i71k8jGCMKyvBN+8DcNSgyNjl4kpL5LDwordSa87AYLQ6jsQMX5
	5rwNBpL/fis/p5HYR6r2I866iWczu5pFitQWrQl+irK7E129xlx/LVvDRrOl2WP5U12b60+OOrF
	lnHhFR9YetZGGf8bnZrW+DBMxDJlu1G37dxQKKJRnm4CuRggewrZetFxpq/DXoa3VIfOssRzNQ6
	QjD7owwD4FiJ11oaOMmte2LZZwSfkLPsXt0pkMMCR1b/dbrjdop76K4atHSOPPJVJyMbKDzDxeQ
	1CJc681TEJiWrWsG8YITOHohTC7jRvGXSlsQr5OIzbvhiYiDCaEoSeaCZ/Un3agE8eEY=
X-Received: by 2002:a05:690e:80c:20b0:671:26c4:3ac6 with SMTP id
 956f58d0204a3-67a0e4cfb65mr1060933d50.37.1792615525992; Wed, 21 Oct 2026
 13:45:25 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020202614.30277-1-stefanomunari.sm@gmail.com> <1449a6a1-670c-4d1d-bb98-51f92e32d848@lunn.ch>
In-Reply-To: <1449a6a1-670c-4d1d-bb98-51f92e32d848@lunn.ch>
From: Stefano Munari <stefanomunari.sm@gmail.com>
Date: Wed, 21 Oct 2026 22:45:14 +0200
X-Gm-Features: AclHuK-ZK4ETNJ9EthtOCxXQFK-JYsgPoO094x_9rBDc8C162jyjBrY68mcMpzM
Message-ID: <CAAcd9sOF5weSUoxLtj62t4fGNH-Ar90J9CHh=DvCgwSkrtH1pQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: lan78xx: fix error handling in lan78xx_open()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Andrew. I'll send v3 to net-next without the Fixes tag once it reope=
ns.

Is the Fixes tag being dropped because the bug is unlikely in
practice? For future patches, should similar bugs go to net-next, or
are they not worth fixing?

Stefano


On Tue, Oct 20, 2026 at 11:05=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Tue, Oct 20, 2026 at 10:26:14PM +0200, Stefano Munari wrote:
> > A failed interrupt URB submission leaves NAPI enabled and EVENT_DEV_OPE=
N
> > set. A subsequent open enables NAPI again, triggering BUG_ON() in
> > napi_enable().
> >
> > Clear EVENT_DEV_OPEN and disable NAPI on the submission error path.
> >
> > Reproduced using failslab on a Raspberry Pi 3 Model B+ (LAN7515).
> > With the fix, the injected allocation failure returns -ENOMEM and a
> > subsequent open succeeds. Verified connectivity with ping and SSH.
>
> Memory allocations for small blocks generally don't fail, so this is
> theoretical, and very unlikely to happen. Please target net-next, and
> drop the Fixes tag.
>
>     Andrew
>
> ---
> pw-bot: cr
