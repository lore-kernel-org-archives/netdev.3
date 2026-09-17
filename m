Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695A768EA
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671123; cv=none; b=jrj1ymhvZXmYHaL8Xim+NerRr90fLylMk76U5S1HZbZG+pVvMbv2efmeAHcNVq30kegLa2N1HD0SofSA5heosKlrbVCnQFHS/54pEYaDUT3H9L+za/697Qi5TR/78CELgNhNip778VBqT+zGs7UUjcSM0NBJYOLOIxskHOUJWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671123; c=relaxed/simple;
	bh=OG82Jxj0msnRfSdpEsWnvtGSGZhhQK5dbyKLNfGJnPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJISiwhH2jwEONrR4xvhYbOX47IGV0SEUMRKw3CqA7m5vJztyfZvK9VQFzt5uuooMnu0A200YysbR3cvdkUd65eEArhnSByLvdA50B0tFAvWtsQAp6iMRuMGrJHa7sg3Nvgx99cund2J4y+fFc1PZGPpcMqftPsQmEBWKMpDcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SilCDE4N; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SilCDE4N"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso10547275ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789671122; x=1790275922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5m8l+7VKRFbWFY6ZRBtl/OLyMFvN+m0132oJVHA/W8=;
        b=SilCDE4NY9AVRKuyT4SXl3Qsnymi2jt5IU4h0wRq8GDKPAv5wNid379sU9kbnM0LnI
         Ls2Mj68iJGjM8mc6pFJxiySpyd26UIgaZfhcpUpVbAhSYEZs68BfzvPahPR7YzVAwepE
         YSK7DJFEXYDBRFjtFr6jcYAsSgA8nfTnlZAUtdKdalC1E3X5e3A6cBfR5ijomn+G499b
         nqgQHSgP9UW9kTN3CisdgVxWfUnGSzQJGmnJvXjhFyLw7pZgF/0npCQm693+xrsOXp89
         lSr5B2yzv2c7sBAszElEAGFj+uKQrx5vl2bA9uclqryAW0yen9uK7GtIQj8OcT+BUAs7
         FlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671122; x=1790275922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5m8l+7VKRFbWFY6ZRBtl/OLyMFvN+m0132oJVHA/W8=;
        b=RCYFwPfS9chwFdUjJvUYvtvRx7q/Bqz7buqV0CG2KjCxiu7aof08YpqtIBOZsyuem3
         smGHqCsgz3hikeXsxytU58ivB0VJa2c8lRtrSmJ9d/2FjTcVrlD4J4YvYoiW4Ph4kpr1
         EdM+2CAMNsxUFZaEFOwMSFIYfSMjrv0jKq691VetKIybS3sIrERB/1Ri/k/8owg7S589
         20NmPu7cgOdbY6BOT2oWjwnkzraZ1xVR48TyO8LuKlEQDPepRbK9eXAQItk+Xzu19FtS
         3+YfgBGjyX6uD16Ut/iWfH+h6+b/qQshnTRELOswJtushiyyVelKZMo75JSOye9hpiH2
         j08w==
X-Gm-Message-State: AFuF++kDLwe4QHkRNlpFTjWow96dJBDKmjWUUQ9k1CSe03ES9eD2hLP7
	2/t4dqC/WpqV5w2fe+0Ni5I4mTvu2EYTlb9LHWN/6NJ8HWlanjlxGiljhL9yyRRT
X-Gm-Gg: AYBFou1gJERZIPcEbzLt2adejgBTmvUhCkOYeD6k6gUXsMb9XbjbBYeKgrbKEDuj4Tp
	l3Wvc+ef1WoVMD5ukF3hRKzvuoiMPhGf3kevaRxz1CAAt71CP2L2vwzz9PIIlVfvP4LByixg+IT
	jECQEGhrDRkIZ3dheRjAauTWTWfB1jUD7Rhk2o9rBKR167wEksEbHEM/xO2Qmr59W9OMa5+5AN/
	iPBdPkHkYhaticrOkJJe7oGVs+2hPaE9rOUvTEsjNoeK9aNkoRyyziu3XMPiTDLn/EvLvw50SmJ
	MzmzDAJj4OoRsWV5kdK5mYkD75khIHF6E594eMr8jki/YHRotRw+mhAFy/axa50gMSwF4LdBy8q
	KTjeqU/klVvWx9nuN8QW7pBz5o6OyXlsJb659Xlktoe547i8VjAhmdUf4CuY/VYI6nZz2LGVhhk
	t0VXakFVQtzb2TGEDLMqSV5sLSx8S600Y4YoR5iKUUj/NOXUvDDM5gIU46dq8z6SWiP2Jz0FXuP
	OPriWYPEbTOJAzLR4QkKgzA8g==
X-Received: by 2002:a17:903:3586:b0:2dd:ad74:6d12 with SMTP id d9443c01a7336-2ddb1b9e495mr2575525ad.24.1789671121625;
        Thu, 17 Sep 2026 11:52:01 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm31032655ad.82.2026.09.17.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:52:01 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/8] net: dsa: motorcomm: Add SerDes PCS
Date: Fri, 18 Sep 2026 02:49:47 +0800
Message-ID: <20260917185010.3189199-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support in-band negotiation of the SerDes ports.

v3:
  - fix build error
v2: https://lore.kernel.org/r/20260916164310.3168269-1-mmyangfl@gmail.com
  - Remove YT921X_PORT_MASK_* macros
  - code style nits
  - unconditionally write BMCR_ANRESTART
v1: https://lore.kernel.org/r/20260909190541.466476-1-mmyangfl@gmail.com

David Yang (8):
  net: dsa: motorcomm: Remove YT921X_PORT_MASK_* macros
  net: dsa: motorcomm: Split xMII and SERDES port masks
  net: dsa: motorcomm: Check port type with runtime info
  net: dsa: motorcomm: Fix register bit field names
  net: dsa: motorcomm: Introduce yt921x_speed
  net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
  net: dsa: motorcomm: Split MDIO bus module
  net: dsa: motorcomm: Add SerDes PCS

 drivers/net/dsa/motorcomm/Makefile   |   2 +
 drivers/net/dsa/motorcomm/chip.c     | 525 ++++++---------------------
 drivers/net/dsa/motorcomm/chip.h     | 106 +++---
 drivers/net/dsa/motorcomm/leds.c     |  14 +-
 drivers/net/dsa/motorcomm/mdio_bus.c | 301 +++++++++++++++
 drivers/net/dsa/motorcomm/mdio_bus.h |  54 +++
 drivers/net/dsa/motorcomm/pcs-921x.c | 235 ++++++++++++
 drivers/net/dsa/motorcomm/pcs.h      |  13 +
 8 files changed, 793 insertions(+), 457 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.c
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.h
 create mode 100644 drivers/net/dsa/motorcomm/pcs-921x.c
 create mode 100644 drivers/net/dsa/motorcomm/pcs.h

-- 
2.53.0

