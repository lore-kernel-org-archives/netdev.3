Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB9282F0C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151749; cv=none; b=nb/u+IyaAhy6zjcUYH7k6qOZetMndwrjqoUuaDD7k2+kfoeTNxb4rrlkEk9fQjL+e/xO767QF+nYTCvwzZLo+jBX5RcttuZ1puxQu8VAM/F6/hsWifQNBkljApzfoYmScFic3IRMn9q368ySOcMZ36rNB8uCrWkvctkULFArAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151749; c=relaxed/simple;
	bh=gRjZ543JpnkvPdOiYYfaRnVfystG759Aro/R69ofTXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6PXSYjp6jgeaOm8x/HveOMGMpf6JOSjA+WTTmjSdFNxb7evIJb5VbYJt1wvDWzCYrHZVlyBiDdjZEqstjV6s6M0qTlw3qhgW5r0HunqrGNUIe4IIHTO2GGEDeJh+OYGm6awBvGIHf7YDRjWcUGWDJPnMexWenAh2X95SZ9awHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqkTYyMH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqkTYyMH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d91ff7d9acso4555485ad.3
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 21:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151747; x=1788756547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g6UxknVhwES+fkCV48PrpOtYW0/olM82VS/wYfSM3Uw=;
        b=AqkTYyMHVjFiA5THOgWEfyFALqCL0x5lKu3eaVtmLO1wMWK6A6OAmMg8MX9dCCZGCR
         Ai5bp1Xo9IHdyvZYH7V3YEJMSNpKO0VVzMv3Z1R5WGyCwT6ch9u8xLriFqtPBthjB+7c
         VYXGv/t0VnasctYfQujLLxioqFqUyU3xYv3pAv1BPGLV5KcF8mi4Gx6yubY6IaEse4M2
         kznaXQ78Yi2gF0XEeeeZVtxQhSjq6caSTxtQ4fWCY58qAc/WE1TkV1P1HUItG/iumDtC
         pnBdeoXyC8pU6W2xTugfGDWLCtRuRoXnvA1lGmYGagmwdvY9Zc2fxkl8gfZJo7dna0LP
         vdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151747; x=1788756547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6UxknVhwES+fkCV48PrpOtYW0/olM82VS/wYfSM3Uw=;
        b=lpyedODMgURApQfx4VxWtEJ+kdhWVvY4W5+gzNzjJomjmHvVHNObf8EQDEeJcqZ3Rd
         8RZY3jSdldxtdY9AKeDRv4k+C17sF/duLIqN+ofbvHxftGSC+2j4v7KgSUJEMCZJlqh3
         auwCAu62pXNaF+ZjRCEGmz+QUG0gfAOHF+9T2TF9Vu2SRO4tgxNO30g9keojffJX2oAK
         xNrHbu5xdDfHJVOodteOSTCmBrCA9I+hh+FH+fWSTIZQsSlvAQBfS5CuJYBivMWef8dv
         bYuaFbPbWRSZA6sWKlm7ivJe9f6Q0li9Cb/QWuIhk74TQlIAf0MNKpOJfGu7z3U4ca5f
         KX8w==
X-Gm-Message-State: AFuF++ns6KcW+vUDWCRBolXZ1+SY6GqQaYIKuMQ1cwQGPpigQSNEi6rN
	x/1nR6EMwh5TkQORODtDMS+hbcrRcHwvA7kSe1LLs2ke7sYQZGj1ehRTO5u6XGGy8K0=
X-Gm-Gg: AYBFou13ecToYr1uACZg8d80FPCFvc6hMIhvVb+XGFb33MSFfpEox6JVxi2JGRWWWrc
	h9YlYKCJhboKUaT3nG7oBkDaxjZOTaHC4naChF0ZWH+BsDwTP2iBqOfaSKvKRV8wQsruwuueqBg
	hks9tRxrLVIOOolATPWz5wuxqGNEAC7tUa8D3axxmWeiabL5v4c59G9ulu3uafsX+6uyZT/nEFt
	K1mk0gfjVTFVij+54vFj5xKW1gkEOwHtA+DueI96x5R/HDYlwh6S4jOVS8F+4ZySc7qMi0QhLnv
	hWLfiQlJq0wM4n4dcfOMUL8YFqDsw6EoWIxSbWa1Hs4YPBw7ZEoXkZLWA1JLXnxrsuT+37YRqxs
	epf3K/cIoXRNyGiE+f53Nmkj44JSZc2FZ2JAD+I8hVetb9oG5vNTTVdqQAFaQ67t7/AxcYWfbby
	uR7PGv+e1T0nbqEhEKaH3FNZha1z/VH2oBNVqGxRHHDUHw5zt/jVKgSpH20NFN0u0JUTeQMpZOc
	pRuH71HXivL+g==
X-Received: by 2002:a17:90b:4b05:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-396d0fe2140mr36234553a91.10.1788151746977;
        Sun, 30 Aug 2026 21:49:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:2e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm19345763a91.8.2026.08.30.21.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:49:06 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v11 0/5] net: dsa: motorcomm: Add LED support
Date: Mon, 31 Aug 2026 12:38:53 +0800
Message-ID: <20260831044818.4103477-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LEDs can be described in the device tree using the standard LED node
notation. Currently, only parallel mode and strict 1:1 mapping (i.e. the
HW default) are supported.

v10: https://lore.kernel.org/r/20260816193905.218112-1-mmyangfl@gmail.com
  - new patch to fix lock status check
  - LED control block redesigned
v9: https://lore.kernel.org/r/20260726162731.1005803-1-mmyangfl@gmail.com
  - LED initialization sequence adjusted
  - add DT description
v8: https://lore.kernel.org/r/20260725045008.858692-1-mmyangfl@gmail.com
  - limit the led port number
v7: https://lore.kernel.org/r/20260723195335.806002-1-mmyangfl@gmail.com
  - rebase
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
  - do not set up .brightness_get() to prevent dead lo

David Yang (5):
  net: dsa: yt921x: Check lock status with lockdep_assert_held_once()
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Add LED support
  dt-bindings: net: dsa: yt921x: Add LEDs definition example

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  23 +
 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 228 +------
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  15 +
 drivers/net/dsa/motorcomm/leds.c              | 641 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 118 ++++
 drivers/net/dsa/motorcomm/smi.c               | 180 +++++
 drivers/net/dsa/motorcomm/smi.h               |  61 ++
 12 files changed, 1083 insertions(+), 219 deletions(-)
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

