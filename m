Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589174;
	b=SY6WOcFrOXQl81baCMQjuCUEvDF0dQEejzJTQdRBjCH7QQ6GWxmURA56XmJu33M2/6fC
	 j5jcIB8uVEaP2XQ7D6NYG4DDFlTlmFqVN3/2yZk7CkbWmcsnjMZyy6eDdzgkvRF9BQX2L
	 8X5ehtsvjBJJYnvR9JEe5iIyYzLy/ju0D4oj9j6ZiK8WL39MCXCw2oVBoi5ZJ2Sot5Zip
	 WYo7hf65LhPuacR3o+o5y1I/3PMi9QqLixzv1IA20nIeVmgOd/Y000Sny+UD3/LKjbLTk
	 Bf9akyFIQ/gekOOHo4SCL6TzgKmrxolJIEH7LwYzLCGFsfEVygU1fTEGlA2NRIfj18Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589174;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eq2xc2OeNPEpdeVJI8qPD2P45dx0Jk5LHFkdJOBBdxM=;
	b=5fYO4Uc2AHNc8SiUnM9VaqHRmO/VwXjhgjegp4D4V32jJG0ttIy+foZhsq2jAhJsm4l0
	 IFJ2iTt4/rhPPmtWos+570vJ0SAYaTmYJOQE37Fvh+PQvfVnb+ip/xPUaFDMAfAEezoKq
	 yuMZUFtuP+/31tyYWIWdnS0VAT6pDRYtpQL6H46iIldvV6ZJZCdEdGtNNZT0GxH+1LY6v
	 1FkSufoxwRpfXpeB0Nji6g3b7qqyzvTvVEl01M04/NwYEGkcVuzCo0ZMghGR2bPPT042m
	 KFBoiThWBEghFT7mega6S4Hn+xXa15l/dQuvf5qFFMUQp/2OuvkjALbU9crYtMlyuqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFB1IgE8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5464B60A3807;
	Fri, 13 Nov 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFB1IgE8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589174;
	b=g6JZ8HGZoI6lWieyNShc7L+cl2uYbuu5yfulOJmebqYNuxDlTqQAIMyc1SLd/lFNPaV1
	 HfWqTNCeNWsmfTrWFMWP3OZXgAyMeTRFuteGh0ZbpSXvPqnFVpkafva8HPDYaX4Uv4cTu
	 XO94Beg0Wc29nI7aOWnssagMyZed2Y30Z7aF9jrCL83NAsGMhvOhZLbuR55/KTmJtF3br
	 Dd1+JfEys5MNiValPcg70MGpQe6Y9YWK7dgZA1fYVMyhK5cmlpCRbp2KiGia/SjFNe1UQ
	 1xxDvpodS5Uk03TctTFnFz4vYNPLngQV0JV5ZfPqKfyySMsdrjF5va+V5BvrFTiyJ/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589174;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eq2xc2OeNPEpdeVJI8qPD2P45dx0Jk5LHFkdJOBBdxM=;
	b=ivIApkZSYrCfbaC+Qtntr7UXqg0g73tLJdb8KFDnliqHJSXMrwQPf/tEWQpXEkaf3mdq
	 WHDmQgAZt55zwPh6Yfbf/2CNBWHXqhsQ9N7NbETf/2gy/PEJG+K859Da9XphVBazjkQma
	 dh745ftZv8SbTGMkZ7Jo7LkzB2rqHrM9QXIax/KYODhul7ivckv0XeDxTn2G7Y/YdriTo
	 P7PJXKqDIfWvBqSkG6y+1IxulbMOM88kOkHZ1G8AXa3MnQLFmlB52HS6vVcOewaJnK3MU
	 HaMcUcKo4KVqZVXYamAHsZVYAzn3wUTvkL3PbwP6Bvf/DgyDwUmtj7XQi/8VE434ozA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 180FA1F00939;
	Fri, 13 Nov 2026 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589174;
	bh=eq2xc2OeNPEpdeVJI8qPD2P45dx0Jk5LHFkdJOBBdxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WFB1IgE8CUkj+6Z4QLK/VjTKYwlmvJFpA98CR6vZcDtWfr7EwoLIS+nxa6zdLUu/s
	 YkOOZDmcofP9kMoRG2ZIZHwpT69z9PRxb1XZ4Y2NMRSg75ktW2Enx9E9mtSkD6vojn
	 LYf7owP3/5MvcPtf3ijqWqXtLlqztQeu/JQowHttGZP/9DT2N/0sjvLET8DeOjHRut
	 9LGNlPw+YncONuEC3GnVYcSRdF2UAg6+Gk6TPieY4j5mXuTknRt55rxN31a1qaQKWS
	 y3NDOQTPXj5ueCE7yYbjiY0CnH/cQg0uWxkzkEnB9YzhLchwxKwGM2l1pjDg80N3jA
	 E6yiX9/g1Pz3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 24D6249A43;
	Fri, 13 Nov 2026 16:59:30 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:33 -0800
Subject: [PATCH net-next v11 14/14] net: phy: dp83867: Use
 genphy_loopback_no_speed()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-s2500-mac-phy-support-v11-14-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=1372;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=87SU+XRFLyfHxWdkx39h3CNz/aAI9UytC7bQUseGhEI=;
 b=RwrVKWKMpM+IGE/WwBKcUeSKSSg29YqAKc2KsjnbELQcB0Ggn550Azc8Mce/HagQPEMb2oCkX
 snNK35YnaauDn2k0IPp1TGSJomMr51xqWiRaPeZ+e5QnuiioS+tKSDd
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Replace dp83867_loopback() with genphy_loopback_no_speed(), which
does the same. No functional change.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Moved the vendor changes into its own patch.
  - New patch in v11.
---
 drivers/net/phy/dp83867.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index b4b4931c6f8c..dc00484c6c7a 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1057,15 +1057,6 @@ static void dp83867_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int dp83867_loopback(struct phy_device *phydev, bool enable, int speed)
-{
-	if (enable && speed)
-		return -EOPNOTSUPP;
-
-	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
-			  enable ? BMCR_LOOPBACK : 0);
-}
-
 static int
 dp83867_led_brightness_set(struct phy_device *phydev,
 			   u8 index, enum led_brightness brightness)
@@ -1291,7 +1282,7 @@ static struct phy_driver dp83867_driver[] = {
 		.resume		= dp83867_resume,
 
 		.link_change_notify = dp83867_link_change_notify,
-		.set_loopback	= dp83867_loopback,
+		.set_loopback	= genphy_loopback_no_speed,
 
 		.led_brightness_set = dp83867_led_brightness_set,
 		.led_hw_is_supported = dp83867_led_hw_is_supported,

-- 
2.43.0


