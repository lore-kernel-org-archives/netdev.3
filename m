Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA17347FEC
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673828; cv=none; b=EWAliRPVh7NBFr7p8WmHRgTZ9kzpvfxeMpL2+bht7Wn+p5A9ckZtIJJHChvZfYWhjaON+Iod+almBOn2RrbJU707ZohFF6M/KA0EYDNE3kK4sDvlPIbFlaIC+4StBqAPRa8Rz0Xrde7afteINtqkQfrwMKdNTnrrh1Ou2IE9/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673828; c=relaxed/simple;
	bh=S5Yk9i5Uw4O3a4L26F9Dhe+pD2vL/083DG/Xe5+4P3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+9bRPDtGcfAaXC9X037prCFvY7mJ6j9xlVBK8rJ8uBDZncc3jUVmpOGTHhMUD20s702mCEmccvUeqNV1WtbO9oivHWoSbWov1kFahD9B8MfPDPXItR3+YO18vjmJi7gNNXnOEsQf9hoL5oO6Ta4gSiSZNIHi0KS5GOLW1vHG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN9cYXrq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN9cYXrq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2df8c28a0b1so3649255ad.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791673826; x=1792278626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vI2kBkECW5iZmYYSZT60CeuUy8PSWpfrPWMFdyyehWA=;
        b=nN9cYXrq255tD9Aahm9RsHi+tbECrjSHxGqeYvjxXWO9iw45YcAYIMNBR1pzA/YLqm
         WbX0JBDza97y+Cpo+ZLtYxAtcyaV/SZ7l8l1Afylg2SVCtaP1OV5wtBkRAT4q1LMN2dU
         3w27CFVNO2PlB22zUTElTl3vMyhlLfAjL723UtCFFDsF7x5Dw5N4HoGO2ViIIFIBRdQ7
         lgRB0KvVoLGFwFm8lrKpaEZ+5GiGiqn6K9xSAbci604OFbHIGW8u6XqdfMln6I1ESv2w
         jcbTANXVtsevDQGPOTmU9nge62XFlXEZ7wKt+mNQ3eocE9BetstvzwbA9QDLBBcxeI3a
         hdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673826; x=1792278626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vI2kBkECW5iZmYYSZT60CeuUy8PSWpfrPWMFdyyehWA=;
        b=241Oh3J1W8V7riRC6rQrDpvH4N70b6BYwavBcBh447os7fgtriT0IPZtDbgSioqUpK
         GGgKv+otamW08Kq8DRCX4Ggy6f2u216O/gezHy9Wv/E+/U/VaW7zD9+JwpRiB73lTNSv
         FC8xqX7MBBnMYNI+FoS8DMdlSMUfkBf2w8o0WrAzApxYVvp6KGxQFXhf3rnISrMpJBtr
         fG/YmMeHFbX9ZmI5yzqqttdxPxSE5bg/e4PqNCBlh0JpnSEfaLxlepvlwOwx3rLpn+Hn
         ARTEL77Nu5fy8Yb5LfzO7d0kR1TUmZN/+1ACvniRZ1YAkxUvKOpeYEtuZOPfdqD9fOa0
         O0pw==
X-Gm-Message-State: AFq9FYKO2IeJUeVLujVJoLL9glvOFULQhAMIuYnWtmxR7he+bOQR18Aw
	eCUH7lA8ooi//RB8+VJrirhpTOFqehWQzSqiwm9VWuAsjMAqotxAxQDziOYEhQ==
X-Gm-Gg: AYBFou3hJjFNIQnPGgeTJSYKufsbUZK3N3IEjZTkSUET0pcFnXpGGVqdYTgri7i71uv
	n1cSA1nnX0hU8EnNGPZyLxNLCV58Aw4Dhfg+EkFxCkxocoDcOhoKJOqm4BeWKP83/qbl3We6tha
	7JmsjjMiH13Drsn45AqP80cSzl70mcUD4ZdLAi/rj2pJb5rdUKa/6QtAtVncDHr1hTceI1U6RfN
	8TbQhlToF7LsXO/uXkeytTMOdUWXaP5BzHP2MZCnJqiOX6JGe5v2+8zGRLuDWTRdWp9B+xeHzQq
	mXFwmIB5gfwR7sSRq9q0SJJ57uNzEHN9yvmLwQ10g5RgH7Gv5XfCch3BsIJeUiP2e6xU/pHCPVP
	uE//YHsQWn3Eev0gZiUOJIwEa6QQ3HvRV46yhkqXO8k0j8BMiWbh7YuVW+VAM3udVxkSLEaIjZE
	Hd/jlZfh/3QC8XihuWh/eavokzYppoj9XADBj4dFWbc5UPVN2GQuvV7DNjCxKPtdQe2/aJ6POab
	gilPGC+J52iZG9K8nObxqaE4lY=
X-Received: by 2002:a17:902:ce84:b0:2e6:5ef:abe9 with SMTP id d9443c01a7336-2e8429addfcmr42328485ad.37.1791673826108;
        Sat, 10 Oct 2026 16:10:26 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e14f6sm26813065ad.69.2026.10.10.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 16:10:25 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: motorcomm: Do not do the redundant MIB clear
Date: Sun, 11 Oct 2026 07:10:12 +0800
Message-ID: <20261010231015.2600207-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIB clear in yt921x_chip_setup() is redundant: it runs right after
hard reset of the hardware, which already zeroes MIB counters.

It did not execute the right procedure either: ALL_PORT must be lifted
from latched value before CLEAN is fired. It works only because the
reset lifts the MIB control register (and counters altogether).

Nor should we take care of it elsewhere: .port_setup() should not clear
it, and .setup() runs at most once per registration, so per-port state
is always freshly allocated by .port_setup().

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 980d066a4bea..43e8af90ffc9 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3996,12 +3996,6 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 		return res;
 #endif
 
-	/* Clear MIB */
-	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
-	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
-	if (res)
-		return res;
-
 	/* Miscellaneous */
 	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
 	if (res)
-- 
2.53.0

