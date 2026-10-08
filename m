Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A3364EAA;
	Thu,  8 Oct 2026 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477778; cv=none; b=UHedxcQKezRtaHYRs1UsECbpiO3gvbC13gD5X1V3AofVIseV7LXrD850yLZTe42CDp3qfxg6ZzP4cJ1rSBQbazCdPgnGKJqypBp2W7j0W6W5K0/ZlIZpE2T7Ch6rdtnl9cNFUKAS0HayPyy/3kgo1BdYsXo1yC0QkbAMEpECqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477778; c=relaxed/simple;
	bh=t0UgcrUY/CuOUsXCOb0vIoQLZNgJjyV2lhlo0hZ0a6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3a4FntUKUbdUV5sYqRNA2Y1z5w92wmoqtYloyB9XQ5MG94PGw4x4xnbhaz9OezHEFxOSidXf9UmeBHtd7FMeYnW0T9jEczLWODc61yV6Q2i6Ws9N87bRqMOQyt+Qp+yAxpKkFNr6NPoyJeSt+6JREve7969fsn+k54Vgw1q+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADHzz39x8dqB1YOCg--.11888S2;
	Fri, 09 Oct 2026 00:42:38 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: bcm7xxx: preserve __phy_write() error in write_mmd()
Date: Fri,  9 Oct 2026 00:42:40 +0800
Message-Id: <20261008164240.2694229-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADHzz39x8dqB1YOCg--.11888S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF47Xr4DXw4fGr45AFWDurg_yoW8Ar1xpr
	s0kFy2kr1DKan7XanrKF4kJw15uan7tryIka4DKw4fuFn5tw4vvayYqFy0qr1rArykJayf
	Zw4v9F98ZF4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUqVcEUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgOA2rHpl1U-gAAs+

bcm7xxx_28nm_ephy_write_mmd() jumps to reset_shadow_mode when the write of
the shadow register address fails and then returns the value of the
__phy_set_clr_bits() cleanup call, overwriting the negative error code from
__phy_write(). Since __phy_set_clr_bits() returns the positive register
value on success, the failure is reported to phy_write_mmd() as a success.
The write of the shadow register value is also unchecked the same way.

Keep the negative error code in ret and return it after the shadow mode
reset, and check the shadow register value write, matching the read_mmd()
counterpart.

Fixes: d88fd1b546ff ("net: phy: bcm7xxx: Fixed indirect MMD operations")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/net/phy/bcm7xxx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 71a163f62c0e..a0c758e2b214 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -677,12 +677,13 @@ static int bcm7xxx_28nm_ephy_write_mmd(struct phy_device *phydev,
 		goto reset_shadow_mode;
 
 	/* Write the desired value in the shadow register */
-	__phy_write(phydev, MII_BCM7XXX_SHD_2_CTRL_STAT, val);
+	ret = __phy_write(phydev, MII_BCM7XXX_SHD_2_CTRL_STAT, val);
 
 reset_shadow_mode:
 	/* reset shadow mode 2 */
-	return __phy_set_clr_bits(phydev, MII_BCM7XXX_TEST, 0,
-				  MII_BCM7XXX_SHD_MODE_2);
+	__phy_set_clr_bits(phydev, MII_BCM7XXX_TEST, 0,
+			   MII_BCM7XXX_SHD_MODE_2);
+	return ret;
 }
 
 static int bcm7xxx_28nm_ephy_resume(struct phy_device *phydev)
-- 
2.25.1

