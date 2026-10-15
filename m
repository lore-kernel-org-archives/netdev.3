Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697E2E7366
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792039825; cv=none; b=iBE2R258upyb83L6PxGxiQv8pBDOTU5brHHfgj/TWc1wG8L7O0T397c0FG2AGLx9bmUAuo+S93iUNX0hLk7ehsu/C26AHl0N4aGXanlR4rIQzZHFjvqSKJI/hDDCHtJo2Ut7g3yXlzBTVHOKaHERWiv5suV8S8KLHCawwGpSMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792039825; c=relaxed/simple;
	bh=VZ3Tr2gFB2e6AncKRZFku5qMT3/qdFawvSt1vkMJhWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qUiOBHPv6Bc6IdgUWlRrmW/Svzl7XXuKSsSVMqUo5HFZDAtAlO9KXn2XkDi3Rfh+shu5VTkwo050KKt8/vekp3YTjxz3EJakyzB4ISWY6ilmPiwIEvk8RMewEFBIL3jZ3mAJ3HJQBJ0wtXtNfBjJB2c+TyjLIN7Zq+4TVeQKh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qX9JESsg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qX9JESsg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b001cd92bso649308f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 21:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792039822; x=1792644622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZeTuZ/4qQQoQ+0qzys9AulwqpOfOPP73+MEdMRLt/A=;
        b=qX9JESsgvezlEjZyV6FYO0FazvA7RN1/EqBBrae/pVjkquCTR+zKSWlJ0LZouKFm6T
         hzWKy/7ljk7jYCXEU1AyO1EsXOrOwrqKn+eBKry24VkpvOGx/B5gS5wpGNH41AynWj6c
         LgUlVlNOrhPs9i0dnhObDXbruYz9OUbjqxNjN+0NHy1O9cTcwiCKhGXIzY2OtvzaGYXR
         mpC+wBrFEQw+HEf5lnA7PF38xzGGqf1KcQ9q/QWop8fhefag1EmUYUofFhHb/AMgmC90
         w9e45za83XXoLEGb37uANYX3Kt58HPZMFaX71crDwKZ1sfp+Pe09xmM78oLBw8zf1XOJ
         CNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792039822; x=1792644622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZeTuZ/4qQQoQ+0qzys9AulwqpOfOPP73+MEdMRLt/A=;
        b=xe82bTwYKZ8pUBTEZL9lD/f0IE5QKxkVGvZkks6Z7o+2e2JDB0LOa3VIJ0Jh17FPbr
         0Hg5Y8yesvVDDCO0PPFFnCR9a0jnTSD3SNH2Uc+ABe4rEJuoSa/STobN6LdkwG2/DHqs
         KKRrmv18OQY3hfHmQl16CTDnlpYx9dJ4Y6DblsUdeV02zbZSyvQIhGvbkxf7rZEUuIDO
         Uv6X15itdGz9ejV6CeAlmQYuB+0v3yNJz3J5XjW8vrzDbUKCgQnON9W+P7eBgCKUpyYQ
         WjyshJX3r0yy7/FIlcIP44ZSm8b2rTsTJOXRgFCsmkGURueyQAdDhSgcaMyTNSSxnJXF
         yBzw==
X-Forwarded-Encrypted: i=1; AKwUvBwxhFysQXfIwHoK+ZwyqtxalhskPfStHw6YP1aPWgkYAc3LEf/SdlFamcWqWUUAKh+0YfEjKF0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4NXvd+2sfglQkGDS/Pz/bh/S4ckmLGAT2Y4mfvI39iy3cfp8d
	r2eHFeaYw19sX8cZ325yTFBPpqeaKq0vjgGMVThCuzQYa76w8bu7Vu+z
