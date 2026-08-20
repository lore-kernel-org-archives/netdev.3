Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522363988F1
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255570; cv=none; b=kIIP28uLVnykiXluDHzTBkV0VBeSznRD7brbZX4jWkcZmO7EgfK4wnnLNYvfeLBg45xoJq5DdUy4Sv2ICnUHKqFR6btVjCzkdWi8iYLsXIan9p3dyZsgAhOK40MbVKfRTJGvBJIB8IQD+NLAA3p1z05mK28zPG3jlSdVBCkM+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255570; c=relaxed/simple;
	bh=btXZ31id62L7xkXxIIacKYO/K7DamlhGxXWECxAQDls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SStV5mUVTfCVGVUC8qKQ7uqzqU21V54cxC1s7mutqFRWYbJD9QHIR671oXrRCiDjMir1hXkjVghjdba/4CZSoayYaUMTSQ8Je3P2W6UHoLLOkajSd0fF3t+rx+fha/HAYhcbfiBPiFlr8VnmkGXxgYhwJyHxLOv+pxjRzYrhAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VV4OX5Px; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="VV4OX5Px"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d0407aedd6so3233065ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1787255566; x=1787860366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pBLOV4ZGgtSNqaZUnfdLgTjbJOpqmbdghaWweHuuFKw=;
        b=VV4OX5PxgTy6TkxEVnxs/B3GmWI73pKbr8oh+6LVXm2dJglAr1YJKjNpqkpmRF2D5e
         sDdIOg0zlYlF9LVwiRqhsG5GnSbOwVqqgLRLSbZYI7Zu0yGX2Z6OjEg4zixCq9bq3MvY
         5k4RwuwSwGjumGyXT8WLmTZqHJ1Zn8+ssQH9UN+P5YBx0v2KKUZlbOnMacgTQ5lta0tm
         T9rqFKKrfQy/r260XnDMZpvknYUpTbB94KPRmtCaJBQ5NNUsO4DMAhKUHenwyFOEUh3w
         j6YQADSnlioamV4zywypKLVxsxgG9t5Ws4zDIv0PqW+SZErgIiyeGBgTgzJ9/NmP7te7
         pZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787255566; x=1787860366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBLOV4ZGgtSNqaZUnfdLgTjbJOpqmbdghaWweHuuFKw=;
        b=cpBy4A2Tz0LZlZZR6WLloDOE78gv3ETu8gYRNffknPZ1wVS+shoHmRU5jX8VUDq0FY
         GcVLwOpY9oQHlUam9ZZxx8yElvNzubUpJ/WJCjDAjZlt3cM6HStPXhtZWiTnVGCnoOCL
         aJXCgXEKOG61ekQ1e05WQka5/TVi+Z6lRG6RKBNkbPhK/L3lSGV7dHPgWgqDAjth4SmN
         8VMJ9vMdly7KF6vPow45CaoVcTn5oKbtXh88rnjhIZS2e1sJttJrrFk0ZEDZDu/ftiU8
         M6Ca4hq6yaqEO+pm61yQbcXx1O8v6iXe+KolY6pwxaS9ZhYVY03kkO497l5bhy154OFU
         j/1A==
X-Gm-Message-State: AFuF++m9FkasgKAgKY8g6BneloPuzWKWt9xNy/hUV1FfAkYfMLRCAMIh
	aozid9nSW4Y5cdS2spBDdD9P6NGiWFm7tHF3tywdq32aDLUjrXPIowanPtQbXlR+NQ==
