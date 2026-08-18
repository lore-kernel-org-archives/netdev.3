Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAC3AAF70
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787020634; cv=none; b=D3YuNVSK/a98NyDRSzYTH5xntXn5wAS6yPo2K2zx+VWjDEbnj8K4RPjtgFkP0mt8JYceeUsm+4szwnwG68mKAHfD4I3/u/Vda2wPU6kHy5/F793iD7lK6nW4MB9AsesZEm17Rj8nhAezTvc93OIWAxC0WmA+PUPI4F+8fv70pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787020634; c=relaxed/simple;
	bh=xTzzxtotF9gl39HUnYyVqOqsYpyusgOxBTbv6wM4zeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUP5ShDflp52KmQi1oeANEePWNZARd4wOoNvBz0ea92OyL7TAKbMsMWSLh/YvbjWA3Hgef1zBXWWlOaMFHLGh8P3ZRBBv/QTtU0m7yTsfYMe/jTa+WSD9sZ4I9vF3j9g4upYKzq9F1tXr5m9vcM/dxI4sJopT6YFAhf718hepVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1O33O+l; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1O33O+l"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso4212896a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787020633; x=1787625433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5t3WSBXQEgnmVFFBRODA6+TTnt+X/iUBw6IiaqKbt3E=;
        b=H1O33O+lS3MXOuFduB/7EfqxpvuhA6ZC8xPrIEI6/ALUsmrRYG2zRvo8rbS5Ht2RHk
         cqymisCQeh4c5ZM8Jxa+ihLj9tmyvaWfT7VGxs/P94EhHbKNqik+2cfz8a2EyGsIKotu
         DiYZcCrsdIBoPEw2jcwpWfoyd6TtCOXZpiwJKL0tlYESmPVqyjmOQ/7ixzYQhrkGCBVp
         e6zgwrTztwiks0CnWRPDjNUUIO3znrxCge/6WqHBKuHpIVPZ21S150nfNoH3ro0J7lEQ
         tuFx8uqEW2zSrM/6xPSUrqPY9JzARKtCnux/tTC0qhB2KwTAwBk4BoIdryXo52QJwgJS
         /iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787020633; x=1787625433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5t3WSBXQEgnmVFFBRODA6+TTnt+X/iUBw6IiaqKbt3E=;
        b=gPj875RrtK+EfWZGGVgKrdAmbD+sfzzSQEChZSbXTmlUw89GQ/5/ytXmEb/6AzVZ25
         aq6IkP79l2tL8D/cP3r1LPth7+svAfW+plfEHHeG6hNXbMb05P32UG6zRj2o3+UraOYl
         p8e93KT64tWk+gYES/aN3gSkA2W6tDZCJfoBKB751L+wPAJJ6LID5zLnRVISS2HfREUb
         6hu8umR9CE8DrB2bKXuhYdxBrdCkusjCBE8DzrdlfYz+22Dfapd3Eu8rheHenFyAyzHv
         j7fW6qon3mJiZpvUQqOHpF/foLJ05CnrL60uK1mG0yv07aIj7i5H88SJd+brU8igObK5
         Xilg==
X-Forwarded-Encrypted: i=1; AHgh+RqRaHlIN6S0avLGEIQvHxZCXwMshzsH9v8GYwK2KjOnhKBC+2gIQS4n3wG46aWF0dQWKv7rPf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLeCiZdurDjErsDOcPGbYnJIP/e+JCiFOExaVnH8KYqxDIPraR
	knZRsInj1wXmRMyCd176FK8V0aI9BJycZvgayhpoZFMytkFHipZha1bm
X-Gm-Gg: AR+sD12OKzL3LVmcAOKhdxEnhVTgyqX3CBAt7X+n0O/qGGVw3w2Q+iyfK9UuSaIWWmF
	yGcjf0FStK6Yy28Px6WA/MEhpAtm6I9cCvq7nybkz/fgSas0a8xv4hEdBIZAA4nacTC0PZ3lwCv
	y3aRWrclixSzaHsXjPxd4Gu1gGDmRk5pj6f7Rp9A58SASA/vmax5EYZ3dW+TBiq+TuFFisI7dbp
	3MDUxP3XsOfZqnLDnyh1Vft8+1aZiGWAaIxVrSu9h/RS1XejpcKHgV/TXmKYK3hVfBwXIRlEQMe
	sy7y76ZWcSiyMgP8cylP1bARznX/G9xmAM7jdHWtjI0NTH74Lk+fPuWlUVSDkegSESZ6VXtDa0a
	nRRLAbsAJUvArGQog+kTw+/a3yvRsVJMOGr3YEAmWjuJ5NlpdRnD02IcG5lF/7oRl3rvzodR6PA
	PbqLa4fV9sPignk6A8R/wqjztIdf7HzUSICEmug/4q1By8av2SbmP/N65yN1VHwLDnpppTZ5qeV
	dZcoZxaLTF8
X-Received: by 2002:a17:90b:1c0a:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-3933b8721acmr25288593a91.12.1787020632627;
        Mon, 17 Aug 2026 19:37:12 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e8418bsm7009248a91.7.2026.08.17.19.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:37:11 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	zhanxusheng@xiaomi.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: [PATCH] ethtool: remove unused __ETHTOOL_LINK_MODE_MASK_NWORDS
Date: Tue, 18 Aug 2026 10:37:04 +0800
Message-ID: <20260818023704.125721-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Added by commit f625aa9be8c1 ("ethtool: provide link mode information with
LINKMODES_GET request") and never used.  The same count is computed as
__ETHTOOL_LINK_MODE_MASK_NU32 in net/ethtool/ioctl.c.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 include/linux/ethtool_netlink.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
index 39254b2726c0..15881f34ef66 100644
--- a/include/linux/ethtool_netlink.h
+++ b/include/linux/ethtool_netlink.h
@@ -7,9 +7,6 @@
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
 
-#define __ETHTOOL_LINK_MODE_MASK_NWORDS \
-	DIV_ROUND_UP(__ETHTOOL_LINK_MODE_MASK_NBITS, 32)
-
 #define ETHTOOL_PAUSE_STAT_CNT	(__ETHTOOL_A_PAUSE_STAT_CNT -		\
 				 ETHTOOL_A_PAUSE_STAT_TX_FRAMES)
 
-- 
2.43.0

