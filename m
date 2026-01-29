Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094637D11D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676800; cv=none; b=G6dX4m3FiDWLcBFtoobxnwMUI/B6vny7QFjWEifECyGaMUBot6+AXO2dCPIMSVt+7HJNfLBh/pnBVRYVYriceiZc6U87HvJtz6axn8Q04dBHKqsYodyFsIPvdur4/+pkmzbxJN8t6y9p3cvl/ZWXA+8qZLuLIEmBgaJJ7fNCpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676800; c=relaxed/simple;
	bh=1yg64/14VJRK2w6WnKwz4fsy8uNrGXPr9neA0RouPNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ursG2Vy62OpJockMsldcG4RNQtx6EH26to757tPnEh/DGrqA5o01LLLwSwCafrHx2N1JHJL1iyCtuOygwiXDCTBzkfqXFMZ7PIdZ+HqvnZVhC0YCG1fURXXqK0LOW/wYBmaPg73lyOyPTSxPPMeVCnG97+AQrtd+SDFad14oy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G21snu61; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G21snu61"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a09757004cso5642995ad.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769676796; x=1770281596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5g8ahlF07iR3ucOCXhV02sHjvRcq2RGPtiGM7IKD3to=;
        b=G21snu61mpgiNhHEtb03LlBBfzbQYTYttikfjURoM0dDVkvPDZ0iW/Si7felL2VwrV
         Jm0alXalXYwfxGbrrF6e5DVxAuZ6nU1TDerGDGRXKACvhlu/jJwvbhWE7g4L7hNfO+Vv
         ChMhfa8DuofIUuuK1dbqNHt/1DM77k2dRiXUwmm2WLH2pmclqDFe/+UzImjnJn0zlNup
         vYLxA8Id1To1xZ2GB11ctHLXEMiJ2rijs4E69HGgBiP9NV0Q69mtmZtUTMG5kLVmb+Vh
         9tKlOFqxDSAljhptWDcjRhNrpNNBtzcEaN7Qj5XnrvvBwEUmuEl0XeDCF7+3HL2TZf11
         s9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676796; x=1770281596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g8ahlF07iR3ucOCXhV02sHjvRcq2RGPtiGM7IKD3to=;
        b=SWTwTZpz1wW544oP/p7dW9JqpCds50HD3U8W66GeDBgMzTUfZoWkeRA+W7XO7TBxAJ
         Y39rcrpjLv11lUs0Pn1cE3OPEaynDTNCQddCmZYkbVC/ACiAhCf+aYkFYukjetCH0Nrz
         ABbXpMlw4V+hg6H8TYXgBCwqsJdqmYvRHaTYhtL4TILgzt6czfjhfu8Oxoq8uWH0N/62
         yZJVMRl6R7BHFC3FfQd+cwAR3MJlaul15FooRnwMm7f+HBpA6rzugfbxAF0WQZnGidNV
         iZ8+tNvlbCEG/4sSVrxYTa7uWbCiZWf+eVk7yo598z6bAtLn+K/3lLuwepPrcYegTGrr
         0TJw==
X-Gm-Message-State: AOJu0YwZyYjMIf2UbNdnkgDDLgNscvWJuDbhECT1EK3iq3nQBr1mhGz+
	fpImQmXV+4PNwSga7X233nuFiV8JvJG7dZ4EPgio9dRDzSgvA911W0UcYqpM2TZl
X-Gm-Gg: AZuq6aJ3ZpFmDSLQzyQB8wJzNsZ5fIL5c6YgRXR9wCB5GQx931QsYQlJBa4NzGek7cH
	/z9q/JYDWTL22IlGBelH0s7IaommT+RoAGvngl9MlsyphGg5ZoZqO9DH3KapvZgsFQWQ0R4g7Kp
	FCvv1VzTK3SPtZdB6u+/GWx2EC/OSf5xkVxJ7P8RYvb/WbipYWb+6E8z7mnZY4h8MFe1oZlyfI+
	9NvBcvMuFD6EOmeAGsBrBCHdmZcQ+lUioxRNZaXt4eJ503bC+3c/VsKaWIhqvoB7et/LwABJo6K
	mRML6GNoG2fZNeJe4DXp9/wjOWO16kQe67oCRvdTwfE358rdSzlfQBnwG1ady0IUDncFewKtaJr
	v8XFS4QwKI3syqtnuOg66aM7fDKNknCRDfH/wceAkWZbsIU40pL14JkZcyEIGgj08EPCi2S1K3a
	9ceg3PPftgZ3ZHznMGautiJBW9WSfJGjZ6/9g=
X-Received: by 2002:a17:903:2446:b0:2a7:5171:921a with SMTP id d9443c01a7336-2a870de6518mr79763785ad.54.1769676795642;
        Thu, 29 Jan 2026 00:53:15 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef50sm44651165ad.12.2026.01.29.00.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:53:15 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 0/4] net: dsa: yt921x: Add tc support
Date: Thu, 29 Jan 2026 16:51:32 +0800
Message-ID: <20260129085139.2767649-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support limiting the rate of incoming and outgoing traffic.

RFC:
  This series is intended to be appiled after
  https://lore.kernel.org/r/20260128215202.2244266-1-mmyangfl@gmail.com and
  https://lore.kernel.org/r/20260126061340.757543-1-mmyangfl@gmail.com .
  Sending it for early review.

David Yang (4):
  net: dsa: yt921x: Refactor port error message
  net: dsa: yt921x: Refactor long register helpers
  net: dsa: yt921x: Add port police support
  net: dsa: yt921x: Add port qdisc tbf support

 drivers/net/dsa/yt921x.c | 543 ++++++++++++++++++++++++++++++++++-----
 drivers/net/dsa/yt921x.h | 111 ++++++--
 2 files changed, 566 insertions(+), 88 deletions(-)

-- 
2.51.0

