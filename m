Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F05304BE
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169683; cv=none; b=CJTyyh5BNGUAa5xT6IeWnfjrYU2wAcYA/9WNQaGdRGuVXNAGuIBUfls1g/OmtE0hjOR4ddQ41n1FDUrY3NKj4eI0xZe2eYB2RHgzqkDoafGmkNL5AlismA8Ewr6TeLGOdZYiaAq2x/AqGsj/KsgPlADd3vkb1t6UyyGsgDtbnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169683; c=relaxed/simple;
	bh=ZscYP5Jl3CYCN/ODi1n/KGM8DsiFKAZ7pnQCj8a7dXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCm8uAx/BBHLgJfvdGBIa9d+HiqYhXcAHZ3VKm74Q7/xgvV0KbhhU8X8cHkIbDx0xUCa1U3pFytsbLMkEAarYtw+3pvXszqD13UswVH/FETzLId9A7AttQ7ZFZDDxfKYdWoWQgODyVgYW6ZMTDO4TQHH3/InbFohdsVrF/441NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lqs.me; spf=pass smtp.mailfrom=lqs.me; dkim=pass (1024-bit key) header.d=lqs.me header.i=@lqs.me header.b=Rfm/DUaH; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lqs.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lqs.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lqs.me header.i=@lqs.me header.b="Rfm/DUaH"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so499377b3a.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lqs.me; s=google; t=1790169670; x=1790774470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jA9Ng4lpuxB+WAdNDY2KHfY2L2MitKxI8+kcR8oAY7U=;
        b=Rfm/DUaHx0AWT1pzHvJ8IN5dDoaOXWrqMooM5D6KVQWTZN/nIfedPx/Au9veoAOFSw
         c6rxEUJ5rY6NEoN1nzwUPRbVcVh3DRneTUn7fmarfAPJAS2O6MUeL9df3WvJ9v64n/TU
         JUhtASiC4G50zJYygc8G9nvemxzkHsYQcYMio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169670; x=1790774470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jA9Ng4lpuxB+WAdNDY2KHfY2L2MitKxI8+kcR8oAY7U=;
        b=Dw2NTLN1V8nQx+DkbR9q8AzjSdXqOMDYoH7kLxJK/hdh3RVd/gYUF+ytTkdtG29/t8
         Uba95hZue6M8rTcLL+iuuVafxJsyOCp6ukmxKmjs4x3N3a+3pLxsJc1S7KVWZ2DgvQVN
         0JvnnQ3yfTnMplYiUQn5s5yn3KKqrhlbuw1k58Sf6YDZw/lAwiJF1aGM7VcHs5lT8rRh
         DCUYucQ7+ThcNlVRTb5yhoXBfa02R+IHfXKnMbBMs2zo3IKpRszlZiy3fbZrCXBysmMr
         IDgymXNOVlSK2dPq+e/6hS9cu6bAdsuqa9nJpkdepx01DTQ2l6/YbTwuO2111+hyo3Wl
         wJvg==
X-Gm-Message-State: AFuF++mzBFzYTxHUtzMuRKj1raW1v9tKvGOYZtddqwzPTjay7QuKzOgT
	0JgRKodM3hwGwb5w/vefkJw3DMV1s0jYKYi7YOmuvxC8UlFPTjR49GhcfkjUXkMa32AjrMc4M81
	3BcbvlSMohw==
X-Gm-Gg: AYBFou2bVRwmzarBtMlIOsgAxAIyzhFLUnUiuqShMC3N+I1b2csT5f3gDTnqsNlvDB+
	1HWogvoVQs6MK1omW6RsA5cNQkw7xqA/7MVBg+/1wYWGkFLT0nxV59OK7haaXeHqgHC6jQdcnCJ
	qwhyl6i48R4KHcQvL97AL8c+x0uoAKVa1ACGk2Wqg/cwm3rJwjUI1yNSjLRy1lAOcdP+o6nnhQw
	lrmHP7E4tjQLEfFRzHKk/aFIupouhh9IiGq9QbOfQ7/XxmzrTM3zMFwSFe/dfWaHwvr1jqMWifz
	QXL1wyR+ZFhiYZLkEI4GaOtOu2m+rLGjqqZxnPw3OuyS30KID3yQtP1gD4rW3+E3h0D4b2bADpv
	7CCIqG55CNYCY54+SvtFoY1b7p6ieMRbhOCaMZGrHmS/8ONCwildq8m9tZmWuH5w4m7yKNCN8PL
	aRU9FHF5scuFkN3xOGGBZGrG/zMxy+Opw/TcSbu/7FqjgivuYg+3DHsuWIAmXed2YhBHyk1q8zp
	79M9dCkPFEIO7A+5lTPBJuaIDvENHMnFkLhZF0JSi3c7mTC
X-Received: by 2002:a05:6a20:7290:b0:3c4:4272:b400 with SMTP id adf61e73a8af0-3ddf7e7f980mr2531871637.18.1790169669529;
        Wed, 23 Sep 2026 06:21:09 -0700 (PDT)
Received: from localhost (59x87x240x206.ap59.ftth.ucom.ne.jp. [59.87.240.206])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3ba829sm1081450a12.11.2026.09.23.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:21:08 -0700 (PDT)
From: Qishuai Liu <lqs@lqs.me>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Qishuai Liu <lqs@lqs.me>
Subject: [PATCH net] ipv6: fix prefix route expiry in modify_prefix_route()
Date: Wed, 23 Sep 2026 13:20:48 +0000
Message-ID: <20260923132048.3272878-1-lqs@lqs.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modify_prefix_route() is given the lifetime in clock_t relative to now,
but fib6_set_expires() wants an absolute jiffies value. So when a
permanent address is changed to a finite valid_lft, the prefix route
ends up already expired and GC removes it.

Steps to reproduce:

  ip link add dummy9 type dummy
  ip link set dummy9 up
  ip -6 addr add 2001:db8:9::1/64 dev dummy9
  ip -6 addr change 2001:db8:9::1/64 dev dummy9 valid_lft 3600 preferred_lft 3600
  ip -6 route show dev dummy9    # expires is negative

Fixes: 8308f3ff1753 ("net/ipv6: Add support for specifying metric of connected routes")
Signed-off-by: Qishuai Liu <lqs@lqs.me>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9d89be7e0544..c90ee6dd7446 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4874,7 +4874,7 @@ static int modify_prefix_route(struct net *net, struct inet6_ifaddr *ifp,
 			fib6_clean_expires(f6i);
 			fib6_may_remove_gc_list(net, f6i);
 		} else {
-			fib6_set_expires(f6i, expires);
+			fib6_set_expires(f6i, jiffies + clock_t_to_jiffies(expires));
 			fib6_add_gc_list(f6i);
 		}
 
-- 
2.43.0

