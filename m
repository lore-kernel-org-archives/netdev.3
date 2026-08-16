Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904133DD53C
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786880367; cv=none; b=rSUlpbsivX2zLKoaoHC1F3nwimj9V7QhTGBxW68IIZ/MNvLT7pic6j8hbn3MwuP3dgkTXoymg/1I+nHfNYDDel4E2AXFJcPHLh7JMMuOiPR2dIics72frPvbj1YquQHTEbH71+oR7VcPiktDlB+d0d2RK3T5N+s6s5JcvH6Jqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786880367; c=relaxed/simple;
	bh=f8QTlcS/MhDaRBf+bmVPftB6AcgrNfengisbZgNhgIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkFFjQmu55XGyVAyKuP5ZtBktSWTMhBHUCfybrOJTSMZYj0Tn8h/ds9S0LeKPnYiz+2mXvO3EnoGMisL6aiiUvZN6h26s766HPx3Q6JKDQMzZ2eXEuE7L6GRIXbpOHbV3bkcFocf4v9HNi0He7QouwpSQfPpoAF3PRq+PdvZp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvtKVT+T; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvtKVT+T"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381b831d535so3753514a91.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786880366; x=1787485166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2hN3pG7DWenkEBL8a2DnjfNcMqYXamdUeL+Aidbmqw=;
        b=XvtKVT+TqQb9DWhdVHDX58pRMNY94c/SlxzeTd6ToSkHEwJhM6EXrLcoaIbFGmm+Xy
         SFgAWAn6yTagfcx2UzMyjilvIiPZWVzE4qn0lwzbWZVGDotpE1nXjZQ7lLC+gxEEberJ
         LUGsyBfiV1Ow5a9QzblBRHn660ASXU9RgKzjbMPQn+yfhC/u/1ry+f25QxaLm6+OA1y5
         yjiSmVym9sQOBNt+4XoLoBG178dBuPeyYru5/GwEASY/BcGJMo2naa8vLAKYnOvFIvtY
         Dl7FfXnHmWaziMoQHC46I8SMsoVHam6aBv2dZ+bQxLkoa8XWz1ZkGB9nOTWtVwpiURsJ
         fW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786880366; x=1787485166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2hN3pG7DWenkEBL8a2DnjfNcMqYXamdUeL+Aidbmqw=;
        b=GbCAezdEtvFpuqUO5SwgUUvYwg5edbsksC1dETP0VBzx61MbRM3RsTl5GNV4Wua/c9
         fzuRo+Wbg7fmf7H3UyRyJT/M++rsKTdinxTlMV4ukoTwMj+ov9mDdYQOZV+LyEupdOod
         qA40OJuPOlundIQWpVFDI4KKKrlNUpajVA1MzXc6MTUwu+6y/rcCcaXKtrfuwYMJhDvI
         w+vnoFpge17xqPp9OVT0L/lfd+QidBoNv8ee61TlgxhpgTcG9lr5qAhvGJm0QzYZX3Gb
         wwaiMwuLZHG+r/OfSJqfN+9//0SQrzKEnKm1TFM9Oo/KNJYUaImr3Jr9Kk17HulfVfh5
         nDZw==
X-Forwarded-Encrypted: i=1; AHgh+RpQ+2N5wigCjt+6Kp305ZDf7HEEV70/xTx0SjmZePaFTIWFasziFgn9FNw0M9E/sLYwhhJUFsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZ1VVLIxo1RBxWJV8f/texVpQMIwRVvuGOpwZ8zK7B+VEHMge
	QpBQ3c4BfE57fgbOln7ONfrMC3fvOhzCeKa0uaYNQdY39i5oXq8vMSQF
