Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614424;
	b=V0QJljRGB4kAb8fDY//6RAg+OKbDPREe0taeFsA1IoxmnUYPCKQ/bIi7lqOvYBzeLQSB
	 PBLMobxjFHWoQ2no+dQbDITB7EgmkcXQhv/wBxRFDuK+ZGsU7u450qkp7rCSjPbxpDfdl
	 hkhsKLtoQbi0QD8OANt6/tBZfcSG90Jx/DyhKS0yuyHyB1bQ6LTin46hCxZETwselXjYR
	 FYsqU2zkS3b/KlQAEU+tCHL6PdTQhA7x4By4HdsGI9Y61L8IUPgpxv0TUiEi3hqi2lQnH
	 IF3BSdGk1Op2hVUsVKiL8GynzHap6Luta7RHFZVZqt1Aix2MFekEix9dROK7AnmgDJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0/YKtDl3kyknZEf1poD/4hGve8tGLQ14nN7yKL9Ojgs=;
	b=jl4zVYFRiEqPS3HioYPs8hRzjQki1JhmQXklFTOlXQecATM2g7bIzfWaKxun3Yv/Oq/Z
	 gbbiQqzPNRwDRz83zA/dBKqg5ZZe7/QPd8stpQSST7qEfD1Tvv8cmgp95u4b3B6CGFClZ
	 udfI6iAs+QFFV6bEAUH10BPYx+/ArltMOSquRZjvZYC8Al9KBFmJCxnWXYXE3aiQV3r5t
	 yhVqNB/iGFVXFP/x0K2alwlojL/6ijJOY5C03U/8LXgWUzVmJ1lyU1YPAhblWhWUq9tVB
	 ZDFZPObQyjnoE9omy5q4ZumUZMxGwnG07VdgPLUvInoTsKhs1msSGmJPuLA95IrZC0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PGgoNLh0;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F0B606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PGgoNLh0
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1730141a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614423; x=1794219223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/YKtDl3kyknZEf1poD/4hGve8tGLQ14nN7yKL9Ojgs=;
        b=PGgoNLh0EZlQj4dyv9MgssIQx/bFbr7KGJXYLtareFgZ5/RICqwI1uLgg3BN09QKA8
         ZGm8OO93Yx0bvbYl8YvMKevNkWkIVmRUo32NRZteidD1Ze/thdX7yjKt/rVD1xR3cdE0
         Txoc2xuHV6qG+HpiIZrlCKmu1qEs/QUU5syyEKZWJtdi8cnOF/1jE9mc/FzUwLOeJE1a
         YlKhk2n9g0pBJStgek4JKrTQ0XOByPzb4KCkdEbWQoIkMNHSyBV92/0PYjxtF1ylAWi0
         JeF/7WHDgL8Z41Zs7DdtPY64TMeN8Dywv4uPGme1gnJFOJoRHMpbgtUg2HQVUwVRefgF
         eJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614423; x=1794219223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/YKtDl3kyknZEf1poD/4hGve8tGLQ14nN7yKL9Ojgs=;
        b=XFnQHwmT7Blakc671Yz6toEoTjXDbuVda7l+bTxkkoob+LinLfKnrTN/JXAH4dMcaD
         vhqisTj/k0mslhV3fWj27aR3dQrHCFB5ahyUpqNSvta+Jx+4BiXDDaHzCfZwurzNneiC
         Ba0Gxl/ai7fkZ3CQ0bji0i4ubtZ4kNSNbRFHMqjSQHvE/JmzRmpYOpVKWRiDOf0ZYdFV
         xds2ElQDAsDipxHz1Iiz3eCCa763hPtDIMnuRjQ8dqS7mR7AnMXlMUD+Aw8GJ20w3A3+
         wj03AIKLp0v97BkS7T5UW3TBkn3zG2oISs4ZFzf2ryducOEp2MKqJajtU4pqxzM97Fn+
         Ub/A==
X-Gm-Message-State: APuU4Z8aleC+KulVl04MBhhPdzBYuxNhQeIi1+jrKTRZRd6ArPhQIB/G
	nEWKYGObnVrI4LdUX6Nm8zWAAxUVs313tvihCqeW0z+Edh9YX6I4lgeC+86/dg==
X-Gm-Gg: AYBFou0JkMK5CY5MWdBStgZFcIS8baOkiWcGN5/j1FOIxkDOU0IbzyFeUONhEFNSq1Q
	geCfiZLnJD9KcRrhTlCi1xnl5S2ZwSk9L9MnQSPiqBuMaS6R6WZcgfBNC1A8M/RtjIo7c81/N8E
	pK1hVZlJrEA1BqKN8V0kR4WILaVvMcKHyWY/M/DOoN6hI/pMQRegGWM4kJMnlzuGQUQ3bRAC/El
	0bIamJwPpQZnP9k+Lc/9JxR8vTP2EvNx8TqIBtTMbJOzWu4SmigVR12X1dxHaYQTAsZBfm1zoNB
	DcqeRiUpYJRS62bzO0hgXO0kZGKo9/VlPj0EA0RFrqWAgA9JDZdIDRHTBLAwXIEO2H1uL+Q6iUr
	a+su6pNx2D+Fc2l5qP2zt5bxqb6WhDjnDke6SmuGZLtfByUfnxo0rg9wQlExVekV8FbMp1jiZ+Z
	M2F2wVC0IASG4qmRv138ruB2d3T05/rsSGhz3pX6eTkHo18HapRmMwNgrBZdjluNd8YdhyC6zbs
	Q+s+d2YnC7VdsEqCP5WXVT6czr+Lcyue7SDQZQTbcFshFRfP7Lmf0SWXda8oniLEMXEN/U4oF+e
	Hvk1LEGC/qpn2b/+CLcuJUH+xZ6NalHRF2/NMC2RPlcIbi3SQaUXd9nHc3i288oAHzQJCvZbkQ=
	=
X-Received: by 2002:a17:90b:2711:b0:3ac:7449:40b4 with SMTP id 98e67ed59e1d1-3ae8981bdebmr6716889a91.45.1793614423391;
        Mon, 02 Nov 2026 02:13:43 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm18762641a91.1.2026.11.02.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:13:43 -0800 (PST)
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
Subject: [PATCH net] net: dsa: motorcomm: Do not publish partial MIB sample
Date: Mon,  2 Nov 2026 18:13:31 +0800
Message-ID: <20261102101334.3525485-1-mmyangfl@gmail.com>
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

When a register read failed midway, the buffer was published anyway,
mixing fresh packet counters with stale byte counters; get_stats64 then
subtracts ETH_FCS_LEN per packet from the stale byte counter and
underflows on unsigned arithmetic.

Keep the last complete sample instead.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 6b170fc6e187..bbcc418fcc87 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -127,6 +127,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		buf[i] = val;
 	}
 
+	if (res) {
+		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
+			port, res);
+		return res;
+	}
+
 	flags = u64_stats_update_begin_irqsave(&pm->syncp);
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
 		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);
@@ -148,10 +154,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	u64_stats_set(&pm->tx_frames, tx_frames);
 	u64_stats_update_end_irqrestore(&pm->syncp, flags);
 
-	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
-	return res;
+	return 0;
 }
 
 void yt921x_mib_poll(struct work_struct *work)
-- 
2.53.0

