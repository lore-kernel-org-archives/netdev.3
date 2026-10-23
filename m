Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741067;
	b=FbLwrwo3DqRdlbEl5sOwIiPP+Zhk5Cc7taFwlq7U8/u/L3UV7LTDYQEX2DKoKBiWLpHC
	 H6WSvwgvKJtdb6KTzWwFjlFc0E72fMgF0kSeoqV4ZyS9iJhB8Z8zA5hoTdqtefYySY8qh
	 DQgNYXmwEWd59F46/BatP8qgTfjT5zZ8dtuVsyjTjmJ2laptdjuzrm/iXaJ2ZF/bRaqFs
	 6Z0x2AcmlyW6emVTgz2DXV6fxetKL+5ZUA8eY38iWV9dz+hi4UaHIg1QESbPGcjVkx03l
	 779SXuCBnsStmCMq8NnIhdfycIOyY/cD+62vTyHLLDE5d14oxPJO54SQe9Yl00eSwqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xbXgUfMO4n6ZI7asv7ecgxhoVtqoa3gH59XiTCl2s+Y=;
	b=ORdvg+yKnDX7tmVxHsEwN6Uh+h/c8zEaM3PF+/JQo3MyplsBdbgcUR2+PKEi21k7YCux
	 n0LsdWIuF44iB8qbIHYZYA6IEu7nJih0V9E1xhfCplUS0P6BkD5LwvkrCHBiKACi7M5E0
	 T70hq3yYaXotTHcnbWm97NR2K4cZObbJ5PII+7DfWkqn2KhQqY+BywXVqCA1r76PZjc2+
	 yxwT0q05o9EZH6PKQ/Ycsrd5c7X/oCBmbpB2/tYAvhZ1DY80rayz8ajc/U3dUp22x10YG
	 ak9QxY+uf8AAl+14NrxfRaFdFQKh0ctuHkRj4pfZlOhknIy4MYZtNOn+cuFWBoMnz5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PPfpCORT;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85F606A322
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF85F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PPfpCORT
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-18cdcfc05ffso682613c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741066; x=1793345866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbXgUfMO4n6ZI7asv7ecgxhoVtqoa3gH59XiTCl2s+Y=;
        b=PPfpCORTQJGDfKOe8LJGU9ZM3fMRYZ5CUqlGPImpPiiV+Jc+25baBnEmpNoU/rA+O+
         N0F4/vCFFrcO4kbRLGO9KX9b5vqzp4r83LxiV8M3RjtPkOheII1pRa5nGjH0fS0mgsVq
         Ze7IYxnr+E5Q+63JwOrpHQxd/oMxaNs8IdOsSica3zSyO48Ti0kNLbR8IIy6401iGI0D
         8aVuxARf74NmmFPuvWIowent4++ra6dN8j3lYJ4pmyykCbUmt4E58LN848ebbyBVm1d0
         XkdOJURfCitUYsSbPq5XipHfv2czJ1bmjn+r24dI1Bcs/o8yRwg2VAk6biNmi//Vhv8q
         j+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741066; x=1793345866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbXgUfMO4n6ZI7asv7ecgxhoVtqoa3gH59XiTCl2s+Y=;
        b=f3Xh0eVCUVBAzZoohrurs2uvkdO91pkSQLs/w8oJPe4mXDNIcQdqgErNjZG25hmD8d
         laxqLHIngF7lZSKfo+MpKgSQOydsTKvaET6rDbPI43fM71Z04Plv7dv8WtfFD+7JPG4C
         M1tcs6iUvFlpJJEdj4EECIJDRP2raWJ6MAUJXz4k0v3JciolnTv+L3U5iQMjX6Ux6Na3
         24IK/R1Ba1CZph3TT0jCsxQSCc+PG2olX1Q0X5E/zrFvDjnv+tecRm32ZmZl0Kh79NX0
         PCiO2CxhVkNqQ9lXrFrn2JmrdB3LuoETRD3T8nOEdfdPl7zb1ksdfhgWacvhMAJNa+dk
         Wv2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwBERi3pEfHutyZRWexTnPs6GwGSTFrxTKDa9hJAtU/Xq2YeseohbMmWwfkrQqDxXQsLIAK3Is=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUBb7zmsHj6C6GETjjYGl1Hc1jUu/Ix19Jr+StyTsOISBVsLLf
	ThwiMFUOtzC1uy/4hk5NNerac/OYYoId/Kam10fM5zM95d6QmDj7aYZ1
