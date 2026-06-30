Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C53E3D96
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843694; cv=none; b=UCqhoUDtIROBlkpA659IeCoZwHxxWJuUMYCXkGdxcgc/mUzHb05c1EvWXs1tkx+N4Id2xzJcOtkBaI4vpYY8Ywlmx5XFSGucDJ8zn00yJxBKnP1qk5JmH2ABnk+gEXljrSnlWnSvul0VjgMBqtOc6YuFGZxP+tutnojlhUnLrFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843694; c=relaxed/simple;
	bh=2Ar/mW5Y5VgDOgKTlgwEKyY0xuG8RrEyry6lC5D6q8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9YwKann5SczYb5DgUXTCJUn9bNuQPJEbKQrjWL7tlXjDBHIhNG8VeELMxMuWsZDCpCt7WvfOkvufFPnr+rwS0f/u6t+qnWbyNM7NAhsm9pYOwftdlTvGa/Kw+cPAZV7oRl/UdcyLZZ5ClM+IIfQD4QOkKtj7gyq9PXoLzlTK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJsKu3No; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJsKu3No"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2c8017e981fso26658665ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843692; x=1783448492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLS+PGgTZx0teeb0doa9Yv/49/wXqR6ear68kfo8xTc=;
        b=JJsKu3No7tmU88RW08/exhbAH6EXkRDgPW9hQZccWXKKSTeUx05xiFqJhfMJNRnQHo
         16kRCwCGEA/BhmKkYHUQWN7CpubX99Ds99qQnrDXpiaevEvyLA5Jn+EIb9Pdoy5y3DLJ
         f7lKbILiQPRQv/1DX4P8lWzD6ys0KdmIvsHDaX3khfuOYoVyKStR+q7F+lXnIRGCYaVy
         tJs9R8dMXHes9kLzS5dxlTlaJw7exlibidePJ/oD6Fy5gozalt5+Vk5ndzK6bUxqSL+7
         hNH+RObbvIb5Je9gDDVO5vzlCc60HQpbsYoQ6fj09k25lkibHOfe/aIYQDeeSgX9UrWV
         +KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843692; x=1783448492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLS+PGgTZx0teeb0doa9Yv/49/wXqR6ear68kfo8xTc=;
        b=LWEbsVM/FL5teOcTmX1cxyb3zZeCdK/LItdlzY+H8ccCseev2q8GDii6peal8MHGqD
         +K5uGZfofW0gAZDhYW7iby3mThtIjtI7q7MrZD7vnMcjZXnlmtIpyvlL+vym1B39taoM
         oR9AjQHMXay+9sMNtu/thJ6r4G3n7OGbEY7zCwK2OfopGExK1xCKnDWy0AfTqesxLQwN
         gDBAebqMJLF3xR4LX5TJCiTeY5ee9yiQzDUx7ZvAAoP+e/ACEM17O7bPG6qTVUbL2uoi
         l4GZF2CGB3k6NzbPYeO70pLaenJ1avWngYIjkqJ7iT+uW01ms6VH3r5tDbDm8p7IbxEB
         EapQ==
X-Gm-Message-State: AOJu0Yy2ilrWw1b6vZjyw9iviqxVX/9oix//5ZeHa97RdIY/0nT6nUtn
	xxhMlM6o68AwHfl4UbG+ORZWi6uh2H8+5jU+FT5dSnsH+H+oIQDbeslfeeInWRjo
X-Gm-Gg: AfdE7cmEACvidADSm3lASr/G7mQlwKbNkODfP/kjVxuhi3Xzsc9Uty7AB2IGClc3ZVN
	LIgJq902U/U/nY3GFtJRoMYh/ggTlOMNpuF0LJHrrjnTrdj5uIhKI9uYU72Iwo+wkBVVUD2TGxn
	fuSNWXMVcx6cPLTm13oD/6VVGYjn2lmG/v02UKWbzB7aPqs+rAvS8sHQMPqfkEB+ShmNwBSBY9T
	TK3Re16CGmhKvETQOn3NuZI8vjLUnDRClL5RpXFS+FDWSdll2zKozYcqVeaB6+OVXIcD6B0PFdM
	YyDleZ0J4aPdUtB9dTGryy70b+j++5CnKSncTeGAvov/7ReIvFY5k3WzcEE8xBayXqubhMLjh+a
	O0/olqJgfA+AgbapM73ygCLej95S/D+1JigypxIsSMeKq21X3RT2Rr3uS5QaMexXGNBSfKmQN8L
	0YUbPu7g==
X-Received: by 2002:a17:903:2448:b0:2c9:99a2:d108 with SMTP id d9443c01a7336-2ca2ea32c6emr39162445ad.37.1782843692275;
        Tue, 30 Jun 2026 11:21:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a710b8sm19296075ad.1.2026.06.30.11.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:31 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 1/6] net: hold instance lock around NETDEV_DOWN/GOING_DOWN
Date: Tue, 30 Jun 2026 11:21:24 -0700
Message-ID: <20260630182129.1601784-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630182129.1601784-1-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mirror what call_netdevice_register_net_notifiers does but for the
teardown. Cover only DOWN and GOING_DOWN. UNREGISTER is still unlocked
because of the SW devices using dev_xxx methods.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..9d49493f4fb5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1912,9 +1912,11 @@ static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
 						struct net_device *dev)
 {
 	if (dev->flags & IFF_UP) {
+		netdev_lock_ops(dev);
 		call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
 					dev);
 		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
+		netdev_unlock_ops(dev);
 	}
 	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
 }
-- 
2.53.0-Meta

