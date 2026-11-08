Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131165;
	b=qQiilK7eMXyMeGimeaYYeQCwm9+LubT49/zoq/3KpWJu3FPqKYui6wbld/gNveak8vIf
	 pGOc2GykoHn+Hz0sEt97XvkhQDM14RZPTbMbDeNkLYr+hwIC9UmoBfmtLBwVnvI/Y9RFk
	 7hIO0SexhhSNBZxwMoikLlexJotzPzSCcKcZ8278JT8Ac+rpiFKKLMlKdhCHr/dtRtaxA
	 MVOLJ64hJ/E7abZOtyIFhz3PC/eZAE96Z4ir3i+pygccR9ffxoEOAmcCIJwte/zKci7bX
	 JpaRIiP+s21KtTyy2ieN/8MrCEQfHTR+yw0d0DWRbEizhkVQgauPUDvAE32gKpPeMvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=D1K0wrjeRxXZkT8OyeftvPsGaY/KHPkSXaBR6fxBie0=;
	b=gP7sOaOp+qwB42TjP+ocniUfeBxESayXFk0VePOYG3Pul7qFr5cw1z/IpnCUm2VRzXIA
	 pUOmralnzwrNTX6n5PSKgiOb2czTT9kUvUD6muQZHPWW/LdDG21M1oFmQHgqaQOrQtrwf
	 GLzT9mLBeH9D0l5CeaRhNpmdeYsYUK6fxOIq7RpHlJtV1sA5bZleJ0XzgKG2t7VDr6o1P
	 FQb2gXr+ByGOD6jfkZ6lgpMTVZpYIESExd8Ehgi6em3s6ovbpj8WDiPn+kr2U3ZBy9B1D
	 FvLI0Nl2ji2IEZDttZcdklYLJKWHC7GDNtGHuHfpUx3iTmIFGBllJAJhJF1qNmZvqEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6kizvfy;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7B606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 09:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A7B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6kizvfy
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so90240a12.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 01:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131164; x=1794735964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1K0wrjeRxXZkT8OyeftvPsGaY/KHPkSXaBR6fxBie0=;
        b=P6kizvfydJEBBrd67EW+ZuJceoQtok8mvajjLX1bbZYcyblT69RDSyyGmIvodHkDRD
         gIipWpBC9yKMmbpRGSmXdk6qO5/5NngYLoXoy5LU7K8cXS7HAo2Uj+7LyjtB+T/NSiAc
         8VmP3ibaXdqvZXsfuyvq3nroSmJuRGRf9OPVJOK61xdisduR4jW5S/qs3FTZmZaY50Li
         n9nDFR8+inTfiLt2LyA4EdbWlTA3EKgwWl35KfLIg1c8zOarAtJ3zfOfBlMsDOCyx7q0
         ZT+YPn5MqBGn8lzhHQlxM/PruosuuhCiaznd8f14+kPS1/UDaDuCdFL3uD5QWswYeo5S
         JmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131164; x=1794735964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1K0wrjeRxXZkT8OyeftvPsGaY/KHPkSXaBR6fxBie0=;
        b=SbAtstU2wlqD/kCmRlwSFEjkUVgSTKID84i2t0el04+YwaXm6rTqMLQUyr3mR2O3te
         NPbGVo1AjCHg8e5JweUDsSKPf1lkwboFiqSNWFiJUJ0CVrcTbFGvcXeGrUEAicB7+Q64
         ZzRr5bwQYZxowbtxNkm+qKpb28HU4MQZ/C4XGp54zTEqganbPzBiZP/IXSURPOZ2zjiS
         t0OIG5ZwUAtagJQJl9WOVdDrHrVyaVvyzIVz8SCMn3q5Z6kxdgR0kDag83nYX5Hc4J4P
         E3meGUKHHPPNLqlbzm84UfQTFGfYcFwVZF29qm32V/JyrdFM8Pw+v2lIByiYaYyzvX3v
         He1g==
X-Gm-Message-State: APuU4Z/+95ddnB47oTnN3buyX3JWdenm1ovPI1bq58yrw4jV2zIU1a3u
	hT/w4wLHOItu7B3Zvoksf8MHDzrZFzFtjuSPMnBsYhvopNFv7nFqyP9AgIp9Fg==
X-Gm-Gg: AYBFou2MIUnEkifzg9XSv1SU+P349AJ+djqlgB+ViFpQc1X18HA1JDdPc3bPX1H/jbU
	nxXkr7OVBShyaOSof4QgfvVQxj04V59Lv5qN0NLrVrOZ7Puk90bGr78dM1GxA//4UFCQJLZGZYi
	5fMnWXu4We+x2E1ZoKqUiA8lpuREFlE6W8ud4MXoyay+FjCo3hIM3Mv7Fo+/X+Ai8fnoGVP2O6G
	jugIocA0eGy6O/6xlyyqWyToD+8bC8nvs3hfy5LSRucIHpHGuaiHy8X+XLhVlmhUnnc8HxK+LtN
	x3o0WcgWO6eZ1pDIDiWS3twH4qzS2Uh7yvyum0d7NZTGp/1dFSqis4Q56AwtUq/3I2vKbusxyoi
	K7nuX3xFJsWHD2iPrUypQzz3CPNFzfBgkAJhrfIYXRBbJkRk9ChpVWSeMJqdjO+Pl547YFnm4W3
	Njra3KVgG/ZYgMVlDvvKbkKkR/ftB6GpmHdTiaEj1ykQsDy4VOjn4rEBAsL1A3M4Rv6ASLYvP/x
	ogwV5I1oraDnRMeM2gUBBOGAqHRgixHxoxEz7F/DiD2qYBrY21r0X2ZQ2Y7lUngySdHTXA235Wr
	3ALYJR2S7ClOtdew/TcabMQ5EraQblEZmfprgtUdxjjFdXN6VsubwQ==
X-Received: by 2002:a17:903:2281:b0:2dd:ad73:c987 with SMTP id d9443c01a7336-2ed837a83abmr9322425ad.31.1794131163926;
        Sun, 08 Nov 2026 01:46:03 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed813af834sm3222715ad.0.2026.11.08.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:46:03 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: dsa: motorcomm: Add devlink info and resources
Date: Sun,  8 Nov 2026 17:45:08 +0800
Message-ID: <20261108094512.1285796-1-mmyangfl@gmail.com>
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

Add basic devlink support: expose the ASIC id through .devlink_info_get,
and register devlink resources for the hardware blocks, reporting ACL,
FDB (with unicast/mcast/static occupancy) and meter usage.

v2:
 - fix issues reported by sashiko
v1: https://lore.kernel.org/r/20261106184811.350700-1-mmyangfl@gmail.com

David Yang (2):
  net: dsa: motorcomm: Report error when FDB fails to add
  net: dsa: motorcomm: Add devlink info and resources

 drivers/net/dsa/motorcomm/Makefile  |   1 +
 drivers/net/dsa/motorcomm/chip.c    |  63 +++++++-
 drivers/net/dsa/motorcomm/chip.h    |   4 +
 drivers/net/dsa/motorcomm/devlink.c | 216 ++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/devlink.h |  18 +++
 5 files changed, 295 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/devlink.c
 create mode 100644 drivers/net/dsa/motorcomm/devlink.h

-- 
2.53.0

