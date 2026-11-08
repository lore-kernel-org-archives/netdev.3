Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162735;
	b=R9nA5Oti8pJVnBpZgn/oHiV3QrPBA7v/nhBFcqZXXTXBhtwYNeQumNVsrahX+sNJa9V9
	 /nnwdV63RUHY3bTNNeG9/EkKJhIIYNRXpcM3xc5YlvG7uaYiWRxlnpeDa9t3EZxrivJJz
	 25JFfnl6cK9AZbPdJdVqieiNSoDlgdzQTTvDGbrh1NhfRRgxm75UTYImQ3EkaxYYrbhj5
	 lu7iv16J6kwIC0VB+t9iln9VkdXWtCgey535xsUA4sxsKhccYnMM7nuTkfhqXSYM7mB68
	 D7uZqz/1r0CmyciyxrYqVjj+2xZnplHQXofEqpnqTpPIaIhPOt1DHdrarCh+6w40atg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gph2Kwbd7Nl/6/v3WX6HzhU8XiforJFJRj38g/7wFBc=;
	b=4AJ5yb4biV0jPyyD4p9adDwfiYuPAq9Cu0+lwqsNhDD9VrrSrFCjCdhXXAXZLBRc5nQt
	 zjr/KqFFaH1RQDdgDscFuZN9keuF1C6nSu4Lyms3LPVRbGAjDe1o3Ub1Ic1f4bE5YCGkK
	 R0qiON7leQ+PoDdv7SDYqr3xQTPpLZALY0T/8uOXRF/c5Lj7T8fnSBgEI9C3ROVE0DtWU
	 rEHT2hpZaziArSxlWBKJ20TTyuog5Tyg3hB3eK9nKKUgXyT8R4jVGBaQJtmUU3lzHP5Hq
	 I4Atgmj/JsvXVj1c4HbbMQwuF79uavv3AtdFz1IWZkzYRfadC4i77rGkEreyuAGDzCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqrvHFbE;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EA606A338
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4EA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqrvHFbE
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso128494a91.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794162734; x=1794767534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gph2Kwbd7Nl/6/v3WX6HzhU8XiforJFJRj38g/7wFBc=;
        b=sqrvHFbEAtaxln7fcaNMYPt2/WXu4kpYJRogIO6ORTx3S/c7Jpgv18mvA+KIEjOrPQ
         OkY92IECPUc2luV/Zdp3cGFYeBPwHcbnhBFDWk0P4gni2Ia+jeHfxG9dwzzaJtgAwZj9
         2Zhlb0KbigOc2YsWz6KGNW8uRXdDTYIRxVLUdfOdNirBwKt4bJMz6BSh3LAK4BxiRMis
         tdznulRhPkN2WN708urzkyyuSCIEe2z5aSwLvq5lTFNEUpSJbdfT9umgz6086yc7fzHU
         5bmSTMLvkzufDPcLsTdHftXAQFYzAATdo2g81aK31dUwhyLl5NgfhKee2hxhiA/GiA23
         ee2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794162734; x=1794767534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gph2Kwbd7Nl/6/v3WX6HzhU8XiforJFJRj38g/7wFBc=;
        b=pafPW9954mTrR8rfDMHFLe1YVCW6T12423lspVO1Nn7uiT2qnCHOXVb2Fdfm7XXOlH
         0yy1yvtQA6Lnv3GWOoZMNYKu4LnIZmQYIviDm0JuEVmd2ZnAaPw4ibX4UjpUzs0t71oN
         fkI1Sle09AarIsUh85QWafXwVHBhPBA1CXaf9Jg1O/8M2Tcz5+T0wn4ooY3HjOdK0o2Z
         Pzw0xrSfdO46Ih+uFEuL2isGiKqJEYYW+/FfCp5SZA6K2H525xX72cWeLD/jGxJ6bS+9
         /2Mr97ozBB2m1W4kq6Yz6X/LfW4+oMmPYezpjTVhTAS5NoJUHntP9TkkN3gp3AuqVvkZ
         7H1w==
