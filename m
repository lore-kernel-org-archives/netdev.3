Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E1B3FE34D
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218866; cv=none; b=OtLCgiVFI1nrjDlGEiLVcYYWFxS+RIuiawLJWIgWfWHYHlBA/AixW7OcWr8eKAGgRdcFE7FB7U47RYfByxF7H74nX5RBfOlsn+TLxNy5xoLZyfhg+/++2UW5tGbE0iolKOG5b7wIL+KZmlSeDCvn8bOABtxp5ZjJmDXCLkhK87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218866; c=relaxed/simple;
	bh=FzHg9or1Zwm8rHfuvlBTPbxJtQYBwLJ33RJpzjd9Uq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3zgB6BL2H3eobchSbj925TV/ccUoB+X2ed90ShvV3+7XPNi2TLT3kFb1gCoOZi++IXf+rOjB/JCdC3SMqfOuPPwoTwsl+W/kEqTwvJzmZcTnasZLO85XdDEO88LoSqwmUjmjssQ1YlaTiy6Pn8DC5EeWYZABAeQCgYR3FLZqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs4sGP6g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs4sGP6g"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2734184a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218858; x=1787823658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yF1JbB5R/FVZprSXPu19zqoBb23lz+r7CLHDK21Q7Ng=;
        b=Gs4sGP6g+kAFvymtg57O2qy9qp33etYUYtHr8EnhesCjg24pmJLYmVHPzhWsmhouXF
         hiR6hPNOWUjpTVKO3bLHj+pYbRMtX1TKKQ+Uo+WDXzi8rVOZquwj89M/ncE38qsJ2hPZ
         n7j8Z1SigAQaAwH6WK+YSp6HmVLL+W+5G+lw1ojcdekT7ITMar7SbUcQts+KnTwlra+8
         2+i2BKOsyrpmn+bOCfmxdCsByuWLREXTC4dTMl7b148yPWRn5TheAXRpSwDRsBbqkG43
         qW8bGql6S9MxnwliKnULZu3hoh0ZGHKSVZDMdg7XpX1RQftdk5h7/CrO6GOUQUD553Af
         PRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218858; x=1787823658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yF1JbB5R/FVZprSXPu19zqoBb23lz+r7CLHDK21Q7Ng=;
        b=fWl1WoQaqMXOY2MhpVoPNXYXHqeCJYDcA0dNqPodiR24/3yVqZKcLcJrZ3uR/yPSnP
         9WQRkvEuZWqFs+ypt+6VvYv2CkKPoqLITk9qH3TxukVJbypM1og/6dpJih0+Nl2sPp+/
         23QyQjrr6g2tIBoABau0M9943GG66wrfRJu0vt7JcQqP4mf63Ntf1SIDnx1Iw5A8IVeD
         Q73wdMS1xE/GsR7FG1c5XHOqfKQF6VSLjZ+1VhKZTvHsEgx8VTDGXbHoBdlwSPWA1mrC
         hiTs4LFpNSbhmPjgAdCQk6b1TYQUVTm3s3WeMuoVwRaBQkA09xdv5+RoRVttsjyGOAEh
         Ef7w==
X-Forwarded-Encrypted: i=1; AHgh+RpXVmRNQoy7vgC/f5s4updpQ2KyPvMtLe04vsvSBvD5rRvjZ3L+h083Ov+tT1NiR342653ivbc=@vger.kernel.org
X-Gm-Message-State: AFuF++m4AV/P9Jg/vL5NdmJWMikhp/tLoSFOxyRvQPiZbVzKjIXC5KeK
	r6T8Kuohe83QQfPQk24u7zlpOdYohFv96G2wjm4zM2xI/cKMq06e4UXg
