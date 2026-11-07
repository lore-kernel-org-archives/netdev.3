Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053834;
	b=KjTwXF3CuS8Pv+649EfatTzjCUf3YHQL/KFqPNMZKzcAuWR4ASMXZPOWB3CVTqzb+2w1
	 vMiAl6DqCtS5XGsufBPpKyCJlPjMs3HcVL75GNIvvzkBbUHtFCfbtK/+00I2mfi4YnkHv
	 ECZjyUQzYlZtCVwIvDKKpTytX9ExLYRHuS7skw+XBX+C9f4EAA0YvCoefrywdECOmH4Do
	 aBXvnTiXT32w5b+UegFRDU6xSc4ZAck0ndqzJP5ZFaFdJXgOcY6T+kMmaptBZDNf6XwJM
	 bTvRNLFUGnag3jmr6R5/SEBTn6tWy37aaNRyBvSa+uUS9dK4VwxGwHvJe4sVydSriHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KIQZbQKy130fuucWbkcIp9PHo39UBfLSN5H+7TgfSpg=;
	b=WLxHO/pXDd++6gtnum5MBs/riAbLlqAxTmTHESSEA1YkHO4Koz69f04Wl4gl4tpnMxxU
	 iBX+JDHb0a1Lln459vVGt02FqO8qtkcJKgbdNpakM3x/W3ZKl4L74XDrkdnutGO7pMdnO
	 h8mHAoEk4Ozww4xp5xyHKLIziXxbli21ElFwk31jY+dbDEqH2SAuN/RUIDztKXVHWzxnw
	 9k6Vik7KEk6O0I0JpD8O+aIJBsn0ofx6xEFAS1EfUhZWUpWzQDmoLA49XC72miqOlet58
	 e3NE83lfpHC8jfBH0MqBdtLMsPr+8l/nFHCHi2n4vx8JPRXgGOpW6G/R6xh6KagaGiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w0x6F2Te;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD462606A32E
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD462606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w0x6F2Te
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ed2b4348fcso5692465ad.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053833; x=1794658633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIQZbQKy130fuucWbkcIp9PHo39UBfLSN5H+7TgfSpg=;
        b=w0x6F2TeTmZK7yOvvONdVplgR2zaniUGKs45YabILlP9H9SW+aATY5mQd2usRzJ8iR
         iCYhqLAi3j9eQ/TpyC9vu/Ta4x92UBeJLvU6mJNXbi7v8IHEuICAg9MMbl6vaaQ74LJk
         Gqa5hMAHerGLipr9gs4U3OlaOqpbTljsUkL4tHU+AMlzkT1+yUXFeJ1mw5ydsN20KMyg
         yvZ4yuEvoxcDIKg1d+TvmUsblLVF79yG7B1lPmT1vfJQssjD3YMMIcHfAekkvgFd9dlH
         UZ99apgm6z3L3Kgrfg47Thhds9kgogWllCjZo50Gg1VRZIL73sQdICrh7rC02OZAkbUE
         dDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053833; x=1794658633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIQZbQKy130fuucWbkcIp9PHo39UBfLSN5H+7TgfSpg=;
        b=aRj4Z5PfDrExsFXeiTMef9Hm5FmbM/zwu4DlbxfEzAI/Ph0rH3ftOjNOLIc5/cK8OP
         17Gz1SemwQFmbzE0qp4Om2NRZwNJeyQSrnAPni6clzzy0NthHxyFU2dr3gz+ERcuBbQu
         uWswMVmz09awa/MtQhGvEWWzvSbp14EUD/LziaqS/xcbFsSGqtYU9nlUYgfg+ot2FRWA
         KYSGUDOpEj6IzT+UIU+oquieVHE/ZAv3BlgaUnUAza/QvHEbfMoVIB1u1XNJcyNYHJzI
         UYZ1iQYj3XZxllbJP3T2k8J+CfNY0FGgJ9LrGfb0En18Jxn2Vdwfcns+qYbopcMI9yE1
         bzHA==
X-Gm-Message-State: APuU4Z9XmWGvjX6ZJNWfb3tMt7N3IHKlLQSZ9BC4jALiHTFOQggU0ii7
	kfgzDZqNHis+LfB1yy8trOdxsjmy4fQjS9n7zxN17V+F3DnqJF8uOhkmxeZO3C/TUw0=
