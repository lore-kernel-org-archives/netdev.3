Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794353;
	b=JQb+Dnqu6SnKi1TGixJ/yf+WUNJgnUkpocmc7ifvq27TthXvJAjprps6MUVc9BRy4Bn4
	 Ax0uI63pjoLX6pwDvev1hHldJwu4ig0gARA2dPORG4mO//Vk/QO5VapeiJG5+M5auR9xl
	 TMvf8K1INMDVYK3pP/pwIsfeHZAV2qpUBKH3flLP5Vqrdy3wleqt0ZYI29wpetiquUBap
	 aDdRiVcQ4iQ4J7UwR9n1sgEiEhRXWTZM92n6VbsjJJ2feApcKFcQux9ehHfbMyU2k19vl
	 Kpi/JA4Nlfpy5Mr+pMnM3okjOyY9KNCu0hAH1ERBo007++ygoyxFgB5E7C0Cum9Q5HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3hdjxJDa2z71+/Z+9H1w4CH4cajXV37L3T9XXobZoCA=;
	b=oOwdLddiKXQA4KkoOfPKQowgQYXggeC1FuZO9ugGa3Abe6TjO2gGA81ReGU4QhAX27Ob
	 V0WUPYCASM/CU6Jz0v8z2DgDmTrhne6w41iV6DThpluf4/QkU32v7gX0gdA6jV9IB8hxB
	 oxZsNHgV3IHhFdLg4CfZm1Isto/8TPYLOgxL0WCMzirp3ZOblZNSje8tsVchPn/K/a8Ky
	 UTRcC6YvXLy8QsLegaz/FPbwHNGzGE+YymM7emchcFxtLE6e85N5wr91pqyGX8acFPCvX
	 1duOJYQlKxw0c2rNa3h2r9oR2No+4+r8qUVlsb/qdvaXPQvlZUitc8lxbQJy/ZEsLMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbYAv4p+;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A1606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 178A1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbYAv4p+
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a73fdd2966so837365e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 04:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793794351; x=1794399151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hdjxJDa2z71+/Z+9H1w4CH4cajXV37L3T9XXobZoCA=;
        b=LbYAv4p+IC3snsp4kyiDeq7JnlTxI8zeQoSRa0t2mpXN/FGnEHu1VCTe3tgYCN3zzQ
         M7QikGo5VP+jY2Eyj+bCaWUC/mDXfSlcSaLRK9oTlDAXMPg3cDhVbawlu/fwTg1I8/LI
         BmhiSghDeUn8DhwqW/GNdddqO1qNgtCxeIxksmf0azGKBHqAWOwM5d9khwEO9x8kEn6r
         K3eAQUFfJ4QWRAVYDNY2IJFcra10k3WPOgay/xz7htrS/Hpmi4pQNIVuy1M/3T6j4lYH
         DaClonnOHHocLlJhTrdIfaU86F9PCyoXmy7+TPFQTKJCytyWC/rJFs0XZtHSWwBDRqm3
         8tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793794351; x=1794399151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hdjxJDa2z71+/Z+9H1w4CH4cajXV37L3T9XXobZoCA=;
        b=BXvO+hFnmTX7htB39h9VeYhL121+/ranUaKpOlMAo71DIJ4nENRl4aDgvrcKGf3GrB
         59B8Ei9HJHKV4NO/6PXQYBpw+5zKr98Vz3taVKvuuEkVqjuIDB2TwEDYJh20bqSdKV9/
         iHLGX81hlibvu861szebMY/vJbH7Y/4ZT9UdmZrKhqR37lbPrS+NQ5ZiYTOVOUCQv9zm
         XF6B7atEO4jTxxVCJ0XoydM7kUN4mG7W4i+w9IoEgxjuONoppS3s06dAn2H3lMSZvQYg
         Fda5g86C3eRkjT28UIopTN+C/SFrNSttYjRePBHk4ERRoTpaTjlCsM0zzUBn4Jkzuovr
         fwBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVNYZSaG1TSvpIxeyWq5kMV56aXwAHl4RANIkOGStUT2HbMqBoAShRuWfc2jiVwD4ek6miAjo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/Fap799GsK9atvQfTPjHyfK97XBVnTi9rbgLt2elJhNRxayjG
	BqTkxs+dP64eqKx3t/KsLt5Ou7zxfQwI5wAiwyF1r7Xhy8WyfksoR1Fi
X-Gm-Gg: AYBFou3VubJLGjAKtFPqYs1tMgU8tK000D8tb/k8GSnMSVzdnb62dV3/bVxQPcNfrlP
	7Lg9NrGdTzo2QcB8w2pGXZAis/4phDXrRLRn8Nuj9zJ6jn6U5K5GTcSQwzV32IgY3hfu69Af/gU
	q6YWgAsJNIcB6Eoy0ObSp76vEKELgpiDPCc32PVX1brJ9JexhknS/qh8+m2LHM0SsUlq2Uu9DYm
	dIyQsVfJHh6OcV9j90G9b1W5Dn0fCwkKZcrn2Omvyign276zYJZ5NpEAfg4KqZzyK2QMlcWZeB+
	tNMHL0nCZfjC5ruP2gwhrjL2oaPmB9SOuDgPvUpawphZM3EEXqCY9Zv9D7NxjgkCH3XYdsUMT5E
	OwcgWkK3ngjPRWzXbrizKBibJYRPCnqveUNSiFaTyRh/Xn2K0gdjr4/YaQaOfystZXoJy+CKU2B
	bU8eB5D0zL++8C/jHtKZ6ehD/JdtNVTmnJLLOl8Q+3tID3VdKjMATkupJw9uA6YIw9oCalmAjxo
	Qc1ql44QeqKsxPhgIFvXW8XiiMcPwmok+9LKsfqsmCSW/B8oNCwhnTSGbkbUg+eryAUKqmy8o/U
	xzvArF5xmrjwK1kHrRXlB3YG2/0X9TEKxDJBh5cFWdD/pSjmpI/u1wkBZCv4/Hf4xEK13ZkB0Dz
	6SHQvcnl/8G4MhAlObwj2jVl/BZgBF5fRZsqNQhkb
X-Received: by 2002:a05:6000:310c:b0:48e:eb:56a5 with SMTP id ffacd0b85a97d-48e6e2fb8a8mr35066356f8f.4.1793794351171;
        Wed, 04 Nov 2026 04:12:31 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fee968763sm3641943f8f.56.2026.11.04.04.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:12:30 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org (open list:MARVELL MVPP2 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: mvpp2: fix double free of the replaced rule in  mvpp2_ethtool_cls_rule_ins()
Date: Wed,  4 Nov 2026 13:02:23 +0100
Message-ID: <20261104120225.28377-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When a rule already exists at the requested location,
mvpp2_ethtool_cls_rule_ins() removes it from the hardware and frees it,
but leaves port->rfs_rules[loc] pointing at the freed structure. If
inserting the new rule then fails, the next rule insertion will free the
rule once again.

Clear the slot as soon as the old rule has been freed.

This bug was statically found and theoretical. Compile tested only.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Fixes: 90b509b39ac9 ("net: mvpp2: cls: Add Classification offload support")
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 80d15d7a5ec3..8ec94387cb57 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1405,6 +1405,7 @@ int mvpp2_ethtool_cls_rule_ins(struct mvpp2_port *port,
 		if (ret)
 			goto clean_eth_rule;
 		kfree(old_efs);
+		port->rfs_rules[efs->rule.loc] = NULL;
 		port->n_rfs_rules--;
 	}
 
-- 
2.53.0

