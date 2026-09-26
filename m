Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28A37B03C
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790457511; cv=none; b=LdaVsvN+vy8tWb9KEs8GWO+AenUgLRa91IlzAimDgbLjL3qtQflEhGi3gSHfHRnmHfYp2AhiF9zRsoSo6Y8gXDhZKke/bxfk/XbZFyyGn7kfCVW2xh1mDkl+8rCfz26qvoIpYssbK6HIsftrNv4puuuTQT2+TkqsWDWKFPdW9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790457511; c=relaxed/simple;
	bh=ryFFIZQwlBWdWNo+Aacx5hmk4ccvP3E8KncHVG8204E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASkldHCmUGRX8+39H9X6kYrzIC16uNDHSS3jZVhQ9Qto6z1vuJfcVpJVO16Vixin93JmVYxDXALjzugj2BNeauFWB946b8kRLJBbQmAqZ5lylCWO/qK0M2jJyHps3l6J6ea+1VhIgvKZCgwONYs8zepab/zRO/rGfTLDs+u8Vdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evk6PTdr; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evk6PTdr"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d2c37b0bso471802a91.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790457509; x=1791062309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hKYUvU1uRkOorxf0eC/LBTf/LKSxA/wOyNWUbMTeLQ=;
        b=evk6PTdrpwiQSRs3v41tdlNFVEL96ueR7KvkP4k9ZK53NQLz+5bk1QMFZ13QBgsRAv
         9yhLNAABLoLmdqYycDTRhrLGx1gk2+2u9UdowVC2Hrz8Zncz9QRTJJ/HuRryu398watO
         SeHKylb4OjYzJyqbY3v4NTgSPYUy30veRsnu2LaezgoQL88792MDZnQp1hHLBmlzFd8k
         KrwFdEuVUMOTAYdoc24nw53TENOYCN92sfTq/p1vAU9PIJHgURYxagOvzfQC56QQ7k8p
         8df15NGREK30edp8bdUw9PnKQ5MadwTndsqpztbV1MFDubNzg1wBwVSN3Uc1Ud2qiN2m
         adaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790457509; x=1791062309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+hKYUvU1uRkOorxf0eC/LBTf/LKSxA/wOyNWUbMTeLQ=;
        b=pxi6Cbe63RzQIMAMSgI9H59AyVNRTfYWJ3ke824PIce3XL1WdNGER2xNvKG0KHadYJ
         MeRzp/sLVJDnhoVjRfGVEWdarUvUQaqfI+kwB0peeKCqUf5d1OekHjyqPW6ZrWGNojre
         2fDiI5jYH/seVizLHWLAkZYvQA7HIJZmjwGqS+oBGl9m/PY1TIGACzoE1rtxDwGL3fLX
         3h2dv1tghT9jAgjjYgWscd08VZ79s++jtMACftHIvOePQicApYP7dgN5uSkOzn+Sm68j
         ULp4hwDf6KJ5dnjFQxuFnb+bzqzKwe9bzQ2lw7g3Az6cNwYNoqNbXAnz3vaKU0IiVRwo
         6MNg==
X-Gm-Message-State: AFq9FYLLukOxKYSae8TAfc5Xhu05CtKk5kHJRa/aF/qoWr1fsXfNMKlt
	rYBPFk/N/VxSYVvZyG+RAPwRMAugxGE6YLA48qevnuu8Ky0RM2BZiA4a3eQoZg==
X-Gm-Gg: AYBFou1FiE6kYLsmmxRuQwfEdZLZhLTDYxxOLHo+dulwix4Gcn18mhURkWuzbwVEHrx
	+ioS6Z6ZtlplhQNChD5sf7zqIsg6ogiebf2pUParXVOzHcYSgVPFdirSTV7r86Ta/uVh574Sv/d
	tmb46FrOnndiPfUmYw1Q6okGyMOi2LK4CD34wVzXYHi/+oEUcFlKpf4njH4uEnX01D2gfpbABQQ
	VKkoacpPsESY17YABgvQepteKUF7BDu9yXiICYCZn0/tLnfRsFe7ZNkpUq/gB7gnH32FDG/O9x0
	vegPPYmETOSklwxvKOoe81e7pcO3Hjfsa3/XvncCoQKLTO6PpKU3AXGOAPufPFQ3+Ff3JVbxns2
	///E0gIaA+NW5kNGuSSgSp88oNuLpzY0ceplZOv705R09/aik8h5VZ9yNznaUYoabrTpkFHFaHT
	OVRSRsx8LCyPDz8s75AxI62PyVABDoXILZppv3+Jhuy+zRbdXYOELnh5U4sbbEYbz7fC+ASaXYd
	9wUH7SheBLMGk2E7Btj3ah5
X-Received: by 2002:a17:90b:28cc:b0:3a0:d440:7950 with SMTP id 98e67ed59e1d1-3a0d440b3f7mr3243034a91.4.1790457509496;
        Sat, 26 Sep 2026 14:18:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c3f74e5bsm9473204a91.5.2026.09.26.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:18:29 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: dsa: motorcomm: Use NSEC_PER_SEC
Date: Sun, 27 Sep 2026 05:17:31 +0800
Message-ID: <20260926211813.935723-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926211813.935723-1-mmyangfl@gmail.com>
References: <20260926211813.935723-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of magic numbers.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 38dd4ec60bbc..7717f1e17923 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -28,14 +28,14 @@ static u32 rate2token(u64 rate, unsigned int slot_ns, int unit, int C)
 {
 	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
 
-	return div_u64(ldexpu64(slot_ns * rate, -e), 1000000000);
+	return div_u64(ldexpu64(slot_ns * rate, -e), NSEC_PER_SEC);
 }
 
 static u64 token2rate(u32 token, unsigned int slot_ns, int unit, int C)
 {
 	int e = 2 * unit + C + YT921X_TOKEN_RATE_C;
 
-	return div_u64(ldexpu64(mul_u32_u32(1000000000, token), e), slot_ns);
+	return div_u64(ldexpu64(mul_u32_u32(NSEC_PER_SEC, token), e), slot_ns);
 }
 
 /* burst = 2^C * token * 4^unit */
@@ -86,7 +86,7 @@ yt921x_marker_tfm(struct yt921x_marker *marker, u64 rate, u64 burst,
 	}
 
 	/* Check for matching burst */
-	burst_est = div_u64(slot_ns * rate, 1000000000);
+	burst_est = div_u64(slot_ns * rate, NSEC_PER_SEC);
 	burst_sug = burst_est;
 	if (flags & YT921X_MARKER_PKT_MODE)
 		burst_sug++;
-- 
2.53.0

