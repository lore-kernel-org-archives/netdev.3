Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459222;
	b=bWQJYO1KLkBOR1KdXOo9fTh6UHdzsnzPQyYgk36mk5TofZuTffGQyo1p73vdsxRqOr/g
	 q4MmTYnjWjMNZ2rkm0kogS4R2TymaNBpRnlSS4RKwAqgxVQHHcex9jolK1M9kprQi3JXk
	 zgu8G8Vpc1/Ddhlj9rmD/QFGsc03P2O8Ksd5fnP6QqRfmSjfLE6x07+FOT/W4YpyJK2ua
	 /ey1BIRuHDWouidLXh1h6MjHObHPbIKp7IxRqc6u5RdV1p7mVbRhJZ/4BN+XuzdxFLorm
	 nSIs+NLBsKu3zSAq5zrUJFBpBQhjE+ogD5O5Jpp9Tk7cmp8oWaDMt/AenmDherpCnKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O8eFfbSG5vJmh+PRh1YD9XBTnKbqGfFwPb/6vx+9vU4=;
	b=1V3T+1Hcl/4o2oo8ddI0iy15yTL51JHHXrlOmb9qmp61GgDMslZRFk8E/A1k9N8hpMav
	 uOgQDy/fKtVQhcotDfqk/EGjafia+JUfYHYPwCdyXHw77/wJzjZ+4pNAQb5jBGT8a5SUG
	 0YBvR71PywKxzu8XJGItgVnztGC0WNxh8mlYQOJ9Zx+H91QakpTjLE+4IEBnuq+uHD7Vy
	 4nux2gSy8iwJ6IDT90V/omyMkcGawRE8AmhbcDIhUjvLWABzEdMMGZv1URNbskA+d+pNy
	 Anjf8DoUTkZkgbrh7RyETtA6CquPzeTWZ05OKYiSVA1Yu8SveiASSJIkFP8WHCr8syQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NN7eytIU;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C57606A338
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6C57606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NN7eytIU
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36e795af1d4so420766eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459221; x=1795064021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8eFfbSG5vJmh+PRh1YD9XBTnKbqGfFwPb/6vx+9vU4=;
        b=NN7eytIUilnZEYZS7gynUWECf0M2MjFXYFQhvcRVtEP4HW9EiNpXJxHIKdLxZ3xVCE
         pVRvJV5Bh+WjrFHUyVpiZbA9bMW9+IoWIZcpunlUz/sjJUFVtUWn5FJCFfn8I8e10hs5
         S77eg5yDcu9yVmDUhMVdicVA/VCteI6ugiVM9EI9vqWxYvttoDKZ2EePcjXitnZwLisN
         wBZstSX84CRM6go61KvtvrVN9GjVDpdRRLLPZV0nlYCIY8x5cqpesfq6aU97/7G/pP5B
         tuPb4XcUDiL45k8HkspRMVnU94wKzsWED7P5ETntsuVRc1KYdBmO5kBzZ3re4JiwEF/A
         2p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459221; x=1795064021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O8eFfbSG5vJmh+PRh1YD9XBTnKbqGfFwPb/6vx+9vU4=;
        b=0j0vHWDD5EYp5exnVKwcxv3x/UyT9zGxUU/jL7cZ9lrerwo0rqOM4pVckFO3IYV5nF
         X+189hqcxYp3rBeVNY7VS9J5/DNQvdPTnl+yJNthlqVq1wCELQxn7F/mnHK5buxrpVwy
         17tS8IJmAf+bKPb8l3WmsvmW04EVowIo3Q3KQDy+MZp/Tv7ylc7+WrLJ4qzWw51gMwlV
         yykP5iiADDQxyI9Ik7J9JQy0HT/MqbKafKJFGWc5DrnJPn2zMwPnxtVwFy+vXjo/h2ey
         Bs/qiL3Pj860LrO9he9R8txq8XTI/hpNqsxOUkeLy8jcgVSImVnC6GgHVA1pwUfsDmLQ
         gDlg==
X-Gm-Message-State: APuU4Z9BBwgM2WV5NfnRZX/tv03xz0rdNSbh4lKa2sgiuVQNi9o0IUbQ
	yLnzSlhhkaa1KSwraYBy7b6mBebeCMGJfFXEmwqgqXfVLFfTORtHqCOnQX3VqQ==