X-Gm-Message-State: APuU4Z/BFvFsMHz1keax5gjMsMJvnBvqyiEl6FFmBFC9BJHVineartPo
	3KyqA/KECRZHXGhmQ1Zjd5SBi5ysfV0oM5soya1KY2VuGr6XjRfiyDneV3wkJg==
X-Gm-Gg: AYBFou38uSxwRINiV3KJR+WYUD6n7y7Z3nAKg3jt+o9ydnC0sf43fbWCb/JJ5C5F1Wr
	jTr9cEhiofdT6saogHu5J0uqqcRzwHL8mmaSH/5VkcR12nIHH7xgwvEu59ObJPHo2oj0ORzagW1
	c3m6fPe8k9uCa6EByQXnUVgO6T8/buk4DZX/rTS1l9f8LGdcAGQjwNXnXd4umZU8qzwsP0Zl0ag
	hwTb5shnkB6a/y3p1lphCrlK1H5vDKxYSK8QPVlAidcNEwuzN3ds8LLuzz1Yf4a8TrD6h3Kx0qU
	GNA5mjifg+3r0dzS6Nz/nOw6QLJFDedVuEAbvLB1Xi2c6OiyEW9vOKv9bW5Xz8Svl+o6uVundvB
	Go74PKkalgkCUTELl+0d0Gm9toruX9q+27VHHFfydcvEmUv0AECpRn/VMvGuXSDNqw4vuSqjXxC
	qEbeeUtH6+LJ3zKG6qZb79kGjEUq2dJQDCnPcvnXOwOVF61LBQvLdNTe9cq9bfQX7QtK7iOC0ER
	wASGy3uUzqH1nbX1HMz0CkxJFQbxCSd+2yoY2m6bv7yjc089/GnuUqTlLhQj+VHx91YTgAgU+7c
	DyoaGQZ5IeXLOOfeBPsaiq3QcGbNxWO7QKqiNfaAy8pbYJ6tzBjodPY=
X-Received: by 2002:a17:90a:d007:b0:3b0:9b3c:4434 with SMTP id 98e67ed59e1d1-3b12d4ae6e8mr1796524a91.36.1794162734091;
        Sun, 08 Nov 2026 10:32:14 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm7600534a91.0.2026.11.08.10.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:32:13 -0800 (PST)
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
Subject: [PATCH net-next v2 3/3] net: dsa: motorcomm: Use safe 64-bit counter reader
Date: Mon,  9 Nov 2026 02:29:28 +0800
Message-ID: <20261108182931.1542638-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108182931.1542638-1-mmyangfl@gmail.com>
References: <20261108182931.1542638-1-mmyangfl@gmail.com>
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

64-bit counter registers are read as two separate 32-bit transactions.
If the low word wraps from about 0xffffffff to a small value while the
high word increments between the two transactions, the recombined value
becomes ((new_high << 32) | old_low), producing a spurious ~4 GiB jump.

Use a safe counter reader for this.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/mib.c | 21 +++++++++-----------
 drivers/net/dsa/motorcomm/smi.c | 35 +++++++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h |  2 ++
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index e9f28d446251..6df31753cbbc 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -102,29 +102,26 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
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
 
 	flags = u64_stats_update_begin_irqsave(&pm->syncp);
diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
index bf3adfd64165..dff576271446 100644
--- a/drivers/net/dsa/motorcomm/smi.c
+++ b/drivers/net/dsa/motorcomm/smi.c
@@ -63,6 +63,41 @@ int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
 	return yt921x_reg_write(priv, reg, u);
 }
 
+/* Reliably read a 64-bit counter, assuming the counter isn't that "fast" */
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
+	res = yt921x_reg_read(priv, reg + 4, &hi);
+	if (res)
+		return res;
+
+	res = yt921x_reg_read(priv, reg, &lo);
+	if (res)
+		return res;
+
+	if (lo < old_lo) {
+		u32 new_hi;
+
+		res = yt921x_reg_read(priv, reg + 4, &new_hi);
+		if (res)
+			return res;
+		if (new_hi != hi && new_hi != hi + 1)
+			return -EIO;
+		hi = new_hi;
+	}
+
+	*valp = ((u64)hi << 32) | lo;
+	return 0;
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