X-Gm-Gg: AR+sD10f8Ux37fhbbFCizO6MJkAs/8wDNW21sUYvfbW68HIUPpAsMD2CaFAJCraVHXH
	KEa2l6/H+7NErDMDMEKrJ/8RFARKAwVhd5hZQqNttHGBsPNNZgz3EBGHPhAxu731JYhQuDd9xtw
	PQI83q9SjpKkkTJgiSHnb0VNP/xjD3fhbHjujkyiDfmGIi1MZXdMlrht18b7qSUu1UDt7VkRlJ4
	OdKrPPTh2j+oXHlvhGPSsPowc3DZN/0rs74XQeitV7EYgpOpMSPFAsGRK+N/yMMYgTtpn0/V8Eq
	hua04zQRw602l8xyv7zVksFzLv6X1oKS+4APTHgy1vjqNB0v46g8idUyDZzeiI+Y9nnCkol7YEA
	ZeDlWrklYuwE9Fs6ZjmTg5PAERDdPjq/kJmREhQdFr8Ot4j9LncSoO4FSPkJiCdTb+ND+EG8YWe
	vaJr0OaT+Q8Cxgh0E6qP+fxQ8rI7es37UsMfv5oh1QPGjOnoLOklceH2Q1sx/TNpO11chtv4GPh
	18kpN7E
X-Received: by 2002:a17:90b:4ac9:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-395810cad6amr20759699a91.14.1787218857689;
        Thu, 20 Aug 2026 02:40:57 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:6143:5a42:8472:2f21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327cb5a9831sm8393939eec.21.2026.08.20.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:40:56 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com,
	kohei@enjuk.jp,
	aleksandr.loktionov@intel.com,
	Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
Subject: [PATCH iwl-next v4] e100: prevent shift-out-of-bounds in EEPROM access
Date: Thu, 20 Aug 2026 15:10:45 +0530
Message-ID: <20260820094045.41400-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

When reading the EEPROM address length, e100_eeprom_read() can return
an invalid length. This value is then used as a shift count when
calculating eeprom_wc, resulting in a shift-out-of-bounds UBSAN warning.

Stop EEPROM address probing if the detected address length exceeds
the initial address length to prevent addr_len from underflowing.

Validate addr_len after reading it from the EEPROM in both
e100_eeprom_load() and e100_eeprom_save(), and return -EIO
if the value is zero or greater than 8.

Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---

v4:
 - Squash the v1-v3 changes into a single standalone patch.
 - Prevent addr_len underflow during EEPROM probing.
 - Validate addr_len in e100_eeprom_load() and e100_eeprom_save().
 - Use BIT() and cast the result to u16 for eeprom_wc.
 - Target iwl-next as requested by Tony Nguyen.

v3: https://lore.kernel.org/all/20260816113754.22900-1-pavankumaryalagada@gmail.com/T/

v2: https://lore.kernel.org/all/20260810083355.21631-1-pavankumaryalagada@gmail.com/T/

v1: https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/T/
---
 drivers/net/ethernet/intel/e100.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 29960762e64a..cd8190386652 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -744,7 +744,14 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
 		 * complete address.  Use this to adjust addr_len. */
 		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
 		if (!(ctrl & eedo) && i > 16) {
-			*addr_len -= (i - 16);
+			u16 len = i - 16;
+
+			if (len > *addr_len) {
+				*addr_len = 0;
+				break;
+			}
+
+			*addr_len -= len;
 			i = 17;
 		}
 
@@ -765,7 +772,15 @@ static int e100_eeprom_load(struct nic *nic)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
-	nic->eeprom_wc = 1 << addr_len;
+
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "Invalid EEPROM address length %u\n",
+			  addr_len);
+		return -EIO;
+	}
+
+	nic->eeprom_wc = (u16)BIT(addr_len);
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
 		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
@@ -791,7 +806,15 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
-	nic->eeprom_wc = 1 << addr_len;
+
+	if (!addr_len || addr_len > 8) {
+		netif_err(nic, probe, nic->netdev,
+			  "Invalid EEPROM address length %u\n",
+			  addr_len);
+		return -EIO;
+	}
+
+	nic->eeprom_wc = (u16)BIT(addr_len);
 
 	if (start + count >= nic->eeprom_wc)
 		return -EINVAL;
-- 
2.43.0

