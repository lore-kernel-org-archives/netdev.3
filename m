Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A23ACF10
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836427; cv=none; b=onkOT4tYmpMjWzGeIe5gJZ/LTzKH4lhSgHV8fUXO0nyI6jBteYGwGtHPNoudMgm95jO/Yd1P4YQ/hJOU/K3/3kUmql4t6PwJTNgUkxmXDR/ZPep2vSMQqLxZ87rZW7++68zhXDvKs0dBJJGRmg0GYC6rSUERBi70J4EKbd6savA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836427; c=relaxed/simple;
	bh=/scdopOPthix25Nqc2yLeLuy9JI1gcxozcY01DS22lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBqS5/u/IoG3FBqCO/yvPCaTQg8V1F+u0xwQZ51h9TmFNVnlg57rtW9zbjvIC0az4PrkuGl7SIYtSXyBtwIWvGDVGnw1tkiXt1L0Ni0dEomoFVk8YHAT4OYe8Cql/SEw65YeuFM+SbkqhlVesQyJMhHbE58bMu9Ny1d9FiHF4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSo/OgFj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSo/OgFj"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf452def93so7286545ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836425; x=1785441225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+sAT+OHFskFt5xNReSlYNg4qidsM00RmPKUTMmAHMQ=;
        b=KSo/OgFjZGdl+b31pAQynnGMOVFWkqOLJJhTjxzFn+L1vivu+CN+WcZb40O4TZYYzH
         6s+rsmWPXKTeZf1Y8WfxQY/ieXTkgPJruLKgEr/LnY2/3662goajCG2ScC4Z4zcUOSBq
         +Jg5KB7AVgTdCwz2/T9LE4s/s8D8elhmATm/DGuako5/+so7MFF0LSBBHxDG6GpyJ/2R
         wB9heti9j90CWyIB8HFelYLqRPut84cJ2Eq8BBPk+WJ5vy7ggrsMMoaHDRo++HsQQvu7
         2NPoDw9Uke267XL3fNzXI7pEYKZ90sMFMmNhsxSXlek2dseJDKYLGKDI8u0FYrA3gwp4
         Q6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836425; x=1785441225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O+sAT+OHFskFt5xNReSlYNg4qidsM00RmPKUTMmAHMQ=;
        b=QV5vKT6y94XMCUEqAuyOn0ch1xF4m1gZnpnr2nWDQ6t4brEP7fiw7IoxhJPTpNgEnF
         vvk4UGrd7spRKb/VCLkOzq7l11zA7PdPUFKmpn+fYRPL6qx3FuDAWzmTl88nnGmLnFew
         rYAuFR1xG65w1P8ULa0FKGM5dUOUWAa6pqn27kSUsIUFtpj0I2Mrb0QsODJGZAGdJpNP
         cPY8DuzjRhp3EbH3YHfREMhwhkVtb8BX8JVb0LFu+BCRnkvXkWfZSGwKISFmmSTCT+ib
         pkw8zcYULgeBnW/9X4oXOyCtWtvlUdy2WXxQvCU9/ASKe+eYSznGaejIG5O7dvOydAzT
         OMWQ==
X-Gm-Message-State: AOJu0YzGtFOaeGWhx07ByvBfYyc24RA25tsHCoI6okaxAmAAfRKyGq33
	+gz/Lys/FZ4cd8VvKqMqbMFyuiLIWny372ZxMPiz0MXCx7XpbRl0kkMEuUW05MFo
X-Gm-Gg: AR+sD11slRLXYzw9LQ7CUMqony+bI7cp8dQOjPnMPT8LHfy/GaKPRJIbF+FCMx8ynWx
	cyvsZnT03bJfVSstsH6c7FUH3tgaNBIZ3FiSZcYYSlaeQY0SFOLc+VDW5xXBkTq5kPN4TZhjshG
	GuC9BKWvKsezYFLbAyES/s7DcpNyREzEa0r1vddLSXbgF4kREsuD/9XDXFZ8mKzfFQIKRqu3Kgo
	6RsPeNV4nq7mHuveXFv2Y9+Xqfi70ZD9WT0RITWLyerM8ccNQEIwtzNUeRkV1r+jxareq9UpD6L
	ax/Y6xK3KV2fX/56ZrBxJ/gy+zhZqvM3gBKf8O7LyJvZ6QaUSDowMun36o0YK0MJ7QpubSCdTon
	4Y2K53h0cFOONgItLsVxCobp09PPOcXCpayvErHb5y+ys2HnfRnw5bYaZw/G1RUt9rT9LUXCzm2
	5Pz5fcaYTAygcXr5SCICccXPJWmlF8
X-Received: by 2002:a17:903:2306:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2cfa9588d7emr48697615ad.30.1784836425423;
        Thu, 23 Jul 2026 12:53:45 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f310644sm39106625ad.55.2026.07.23.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:53:44 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/3] net: dsa: motorcomm: Add LED support
Date: Fri, 24 Jul 2026 03:53:29 +0800
Message-ID: <20260723195335.806002-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6: https://lore.kernel.org/r/20260709014812.1158178-1-mmyangfl@gmail.com
  - per-port initialization support
v5: https://lore.kernel.org/r/20260707064752.1030345-1-mmyangfl@gmail.com
  - improve trigger selection
v4: https://lore.kernel.org/r/20260703165241.542195-1-mmyangfl@gmail.com
  - fix some reg op typos
v3: https://lore.kernel.org/r/20260701155519.273212-1-mmyangfl@gmail.com
  - fix null pointer dereference
  - support polarity auto-configuration
v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
  - allocate LED structures only
  - eliminate double locking
v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
  - set up polarity correctly
  - do not set up .brightness_get() to prevent dead lock

David Yang (3):
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Add LED support

 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 222 +-----
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  11 +
 drivers/net/dsa/motorcomm/leds.c              | 647 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 121 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 +++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 1063 insertions(+), 219 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (96%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (99%)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

-- 
2.53.0

