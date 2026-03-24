Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D13382C8
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339781; cv=none; b=IWfNp8rlmBBHK3ieV5AJBVFgvG9NtoVHSagVFvoIPunkXmKcmSwDPQ7OXv7h5T2MDxRRBjCbZNKow/7rQksz5S6HO9h1Hpf6RFTxDjoo+/mvxZCfVdeTmYkTda4yqdRAzlASOND/gXOc2YvGRmYYSNwAzPiP1QBe9/4r5J5fGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339781; c=relaxed/simple;
	bh=uUjzgoMGyXNZJ/A6a6SMtJQvn5oWJoqboZciUy0mlcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zwtbi1ZY6Onj8bY9DpN4AE+sjQ4cdoCjcQiGJXt9sj6NLmCWIzQ50MqlctaS54NKwZ0p8TMnrpuSeopcjLOwFqIBgYSWnJFSXUNhSpZ2/b5vbmT0EJ0kkrIWZYIj2fVoq0SMop8fc73wkFRsQlWDuqE2sBUJuJte9XPAhOUmC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxK/JIue; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxK/JIue"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2853b1f8cso864211e87.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774339773; x=1774944573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f7pTcS/XRpG6O2bwm88mloQEdUOQr6UIgEUkrvYwL0g=;
        b=TxK/JIue4KeOYh0UkcAomb0+wPhv8cWzn1goWeBIxQDM0o1QtIQzGWbLX7tNqTNm4F
         jQtAt2ZX8dI4NqoyGqt4NUwcKcmztF0z0NMvW+jzn0vez/i6ikuHsy97AKXwJTO/oqob
         hEAauRB/tHS/+YE7OppQl/F9ImeNHc/+sZbZXHszDQljyn7pNPRCsVzV/GzOB5kz7D4B
         GbvY/qyKjjMHgz3i5i8QU+VnvR2IlORos24YvweaRTauoCH/SeTsu+/nHjdf5fkuSegz
         thAtVkADm2esMhdo2VeWQ5DKgL2FguXjgU2pyJEW93bDe9EW+YJLxEgLU351X2mf0v8M
         iTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774339773; x=1774944573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7pTcS/XRpG6O2bwm88mloQEdUOQr6UIgEUkrvYwL0g=;
        b=fXGGvlfoCi1Y61ph2VNawg1eBB6cLLnUdoMV6ECsuGGLOvKQfMgUMN1MKz/8PEiasg
         sl5gl3l/b0zQHNF02bpu9eN6NEP/jZoi0CxMysG4xJoO80lwrVCxKbQfVdRyKuGa9w2a
         JMRxjJ1vsvxpOyR1+sEClnj2uJn32o4GLAsQrzo94t9FOjfltWCt2TySFyyJICmWxXYC
         q+G7FXF/HNcclO4gcx4Pll0xB5Sqef/d9a5moEeoTflizXycsN2qc8+e3BvIVLR5D3rD
         89gTYZgOr0PwV96nlJq/i1zAY0i8znbSwqq4/K7qAzXRt+BxV30CgzDHN+9B9gR5rN6j
         8Ifw==
X-Gm-Message-State: AOJu0YzOyb3+v0g1V0E5FLEBrjbd974yUqFXKbkrZbrwcBkjz9kAn1cG
	Kx+sB0ZI8f0m9fAd1gADWogUNa/sm5qis1EYEtJnPJPtycq1sx69zlBxsm2Km5lW
X-Gm-Gg: ATEYQzxGF9nhMQuGZvzkYnAhQu5CyTzd5lqjYL7TEp3fjVb2IvSCSfs3oB1PD7wyHAI
	GoAvQus/WA624TeIFUGGQHNoX4Ssu33Z5Q5w3SilE6b4Ehn4UkNDuxfgtwhtfCL/455tT/B6ZXX
	FMtRNtGFB2caIiYsRgqEe4mZhsn/28v/NexmMHkZkbv9y4x5MJmCVSbKQX+HZPPA59XXAMyqfbY
	HtGV7KdO2Xfl5I45RDO93FwbCuPz2riTuZgWmvncVzqpqwdng8Kzzf9V1WyobX5KncX+vj0IheZ
	RAPtdjBQRZgOncYrLUDNgTSYVVIzmzC3Mh0ePD+oWe5wK4LZwtZFCIi9ekP9kSgS1rXKVcJamNB
	9a4zVgme4X9aET62YIfRSIczYpw7hQLBcDxfYDWeoghFVCXY9buNR/Pcd5GqtT8kH04yzQc6pyh
	dshV6IvcmDK4nl4ieHfule0EC+9Q2AcxBnj67pefLjg9A0jnKGdCbnbFybRYvid9FPvL5JPkA4E
	yv+5fCjJNcJAysOVp40Rw==
X-Received: by 2002:a05:6512:39c4:b0:59f:6923:1cb1 with SMTP id 2adb3069b0e04-5a285ae30bfmr5768214e87.8.1774339773179;
        Tue, 24 Mar 2026 01:09:33 -0700 (PDT)
Received: from pop-os.. ([2a02:2121:806:2ce1:42d9:28ba:7989:a157])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2963fa304sm394953e87.27.2026.03.24.01.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:09:32 -0700 (PDT)
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
To: netdev@vger.kernel.org
Cc: Nikolaos Gkarlis <nickgarlis@gmail.com>
Subject: [PATCH] rtnetlink: add missing netlink_ns_capable() check for peer netns
Date: Tue, 24 Mar 2026 09:07:30 +0100
Message-Id: <20260324080730.4051666-1-nickgarlis@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
network namespace when creating paired devices (veth, vxcan,
netkit). This allows an unprivileged user with a user namespace
to create interfaces in arbitrary network namespaces, including
init_net.

Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
namespace before allowing device creation to proceed.

Fixes: 48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifla()")
Reported-by: Nikolaos Gkarlis <nickgarlis@gmail.com>
Signed-off-by: Nikolaos Gkarlis <nickgarlis@gmail.com>
---
 net/core/rtnetlink.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 576d5ec3bb36..f3a7d6dbd713 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4030,8 +4030,15 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 				ret = PTR_ERR(peer_net);
 				goto put_ops;
 			}
-			if (peer_net)
+			if (peer_net) {
+				if (!netlink_ns_capable(skb, peer_net->user_ns,
+							CAP_NET_ADMIN)) {
+					put_net(peer_net);
+					ret = -EPERM;
+					goto put_ops;
+				}
 				rtnl_nets_add(&rtnl_nets, peer_net);
+			}
 		}
 	}
 
-- 
2.34.1

