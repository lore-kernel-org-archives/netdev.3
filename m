Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84951C322
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070092; cv=none; b=i++pz8KRQX8qRzNMLG9YC5pNArfcsFV1g7OkHUYnIfDxRnpb1UO7DnSDKDxEM9OnF7I4SqGHUoERDVMs10/fyU5suq8N6ff5MdQ0XwHIo30BWwG4ECRf57DrRF4+xlWzgmbYNHkS+J84tvoV2OjH71ELK6oB/C8dgpZ9cUIMaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070092; c=relaxed/simple;
	bh=GNmrpnkyU9pHXwGf/LVP3YSCbYjT7Qtwi3MUrAOJQC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLBjGinnL7nXk7dH6Ruxvl6vaSgA7KBRFSMgg1Aj4ERuoI5vQ8c7MT5acFzE0DPIScpApI03AN0iJEUjFOk9pZxONtgoNmUGcsibcgMNnjRAberOKLeuf74y9M9okAmrEEsnmAYs95HVrrsKHP1UQM7B9JGi6amCbvz/PXFvmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAxOtSRn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAxOtSRn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a005aa0838so5059415e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070089; x=1792674889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9e6tOpY5SeeMPDTwWX6pIO46IuU6H5Wj4q8BPwTgU5I=;
        b=QAxOtSRnHp2VBkQq47A09g6RXDFthCDEAbKON1sUuKorhPqdTV3bhMDNjd2nH0Ss8w
         DOhrHue0qz2Wgkn4N5zFxUSJl1b7/oTaBUhEm7hZWRe5giRkJu9E/OAYlrnc16pUw6ZU
         /p0mAiNlDXiF/uAh4xRzYWQjwu983iMsPNv4oC0ogtHscu/Q/n/qnimWPrlKrEPr2WOU
         rWfxUKnh0QI5Xnj1vPQmcPXJI1wieVeR6IIq5MpBLdg6Lh5HrDdfTJ8tL5hLdur1mS8R
         4iIubmpvJ5Y8vDSx48cBjn2cuKpo3CmSShZwksrL7m0Tz8voetOpgph25OAE7x+6WJz1
         fd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070089; x=1792674889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9e6tOpY5SeeMPDTwWX6pIO46IuU6H5Wj4q8BPwTgU5I=;
        b=dR6cYpFuHoETCYsVeWr/6kJWup+DHYIi5cdmkNTnaCSUdPD+0pEiTe4x2qprkJDSMF
         /sSvwh8ANGlc5oj3SQKyLjBnIqqRmktp9plHnPL7x7zpapIEcIMvKEYJ08ifa6N50A0J
         PkEI+tS00SkqvXNXkcSYMCpaoq6PXYu5vaaaSuiiWlxpM2Mo3rZ2Pbqay3qcGX3t+990
         sB0KGZBQGR7CA/uYG0T810PJJpHQymW8fB5feY82lXVIID9J7AZGNp84LNawURGm7gNd
         RYEn7BNgPX6YmPC8eNX84HnBpaAs6+YCx0kkRo9gnuVkXlDQ7Rd5GxsweCRZHOLo1mwY
         3lsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTcRNgLh2SOis6Q5lWbpsQwqqr2ekQ3JpiRe+m5NkPFvYCPkjtRvxfSSxDY6j8opXL6PkYa/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaUO0yTMYUFfbG2Nrt1YjcoQxuR8oCK0DSNehpwIS5PpMYK9e2
	UgkzNjTNZeFLH1PyBAzColhEB7hhxeV3eMq3ihTIYQf3PxF0ZXpgsVfS
X-Gm-Gg: AYBFou0ALKg3cyLCdsF2iBjmckGY0j4OphdN+SyspocgMppPXgE4W5+46ZsnNKwMdTB
	kv8li35ac86ZhDKoGaPLY9qawPM0CTB+fzGQya84tBG0ikMF7EX5Aj+Nspj1jwUlL3pwWoVaDfn
	kjHT60vhehLLRN2pyaC9reTrrZEgs/OsH+S5TX0yzXjoMJILNdojPgdwKMbNHewCHN0E/SJszk6
	mSlkAenEIsiCkIIN2gIqLNJ2FXo/u1UmhovlES5s/gl4fk/idg/9nsFdjX+T2V9RJ8GGUaD8kPS
	mslfxAfTpxi74xMGZVJLBKeFCqYAlcrofqSilAabe75kwyngLAKlyLvc3GfLLXLfwI/xb3Axgi0
	wrqmqWZ8mQsko6yL6eyS/hoUZBGJw1QWp0xh/FlrsWHg70e9crxVpiXjyKdH6JnjQ9a5IpRPxnj
	25txs6dMBJxwtOOpJIfbFloifL9cPpAPfJacCfnwUBCwi2VHRXlpig/YXwPrxhXHFr96Hlatf6v
	sCOfHa2TGb6yYRh1TTbYjhHNovHxDiby1LSSjEreYupJmoR/fB52bXbkgaKU44C2Ls=
X-Received: by 2002:a05:600c:1e0f:b0:4a1:8469:e6c8 with SMTP id 5b1f17b1804b1-4a18e46f48fmr408305435e9.1.1792070088832;
        Thu, 15 Oct 2026 06:14:48 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1bd99faf3sm70307735e9.14.2026.10.15.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:14:47 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	David Daney <ddaney@caviumnetworks.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: octeon: Fix dma_unmap_single() size
Date: Thu, 15 Oct 2026 15:13:28 +0200
Message-ID: <20261015131336.34801-1-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

re.s.addr is mapped in octeon_mgmt_rx_fill_ring() with size re.s.len
set to netdev->mtu + OCTEON_MGMT_RX_HEADROOM + 8 + NET_IP_ALIGN. It is
unmapped in octeon_mgmt_dequeue_rx_buffer() with
ETH_FRAME_LEN + OCTEON_MGMT_RX_HEADROOM.

Change unmap size to re.s.len.

Fixes: d6aa60a10b2f ("NET: Add Ethernet driver for Octeon MGMT devices.")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index c190fc6538d4..92050716f103 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -380,9 +380,7 @@ static u64 octeon_mgmt_dequeue_rx_buffer(struct octeon_mgmt *p,
 	p->rx_current_fill--;
 	*pskb = __skb_dequeue(&p->rx_list);
 
-	dma_unmap_single(p->dev, re.s.addr,
-			 ETH_FRAME_LEN + OCTEON_MGMT_RX_HEADROOM,
-			 DMA_FROM_DEVICE);
+	dma_unmap_single(p->dev, re.s.addr, re.s.len, DMA_FROM_DEVICE);
 
 	return re.d64;
 }
-- 
2.53.0

