Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FC480348
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582431; cv=none; b=Ya7yHRASF0d2pwCFZDv/DucZDr35X1B2G6JgpEu+8DWyRABT5H6EADgKxMoJlkLjSyO7k2At0vgy6+L6VF/Dqt56P+dw22GMKmoWfEw/jStWnthvAXYDUcdSppRQPUTfWPNPlriqBUMij1FhJIhCSUyICI1XpyrrDsGOrojyj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582431; c=relaxed/simple;
	bh=f95+yIa6EObENvY+ABBJylatTo7FDUxTZ/KU2+hyWrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fE0Y22Zt4rARx5bmyppvfW+gIMANh3r19cwXeQCZMGYtvdWFEG9e4CCsKzz0Cp2soA517EQ3F28p1Qa6CyzBVFJU1L+5J2ap7xZNUnaPeP/NwqA/Nar56c3VeVO2r5kqV6MhuGoi/TRrUYJBYGUpNqCTRIuI0z4ZPJ4r5nXKf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qreiJpKf; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qreiJpKf"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ccd83d58d9so11748266d6.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582428; x=1781187228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb3gOlt9ISYlGh6MgorS7Sw3tas63xLeycEBVQlRA7U=;
        b=qreiJpKfl3ut/20BQwIqHSBCTYjmRsMsdd9tBSLM+vM95fkaQLBFxKUHSw0F+2upyC
         kRHbVicySKeXJVvrWrGyFtxcyjiXQE0+GJIehVVhBL6V42Zo0XKMOGVaHa5wznGzOqMB
         IJEL/BL9zzsDiFcewWb8RKaDt8+E8TTLUnu78y4uFHLPcjeB/rBnueS+SuDzoRgYh8rU
         6tU3p/EQvoGo6AC4mzDwqQmWue3Hb2H1MQgywK4vlqKvlPKy8ngOdescAxSmhzBwz59l
         YYBI1DVgiIZ1bC79FuPSlW5HTBHGsp0/S8adwrZC5a/6VmVXDsreRbVgRY+4dgDKEyrb
         eOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582428; x=1781187228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb3gOlt9ISYlGh6MgorS7Sw3tas63xLeycEBVQlRA7U=;
        b=QI8nzny25RwDhGeFo3WMiUbn5c/QtW66375Qp4LHTom+/KNPnkJDvxno+h6eWlBk8B
         oG9EWbdRoVfhKpJFlgHrM1XSQxrOJf4rMJgiNVkNCpxTo5q11k4Zm+14t1foUgcE6qx/
         ThV6ZOeXxYtbDaUV5YuJkUPDRF8BcY4+FONMiEObB1LDdGZmLbc3H2C9bkXQ/EeIOZlw
         VqJk4lEYAcB7NbekQEg0hpTMwAHBnaOnYvjIyT7RmHHXtLCSGZELyMEoA8W9inJ8R0WA
         tgYl5SqGbv9CuecZV2NCdN9eEMnJMJ7RBcqtJCd3hlJFX7l1ECwB+7cQCeGf+5AWqqK2
         ucrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KDuKY1MM6OCeYzmGQMkdWMiCBKfz9zbli/8seeYTqhzsmLyzxoI+Tg0wRN9ES2YzQPXGyfx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKV4GBmL1ClgJaiF7dpmOxcg2VMEI/S9PpgYlQTqI/OTU+A/8
	FM9T+/BJENyggEGQ+yqU6i+sJyf6aaxTWLaOQkyYWuBcEYYDzrR3RwMraACZ/PLIpkX6pOjjP66
	XKGG1UClh/NhrBg==
