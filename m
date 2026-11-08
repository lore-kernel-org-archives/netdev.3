Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174315;
	b=AnSx1pv0krgomNinSkD1Jp9uvOHHbkf3iyJKwVEGEzm/PY8wyKHwf6/YZlPfwa8TE0UY
	 4LR66Fy1+DJGp+ngGAjbp/kU3gKowcJub5tNci5K12vkRMT/RMgsIiBx2Zr/Yq2IlX7eO
	 cMn8r9jQfjVzujON93r+V0QkGQwqxwYIcxX8V1KSHW9jXLkIo8v/e5qz2k4ZlqBiQADrn
	 xMS936GXOaTady4AX++lo11+mbMAQgceB+Ij0wvT+Y27ozEUlA3IYkSzqsH3k8jLId+fa
	 EMKt2MPJscI56LLXyDBQIj88j+CzcrODU7F4tdSCGy4tgFjL8yHQ7jKoBujiCUmifQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xnQeGBiEH8XniaPdtXo6TRG8fMURfPvZnz3uNdKFs0A=;
	b=5RbdUOKmA2Rs58SXqLDwP2OOxryC6KHP16vAj2X1qsdCmuuLpUyGRTzPK2MrjUBlph+A
	 i/zCVUZgEpgmHWDIw5MW1OMAZTCc3JOUX70S4DXSeqQCrTyWdGu0HGKyBcG01oGB1xYfi
	 Sh9Sta11T94dIGVPrsuz2pE6mOng/cM8X+rhdZ9U/YUo2NqxAJyYJhg6OltcRsHKbXl61
	 UukdmRr4sldi5/JJ01czx0xyThk0qHcgecKKHe4yKEdX89EeEHgQxzldA44NVvZ4gYFlY
	 4zOFY8t2WkOo3Hxjhaypu7n+Yyl4GdxUzxC8BfuAV0Xkq6Saz4Bmrn+oS0vwySFB0uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="H6v7/uaX";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E8606A33D
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB6E8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H6v7/uaX
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so156114a91.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174314; x=1794779114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnQeGBiEH8XniaPdtXo6TRG8fMURfPvZnz3uNdKFs0A=;
        b=H6v7/uaXN5ImIlXEQg7Vi6q8sSpAAxtdlzDO2SKtZOWSV3q06KYH46GhKX1BGBKv6E
         iqdycScwfmaFyc2tqEGrxfzDfWtyIqRkp6YwpkOSG7x7A7B8+xcCkPShSbY49mivodLa
         25nFGuVsAOhk1XcA0qBRJrSZUebzRkKRt44cBJFcP+6eg7zlzZ5Mm8CPAKdDKE67DY0i
         AXoAdWSuVwwtcSjg/6rqIPxzDKe/lR9KHiVUxSPbe+VPqjONzeviF2lwhtUaurQfsfvR
         aVr079OutPoSq9jbUrqz8hFfOxd3uQpqGTOzxb08jKnZLwm5gXLxyXtJYFCCgBRiZwBF
         NY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174314; x=1794779114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xnQeGBiEH8XniaPdtXo6TRG8fMURfPvZnz3uNdKFs0A=;
        b=NSDsWQvA+ILoOhIeTn9FsKz6wQBtN5zYqQbN3hb1IbX4kaeFeKJ/voGa4C2+ZDiVT6
         pstp5LgR0Uv3cKiPRoI5cZOPKXeRExutoZ8I1e7EmjxhH/S7Ruiq63UMWAtoDuWGX8Qj
         U30e6oY7KQuBOFhk4SPuvVCwLsR92C8RQYAHpyzFW4HkpN/YmlZKG6JUhoxOPC80itvL
         YYBczK/zmTUAd7qCzAga2Pa52D3ENepQPTnXA79ycifw3veojusosaFLy8MtQZ1BDEv3
         22AGNia5uluDHo3q6h6HiAuIPVqYqJd+Mc0vTYKI0LAxNssLWL069ulbbyQFvqRgoL59
         pdkA==
X-Gm-Message-State: APuU4Z9HWPbv1HdrbRBNqq5u3Z6t9d9Cj+GrUSr63JfUCEPKroCZrAgL
	vk0lbEaxnQOxxdlJBF+EcpgtP5+/3rlx4BioRvUfHvVPf8Jg8EJgAkMvKyiCBQ==
X-Gm-Gg: AYBFou2/yAH7G7si6amVQ1XXbQRDgm1YVSUcU9mkOkD+IVm0dmDwD/vLAjbTuHHQt9u
	dY9dxQn9G/qYjAF9vLXQQuGFGeAe3MNSgqpxrst7O7WHOL5dynhktov9Ok1usAVfuPur5YdCfLy
	Mryfh99zPqKPx3S6E3yLToktWRwCe6CaoMntnF6qHiWN1fwjQLyQwH8X3NXQNoX0l3XIlDMxTe0
	l1nGaSW4Zcvl9IGr62eeEQuRCr/hpGTkJNAD2o1/W6b3dSTtpqvkJmO1TIwg8WapfIgxApR2J1V
	IRGx5kITflXL0QzUI+Ac/oMKwa8e21Z1bggCo+XRM3DZesRqy/e0Qp3HpthSV6EewfwKdb6AzEi
	1Us0k9xjpOOMMk0D3536GULSyBIPRfNPqwFLVmV3wdCxZaMi+JPoCEGobOA3gNoz4wl8NhvC0lq
	q88nLat8ZGbB6Iri23TpLscXSKLn2n9f5gCb/2C2n3wN8wyg2uEhcYNzo2RkEwBuskZ/qLCQ0U5
	/UF3QyJ07X5W3r6S6E7xgypujxDVzf8NPaIUYlpgncRCnqxFIes/Rm//EDkxS1FiS7UknU3vSy2
	Fyc/0TtLXA0q/cecF0Yn9Yvcdsr++g0I59hBsWOPHrma/3ie4XxnM7M=
X-Received: by 2002:a17:90b:1b0d:b0:3ab:2d46:1dd2 with SMTP id 98e67ed59e1d1-3b12d1002c5mr2069263a91.6.1794174313968;
        Sun, 08 Nov 2026 13:45:13 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm4619463a91.4.2026.11.08.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:45:13 -0800 (PST)
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
Subject: [PATCH net-next v5 2/7] net: dsa: motorcomm: Drop VID 0 VLAN table programming
Date: Mon,  9 Nov 2026 05:44:42 +0800
Message-ID: <20261108214450.1662362-3-mmyangfl@gmail.com>
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

The VID 0 VLAN table entry is unreachable for priority-tagged frames:
the hardware classifies them to the port's PVID before the VLAN table
lookup, just like untagged frames (measured on YT9215S), so the VID 0
entry is never looked up. Drop the dead programming.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 693564aeaec1..47f06945b8c4 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2263,7 +2263,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 {
 	struct dsa_switch *ds = &priv->ds;
 	unsigned long cpu_ports_mask;
-	u32 ctrls[2];
 	u32 ctrl;
 	int port;
 	int res;
@@ -2321,15 +2320,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
-	/* Tagged VID 0 should be treated as untagged, which confuses the
-	 * hardware a lot
-	 */
-	ctrls[0] = YT921X_VLAN_CTRLa_LEARN_DIS | YT921X_VLAN_CTRLa_PORTS_M;
-	ctrls[1] = 0;
-	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrls);
-	if (res)
-		return res;
-
 	return 0;
 }
 
-- 
2.53.0

