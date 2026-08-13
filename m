Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0531F9B5
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607403; cv=none; b=Rl3/0fO0sr7l+Sbxx5bn9dside66C0H0WwJD40p6mBkcKTIeCEuz4ma5z/1gEDnpk7I8I4Auy7rUj9rHcwysS6LeV3hf0vwxaCljwVQwHl49CEqKbLLw+G9cm+ZNWWNgsEAFp7v+HOo3LHgczktOIOgMH/f27XSo4EzgjUqFDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607403; c=relaxed/simple;
	bh=Z7PZv7lkF2f/2APsSytzL4xAa8qnNQPmEwjqQXtITU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IZ0Vwzz8SY4tA4+jrOGP17KgjIRcyzXfspfaWSrEZZAgC2Ai77EiL153IEOCLzrfLMQmZ2p8gJfqWIsdwsoOsG+r2+GyJ5xZNyRWg7lGaNEtTD041kFMBWYfiUgEMfGSgPU0LBLpj4zJ8USfhfok84KgdnwznTjMJExOxhWi3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaGdyH7I; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaGdyH7I"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so2954315e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786607398; x=1787212198; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hvNjOb0PYgKb5i1b3A7SCqBWH5+crd0NIVMjDXNl+Sw=;
        b=SaGdyH7IbKHKDesgDdNecgwmOOPw3M1q2imG1sofbWt7P3OBbajoDOgkb4KzTYW+lv
         on7pCnVdfX6Cw4xqIS3DvKUK/OaeEp8ycIn+oPY1DahQxrcAmIjtG90+CMaevNgRpVLq
         U2Y8eHz2UaQItRj/wMshp0ro1+vg6gQYF9K0oL8M1L8MvHPOyulj4HDqExLCvx995WJW
         vKs8UcCqd76zGTbT1p17HJcVHW4oJOV16eu8tbqWcCAzZQmusfi3ZXfP/k5zqNNgVaBa
         isRIPWdygYDSt7pDTd9idrtUDv+4DvSwEU5/L3ThRS3y8OGhjvOErz7fYuQ8TODbN8vn
         3K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786607398; x=1787212198;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hvNjOb0PYgKb5i1b3A7SCqBWH5+crd0NIVMjDXNl+Sw=;
        b=njHt+FUjnhVFfBccloyoBHm7cYr7JzQ2d0OVeZfinHKQ8+YWFZILyNtjhwEjgWCFX9
         2HPrjGmFPBZyoO263Qs2vMQiycdn+jwJu9LWIe5uNhFH8LLQvvgnstZLZR0rZd5ha+vn
         mi62xzWy6XNz4/qQHlphmOAb59bz3rPN7AvFH7G2Z1ddYXMCxlQwqYAV7yeXW8zBEIdM
         QV2KDXnCk6brvTM9AJn3pKgMzE8wZm0zcDq55aQMhcoQl1h6Mjg2/EQGiv/zBP+whX4x
         6lG5hy12Lqbh+Mwx2TFC213djgzBtDKKR4/iiYXugqWBqxKWMOUAu9NA2s4pRK6aS/C1
         X2rA==
X-Gm-Message-State: AOJu0Yyeeo8xzjVzAKnMHPlPu6vK7Gc48wX/G65odT/4JyGbL5tx2+Ez
	W2u2j7ayEB1AcoeZlJ4QJVcx8K5VI9qU03prMi/kyCB5Bd/GVpjaIl65
X-Gm-Gg: AR+sD109/vKUyn3RV7dTBWFVgFyLUVsLcgL6ZIsbEntj2JKpsB8wLWjTKfd/O3o4jHW
	RRhkuCbptuHIFF1IXxefV1beJCIlZ1qFDKuvVvypDyPqYjirrElX1p3fKa5ICB1YXEJCM7NL0DV
	ILlSOLbZ1JiflfKG262rppMyqAhe9TvldATYywvuLpwvKdPqCNzs5lc+JfY/HaCBTbVN2zdABKx
	YbIPp/vYmoIrs/NurIz/XpRBQAaE/YoVCjVZXtgjMH1boFuYzmu8gsaJkoFYhRC1GoE8q3N42K7
	pjmYhHbxj71cGeEETBl4p/PUX3U+noPgYfbEylXDGCD4GUkm4c6qDTHDOeOlMQuDfF8zbHBknh4
	gs7Etrh8PWvLDNyu+wVOlWNzMdt6mpo5kognRCSzkitzrYjpo2EIwLX+O67JYDtkSi4gUOQOHV1
	IQ7R94h4z9VAWCQgdvyLWt8GppHQmU+6pBDDNOlfUM1O5dg9DHUkBYYfYegxIUOu8SXJJFPxOe3
	q3l7Pe7klENzH7XSMvq6U6V0UC7YJTQelq617Tg
