Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9E501F47
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539489; cv=none; b=QcMsxPsjpknqdv6Ivna4D6Xcd2EqAv9EyhKSNKqJmFzzTx9F02T0pR4ZSATnKGqJMe7gsp8wHd+myROkUuLkcR6DCqYncgG0fMiHCRu/HHH2pneFksOhUNG+3EJAgqzoauJ6rgq1FKds9fEJv6r32dzduEn9L9JIm4zNDp7UiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539489; c=relaxed/simple;
	bh=v6BGTskfyYdAzw7ivySRKD5EqTbHTtrOxjyyM+NNpUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9EdMgXfjQa3AweUGvvSSYnOHi00Ra/+8AAn4IHynnbvr2z56MWh9kau6Q+DWlJlC1SIm6BvxbnKQvt4z3nxcYeSt4x8/3hP3Z31Wm8W88edxK/QqHo4DgYjz4jvUc7QvYTys2tN18/KQKbwRWQ2w55ASo+jydQyCJncZxFCKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUmJKJCz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUmJKJCz"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso968519a91.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788539487; x=1789144287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7u3jRd+MzxyndQi5AHaCjt2uZ5jt3CwjA+sg8R0AWQ=;
        b=KUmJKJCzX4xewi5L89+oxty9tFyODo751x6VKtNj2HUuMZ1CmQipIO6rrao+2f6va/
         WLE8Zh5bkX60JsmOBhTsxm8aduwMPTHUEkrBoOr3x/6i7TVMratzT3ElixBcVc83GPtS
         AX9V9u2RmEYHTd9gdoc/jComEqFm+0NnkgyumPTFOCBGC5G8WIvqcevZpUqi8/DBarTQ
         plJePtNiy6QLBZBnvFhl2tjMmO9BTZOT9l/LKglWHRcxYXv3donthtY6Y9NG+YTRP+q1
         6z7IcvslfLBA+TT3hfyzdHLqnT6/KEcyxd16kASS6/RkM7JxtyBEGjG5fT4prSxV82NW
         95DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539487; x=1789144287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7u3jRd+MzxyndQi5AHaCjt2uZ5jt3CwjA+sg8R0AWQ=;
        b=Eaed+bdurX9X2pAU6JdYf/CwWL4cNfSRd480oEDc/XXMhGiSMG0eKVwHvPOZYZx4oo
         wn6ah5tU1SUaLyL2LvMmmw/rNm+/8NgVeH5Nn5++e9csivojhhoIx4MB2J+rwZwSGKLv
         9zICvBQguMfqc7x/ISXle3OPicIDz0ljgfAxwiYc7Y28rybbFHVJeVYp4HZIb4nsplCr
         i7rDU6UKIPfV2AZ1PS6azcKscVyKjR7YDfSDAXzf/xWVoIYZLE6wSCQoaCpc1sl0sU4+
         LzWyIvh2DohOpG33vbLAO6FAeNSiLepPo2o6vgREdkq9WlMQwlNyO9o4lRUJiMxeaXIF
         F4fw==
X-Gm-Message-State: AFuF++l/Gk8FEFHYG1iUf08pvR09lqidiIEYwVh/uuRRhWxD7vJnjobl
	mVUfmpaqYEaCztEeUk9sxGtGppfhshNRQL2V4OyAPuvG4rADFyXe+AmcWhI2Xg==
X-Gm-Gg: AYBFou0b7NMcP5c687NFuQbIx/8ufP57Lt9KDl4xdGT8LJXYUCL/zKQlUisqlkbjnyl
	1wc0SkQPlpVKk+C8NipJwRRbsACEtYSF3dNpoLaRbIapJU5Poyhq8iLilVigFC3f6W3ZxUpRadf
	Yfop7fYGWBBIDdqZPSIWcs+1AqgOD50srC7TPFc4g7A8dQd60UCUd5kml6PXzWZOQgV0uBXG55+
	Qi/IFwxT0avW1XPCiI+jGEH8hdo+8gXhgeoL2wzXLTFyOuJKDynbW0Cf2pJoX1w4eRzxUwhaq4q
	u9KFGbU0tK9PX5EoBajCC5DC/vrr6b7YjsHi6guRYzLzjftsYzxJZ/Z+hfOeDknhMJzzeCSgVnI
	e1OMV8jbsOmrO8us13a+/YVF6hBq/i5hD3xkHvQm3xCQcZdHbOAPNhwrQEWSSWSrrAxP0b7JHZQ
	XT6CZQeGPtVDiqKv4ji9zO34/1ruLEqw2WLj9qtYsvJvRKnKXpWi3GXlXMCkslUUwc8b5Z8plnk
	bveJZSJO1iKkJ4=
X-Received: by 2002:a17:90b:2ccf:b0:398:a2a3:b631 with SMTP id 98e67ed59e1d1-39b262aaf3dmr11726379a91.19.1788539486428;
        Fri, 04 Sep 2026 09:31:26 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3050::4d0:46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25c974cfsm5383010a91.0.2026.09.04.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:31:26 -0700 (PDT)
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
Subject: [PATCH net-next v2 6/6] net: dsa: motorcomm: Use safe 64-bit counter reader
Date: Sat,  5 Sep 2026 00:29:48 +0800
Message-ID: <20260904162952.709368-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904162952.709368-1-mmyangfl@gmail.com>
References: <20260904162952.709368-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/motorcomm/mib.c | 19 +++++++++----------
 drivers/net/dsa/motorcomm/smi.c | 30 ++++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h |  2 ++
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 31d86c3122c7..8929476a976f 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -102,26 +102,25 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
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
 
 		buf[i] = val;
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

