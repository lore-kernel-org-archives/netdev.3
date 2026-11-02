Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654738;
	b=BrwSQK5LaYxeCRmcyD87dAJcan3vDYUh8vFXFdqtcwloqz3vVm9K42ezpT5mX0SyfoKC
	 otYnC/CoX3JspmiM4Os9vOpyjCoTdhdIpAP0e7ffg6JjLmnwEX1n8l8OaEcjNh7zancsr
	 6a9EO+/LBN+GlUBjSoFreOAqc7VNWTf6nmk5elbDYcdYvTDLbrWDKF7tgErij0aegcoX4
	 X+J/JR+RC0vrP2v3vH/nylYyiVMk9fz3DpQ7RGphWe2klO7Hbv+w9Sw2/xJMuAk0QDJZM
	 VLLjNEpryroFEHV1XGMWow5mFBRhIdTcrUQ19KifWLvrewefTvlxsy4hqe5lnI71ePg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f2iHlmQM8BVjrAqEqrTQxQY1XsehcxpHrx5clmyJcPs=;
	b=GUqKVxw6msoyqU9OKSmet5MdykJMBS4CrwkXDClD1OhgTUA/vrBMEp84I6NKn9ilHsKf
	 JfUhop63NRPFbXA8chgaYmAjrfR+gxa6yXV/YntbVty6sW14Z9CoZa1QdTI/GepuVYRIk
	 txctbEG2Ric7vvAXrKEeuFG2k1MlcN7HgZlN6lvnJImtcblXjfgP56GF/3o6QJXuPiURv
	 HkjI5ZHjLpvNsswi5d5FzwkHp8jpzqUeLILK4aMyPNwttEjuyafKgk+LIFQwB4mges71f
	 OUZ08eNlE9QvDK2wFwv8kNhC69ashFOdDDukN2lyhgSzmwJ81ZXIlgSS9sewW6TCjXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qbqvB/Gj";
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FB606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 865FB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qbqvB/Gj
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-1379d236149so1383922c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793654738; x=1794259538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2iHlmQM8BVjrAqEqrTQxQY1XsehcxpHrx5clmyJcPs=;
        b=qbqvB/GjO3e7E1PaLP8+FLSHhuN3anEe3yzjwAOp9wNdlD7DFdJjo9b4fcJooPoSsf
         yuv5+uKOlAd1+wACJOj71CMJTFkB2O6ZFbHunBhL1P+1I/6bXATlwkSUFy6ScHozekuI
         F1nmhY6ve7z4VzQYevHyJyOFz7bwDuHCIEzzsxm25he9grCYuGCDx7w/WUmA2G3C7Jgi
         Oqt+3k9LU/+SN99KAgtNz+csds+tUA7Z2l9BRypViX5muWRBr3fjj4WtVE0IWdOq9CF5
         5duG/WnTtld87Xa2XvtNHz1vNhFCeMBhgTk+iTeh0Gx63v+4ElghLnfxdm13+cWPDJR5
         rtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654738; x=1794259538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2iHlmQM8BVjrAqEqrTQxQY1XsehcxpHrx5clmyJcPs=;
        b=2dKcYxTx8uPu1wH20kwgiaLuCwpPm4KGytFLBbPnFTO/H/XL1oTRaQ0MBm+OPm5w83
         TOhdBLyfJ9fvE46XdhnQOiKE/RbJ2345Hur7jwOGQX93KCI9bII+2Z3XOyDDL2CN7W3y
         jjfjaCo0g9WZNOHyOD0X/nhvohVFoZ/CwGQVdiOT2TRXL8qwCu+w/47r5CJFNxYShZfD
         lhjcGK5AyUFex8y2N1ufdAGJ57h/vSETKlKPopZ+JRa7AhQltIfh4gCkMj/zvQSYAAIt
         CeRnhQREl5hI0wGevII3QFUn2kZDJfsyrpxzQ6c4dVuM3zpeKHoW5tsZ+v6C2Z5SXSQf
         qy3Q==
