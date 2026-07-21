Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9A3F58E0
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644576; cv=none; b=RZ9dlh9TkaFRdsYfjerouRsZKn+Z66AbZAPMnSAO3XNaKADnmbxDyTqZI3ZgFVhGg3EGSELz+6nzyN5m9u9dEwBI6OEoVTJdbcxTpixY99U//Ey9C5I4FlGYF5yL1V58MUfDppZRFc3yQnhktUdlqdnN3S6iu4CY1a74YoWDU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644576; c=relaxed/simple;
	bh=XmRIH81bkc6iTuUsDBxMlnsDiC1T3l2tIg9fzr6uTQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+DtMAkX/Q2lZ5LDjzK123Hfll/Js/Vy2K5YyjUokFMcix1PM2qf+pMsIhYRt3L+KtsKJ1tetfvX13hQsA5tBoE8Ai+wJdMnujmXXKFxpYHyrM4+zvXJBa9ga2a4jwJLzIKPt5B0x92pqFxzGlAZDaXNjt2W+xtnIpULbdK5eto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ6ZoOXn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ6ZoOXn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf41bab353so53322395ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644567; x=1785249367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AGP75FyAbi2oJU6QjLsaMh+MFlOMgbSJcYTqF2a3ups=;
        b=aQ6ZoOXnCU6k3jMCMhyKdCAWB0tEGc50KWcH28l9ss06WJppYQg4XwwbUdBSZIRGby
         Nbv6MlptfBhcr0/qZxh+AXo8r3I+vrlSptqc5dXn6jAS7Xi3j2hsMLLXl9ZO33RgtNQK
         jU13iA6J5PAlYnL4zd1A3SZryVIEqPqdyOPIIoAVtDlaCQJsCHMQHO6KQB2d5gKGLCWR
         ZTLZ+Dk/oBEWBaa+okXtipQEB1tSxhIN8fWFb05REv3nv/Lsh74AIM3ktLn5ETkIRxQm
         YFkjq8g+yrOQ+F5cICVk4htt+tN0npOQBMJjhuLwgn64vkBxEKLGNbw6k8Fe09nWYNWt
         G+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644567; x=1785249367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AGP75FyAbi2oJU6QjLsaMh+MFlOMgbSJcYTqF2a3ups=;
        b=XhbRNZUq133WsYGRqovKyJfVpCxnz5Z8e/7cGTYOwBCq1Z1N5z56ulJSn6Gk2dEkZ0
         nEUwpUooJLD44puVaM1oiM82lbq+lXxV9/TJqJ7LLQRG4rBV+YeGNKpmvox5M4hGyknL
         FM4zCWckhEC93AV2vNGn3u8tCsMoX1HLU8O3gfMYrXXAd8uUtXkbOt5Z7io2V4paMPP8
         rpqT2kdQ2OvujFiSdL9LhD1J7m8kxiaoJvsaAjV3VENuK7zCyY6WIMx2NM5MF/hkG+Fz
         5ad0tHnTVBOSCliyHZT4iSJPkkItNLpYi6vAmi5tEvvzf1iOTdJcdmAtxRrDxjHhI+gf
         DPcA==
X-Gm-Message-State: AOJu0Yx5UO8557cs/NBR/ZiKB7lkDw0tyMs4AE6vm1HvEs7h5/A1HyYL
	0YDNNiG4Ukob4EU3SR59SXhNZpEimZvrJg2WUhvshKqlY9TIuPqEwV2K
X-Gm-Gg: AR+sD13iVK2uUB2jkP7svxTuKkuDh/x+fuKi28EVMUYZnmsuRlzSeiFtyzKYD805mZm
	AFKk0d1Phu4E3zYBJ57GoFHNswoXGZbA9uBXO6u737kCkhLN2aoauPB9eHDGuA6NvA7p3BdDNEl
	iPOYufjJ1SuMLzarmHq4N42jGN8I3I4QWP6v6GHhtq+AoY8xQSOeXG/ukkE3QFqW13rSE2oIOui
	97blK6jOBM4U7WiezXswFY5dYDh0lTBcg9q+wq8PHc+8dUmTBguL3WtzMAvq6Fe97K8qNNkc+8K
	C+wqgaGlQl28sBIu/u+yiLbe5IX26v2k2nLmxsQSGFuyWlfBj8FXmxpaV38XKtVscEOqe/q7B/E
	Q3JDB3Xf9/JNJPBiNdxfWp7nIAfYCwWNdo9Ivy+RuDpcWlLXFLyqHj8k0qxQ1vJ4bNcZniJvBui
	mL+rh3AV+ChP5l+3WRU2dJ/UrWdR0ptUOBGteGZUaEdHOqEHDZJpXGb2gwXgb24wCk4LL3nut7P
	utWuLkLITe+Y/gBS/I60VjltfFG
X-Received: by 2002:a17:902:d489:b0:2ce:ed59:7044 with SMTP id d9443c01a7336-2cf3497b251mr207762785ad.30.1784644566684;
        Tue, 21 Jul 2026 07:36:06 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([2001:4898:a800:1012:d7e3:b398:3823:62e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf345111d5sm77235505ad.37.2026.07.21.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:36:06 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net] net/openvswitch: check Ethernet header length before key_extract()
Date: Tue, 21 Jul 2026 10:36:02 -0400
Message-ID: <20260721143602.64677-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
for MAC addresses and parse_ethertype() pulls 2 more, either of which
triggers a kernel BUG in __skb_pull() when the linear area is too small.

  kernel BUG at include/linux/skbuff.h:2848!
  RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
  ovs_flow_key_extract+0x419/0xa70
  ovs_vport_receive+0x222/0x390
  netdev_frame_hook+0x3e0/0x630
  tun_get_user+0x2d0c/0x38e0

Fixed by adding check_header(skb, ETH_HLEN) in ovs_flow_key_extract()
before calling key_extract().

Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/openvswitch/flow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 66366982f604..a0f9d788d284 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -1035,6 +1035,13 @@ int ovs_flow_key_extract(const struct ip_tunnel_info *tun_info,
 		return res;
 	key->mac_proto = res;
 
+	if (res == MAC_PROTO_ETHERNET) {
+		int err = check_header(skb, ETH_HLEN);
+
+		if (unlikely(err))
+			return err;
+	}
+
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 	if (tc_skb_ext_tc_enabled()) {
 		tc_ext = skb_ext_find(skb, TC_SKB_EXT);
-- 
2.53.0

