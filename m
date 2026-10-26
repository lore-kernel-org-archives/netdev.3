Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034742;
	b=lBFSYYgEFM9z2aZaOD+k+O50vDn4YfozobqsE0xnc/MvCx50bojPi25XjZu6AlnSpo6D
	 +Q6V4CqEsHBkE+yxpzfr0L53hghyDlplBxaXWBqULEDCKj0Jm2YMQcqxYTbVSk13bHNru
	 UQPgk/f0ARg1VXSOz7yPkNcy+QxOL2TsywNeMC40DvT5vedhx3/Z50hjUIMuRKP0ucGAx
	 OqiQmlOjvf2d8pBVR6aOVquQg8b7D05gVLXQZDihTHrnvr/bSMr35NjBVcdXajj8ltn75
	 YkGvzYKTSjwmD+rHRmyT8CvxhAqlkWdZATSbmttK96GoSCEuibkw2KJpPIwGY+JSuKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/UWa9cXw4yw98mMhsberGzcPxMx0T4HT1OYdgpW1NKw=;
	b=taivH1rpSvb57+h0qfPYgw6S18YRd5wFbbIJDJD6p9m/8GuXdMdXpqs/VFyr2WXrLDK9
	 ubZKr1uHGGqndyERknZVs3ODTRILUCEXqjWoNc7TotDPPzClST/JRBrbD3+LJaSv6UNZV
	 8FTSXigw6h5UKjWzt8jx06EpsXLaiA/aQb/Fit9cgHNvhbgKMFvODhIQH7oN5zLwNYtJw
	 cKJemq3in6VcbiHvMQWxPKgGk4T7vVZXso3/auoOP4UReuIljb+JQwtx2MvBepGt00pR0
	 6k/R4KMWV1H2oDSS2kQUJ9EeeK8d2M3SAXq0NqHm5qjSAd1+Eo5+BIyYRc0ikxoSDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hZAvbhrS;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A224606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A224606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hZAvbhrS
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3282db206d3so6418584eec.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793034741; x=1793639541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/UWa9cXw4yw98mMhsberGzcPxMx0T4HT1OYdgpW1NKw=;
        b=hZAvbhrSMainnQpfsPBEEjcu5q2TyNtUPH1dDMKzJCIgYBPtvQUv/WLBENwclcvtSw
         B7p63z96Dw//7bDqd/WqceKFM5ItJR7cwIGZSp/koDwC3iU/A+DLL34p7uXe5cfZSgJ3
         A80scB7/wdXobGzBdFv4B/k9r3EZCNTWm/DZJJFU2f6cV0KqZG1p6wOnOcdIaHE0BFwj
         /1WJNttieMFtlvA495SGtNISLfvab1BdS/SwoSp7+IkklFEwq2kN9GinxxLQElWERpMS
         KBu6u6lbceDVbSOP5dgOZwXaw4Xap7svxzoBSv9MFbDqedkRCbc6HnU4HB68KIZKJnBL
         KS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793034741; x=1793639541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/UWa9cXw4yw98mMhsberGzcPxMx0T4HT1OYdgpW1NKw=;
        b=xtHcA2WAOtoQiUIuzhkASY6MQ4XwSbbj4pq6J3j3w9av0+HQiEe+czLajeT358TcMN
         b+C02Xz8EjNcxaOKOdvu7Xe30yAQFucEZxGwdZy7qnaUMBJpjv7Lt2zmzYXEDl53rvHk
         ajy08f+D2xns7ACkrmM7dkDaWc2YeVeqoPPpoM973G2eCy4w1lZMCIbx6dC4I7SFipUm
         NryJ3lOjCYezckEMdK7LOF5GYHT3/QF5ElcJ8YukwYmsIHmwVxICZR77FoHQzyYHyXgJ
         AANjR4sKywLrHfT7XMi1eUoDcmQUvwsya6xP19q/6lF8iuHURH+OMYrNDIIy8v+fxl8L
         ymcQ==
X-Gm-Message-State: AFq9FYJY7gNSjbnOhfPZcoD6AFRzlPkJ2JDj531p45mdhajdVoCpBZz0
	lyXQqzuSZarZxR4t69f+9eIs2xSOeNPZisqvyGSjGigfWussVODVVyJpYO/vQVoa
X-Gm-Gg: AYBFou0yW+Vq0Guk688o/TVwMVgwEKQoXrTl56qxVHEbGhFY/iwp4K9gsp6J9e7cTls
	GRAU66zN3T2w7t9bP0/GLJXX8SOhsFLXPlFeaNllGFUMje4639i5xo2Q44NDXoV/egqjbALyFYt
	LigdZlouTVbHSNTrQSQypvYp9XxOM0NifwzW8sF1UyvjmR2d9qP4oHeAN0R1H6IEZ6kcpdeuHCm
	0QaSAQwQ8qM8gycEZo9V2Rymsnzy2YlWAUbmTPPSvtC7uV20LwcRokwA4MwQj8bsB2/CIvH5LrK
	XpZmmf9KqIED0dxQ4m8wXaJgu3P8lrEP4WWJ4P5ChgElD1GZ24AhkHjCUliYIDYEpPx6ZcN443J
	iLMMktpsYTzr/1Vv6/DkVzLEN5K0dwPjopkEPLmAhKw886Ca+rN+9ZK6hz9G2GbzD+2wVIq4BrS
	DXtcww2IJKeUPb1cmTLR6iMGYo1C6tbuylCQgKR7YaZyQfhNZ/f1bv4ARCpamiZLC13DeDTdA8G
	fxhc7akcf/6IzI1+k9mYVzlh2aJJajWMmUWCH2B8dH1bcS3pFJZKTIHTmoX95TZyuGwJrgSpyMs
	49BZEA==
X-Received: by 2002:a05:693c:415b:10b0:368:c6b9:d3c0 with SMTP id 5a478bee46e88-369e85080a0mr13138493eec.28.1793034741233;
        Mon, 26 Oct 2026 10:12:21 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f27d5bf8sm24878750eec.4.2026.10.26.10.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:12:20 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 0/2] net: dsa: mv88e6xxx: 88E6171 stats fixes
Date: Mon, 26 Oct 2026 09:47:31 -0700
Message-ID: <20261026164733.737299-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches fixes statistics on the 88E6171 present on the Linksys
EA4500 router. These changes were found during testing using a
resurrected version of Andrew's dsa-tests:

https://github.com/lunn/dsa-tests

Changes in v2:

- cover all of the affected switches in patch #1
- add Andrew's R-b tag in patch #2

Florian Fainelli (2):
  net: dsa: mv88e6xxx: fix 6351 family statistics snapshot
  net: dsa: mv88e6xxx: fix 88E6171 statistics type

 drivers/net/dsa/mv88e6xxx/chip.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.53.0

