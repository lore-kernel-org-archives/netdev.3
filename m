Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057667;
	b=jrRfB5euK0F2Fc/TXYAfs9Tdh3gZUAgweSRIfzn6sh6gFcOgsF52JMRiaCs1ENO+bRgn
	 +EzUHkqFrcdlrxP1e0SudGPfMwtuKFHEHL1V8+M2baNa0xcVFW/Y+XSBpWuJaYkmax9vS
	 Xuduvtz2v8EpMpdPMi+Wic4LOWNUfcgQgK/AEe3RPjBd6K+PWWpDdcwF3H1iPumC/NK95
	 W5uuxV1oNIR5chsFPOlQ7jdvzUe/42VSuG5IxruRde0YEyjd7xjaYq95Ghla+SVLwtSiz
	 TCK/GIs9PDGzkbaOdissfW5JXJz9X5Wp0tROCMuDY6j98AxCQhTFt2/taCZccg7dBGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YdYDe5Tw+9XhasZ+ahvLRnigPCWeorVpo4kpPwQy+Qo=;
	b=SP2o5NJIVNyT+VQp+oE11cQrF01dcypMDLVPv3AKH4zP50VEcGJROU7FknwkN5/rpWD0
	 kTv3ZMmqmc3k2lu1F6IIFK0MnLMtp9sudZrc9uilg3ude6PSPRYF3X4eyyxXFWAQKUKxH
	 1W6N56g1v/sVvU9zv7XaHaXCHkSfnTjUqDXvR+pzltxDTaxZkoAGM0UsUrAIBnIIiTOq8
	 ZmJXlbBoP3mrP5HOjXuUXY7odryPDE26F7ICbbBLmcLmATBt9uLYByHG9j3AOy0SgF4dU
	 xdhPKZnd5T0J5gyrdvoGFttu/SXWECqjLn1WhP2BDDmjcyUCrJ/3j9ROGKxjDtK1Rgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LtTfOAcl;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C2606D802
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 13:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 460C2606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LtTfOAcl
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb684859cbso982085a12.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057667; x=1794662467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YdYDe5Tw+9XhasZ+ahvLRnigPCWeorVpo4kpPwQy+Qo=;
        b=LtTfOAcl6kg+iNbeMFdFtsPGnIG6nfbkgmbSrZVWR7b+CNRpFqsBXnBxrQC7zELuBg
         B04W2GfJYhWnz0RBQSGmZBI58JvUNyJPHoLIB3v/Hc3R/fBT/JPAVsL3XNAhUfFP1Sv9
         0V6EgNaBlKNgN85XJWZRfXmbIfD0SEwjkDhC2YKJk8RIQAB4drHGu5Y2YnATaEhnxbid
         bcpe6B6l5wgs8edoRRDNc0iXaLcCMIYvYnvDnk8e2ExOhN7/3XC8RJiFtr8HocCb8e5e
         v4LW59HYuQnFOlvXB4uL3G9qJzqvMPDPDy3XjhivSoA1n8isjT8DBTJk3kSMiDZCNq4t
         PJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057667; x=1794662467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YdYDe5Tw+9XhasZ+ahvLRnigPCWeorVpo4kpPwQy+Qo=;
        b=TBZnQQcmleYiz3EQ+Og3WjMYbbl8okLBFdx3uZ05KpWCaaqTmoMcoRZdNoWQkXHuJ6
         vcm1Liq1z+3AU2aqJRH5tw7kWkSF2WHh2IZpFGyF5etS+KFyeAscytwr2I90d/9VXtzv
         WeO00nH2LoxreHpAuZrjAy3/wkV5Ss4/8hRk6HuyAZfDLhn728VlTPLNsvk3yYWgotV3
         AigHRHBSUjVyj4w9QgY3NH2FGl4KuqSdfgJv+2UBjN6J21lMhAEEgcg8EuM9I4sPltfW
         ZsI5W/DgSZ4amf2+5yuEnjQ1Ai/bE5vy9Hd25Es9ySMtP444kE2kj82iwl159Stg+AcB
         IO8w==
X-Gm-Message-State: APuU4Z+hedRwv7XCmQ+GLDrQX2QYTKP+xC7O83pec1jCJ6wc1V02iSR0
	wlnCCIVuaMo7gF7TTKeOch/iymVGTfDRBeZjzXLQ+9PZ79UanhNSZ1OvekZX6zUa
X-Gm-Gg: AYBFou2h2QUaM/NBZs6fYaDqg+Xi8+18hEaU1K5C7pyoc/coqda/CRS+TrZ2m7n+e41
	xq7v9PEpKc6yo+Zq0i3SPTXwVYve6xL8ka3YMo9gf/ca44Gng4tI8sQSQVIMAWWLq9myI5TlIe3
	Zd+Izx22gJht1rATj/8ISnFzxV746IDzPzf/GOlT5ThD1UqtEvR5uCSM/MKbiEgKzlbGH6g23W/
	mKKnZnPGfjxVwm/upVcTfDvpAjYD2ccmtjrahXv/poOHlNmWER2RuekYl/n5ZpHddln2ijB/gNI
	mapk08K88rh1UFNlipZQffDnbG391S8kIZbKsYVT35MLJSry0UJXNcEUg5NHgp6Hk2u5/yK+f3G
	8cD+qT7R0pk6+aS+s5Sjf9VqX/BFY5nW0aeGerR2vaV8MbMV0dFlUj/DdA3CtujftGEyvwH5NjS
	D8zlbxr9tA25UwKPoRqn0PToIzzWq0xSXniI1twVOZtnquALla9a8qChI8KjVKaynBhEWn48Zf5
	ZB52zkDd9A9IQ+Yup04vjpgqnhXpwME7wc5p1TQSiJlL4orzSBFi8Gp98I4cKDGNHnqmDZA7zri
	CCCFsFwVlFmHIXdw5uhTiBHJm7LCdXDMdAOdOnsVIrh4LLOqRWgTGw==
X-Received: by 2002:a17:90a:c2c7:b0:3ad:13fe:41ba with SMTP id 98e67ed59e1d1-3b0db6f8012mr5252212a91.52.1794057666450;
        Sat, 07 Nov 2026 05:21:06 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101d3d0e8sm1626521a91.3.2026.11.07.05.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:21:06 -0800 (PST)
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
Subject: [PATCH net-next 3/4] net: dsa: motorcomm: Use safe 64-bit counter reader
Date: Sat,  7 Nov 2026 21:20:35 +0800
Message-ID: <20261107132040.1066996-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107132040.1066996-1-mmyangfl@gmail.com>
References: <20261107132040.1066996-1-mmyangfl@gmail.com>
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

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/mib.c | 21 +++++++++-----------
 drivers/net/dsa/motorcomm/smi.c | 35 +++++++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h |  2 ++
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 90b0ef670aa3..b45bc8211741 100644
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
index bf3adfd64165..16f62409422d 100644
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
+		if (new_hi != hi + 1)
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

