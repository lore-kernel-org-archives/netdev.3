Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77A395D99
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319311; cv=none; b=dAxzvhb9wkBrwHg/KLCzg7QoevTyEHJrOU/S9hmU7KHY88KAvZO9LjPgbbjHQoK5sGQLKqv8stjlkZE9KK3RQ2WLKzfjRiDObNTpSnnePN1nd9NA+Wyk3o7ZtmW1ONZGh1g+rBeKBaR2IyMIFYvAd2m9EHKVRq8EmnyXriMhQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319311; c=relaxed/simple;
	bh=fKe70vqmsSB7Sbpqp5Pwa9y18Qh7KEsEmm0Uen+uTFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OV0jGc9aMWMGo/DSF4K87mGdxPe60F5ewmMlN5PR8VgqJDUhJmTMmYk5wNEJ7Y5KaccxX1ZEs2kj8V7V9qlr9nrpKzPwqfbJ6LqrgvizuZDZda8OiaC90ing+wCX4GLE3qbAHUH6CfLc8my6vCM6thsrvrx8Jc+3y0IlzSAZPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG5YIEJr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG5YIEJr"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c2ae992beso487583f8f.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784319306; x=1784924106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9VRQMdG5mh4GbPjofS2MPnVG7awxExT5N1bUTExBEM=;
        b=DG5YIEJrcxqgXQuqgUTeekgqShXDHiGBfC7aElmm2s29YVh5VARPP80eTO1OQuziIJ
         n0LXuU1OYUen7BA8DgNSFxf34Tw6d2wgRbNWv4KwqIBSK9gH6TqmWKhMa2AGNxEHZlxr
         WvmX8yByXVD01yVyrWzFFsp4eg1GJdi6LafIv7msdJKpCUGl/Ks4CC3RgaM/ZvR47Tpp
         gGGHRKkxJMniDBGXbiTWrqcCxzNZ4ntjrPjPtjsdViWeN53ljiTREPbuvMvS1wVqMkRx
         LbLJvh3zkphxBM6dMXC8OisEFU29jp0r7A4FfDaf1jOEPWBXM6gfIh0PvjIp0ZBDY5jU
         7wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784319306; x=1784924106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f9VRQMdG5mh4GbPjofS2MPnVG7awxExT5N1bUTExBEM=;
        b=Z300K5BOlNkwToegUAWlY/BZqvs4uTCyUFIk8bJ2vjl9jXTlj8zYGGoEYSYCXN6AEX
         Uv/zjJ2ICVkjGEMi8mGoAvPSmUq0PYdreWy6+y94rQ70tC/yRnOYyd6xAB0m1aSLhaiG
         rMXYUK/T/625uV+TzYnc8nxUDpVtofuC83WxszAzZFUZjPFts+8I+M2TUDECeKSocpKs
         uF8RHlUAlNbh+7Ys2v1UPnfVBsOHYSm5Y7ciMID5ad89dTOmAHHQuCITqLCFlNgU7LKe
         ezwmq4huyvcuNpBVpxiL9bEqwMubn9lTKC4uiY6B7cPndthf9M3eMwun52OLlbiEkv/L
         t6RQ==
X-Gm-Message-State: AOJu0Yx3ZqQ/XMDNgXSTa+53dIyD62qgLhwoRtQWjvqEKCLdI+5hAeQw
	p1CXyP9RfQYgz74vaiko0iVdA/pZBAmGO2nYc7Zxy4OFE3sVEnI5Dn3vuvEm74vy
X-Gm-Gg: AfdE7ckAqZjFvfNJGtISU0ix3p3U1IBtFLqj7TElSKo3ki83z2Tf8h13JR+KYzaMGaa
	0aCbSnQ6/d9hYzjs6/JeHJO8tB9ARGb5i7yIAsgorWMabTySqTMgeFD7Fn8Ke0ZHaIcMEcSg2VM
	Rn4WFO0UzapMUcNPA8ZaueebgBuq84MfOjMb7Ec8dNAu423/3PBlaaWdwEhYf3NksPaBqYJmi7A
	evv+JD4KjViVIjyjO0CQkJdDHbuwD1uNGxJKqBlzxaqL7gfwGJm2yMWSJShvDh+nrqL2CKnDFbt
	AuJ8MkN8ybTbc+7HrI01lumF0XagqSAm/xii0tvcrjTI00DcTCEvr8AntHHUbf6JhtVf97d6ZkO
	vaft22yZgKpV/0HfvlaY0Af25HcUaW3JJf4bjysDqPtzXBCXiqSa+FwDDqdyyIHxHebei0RypRL
	UvM9gG0tF+lS241UcFoJIfXLpuCv3Sxo2z4AmQ83G5IgKItGzxf9hV9WoywtPD1RPLK/w0vvdTl
	upBI39w1PHUEJaTwNCQ8DhwTub0axOEIOW3EIg=
X-Received: by 2002:a05:600c:1f8c:b0:493:f7ca:bd6a with SMTP id 5b1f17b1804b1-4954a50d080mr27318195e9.8.1784319305927;
        Fri, 17 Jul 2026 13:15:05 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-077-126.77.179.pool.telefonica.de. [77.179.77.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499a5847sm53179335e9.2.2026.07.17.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:15:04 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	wsa+renesas@sang-engineering.com,
	jie.luo@oss.qualcomm.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	fmancera@suse.de,
	bigeasy@linutronix.de,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next v4 3/4] net: hsr: allow PRP RedBox (interlink) creation
Date: Fri, 17 Jul 2026 22:14:56 +0200
Message-ID: <20260717201457.54-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717201457.54-1-xiexinet@gmail.com>
References: <20260717201457.54-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the PRP interlink datapath, duplicate discard and supervision support
in place, a PRP device can act as a RedBox. Remove the rtnetlink rejection
of "type hsr ... interlink <dev> proto 1"; the feature is implemented
unconditionally by the preceding patches.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_netlink.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 8099f2069a7..88940e8014b 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -121,14 +121,8 @@ static int hsr_newlink(struct net_device *dev,
 		}
 	}
 
-	if (proto == HSR_PROTOCOL_PRP) {
+	if (proto == HSR_PROTOCOL_PRP)
 		proto_version = PRP_V1;
-		if (interlink) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Interlink only works with HSR");
-			return -EINVAL;
-		}
-	}
 
 	return hsr_dev_finalize(dev, link, interlink, multicast_spec,
 				proto_version, extack);
-- 
2.53.0

