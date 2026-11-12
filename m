Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489295;
	b=kQEM4kNT2GXuEH6SjV9CAkPzTarxuEsD6dF5dWLOpFfjOvl2NwI+uB2bR48+mw5ap7Vs
	 iN3gEXn6XPLVGpbwNq2phAMIgEK/ZtT088HrxPa6RQcFMKi+sw0PzzcaoBqL3cs5pCQ78
	 BCDu80bfkbPtauks4oyunwZwaXXlttdolMxhV9DAG1quMuorRx3ddnwD//eyY7n5YOwDK
	 r2Wm062OznBV82OH0v7vds8XRE/TGqYfJLUpy9UFlfArS9OPuTQGvDXyiV03YZl0lOyHH
	 wIpl1XNZZSILt9nqWBzg7e5RfZfqb5Mo8td+yMa07r6mYCvgupRDqJiErRxKEPBNOFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pEd3z9MXCanS8Ka4a/h6F0U0CisvJlSwqV3A+qWLfjs=;
	b=nF1x1u8cQgRoeGkhNrznwKhp15dcs5SZHSrZvTgsSaKrIj4OwjwrHBXMSTQM4DWXHi4V
	 y9sSuWP7Fch/7bZ1j5CEosmiBb7bYrqPDdhd4uPVlElAsDcdFYzNVrohrZp3gztlqjtop
	 IUPGFXXTNiD05vfCJe0cw1oHUdAMIgHVzQ+wEREJctkYSdWvcerYhwxV9zRXfSgtKFt0/
	 PIB7LMa8/O0PhGVMll1/d2iWkFjwuQ6wI08m2lOQBtrThABoJ6haNeJYfTft2Yze2pULj
	 nossNua01LDe1F47oGFZZPWN5Yif6QchNG4SKft83SCl2IpHHjJWIID7jR/8Pllcl6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3gTTP+H;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940E606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D940E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3gTTP+H
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so52762295e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489293; x=1795094093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pEd3z9MXCanS8Ka4a/h6F0U0CisvJlSwqV3A+qWLfjs=;
        b=I3gTTP+HL30VFjoRwtLs4qSDYh8dL9UGbx7RkEi0ruJsLpN2Xtze460v0FzRJMc4Oh
         OSa/0LvNqadDMZABhvgNeBLIx2okLKQTK6flYRhayFxQL5YxUs9aA5C8HVeLC2w4aKW7
         3WE+OXlxbGZjqgRyBLGladqfVFIeAINjG5QsYpo7Yj1dCmzDl/bTEQUnrUfuYr6wZm+a
         s4UQOfL2jQP02N5ieNuKgzbllJOD05d/DB5j5bcGFCOs+r1f2hlDYuszQngxN4PuS1vJ
         vFVpQJSgUwfJaYawHEzh2KI9Xe3pyu4zQ2/m4y20wVJVhxP4Jq8hgo+KW1/IGufAeEbU
         Od8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489293; x=1795094093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pEd3z9MXCanS8Ka4a/h6F0U0CisvJlSwqV3A+qWLfjs=;
        b=vx2aPyOnqF4jEM/PUNrUGmG+RZcQfdhMhvRNm3/bycSJqoimxxH016URN2A2nXucUp
         Ug2iAggqcU69YBWCfgvTRPSXCq9TCYcAJMRDGSlRq7LJutWKqg/CvZiUDDaMHN6ZYBsR
         BCnp/AwYSN6BzaSFO/drubRTF+DEI7NE5oThjYoe8UMN4B9++cUTrEKmJJPlFnqfNVMZ
         +ef5doZ2r+vNr8dVmX53p9bbiolhm/drM9rVYaxf8EL29j3iSZ7ER81g7Q6pIMDyKtqR
         bDZ8wbpMuqcWpwGXfXs7B39+Q9pePFVvRn5FJYxY+K5GgrdHh/wN6AV2QpIxkru37jyb
         aKBQ==
X-Forwarded-Encrypted: i=1; AL+hErGvGzzqAdruW5coe6++zEc5HyuBZhYA5lUsPv+etb/ckeTYuUfmKvOkt4pN4tkQ8jgzvivswic=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8U+YSFZQ6sxr7vWnVcjQWm1dUxspqNBrDDyeW/6vH/hPctwGr
	Lz9TQQIqqCU4innx6esrIvxmTixjLaxRuErGwDMuB5jQ1cgpiJ5b3Ji3
X-Gm-Gg: AYBFou23nQk2gBnD/au/KUy2bLA2XoAYtfd4Vm7Zt/pdYN5jLX3g0Z9TXlM+r9BtXw6
	4pfzMFFhtpKUJDxZm8JujVV+zrf//tFoR4MuewVa9bOespKaAeTWcqibIixatxl9gAW5hzJFGGp
	L+m3VzxngY5fgXx01fXaLkzKLmmKQOrcxSlVaym8xQqgpi8hLEYpw5CrtIjLXpzgo5D+7hWzQxa
	Z+j2I0EN7RPRy8NZotbZgz6Z627Y+OwLFfCfqxYhks3W0/yk8BgjjxI1PDVrKVo/Hh0anTLBIVV
	y1TQIeydST67sdOHtTwK0zW1czuW832SX72PxWN1/3mhKQMxzi7UZq/5Qh6C9CoqhqBvqItDQ7Z
	0X2zX1d83dXTRVXMDCJHmi9+p60u4xqnj3E5A4oGMqAaEpdFd3xwKOdV1UuCFNhZg7oF6jyTXs2
	CxdoUPHyGhfTuwHFpdSNZS7pUIf7YNGlX4dCGDPApoUO0F6TCaM2U92tMFD1Eivt/SQG4Tk2RLU
	G832PC52raTg2Gz2lKD3dPJt+IolHwcbxbWmdjU0dqZQ9hKC9seXqxTO6wJR+Hxpg+gC3qVB7in
	QleI3c6A/WA5yg+jBPgvtemyDpdajcwc8jDhCK0hqdspxh9gJwLqvJoMBdy2+0WFo//LBow/Edj
	7jaGgVbjmpsinImXupS1bqhVcFxSk+U5kvhmeXZic1aTthLh1TptJ
X-Received: by 2002:a05:600c:8b34:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4ba093775a9mr101916085e9.7.1794489293257;
        Thu, 12 Nov 2026 05:14:53 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4ba0951fe22sm146453225e9.3.2026.11.12.05.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:14:52 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net-next 1/2] net: phy: use const char * const for phylink_an_mode_str
Date: Thu, 12 Nov 2026 14:13:56 +0100
Message-ID: <20261112131358.106442-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The local string array should use const char * const as reported by
checkpatch.pl. Use the correct type as to mute checkpatch warning.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e885da1c2831..bf1962e572f8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -184,7 +184,7 @@ static int phylink_is_empty_linkmode(const unsigned long *linkmode)
 
 static const char *phylink_an_mode_str(unsigned int mode)
 {
-	static const char *modestr[] = {
+	static const char * const modestr[] = {
 		[MLO_AN_PHY] = "phy",
 		[MLO_AN_FIXED] = "fixed",
 		[MLO_AN_INBAND] = "inband",
-- 
2.55.0

