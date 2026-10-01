Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B626531637
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869430; cv=none; b=m9VjNMGVqX7/DVmrEwIcwiGkaYqFX51UtvFf2hEBtIT/Njo9qlafjYcA5hhes9Tpw17yUnoQDZgUnL9h2Z6w0wR5H0O/fqseT8SxsPhfad8QSLYfTOsIuMXMVVBZfoSh9KzfAoJ1dmf/HfvikdwRybFgom+4CyJASbtVLLf3Nw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869430; c=relaxed/simple;
	bh=QFT1eDN4ZR7AODbKr+RvU+dFMFyGGoZXqjrrWzy/UX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA7eXnX+PT7Eo89CXs6KWGcA5epJGKF62gPluQxhhRCUkKZAR4CjfI77GY0z4BNneC/BPWApUYawDMXpOGL0idOGy5PWttVZzlsio2/nmMqHP9kHC7VIoISudSJTfaqcpri9CXAwoia9YPNnbZ2yb9TQbW1UY07bwmDhG2/xIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOITgrJa; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOITgrJa"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so36888035e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869423; x=1791474223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zn1IXa5RU+Z+WYKU4TKYYkLeGm077qo9pQpnAA7fCI=;
        b=iOITgrJaB8vVB4sK4I74v70kHddNUeSlfdqTiHgwe4yit2aj9ufmPcR0XmrJqfvlRk
         /vKM7SskWbbeg+0yPVEOh9moUQ6wPmAYmqQCQBy1zyG34C+ImZakhbyynWPsiPnfr0RE
         JuWa2MjO212SOwAXWmaaJIDi4YqscrucS+v+Lpmz0SJXJyM2jp7x2FGir/N/OeqxFWb3
         aGXaRMUKyS6xhGxACMDI5YHxx9uIGvNjUEZVPedweOY/OYKwLmZXTTEKUGqupiXqHMcv
         LdKl8U8d2OYF2KmeyAzj8kGLSZhEGKaEZDWrlJIRhB+664Kx/ZpEA2/Tu77HIVMIaz/B
         GHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869423; x=1791474223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zn1IXa5RU+Z+WYKU4TKYYkLeGm077qo9pQpnAA7fCI=;
        b=fkCCjmOvpFQu5bTYyN6YNFY8Mw5Pf3snczshzNO+ideKC6wx2nOqrmjXkfokM31OOT
         iFQ9iTsDxrKWXmqkw5nJDxzPbF2h3e7/OIWzZ92dweq9eb2NpT8Rfd7R24aSPMO15JqZ
         j3VknlzHJn+EFDKU7pK3uy/OWjNfn8gz1KGbP14BbEQLBPhNM55OVRzwpSFPZss34N5x
         3P4c4FZ8M+bqEm0qhPpdIfh9rIH8UYZCVjDvzJ9uOIoSyQ3LVyHok8UKzM8zOECq+Nx4
         k5kadl5YLBw4rBPmDtQ1YB9lzTUSCS8SfDbA3YPUAzdGBF6jymE6+UIFcz1zOENjyPLD
         E5yw==
X-Forwarded-Encrypted: i=1; AKwUvByNPvCnUu23mVpHANYhhn57fSWmTDXeuNwQEW+9njvKKcPZi73CG8AqaBZTLeD9/633LDplb/k=@vger.kernel.org
X-Gm-Message-State: AFuF++lfKVphiGY7Oc10dzAvbmlBEAgPMoyLYcU+NpmeybTOpsq/8H6K
	dc08mwdPcIjU3/u1/LGxluGGYSrbfD5xij6VXTEFWiVWXiNH12EpsyfP
X-Gm-Gg: AYBFou05H/5X0+O9YlIDQ9lhaX6KHCOOAGf3s8c6dZ9tsP5SSkIMDdxQlauKHa183sI
	kn/mEuYdDn4g6bDJB5Wk8nvpsPl5oNB6xZbxZS31pyq16bp8MxDJ3HW+A9VneJ4h0a5GLAWEpLr
	RsyYVFTahlrCwJTJTP30GZ+l4mB1kGty6kZPEN3uHrDSp2fHSeDWE6sAq2Ww/gQDtxIFtqay/bq
	8VNet9CGp6b5MvSxI2Yi1q84JXeu5LhZe4g812mw9esOIgngeFZSJIWSRIszyH77Ii+lsZFvrLE
	nUCco8FehPPKvX6q4WRT38KiWzoje+YcXRJxodbt85JbeGFVD1S9ox3YQFs5BksFfCkCMh7QY+2
	KNpXSNlPl5VgqyEqneVrdasDL5Z6PrRVTFsm2RfL6QzoF88hht0VKiKDDw7qKtbG7gDooLSjcdC
	Qiqk37ao908+0TIC/ptnlCJvCYWeo1Z/4+8TNsgBXCmEHA7ct4eK1jbBhxs/OTu3pARtmp4+H9Q
	98KEmt5mFsmUwRzZ7pjDq30reAjTMJXKxRtRyixv4Tx94mXumR8iG/a7ZDslUNodmKctObxZ5jz
	fxliM618
