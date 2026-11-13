Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608447;
	b=RQY8U8ehN3i6Y4RXM3rxoQYY9x9WvyxAINpU8rG+B7sl5bmQt3/OMOnl7zbGPduek37L
	 XMgg3FQFHnzZVNPRva24fzj2XPh8B8N33VjdWQwgUCgxOFsPKRAuyqxuj9zHl5hP2ZwaA
	 uBDG3eIPNq5xHL+6VutvZnXVI3r5xwlc0ST1kwX8jBcyBgZUnIPCiGyzwIvo2XHXEKaTO
	 kHsMLv22TJuFx7Nx0aZx7uHbktOClg1WRzYPi8f70+z4ONAsu6mubOZG7QoYH6KbHI56j
	 NrGimJXsOjseQU/Pf8RTJaeZGNZFO0RQbt0triIZHRXLKk7SgHVnWn22JLvpereGbIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=awTWuz2Pbv3qMcNvqNUDXdB+FnmJ4OgUX7z3jOtQego=;
	b=vO9vk4SW5SuHtjCtZ1ZewdRh6d0J0WxDzqP/JKwizsTIM+WFq35l8dCqzwoy2ksXB1uo
	 N5zdBe9D8pZGoejneJOhtsVyVrJzfVSIj1a83r6PpFvEgV4SnPug5rNgQ6+7bthscjfyL
	 Dud+J/4MZ3/LMt/6DKUvTwFqRQekadc8b7mzX9uocHb7BZLk/3mxnTZZUg7PtUWSoVN4V
	 sIox41KkELPD/XOEXk9b3mhF6flHrBPKjynHdhRvXszmRsejJH0egLw6GgEQPUnO57sqA
	 H4v49IR0s6pkHVd4P1pJgas27j4eL+5QTn6wvf1eWuuX7RjXQkSvaFeFFUEXa8r6zgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EHo/TLyj";
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A3606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C4A3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EHo/TLyj
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ae25c846edso15722031fa.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794608444; x=1795213244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=awTWuz2Pbv3qMcNvqNUDXdB+FnmJ4OgUX7z3jOtQego=;
        b=EHo/TLyjv+b+6c1JzMljB/XnMVizYTIKonHxM9wW6wHzUHS0ntvI4pKVbL0gbeb5Qy
         dCWCYGQZK/W6yBc2Fi1HqO8bwT/BUgiJ4L+zMSsFvsPeS29JRqLA9ztkhEKgvWdPdzP4
         C0CI5DzCtqpQM9ilS1UfuSg1W1zFcXea7xiUWY2SRd5uzeP2ZV9cr5OkyR1G3R9oDrfr
         MZa9glg4Bj1nupn4zl4GeUyrLqkgwCMswd1kUQgAauWzavtGojEA1JHaIeKsKR2S1uka
         XZcuDHzbmDozJga7eCNxw5fu+NdGK9yy6K0/TF4LBU2HyiS+MSWqncmimT2H/v8jKIA/
         J43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608444; x=1795213244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awTWuz2Pbv3qMcNvqNUDXdB+FnmJ4OgUX7z3jOtQego=;
        b=LX6mQr84UYn3NZbHPGtB6UiWS+pyj2FI76lSXn5GqrwlJeyTVEgeGZA5nE3gcBGvLt
         a9xhMEi798jSJpRpyO0+HJnKyxLeTvEf9H+IqSsSSUHCC2+c+SvKFxCeDD6zAP7/sS+Z
         NxCgYmwVTZup3616wKOlfwTUFAZcYcWEJ6uDOIvvO4EBdXtZSb9r/UeP4NK/+fVd3L1J
         VfrjBFrPsB4TFa+Q82AIRUzT7uUA9AlxOyqEQ0m1xnswbZV6vSMrffDYJHLYrDIFCpPJ
         KncbzuESZz1bc7t7B7+fzAAlHtynxtOdRuoI7SENOg27u/lyTOCJaWT38PlHxz7tWkB3
         zomg==
X-Forwarded-Encrypted: i=1; AL+hErFoRBMcXhKtLT3+an1G0CCnyq1W//Hhm0jmv19sLmNTeGPPoJce/wRC1hvj7cKFRomwuLeIIi0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TW6Tc3+kcQYmGAO6bRG95NA7rT0/N05AQqKR5kMpSEbJhORP6
	VPp/i04sYnnEMARD61ezRxpEKMf/GZIDuW5VjCeRhWEei07XC4iubhV6
X-Gm-Gg: AYBFou3FmioQlqKo5Iac5QC+yhrimWAEVs6rwVCZq216yvEvX0IJSQfHJ9iEw1Pgvr3
	B7vDdW9rlJRaQUIQLT2GqeJzOammn4FMj+2dG2nfmo3J3qPfcta5kCskSWkfuUrwYIFZJPOzHIR
	TrkvNnAVvzSOUp7vnvXBM4mgx77AQ6qqzjIae7QcUufL4wpzQkGJirfiJRsFWsMrYf2EX26AmYp
	RzbfY6gTobCc4Nl/9PqPurdRSf/RgXLnVvpQjbLbO8TXrYIeciIGmm3jq5gZttKJ/7neguUXW0W
	UXP79mBTgekvZQK5XtZ6gVJwC01WbDeycyqBn1Xrn1nv5eRL3LRr7s7CeXyfmzfMBRzxnhpz2aP
	r4irMEdoL5SMO3C4w8oNBpC+kHTJOn8X8HukSJTAyTylmNCrmvah23INQB5BjxP5p/P5FECE0i/
	J3ReTaa3DXNT3wi9cphE3rbAQNV19kM4goeiDvsqZg4dzd+Hqvc95iBnkaqcIzaLo7ESZhxYHUJ
	O+HkVix52Pee5qifGTPY8YMicQ6loPB8oIvrS+TeHLsXsJyiO/tDnGuCXgBbSYoFGFN/fjd3bSv
	+oIT0xTEPHUKksjCddlvFCvpsFXxruL+C1GWaAGNuYvKwv4loZMEBQqsn33qLNMxF7AXL1jr77G
	M6uDeUS9mfuNDekeoGhmTTFV3dqevZLTr