X-Gm-Gg: AYBFou1MEf4n2K+BYky9Soon40qeP0W7zuKZCsTxsvhfYIQQWYu8GNn0y6XYXIXPgJy
	bd+4XcDEeFXgPWG3qh35QKHCBgFLnYGrsiLfoywOauEzsNM/gqwAuS7gGXqRIrm1rg6ZsXh+jBP
	wvpKkTFokCObCEiaxj++dVzhYnGluTiS2IcQDiXwH1hCSu5CuHD30nLZawkBNmIDkjzjNr6AdZf
	NdCS/E85NcyCU7xbr/QfA139G3YBwCFsKWuHSczrfqv7yZp73IX/anEJeru/P+xfWQyuCIzAbvX
	yw2WCI9Odi/3sEUsFfnU4iaS60g4tUOFiG12bq9FYtVtUSOvIovMVYEf2f94Ricgj3Sgq6CuPSo
	aNnkUb9D3F0sRIZ3sJOZWKptzD0HXZ6GGRSLLF7LTX/7DqKOsbQ3NayGdnsxZwTbYbN3RWfA4gD
	Jq9sMN9feNWSVdI1Ll4m++UMquIEmqVD3hC+BHUVR2Ipn0Ex3DO/x43MOxmPH6DBAJMgrZpf1bA
	ZOi8ErHHTqoQU9LoqRUAEYjR7ZWhfRSpi1/vH7AQaO0ljj2Fd+GOsW4s9BcS/izBjvlBHSCc/OQ
	Uapezlos+aNmrL4F+zjJvxxo/+Bsz0xYtByQlQLUE1J5h08kCnc/UA==
X-Received: by 2002:a17:903:1b08:b0:2ed:18cc:d3a4 with SMTP id d9443c01a7336-2ed40ded9bamr65229485ad.46.1794053832990;
        Sat, 07 Nov 2026 04:17:12 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f35asm12773555ad.49.2026.11.07.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:17:12 -0800 (PST)
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
Subject: [PATCH net-next v4 1/8] net: dsa: motorcomm: Fix VLAN SVL and learn limit definitions
Date: Sat,  7 Nov 2026 20:16:22 +0800
Message-ID: <20261107121631.1040612-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107121631.1040612-1-mmyangfl@gmail.com>
References: <20261107121631.1040612-1-mmyangfl@gmail.com>
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

Bit 3 of the VLAN table control enables shared VLAN learning (IVL/SVL),
it has nothing to do with S-VLAN tagging, so name it SVL_EN rather than
SVLAN_EN.

Widen PORT_LEARN_LIMIT_M to the 13 bits up to LEARN_DROP_ON_EXCEEDED at
bit 2. Nothing uses it, so this is a no-op.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 4 +---
 drivers/net/dsa/motorcomm/chip.h | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..693564aeaec1 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -922,9 +922,7 @@ yt921x_vlan_aware_set(struct yt921x_priv *priv, int port, bool vlan_aware)
 {
 	u32 ctrl;
 
-	/* Abuse SVLAN for PCP parsing without polluting the FDB - it just works
-	 * despite YT921X_VLAN_CTRL_SVLAN_EN never being set
-	 */
+	/* Abuse SVLAN for PCP parsing without polluting the FDB */
 	if (!vlan_aware)
 		ctrl = YT921X_PORT_IGR_TPIDn_STAG(0);
 	else
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index fc315f1d8f87..d9425afc7bce 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -240,7 +240,7 @@ enum yt921x_app_selector {
 #define  YT921X_PORT_LEARN_SUSPEND_DROP_EN	BIT(18)
 #define  YT921X_PORT_LEARN_DIS			BIT(17)
 #define  YT921X_PORT_LEARN_LIMIT_EN		BIT(16)
-#define  YT921X_PORT_LEARN_LIMIT_M		GENMASK(15, 8)
+#define  YT921X_PORT_LEARN_LIMIT_M		GENMASK(15, 3)
 #define   YT921X_PORT_LEARN_LIMIT(x)			FIELD_PREP(YT921X_PORT_LEARN_LIMIT_M, (x))
 #define  YT921X_PORT_LEARN_DROP_ON_EXCEEDED	BIT(2)
 #define  YT921X_PORT_LEARN_MODE_M		GENMASK(1, 0)
@@ -357,7 +357,7 @@ enum yt921x_app_selector {
 #define  YT921X_VLAN_CTRLb_UNTAG_PORTn(port)	BIT((port) + 8)
 #define  YT921X_VLAN_CTRLb_STP_ID_M		GENMASK(7, 4)
 #define   YT921X_VLAN_CTRLb_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRLb_STP_ID_M, (x))
-#define  YT921X_VLAN_CTRLb_SVLAN_EN		BIT(3)
+#define  YT921X_VLAN_CTRLb_SVL_EN		BIT(3)
 #define  YT921X_VLAN_CTRLab_FID_M		GENMASK_ULL(34, 23)
 #define   YT921X_VLAN_CTRLab_FID(x)			FIELD_PREP(YT921X_VLAN_CTRLab_FID_M, (x))
 #define  YT921X_VLAN_CTRLa_LEARN_DIS		BIT(22)
-- 
2.53.0

