Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4234F0535
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674916; cv=none; b=UeeLIiJLgQI4NkGeJjogL+7cG2mQxYuV+J5b3wcxU4GFkYIcYEsKnHmvVsWzZ9hPB/BCiWZ9R384a9wvogRzg9oIrcUtYxWXDhPydOoFCKV5zLmBym9/CqDU+iLzgjRn0Ts+OzdTOLLJwRaqR9p0sbSC7RcVePBt4FU1fkzWQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674916; c=relaxed/simple;
	bh=0P2nMJyk5QJYGA4+K5hLhmxCTWy627UxvCFBI5LIYM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzPEEIdKzoStBceZCR70ZQ+qlcv0ilvxM98Pyc+5e6zW36COAohmfeoDrcT1p75E8+aJS+DhQTmdyS/rmdhO7V+4va5cS+P7r2qBDV+YQOJYwujcOjDa/napdiQOoplHW2yPnH92qfonH/f4/bebroAFm2+WUpRO0BoS+3wCC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1Cm1QUh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Cm1QUh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so29563885e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790674913; x=1791279713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhT/d71flljW9jNeqH8EFFOweIQ3C2k43Y4Y6+ueZeE=;
        b=T1Cm1QUhMvOHOsoE/25mc+yKMeANrs509H2KdkE6n/Cky9u/eZaknmHacdahljm2Tr
         Trw5RJwMUQdwUqgNcZmb6K6aCwq87WLAF+rkiWbwt3I+joDhHzN8gWjTtnYYvjvkLcTA
         DrVRuVA5fMFkvXB9uZakZtwdhPuuIMbyb2L/i1y++Rf1dcC1DvAqrN0lGOqTqtbERj5n
         cjPWXBK4R+E02daCFta9ypznAEj23LtH19hvtDid+OnUa6XHtTn5nh5PvALPsKk6PiK7
         sycmpfQ31QjGASQoHeELrsyYSA7sZiTuKaFddL3hx9+3c0CUIIxK2n3oMr5wBkglspQA
         Ahng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674913; x=1791279713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UhT/d71flljW9jNeqH8EFFOweIQ3C2k43Y4Y6+ueZeE=;
        b=0qEqKs3Rc12xkwFeFuKyWlRX8xxIpLnL3qP2gXQlYGu4IsYIB1jFQK24ceax07Ydmw
         m39i4Xi40iq0+appsJpfVVkIKRCwRdyTCmByovPhuRk4OU5vOV1PgZ7CiBbecL/JJscX
         Pglrl3aJOvN2ehzQe27MYeYnD2VhZ1nzlhK4nUtq/W/tzzthieQCHNBJn9PI8R7tyR1P
         F2+7ywX1udfJSG4PMvAsXIqkGCV8RW9Xuosh+Wc7hQ0x7ZHxEoONmVeNRdL/o5RNplfW
         NRfbiBH5wiaKmD5h0l8cdVV7YAep6psoetMy+lRKPwG/q38pmRoXc7pl77P65btErMMd
         Uhsw==
X-Forwarded-Encrypted: i=1; AKwUvBxxHF6xGHwiFik4MhYe5E28vkEnFd/4Sl2eSQ0HFsfYigUuisyWIdKkNTYu/2AURq6xhVjawyM=@vger.kernel.org
X-Gm-Message-State: AFuF++kkfToRfovOithniZ3SFLpGisJUM7Oiz56nTvzj4QThjUjM9cSP
	pFe46GZS9rw+ceQeZ1A6ep9T0BpxM9bX5PWtuVv/1hgs8RhWf9qRIB76
X-Gm-Gg: AYBFou1Mbn5Jw5a1zZDeAJ0YVl6QDkLK4qSFrqYnbXaxSaaeJzPoyhjyEumDNeV7s4w
	AZym/gbUqAiXOPiPP2CocBv3apqowgnQZI++pVykJwTySAFT8P9bRS5bBF/ftWuATpaosj9yEK9
	RpA1bUyEl/uI6z+37BgbGJ00zATITUmiztN66MVjD5ZsmpaY/0MqVSleJ+ZJ3vGjP+i9SvNobNJ
	dGazMpP8aZEUup7SSy9jIJX54icCCRwwFvnaeaB/icDRmCLLEp6YICOYrnQQpf+UONJMB6SaW52
	L2F5R7vQiRov24Ufge7tVF/2DzibkpFEO8XoXI4jSg/5KrD5zqhGbKDJU1P1eivlAuzI/q6x/ya
	WypbEpab6QNuTIVd5I9YR/pjAGqd6o+qpyrF1Gbjbfmjo4XQvE+HkpLVT2HjI8Lbgeh3BZ7ArzT
	Hbw33jUkzvqV0FxrCXlpI5SGutwNvDAoyLMhDqlynELJxWVs575mclKvG1u1i9AYEay0iYMVtMJ
	/kHMfk+LOP6DR3MTnkHODTBMqcCrg8AYCKRYlwfXnFtxh92Fcf5/9js9JQemF+n9JKjuM7ZUlKR
	Tn66LL09jwzV+/+uwHtvcMd9OCNr
X-Received: by 2002:a05:600d:8652:10b0:49f:feca:b3bf with SMTP id 5b1f17b1804b1-49ffecab799mr95152725e9.8.1790674912690;
        Tue, 29 Sep 2026 02:41:52 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfe16a2sm64229765e9.4.2026.09.29.02.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:41:52 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:41:49 +0200
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>, Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 01/12] dt-bindings: arm: fsl: Document Variscite
 i.MX6UL boards
Message-ID: <aruH3VNnY8rUYJIK@Lord-Beerus.station>
References: <cover.1790512621.git.stefano.r@variscite.com>
 <a4e262cfb08153c23c80cd3098a684816993f1e9.1790512621.git.stefano.r@variscite.com>
 <20260929-logical-fanatic-quail-2ff20b@quoll>
 <art_faJ7Zx5CaWfW@Lord-Beerus.station>
 <c97be589-45f4-422d-a4c3-e5b0a61f5b22@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c97be589-45f4-422d-a4c3-e5b0a61f5b22@kernel.org>

On Tue, Sep 29, 2026 at 11:32:45AM +0200, Krzysztof Kozlowski wrote:
> On 29/09/2026 11:06, Stefano Radaelli wrote:
> >> Also, look at other examples here, like Toradex. The actual variant
> >> should be the last.
> >>
> > 
> > Could you clarify what you mean by “the actual variant should be the last”?
> > For a board with eMMC, SD card and WM8731 mounted on SOM, would you prefer
> > variscite,var-som-imx6ul-emmc-sd-card-wm8731-concerto or
> > variscite,var-som-imx6ul-concerto-emmc-sd-card-wm8731?
> > I had used the former ordering following examples such as
> > toradex,colibri-imx6ull-emmc-aster. (som - som variants - carrier)
> 
> Indeed, the carrier board is the last part. Just to be sure - in your
> case the emmc and WiFi are on the board?
> 

Yes, eMMC, WiFi and the audio codec are configurable options on the SoM.
The carrier boards are shared across our 32-bit and 64-bit SoM families.

Thanks for clarifying,
Best Regards,
Stefano
