Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723441;
	b=ExQI+y4fH3ibNuyCiW5zhbA65B72DC0TXPbf4ok7UIQV7JOxhiiS8/l1jEs4/lw++jkl
	 5K0ojznyHQKPhoJmOgHWI3pnRSCgh7+yQnfqdBH49Xzm6e8zu7qUNjyID7mow/+wRuOAz
	 ztmc9I/iS9ViP+M2hhw749qnTD94fquT++zG2VddgXs3PLE9UgJwh/N2kJKsFWvT6JvDJ
	 CYVBGEtmDKf55MViJJv3tF467nmiQSLRnjps1oAd3Z2H0qzFiLXvQMX9NT05s1VuqjqZ+
	 h/0vEa3AYHS+2GV65pBtBItV7yLzan5PZlLLEidTN+A5LMYv8lmK3eunVNoUHYHaX2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723441;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QIKLXmDhQNqLB4Y+YR2V9D04+lvxRqYL6EpEyVAWUjQ=;
	b=OF99ORjil/PSgPVNYE2YwP304KlXe0iOA+oLNqBe0lm5BOVpEfWvF73bYV/Me67M+tFG
	 aORjYjhCNoIngELDuj4EbTOzDq7YSNRoYp2sliAuD1VSfkikqpPOtOBs++7vnrEWW/Ck+
	 BR3Qb6GQxoRRrjq24sM9pyP/X1OX+fJn96UtLlR6c2m6LY1+evDnDMKrVDodllx/jIhB5
	 KVIHpsOtNRHBnGcNGKMx5AjheO1G4RQdCI91+K6FfhZovK8i0PKjOKjWI9KIX2P+x6xMw
	 fl6+Q7n0HomN7Rz82KOjESPzd3E9RyjInUi3F97fws7fK9h0yP6iGnIGs/NiYRaC7Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEFD606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FEFD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6798af41644so3048741d50.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723440; x=1794328240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIKLXmDhQNqLB4Y+YR2V9D04+lvxRqYL6EpEyVAWUjQ=;
        b=SPU1m6+nTeU4MwKXItgEQ9Dkk09hsaLFjHC2AdQkN613bJd4p+8Blij5LrAFreY+Zq
         /FJcYz5PWgb+E9EbGzkbeXmK3m1KuRj8egedyBBIHOqq7Vuy40FtKXhGCei2MfO6cAYM
         CKItRB3MxJNF5byd+YMQMxXHtCzEq+OR78YsLHOVxF7xxTA711FJEV4G6zyVKP/tC0xE
         SlUP4Thu1R2xgEjL9hrHQObkCmf47BCf5Fc106QhL51TFqmEmkKOUpE8uvgRMwTNjf0U
         0WtgHkgzuzYPPrfwH1BnS340YxBIQMej/knXM3HOeRppladbQLiuUn4JKVbjwH2P/Fgk
         mBbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVgP+TSZNaWlWbeWpQVXiBWPGQ+zKEZlw8DF60DTU31v9I+88OsW62HIqvn65zK80G5rgRS7I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ckv/JCXwLK846ZarlnFtUB4+3CNMbFa82nZcQC09q+iHr5WrC
	Rh/U6JFPeKUrQs3mJqvKJtsL49J/3KaFsEfOj3/HD7w6jzePS4VX658w+inHjDKh3t0=
X-Gm-Gg: AYBFou3O3ySj5mBfzX98tewJ/wga3NhoZ2cHdGK7A5IOior7vuXvDxrJxtL55I0PiTU
	7EATZSjFwqDOb8X2sGEDnnIwCPo+NGHPuW+2q+2j9+liABSWtBjxLJAb4herFc+OjVVSWXFpfJR
	XMdXrJn9/7XzhGa5WAOMR23gh0bnUi79Kj1FivcOD2BH3D9ArlgkAPZIsLQQRW2LsmeMorX71Jd
	bQuqdtlUzBSLucyPpyZ/o+q8NX8zXgmU6lVYIYhVqC7UnV4TdmTASd665mgZhSpczyEyM1ELRYp
	H/aYs0OjPWpZAOI05+v0DsBSeiKpoiguTD+UZX62fbMmMNK7kTniVKDNJZkEaIYZKDu1V3Do1uW
	ao/A/pinDTO7cLZ7DBKWHki42aOpVnLlfzaBNf9DQl3ZC355C6xrB8ZDz/X+f9QD5YJjLCz96nG
	i1G750F8hVIcYC5H52Cv246O2As3kCk7w43ZuuEy7GE7OmrEYmWGUVHUnKkjO5kdKJoU5SzU0nm
	u4n0NVUkZwniy5DWWpUUDB8JrMOBAGhZ35Co+yon+ETa11i/bs23uoKZTj0elpCpm0aFMmsbBcn
	ERVGPrK6ZXV8NqFGXhrfNVdGsVUb2qi6EV6yg87YOc1hPm/FIc1Ka4uujKvgzqTqGRglj9gu7Zn
	r1QwhOKCP6gd+YwfFQM1JGA==
X-Received: by 2002:a05:690e:169c:b0:679:a898:7d97 with SMTP id 956f58d0204a3-67ba4fa146bmr11876281d50.26.1793723439642;
        Tue, 03 Nov 2026 08:30:39 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf26e646sm7308406d50.7.2026.11.03.08.30.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:30:38 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ac525c1f05so41852007b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:30:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx7JkSg3pmm+ZdvqQJpTrbW10S/1uO0GW9NJExrpkAgVzLw6lsydT+PrCZBuQ8LNkLWue6+kg4=@vger.kernel.org
X-Received: by 2002:a05:690c:91:b0:8b3:2b8:856 with SMTP id
 00721157ae682-8b302b80a2emr8226867b3.68.1793723438403; Tue, 03 Nov 2026
 08:30:38 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022200640.3101932-1-tanure@linux.com> <20261022200640.3101932-4-tanure@linux.com>
 <c7d703f1-57fa-42cc-82fc-3e0aab05b71a@lunn.ch>
In-Reply-To: <c7d703f1-57fa-42cc-82fc-3e0aab05b71a@lunn.ch>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Tue, 3 Nov 2026 16:30:27 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+1=3ZRLX7B0UG+R5G74S6tVECPJV-MWcYfbU6nh=EOaug@mail.gmail.com>
X-Gm-Features: AclHuK--tXPcmW4jBK-98mKvizjMAJUNc7lOR6WXsrVb58UVKvwxXzerIoleZek
Message-ID: <CAJX_Q+1=3ZRLX7B0UG+R5G74S6tVECPJV-MWcYfbU6nh=EOaug@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] net: stmmac: dwmac-meson8b: add support for the
 Amlogic T7
To: Andrew Lunn <andrew@lunn.ch>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:57=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Without that gate the controller cannot do DMA at all, so it is
> > required rather than optional: a clear probe failure beats an
> > undiagnosable hang later.
>
> Does the DT binding mark it as required?
Yes. The T7 block in patch 2 lists the five clocks as an "items" list
without minItems, so all five, pipeline included, are required.
>
>      Andrew
