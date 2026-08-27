Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B1386C1B
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787872964; cv=none; b=X1sdd3wc0SOwft3sZ2DAGueGlUe+UilQ/BOWWHBByeqOgAvUanGFFjdle2XDOkUJxQNa/OLrZUg0wDuYaxGhap6i7XumVLbU7/ZFRr9R39BsMxNsNC081IvaDe5YVIb8AkCbE4FO7wK6/Vq0MsBRzDOkZU3egw/gWEeS20w0M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787872964; c=relaxed/simple;
	bh=ToL+qrxaGPkIwwzSzJ3JM0QaLYNkEH3g2w92rivyJ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqUBhcvkWM392RZf46A4/dR+oMWDq2uXwCeXHHq1zNVdMhx5ElcR67rd+9ip7vbucLwNYBQpjDIveVmQ9fUJclNBgg7lXADBxa53qvKdSvYDeQVFd/KsEHb9NISo9YLWWt8v2iZVkLdbzvMk8EQK0yAMNFmIlZzn1To0ZzMX59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/uRqyNz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/uRqyNz"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d5335cf904so3732795ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787872962; x=1788477762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCUYZUagUYklDLur0cOGI1Qx/7xjgBtFl/8/oR1JLCI=;
        b=U/uRqyNzHXLost5EtlVjlZEAZLlxWKoeyCB/dlbJeC4gEg+begoOFjv5WktDE3BBof
         K3hMLDES48qonPLCjEt/M8GOrQMKYCf3MvUM5uMPky0Ci/hFQggHkeiJQXY5FOuD+8sT
         PFX8OTTSa55U3bQkQDDHk5SqRQfk3DVmLjCIQoZ4Dwvxl4Qy8Qk4qo3TgSYt7CrRdkTC
         5HTps3Q4ekcd23YOW12Q7ZHOxLmzTTLxyrlfPKgNKpREhXkafinK9+5vUo7F5kOMpYnr
         tcch2QcFX97g4vYWAJ4161A88u0GBWxsYa4ovF+/DlmbfQLh45s2Jm6QPTMO7bAkdGF6
         d3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787872962; x=1788477762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCUYZUagUYklDLur0cOGI1Qx/7xjgBtFl/8/oR1JLCI=;
        b=nT5d4+nzZQSELZMmVaKDRDIpZ4iaDDGMqSWaw8ew/aQNDlLk487bQjztV3P5esdOcM
         bqhAPS5QryO+vYlNZo3oeSt4+Fv71xGNrZcaxFWVU0C6+E0tGkIHs74M4GWkscpQWYhC
         kCwyhiZmU4NxUy7GPRlOUuiiF6J4IGEvO1FCHvDP4XQSuuX7OK6HQ2BQfnRpKztoQ7Xs
         m3T0DeCEfaiLNfUTOrH9ANVklFYprOEfoBW4sS4TOF4bGPG2HVDL8eh7W+mHrFVfRaAr
         0VFTTToJD4H1i7d5empyDmkFDCphDz5EdH/pX1mbBidXmYmoBJsd+8vbwOweJBe3LIah
         k4YQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBpfaVcrUHzLotqlGvw5oeM3+lHejFLozfncqGoRPr4KOE8K87EKTbKJCChZKO5t239RbAeOY=@vger.kernel.org
X-Gm-Message-State: AFuF++n3foW97IiaFbjMDIaDY6/qKcMdq5i/o8/+pgpnaxC3DoEv1xNK
	vIS0mJFmXmIMYw0C38SDRvpuZ9s7JZjO+M4i5EDpUY7siELz+yP9IVwB
X-Gm-Gg: AR+sD10UOLE1sqfEVEdlHFpVIPb171iWYqHVDsi+GPAUnghRDoU8g/JQ4AaMruIw59y
	za73She7q6qmZK72nmENmaZQoC+1AQbHLlrSbEuDPwr5R5YB7n0IFfAdvdkelpv3EVjla3OizB6
	jMTipJZU57gYgxl0Cvv0r+4UcbG5IufoCHx5fHvIZhHND4sXX8wcDJqZbVlf+8MmB8bMrMqvHOU
	0uiw8m4kNTPOb7hRcjiEHw1jKOGCI1c7v3n4YtzuvxDShh8cfsDNLR9UPR7N4fSJMdaTM8j+jGV
	uPHIKd/TwWnCkoixeHJ2GGuDK4a1Wu14RZFYnelsxpTFIoYrcoNFwB7GC1retkuSxkQBmzr2L8z
	vrVwfiQSXAP+nQV0YqpHJujleXRZcxyvGXpsq/uYhjIdiu3qyxf7VkFyAfaeKzci8vHKzNDbdnx
	CNF4PyM2pakS0lt7GJOmPfko+2kr4htEVgPd4Qg1PEzD6jNpvHVq8ftKX1zlUDuu+ZL69U2mKqb
	WXiwGvWfv43p6ngJWYwYBUQm/xyaIngJWSbkra8DZSfM0H87NZNcnV5xOlY60QYP6+cpxMomMlu
	VVvsVk+3Yh43D5zbmjJdE3HjeOzwf5U965xkuj0=
X-Received: by 2002:a17:903:3a8b:b0:2c9:d88e:f996 with SMTP id d9443c01a7336-2d74dee96b5mr44091705ad.9.1787872962286;
        Thu, 27 Aug 2026 16:22:42 -0700 (PDT)
Received: from localhost.localdomain (2403-4800-2450-5401--2d10.sta.dodo.net.au. [2403:4800:2450:5401::2d10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d730c3csm24163635eec.9.2026.08.27.16.22.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:22:41 -0700 (PDT)
From: James Nugraha <aslan.jnn@gmail.com>
To: Raju.Rangoju@amd.com,
	PrashanthKumar.K.R@amd.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	James Nugraha <aslan.jnn@gmail.com>
Subject: [PATCH net v3] net: amd-xgbe: discard rx packets with bad FCS
Date: Fri, 28 Aug 2026 09:22:19 +1000
Message-Id: <20260827232220.69907-1-aslan.jnn@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd-xgbe driver currently sets the MAC_RCR.DCRCC bit whenever
RX is enabled. This disables hardware FCS validation, causing packets
with bad FCS to be accepted unconditionally.

This change unsets DCRCC so that packets with bad FCS will be dropped,
in-line with typical behaviours of many other network controllers.

Tests:
- Verified that packets with bad FCS are now dropped.
- Verified that receiving packets with bad FCS will increment the
  `rx_crc_errors` counter.

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: James Nugraha <aslan.jnn@gmail.com>
---
v3:
  - Removed DCRCC unset on xgbe_disable_rx().
  - Add back the missing "Fixes" reference.
v2: https://lore.kernel.org/all/20260819091656.23943-1-aslan.jnn@gmail.com/
  - Eliminated DCRCC toggling via RXALL: now it simply sets the
    correct default value on MAC Rx enable.
  - Updated testing information.
v1: https://lore.kernel.org/all/20260812091616.35811-1-aslan.jnn@gmail.com/

 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 2de974213..e2e850c1b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3400,7 +3400,7 @@ static void xgbe_enable_rx(struct xgbe_prv_data *pdata)
 	XGMAC_IOWRITE(pdata, MAC_RQC0R, reg_val);
 
 	/* Enable MAC Rx */
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 1);
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 1);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 1);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 1);
@@ -3411,7 +3411,6 @@ static void xgbe_disable_rx(struct xgbe_prv_data *pdata)
 	unsigned int i;
 
 	/* Disable MAC Rx */
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 0);
