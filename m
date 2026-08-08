Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C5355814
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187300; cv=none; b=tYR13Q/oz2CjDVmLLp5UY853zyxgagXVOLDPwLkNKUPCe6ILjceBp9CLBaJxuhtpbyF+pN3FU3iHsQ6e2nodlqPKv77MDBhVw0dcMWrzf4g0LeCeYr8xDEnJzVUsgOp+spIOBtkueHHhB67ol+Yp68qkEaGE85T+jXny/8NE9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187300; c=relaxed/simple;
	bh=3Z0CI0uIceg4PVOuJtw78UW56wWQDdjmHOKgAP2pJFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NdoYtRXnAuiUlaSaoxPL6hVL7g9h60Lly8bbb+3uurjO9rlNyBIWnWslulxZvx76gKtJvUXyC4EEv5EvmCVAo5cEQwMxESaYa1ITSSB7W25BC3hR3X1sb3n2eFhbA5O5ZpMoLGn/xuNFYkf2psqU2/7Y66RIWNlEcIZDSnKkmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMYo7IUM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMYo7IUM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f5d5dbf80so28403f8f.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786187297; x=1786792097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YGC0qs4udldeauBqKI42idTjvtWhQdYIzmlrmGDgBN8=;
        b=VMYo7IUMORk+DN6y6OG9RqrzF/3750LitQFDHs5hdiFBNWqAMxl4vr0+IofPG9a+Br
         DP+XUsNz9+8WtnqCY8M6/wecVe1TL09qK+m/9ZPXgGaQqxpMbqCi1I/YWEU+u5JpieID
         Ys2bhgIYG4RrQl4gmXAbZQg00N+diPmoCBH6c8uhDAm+TiypUAb1FLdZp5eu6zc2JcdX
         Y3civtHe+cwwXZki4j2SEe5BjJ5ww8HnASHfryLyK05c83LIyaL+qJ8dTTB4oizoQ/Rj
         hmpRhIvpFhCk7D0oRxgf6l2OYY5GHvhJIMKIM+0p8MRq4kQ7BBAGb072V94SLg85oHTn
         Xwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786187297; x=1786792097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGC0qs4udldeauBqKI42idTjvtWhQdYIzmlrmGDgBN8=;
        b=mue/4KU9HjnE5ESX3uYrqvV82+0/CASC267Dptk/ARKSUK3HQ7M4lao/rxlaF7+/lQ
         x+kcKEKNHfeqUzlr8oauKSNTWHa+vvWsp7E/aSapUJL0aVxsXDDp4aDhV/dEINcJFBYV
         3jnbP/90RsCXt88K2zpSEQrqVyx/1wusU9Y7bj/uZ094MjRYmgMwbXyEGZ9NenvqQmw1
         tgpq8mYQBtI0mMI+po6lcJW/MufYYds+ch+iI8QBMBvYscnyuGwNWLdKxGOQxLpk+RW4
         BZ9cRWB3r5z9P8Yf9Og0/RDfeQE9JeikaJn/GtYVyEn9i+vR7TCOH5Fy/iJJWZRjz5+i
         mq0A==
X-Gm-Message-State: AOJu0YyXHllXViL3IKYr2CwS7olaCw9n4Gqvl9Yj5KxHp8BFKdxui07m
	Ei00xC+eeQwzYzL9qhG7yizU1Sc9jmqVYOUtIfmD0dzW7jE2i1rNxjg/J1algmeIiNA=
X-Gm-Gg: AR+sD10BiTO3XCg14J+IRqGE0lNCmimbRKloCjaYamc+puf8aNpf3gQE6svcNondE8Z
	6byFqxka6zzZTkBgii6sR0N584NI6PUIjSDvD50krP5n+RE/9N3xP2wEAoQU4s1r34FTs+4Smig
	78dQ60Bj0dBA1SugWb/Q5TTJ7FqtUT8x+/VMWOi3Z85OpVpqFPaC3rEm/7rJHks4u7E6uFiPgEY
	ul69mqXtswM241WWY067rUrPea3bLvK4OZa5xsr3BlV1+sKkYGuz+YSHP/+q+wuSqRYRh8ssDyv
	o6/I6P12fk8AKrR2+n8HAD7FFk/hqjv/CYIsz6aQ+xPpF9d2uSUbMMSgsQRFCHb+TkNWhRiKQza
	q2YbVUC4dJDh0Etl3Ks6U70evPLSs0SmyLaXk4yuRW7cj60EYkAVEJCtMSDlBeR2eIGBiv8vRP5
	YUAUx4IYgWa0nugvmO1nKXwomJ7pb+ZaPmlUgNoE3uPCjihoS0xPyS7fBqRzTIgpJo5pvfsADkj
	6AapgTH7JyFABGAkL1D48ic60bVUWg58vNE/t3Lly5TUCNCb6JhkEkuIdVhXgooCpCLnvVnQl6v
	itisBAQn6eY8ZijjXYhpVQ==
X-Received: by 2002:a05:600c:c8c:b0:495:7561:a9cc with SMTP id 5b1f17b1804b1-4994e7d5c76mr193087175e9.4.1786187297100;
        Sat, 08 Aug 2026 04:08:17 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-031-173.77.179.pool.telefonica.de. [77.179.31.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220727bsm14964232f8f.33.2026.08.08.04.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 04:08:16 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	liuhangbin@gmail.com,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	kexinsun@smail.nju.edu.cn,
	arvid.brodin@alten.se,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net] net: hsr: free learned nodes on device setup failure
Date: Sat,  8 Aug 2026 13:08:14 +0200
Message-ID: <20260808110814.1637-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_dev_finalize() can fail after a lower-device RX handler has
already been registered (slave A is added before the failable slave B
and interlink adds). RX handlers run in softirq regardless of the
master's state, so frames received in that window can learn dynamic
nodes into node_db, and the error unwind never releases them.

Free both owned dynamic databases in the unwind, mirroring
hsr_dellink(). proxy_node_db is provably empty on every current error
exit (only interlink RX feeds it, and the interlink add is the last
failable step) and is freed for symmetry. The order is safe:
hsr_del_port() unregisters each RX handler with synchronize_net()
before hsr_del_nodes() runs, which removes remaining entries with
list_del_rcu() and defers their release with call_rcu() for readers
already under RCU.

Fixes: 81ba6afd6e64 ("net/hsr: Switch from dev_add_pack() to netdev_rx_handler_register()")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab19b..9c3078dd38c2 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -820,6 +820,8 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	hsr_del_ports(hsr);
 err_add_master:
 	hsr_del_self_node(hsr);
+	hsr_del_nodes(&hsr->node_db);
+	hsr_del_nodes(&hsr->proxy_node_db);
 
 	if (unregister)
 		unregister_netdevice(hsr_dev);
-- 
2.43.0

