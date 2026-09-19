Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C5391E73
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854771; cv=none; b=IRLSc1saI/v2MEkB3cgBx2+tiBe5vVUIHJ5XrVQdqCgdQIIb/RsXgFi9aHF29tpCBa8oA9H64wykqtIwSC8e1PTJPb/3e6mEcA9bBNuz+JTSzPhzqXs49JU52MJIFjSQQIh673TFaCqqzPuGyB6h1iFBRkOoiT2x8IXvZx8kOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854771; c=relaxed/simple;
	bh=ok7q8RjuE02Bww+2QvSjqNtvkMyCStknUKyLWbBaTyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfAS9JTxQmuBIzenj95Uo+y3Zc1PDRrOdV/ubfU5tkprS+ShTMZXCKE8bpOBpsjP2pdpG7emrGR6LuKvD5985+azpt6lQxjKqg4CjJk5yzVetCn/F1Wa4Haz9X0huDdl4qtUoiOrqath8I4jPDSTTUqo4G1tNQPIV+ZhV5X/Fl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwXrRn6c; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwXrRn6c"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed6d6eso18528745ad.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854763; x=1790459563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cp35LkaPgGuGmcugrLJDe3EFri8Cdl2WjJc6hIpiryg=;
        b=PwXrRn6cQlBooUIymKChwIp4+XG5Gw6XmGayioQv/YymQnxBptgc9e77iOSJ2PipL5
         dqJgc6xz6QTUkcGOPunig3s+D/W+89ajnwtsg8ntizY1qBDVP1styBx+4gBF+D2Y3pPj
         W7yibt025sqDOPNQz19Ac4tZ/zKEwFxUQfQ708Il9Tq/CZ/+jtcNEQPZu6dff32mTzQC
         WgAK9H234C4VnQtFC4nlAQyxa3gjQVIxXFDzo60w3TiIVz9ivVYxh+/aSX6Qq4lEnPOA
         l7EJf2pGe2gZCCRkWJbllFvlHXOjv7huQj4GbIoOvGb7WhOr5foSFIE4P5NqG1JcL2Gs
         zmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854763; x=1790459563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cp35LkaPgGuGmcugrLJDe3EFri8Cdl2WjJc6hIpiryg=;
        b=fixefVkn8YFVCodSAZh8guzN2J9tm4Ek9wmjQDJstG90xyGwc9vQlka/g8PyfLO1Bs
         k0+hh7UKdUWGd8HeaUFbQX6KgRNxxQ2QzjWkYupPy6AnT81631Yr7IoCv/mO1fqpLDle
         /rL/33axFNGeNorblwbGxt4Y/j1DDd8Lo3cqn09KRezIF2KCQPbJwA9MgwTrRDv/HnL7
         koE5Jb+Hab5q/HcwWQlFsAZQbD6ibWnFdqp2L8wesJwo67mOkC6oHTDV0XtSMK/SM69F
         uwxXtp+MXDnE+AU/OvaFG8uZyxZEMKkDCaM+jrX2EcGZv+YoMVR4IAhJlaH7xDNyDDxT
         qLKA==
X-Forwarded-Encrypted: i=1; AKwUvBxUlC7ovDNpLoGf31D0Mvj3Qe4ZVISfgPGz+PUKLJiN6i2Ivm1wEGLguQhR7ICh4Zn8moGGXoU=@vger.kernel.org
X-Gm-Message-State: AFuF++milDmrx+yZd8uFpB96mod6Rpr03Lysaf6GC9Xe63p/5I/Iiapu
	oKCLm5tsRyoSoVZRcjEXhcr3kam7W4RzeKyJQF2x7vYZ8NjsOKr/t4Wb
X-Gm-Gg: AYBFou0yLCacJqbdsjbFDZZ2l9bZenGgEyJexstzwVBX4cW3H09aOmrKnS7/5ZdSCLg
	wgti4p40doCMj4PhCfudzdtb+vtllHdRTTiztdQnErmbWpxqJ5DzQkUvuZwPbyc8MiCmoE7+TH0
	EUzrdqHe8d7CJgp3CHqYi3jIeBiCVeujk0HduamFJCMbt9jqn37qfW+9IcS3GLTyKkM9DQg2Xgy
	Qyc/gDcp41Co5YT2WbygY02PQgleraNny4jIwy1hIqnCrAWRNqphX2ghe27hNh4Xovqllk0HHHp
	rOKRkTYPpsuVQlRkv2DhhKXrN7FH2iNlze0m98wXSu0K5/56/pMp544eysVLPp/xsRT2pwXfAeh
	PTxnQ9fPn+tOmfLQqXjuqT1y65CESVMtUAVzQ+0Ov3/YhFiI826iEzutmKwZDDIyzLtNpczY3h3
	tsWgj2XUPKMxJ3cI9ZbBUTNoCTYVcv+CdS91/6U4816mHhreJHmoQ9Lk/NhEzTiUUcXAh/MBBra
	TGjVIq6UnW50vuV1vvSrG9EX9vFAzxD2k0+K641WJPQzsfKgTfHTrJ2hKM88xsqR2e0YebJhv7E
	CtTyLQqQ0Q==
X-Received: by 2002:a17:903:2343:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2ddb1ab24edmr114324035ad.5.1789854763351;
        Sat, 19 Sep 2026 14:52:43 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df3ae73eb9sm3264875ad.44.2026.09.19.14.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:42 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: nf_nat: fix unsigned range_size underflow for ICMP and GRE when max < min
Date: Sat, 19 Sep 2026 21:52:42 +0000
Message-ID: <20260919215242.3471883-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nf_nat_l4proto_unique_tuple(), when NF_NAT_RANGE_PROTO_SPECIFIED is set
for IPPROTO_ICMP, IPPROTO_ICMPV6, or IPPROTO_GRE with max < min,
computing max - min + 1 in a u16 range_size underflows (and wraps to 0 when
min == max + 1, causing a divide-by-zero in % range_size for GRE). Handle
max < min gracefully by swapping min and max for ICMP/ICMPv6 and clamping
range_size to 1 for GRE, matching the TCP/UDP/SCTP path.

Fixes: 203f2e78200c ("netfilter: nat: remove l4proto->unique_tuple")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index a4858c2b2d65..83f4eb63a584 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -575,8 +575,10 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
 			range_size = 65536;
 		} else {
 			min = ntohs(range->min_proto.icmp.id);
-			range_size = ntohs(range->max_proto.icmp.id) -
-				     ntohs(range->min_proto.icmp.id) + 1;
+			max = ntohs(range->max_proto.icmp.id);
+			if (unlikely(max < min))
+				swap(max, min);
+			range_size = max - min + 1;
 		}
 		goto find_free_id;
 #if IS_ENABLED(CONFIG_NF_CT_PROTO_GRE)
@@ -596,7 +598,11 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
 			range_size = 65535;
 		} else {
 			min = ntohs(range->min_proto.gre.key);
-			range_size = ntohs(range->max_proto.gre.key) - min + 1;
+			max = ntohs(range->max_proto.gre.key);
+			if (max < min)
+				range_size = 1;
+			else
+				range_size = max - min + 1;
 		}
 		goto find_free_id;
 #endif
