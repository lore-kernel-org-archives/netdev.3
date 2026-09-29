Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53E33D4E9
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672793; cv=none; b=GarVFeFoOn4rdiPN6WWm87DLz+vKVo0diSTF7+4V7JIYPHszGSiPD56yq5ayB1i9IopVwKgcPW2/C2TRVwVQkto47bPULDiwoeZV6aVhKxgVIyCDwC0XjEHJEShTOza3JNlsfGBuIubkiFMjTqd3OINMlPen9WgqzkBYd+D4gQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672793; c=relaxed/simple;
	bh=tXJ+qY81QYX6ntiL17hDKcWY+jDR6CzEofjkGotGB90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmv/dBr8XOy7j+tLTaNsr+KNxkemaa75FKt1xnUXbBphotCyKeGLeIJ3mEmdugyfOL+svSOZSvKpLCvHUSpf19iIjxKmzP6CCyTeI4cyYzZ981aHtLK4yw9A1uOBL7t4zmK70+bRtl0NIgGgUTaoLznYCum9U0B6Ed4U+uFcbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSNpgtnO; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSNpgtnO"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so29649705e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790672769; x=1791277569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVeHQ0WAriz76dL1hysd44dqzM4X8EtO0BJ7xNzSj4A=;
        b=DSNpgtnOd5FV31vC8ZOmXn+8R0a9zXQAz+jVnfMhjmoh7Hs9z0pQo7KIOulBI9Rl+Q
         ig1KgCzTuj3F2GoQ9+8KgC+ep7ywewlNc8wajiYE88md8LgJ8FBBsWaGbv31nSk/ZBT6
         sQo2uhKeTL1QjoLi3nc2VOfVJUiQAaT8B/AW5DuXIvQCf6ICemg/VFFjD6RusGRYOMyN
         GdiDRkjpY/JG1e8w6PmwuZ3ntqwdXX/MFon8eqqOB0kRJ3Uhxnnsn1ZzpI2u8a4aN2XQ
         npypCMWc8XqiC0vSH4beQZ38GWb3pdJ6wuGBNaMdFbKsEqNeSNFyZnTOdWcwEtvTW8Wt
         QF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790672769; x=1791277569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yVeHQ0WAriz76dL1hysd44dqzM4X8EtO0BJ7xNzSj4A=;
        b=rGDuxfnLCNb9qvIyA4kJPlB+BMXIraj2GvtlSge3Cqq0RCJhX7XCWL0oRFrmr3nr68
         tpogQ89DM4idra3c8gXR5secYrHjYEO9V0ftdKO4r3jhjkgR/uunDbs+N5pJOZOmSClC
         duGuOaSL8Ahrfy95B6ZtgVDZc886ovInk2kNLWVDB0IVgFl3vZcalYAkP4iVLoH5vDJB
         PnCgZQm+F7l5ZjzjaXCGmoVHZxtJdo5SKMoTj3DXLyFB2dqfPWXksvB4ko5WM59h02XP
         /dv42/TnjkSv1657eu0sKlNmD9iEDb4Li6/i+DlEDiKC8hcqg6+yLrcjT/35X3y9v+XJ
         f70w==
X-Forwarded-Encrypted: i=1; AKwUvBwN0JE60S3uAk5PBzDJYpGggesYSvjuQL5ltQk857+2dx6mDLAUttcnaZWl/TxEVcyjbNryvk4=@vger.kernel.org
X-Gm-Message-State: AFuF++m8B1g/avFDX6LqkkJ2AfAc9Ezeh/HIY5CPXzySnkMbpy8vmJKp
	sYxfucinCfGI5qAeDO9lZS4YAuq4hKZH7djR+OQGZP1JTdkhCSAjyGmV
X-Gm-Gg: AYBFou04q6Oi+mRvr10/wTsumHtIaDm+nvuCHGEH4fgWMzxUO8tJmHOcKgKBcDmaqwn
	NYBreXXUuj1MJKner8HgIgaqg34GUhdbUHQlk6M33gXQtzAcI9GiSKtb3i4QjQr9lBfdjtdi262
	u2zkxLwPiY5DzKd5YIatH+tHt2Xsrnby5I8xqSW+eMu8fNTGqtHvfyDAr1H+hNfvETsWda5MenX
	kTZTQHQrRyteVe5JlTjEnOUQZa6t1wb/g75uB1Ix/3gJ1B3UuIpxhI2KQrG6iMjzOtBUmURwFl9
	dQdJNrcPYV2FGL/gOKnNtOd+gQK0ogs/KOMNxx2ZtXHWSyhJ0KnhQERvgvPrRTrKQgJaSG6Zs0z
	OS5UkupJErfGCKUJx+jDvTaxO+vM9qlpZJARz2UsQbqCqUCx7LaGF3Cre5e4Et/KfoXejKlyamp
	zqEWeI46SWJT9U3BYM5o5kz0hxy29eadv5IFYL9Lf4IpqyTuEZBFipwM9mjphqIGZhzzWtlxM+4
	GuMV9l2deRpaGr3s2icf81OPu8LfxzKDKITNn1qugdPlTXycg6qLPgJqpYQASgHpC8o6OrNV+Ge
	2JcfZlNotf8tdAO1qBYFRgHoMra1
X-Received: by 2002:a05:600c:314f:b0:49f:e4ca:e09 with SMTP id 5b1f17b1804b1-49fe66ca9e5mr261828235e9.3.1790672768454;
        Tue, 29 Sep 2026 02:06:08 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d0ea7c0sm65937205e9.11.2026.09.29.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:06:07 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:06:05 +0200
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
Message-ID: <art_faJ7Zx5CaWfW@Lord-Beerus.station>
References: <cover.1790512621.git.stefano.r@variscite.com>
 <a4e262cfb08153c23c80cd3098a684816993f1e9.1790512621.git.stefano.r@variscite.com>
 <20260929-logical-fanatic-quail-2ff20b@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929-logical-fanatic-quail-2ff20b@quoll>

On Tue, Sep 29, 2026 at 10:49:08AM +0200, Krzysztof Kozlowski wrote:
> On Sun, Sep 27, 2026 at 02:46:16PM +0200, Stefano Radaelli wrote:
> >  
> > -      - description: i.MX6UL Variscite VAR-SOM-6UL Boards
> > -        items:
> > -          - const: variscite,mx6ulconcerto
> > -          - const: variscite,var-som-imx6ul
> > -          - const: fsl,imx6ul
> > +      - description: i.MX6UL Variscite VAR-SOM-6UL and DART-6UL Boards
> > +        oneOf:
> 
> Please do not introduce own style.
> 
> > +          - items:
> > +              - enum:
> > +                  - variscite,mx6ulconcerto
> > +                  - variscite,var-som-imx6ul-emmc-sd-card-wm8731-concerto-board
> 
> "board" is redundant
> 

Thank you for the review.
I will keep the existing Concerto binding entries separate, use the
surrounding items/enum style, and drop the redundant -board suffix.

> Also, look at other examples here, like Toradex. The actual variant
> should be the last.
> 

Could you clarify what you mean by “the actual variant should be the last”?
For a board with eMMC, SD card and WM8731 mounted on SOM, would you prefer
variscite,var-som-imx6ul-emmc-sd-card-wm8731-concerto or
variscite,var-som-imx6ul-concerto-emmc-sd-card-wm8731?
I had used the former ordering following examples such as
toradex,colibri-imx6ull-emmc-aster. (som - som variants - carrier)

Thank you!
Best Regards,
Stefano