X-Received: by 2002:a05:6512:138d:b0:5bf:ce20:57e8 with SMTP id 2adb3069b0e04-5c1709c19c4mr1534065e87.40.1794608444157;
        Fri, 13 Nov 2026 14:20:44 -0800 (PST)
Received: from localhost.localdomain (85-76-110-212-nat.elisa-mobile.fi. [85.76.110.212])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171333630sm1137443e87.19.2026.11.13.14.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:20:43 -0800 (PST)
From: Elias Pukari <elias.pukari@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Elias Pukari <elias.pukari@gmail.com>
Subject: [PATCH net-next] net: phy: et1011c: don't write an error code to the config register
Date: Sat, 14 Nov 2026 00:19:17 +0200
Message-ID: <20261113221917.3542509-1-elias.pukari@gmail.com>
X-Mailer: git-send-email 2.56.1
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

et1011c_read_status() stores the return value of phy_read() in a u32
and does not check it for an error.

If the read of the configuration register fails, the negative error
code goes through the read-modify-write and its low 16 bits are written
back to the PHY, for example 0xdffb after -EIO. That sets 14 of the 16
bits of the register. The interface field (ET1011C_INTERFACE_MASK), for
one, ends up as 3 instead of ET1011C_GMII_INTERFACE. The function still
returns the result of genphy_read_status(), normally 0, so nothing
reports the failure.

If the read of the status register fails, the error code is compared
with the speed bits. For the usual error codes this does not look like
1000 Mbit/s, and the update of the configuration register is silently
skipped.

Make val an int and return the error of either read, like other PHY
drivers do. phylib then handles it like any other failed read_status():
it triggers a WARN and puts the PHY into the error state, with the link
down until the interface is brought down and up again.

Discovered by an AI agent (LLM) inspecting the code. The issue was not
seen on a real system. It was confirmed with a KUnit test, which is not
part of this patch and uses error injection: it binds the driver to a
PHY on a fake MDIO bus, brings the link up at 1000 Mbit/s and makes one
phy_read() fail. After -EIO it sees the value above written to the fake
bus (UML on x86-64).

With this patch the same test sees no write and gets the error back.
Not tested on hardware (no ET1011C available). Kernel selftests were
not run (none mentions this driver).

Fixes: dbb7a95d810a ("phy: Add LSI ET1011C PHY driver")
Signed-off-by: Elias Pukari <elias.pukari@gmail.com>
---

Notes:
    How this was found and tested, since no hardware was involved:
    
    The problem was found by an LLM (Claude) reading the driver. The patch
    and the test were drafted with Claude as well. I have read both and run
    the test myself.
    
    The test is a KUnit test with a fake MDIO bus. It binds the real
    driver, brings the link up at 1000 Mbit/s and makes one phy_read()
    fail. On net-next d1f4b7c6b997 and on v7.3 (UML on x86-64, with and
    without KASAN):
    
      before  config read fails with -EIO        0xdffb written, returns 0
              config read fails with -ETIMEDOUT  0xdf92 written, returns 0
              status read fails with -EIO        nothing written, returns 0
      after   nothing is written and the error is returned, in all cases
    
    The second value depends on the architecture: -ETIMEDOUT is -110 here,
    but not on mips or parisc, for example.
    
    The test is not part of this patch. I can post it if it is useful.
    
    Also built with W=1 for x86-64 (gcc and clang) and for 32-bit x86,
    allmodconfig.
    
    I do not have an ET1011C, so this is not tested on hardware. For that
    reason it is sent for net-next and without Cc: stable. I can resend it
    for net if you prefer.
    
    Not changed here, to keep the fix small:
     - "speed" is a static variable, shared by all ET1011C PHYs in the
       system, and it is updated before the registers are read;
     - the return value of phy_write() is ignored, here and in
       et1011c_config_aneg().

 drivers/net/phy/et1011c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/et1011c.c b/drivers/net/phy/et1011c.c
index 6cd8d7758..603fe5a1e 100644
--- a/drivers/net/phy/et1011c.c
+++ b/drivers/net/phy/et1011c.c
@@ -62,16 +62,22 @@ static int et1011c_read_status(struct phy_device *phydev)
 {
 	static int speed;
 	int ret;
-	u32 val;
+	int val;
 
 	ret = genphy_read_status(phydev);
 
 	if (speed != phydev->speed) {
 		speed = phydev->speed;
 		val = phy_read(phydev, ET1011C_STATUS_REG);
+		if (val < 0)
+			return val;
+
 		if ((val & ET1011C_SPEED_MASK) ==
 					ET1011C_GIGABIT_SPEED) {
 			val = phy_read(phydev, ET1011C_CONFIG_REG);
+			if (val < 0)
+				return val;
+
 			val &= ~ET1011C_TX_FIFO_MASK;
 			phy_write(phydev, ET1011C_CONFIG_REG, val |
 					  ET1011C_GMII_INTERFACE |

base-commit: d1f4b7c6b997c29de67ad7178ababac2328cb1b4
-- 
2.56.1