X-Gm-Gg: AYBFou2OMlhZnf4sezcB2U5vmukQCj2M/wyBt69rFK30FwNwNAhme3dBNeJZuKpoK+w
	hLsnG7xOhlyXlUJigjqDIrT6NexNEB6SuKbTztLaK6eW1+yVguhSHFTzc4AIAWz5zQkddwBIgg+
	dP5rKRzCF9aMpELGIX9c7D1hqXImtxbWiJPzxadkoVxDiw06GCRkEfXjPs9a5CczOY9QvbDovUK
	vFJzQvWqrxU+r9Wkh9iMX//3vyfsT8BlE6LvoZg65BJWg3BTC3gygtDmqM7Ybn/jtDEkL52JcbA
	Lt7gZ3GZnRuINDZ+cdNpCpeb5FuyPusOZhcghabWkI3vW3rkEq5NoIpOq95HmqwbJVedpQ8Wa//
	8sADDSu27wLDVR1ScjhTJWoeo/s85YgGy8iPs0mzgVCshLnIA/Svs/KjFoeIZCo0QfVEw3Ac3AW
	eMz18qibgAqv2zFcEC5y63kAHVgU+PtZ3ocoJjIec9NG8d0mCI4RVPmcyu919igfIlkw7XMxC/k
	QoAQXMMe4s3GlT/utGjNHC4M0Mct3xzWDNFJ7S/yoRNvqCMvgYKaKkxWxjVoFg0yYmX9EUbidnO
	+oQJ4UfibcF/26nZv63LDNeCBXXMm27NWT9KzG9Ut1PP9aRgGquwRLfC9hZpIu8pZ5Um05Z3qhq
	x/+t637oHXGv36A==
X-Received: by 2002:a05:6000:25c4:b0:48d:db43:4ba3 with SMTP id ffacd0b85a97d-48ddb434e27mr20529379f8f.2.1792039822104;
        Wed, 14 Oct 2026 21:50:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aeb3-cd01-f139-812c-65df-b930.310.pool.telefonica.de. [2a02:3100:aeb3:cd01:f139:812c:65df:b930])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd1843sm16398919f8f.56.2026.10.14.21.50.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 21:50:21 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: phy: realtek: restore RTL8211F RGMII delays on resume
Date: Thu, 15 Oct 2026 06:50:01 +0200
Message-Id: <20261015045001.83986-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTL8211F and RTL8211F-VD both use rtl8211f_config_rgmii_delay() during
initialization and share rtl821x_resume(). The RTL8211F-VD loses its
RGMII TX and RX delay enable bits across a software power-down, but the
shared resume path only clears BMCR_PDOWN and waits for the receive clock
to stabilize.

On a BeagleV Ahead configured for rgmii-id, carrier and the negotiated
speed return after an interface close/open, but the receive path does not
work. At 100 Mbit/s no frames were received. At 1000 Mbit/s all 11
observed frames had CRC errors.

Reapply the RGMII delay configuration after the existing resume delay.

Tested on a BeagleV Ahead with an RTL8211F-VD at 100 and 1000 Mbit/s,
including close/open without a link partner.

Fixes: bb726b753f75 ("net: phy: realtek: add support for RTL8211F(D)(I)-VD-CG")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
- Move the shared RTL8211F/RTL8211F-VD resume-path explanation earlier.
- Add Andrew's Reviewed-by.

v1: https://lore.kernel.org/netdev/20261014033659.95196-1-kmehltretter@gmail.com/

Hardware test results on BeagleV Ahead (RTL8211F-VD, rgmii-id):

                               baseline          patched
 100 Mbit/s close/open         RX silent         pass
 1000 Mbit/s close/open        11/11 CRC errors  pass
 no-link close/open, reconnect 15/15 CRC errors  pass

The patched kernel also passed bidirectional 1 MiB SHA-256 transfers at
100 and 1000 Mbit/s and eight consecutive 1000 Mbit/s close/open cycles,
all without RX CRC errors. An s2idle suspend/resume test passed on both
kernels and did not reproduce the bug.

Testing on an RTL8211F (non-VD) would be welcome.

Built with ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- LLVM=1.

 drivers/net/phy/realtek/realtek_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 177b62a7b2d16..c867e5213216b 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1375,7 +1375,7 @@ static int rtl821x_resume(struct phy_device *phydev)
 
 	msleep(20);
 
-	return 0;
+	return rtl8211f_config_rgmii_delay(phydev);
 }
 
 static int rtl8211f_resume(struct phy_device *phydev)
-- 
2.39.5 (Apple Git-154)

