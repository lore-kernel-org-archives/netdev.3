Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174312;
	b=aXmPvs3p4AGyD1zvtzLkn4kjSfUSV49gbKu8ABL3lealDEEprQ3CoZsOcVohqN8dd62Z
	 ER4qcuxAIqcW6Ov+1sPj5dXGmAls3DHhsR94gRV6CO5n9/odRw2Nvomi+RB0uhzwzV1mP
	 5uIE6neYD3Vwf9hr1zSWIi9okxan0fkrVwpq3HObjP6+Bj6feuoAymVCzZdGgg6PEMnqK
	 xmHgkhI6U0hAGXyEx7CoJyRKWteCKwywHTFaYJWM8frAr7gOUfZt5t96YqdnCZWbXGS1p
	 8Y/jd2OerOIOcJGXmutw2+OXJVN8PKWLj2baVJMZNNa32aU0qX3/fMoGwKTX3LazaTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KIQZbQKy130fuucWbkcIp9PHo39UBfLSN5H+7TgfSpg=;
	b=oh09QjPCe7v8ZIxu7bugQLWDWqAL/tNYLgpIcJZ8Z+3WIvTMQOhedhWsGrDAQf0lNrmm
	 uI7WLted7n1IGT8kfS2KTJKlSbgqFMjrTPe7FxxfdjAVaHprjUbJzOKuh7xuAURr9FQM4
	 iQN/EL1o/9QPOEQYETRHka2uG1CAO7xqR1dyxv++uEQsAewMehELUpQdPHDNr57vyB7lt
	 Tp749RHRMAjZFdWBEiAhEfmbOjbGMTMBKcAGACUUoz+lsrXbdji5jnRL18U2M1iwxngxZ
	 lVo/nMEaoFbLfPhkwXdxGVCXMnlxPspOpIRCzSv2AhshN2lFfwu4sLuM7stbDaDnDoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FjE0158q;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09489606A32A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09489606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FjE0158q
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso119863a12.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174311; x=1794779111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIQZbQKy130fuucWbkcIp9PHo39UBfLSN5H+7TgfSpg=;
        b=FjE0158qwAenQ7Dbefzf7Ht3gJ7yYSw0c1CN7yh1wXZkrjRhoTxVbV0HnPkOOsS2ui
         K865EkqlpMYVc1arxn86vwDSry29GRkrGZd3HnZ+ZFJLpDYVG+q9swlQKEq9brcVVa4/
         vdXOf9jCWfORm8/kOuizjGYW2O1Sa+tnQtPKZoFxQIJOXBcSLwkCxbiXyxNjFASIAmQq
         IO9teBO0dKt5DrIdhljDxYwrLJOF5Y3p6akXfyi0L/nIyiLVKgIm4b9X89sxvd8ulApr
         57gEryyTc5HBC/dk5vdbFxg4mcEQ9rGMC+M1tNarGfF6jFqZ7y0j9Hnqo+207/Je92iV
         dmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174311; x=1794779111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIQZbQKy130fuucWbkcIp9PHo39UBfLSN5H+7TgfSpg=;
        b=ptsAkFF+SRas6TRTkw5vm0R5UsXuTtOoe5exbiWPuTYgBDghxAMJYT8P7aIsqCMguu
         6qXv4CjQqd3fQZBfCS6dIoAHNs3tSlmLH3FA+xu35GYCXh0U7I/BM9Q2K81uVIdavXly
         XsgB2HIikNUV61toCNGhxonVG+bshU6snuR/bSXOQviWUMIYmrZMiXPtaQ1lPpQqXUQN
         0daIHbL7+qYnpc4wWPM20TAbNeU+hON+jC+aMXXVIxbtmeZ1pKL8XcLKWBdMp/BJojou
         GAhwJmooAGS2Tx6aarw78LLeMaexWdBf/+2RJxlSDv+cvYhuFVPk1NNG2nsBLyWdjrbw
         l6rg==
X-Gm-Message-State: APuU4Z9H39lSpra56hXBIVm70nWsoXoI8TrduupNHkYK4c9pkv/2J2ia
	JmutDXqvOH7P15A7boJttJHwuwC3RXngJtc2Pkg+ZcQq2Zz7cGe3SgTBErwKVA==
X-Gm-Gg: AYBFou0WKroRhagRsjSjpHxUcuzJN+SP2N7TwSt1xNkv+2buAlc8ejLV0JllKlGMA1V
	G72AN55Ltc2SDSdLc1CdyhWB1kr1GOJSqF4jqcNWzv4dnp1fC5+3WLrJETekhB+asV7LQRcgIFY
	gxOZorl/JLPrk1tKDhFZ1BF5xo3FK2mZBfDoUB3aAflQTeQou/e3jQOu8ndVGkO01vZH8+te//v
	HCd0DbZchZY18WDXUc46lVYgApjS2HeYW+BfVK1r6ExbJhLHMB9vRG1InJqeA8E1KTwaUEwhT91
	K4mppC/HzEeJ5pY4yH4wdqOCqDWMIhPDqt2rmefblfKqmA6CvnHr+7KGPXMB/MosYyZK3SqhRnH
	kegjLzn3K2IEgjR4syUHzthyS6ex1d7/SFJPvFlQ/SLgqdprj/T4Cx/QmW6yCtBaLl2RoowZNQa
	ssqcprE8V6W/6Z1KRULPt4od5z5fbrCi329CDtRkQuxdJ506lO4WHX+JHE7tCIbxsE4RrgXHPxg
	ZT+qF6mJybUJZ4/7V3tWvPQ4qc/cT5AexfAiJvHBjHQDIEHKdr+kqSlDPi5cSGnhXEAkCZEQHj2
	yuJL7Z+VU3oHI0Na4haHGCa7ZEe8/CFYigXeqgGTbROP+UkM3KzksQ==
X-Received: by 2002:a17:90b:3a10:b0:3ab:b39f:41b9 with SMTP id 98e67ed59e1d1-3b12d502ed6mr2080177a91.61.1794174311287;
        Sun, 08 Nov 2026 13:45:11 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm4619463a91.4.2026.11.08.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:45:10 -0800 (PST)
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
Subject: [PATCH net-next v5 1/7] net: dsa: motorcomm: Fix VLAN SVL and learn limit definitions
Date: Mon,  9 Nov 2026 05:44:41 +0800
Message-ID: <20261108214450.1662362-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108214450.1662362-1-mmyangfl@gmail.com>
References: <20261108214450.1662362-1-mmyangfl@gmail.com>
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