X-Gm-Gg: AYBFou0R/LbPgYUpe09bza5GrOASCne/6xm9hJLLvZ4d7BdSHl/giGnA3KMMnc9nvG4
	NlkX2trFvm8WMKu5HzBeKQNEvwLZvQl7oF1Jr1DM8BnSAOpMTluN+45pt2ZP1NdscbzivrDurPp
	CVZOphOERpK4CIn181tYC9+MUC9kuQRgzg3kr9Yrh72p14lpRvwcmF5mTN5L6shTDiIzOvCadPh
	QYMmU5EJtZx7FvPHn/piSY+/wMfhR1nEHB+iEk7b4f5Lt43VkvVF7dgHbOz++PSBztdvVTDN+AS
	O6bWTrOmUmnpS3zAF+0gvQmW1Zd2zZLCVLeXDWMCm+WJoBWdVqbyseYkZf1uQFjnuU7KdDPfH3E
	cJ1/fy8r3TXH59W9bRdzDzBXVuxvQ5Wzk4OEPLVqu+n6+WE5d/SBZCDWfsIYMFehciOnEVQZvHE
	RGpwsmjiqEc9FOCWl6NNApDmL+dZWjBzVlI8kvW4DdjWa8u56lboCjfyh4Xz/hNe7WRPV44pnMC
	Ai7YndvtUl/mZtYQiwZDOWypPcXc+d0c+RMkwDKh7XIy+FgT651Rrhampw39+oOPpA0DGgj9qgr
	dbX6ticluJPnsLRrJYgs3VfXNa2B6BE=
X-Received: by 2002:a05:693c:80cd:b0:377:82e:2d79 with SMTP id 5a478bee46e88-377e093ecaamr1595631eec.9.1794459220160;
        Wed, 11 Nov 2026 20:53:40 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:35 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net v2 04/12] net: au1000: report MDIO transaction timeouts
Date: Wed, 11 Nov 2026 20:52:46 -0800
Message-ID: <20261112045301.3669532-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
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

The MDIO write callback reports success even if the controller stays
busy and no write is issued. Propagate timeout errors and wait for write
completion so failure of the final transaction is reported to phylib as
well. Return ETIMEDOUT for read timeouts too.

Use readl_poll_timeout() for write completion with a 20 microsecond sleep
interval and a 20 millisecond timeout. The MDIO callback runs in sleepable
context, so avoid adding millisecond busy-waits for completion.

Fixes: 0638dec01e89 ("[PATCH] net: au1000_eth: PHY framework conversion")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 7063f9e5bc7c..6b2e216a8361 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -41,6 +41,7 @@
 #include <linux/platform_device.h>
 #include <linux/cpu.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 
 #include <asm/mipsregs.h>
 #include <asm/irq.h>
@@ -278,7 +279,7 @@ static int au1000_mdio_read(struct net_device *dev, int phy_addr, int reg)
 		mdelay(1);
 		if (--timedout == 0) {
 			netdev_err(dev, "read_MII busy timeout!!\n");
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 
@@ -292,26 +293,27 @@ static int au1000_mdio_read(struct net_device *dev, int phy_addr, int reg)
 		mdelay(1);
 		if (--timedout == 0) {
 			netdev_err(dev, "mdio_read busy timeout!!\n");
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 	return readl(mii_data_reg);
 }
 
-static void au1000_mdio_write(struct net_device *dev, int phy_addr,
-			      int reg, u16 value)
+static int au1000_mdio_write(struct net_device *dev, int phy_addr,
+			     int reg, u16 value)
 {
 	struct au1000_private *aup = netdev_priv(dev);
 	u32 *const mii_control_reg = &aup->mac->mii_control;
 	u32 *const mii_data_reg = &aup->mac->mii_data;
 	u32 timedout = 20;
 	u32 mii_control;
+	int ret;
 
 	while (readl(mii_control_reg) & MAC_MII_BUSY) {
 		mdelay(1);
 		if (--timedout == 0) {
 			netdev_err(dev, "mdio_write busy timeout!!\n");
-			return;
+			return -ETIMEDOUT;
 		}
 	}
 
@@ -320,6 +322,13 @@ static void au1000_mdio_write(struct net_device *dev, int phy_addr,
 
 	writel(value, mii_data_reg);
 	writel(mii_control, mii_control_reg);
+
+	ret = readl_poll_timeout(mii_control_reg, mii_control,
+				 !(mii_control & MAC_MII_BUSY), 20, 20000);
+	if (ret)
+		netdev_err(dev, "mdio_write busy timeout!!\n");
+
+	return ret;
 }
 
 static int au1000_mdiobus_read(struct mii_bus *bus, int phy_addr, int regnum)
@@ -344,8 +353,7 @@ static int au1000_mdiobus_write(struct mii_bus *bus, int phy_addr, int regnum,
 	 */
 	au1000_enable_mac(dev, 0);
 
-	au1000_mdio_write(dev, phy_addr, regnum, value);
-	return 0;
+	return au1000_mdio_write(dev, phy_addr, regnum, value);
 }
 
 static int au1000_mdiobus_reset(struct mii_bus *bus)
-- 
2.53.0

