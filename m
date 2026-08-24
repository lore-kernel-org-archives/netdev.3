Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977C3F927B
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567843; cv=none; b=Idb9oeYSELkpSqVAFwpDvjbVWJpB84r7EH87qwGX13fRmXH45WCynnf4cXm/JWd4W838bpspvZKfd9P9fRdWm4I28VH9ovueLIMRMFYoZz1VfPfxpgCj2KrC9QV/6Xsm3HQOssN40BRGr1FUx3IPhyhgti7DjrjieT3trY6lcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567843; c=relaxed/simple;
	bh=J19TaZpjBFKFpKQddWptge89fLyuS77fbLqrx4LT1p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VL7OsuSM0L0EjTKHxSkpzMEXqRbcfYWY872dE0oLktFmlQ4mQbK8YztTcfBBhYYMBxxGB9jh5cwZDaTEDY3DJVFuAziY2xoD7TgASXmXBa05naXxbWzsFhbzVjhwvMtuADSft2PFpVqU+J0qXqQTZ/zZ3ti4tr+xpRsnQdNyIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFzkTkvP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFzkTkvP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4765eec32e1so269434f8f.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787567840; x=1788172640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZIXvGRqZDv1pZyUfC6Atrs4lIO+NNS5+uMrqd4f/BwE=;
        b=rFzkTkvPA3/EppNWkYBTKqpHBlE2APdLndcyISwev/m1pt39ZexLehOTNlKRFmtkDO
         Xgz0mqpnWwX1rkWr/PMm8kRLMGMVjYMp125u8OHqjDME92e/Q41e0R4XejAAXR1Duf+E
         aj2Up+sEMA1WATBaYonQQ2PgB1/kLbx+LFnUdBVjttt9uslWanoOEic9ueJ5NJqChH+j
         WJa8LoBlAjyWPHpFortvbAuk5vxw2y/3AXDjwHSjg9g9fpHMPzBZqxVaq+9KIiryKuM6
         wgylsrgtqhwvybzWd68E3o36zVfqU6+VU0o6Fyv92ReN1NojKzzY5aRxZTN7YZe+MLI1
         vSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787567840; x=1788172640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIXvGRqZDv1pZyUfC6Atrs4lIO+NNS5+uMrqd4f/BwE=;
        b=V67HYhxoYOFsiEPbdvN8bO5MC3FI5Yl7bCtgZh4zoxngpApVR5VJi9BlYdkZ8y4Zl8
         vWrcbwVgzYPC9T8gaXafLbnFTg83rzsl7S2AMRdGcHcvZzssyPAyPsZ1j9haYf3o4dHE
         /lIQhvedEFhjZa+lbysncOGoZOUD13NJdsXVNMcJ3vFHjo2aj/aRrujECokOSPDMQbnV
         KgloflpOWPqqmC7DjC27RHiH81X9BeIwr7OPpD5OmaxCKf/HjSTsMWLiUsjKPIfFZS5b
         UJ+7FyIyD9UWZgeIBfYB5mUij2HMbJ9DEuvdiuInRWHuS4rSoIj+lzHtmixdVgxL5jzC
         YcSw==
X-Gm-Message-State: AFuF++kqi4ky0KeRit7uIDwWR//xF53NfL3GPQoEugeZ0r6syvWqfL16
	5DLTU6D/Xcv8SM6ivVllAW39lpolyp+R1pOt3ZM4TtAI7RZFRFurr08Q
X-Gm-Gg: AR+sD13Zsegu3dw93S9fZKFI+4lOnUP8yqa2OU7A0KN0QP+Khx31SZnX4bap0HEoThf
	0CG/lCWKWKqaBaKu6KteXGffEx/yigE2sLIM98erObfeCeDP3HhOFMylxHyp/Yon8uwbV2tCgtW
	E640fBCwfzXiy72ZuDLCUp3C7YsZtKgc/9aLCYk1iOC7E4GvzH1st9978qQnr5hwHK4aswnvq9J
	udGyaHl753pQMDewSUUu2zlhl4Wv0sNSytC4W8WlTWpt0CvMgEdZG7oQQvV8mIEMZgnKe/bDzKC
	FofJy8H7V0rQtNIL2i3zgyHRSWFbl8Jdh+EbH3ObbuLP9UiIauq5hnypHn1xyiD+ECPkM1t3n9w
	uSObqlrgB41SZxl1rihDVlOeCb8kVVktXL4f88UW7DrvLwvmfXfm+ArJZ70ERNyY2riJhffkX7d
	hiKkidSmSronqVZKZClXp8DBeZ+zHKpx1oXI1qEHjW0LMXWKsAjbKxzzqEaJdE/MXLng==
X-Received: by 2002:a05:600c:548c:b0:499:5b0f:72b with SMTP id 5b1f17b1804b1-499b835251emr145411275e9.1.1787567839702;
        Mon, 24 Aug 2026 03:37:19 -0700 (PDT)
Received: from dkdwn-fedora ([2a01:e0a:354:c290:491:87c7:45df:9c03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9bfcc31sm7675717f8f.17.2026.08.24.03.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:37:19 -0700 (PDT)
From: Lucas Poupeau <lucasp.linux@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas <lucasp.linux@gmail.com>
Subject: [PATCH] net: 8139too: use unaligned helpers when setting MAC address
Date: Mon, 24 Aug 2026 12:37:09 +0200
Message-ID: <20260824103709.98373-1-lucasp.linux@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas <lucasp.linux@gmail.com>

rtl8139_set_mac_address() accesses dev->dev_addr by casting it to u32
pointers. Besides potentially performing unaligned accesses, the second
read starts at offset 4 and reads 32 bits even though only two bytes
remain in the Ethernet address.

Use get_unaligned_le32() and get_unaligned_le16() to read the address
with the appropriate width and endianness. This also fixes the Sparse
type warnings caused by passing __le32 values to iowrite32().

Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>
---
 drivers/net/ethernet/realtek/8139too.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 8241bcf76664..1736599d7244 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -112,6 +112,7 @@
 #include <linux/gfp.h>
 #include <linux/if_vlan.h>
 #include <asm/irq.h>
+#include <linux/unaligned.h>
 
 /* Default Message level */
 #define RTL8139_DEF_MSG_ENABLE   (NETIF_MSG_DRV   | \
@@ -2230,8 +2231,8 @@ static int rtl8139_set_mac_address(struct net_device *dev, void *p)
 	spin_lock_irq(&tp->lock);
 
 	RTL_W8_F(Cfg9346, Cfg9346_Unlock);
-	RTL_W32_F(MAC0 + 0, cpu_to_le32 (*(u32 *) (dev->dev_addr + 0)));
-	RTL_W32_F(MAC0 + 4, cpu_to_le32 (*(u32 *) (dev->dev_addr + 4)));
+	RTL_W32_F(MAC0 + 0, get_unaligned_le32(dev->dev_addr));
+	RTL_W32_F(MAC0 + 4, get_unaligned_le16(dev->dev_addr + 4));
 	RTL_W8_F(Cfg9346, Cfg9346_Lock);
 
 	spin_unlock_irq(&tp->lock);
-- 
2.55.0

