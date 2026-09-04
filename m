Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54DE3EDAA0
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510493; cv=none; b=cWDxLh84L2Wlp1PyTvR3yQBqghnQLAEccq/QewAq4x+kSk43zaTnmW2jLZ+NghVhhqB5N/1+i706Xi9u+2u87jvvK9Is3DWvu+wTpP9zsLgMYQbYyfjdxCL9K24+kIUIkoafrzX4zp3bwNQOw6pjmfnxWIVuqv8aP9nC370dteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510493; c=relaxed/simple;
	bh=vAduMceZ5WykF9AxLntA2mjBC+eC1Z+b3m9MMdygFJA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EXzEPtb6jFSwQXQ7Y7S98jvW5iGsVJXfI/DXVXMj6ayvcW4EpPgOizom1B25jZfdU1pgDYGfm6yLKKaxok8GpGQdKKKh2sg7WbCMsfBPNBsj12JjCKtlz1bj11nFOCPhqYpCkMyfegzXItLOzKXh0dSmQxjU21ExA5rOIqR6txs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RiaQwOXB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RiaQwOXB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso5960615e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788510486; x=1789115286; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAduMceZ5WykF9AxLntA2mjBC+eC1Z+b3m9MMdygFJA=;
        b=RiaQwOXBOn0YzZFijm1RpCHRJ6mSahw/bPpElMP5GJkOHm8JqWCflj9TE/WMO28aZi
         eIlnm2nMZ7As9Wb0rrvdYwAGVWKQuBq2K5u89uD0JAuqEFQJJUHFofCeKLkYUiRIeKcI
         05vwddqEQUKkS8KNpu8ZrtLK4fSvbO51CBuMSRnrdWPaCrDq6LD+UHpi6Z8UAQ8YwK8H
         Z62V1ZojujRMo1Zg8V9NCVmjRMIk3jOW9HM9uDauoxXTBeIlbYsww4z2q15ahlxqt9oi
         tUBvWRQu9kOhGLecsOqFRlDq5kn4tWxpJmCYTUtITkz1aIRyf/B9o/9qJl9W8lC+bgfT
         7cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510486; x=1789115286;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vAduMceZ5WykF9AxLntA2mjBC+eC1Z+b3m9MMdygFJA=;
        b=MhyZkK7nNwwhj6fuz/s2llbdQxu1AVLJIxa2V8MlionnPhr77YnCjnXsS4YNIe/CZy
         0zxuwbLHgaJDMO4qYzOtybKmyPOn7NXrE/JErgCXerJnukrOovfKiJvGBPJhdJkN/tJ1
         z4DE5Y6wYIueSTvYUsgNarw5UyhIQXDk/r3eVNqB9yp1bEi06dF4XgvLeqTbeQRLrDuC
         XuMXUcrTX8pmtX1z+5vSn2H4ogRu0uhwldAwhqpDdA8IuV1dMTRuvk2eNfcyVDIc3cPc
         ooKzv/0MUKLYbAsK1TZGdPlojAzeMPAnOdRJxMLHxp8eFlux6DNuztgnm1+4LM4fli3x
         hYtA==
X-Forwarded-Encrypted: i=1; AKwUvBzRK9NwWb8Tcg9SQQfPAmx4u9yXjcAK+rVSNjlUzJGZNdbJHK1CUJ/XNSVaABPWXBf/8MyzyMI=@vger.kernel.org
X-Gm-Message-State: AFuF++keczDwrqlYY/lZK2rQ5fLzkI1H0MArD2i5674iabwuNbz1G6fB
	NSkBgARYTeA8ptWB2VlQSt4SPJQWvMqyKjhwE7xtBLTCrg0HPsDkXRMaphXehJbB4XY=
