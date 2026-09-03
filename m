Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A05335BBB
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402530; cv=none; b=ncqukYmCeBpre3xIylpZlbzl7pOqRjUzGq1B43qAoKFfwxLRTlUF1Ht7l4gp0JJuZnSupcquvuu3TgNp0IMM6RNwLySipMXm0myVamOJwFEBZyPgx26ULE3QKjBLoInynon31XHvK1nhKBcoZVj5AoA7U4iBJrUbicBEyoz50dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402530; c=relaxed/simple;
	bh=MlS3IX0xH3F6kltkBlDgyiNzI+eN5idd3Z1w/9mta0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjEDKscb2Q4ON2pW4+sLLei0k8ue+ncRbS5LR+6hjVgoJOackW1FsWU3aQaUVRdwHzbWRIkbmkmA4HJtAeB4RoHXocA4/O8i0ML3OKJwpNlrqobAIjK3jShkrvsT2WF90rSKb/l4r7V1sB2Rbf9UQ41nmqgl6cP+FxDnfNFWOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKDBwDMN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKDBwDMN"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso358529a12.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 19:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788402528; x=1789007328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5h9wrn+mfzp9QC7ABJOSoQKED7IPugC4MTokiR4EUYE=;
        b=CKDBwDMN5U+nI776xYf3WukymksUp8/+sF1XrHfKNvZCbmfaXFb8WK6XG9NRKpppTu
         PIvRBAg36dZTZiGmxwOCTwM2QqA5eDSgBY1PZX3fvOZBgXPCLX1oFvcXXMrPeQQ0dYfv
         /EwGxbXGwpPseCWEn5EZvSrDxxoIZt0gCnIDguHTgZMmPkrbK6P5G3IMob+gVQB37IzF
         2QazuZ6MPIAH7p/jEHtqRax3i4CPipGfSvaAIRUZllLnPHWrlDFX7Q5g2HXVAKrnNRrO
         n+c5SZ+rQ+n/aodXD5r9fSOrMNWXseqaN1b1PLx5XhYT07NsOwKTzxT1OuRRtiT+VPhF
         +3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402528; x=1789007328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5h9wrn+mfzp9QC7ABJOSoQKED7IPugC4MTokiR4EUYE=;
        b=L76SKCO43tKG0DC/rdwpei0bzKrkjmiLtD31M9TbkMIBwG/pQJ0+y7jwDWp/Mc5Kmg
         M7Nb7scZKIg9XS7z8TecUZTTF/gjlz4sUq+yP9a9Kc663VvBfgnfqDcGP9uAoMSFs5Qs
         ZqshIhhuI8HNI1ifDJIJt30kVjpjTeI1X/vuA3WLsGIMgIOcivqzX7sewiQYv6MMqVKa
         e0JeCbr46id9FiZQ3ObdNmjKanWtsdxsBsxo3a4QZoxuxVrNcP4UsdEUDxFVgbUqbP6s
         6nKawhXBCzby+QIN6OIUxo7LjR2akucYJBWt0Vf+j1g6Bxi9qSI49uR1XXkVjzJa54q+
         V1cQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrXUZQTsKsIlcs/dmEbNXwkX9IJEC/kwKWf1Hxf1ytcgHeGzvmOEifc3VWf5GdZSL3mbyTSwo=@vger.kernel.org
X-Gm-Message-State: AFuF++lS11Zzhdyvs32T9m1fFphNw48BDOJ+0kYU9x2dnIvz0XLhoyeQ
	AeKA9Y7XlrGrxDkm4q/bvfYNEKULNyf6xx07CUhkc1zzpqxC2cZ1x80=
X-Gm-Gg: AYBFou0G+i4KJCA93aa7JOlB8hd822n8uO2N8Cqiw5nLwBVZAKi/iaXAWxH0H8aPJ0c
	DMtJ0Vr+kj5BzsnX9JqucFHR2aSwmCoak4w06H3fh9hLFNNPXtRt2zpyVMBVdZPNoWDJGnH9NPl
	e2sPI4K0gBvF55HxXCM2Fxunof036DAlyUjkgzyErvQxzgGCBt5k4z4tivtyH8nRav/G/5LFv5t
	B1bPha7KGc94sBkP67VSDOQYEP6/M2gFex/CRKwFP72trE3+WT7dcvGAr6aZLGnKbwIjvJ9kdc0
	D5aWbATj7I1XUMTboVeWauC1j9Pj2xe/ZEGPxldgN44WK1RPyKRjoiz96SOLRyUs8S7heVEhLy1
	M5D1r5tKaXW9PaeTo5FJ9yQBV16oO2Ln0wLMQY4SR6K6yKI4JhfQAMdF0e2MMXsLXVOUjYcU+Qk
	4mtbxzZZZA4CqyR0FJUXc1t+UzJ2D56OmSfguVBI06yYNsXwuHWqnXwhsidxcIPAVShtJ6c97z6
	aLIV+oG6DsOEjwp9qOl5uuv8mY=
X-Received: by 2002:a17:90b:50cb:b0:398:baa7:4c2f with SMTP id 98e67ed59e1d1-39b13222d5dmr705565a91.5.1788402527851;
        Wed, 02 Sep 2026 19:28:47 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6496:3266:b22d:ab57:a1be:ef30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b0832c14fsm2152818a91.3.2026.09.02.19.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:28:47 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: dp83867: handle the active-high LED polarity mode
Date: Thu,  3 Sep 2026 11:28:38 +0900
Message-ID: <20260903022839.4006614-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
LEDs") added PHY_LED_ACTIVE_HIGH and made of_phy_led() set the matching
bit in the modes mask when a LED node carries the 'active-high'
property. dp83867 was not part of that series.

dp83867_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
so far and passes it on, and phy_probe() fails. A device tree marking a
DP83867 LED as 'active-high', which leds/common.yaml allows and
ethernet-phy.yaml references for led@N nodes, thus stops the PHY from
probing.

Active high is what the function programs when no polarity mode is
requested at all, so the initial value of polarity already satisfies the
request and only the case label is missing.

The same series updated mxl-gpy in commit eb89c79c1b8f ("net: phy:
mxl-gpy: correctly describe LED polarity") and aquantia in
commit 9d55e68b19f2 ("net: phy: aquantia: correctly describe LED
polarity override").

Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Compile tested only. I have no DP83867 hardware, so the failure path was
traced by inspection through of_phy_led(), of_phy_leds() and phy_probe().

The polarity bit sense assumed here matches the datasheet: LEDCR2 bits
2, 6, 10 and 14 are LED_x_POLARITY with 1 = active high, 0 = active low,
and they reset to 1 (SNLS484J, Table 8-24).

 drivers/net/phy/dp83867.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 88255e92b4cd..61a941aa02d9 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1150,6 +1150,9 @@ static int dp83867_led_polarity_set(struct phy_device *phydev, int index,
 		case PHY_LED_ACTIVE_LOW:
 			polarity = 0;
 			break;
+		case PHY_LED_ACTIVE_HIGH:
+			polarity = DP83867_LED_POLARITY(index);
+			break;
 		default:
 			return -EINVAL;
 		}

base-commit: 5a3f7a683aee56e1f15c9d53041f3236767eaae7
-- 
2.53.0

