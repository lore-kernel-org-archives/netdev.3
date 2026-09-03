Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4A4A5EC9
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439019; cv=none; b=R2I8DoBgvrxEBs7RGH/XH9eDq38amYTpF6LXO7HfTSIGLkxGEFURd5hZgTRkf+H4jCHCG9zt6K42YKkEuCWoPHZrgfmHMoU28seLkYsr+s14dhf+PKJNEwvhv0T8YyRCXI9vsgo8PA7BmIsymS34g+PNxElbayOWzIRQ6ihw6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439019; c=relaxed/simple;
	bh=brpeVGkdATm9/S/f7Zt0radMeEIsjvEyqqEBAC7TF5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJfJx2RSHn6+3RKZKeVOSFrDnhXQfO4eScQx+Ad2d4RogkZSbT4Bf20ob6bq/J0/q0ZmaaCTauuI7m6Z2eQKUmuRag1NBdOo5Aq5KWHIFuMMiVJAD7t0ZhpaK/c66jD9yA5OKIk48q41Xy1H9Nu/t7c1NtF8+zjUJtXh2Eujgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=NPTgMp1g; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="NPTgMp1g"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4843f205a5bso1598944f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788439012; x=1789043812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KXagxsF6Wsx8TN0mAK3YK+Pn/X4rwuAoc5qw2yFfaXA=;
        b=NPTgMp1gwIkT5jNtgsMTbnVuhvSRzmTZUZftpHDvzIcP6CLUOBd/+v+RflfYD9emvi
         t7HDILJokFB5Urdw83Dt8rXEvRDVdFuVqduvPI95MJyz2QRO0jgJnj8xdJEgrGIxTQ1X
         vGUI2yRhRmwtb+dW3G/4dJRJm6LdZdTW/hWIzY2lwQEWkb6Bi8RPcPzaiM36D56xQh5c
         9R8uMJP46INXQ6bySo7TG/ExgVjvTJZvqkTGUKHjYLxRTTSFnwKmYOFOvpidtlyCdlv3
         rCoVxFUjSmFhN6YH1VejQkC4Qg8XA234kSoCV2J3tzB3QSWKnHHPsnFYnyC6BxRwEcMP
         wi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439012; x=1789043812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXagxsF6Wsx8TN0mAK3YK+Pn/X4rwuAoc5qw2yFfaXA=;
        b=dZGgEcnQkXJL5vB839WrXlLDcXa35Ya/bt/teHlamHXYq2gjIHAfXCOcTXR3wZbsZp
         vmaXbcN7I3q6rtMQDHu9NXSQvfK9oB7I1Q/dQy2xtnUE27KGhuT8SosN4Fe9CPvBjMQH
         g+ESTrqKlDLIkc6wFQf2QMboh1GXTtE+aC/CU9ovY0m22kTw6Z7wt0njxapSgFpxIyX0
         xB8SgC+uMkOEMXREukVOye1n446dexHhDc0fm6RI2ffexOJYnV7yHZnQ8CN155dtq5Um
         i2CgADm53jYwBOqeim1i0NC9e9x1/2H8NVsefT5mgYKY+vciRChmLj0XS92Nt50TXjqp
         o0sg==
X-Forwarded-Encrypted: i=1; AKwUvBz0ZR0MieTbZd1/TL6yMxYhXt84ysDc+ppypVSdhlw4GfznXlndwJvqJ84VA40KlFkIHDphrQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++n0B8DN5Yay2XUT4Zn6AcgT6xnWz7PBk/ruJjBDcP03LoBlGY46
	Y+PUoPWA/qxHpRP1ZrLJKqsdyJ/5whgUTU9idYcT5q5hT0qIFAUGTPtVYU4TOQOhB00=
X-Gm-Gg: AYBFou2vL0q/M7jYEwoQE/94td0EOMbRhAggneb6w4jwTK5d1FI46KqMBl7tqGVBIhN
	GBj1DQFJ9o+2r3GERApbgPZzwIDfrhhjbUH490rYwOxWUU/rcmk48RGj7h6G/G2T6HGFc0jo5HY
	t6g8EDivhFsxAZIrXR4Wjyw8akKrLt8ZVY+cWYP99FIus9vQJQzWD7r6DlB3PiYJ8HchO6smJJs
	cKdP/MPMXFsrQe1yxuA0bD0JpO9YcJVcy3FAYXPzmDDZFdzxgGEAF63kNZac4H9VLScxY46kYGB
	/wMxL5N/ZLi2K8NTrUkqX6nNBbKarqz1Etti1PVk9G4gwjHcqs4OqKWYDi6w96Mxa09sGaErAJH
	Kt3ShjiR/itBX42KnGTlUSSvW+E0NWFO4LAo20I272KudfWW/HqnlN7s1dlF60h3fwZlpI9TCf6
	TqnD25EfbGnVUnKBHaCy3O+0sP1BB+UYW0DmjMNeM=
X-Received: by 2002:a05:6000:25ca:b0:482:fe64:1717 with SMTP id ffacd0b85a97d-48488dfb16amr19441433f8f.7.1788439012371;
        Thu, 03 Sep 2026 05:36:52 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed3706sm13829439f8f.18.2026.09.03.05.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:36:52 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: air_en8811h: refuse a firmware blob that is not a multiple of 4
Date: Thu,  3 Sep 2026 12:36:50 +0000
Message-ID: <20260903123650.23855-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The download loop streams the blob into the MCU as 32-bit words and
reads the last word past the end of a blob whose size is not a multiple
of four. The shipped blobs happen to be aligned, so the overread never
showed; a truncated or foreign file would carry up to three bytes of
whatever follows it into the MCU. Reject it before the first write
instead.

Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
Assisted-by: LLM
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Found by review rather than by a failure: the loop reads a 32-bit word
per iteration, so a blob whose size is not a multiple of four overreads
by up to three bytes. Both blobs the EN8811H ships with are aligned
(16384 and 131072 bytes), which is why nothing has tripped over it.

Exercised on an MT7981B board with an EN8811H behind an MT7531 switch,
with the DM blob truncated by one byte in the image:

  firmware size 16383 is not a multiple of 4
  airoha-en8811h-mcu mdio-bus:0d: firmware download keeps failing: -EINVAL

The blob is refused before the first write to the MCU, the driver
retries and gives up with a warning, and the port comes up without a
PHY rather than with a chip programmed from three bytes of whatever
followed the file. With the shipped blobs the same board loads
firmware 25062302 and the port links at 1 Gbps. The board runs the
loop in the library that the pending late-PHY series moves it into, so
the message carries the bus device there; the guard and the loop are
the ones in this patch.

v2: target net-next: no shipped blob trips the check, so not a stable
    candidate (Andrew Lunn); carries his Reviewed-by.
    https://lore.kernel.org/netdev/20260902080525.2211446-1-f@lex.la/

 drivers/net/phy/air_en8811h.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 0eeb7b9a4e26..34d2727e8222 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -312,6 +312,12 @@ static int air_write_buf(struct phy_device *phydev, u32 address,
 	int saved_page;
 	int ret = 0;
 
+	if (fw->size % 4) {
+		phydev_err(phydev, "firmware size %zu is not a multiple of 4\n",
+			   fw->size);
+		return -EINVAL;
+	}
+
 	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
 
 	if (saved_page >= 0) {
-- 
2.53.0