X-Forwarded-Encrypted: i=1; AKwUvBw4b+rWqaOBBMnTdQJKiBf8Cc4GURij2RZ4JbP2NY1Nhk+WarrdbM7ATAKQ7Qmf5NPTs2BOZJg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGv99FZtdrw6ujQrpG1otpOxaMjEQYwcAeheQAJnH8PCA8vd4x
	Pw+/ESVW2KIIcvdlRT4Kn8+JHM5GIE9FPejBYfTVNMvkGLxTHQFhxolK
X-Gm-Gg: AYBFou1eSKgzqwoDo74+wibptxJdCWH6MHNUReF0Kz49Zjl4k1yL5dJZW++VuJwFre2
	eCcccrNCBGSp1Atv0I7wMxGVBlJ6VAxJnkKpzyA/4Ug5Ty1dh46eTBzUq08PJxgJbP82RxCQ9dB
	ozq7z6IG4p4+wBX63GY6kvI1QqPPz2SfYLYvdTwQUBcWukHR3bFrA9+QMs+puButv0R4FFMFDcL
	d8V6XBaCMZjxyfUV/bXdFBhqeqffCj8vxQzs4sRbWjtKa9faLZG6lfgvB4iYZAJykfOR5b0Hdd0
	oycOhZECefqhiLhqE46JCU2mvmVYYpm7mTuZcJuwTJS2hevN/It1XyhF3vUwXcC/O9VKa2u2G+c
	dfhmT+xeXX0JEMwzQLUnhkgYEVU/imQqD8i/iUixGbuvIgW8uGSv0f7P97zbmS0IPbOdViFpdm2
	dLsp7zYZ/8kiXWArUoMGRJgQnnFN+PmA/eg00LNCWAU9/1x68e+aEpr2yHxuEWVWORhTSIFhOzq
	NIj+9B8j6EwFQHsz+l4t8zhn6TZ1RH3ocNfxsJdhMOn0jT/+T2ILFVwD4Ffxn520FDk006PEPhk
	dzfGOl2TJGOiaRxGxhkbqzUXDQY=
X-Received: by 2002:a05:7022:b053:10b0:184:19ee:1fdd with SMTP id a92af1059eb24-1ac56302618mr17357629c88.5.1793654737507;
        Mon, 02 Nov 2026 13:25:37 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm37195851eec.12.2026.11.02.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:25:37 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net v3 1/2] net: phy: move DECLARE_PHY_INTERFACE_MASK_ZERO to core
Date: Tue,  3 Nov 2026 05:25:06 +0800
Message-ID: <20261102212506.3348537-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102212506.3348537-1-coiaprant@gmail.com>
References: <20261102212506.3348537-1-coiaprant@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The txgbe driver currently defines DECLARE_PHY_INTERFACE_MASK_ZERO()
locally, but incorrectly uses PHY_INTERFACE_MODE_MAX as the array
length instead of BITS_TO_LONGS().

Move the macro to include/linux/phy.h and use
DECLARE_PHY_INTERFACE_MASK() to properly size the bitmap, while still
zeroing the stack variable.

Fixes: 47f848aac4e7 ("net: txgbe: initialize PHY interface to 0")
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 3 ---
 include/linux/phy.h                             | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 757d1ce8d3ad..8071464c7b90 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -315,9 +315,6 @@ void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
 void txgbe_do_reset(struct net_device *netdev, bool reinit);
 
-#define DECLARE_PHY_INTERFACE_MASK_ZERO(name) \
-	unsigned long name[PHY_INTERFACE_MODE_MAX] = { 0, }
-
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
 #define TXGBE_LINK_SPEED_25GB_FULL      0x10
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21afc2082b17..43aba23109fa 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -159,6 +159,9 @@ typedef enum {
 #define DECLARE_PHY_INTERFACE_MASK(name) \
 	DECLARE_BITMAP(name, PHY_INTERFACE_MODE_MAX)
 
+#define DECLARE_PHY_INTERFACE_MASK_ZERO(name) \
+	DECLARE_PHY_INTERFACE_MASK(name) = { 0, }
+
 static inline void phy_interface_zero(unsigned long *intf)
 {
 	bitmap_zero(intf, PHY_INTERFACE_MODE_MAX);
-- 
2.47.3

