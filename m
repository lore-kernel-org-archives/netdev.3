Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535405;
	b=nMWjqaAT2GzHz6Avp7zUT0cTGn8rwPpprO1I5Cnic4Rnr4EBq54G9YkmsF3s4fnHD4DU
	 PWFzk76bkUQ0FEnOeBgzqITPA3kWBMnDJFnDIFbqJSufIG8jZ1UoFyQ6YEu21xAGtB+9M
	 rphIv9bxi4EO7xwjqQ7YEtrQuqc5qlE8Ve4npd52sLpQ1pKzVbbtyQizDMkEnO9ijnEE1
	 Lb+ASZzGxFF1cTFL3WftixXuVHyZUwxuKZwmLcyucscR/YUVNSfdWzeso2nwpTXySw6zq
	 xOpDYHGzjOcuvMTnLiNNPaRwArAad9RldYFG3BdHBlDFxyDQoz3/d+rXT3jZwQPUpRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=c5assFKVMGGXUkEMinTb1XrwHt0i1wfhDNtcpFfaGgY=;
	b=BQ4Ku5NBOW9NolTbTDPGQvnJXTDpBtPdElBZisLilV9r/9+budx8QFzkpq5h+6m6mQgg
	 5zVoX2pm1f+p2T+ua6S6dVLPpiYk2LPqW5pd8HhhuFLQR/RQ//JlKEAHpn+ZZxIXqbHMu
	 DPj/noDyfmmLIOPRCa/tdgRoOvhoe8yTj9mlzXxvosLN4XQkQFTfDQqqU3yTBHCxaKQFp
	 zdAqFQx2APzlBfxq7fQBM2B3NLY+qXrpb94pMrc2s4glzLF2qDyq78kQ9g0KtokoLo1iQ
	 7SsmFEAZAiuWDVQ9r6lwEmHlvmWMeFXIdqpHRjfZfYibugKOxBlR8rcYEB574u9fKrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T4+D2npb;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFF606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2AFF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T4+D2npb
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so111087a91.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792535404; x=1793140204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c5assFKVMGGXUkEMinTb1XrwHt0i1wfhDNtcpFfaGgY=;
        b=T4+D2npbKehi8mG3vCsjpP/dcE49IbSfKR9nhngdAG/p0kWORvvktmyiSdh2ytzOh0
         rg0WDbr0tu82Z4pXRxZS/QiXwUuBSDYGU2Uqd4fdnq2leNFgyoPcZmlKYHsLB73tAwKO
         IpAyUHcoh1qupgoXnF30to4G53LIjdvcimGxWzIrMU3kagtdsriyhlXGlJ8Y/sLSkkv9
         S5mlsAAE6vL/S/2TLBYsuf5jIZINIAYNH0zL8Yaqd7st9BfuzSyVk6f6ohm0T5vs99x6
         FUxb0t2i6qXAEe2aQ2ch9if20B17T2Csmbef6Y0QAxn0pHO1RsNFpuZerWbswGTUUdYO
         a/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792535404; x=1793140204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c5assFKVMGGXUkEMinTb1XrwHt0i1wfhDNtcpFfaGgY=;
        b=pJrDmxdbjAQNmow9bUldDTk0ntIUGe39+RcujtXqiqKKTfqPgC/mH/CyFHAYmVUnzf
         Kh/MmxVuBj+cOaE4FnbHifjyx76N8+G3obUQabVmB5wAFmQmmKZX7Ga+2Si77njMg0LI
         K/9mO5f2+PHrq+p3h9XizHYihlxY00kQQ/8HZnVpIHdJ+XJRZS88HMTOUKKfjbOIPtW1
         s1nwEXBaOXqWPTtoU8mlyp4+krOOM9HpT5VEBZVtwAWI+5cnI4t2mh42qJNIOhOnqoNE
         tjz6i4t0N0R0BZj9Aa3wvuM+U5Y+81A5lg7Y4h9hlhRjWfJuNBMLsFgoglt/Y/VYqJc5
         x4zA==
