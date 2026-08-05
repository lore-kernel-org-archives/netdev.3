Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E846F4BE
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936418; cv=none; b=i0YeWePkcxdFvlS9vVZjtCNZlvGbGmLdpusMSm6uTHY2jlkBM7hwQ8Tmrxlh5CPwTiu7BpLNEf2kGbhYxlRjQKf/mHUCNzn7bvaoFzFCcKtX74KC1v4GSha9Vtw82/pEB7SBXmpzi5m8gMHBsmFZSjJ96/PZHhCY/Cqduug+diY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936418; c=relaxed/simple;
	bh=KOlvn9KLgNOrUC4aWU+rneHxps6VoGtGDWKEGWMf8EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS6KTBTttLjSzpGn540y/EGrt/6Ul/2z031D3PtHpMJ09Y+RbLLVOYQyEwGkSNAZTqzCm8E0A2WNVNWgckoo4VgBEoCTZ693KDGadtSbSGG2qXl0+szT0t56E+UvS4OvEqoyjU9WN80VuKJYfivS9Ha2AatGaW6UoWsrItJDPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLas026N; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLas026N"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38deea72eebso817912a91.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785936417; x=1786541217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xsFym2wB6sfkREOLcuGpzPcVf1eCsaKWwrcVrgYBab0=;
        b=NLas026NwpR2Sb+0YLZLrJfai98stU121xSMsYgfCPuthF3ODb4FoBtGu+GckZw9Ty
         n5YKx2V1Q75ZYBS8QWYrM6arCoAomRZg35+n6fsgz2xzJPN+C/48Hg0WMayGVCzJZbaE
         D87mcMOuXUKsOC028Qd/MePU5XEOkWOBQnu35kDtwFYRbOq0FJOZsKIJpp82urJc5nyH
         EYyN/OovbTi+tNm75xMfkwNorbRe8clnmGZGtjcMScwRri4Tel5eWjUd8Fahii9Wie/V
         Gk/kO/0i/EColEJV+/K90LczXnUo1ezkaVRWzc5zsSoFYmdluJf0Cn8geyhRAktZXopl
         CZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785936417; x=1786541217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsFym2wB6sfkREOLcuGpzPcVf1eCsaKWwrcVrgYBab0=;
        b=EHl/wIKnqkZfPsTk8QqlW9YZxNtopQiDFd7kIoEYnCZ9Gx50drGejfK82BVNFxe7MF
         /UF5CubgruEpu+c86GOBLRna6JRwZfEppQEFVLWwH8AZrunHEh+uBpuDELDp56UCB3Sf
         z/sHH5TfaJn+U8UYHrd/MY2CmGEShcdEPBzMsgxFwC09QFq/OaVmBUo3Vi36O4xwv0Sj
         +7S6OkAt6Zz6X/QtvSQSO0RKDGZuteThXAXIjcg5ZFX62SM5FDnSsjntLtjIkszJMB44
         E2g3Gk0xwQ2z/nro6Y/QiguBcTgdy12x+iROmxAia4FVMr/LWPC1btol03Uez9cw7IjW
         TXKw==
X-Forwarded-Encrypted: i=1; AHgh+Rrdc+UNQU1LRrz0Gv4PtiZ/H3wNDX7IFubBsSE4FceO1CWB9lvuCc8Sg4t6LoYwoqS3iOsoEaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmg3iNRZxsrcdEsiG6V2IXjU9YHG1BmyGNOZkdnnV2mRS29Pnj
	zrBneN97DXdXjdXn2N0SKC+m1hd9MsKv6BnUzlcA4mP70ztbPEAPOgOr
X-Gm-Gg: AR+sD11TseoROrCSkkzXFUGlIJ5C29IBqp7i/BIWH9Q0iA1v/saeTKWVE7hrBArIjmN
	DeSKLXa1IZ6k/buNyIWikwYUtACI4oVehajiOR/v1Q/cyBXOQYL25P4tJhhm2VXBiN9WE8Esf0O
	7c6PiX+lk4P7GjQr4ctHQTKeiVpQpmFhex3uKRN+0KRMlPxDLmW6JnkLT3VwBWY4QPzPlrTBdL6
	GhcLJeePuGQZ1anzpZtJKgXCVCsBVZMz6EWGaqf08utuFpDMOfwqk/tZIXCeCQl0v+g+BVw3twL
	u1lp7OylNsdFZBsoRQRBVbEFR1MfIr1SBs2StLR6Ldkw/cv6+F+v4kcOb7Kq3qbgoejNnjXn8Kw
	OhVyawQs5e7lQ27UCbdYNQGhwf6CF5o5OBE7U+ztExh+3MDu6QhIXP6NP5RLUzDf75qo+L/2OWb
	LGT+Pwr6cy3iZW03vTSj2mHi5uMVV+xUyjoTIv2GVD7sOcNAGhDvQRn16Ya107oMDer5Zu
X-Received: by 2002:a17:90b:3f43:b0:38f:57f3:4dc6 with SMTP id 98e67ed59e1d1-3903c6798bdmr7804649a91.21.1785936416848;
        Wed, 05 Aug 2026 06:26:56 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:ee23:9c43:db25:effa])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca9111b6sm14107231c88.13.2026.08.05.06.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:26:55 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
Subject: [PATCH] io_uring/zcrx: reject netdevices without ops lock support
Date: Wed,  5 Aug 2026 18:54:50 +0530
Message-ID: <20260805132634.12646-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a71f80c.40259c87.584f4.04b9.GAE@google.com>
References: <6a71f80c.40259c87.584f4.04b9.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

zcrx registration can fail for netdevices that do not support the
required ops locking model.

netdev_queue_get_dma_dev() requires ops locking support.
Calling it for devices without ops lock support triggers
netdev_assert_locked_ops_compat().

Check netdev_need_ops_lock() before accessing queue DMA information
and return -EOPNOTSUPP for unsupported devices.

Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=a78926bdac2adb52dc0e
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

---
Testing:
 - Verified the reported reproducer in a VM.
---
 io_uring/zcrx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f1464ea8ca64..2eba7d4e4483 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -17,6 +17,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/tcp.h>
 #include <net/rps.h>
+#include <net/netdev_lock.h>
 
 #include <trace/events/page_pool.h>
 
@@ -828,6 +829,15 @@ static int zcrx_register_netdev(struct io_zcrx_ifq *ifq,
 
 	netdev_hold(ifq->netdev, &ifq->netdev_tracker, GFP_KERNEL);
 
+	/*
+	 * netdev_queue_get_dma_dev() requires the netdev ops locking
+	 * model. Reject devices which do not support it.
+	 */
+	if (!netdev_need_ops_lock(ifq->netdev)) {
+		ret = -EOPNOTSUPP;
+		goto netdev_put_unlock;
+	}
+
 	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, if_rxq, NETDEV_QUEUE_TYPE_RX);
 	if (!ifq->dev) {
 		ret = -EOPNOTSUPP;
-- 
2.43.0