X-Gm-Gg: AR+sD11h1VfKNSDqQuCmumiErAfDCqVul0fbi5y1UhsM2oR7kvC3BbD6DdWOKi5Nwvo
	5L04kKxeudJuBbZuahsZFnpxScBVnCRfXPFSiQ4ke5EQt6LWJSnpV0lkGUacTyv9nb/7TW3/8OI
	4V9slomCUxlIQXbtBClBf7RNx0evmOvGKo6A/MHma4LTsJh/TJg9MqsDDL0ST1VW11xVXT2baC1
	tWLybxQJMpJHlPnDCAJwPPQiB6XCNtFvynB1O8tvix+QNZvwktcWaqq40JZVPBmgayIPQqpsEDV
	UbVhnKTBTBsN6UAJq82GW6qZZCZUdkKPZqwv9/JG98vMTPHlhS1Yl+H/kjoAke5knfdHt0OU+5x
	/CInmdwskFs6sksOb8qE22ASDBJIS/o8a5kOqPid65mtJc5qWBQRAPdbK7fNFWY/4w+XFM52asR
	354vZQoGY5UQr7ay/hnBnBlIjnv1ZiNVP5gIDWMxfRoozWDkyZMLVswRSc8JrjoOORrq+f
X-Received: by 2002:a17:90b:1d02:b0:38e:64b0:8bce with SMTP id 98e67ed59e1d1-3933ba86ab7mr21327188a91.20.1786880365757;
        Sun, 16 Aug 2026 04:39:25 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:c8db:7e2d:fa79:eaee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d61e1cccsm22520860eec.8.2026.08.16.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 04:39:25 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com,
	kohei@enjuk.jp,
	aleksandr.loktionov@intel.com,
	Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
Subject: [PATCH net v3] e100: prevent shift-out-of-bounds in EEPROM access
Date: Sun, 16 Aug 2026 17:07:54 +0530
Message-ID: <20260816113754.22900-1-pavankumaryalagada@gmail.com>
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
v3:
 - Prevent addr_len underflow during EEPROM probing.
 - Use BIT() and explicitly cast the result to u16 when assigning eeprom_wc.
 - Update the commit message and subject to reflect the scope of the fix.
 - verify the UBSAN failure with syzkaller reproducer before the fix
   and its absence after the fix.

v2: https://lore.kernel.org/all/20260810083355.21631-1-pavankumaryalagada@gmail.com/
 - Return -EIO instead of -EINVAL for an invalid EEPROM address length.
 - Validate addr_len in e100_eeprom_save() as well.
 - Drop the unnecessary 1U change in the shift.
 - Update the commit message.

v1: https://lore.kernel.org/all/20260807145626.52692-1-pavankumaryalagada@gmail.com/
---
 drivers/net/ethernet/intel/e100.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 464dc2d6cdb5..5165f1d3c98f 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -746,10 +746,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
 		if (!(ctrl & eedo) && i > 16) {
 			u16 len = i - 16;
 
-			if (len > *addr_len)
+			if (len > *addr_len) {
 				*addr_len = 0;
-			else
-				*addr_len -= len;
+				break;
+			}
+
+			*addr_len -= len;
 			i = 17;
 		}
 
@@ -771,14 +773,14 @@ static int e100_eeprom_load(struct nic *nic)
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
 
-	if (!addr_len || addr_len >= 16) {
+	if (!addr_len || addr_len > 8) {
 		netif_err(nic, probe, nic->netdev,
 			"Invalid EEPROM address length %u\n",
 			addr_len);
 		return -EIO;
 	}
 
-	nic->eeprom_wc = 1 << addr_len;
+	nic->eeprom_wc = (u16)BIT(addr_len);
 
 	for (addr = 0; addr < nic->eeprom_wc; addr++) {
 		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
@@ -805,14 +807,14 @@ static int e100_eeprom_save(struct nic *nic, u16 start, u16 count)
 	/* Try reading with an 8-bit addr len to discover actual addr len */
 	e100_eeprom_read(nic, &addr_len, 0);
 
-	if (!addr_len || addr_len >= 16) {
+	if (!addr_len || addr_len > 8) {
 		netif_err(nic, probe, nic->netdev,
 			"Invalid EEPROM address length %u\n",
 			addr_len);
 		return -EIO;
 	}
 
-	nic->eeprom_wc = 1 << addr_len;
+	nic->eeprom_wc = (u16)BIT(addr_len);
 
 	if (start + count >= nic->eeprom_wc)
 		return -EINVAL;
-- 
2.43.0