X-Gm-Message-State: AFq9FYJ5vNTjsDbjc4rs2sZemIkYA7CmUlYg7lO8w+aiAtmNrhwNWnCM
	4fYOa1IG6OKOCiImBC3VrBpENNP2TMcz3JewLv7aczcXiNW6+D1MOTYIKLEi3Js0
X-Gm-Gg: AYBFou2kKt5HSBgCKps3OrzYK7+/iKSVHPbaJ7WYp3bDALh+Fb13qiM7ZtdC/oSSloR
	h4MFNGbenKb+e0M+suYDBnyp+kYgC1ERqpK/BpCRU1sYRhbDOy1SiqdLl6JAiZR9eN6qzqk1/nD
	F7wiWFzFy6p8Jkc7xib+LX5sMuYcu/fmZKZ4rOK14MpaL34xFY0f8hFxF3mSMOuCK2+0qUndxvc
	JfMAEXVRU0U/IJYjGoRePN+xXZuZiIcR+VWh4O/MjuQsqW5SI8A64pmOobeQzyhlN1Qg3NUYwF0
	4zMWadJ6hkQS3N84eCTmOkPFK1kP4SQ+PuDwwsVL+fqNm/WnT/AheUOw7PIsrfV/uj3QqfGy+Tn
	wx5GOYUZ5i2ql6bni5lED0fjeIVTfVXJl4ANX3/NadZRXUFJlflnJnlQruYOYeZt3ebl/3au3rj
	BtdSvaycZL5kTxw34+d7vToTJS8GjxEyep1bC2xd0b9Fxm+OtaIYOQBVFILmP8GwH99iM0MCMrv
	lPCRc9ibqDP35LZOg6DuM+U5PhKpwHqQZcJju3HCee0qtiq5WahCU4OtahlK1XSn1mDdp9L6NAN
	U+DtamcZH56CEaYb29FMcGQNOLP4N7dw8VCGyWZBgPA2Dh/g
X-Received: by 2002:a17:90b:4a01:b0:39e:6a80:b799 with SMTP id 98e67ed59e1d1-3ad86f73614mr225924a91.41.1792535404295;
        Tue, 20 Oct 2026 15:30:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:37f::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813dfa5fsm1123157a91.14.2026.10.20.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:30:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Lamparter <chunkeey@googlemail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: emac: release DT PHY resources on teardown
Date: Tue, 20 Oct 2026 15:30:02 -0700
Message-ID: <20261020223002.1749284-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Disconnect PHYLIB PHYs and deregister fixed PHYs during both probe
unwind and driver removal. Without this cleanup, unbinding a DT-based
EMAC can leave its PHY attached to the freed netdev, while fixed-link
instances retain their registered fixed PHY.

Fixes: a577ca6badb5 ("net: emac: add support for device-tree based PHY discovery and setup")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index e7043523457c..4124a90b18c4 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2810,6 +2810,16 @@ static int emac_init_phy(struct emac_instance *dev)
 	return 0;
 }
 
+static void emac_cleanup_phy(struct emac_instance *dev)
+{
+	struct device_node *np = dev->ofdev->dev.of_node;
+
+	if (dev->ndev->phydev && dev->phy.address >= 0)
+		phy_disconnect(dev->ndev->phydev);
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
+}
+
 static int emac_init_config(struct emac_instance *dev)
 {
 	struct device_node *np = dev->ofdev->dev.of_node;
@@ -3197,6 +3207,7 @@ static int emac_probe(struct platform_device *ofdev)
 	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII))
 		zmii_detach(dev->zmii_dev, dev->zmii_port);
  err_unreg_commac:
+	emac_cleanup_phy(dev);
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
@@ -3220,6 +3231,7 @@ static void emac_remove(struct platform_device *ofdev)
 	unregister_netdev(dev->ndev);
 
 	cancel_work_sync(&dev->reset_work);
+	emac_cleanup_phy(dev);
 
 	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
 		tah_detach(dev->tah_dev, dev->tah_port);
-- 
2.56.0

