Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575116;
	b=uZUipltwJbTgojFo3xtlZWiok1aLFWZz/t5lqdgD7hoNXcszkahB/YvNTzR1i+xjzO66
	 Z3cSBKi4zT97HGBV828x9ORxAk41yDYBvpM47TM/f3D9uON1Gz1HHbvJkzJ7zM0C3QJ6u
	 A8x5Q375ZMcH7eblbxZ8Y5zvnIgwloiiUGOcvw0PQZyT7374pAG3v1qd0paaPZDVtjNlF
	 cUZrf3qE3EYcB0UqbmWgQtlvXuAfRFRcH0HwRkZeBWiy/znxkK0hTPossibRWCK88m+rS
	 MGmwMmQSlHU3GXpTQEhy64hb+1Wgg7U8Q3j/kJlX82muLhJzOwdzZJ5f97wt/6B3Xqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pv4z+EGHs55+YETm9Uv1vhzwGShZ+7nlSwaLJI5dR70=;
	b=4ngZZ3qRkf/id729IS+saL+OgiPTqiIrfiawbkSRImeRsTKOZfoKDqiw/LBAW8QSbRHJ
	 PSOUIIjYJxSjeLtzJc6uGzvamTQDnE17zoHvNw78J9JngW10m66sm9QeKZtAeS80QuqlY
	 Uh7vX3IUcAahTNqokNJ2QiWd63RGY1iGjpYM5FZA/bnO8b73jp0RjwE/KwOpDnlnxNJ+A
	 e+x4dbGa/Z1BnjK+/y/EiJ9QWwh8cULq4QtSaFGwcWHD0BODhX2kRpgCty0Jxrf7KlIQs
	 I2byNYeSF7D907SYZChjMgro80qJ3S4JNbi3omngCMdXi/mgSNSc0s0IWFZEbYQLTNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDs4nbx5;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4D606A88F
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F4D606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDs4nbx5
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so421832a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794575115; x=1795179915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pv4z+EGHs55+YETm9Uv1vhzwGShZ+7nlSwaLJI5dR70=;
        b=pDs4nbx5YIkcv5EMWzVzfvxBmiRCUp045RZJDx+PGOqWqq+ScZGwI32/3srX+5mWTg
         oia2KRJ2NPqAd3ct9lmfPzMDmt0OX2F7Bq93M2G87nkHF5+c1hgNQIuExy68qqxbjdT2
         cDoHpXVfQ8iAMIncI7xGoVJfo272RobJ5Qr2V/bsT/cyAImf77TJw/fSya6fe5BcEIyo
         /WE3a2fHbxNalwQUprAphy9/9uOrWfEs+fzLXf95g8vXg1iJ8UdFal/C9DGD/aFS1qJ8
         ARU7cMIrKh9mdJcV1MqB4qYOVsqOT5zHstlvwBqnvqC/6DaYTcKZw6JbXKI65n/KDLxD
         e+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575115; x=1795179915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pv4z+EGHs55+YETm9Uv1vhzwGShZ+7nlSwaLJI5dR70=;
        b=cyeT2yeI1n8w8Ai1Gw2Jgp7j9NsJpHZ3NcSYmIpAq04tir1nL+rBDRhpUF7bj4U2kb
         0U2mv0fCnRNdcnN1wCQkeKa+uF0c4oKKZFpCEBOXKRgg/WvkRbFgekqijB8mYNvMWepI
         V9Hg2cRkRWnMXfsQ4frx46WKR4RabpJhZwUEVaFAn4+HMb205tFeJqnSUChaSynxuDHg
         NrgQzO7K4S2HYNNDH4BduDlPhUjq0NTX6vU8bRWoSNoKqMMJVzU8YlAirWDpjbeCcFcw
         KF9mwyDYKldTAca+FQDfdT6Ljc01y7i9soR0KjOMokRidyFnyk6GW1lvaJTRY4FzDKU7
         1TpA==
X-Forwarded-Encrypted: i=1; AL+hErHhyGjX3+XW7BVuMQr1x0SQmKb6HCfHrkLqGnYSqC8aWZFYd6keym1E8aDElUR1sktZouI+TeU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/06twvv4VznfxphAEg1V/LbQUdm2MD6QGIKIQIXeRjl5KZW6O6
	DVFo2VEBE0y/yEwBSFoyKThZcjuA5HWALsKM9k+ovYOtMT1EP6FVfT3W
