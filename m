Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055801;
	b=Bj16Dj3KJg5SPWXArDLEbxDUEVpnndK6GcQWuDHNyPNvX3ddQqFdJuSc4qnKHFUSRilO
	 Kycu5st9DxJjig++wi62wpqcln+7dDvht/3MO8H0lN6eOWRyQalFfyPqUhvh2p4gLNaUZ
	 QPb2+M5sOYbFj0Ci0V8e33Y2rbHfcj8/7TWUo9j1bK1xuacYXHqRiyPKILMznB5EvOTvr
	 RHn/+AvxQtMCPK2henH1Zukr7yw9z1sjUQEqrpKNAmDHlyjVEXLL+pbBnoqOj5YHj9OC2
	 VFh3t0QYmBI1+WwZJqC4ZPTY1Ks49ZYRhaonSOXsbjud5NOtrV2VV/7LA7MLBRWZ1jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ROrFvPTcijTWL4ncTf3h11CzKJrW1vsRBxLVCozH5DM=;
	b=oWuITBzeNof1yDLwMIMIu2b40NCvWfx7wjFayUk6MVLCSt7sGAlzitrlZ0z0QROmgor8
	 aEh+olez458/k3wW2LFgVeFweBRJRvt9YtrUikzLvuvx9QNHSRRiyVqiSpXnUz3nAl2Y6
	 3hAZOerhK5177vom03Qgq8+IBpYNVLv8ArjQF0eL98JHHNtmFCKSgGGfmJkbHzmZp9fVn
	 atxQyUCIWGywTnOBpmSJox75SwvFlWf5zhgxOqP512/3J+h0F0/SdOb+92bYu71mGjLFC
	 7ozRVJnDKsjYxb0wrIgPjchRrmBxQBNQJB7Qz/rIwsANeq+0BMoAeE7IRY44Gy5KfzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nPNQXelK;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D62606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nPNQXelK
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so1051084a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793055800; x=1793660600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROrFvPTcijTWL4ncTf3h11CzKJrW1vsRBxLVCozH5DM=;
        b=nPNQXelKqNOBtSyemI1wReGuDPcsq/B0AKQg0lhL2zJF81S3LChrXxmg1AK+3CM+pU
         Dbwi33DENRCOpp+rTzh5HgGkGmTS0W0VSEA6COez6MqIAV+D+iZLGMeh5nZJ5qPCfDyJ
         cPtZiE2H+0t13rkUnVe71fdjOAxbXbd64LY/CueWJ94zK0yW+h952PWqbG8sxYtZXn9g
         DnjBdrP1ZDiLEpDQL6ZhcPtliUYmMzf4GHooGORBbXXMJ/AEQENrY1/P/cXQg+t1bBpI
         A0tOFeIYWoXCCfKRfyHaOrafZJUZdHz3tLvCBMOn3/pL4PGi3XygqutNDJL7sw9ipECo
         ktkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055800; x=1793660600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROrFvPTcijTWL4ncTf3h11CzKJrW1vsRBxLVCozH5DM=;
        b=nIIN5CxIf8KNfswH9yJO3tRscI+v5WtJ1GlKGMNAwFV1jZ3YiVBK5wKLhH3PdUUX2M
         0SuKyzOGzzkEs8qnkiB8tW8jqs0VEiRaUho7PDw0nepw9hprYb/3woUsOWC6hsaQ6s7k
         cybgzDBOJIZEM+TN0SCXN8WDZlB/ERKjDd0ufK8js96RjOEiXFNRNL9VgeZJvWwhBoBO
         HMFQjSEyxI9pJQ1Qq/V6s5vOAccWwqc+/tknD+fuC5lOCj8HirZg2aMazRsRlZyoyOGP
         rsk5uPSxUmQUelxuy4lgIvoDGIkQ9DdMoF4EzmwNWHNxYv8H7YER/5wiD4jWG7zucGgo
         zZAA==
X-Gm-Message-State: AFq9FYJ/hNGUfga8lVKr1+igdcD9ioBJoyRQ1yVGIV24f9UX45W7jVE9
	sAbJc3mmR2vm7OUmrwmckUSbfD4+wx97U4RvkjKgNI9R3S24QHsk4f13L0UP3A==
X-Gm-Gg: AYBFou31HRLHdeyUGWNNwUwnKC8geMwbkFPU+aKX9ImgtXRfgwunKL7vvHPggB2Vlt7
	vyzdLPFS5BKVYUA3ptbYP0p3J5jZw0x1dx0et73ClwqjeTUhlE0cNp/dyylEbkhynwdXKBI5yYz
	Uz5HEbeeZtpHiyMJ3h++qvNBm5dHmLapc5ub86wg50NQd5rpFg3A0gTSRsoHodj9KWvNTfEDR6I
	qs0uTokoO3Ug0i/B9JXH37iyIABWLE+LnX8DGxFPkw6OQa0aMok6bmgukGmRi5pOuHfhS/S9mxS
	eGeukHlKmbRf+G8Fa9l9eIlKZCwyn0taORE2PO9l+uNWiWFU97VnKpOHWSs9K4C+B7xD783NZf6
	rmCUHu84YZVXXK0aLdlrAha1FA/iB5ZfMxlmP/hKNwYVyLxmXOqc9sLy2zA44tPfcN/aH5LkcYv
	sRu8v8pexZBVm7bQCpaY2jXiMsMoPfFIWZfgHj7y+2MnyunvOnVY+5zgOBo6Vk0G06atN8Q/0Ho
	3RQwU+9xgpukkkQChu31XL4vJReng0X7pp+PuI5JDwe3fQrPboAU7jMnFjWKdjbCZgLnLn47+qL
	5vqnI7I=
X-Received: by 2002:a17:90b:50cb:b0:3ac:9706:772c with SMTP id 98e67ed59e1d1-3adeae83414mr6652606a91.60.1793055799777;
        Mon, 26 Oct 2026 16:03:19 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6212:1232::1d0:de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40427782sm1100471a91.4.2026.10.26.16.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:03:19 -0700 (PDT)
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
Subject: [PATCH net v3] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Tue, 27 Oct 2026 07:02:57 +0800
Message-ID: <20261026230300.1108190-1-mmyangfl@gmail.com>
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

The chip setup only blocked unknown unicast and unknown multicast
frames, known multicast and broadcast were left open (though the former
cannot appear while the FDB is still empty). Broadcast frames received
on a port may flood out of the other ports before port_setup() runs.

Close the window by fully isolating every port right after the hardware
reset.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v3:
 - typo
v2: https://lore.kernel.org/r/20261025144834.2810828-1-mmyangfl@gmail.com
 - reword and reduce code changes
v1: https://lore.kernel.org/r/20261024144023.1010237-1-mmyangfl@gmail.com
 drivers/net/dsa/motorcomm/chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d4fc20c52a58..f71160eefe48 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2221,6 +2221,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	u16 eth_p_tag;
+	u32 ctrl;
 	u32 val;
 	int res;
 
@@ -2258,6 +2259,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 		return -EINVAL;
 	}
 
+	/* Block all traffic as soon as we reset the hardware since it now acts
+	 * as a dumb switch.
+	 */
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

