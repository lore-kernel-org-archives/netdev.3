Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024674BB5D8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446297; cv=none; b=Fx++N+FJSGc3gjupYSNxv9ljWVn0iCEYxQk2HvWDUFJbgXF1jLZNA2srpfRNakIrq1R9lGH0Zzew6CSzP/GhxuycK21ihJ4uBA9OxTpoQMy9oFrq5qyhGxKzbTfMmkbjqBqaIF/MnkTmfn0cO1tjr3ylWbq3LV+/yh+HNJ6lZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446297; c=relaxed/simple;
	bh=kOvpmlyWClc2Bza3wXQ2lfrkpZSO8egW7JGEuQb3cdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYLNiigZxHxjAHP4+4o/vVpg6j8cAD0NwQLEPyX4V0w9W+R4auWMPjQQgAVg4BoVS+pHlmj3A6Zbgpxsy/1e7kI++2F9NzZNMdNJlqBLPjVcnrF88P35N84S0sapx9mH5o8B/8zcFN1+DErHw7LqKa7I0HdyPAOzBmwnR2YpqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4So+RlD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4So+RlD"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398a5aad413so2236626a91.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446290; x=1789051090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8LSRJMb0iTwvInt2ft5DxEiXftUD8BefOLSSFLLUPsU=;
        b=O4So+RlDeumNarLmsJX8ereOSCVe/Sjj0z8olD003jpsRXBO23vPiGMux/CbeDcfV1
         7s+cw1OKHOwYBwt6l5f93r9wqeG1YK3Q95UhFHGXRf5XjmK965OkqdRPjVNbo9gLgbps
         83tUtq7mcP4buBxH38w1rT4T022iep5aOhIp2jWRfasxfPomR6s7x9uRMyJIPGVyRkc9
         Yfi9dpoQCyZQJwudaExvsNvFjL50sXe022gaWGF7FBMkRn94M+CnCiLYzFlDuodfTXyQ
         s9lUoCJeCk5ZD7+Jtwz8SQGLXrNDnVka+EaQGvfV5Nt3PgWQlwlXGD6l3VyzjrhrpgHM
         mi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446290; x=1789051090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8LSRJMb0iTwvInt2ft5DxEiXftUD8BefOLSSFLLUPsU=;
        b=PzYLh2HHY7ocGCjgr2+6iJWjLmAOPwcw464h052BAosav2Fb3hml8PghtnU5ka4isO
         Ijonhsi0TZHi+go92Oji33Z//KUV4aS26vLdZp/WOYtOUfvWr7VBq/irM09xLPCHBawK
         DILt46Fuf04efl2tSEivhuh5veVFbML07lO2UL4v3iJyShzpNaJUO2NVoC0Jh0zJMDex
         72jVoPxvAEGEqGSt/0hK+EAz/qVVNKtjol73iJAau3EVp9hSO6EVJUmWOp9ZwBAEWzHL
         r2kcavY8EtvQ2ITnQ1hv4Gcxv/wjt9FTXpW4Vwu6hyv3JZw8DClNDF4sV2VAKHjHqGg8
         BOJg==
X-Gm-Message-State: AFuF++k5CojllR2/qex+QplMhuQk5OGlks4pXK9ZzPgGhFSXAbi893+t
	IkRxZlpZGwXE5dBAdAYDj2kNjq6eD+z8IVlpHnlg6XE/EaoTevgrpusgkFn/nA==
X-Gm-Gg: AYBFou2Uuq3MMJ47EeuSay8ckIilh2+7r44Ki5BB1U2Q1x4ODfvmNDgMt9hvACLjfgh
	XmgaJkooD3H7KQu6r3ZnttHWUBsT429/ZIX7WDF1yAgCQTt2pRFIZUz7pMTlKomOe+UEQR/Inf/
	3+OVAvwNKo1A6CTGGryuPkoz2j6VVrsy2Yi2Pk0SZe7pp3AyG34jz82EVTXaFqHT5KsVIzmPbiV
	SkM4UcHzE/y7JS4kMMuFKCI8iM8haCgBIhanrjXAun/o2G9BAXOsvrnmaHyA4Q2DUlbb0cXxIFT
	7uurP+mCm0Cs9YeSjv/u3h4uj0Jj/O5DV2Oc3qwg9XmmCYW/CnK8wMstyrQRB9Ydo2ruG1uQuVA
	n9InnBYPTtE2YMNHtTZqQZTI0ik9ekf6ouw0FPhugIQ4mAQ5LS8FnoKcnqI+F8potghyc5f6CUP
	NZEATll9kt1LAzZ/y7k0mqjD9vuS0veLrVKg7eFNeZMsgv5CZX1vLhYsXV1Kwawv0pRoO82rscL
	eTEc7NRgTff4x0=