X-Gm-Gg: AYBFou0fXqGSKnp7sbR/m1Z7Bc81EtSwZraCyQAl/nFh3LzgMci9h6zK645c2bp+R/r
	QasKcL2Cqi8d1+RwWDaCWhLuRT53gLm47vNqSedInlZEwv95hGPOKSqXyVF77wOsugJ3H+ny32x
	DE743RCyIe56838LFoRR2oJJAle+UNkP7eH0k8b+sPq754CHWZgAIPGkU9r0jnpiC/l47243Pne
	ne/90A5lTH/bTOcMUHIH+x8cQpY7JLAok+RQQfAqb9nAAUg7vM98swg/KLbYRpL8tyJ88lvZcM1
	vRTsDOZKxknsFp6FZ6AKHg2ACXmmaziqxUO99rfmmgnXpjlsDexe131xQOCwd8UKCUVifn/cV/s
	PIaZkZLevgY7HOdMpiFjn/sePgvqhF4XcJcjaZwJYl2LfLRWjKI7l9mzDUM/iS7g9arCXfO38bw
	XkzBGmh2rgl1/VlB1/R9gaZh6scnCZZF2K6xIjJKyLpWrxFJNP6o+mT+1N
X-Received: by 2002:a05:600c:3511:b0:49c:fa20:cc01 with SMTP id 5b1f17b1804b1-49cfa20ccddmr25588125e9.24.1788510485753;
        Fri, 04 Sep 2026 01:28:05 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:489b:7642:1b32:84d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm68845625e9.2.2026.09.04.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=aceffad199f989fc0e7a2bade7854fe91c95aab0591a0938aa91a92fdd3c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 04 Sep 2026 10:27:58 +0200
Message-Id: <DL6E1V8AMI2X.EQQ009BX5AZ6@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-omap@vger.kernel.org>
Subject: Re: [PATCH net-next 05/33] can: m_can: Remove comma after
 sentinel-entry in match-table
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
 <mailhol@kernel.org>, <msp@baylibre.com>, <florian.fainelli@broadcom.com>,
 <jonas.gorski@gmail.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <kurt@linutronix.de>, <hauke@hauke-m.de>,
 <chester.a.unal@arinc9.com>, <daniel@makrotopia.org>,
 <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
 <ansuelsmth@gmail.com>, <linusw@kernel.org>, <luizluca@gmail.com>,
 <alvin.sipraga@analog.com>, <clement.leger@bootlin.com>,
 <justin.chen@broadcom.com>, <dlan@kernel.org>, <rogerq@kernel.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <rjui@broadcom.com>,
 <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 <opendmb@gmail.com>, <andrei.botila@oss.nxp.com>,
 <wangruikang@iscas.ac.cn>, <amadeus@jmu.edu.cn>, <kees@kernel.org>,
 <tmshlvck@gmail.com>, <c-vankar@ti.com>, <horms@kernel.org>,
 <vadim.fedorenko@linux.dev>, <daniel.zahka@gmail.com>,
 <nora.schiffer@ew.tq-group.com>, <v-singh1@ti.com>, <oss@vassilevski.com>,
 <haokexin@gmail.com>, <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
 <lgs201920130244@gmail.com>, "Kendall Willis" <k-willis@ti.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
 <20260904043724.2955444-6-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-6-s-vadapalli@ti.com>

--aceffad199f989fc0e7a2bade7854fe91c95aab0591a0938aa91a92fdd3c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Sep 4, 2026 at 6:36 AM CEST, Siddharth Vadapalli wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>

+Kendall

Note that this and another series by Kendall will probably have a
conflict as both change the compatibles:
https://lore.kernel.org/all/20260902-temp-v4-0-3896f7d16ce8@ti.com/

Best
Markus

--aceffad199f989fc0e7a2bade7854fe91c95aab0591a0938aa91a92fdd3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCapqBDhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNU
DgD+NDmEsw57cLpzBEOHVv/Nk1EkJHkfkEl6somoL6FeZhQA/igsPy7rmcarz6Ym
lEV7ixhaA3JU6LQo0KOc3yMdNwIE
=DaCZ
-----END PGP SIGNATURE-----

--aceffad199f989fc0e7a2bade7854fe91c95aab0591a0938aa91a92fdd3c--