X-Received: by 2002:a05:600c:4e4e:b0:4a0:62d:4424 with SMTP id 5b1f17b1804b1-4a027566f93mr172025e9.8.1790869422965;
        Thu, 01 Oct 2026 08:43:42 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:42 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 09/12] net: dsa: rzn1-a5psw: Choose tagging protocol based on compatible string
Date: Thu,  1 Oct 2026 16:43:22 +0100
Message-ID: <20261001154326.754314-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Prepare the A5PSW driver for forthcoming RZ/T2H ETHSW support by making
the DSA tag protocol selectable through SoC match data. The RZ/N1 A5PSW
and RZ/T2H ETHSW share the same tagged frame layout, but interpret the
ControlData field differently, so the tag protocol cannot remain fixed.

The common tagged frame structure is:

  +----------------------+-------------------------------+
  | Field                | Size (octets)                 |
  +----------------------+-------------------------------+
  | Preamble             | 7                             |
  | SFD                  | 1                             |
  | Destination Address  | 6                             |
  | Source Address       | 6                             |
  | ControlTag (0xE001)  | 2                             |
  | ControlData          | 2                             |
  | ControlData2         | 4 (timestamp, portmask)       |
  | Type/Length          | 2                             |
  | Payload              | 0..1500 / 0..9000             |
  | Pad                  | 0..42                         |
  | FCS                  | 4                             |
  +----------------------+-------------------------------+

The ControlData semantics diverge between the two switch families:

  +---------+----------------------------------------------+
  | SoC     | ControlData bits                             |
  +---------+----------------------------------------------+
  | RZ/N1   | [0-3]: ingress port                          |
  |         | [4-15]: reserved                             |
  +---------+----------------------------------------------+
  | RZ/T2H  | [0-3]: ingress port                          |
  |         | [4]: timestamp timer select                  |
  |         | [5]: reserved                                |
  |         | [6]: RED period indicator                    |
  |         | [7-15]: reserved                             |
  +---------+----------------------------------------------+

Because these differences affect protocol semantics, select the tag
format through compatible specific data. This allows the driver to
choose the appropriate tagging protocol for each SoC while preserving
the existing RZ/N1 behaviour.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Updated commit message
---
 drivers/net/dsa/rzn1_a5psw.c | 5 ++++-
 drivers/net/dsa/rzn1_a5psw.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index c8197ef62fd2..0b0b4055e615 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -97,7 +97,9 @@ static enum dsa_tag_protocol a5psw_get_tag_protocol(struct dsa_switch *ds,
 						    int port,
 						    enum dsa_tag_protocol mp)
 {
-	return DSA_TAG_PROTO_RZN1_A5PSW;
+	struct a5psw *a5psw = ds->priv;
+
+	return a5psw->of_data->tag_proto;
 }
 
 static void a5psw_port_pattern_set(struct a5psw *a5psw, int port, int pattern,
@@ -1320,6 +1322,7 @@ static const struct a5psw_of_data rzn1_of_data = {
 	.nports = 5,
 	.npcs = 4,
 	.cpu_port = 4,
+	.tag_proto = DSA_TAG_PROTO_RZN1_A5PSW,
 };
 
 static const struct of_device_id a5psw_of_mtable[] = {
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index 197ff5916578..e952afd95dca 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -236,11 +236,13 @@ union lk_data {
  * @nports: Number of ports in the switch
  * @npcs: Number of PCS connected to the switch
  * @cpu_port: CPU port number
+ * @tag_proto: DSA tag protocol used by the switch
  */
 struct a5psw_of_data {
 	unsigned int nports;
 	unsigned int npcs;
 	unsigned int cpu_port;
+	enum dsa_tag_protocol tag_proto;
 };
 
 /**
-- 
2.55.0

