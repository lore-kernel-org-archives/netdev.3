Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0941D211
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887744; cv=none; b=gbga2odLI708ifPWNzUzSdQOc8xYLXm8kvj6gc52LUuWK18s+iDtq2lA18rZrYM4Pkt5QWS1bvjBq9FaoZD/NnBpLoFmTGkKS8OkcLtsXiexFQ74WolmWWpvr+d2TcLWIL9jRZ4rEgnhVczvtYuvyzHQ+bP+ONXrX/Jp9QgBs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887744; c=relaxed/simple;
	bh=ClJkwdr4rZBNNvHW63KM0qG/lIi8+S689RV7uQKY9Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WwGXBrg67EaalsoKhvYF9a//ENLB0vhCDu+V4eNxqXc7xYONrvaKuEsLP8TfiVi1AIBy6zr0Y+jHlxez/jQe7E6taAcGzEIaY8FiY9TFfIcbx6SHIMUbdHJmfXqOHixOq7GGkFfEX93T7tNIEt6XcChQYizbgomO3r9TThFgVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUVgtTi6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUVgtTi6"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso205228a12.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784887742; x=1785492542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KzhlHn5bk5IOC8WXzw9OkBpAQC409hC1IeVcT5n4rkk=;
        b=BUVgtTi67GyKSy8tbpU4WNlhqNSSWuJyfCikWzksIpTqxYehtYPiAB/zSnEeBENUYW
         rlFHMZCWuyk4a8CVVpiUi4AL8P2cxEz9W8XIXf22uY7olvtECHVVhWkCGPVJZdPRjl9j
         DjnTmsw+39wrRXUUbBwpEfP9Syzxyc5XJyOptFO9mgQdZO3Q0jiYy2gaJWqI1EuFp8n6
         LJ0RfGb3jl8YlR/6IKkAEe+AKMjAOPLlRemD/MsOiSZEjN0Pqwo9DnKcWbcyftxIforB
         q4K/afF5GJSw8mP+9SyDC6ewz6DLCZkCsBcBP+osSEEBkRPYz3vrqXuCj6NU3UdKCDff
         gBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887742; x=1785492542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KzhlHn5bk5IOC8WXzw9OkBpAQC409hC1IeVcT5n4rkk=;
        b=cSABHtDYMTfPAzdbntSjzuOS9jWM9tjr4ixoiDX2sk/T9HIie9Z9CP32PIH6p4ILlu
         xjnDLPaOJZfaliD+7PASErYz3y29tD8lEnU9S96glE80/frHtXzB+Wx3pceid3wpoDQp
         1wXCW5gEiUKedQ6Gn0pyI2K3F+al5zSspwc3NoonrqNvcj7nhGTqvPszkws0qbgPTzN7
         bbln5+PBJc3DP+ig8AgbQDGQ5SDyfpB2XqC1U4qJRG0U4ngkv+FbOSYt8k82UpbDvwv8
         WxO73auoj9WnKSYlRPVJSq75zzdqnBANC0pSk1b9kgjrhcPPF58AbOixD5RiHDgWfgsh
         rqMQ==
X-Gm-Message-State: AOJu0YxxbzrruFpIWaIZnO2kEU0XnRe5gcKrIci72ZyCNnrvvRCONmZf
	qfXrG9PdMerp3QknKHq5b/hgAJMIs6BnzZPgLr51cgyAOS1lmN8StIA=
X-Gm-Gg: AR+sD13F3h85sRKkH+q9fqB9cErVl+M9JK+4rIDRz5/A/eQXQ2LVnduarlJ+UvWGNI0
	YNgsiFhXCBLomb5UBKT5TDgrR5/iwVZ15Q3PJpB99OqsYHaEA1I520C7Lndn3eLNOgiyZG4csUo
	lJS2tMz17+DuM6z6+kKdZ0+y6unxBKet7qbLq8UnRwaLAvJj0jz4Zzpl1iK2vZf52ca2UjWejT1
	138qbk7oKd40Xaapd1fe/O1MdgHS5wZqh8nud7LaT5Rz59ligvlCTPolnEJc1AiipKE3TdvP+5G
	vd5u/h1uc5D0GGdTvhHPOzM0DCsp8GM4NviCT6m3ou3ibj1ALKQZuwMX9LPw4BCyWjdXPpRgtua
	kSiMUFQAWaZ9C5O4JMwZxhsXUyE7OikGTfua9QbhIFsKKoLVtODOlUEK4F6qEEq8gTIwoJ3oYV3
	CxQZi0ds4MhEri3zdt22t9ctBI5K8m8N69McSZ4g==
X-Received: by 2002:a05:6a21:338e:b0:3c4:397a:69ba with SMTP id adf61e73a8af0-3c44affe1dcmr7532992637.28.1784887741988;
        Fri, 24 Jul 2026 03:09:01 -0700 (PDT)
Received: from localhost.localdomain ([117.247.186.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc193f8sm47957715eec.1.2026.07.24.03.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:09:01 -0700 (PDT)
From: Mohammed Hashil M <mohammedhashil786@gmail.com>
X-Google-Original-From: Mohammed Hashil M <mohammed.hashil@dicortech.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed Hashil M <mohammed.hashil@dicortech.com>
Subject: [PATCH] macvlan: inherit needed_headroom/needed_tailroom from lower device
Date: Fri, 24 Jul 2026 15:38:32 +0530
Message-Id: <20260724100832.59153-1-mohammed.hashil@dicortech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macvlan_init() copies several properties from the lower device onto
the macvlan netdev (dev->features, dev->vlan_features,
dev->hard_header_len, TSO limits) but never copies needed_headroom
or needed_tailroom.

When the lower device declares extra needed_headroom/needed_tailroom
(e.g. because it must prepend/append its own hardware encapsulation
before a packet reaches the wire), a macvlan built on top of it does
not reserve that space. Depending on the lower driver, this can cause
outgoing packets to be silently dropped instead of forwarded, since
the driver xmit path finds insufficient headroom and has no fallback
to reallocate.

Fix this the same way vxlan already does for the same class of issue
(commit 0a35dc41fea6 ("vxlan: Add needed_headroom for lower device")):
copy needed_headroom and needed_tailroom from the lower device in
macvlan_init(), alongside the existing hard_header_len copy.

Signed-off-by: Mohammed Hashil M <mohammed.hashil@dicortech.com>
---
 drivers/net/macvlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 9a4bc99dbf53..70219011fcb2 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -954,6 +954,8 @@ static int macvlan_init(struct net_device *dev)
 	dev->lltx		= true;
 	netif_inherit_tso_max(dev, lowerdev);
 	dev->hard_header_len	= lowerdev->hard_header_len;
+	dev->needed_headroom	= lowerdev->needed_headroom;
+	dev->needed_tailroom	= lowerdev->needed_tailroom;
 	macvlan_set_lockdep_class(dev);
 
 	vlan->pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
-- 
2.34.1

