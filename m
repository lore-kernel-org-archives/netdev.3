Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0423C37B3
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151753; cv=none; b=sTSkBhLxMHCouIB7sIhvaqCMjqdlBQzBSaSb/5276YTDZ0cq5sFLtQR/KVdCCqSNTNSGf7Slb+O++y22nMdX5vB6bNy56RB41RfCgANY4J+GXURpkI//e+4qwJCoWgk2fHWW1KUE09twGu7wU3pKfdqqhQfAN2UNH5wMPHTxziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151753; c=relaxed/simple;
	bh=kNo6YdY+tnvG2KdzifeNUva3yG8J1Asl4yyX1fMA87g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGgRTXBCtnmeKV7E0AxPEAMVPTvHOJqkDE0hWJ7QiC7n5iF5ITHa3nDDZ2RzuUUaX7WzBluPCekmfm+HkXOlGAV0B4Eye02HqaZTFVZfOWUVu40XslHHjxIveiLGw8wblDkX7UsYaW8hm2DwOnqjhhatFKA3QuknxYXLflvTpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDlovnGN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDlovnGN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d9201076b3so6357065ad.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 21:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151752; x=1788756552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bq8iQGfvzt1d+4SYb4LSAR03b7kK3VKsffzTguj8T24=;
        b=cDlovnGN1woY+8zxnTgMNAKSkCK5gnD1q4lwD12BBxTwvvMwafiAeV+q3CfJEi6VUY
         SmOUJ7MrtnA9R2NAD0D0biZ/bLtriI1dInyQgfdQ8m+hMfhlVW3/wN4u3h3P0026WvFO
         t2sdp7rJhSv7nLa/H+rP7WeuZaQBnVdtC0sa9MJxVjxnabvPIXE6IU3o+3R6GZ2oQqk5
         JEMW/ZMGGorJU4PAf8F+rc91NA3xaO42QGs8u/RFSfQYjeiHTBCe3L+z4ARO1NJLUAOg
         kyBQKRbSrOsTTUpeMcc4+l6UDgqyqjHMyTV5Z5+1EUE21ND+tXaOWO5AV845nFb+fN1r
         yGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151752; x=1788756552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bq8iQGfvzt1d+4SYb4LSAR03b7kK3VKsffzTguj8T24=;
        b=bdnytXdxxB/AQRpGAb/FGSEXND856GoY2PT0HxQ4V0/HHDpIVDwgANUL62X5PGW0m6
         rE8MxlCxEICNbZPnZQunKtlcZ2rVwap9aUu0n1YbsguymFY537XEj3HJikKRPKe5mCDN
         gGE31SZSogj697vyj7BXXagf40eqtCpCst00Hf13tQTJsgyuv+thji85YOxhGN2cs/b0
         QCs3yfsGgKW2s4R0FqtTfaM0pIh+PUbJ1hoV+dNhmDypL0nnZO216G5Le+pCHqS6J4i1
         kKbJIXxvUuhD3XCBcWIXSElxoUt80TuO2LnhLFq3EW1VE28Wwwp86v2p5pVVOJZjxm2z
         FOXg==
X-Gm-Message-State: AFuF++mdM3RpODmzrOWPmHtHUOw5j/r0sYnCMz7uaRbBpv6AD17HC66o
	WjWwQBuuTPXU6/akZwDabzIs7KwsmLUzNNfKYHMyqNUq7eN0XPZCnJgsHvJuqQ==
X-Gm-Gg: AYBFou1Q/89r1jq/3ekqvxI6ONegAPo0nI+d9a1IOt5lRQzGM55INHZE0JOu2Bw/B7V
	JVRig0tizUf5En8wvRyclBot1owEOtMV0din7MfaoJoav+BTIbU+1ZfzvZ/17eSPKBmTPyR60ZS
	gd5Z6bUeQf23fpS0HOREVs2NeeORZzdwqrQtohrcs9OILeVFJD8wA/Tk5U+XRR3ZcpyheWA+Q7s
	OExCxQIdPrfkqEIR89tNew/Oe7hUflyuKt2bypnIdX1jPG7g+rtzNI51sJ1Te68l6WT/iNWtIkV
	Yozv2KrwkP9Ka7kJUrh0GDg1v34RcJMBIPOUnexMRIQWVlQcFIVHxot6PNYoWMyDdPYbDZ8dePZ
	OTHlCi7m1wh587IwHwz7VSFwYL1wK0Vc2NGioJg7NTHm23g0MDVVs4qMMXMUemK/9gnWYz73Z+t
	+bbEjSz9SuVHWyNBzck705AgzjT99r1dhcoJfvJ4HMerL3jWqxW6qYAp0nCzRCvnyl2pDkLAPal
	gsYiueD+VFb3w==
X-Received: by 2002:a17:90b:17cd:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-398bc52849emr14859186a91.21.1788151751644;
        Sun, 30 Aug 2026 21:49:11 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:2e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm19345763a91.8.2026.08.30.21.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:49:11 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v11 1/5] net: dsa: yt921x: Check lock status with lockdep_assert_held_once()
Date: Mon, 31 Aug 2026 12:38:54 +0800
Message-ID: <20260831044818.4103477-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831044818.4103477-1-mmyangfl@gmail.com>
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mutex_is_locked() was used to check the lock status. While it should not
be triggered unless a bug is introduced, it does not warn on lock being
held by another thread. Fix it with lockdep helpers.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 159b16606f6c..44fcdd47ffb5 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -198,14 +198,14 @@ static u32 ethaddr_lo2_to_u32(const unsigned char *addr)
 
 static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
 {
-	WARN_ON(!mutex_is_locked(&priv->reg_lock));
+	lockdep_assert_held_once(&priv->reg_lock);
 
 	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
 }
 
 static int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
 {
-	WARN_ON(!mutex_is_locked(&priv->reg_lock));
+	lockdep_assert_held_once(&priv->reg_lock);
 
 	return priv->reg_ops->write(priv->reg_ctx, reg, val);
 }
-- 
2.53.0