X-Gm-Gg: AR+sD12YpuBLJP+8MzEmGMTeHbmiBaZ1jrHHBnsNSDT6oJ46ZylQukK0urkg3oyXTuv
	+Y7tHqeniBEe56zbZN1BGPsLLsM0IzyZm8P16e0e5eTdyKTB9qxF6aLbtrOVD+XYhG7FcrgmmHL
	3S1jOhmnCA8eEOVz2q9Pqjm7h+YyKFJLc370ZJr1xCa8l8O4wrDd+HhLRWyd5ADjYFu1cCiZDNJ
	1LFDkXOV8/yxKxXZARnNu3yOMhIWPHJem1bN48fDGEa+pWFOpYVfOVE9szDjR0gB8B4GZfq95Dg
	+d2GFMlYYUe80J8to7VA109JArstne85a73wFhj3N+s31zCOHVubykoQuqav+4hfKmEHP1kY3AC
	P5YuvubJpqApiQl3aOy+SKVPEaCeUD6/swNB5uuUw8gEsc9BBnDYxPbdZEC3v47mqpZ6tT/kUK1
	NZLftXt03U3cZdy8mTcvv4uv1oq1ZhB+I/4IrAYOoYvSRLom4+/3Q9JzzyLd/w/l0TtfOwm9ECN
	JXlkNlBdendJIPYsIV/ePCvqhrPETbmDBwBacn95LA2YA==
X-Received: by 2002:a17:902:ccc8:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2d64ada2425mr24353565ad.1.1787255566356;
        Thu, 20 Aug 2026 12:52:46 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10b584sm32311599eec.16.2026.08.20.12.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 12:52:45 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+4638111fe2a12980@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] net: qualcomm: rmnet: restore skb->dev on deaggregated frames
Date: Thu, 20 Aug 2026 12:52:40 -0700
Message-ID: <20260820195240.1631458-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmnet_map_deaggregate() allocates each sub-frame with alloc_skb() and
leaves skb->dev NULL. __rmnet_map_ingress_handler() assigns
skb->dev = ep->egress_dev only on the data path, but a MAP command frame
is dispatched to rmnet_map_command() before that, so rmnet_map_send_ack()
runs netif_tx_lock(skb->dev) on a NULL device. An unprivileged user
reaches this by unsharing a user+net namespace, creating an rmnet link
over a tap device with INGRESS_DEAGGREGATION and INGRESS_MAP_COMMANDS,
and writing an aggregated frame carrying a flow-control command to the
tap fd.

Restore the assignment dropped by 378e25357ac7, so every skb leaving
rmnet_map_deaggregate() has a valid device.

  BUG: KASAN: null-ptr-deref in _raw_spin_lock (kernel/locking/spinlock.c:158)
  Write of size 4 at addr 00000000000004b4 by task exploit/144
  Call Trace:
   _raw_spin_lock (kernel/locking/spinlock.c:158)
   netif_tx_lock (net/sched/sch_generic.c:497)
   rmnet_map_command (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:67)
   rmnet_rx_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:125)
   __netif_receive_skb_core.constprop.0 (net/core/dev.c:6103)
   ...
   __netif_receive_skb_one_core (net/core/dev.c:6214)
   netif_receive_skb (net/core/dev.c:6474)
   tun_get_user (drivers/net/tun.c:1966)
   tun_chr_write_iter (drivers/net/tun.c:2012)
   vfs_write (fs/read_write.c:687)
   ksys_write (fs/read_write.c:739)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 378e25357ac7 ("net: qualcomm: rmnet: Remove unnecessary device assignment")
Reported-by: co+4638111fe2a12980@bugs.sh
Closes: https://lore.kernel.org/netdev/ijg79FFMfIvKJbivdJEKvTO90Q9dTvyBkJck@bugs.sh/T/#u
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: assign in rmnet_map_deaggregate() instead of rmnet_map_command(),
    thank @Eric Dumazet.

 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 305ae15ae8f3..e6f48dc9fe64 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -394,6 +394,7 @@ struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
 	if (!skbn)
 		return NULL;
 
+	skbn->dev = skb->dev;
 	skb_reserve(skbn, RMNET_MAP_DEAGGR_HEADROOM);
 	skb_put(skbn, packet_len);
 	memcpy(skbn->data, skb->data, packet_len);
-- 
2.43.0

