Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88137C93D
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436807; cv=none; b=KosldygO31QyqInBnmSAa0z4sBBBj5GQU7UHOgGF8ZqD7RQhGmqbPf90oQw5mcP2fvud3g1Dh1tBXuHPDT0nekDnSDhWBpBcpOIDEJS9r1wA75jc98iU5GbWV6EETON9FJLmszglS2IeIfAwcuZ+s6TplNu2XILc/QiYi+7wK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436807; c=relaxed/simple;
	bh=/eMyLhMtgOhVToRnc/6PZd+yHvWgmaLfJt5C/QgKH2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNMH8E/UUl77mi9u+Ie5We5q9YTqqIh3dYmrmXB37Qt2GocKpIE4UV6m5pAvmJIf7k+1diX8rxIAL7PnSspYWGF5sOYEtdOD4iX7MIKW1PXi6j3jAaps6CYaf2C4C1L28pYn2n3gV3b34MSary6ZUAMz8Rf/+RxVJkfUooBw3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0pQJ4ge; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0pQJ4ge"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso61379735ad.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783436805; x=1784041605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPT2PsJ2NgQIq8sAETDfZXCdfC0YIlSwd/aNYXHd3Ys=;
        b=F0pQJ4geBG8PB6T7sKnYP3iaj3tW5bsdUyvyGZfQFLusbrpMCYiaQJj26MrYYpP02h
         FYNxXDVb/RXG1lXcPoPYyv4rCWiKMvVJMbm1+uDCwa3QBSQQvreL+z1GCgh0VwHcAMo3
         zkFTFHCfUwR9spj06vmYvsgwgRAvER7hw/vgHzgT9kQT7tJJYmi5IOHfphvRol52GlXh
         pFMx2DGIdv9FjXom69WlOLr6L9CWYSqPkOZAFkrBZ6P9YebAKeMwUU4EQjy7bEzWSS+U
         WLernjh5C6eK31PtbH1HJAuE3w3/GPC6bsNoAElR/DRUo6BOKuZhM45AIfNgK06DzCF0
         miSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436805; x=1784041605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MPT2PsJ2NgQIq8sAETDfZXCdfC0YIlSwd/aNYXHd3Ys=;
        b=XFRzxnmanveFLmfoAxjJQEIGeXWm+q2oRsNEysNFEtgQh3gazyikOsJjjuLxYZoHIm
         dHEXdBnzMLvNU5bAcj381Fs61vkU0tsKbDyaaTC6cLq1PzrRqvyH0X5mq/Jgxrs8SsVb
         oMfA5OPySR8yjlMHaao+4/Kbpwt7Gmjm0JkYgfGzNqOpfu3iy9bdqq13lSf24ya96CIq
         sx4rPA9fcEZRTUC1mizr+ddfzu9G47sIUBdGDmhMLOatBfVhNnoXo2k/rlim2Tunjw52
         qaBXrOw7xcKHti5spLqQqTXXQUJPpPLmtBnz6ceqJHbyVjjUmWseb1tM4p/cL0ndJfcU
         d2ig==
X-Gm-Message-State: AOJu0YyxFwtd+Ekg31/h7qNwQkkvtLEliB3qhqrmZR4npgnr6QNhPqRx
	SncZ9i5ZjiXDBkPGiGIpV2IkMIeG0UemE2zzJg9azTe9prwdVLAY57FF
X-Gm-Gg: AfdE7cnjqmQ9zfGbEgEue/h27tdb1BW1bxbmZ8+w+SOyYTdvLSRcBuaOSygijiGzfHO
	ZG7ZqE66ID+kFZig6f9oRD9SEML/jVhYJtJlmw5/wOkiqjXCu2P8I+pPoPR6J+l4Cu2OPqrfQyv
	GIGLlLK7jpAPe/+ayHLP6Rwwo8bfJagn2eTg/hoJvjLaXQ2NC0Euu3Ix/vp5U4YOR1K/bk/5JgM
	we6ddbMwkaXCWBvanNqsGQ/CoRl9XpWr2pL/hKQzr7Db0f8LwWGgKqKpbQplpvgGa2Fs7QtrCiQ
	CExESkNYsQTj5UKxHQCCUn6NOmJbmE8Xau2RD6JwBPGbZ6waNHbWIgoVAIo9GZ5PqK89nGFXO8k
	MH2iQxaFyCqPfOa9MleYK/Bjh+X1ai4i3R9iRFryAIn6VDVyDbXt8gojfTW/TeO2d8iujbm40jW
	sF9s7k1NYp3wTmZwRmirSY/90XVrvVmg==
X-Received: by 2002:a17:903:fae:b0:2ca:de3:15e1 with SMTP id d9443c01a7336-2ccbf0105d7mr56380165ad.31.1783436804859;
        Tue, 07 Jul 2026 08:06:44 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.148.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5fc81sm13678065ad.83.2026.07.07.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:06:43 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2] tipc: fix u16 MTU truncation in media and bearer MTU validation
Date: Tue,  7 Jul 2026 11:06:22 -0400
Message-ID: <20260707150622.3310-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <GV1P189MB198837B4F3A78F2A11C9614CC6F02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB198837B4F3A78F2A11C9614CC6F02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied MTU
values but only enforce a minimum bound, not a maximum. When a user sets
the MTU to a value exceeding U16_MAX (65535), it passes validation but
is silently truncated when assigned to u16 fields l->mtu and
l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
truncate to 0, causing a division by zero in tipc_link_set_queue_limits()
which computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing
values (e.g. 65537-131071) produce small incorrect MTU values, resulting
in link malfunction behaviors.

Crash stack (triggered as unprivileged user via user namespace):

  tipc_link_set_queue_limits  net/tipc/link.c:2531
  tipc_link_create            net/tipc/link.c:520
  tipc_node_check_dest        net/tipc/node.c:1279
  tipc_disc_rcv               net/tipc/discover.c:252
  tipc_rcv                    net/tipc/node.c:2129
  tipc_udp_recv               net/tipc/udp_media.c:392

Two independent paths lack the upper bound check:
1. tipc_udp_mtu_bad() -- called from __tipc_nl_media_set() (MEDIA_SET)
2. inline check in __tipc_nl_bearer_set() at bearer.c:1160 (BEARER_SET)

Fix both by rejecting MTU values above U16_MAX.

Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2: Solved format issue

 net/tipc/bearer.c    | 6 ++++++
 net/tipc/udp_media.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e..0926692dd 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1163,6 +1163,12 @@ int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
 					       "MTU value is out-of-range");
 				return -EINVAL;
 			}
+			if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) >
+			    U16_MAX) {
+				NL_SET_ERR_MSG(info->extack,
+					       "MTU value is out-of-range");
+				return -EINVAL;
+			}
 			b->mtu = nla_get_u32(props[TIPC_NLA_PROP_MTU]);
 			tipc_node_apply_property(net, b, TIPC_NLA_PROP_MTU);
 #endif
diff --git a/net/tipc/udp_media.h b/net/tipc/udp_media.h
index e7455cc73..0d62a57c8 100644
--- a/net/tipc/udp_media.h
+++ b/net/tipc/udp_media.h
@@ -48,6 +48,11 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb);
 /* check if configured MTU is too low for tipc headers */
 static inline bool tipc_udp_mtu_bad(u32 mtu)
 {
+	if (mtu > U16_MAX) {
+		pr_warn("MTU too large for tipc bearer\n");
+		return true;
+	}
+
 	if (mtu >= (TIPC_MIN_BEARER_MTU + sizeof(struct iphdr) +
 	    sizeof(struct udphdr)))
 		return false;
-- 
2.53.0