X-Received: from qvzp4.prod.google.com ([2002:a05:6214:15c4:b0:8cc:a4e5:b16c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:578a:b0:8cc:f7b7:bf8c with SMTP id 6a1803df08f44-8cecdbfce32mr131862856d6.5.1780582428315;
 Thu, 04 Jun 2026 07:13:48 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:34 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-3-edumazet@google.com>
Subject: [PATCH v3 net-next 02/11] bridge: add bridge_flags_bit enum
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to use atomic operations for lockless p->flags changes
and reads.

Add definitions for bits in addition of masks so that we can use
test_bit(), clear_bit() and set_bit() in subsequent patches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/linux/if_bridge.h | 78 ++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index ec9ffea1e46ede3762f108f6e7085ebb1bf1d2e1..75673b8bffcb8ad6396e6a05b8af8150208fb6fe 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -36,32 +36,60 @@ struct br_ip_list {
 	struct br_ip addr;
 };
 
-#define BR_HAIRPIN_MODE		BIT(0)
-#define BR_BPDU_GUARD		BIT(1)
-#define BR_ROOT_BLOCK		BIT(2)
-#define BR_MULTICAST_FAST_LEAVE	BIT(3)
-#define BR_ADMIN_COST		BIT(4)
-#define BR_LEARNING		BIT(5)
-#define BR_FLOOD		BIT(6)
+enum bridge_flags_bit {
+	BR_HAIRPIN_MODE_BIT,
+	BR_BPDU_GUARD_BIT,
+	BR_ROOT_BLOCK_BIT,
+	BR_MULTICAST_FAST_LEAVE_BIT,
+	BR_ADMIN_COST_BIT,
+	BR_LEARNING_BIT,
+	BR_FLOOD_BIT,
+	BR_PROMISC_BIT,
+	BR_PROXYARP_BIT,
+	BR_LEARNING_SYNC_BIT,
+	BR_PROXYARP_WIFI_BIT,
+	BR_MCAST_FLOOD_BIT,
+	BR_MULTICAST_TO_UNICAST_BIT,
+	BR_VLAN_TUNNEL_BIT,
+	BR_BCAST_FLOOD_BIT,
+	BR_NEIGH_SUPPRESS_BIT,
+	BR_ISOLATED_BIT,
+	BR_MRP_AWARE_BIT,
+	BR_MRP_LOST_CONT_BIT,
+	BR_MRP_LOST_IN_CONT_BIT,
+	BR_TX_FWD_OFFLOAD_BIT,
+	BR_PORT_LOCKED_BIT,
+	BR_PORT_MAB_BIT,
+	BR_NEIGH_VLAN_SUPPRESS_BIT,
+	BR_NEIGH_FORWARD_GRAT_BIT,
+};
+
+#define BR_HAIRPIN_MODE		BIT(BR_HAIRPIN_MODE_BIT)
+#define BR_BPDU_GUARD		BIT(BR_BPDU_GUARD_BIT)
+#define BR_ROOT_BLOCK		BIT(BR_ROOT_BLOCK_BIT)
+#define BR_MULTICAST_FAST_LEAVE	BIT(BR_MULTICAST_FAST_LEAVE_BIT)
+#define BR_ADMIN_COST		BIT(BR_ADMIN_COST_BIT)
+#define BR_LEARNING		BIT(BR_LEARNING_BIT)
+#define BR_FLOOD		BIT(BR_FLOOD_BIT)
 #define BR_AUTO_MASK		(BR_FLOOD | BR_LEARNING)
-#define BR_PROMISC		BIT(7)
-#define BR_PROXYARP		BIT(8)
-#define BR_LEARNING_SYNC	BIT(9)
-#define BR_PROXYARP_WIFI	BIT(10)
-#define BR_MCAST_FLOOD		BIT(11)
-#define BR_MULTICAST_TO_UNICAST	BIT(12)
-#define BR_VLAN_TUNNEL		BIT(13)
-#define BR_BCAST_FLOOD		BIT(14)
-#define BR_NEIGH_SUPPRESS	BIT(15)
-#define BR_ISOLATED		BIT(16)
-#define BR_MRP_AWARE		BIT(17)
-#define BR_MRP_LOST_CONT	BIT(18)
-#define BR_MRP_LOST_IN_CONT	BIT(19)
-#define BR_TX_FWD_OFFLOAD	BIT(20)
-#define BR_PORT_LOCKED		BIT(21)
-#define BR_PORT_MAB		BIT(22)
-#define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
-#define BR_NEIGH_FORWARD_GRAT	BIT(24)
+#define BR_PROMISC		BIT(BR_PROMISC_BIT)
+#define BR_PROXYARP		BIT(BR_PROXYARP_BIT)
+#define BR_LEARNING_SYNC	BIT(BR_LEARNING_SYNC_BIT)
+#define BR_PROXYARP_WIFI	BIT(BR_PROXYARP_WIFI_BIT)
+#define BR_MCAST_FLOOD		BIT(BR_MCAST_FLOOD_BIT)
+#define BR_MULTICAST_TO_UNICAST	BIT(BR_MULTICAST_TO_UNICAST_BIT)
+#define BR_VLAN_TUNNEL		BIT(BR_VLAN_TUNNEL_BIT)
+#define BR_BCAST_FLOOD		BIT(BR_BCAST_FLOOD_BIT)
+#define BR_NEIGH_SUPPRESS	BIT(BR_NEIGH_SUPPRESS_BIT)
+#define BR_ISOLATED		BIT(BR_ISOLATED_BIT)
+#define BR_MRP_AWARE		BIT(BR_MRP_AWARE_BIT)
+#define BR_MRP_LOST_CONT	BIT(BR_MRP_LOST_CONT_BIT)
+#define BR_MRP_LOST_IN_CONT	BIT(BR_MRP_LOST_IN_CONT_BIT)
+#define BR_TX_FWD_OFFLOAD	BIT(BR_TX_FWD_OFFLOAD_BIT)
+#define BR_PORT_LOCKED		BIT(BR_PORT_LOCKED_BIT)
+#define BR_PORT_MAB		BIT(BR_PORT_MAB_BIT)
+#define BR_NEIGH_VLAN_SUPPRESS	BIT(BR_NEIGH_VLAN_SUPPRESS_BIT)
+#define BR_NEIGH_FORWARD_GRAT	BIT(BR_NEIGH_FORWARD_GRAT_BIT)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
-- 
2.54.0.1032.g2f8565e1d1-goog

