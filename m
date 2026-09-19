Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A732374A0B
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857273; cv=none; b=OAcUcLtpOkS7ST7HEUiRXTx+V2enI24aQcrIgeS4by2Lh5Cbrw1q33+1v3x4WXtU4DzBBkHpzHj7m/F6y+9ZCegilDyb3OguAeHag4dj3JLqn1AOkrxdViAzkQYjsEanQfvg3mvzlWY59+FQODOqdF/8J4lfAvvSlhtmNd8EjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857273; c=relaxed/simple;
	bh=YJbTTv0t2BWIFrbdxBZVugRFfM4btTyxQU6vJrhf3OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHx301a0eBt+8mG1EJklj+bI9amyYWqY9ESHuOG2Q8rMZEw3J/7dDSkeqIOe8NO6rnShi/fQEYW8qYBA3DyaWvNaLuUGDasLkye9WwyGeQMExT3c1XGcY0k40jSgoOouaY5vsfm5swlBFZmIXSCU8nWGgry1eE5rLD+0+EvsixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifYVTsZn; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifYVTsZn"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1388431a91.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857271; x=1790462071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UAwXKmx+R09A7nHDL9ZNtNOP7/6ryqJI8+NyxhqUBXc=;
        b=ifYVTsZnCqOjY48tPbQdI3BRb9dRV0zdTqv5LieteSjmT0VU8iVedFlA/rZKPdf7Ih
         WbMgK1oIPKQrio09BonuYkM9mBjxVyObXJHDggi2hXQnKQHn8SpNtJ+tuW/WA+Mlb5un
         bgLIb96RWYlzQXsCxylzF/GRizUTFB86FHd00pXOoBuDts5GRCRmdBLXDXBpAKPy8Sw3
         MwgtC2AnNWlqiY4KBQMZZe9pnB8YuSCZ/oaBBSD4iHR0cqXnopJYYN+Ar7iW2kSljL4o
         XOKhy8mPcVPpH9RXCMAfiML9LyEMDMp+QzpRLwepcJdxYr66oPrNrj3AQlX+8kDL4dvK
         3dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857271; x=1790462071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UAwXKmx+R09A7nHDL9ZNtNOP7/6ryqJI8+NyxhqUBXc=;
        b=DrYuKrqIiqCp0dIPHkym8nhPDGRgG8cZeZEK1YZ65CS12GWetg6ow2xnpxt+JIuqqn
         Bhn0PWgwVGVlny4oiu6UcAhwE+aIHqicDMjU9uJgev4CYbSZyuuReaCA5xY38AiNYhOD
         QP7uajpfBaBZC6z6s0JKON4AsYqXKtK4rpC7UOOplt2mC/zYZdcBWmWN3RYdW/f0UsZe
         /Qjd/Q8XxAGfD7UDYn/yoSk+xZQUBc02ayE24D7RpNbzSDup1RfYCYDTJVpOl2WoFNLd
         S7bin99oUQLHww4OtWriepo1X6tjpl2lC3N5xuzrd273ZhzSCN9y7UcT9dUMj8a48yb1
         yMoA==
X-Gm-Message-State: AFuF++kB+M0u4lw+BH6rgedk9oX7X83FF4B9irg30GLNUyqAD/YZzNq2
	/pfTn5iWKEcTXFj+ChFntS1ptFpANjWnajKhkouDbZd1gDOpWPNVgkG7eN84Q4Fh
X-Gm-Gg: AYBFou3kge3IpDFUiIr+FV+uRkk3fYzxUmYIop1gs7UzJ2DABviFboVPTwqgic7JzbE
	sBt84QJ/Dzg0ki9aUCpmMfxbrlBsHY5hDlxPiKWPFaogcSeOhQ8ITkWpWkIhE8PgG6CvuSdyo2t
	WRGch9NbjYOKmdimLeKVoJBQ9Xw1yophnbdojdjIvxkW7cEaxUa11t6l57oAFTqhOC+06mapxpy
	37ASghERylyqOELHYJNo5z9mo7zeY3wWw9+OL6doTlT2IVdQm7VHuou1G98GzRbb+oCIWsrhcJo
	cxrqI4IomuebUjMAq8YN0dfRPxU/pgyW4LmzGlncRYpNZf+LrC6Zl/LfOP5BytjK0Ne3ZtIC9eM
	tVpEXww2n58wjI4NECCtofPp5NsqTFK0U44dxR6+bAvPP/BTdm9t+9U1EeZmzPVRT04edCkI7Gs
	MTGSyfgpyaIq4jwjFxzMB8hQltWvP+5/1QR8bTHDGWi3gPCm+DF7lWA8jIm4SLvmvITCyDcLYOj
	lJIEttmnT4ozV9/AuHonrJJlJQW8mg8Q6CqagfC8G58NvlzU5ikkxlhFkLZ1QnFQCtS/egJv84Y
	xzWoZ+HOdg==
X-Received: by 2002:a17:90b:3883:b0:39e:6c68:1559 with SMTP id 98e67ed59e1d1-39e6c683328mr5728171a91.33.1789857270696;
        Sat, 19 Sep 2026 15:34:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55b83602sm4702164a91.1.2026.09.19.15.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:30 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/rds: fix incoming message refcount leak and header bounds check in rds_recv.c
Date: Sat, 19 Sep 2026 22:34:29 +0000
Message-ID: <20260919223429.3882046-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In net/rds/recv.c, ensure incoming RDS message references (rds_inc_put)
and socket receive queue bounds are properly balanced when handling
error or truncated incoming frames.

Fixes: bdbe6fbc6a2f ("RDS: recv.c")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 6204e577a90a..0743706af8ca 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -637,8 +637,10 @@ static int rds_cmsg_recv(struct rds_incoming *inc, struct msghdr *msg,
 		for (i = 0; i < rs->rs_rx_traces; i++) {
 			j = rs->rs_rx_trace[i];
 			t.rx_trace_pos[i] = j;
-			t.rx_trace[i] = inc->i_rx_lat_trace[j + 1] -
-					  inc->i_rx_lat_trace[j];
+			if (inc->i_rx_lat_trace[j + 1] &&
+			    inc->i_rx_lat_trace[j])
+				t.rx_trace[i] = inc->i_rx_lat_trace[j + 1] -
+						inc->i_rx_lat_trace[j];
 		}
 
 		ret = put_cmsg(msg, SOL_RDS, RDS_CMSG_RXPATH_LATENCY,