X-Received: by 2002:a05:600c:3556:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-49982154908mr48444985e9.3.1786607398055;
        Thu, 13 Aug 2026 00:49:58 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62894sm41936365e9.13.2026.08.13.00.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:49:57 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
Subject: [PATCH v3 0/3] fix the MTL fifo and DMA race condition
Date: Thu, 13 Aug 2026 07:49:26 +0000
Message-Id: <20260813-stmmac-rx-fifo-block-v3-0-738acbee55d9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZ3fWoC/4XNSw6CMBSF4a2Qjr2mDyjgyH0YB31CI1DTkgZD2
 LuFERPj8D/J/e6KognORHQrVhRMctH5KQe7FEj1YuoMOJ0bUUw5rimHOI+jUBAWsM56kINXLzC
 2alrFGttyifLpOxjrloN9PHP3Ls4+fI4viezrHzARIFBWQuK2lFxheu9G4Yar8iPawUTPSP0Do
 TuiFSurWjOi8RnZtu0LADHXff0AAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786607395; l=2551;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=Z7PZv7lkF2f/2APsSytzL4xAa8qnNQPmEwjqQXtITU8=;
 b=A/i3S1pHv+HZqfpzdWOkimYcHvIeLijiOg8jpxRANLAXbZaYQ+CFCLDTpOyt3sDYOrIBHwBqq
 EdOnHUba2wtD4BaIprh0cCIrSDmD3rBdzL5cH6s2lE0GTfbjO4DLIvi
X-Developer-Key: i=dev.taqnialabs@gmail.com; a=ed25519;
 pk=4Syx51HH/MOySSUpi79M2ToLOdwt1yiNb338eKZBJNk=

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Russell King <linux@armlinux.org.uk>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>

Changes in v3:
- v2 tried to fix the ordering in teardown path, but it still would
  not follow the ideal flow mentioned in the databook. So have
  seperated the patches to deal with the teardown and some findings
  from sashiko.

- "net: stmmac: enable MAC rx/tx after DMA start": reduced in scope,
  now only moves the MAC enable after stmmac_start_all_dma() in
  stmmac_hw_setup() and stmmac_xdp_open().
  This is to handle the overflow scenario during bootup causing hang.
  The teardown side in __stmmac_release() is no longer touched here.
  This change could go independently fix the overflow hang at bootup.

- Added "net: stmmac: xgmac: tear the datapath down in the documented
  order": for ensuring ordered sequence is followed for teardown.

- Added "net: stmmac: xgmac: decouple the MAC Rx/Tx enables from the
  DMA ops": drops the global TE/RE writes from the per-channel XGMAC
  DMA start/stop ops.

- Link to v2: https://lore.kernel.org/r/20260727-stmmac-rx-fifo-block-v2-1-4dc3457d31d0@gmail.com

Changes in v2:
- Corrected the ordering in teardown for xdp at stmmac_xdp_release().
- Link to v1: https://lore.kernel.org/r/20260726-stmmac-rx-fifo-block-v1-1-45ab094b6c02@gmail.com

---
Abid Ali (3):
      net: stmmac: enable MAC rx/tx after DMA start
      net: stmmac: xgmac: tear the datapath down in the documented order
      net: stmmac: xgmac: decouple the MAC Rx/Tx enables from the DMA ops

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  8 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 94 +++++++++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/hwif.h         | 17 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 85 ++++++++++++++-----
 4 files changed, 170 insertions(+), 34 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260726-stmmac-rx-fifo-block-ef589c38f96b

Best regards,
-- 
Abid Ali <dev.taqnialabs@gmail.com>

