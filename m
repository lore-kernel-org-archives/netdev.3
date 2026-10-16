Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203044C678
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141976; cv=none; b=nP3toWkYZ7jmMRiBI/3LSgI+B5okQ+N6TRNye3Hmg9Jg7g5iKkW9kh1/kCvHqGIUxzNQCyYUB/QnjUsTIu7Nj0PmM+eCK+kuTJ1oi/g+AzOsn01u4iQ60ElH9Ziw0Q/Zrv/lbWik2UHspxr/h77rgsbT/PJHRS6Y9n13HA3/luU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141976; c=relaxed/simple;
	bh=cAYyzvBvABdQ3mPgVmEus3vWnqb83GFBiX1p5PjH1a8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h51fHMfhN9atvTDgyDSNZaYaN7cklbkAeIEWg/wdXrwsstz0AcwsgxpEY4PWDtV08VdLyV+iGQudBEMfwitebZZlYTcCXF+Ua1lWdf6fA3TANmePvaEGoZxmhd1jZl0kntAFnnN8Fm2PT6YSX+xwltj9WRH7MGIcNB4CMrrXR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWhhTCgG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWhhTCgG"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso18032a91.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141974; x=1792746774; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R5dwpMdeDtafkrSIKilmZHw+Byk+8y+YTLJ/JPrzYVs=;
        b=fWhhTCgGrrEUmif/WzS1oi+QJmb7Lq5pm7WWNUejivxq93/7FRIJmimPE4uSZiVF3z
         R3k/pfTzZzvLkPvdd00l+igI8azIoPjt7U0U0Z7/i02GbtnJaqHYg3h6DXaR+bT1jEB3
         oAogcRWjfrKSFJdrZykEvP8aFYOWd66NxrnW9ukI19ecfBqQOgwpzaldxJWj3By6HgMA
         PoTOpKoh+nXlopRT1yj4GqiLX9Nqsy27wzlKkgSus7hCp7dyECOAR5TzH7Xef6I3nr9k
         JUVTA7eAQEDXqZb2bgeyXjRwRjDhv/+EBWhAUjcfRx65ePTWzz+Q42ParWUqr5CVRQth
         lEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141974; x=1792746774;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R5dwpMdeDtafkrSIKilmZHw+Byk+8y+YTLJ/JPrzYVs=;
        b=aUHmxJieukbk4/9iRyerO7BsvXSBqL77vm4MNeyTeLxmPd+MNZ+aJxGDSJsy5VjQ5X
         NrcUeqFhHxgEdekbVod67yfE5xiUYjddfI2VjXBS84qA2SjGwWyPquIhGB0U8+LjTawi
         /uLGbEWnczhVnw9CL4+rBtHZc1itJwiARePG1IzvkVfpGA2dS78uOjlR746JvbCYlizb
         +NMVZQ8KiM5ykeDdJHD/WZWh96sLxvnsqsdsFbVOGBdWKPLBbxhGDEygyvW8G42GqC5C
         JNMnYCWqfz7dD0ybDltaiHz3ZDkuLWboX9vova+9cgsE3E3hheoowFUnalRU4xYKD9BO
         AWQg==
X-Gm-Message-State: AFq9FYL7T+0TuW9iLyqWEd1+xftDkLvWWqAk3O5AMnRjZ4stppPmoLMS
	rB9lYjD/Rji0ro0Nxp7A9ZbmDuZWVBIXDYDTh1XBcNRDjtQnGAX5j0ZK
X-Gm-Gg: AYBFou0KQXVo9Fkia5SRmNEheWrH9gfN0TDyCJFSexV8MxZv/cYsIEl4pF5Gjzgqpn8
	UmVG5YNc1Mf1fdka+cFqJZL2RppzDrc9630LSkkggc4tHXtguJSQXrPuSqcRL/9m7LRP791eDAh
	H4xp+6CVjabpUAqireSjUZFCll+r0nA9VVI+aFcAvsTspmqPsex7XGivyfYdkQyb1EzTiZ6Gezb
	87mabwqUAQQbdS7h2fFVVWzq9m/VJYRBeWn9GjMF4+ACU0bqMDLw4FSivO73KV9FrLyhkk+in+W
	8heFZQ+cwn3nwhOcX7iRFt4A9PJ4sL9BHERZD9TcTFChyAE41ZkG0CM+9GTwv2tO5zeoJZsI4Sm
	oWgTUUOegMSaeTK+2Dt8+HZMWqickO3UIe0cGQTAVASVlbu74XQu5N1bdwa1nPohYjIoWSzH/tc
	xBlqqOv5vvDaw/TBZ/OXbK8UgJpfFoe22IhvMLwAjcsKqrqtuAn89Y6fTa6NXMRNUZi5f7/78ca
	/QCbaTwj7fdiiBQKUGiPVKvwxqc8ZP8U7keyPYU7ZoMdvvf8Q==