X-Received: by 2002:a17:90b:4e8f:b0:395:f0e8:9e13 with SMTP id 98e67ed59e1d1-39b22cb977emr258795a91.7.1788446290301;
        Thu, 03 Sep 2026 07:38:10 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3050::4d0:16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae9087d3dsm2741889a91.3.2026.09.03.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:38:09 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: dsa: motorcomm: Use safe 64-bit counter reader
Date: Thu,  3 Sep 2026 22:35:09 +0800
Message-ID: <20260903143514.532023-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903143514.532023-1-mmyangfl@gmail.com>
References: <20260903143514.532023-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

64-bit counter registers are read as two separate 32-bit transactions.
If the low word wraps from about 0xffffffff to a small value while the
high word increments between the two transactions, the recombined value
becomes ((new_high << 32) | old_low), producing a spurious ~4 GiB jump.

Use a safe counter reader for this.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 21 +++++++++------------
 drivers/net/dsa/motorcomm/smi.c | 30 ++++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h |  2 ++
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 73b2a9f52996..30478ce71c10 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -101,29 +101,26 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u32 val0;
-		u64 val;
-
-		res = yt921x_reg_read(priv, reg, &val0);
-		if (res)
-			break;
 
 		if (desc->size <= 1) {
 			u64 old_val = buf[i];
+			u32 val0;
+			u64 val;
+
+			res = yt921x_reg_read(priv, reg, &val0);
+			if (res)
+				break;
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
 				val += 1ull << 32;
-		} else {
-			u32 val1;
 
-			res = yt921x_reg_read(priv, reg + 4, &val1);
+			buf[i] = val;
+		} else {
+			res = yt921x_counter_read(priv, reg, &buf[i]);
 			if (res)
 				break;
-			val = ((u64)val1 << 32) | val0;
 		}
-
-		buf[i] = val;
 	}
 
 	u64_stats_update_begin(&pm->syncp);
diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
index bf3adfd64165..27086602997b 100644
--- a/drivers/net/dsa/motorcomm/smi.c
+++ b/drivers/net/dsa/motorcomm/smi.c
@@ -63,6 +63,36 @@ int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
 	return yt921x_reg_write(priv, reg, u);
 }
 
+/* Reliably read a 64bit counter */
+int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
+{
+	u32 old_lo;
+	int res;
+	u32 hi;
+	u32 lo;
+
+	res = yt921x_reg_read(priv, reg, &old_lo);
+	if (res)
+		return res;
+
+	for (int i = 0; i < 16; i++) {
+		res = yt921x_reg_read(priv, reg + 4, &hi);
+		if (res)
+			return res;
+		res = yt921x_reg_read(priv, reg, &lo);
+		if (res)
+			return res;
+
+		if (lo >= old_lo) {
+			*valp = ((u64)hi << 32) | lo;
+			return 0;
+		}
+		old_lo = lo;
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int
 yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
 		 unsigned int num_regs)
diff --git a/drivers/net/dsa/motorcomm/smi.h b/drivers/net/dsa/motorcomm/smi.h
index 212e20f71d80..d34240548af7 100644
--- a/drivers/net/dsa/motorcomm/smi.h
+++ b/drivers/net/dsa/motorcomm/smi.h
@@ -35,6 +35,8 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
 	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
 }
 
+int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp);
+
 /* Some multi-word registers, like VLANn_CTRL, should be treated as a single
  * long register. More specifically, writes to parts of its words won't become
  * visible, until the last word is written.
-- 
2.53.0