X-Gm-Gg: AYBFou0lAEh/WXHHRFJjcQwwroTApYzMMrefRZsZzJjcgkMgyq0DPcLx326pBjmGmV6
	19WDyMJyCun5RUvsYDv/TI1/7L4QIBaqELuDplstxQKgGdXD/tJB6/EfHvk7IvsCcmhfBeOChFj
	1LUYvRCh02y7f0F/iFS/mdof8V0ppzQb98d4v7z0JICxg+JH034hl0UNNMufbffSvm2RPlsvxke
	ln/ucZj/FR82V97NkJOWaCtkDxQaPLE6fz1uTyAAOlMwd0tX4eyCOiDtTLOFb/or2eDdxB0yHVW
	OXIWn8SHBmrYokAVXaWTvyvYhiV75nFV9evZnhmv4LFHxiMhEEKkC7jrJTe6QWLNbFXKMVeq1sU
	pyY3NCFNQidEPdSC/YmCudoyucy3QjrSZOtwCWb+zZQiCdSehUE7nxpcJP2rbgmEHe6LN+eB7mK
	SYy8qewVPjZjM2d7az2vHCuxmKlpm2sZdtnBVZoRwaaNvZpJlntFzYXHqCbwJ/OYbgyvAT8zjWJ
	ZlF6+0wVxxm1OK5NYIEFf8Fyk/cWbKxgfCwrTCEB5vx4UocIWFPJVvSxEA6Yvth2FMRQTDwfI95
	3cjz8OM9YDpgzQiGRHmMANM+loja/GGPxJjNG/R1A6tYhLGzTmPBobXGjkCoKiqnmzrNxY9Dxos
	f+uS/18dmYxQMCSEIJo4=
X-Received: by 2002:a17:90b:3148:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3b1b07ff58amr2210632a91.6.1794575115173;
        Fri, 13 Nov 2026 05:05:15 -0800 (PST)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm9916729a91.7.2026.11.13.05.05.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 05:05:14 -0800 (PST)
From: Lin Jiapeng <ljp1205831794@gmail.com>
To: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	sfeldma@cumulusnetworks.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Jiapeng <jiapenglin@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH] bonding: unbind 802.3ad slaves on enslave failure
Date: Fri, 13 Nov 2026 21:04:40 +0800
Message-ID: <20261113130454.63032-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Lin Jiapeng <jiapenglin@tencent.com>

The 802.3ad enslave path binds a slave to an aggregator before publishing
it in the bond's slave list. This lets the periodic state machine select
the port and attach it to a LAG while enslavement is in progress.

If a later step fails, the rollback removes the slave and frees its
ad_slave_info without unbinding its port. A port selected in the meantime
can remain linked from another live slave's aggregator, so later LAG
processing accesses freed memory. A test-only kretprobe forces
bond_sysfs_slave_add() to return -ENOMEM, after which KASAN reports:
     BUG: KASAN: slab-use-after-free in ad_agg_selection_logic+0x1a0d/0x1fa0
     Read of size 1 at addr ff11000109be946e by task kworker/u16:0/13
     Freed by task 110:
       kasan_save_stack+0x30/0x50
       kasan_save_track+0x14/0x30
       kasan_save_free_info+0x3b/0x70
       __kasan_slab_free+0x47/0x70
       kfree+0x1b3/0x550
       slave_kobj_release+0xb6/0xd0
       kobject_put+0x17e/0x300
       bond_enslave+0x1acc/0x5090

Call bond_3ad_unbind_slave() in the common rollback for published slaves
before unlinking the slave from the bond. This detaches the port under
mode_lock and preserves the invalidate-drain-free ordering used by normal
release. Successful enslavement and earlier unpublished failures are
unchanged.

Fixes: 07699f9a7c8d ("bonding: add sysfs /slave dir for bond slave devices.")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 drivers/net/bonding/bond_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e9f5e753f677..60cc9a6a4fc7 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2355,6 +2355,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	bond_sysfs_slave_del(new_slave);
 
 err_upper_unlink:
+	if (BOND_MODE(bond) == BOND_MODE_8023AD)
+		bond_3ad_unbind_slave(new_slave);
 	bond_upper_dev_unlink(bond, new_slave);
 
 err_unregister:
-- 
2.55.0

