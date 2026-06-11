Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDDB3B3C11
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162012; cv=none; b=FRthBuN0T+ibPH4KvPZbXJKvAXxo9Aak6UlBLR5/5Y6zsDOMJCn3I3eFBDMShiMouM+Lv/RnX2DxaJ9guYjxgv+qhpuPzg9ELKKgEkD0ZbWu3mHHX+5cATlDPl9Zi9sQ7v2ACApupDVy5SqN+GDcx/YSPonaGRuWJguhbxOYgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162012; c=relaxed/simple;
	bh=lkne1EM6WpIPMx8e4MpL26FHJHdGGWRJ2jTLHd0ZWjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hubXmY3MJHTY232vwr+kxkhUy8xdJmk6A/Lip//xtBJ3wNG8ZuXLCBxoarxlR0/eTNPDn1jB0emJP5J3wZDB1pZntA9EyTwdKFJyA3s90Xtz4zxBhlJ6RsjgyGeexsCod8hLVckM+oyXWY7FjUpedV7KRHtMe3AdVPII61bp9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9uXe68N; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9uXe68N"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7e8b45dfb3dso90699867b3.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781162011; x=1781766811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHOxG2aEVrWsk+iCIk+Omdwp9IYJcGKP+/ZeDWqwKBM=;
        b=W9uXe68NFHWYcomTui40bamyV45FeWELpKIkzeHwOj1yjffhDDKCQyeSI31y9s8NMk
         EzptMfJdr8cNZZPlCG42yZvCUCXLkHkUby0cWw1VELA9nNQaeRWysOGh3RVNoPsg0tx8
         UvhFHSO/NODJzflxdYuS64sgm+YdCgSjyc61JUd+0poF5/iwF42LwBtZUnI7VdbEpXET
         jHhZ9DE4l/lhhvBt/oYSpdCCc3zGLOEKHjMUIG+X+4I0IhuNEe2MZfODemQf9/5ps+4t
         4sN51FCMMt04m5sMBC2nOm9PVUkvr9yZ35QmbajHw2rbOMi2x0ZLTwmxw1oLIIj5UmJY
         wFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162011; x=1781766811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHOxG2aEVrWsk+iCIk+Omdwp9IYJcGKP+/ZeDWqwKBM=;
        b=rzwLel5DpWiieniHeiPTTSsWJpWUTO3VtBZxKeUR2wMDJqSyenUqQGVYvYyZE3kjiB
         oi4Xtstx9IziySzY41AXkU0FTpWKCTPDM1cQeD/U4bBXtcFMq4y4qbhROIexp72JJV8d
         uwiChFjnRzGLqLkmPDUzkrIZGUXXR0y4nJHb/G/3AXOe0F1Y+5fjuVGNT/fccn5bq5Lt
         UMJ1Rw7XK6oHdloCEUYchTt3y8Z94dxsfL5LpLv7GpYwF5p8qFCLkEnJX0k+Wzymvli+
         kEWkxCuGqj7nv5CEYIk/VCmfwSd3UIYjz1iMihqO0oeazwMGiMUyLRmsqdJUAwvTAf1B
         68/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/pBaGl7a9/6Yx0Tv6n/jVb0SBzTYQtfpCaxPVzrbBTl+vc0qrZooYlN277soLRas4ENWhQma4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYuRqMGFVKteYb7+MhL7wLa/ppgpayKHxm+P2km6vl009hDs3
	p/5XYjQHnhkCrwQmycbLVbfT8BJVWbMrX/C63cT0Z+fy8xvFadoDBPVm
X-Gm-Gg: Acq92OFITiFbv5jaKisXrWoHwhT+8L7PEqarj24QgJyFrdq+Uf0asT7j7qF638czGNb
	L2H/Nu8vI8A2a4EA4t8xzfQKfuQ6KXZ6m673KbPvqwsLzhQph3lUd0rl/1Di52D7R0OueY79imZ
	/7VIeY9TXZ9Jzf20xnyTrg0sFwKLQ3c1aKUhhzTaYF0rwq7Qk+ZHixed0uZFf6Q9yUvVuWogGIh
	FsdEU/D/ESLgEeicnzNenXQCuQvbyOu+R8D3wcT6pzVoOzDEKunuWM9qSnEUI5Y/UvAAlQEmHfW
	NWlp93CWUWwsegv5AeXU6oe6MMtZ5YUd74oYGaX3lY8ImwdJpRmEbFuAwkaB2g44rQK23diuYaN
	Z8sjplNYKUGizMoCc1QahnClLFA9gd7SjA84JXNIsWJNZcBLF1V+n86YkVzrNTBe56z9oADV8Dm
	VHa484FSsEjRWYITnoE+LrMpdOqP8dM3ahAPm60az/FmieXaWX3MY=
X-Received: by 2002:a05:690c:6008:b0:7dd:16e2:7291 with SMTP id 00721157ae682-7f658709aeamr16983037b3.39.1781162010767;
        Thu, 11 Jun 2026 00:13:30 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:30 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 3/3] xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()
Date: Thu, 11 Jun 2026 15:12:42 +0800
Message-ID: <20260611071242.2485058-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

Replace sk_busy_loop with sk_tx_busy_loop to support tx napi in
__xsk_sendmsg().

Fixes: a0731952d9cd ("xsk: Add busy-poll support for {recv,send}msg()")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af5..2bf9a7313ac4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1158,7 +1158,7 @@ static int __xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len
 		return -ENOBUFS;
 
 	if (sk_can_busy_loop(sk))
-		sk_busy_loop(sk, 1); /* only support non-blocking sockets */
+		sk_tx_busy_loop(sk, 1); /* only support non-blocking sockets */
 
 	if (xs->zc && xsk_no_wakeup(sk))
 		return 0;
-- 
2.54.0