X-Received: by 2002:a17:90b:52c4:b0:3ac:9ed8:f319 with SMTP id 98e67ed59e1d1-3ac9ed8f5ffmr4225776a91.2.1792141974372;
        Fri, 16 Oct 2026 02:12:54 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.localdomain (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497e28esm767274a12.7.2026.10.16.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:12:53 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH net v5 0/5] net: ethernet: mtk_wed: misc fixes
Date: Fri, 16 Oct 2026 17:12:32 +0800
Message-Id: <20261016-wedfix-v5-0-8b02e78fd34f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDq0WoC/yWMyw5AMBQFf0XOWpOSqMeviAV6y7Uoab0S8e+K5
 Uwmc8GTY/KooguOdvY82wBZHKEfWzuQYB0YqUxVIhMlDtKGT1HIvDRZoTsjFUK8OAr6G9WwtKL
 5pd+6ifr1XeC+H49dyXVvAAAA
X-Change-ID: 20261016-wedfix-8079f58dbf06
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, Rex Lu <rex.lu@mediatek.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Zhi-Jun You <hujy652@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792141973; l=1968;
 i=hujy652@gmail.com; s=20261016; h=from:subject:message-id;
 bh=cAYyzvBvABdQ3mPgVmEus3vWnqb83GFBiX1p5PjH1a8=;
 b=VVf24T35ucw91qTXLscFnfuQBIvCNVXax72WvCgQBWP7iRYfg2a2Md92x1wnbvy6rlwhXt0Zk
 geGFIrchTdnCstRJxHrqpZ+TlRCUsxcoNV+xlqHXS8CgRTcmeul1YBc
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=AYHrGhtLNb9z7JIsGOOYWmKKIoVPH7ZZgT+CLIDMuEM=

Ths patch series includes some fixes for issues that were discovered
by Sashiko and one original patch fixing issue I encountered.

Patch 1,2,3,5 fix issues that were found by Sashiko
Patch 1 fixes tx wdma ring reset for WED v3
Patch 2 fixes the reset condition for rx wdma.
Patch 3 fixes rx ring and tx wdma ring not being freed up
Patch 4 fixes WED on non-DBDC mt7986.
Patch 5 adds error messages and bail out when wed_start fail

---
Changes in v5:
- Add cover letter.
- Add patch 3 to address Sashiko review on rx ring and tx wdma ring not
  being freed up.
- Add patch 5 to address Sashiko review on error handling.
- Link to review: https://lore.kernel.org/all/179000700034.2160803.10594281691384015089@kernel.org/

Changes in v4:
- Add patch 2 to address Sashiko review on rx wdma reset condition.
- Link to review: https://lore.kernel.org/all/20260730090030.201100-1-pabeni@redhat.com/

Changes in v3:
- Add patch 1 to address Sashiko review on WED v3 tx wdma ring reset.
- Link to review: https://lore.kernel.org/netdev/20260706101044.161059-1-pabeni@redhat.com/

Changes in v2:
- Address issues raisied by Sashiko in patch 4
- Link to review: https://lore.kernel.org/all/20260706101044.161059-1-pabeni@redhat.com/
- Add comment to explain the special case

---
Zhi-Jun You (5):
      net: ethernet: mtk_wed: skip ring reset in wdma_tx_ring_setup for WED v3
      net: ethernet: mtk_wed: fix reset condition for rx wdma
      net: ethernet: mtk_wed: free up rings during detach
      net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
      net: ethernet: mtk_wed: bail out when failed to set up rings in wed_start

 drivers/net/ethernet/mediatek/mtk_wed.c | 40 ++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)
---
base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
change-id: 20261016-wedfix-8079f58dbf06

Best regards,
--  
Zhi-Jun You <hujy652@gmail.com>

