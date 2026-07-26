Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1133CF1F5
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785083267; cv=none; b=ErZgZ5xXvV86+ucMSjcAssTT78ck27hnuZ/3zRLc/X6poavEYxAdwcCWpjFhsHjZj905BhgpaZcP3AId6Uq7BYiIpEW2jXG/CbD51Brq/cM1CBH2larbpli96fU9fMKkOiI4nIUsOu7mOtZVtmImPprj+hl/dY4dyU7rgE/jNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785083267; c=relaxed/simple;
	bh=vSYN5IGF8zNF7syT2GgnaGIgQxsoX1vYb6MSX5x1V+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSPiQZF/zk8XOWsxAaXHHuosHEVB1Tjv7znPrPNRrhgz/QMzEGmCIRBy4nMQ3jkJSRt+D9MsNWwdAgVcLEwCcikDGpXSQzUa6QcnZ55gDXATfoHXtb5BWSKR0ifR9r3oSjgM1kRPDDPRAWcoKXsfC8d0cRVhwi4daUpxRgb1L/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO696g+5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO696g+5"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad4170e8eso29255355ad.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785083259; x=1785688059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h8I04VFiqHbOsB2MvAhPhk53zMmratLXa+0+BOta5UY=;
        b=nO696g+5Nz96uDII/UpoAjjKQrDMKHbCEBloXT1W3li23KvgYq59pHY5jKn5cE/Orl
         1JYfVi2i/3HVhzxpWak7OIi/0IGcdzHRnnfR8w9VaTZDp1LBdWzS/wq7fA8kEoLkAyNs
         nxK0VrtDJKwSvEZXvgO0uaKHn5rndI2hiq5iohLUfwkTgAwVKE3JjaoABPy+jwqgT7NJ
         o4A81f/pMlsew91tppNMLlKcqh5IPrtwQznXKvef+u1FbmAvoE2iIix226LXVFa+BeFL
         6kENPRN4NSRMxEkHky2NHisPRsEMn2xKBT1UKjgBMx+Exssc5YvZtMw+eMyhAUGsAQrh
         B6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785083259; x=1785688059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8I04VFiqHbOsB2MvAhPhk53zMmratLXa+0+BOta5UY=;
        b=IU7Naovcr4RsPU5cq6omBTYBXacjHQ892xMLiHV1RpY/ETx3YtpDvLHKABpvKCFu80
         UNc4mWO96lXU9A825ckhCw35d6HVzS3+zrTU4Pmyrq2hAy2DqDDZtHHteNzqMhpBtGqX
         eDP33+RGmWZvRUMzcVjoPLW4dxLPY2Yu09liwYyPDTYCbHKqRikenCcCdIJIinizxxrD
         bYDsXI/tsScDfynjZ1xsdaR93hfySp8RanCb8Fp/XwRC3j9BYShjes+JW568CcsR+ZmG
         mh/R9xP8sYUyzHG9FakIZ/FMz+GRX6y+x90RmXkORwjO7SHZoOlwJM7yU5yoKQiAXRJJ
         Bpvw==
X-Gm-Message-State: AOJu0YxrD9bgB2CE+6jWBYmNgwobQQy09nRditOWvrcVfL+n9r2SKamN
	hz8h+Dhi5vtJI+U6EbcgZdyMhV/FJURBNWNNdjj9t2bdKrIsWEQpj7hzeHre3m4s
X-Gm-Gg: AR+sD13Dp5YwDB3Ubb+tjGcUTNbfovPctrlywyUD7sX/XDZfwZVIxfBj18exkcBd5bX
	7IeV8a4rnVvbJaQ1ypavl3f+aYZEqXLiz7uHTOQuKDs3uSjsZ2jMk1eNyYzAzzAozkoacMCrDC0
	ctedEXCnigYLSkPHGv5GZzAks0LsmkXFM3lp9zC9ZwAaT9Ee80cD9yS/eljmRJOrybvYlkOAHLh
	2Ryx4pNlNK4m9pIBdO4DlhqmoQAM1O12O97imU2+3xta7Ku0ak50R2Bg/l0opwNP9YU/NA2viSc
	HoVLLuWUKopSPMnuv/Kzs7Fdaa6VvKapnrApAk38CZYTiimEajfnKZv7LJGrwkZxmXJto8BBcg9
	OU3VnyAiCk5d5OZupgQp5rNEo6Lx5lfT3ORVf6KUVulArx0nYjN647QtHG6v7JHicKSv4AV/ZQr
	u+93BTpuIdvOYoC6F+fgm+kuZd2fdw
X-Received: by 2002:a17:902:cf10:b0:2cc:85a7:36ee with SMTP id d9443c01a7336-2cfde862db4mr49961095ad.32.1785083258935;
        Sun, 26 Jul 2026 09:27:38 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdc2sm22124325ad.42.2026.07.26.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 09:27:38 -0700 (PDT)
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
Subject: [PATCH net-next v9 0/3] net: dsa: motorcomm: Add LED support
Date: Mon, 27 Jul 2026 00:27:26 +0800
Message-ID: <20260726162731.1005803-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  12 +
 drivers/net/dsa/motorcomm/leds.c              | 660 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 121 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 +++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 1077 insertions(+), 219 deletions(-)
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