X-Gm-Gg: AYBFou2QaKzQMSB2LhzBhp340Ok0LKBJoMRcKffJ+EeAiXJ4LEVOSJQ52y0vHVq2OPC
	a28k67zyzqjTcaM0j3jYW42sAB5rHbx4ptGMFjcx8SqpyFqBrnOmnmtHgYdU/zGvSJ6m6nnDhQD
	wfgg2IWFMKcF3f+ULXGeICxFnJDn3F7K4EMdX+/lIBU5OF62NQ+oQU6F0NZzzax6ywFmkXKj7Y3
	xhTYiV0a2slhuMTQFf8/SL7o98yUP1QxIAlHV3hHqmf55uZUivIqkKBQdQvoPHiylTvATwGZebt
	Mfc+KKe8YNSJNB1rL9a9I9/P5iW6s1eY9E80fmFHoB1y0au3OiaT4euPyC5PkLwdVYoxoLcajpT
	alkRDpHdFDKZ5J/vI07xvJQ//C2zQw/UU5C4TOsxSNwMnjZQ6Q3I+/xmWcSEO11ddt12uiTLQRD
	Lv2W48r8onUvjh2eP1BvKVf2EzIAJc08gZSYKOC4xWRFY4FNCTeOGCA8k/6uwREB+n2+cgilc0H
	1bQYv3On8QtiLC8XvAxFKi7vjO40ItRfoQjO1R8a6j/rGkvCi4NZIJzepP9j54uvQOvGAwBofBe
	jzBNkChtqhPbA2DJJCDjgeZPBEZOc7CmItMyVQaEkUIXK4+hY9zOvEUBasjRTlA9wuFnCGK/iRN
	7lepO3taPSrOYNtYtRepyww1WZSNd6Jt6KhjUUS1qjvnh8g==
X-Received: by 2002:a05:7022:4081:b0:148:bc4a:8356 with SMTP id a92af1059eb24-195c5bc77c4mr1616415c88.28.1792741065536;
        Fri, 23 Oct 2026 00:37:45 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195e9e9cbf6sm4413627c88.6.2026.10.23.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:37:45 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net v2] gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
Date: Fri, 23 Oct 2026 07:37:38 +0000
Message-Id: <20261023073738.2436362-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The gtp generic netlink family sends notifications on its "gtp"
multicast group when a PDP context is added or deleted, and for GTP-U
echo responses. They carry the same attributes as a GETPDP reply: the
MS and peer addresses, and the TEIDs, or the TID and the flow label.

GETPDP requires CAP_NET_ADMIN, but generic netlink lets any user join a
multicast group by default, so an unprivileged user in the network
namespace of the gtp device can read all of this. Found by code
inspection.

Fix by marking the group with GENL_MCAST_CAP_NET_ADMIN, like the psample
"packets" group. Only users with CAP_NET_ADMIN in the user namespace
owning the network namespace can then join it.

This is still weaker than the check on GETPDP, which needs
CAP_NET_ADMIN in the initial user namespace: in a network namespace
owned by another user namespace, its root can join the group, but not
use GETPDP. Genetlink has no multicast group flag for the initial user
namespace, and ioam6 pairs its ops and its group the same way. This fix
blocks the unprivileged users.

Tested by joining the group as root, as root without CAP_NET_ADMIN, and
as an unprivileged user:

Before:
  root: joined
  root without CAP_NET_ADMIN: joined
  nobody: joined

After:
  root: joined
  root without CAP_NET_ADMIN: EPERM
  nobody: EPERM

Fixes: 50aba46c234e ("gtp: add notification mechanism")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v2:
     - say that the group check is still weaker than the one on GETPDP
       (Sashiko)
     - say how it was found
    
    v1: https://lore.kernel.org/netdev/20261021065750.2069795-1-anilkaushikwireless@gmail.com/

 drivers/net/gtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 15b5d845fc3b..8b29c35d7cdb 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -118,7 +118,8 @@ enum gtp_multicast_groups {
 };
 
 static const struct genl_multicast_group gtp_genl_mcgrps[] = {
-	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME },
+	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME,
+			     .flags = GENL_MCAST_CAP_NET_ADMIN, },
 };
 
 static void pdp_context_delete(struct pdp_ctx *pctx);
-- 
2.25.1

