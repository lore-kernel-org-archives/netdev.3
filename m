Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06E3C552E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086057; cv=none; b=ay34peFM8/zkbmYaKtaV8rfiDwQEkuvqmr1Q79NJ1acuEE+h1dp7pFx0qtA70kQYkFnfuIT3t2SgC3Ejg03pdUKDFApCw7qxs0oIAyW4CckJLlf5/qpqA96I/QnFaO6y+Eix/1SXwWlHHkoJHtv8ESWaQvpHBHCHS30hbAzrvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086057; c=relaxed/simple;
	bh=JiO1cEuDKEl/1aoZtilgDFytkzDCZaaqTK5Z2rUKTSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YmwueLwFtfewiq0ssf6gal8+TkWvqSZyE9wFfpGIENJDQ9w8t/imoZJQ749Pm7cYcshPBKfbb0DVVr3In7ekAY2cyTaFl/JuZQ9l+8rn/EyRVAXBXGTYxoaMWhTrX+3TwW3trHLhzhJ2E3HW6RPHVJ7EBXOzhCXDNnx2Ab6MMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhaAnc7U; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhaAnc7U"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so76729a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776086055; x=1776690855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KSy4P1gRlxJh/l7kCkYWi7TVy86zq+RIkasAHQsDV0=;
        b=rhaAnc7Ud0sLfcgKqeyhg/CH6unx/pEALlcgmDvcEiUwoFHPjkq0rkjCK6GEn46DYR
         q3Ha/Z4wCe4mm+H11YaT+yW1eRYFbfJjxSlPvh+W5uFgjmUYZ9yNi9yxFx5ZgyZy0HIC
         NyMIcgGwk+8prAzknDU/7DMg8fePhcgJiPL6PKrkIIUl+WYpk5kEWWFErWcd+uTSMOXE
         rwin8jVgme/rjtbPeFOvmePjyyQr5YngRj7Uc4SIhfcvHOXb7tNguAAc5B4rkOdCtUHI
         4905pnyu3yqN4CcM9B4nAKn3/9EIG31ZfX6FtCO5En0WK2euku4NLFZVIIF5gaFyVQ74
         Hbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776086055; x=1776690855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KSy4P1gRlxJh/l7kCkYWi7TVy86zq+RIkasAHQsDV0=;
        b=HDeG/H5ZFPubTd/DQtB2o317xdzbiv8nDXriNmxTyH+hlKl/rcooVoV8dPs2eBtcVq
         ZvwrIv1DATyB6JYFF9bpdlWGmJIaDGwrVEy7lELhKliIQ7JhNJo8/4AfwWntnLBrWX8H
         DIc0Zh/QhFLGZOz0a+P6O72AcoHytHtXwE2La6kPa9ElARegQqohi1lyYxDfACANRxkM
         w4ep/IPOHkkpJRomv1YiXPSF1xXJFaBg+mcJE6CBJ3wnWeSpU6CfKFjBcNa7F8ZSIEcH
         vz9iRGRA0u/16ZhD8J60IGgmd7d4ae4G7BcJ/i/542yNC/2UCZnX3MGGTvlNIi9Iras2
         9EaQ==
X-Gm-Message-State: AOJu0Yy6nmGABS5WZr3gq2pPmeD8QKz37gNw8pG9jBiprRdvAMGZywbl
	l6gN9993GgvrEh/42pob+ZmFiyzf6a/ROyoXv15H/KJdAbbDHl/MlfKWbB765A==
X-Gm-Gg: AeBDiesWdEUsx5x22BsGqHJsajOddgvURnOYeDl8v0xAG2eSeVFLg1A84X3XvZflUu2
	OrKqndiLNjbNJXiX5MvEyYNk7gEkzii4xPusjqYb9v38z6Gl2KEwU3BMPPrRiWcTxFYmHXrdK0s
	IUnsUqfzIUantxTrC3TDze/rjVj8ii1mm1RnmOcBB8VJFaaqLUj4U6Shg6Y5VqtOVu64fNU7+VT
	HcrtTU+oqXldkLEPBv417xl49EV8HmXGHQMhZW/rOVMqRvp1Q9c961FHm9C76rO1IifCVZoxCmC
	mxYZ6GNTnKZYk9yK/zCohgj4xC+qFaTSeXAtevGgRPTFP8/XX1CtE0XYtTWnfRg9zFiWM9XXd4b
	7ngc5xVtRwhAaioSZm4+t1E2tvEOJxCDQ1EQwj55+s3AopnTrV6y39GhywVJ8Y9DexudzAfl7iK
	4tEXllViMmeh/uasXtvCDzCd+hhMsdn9I3bCa1vv8cqXsmB/ctUanh5vuZd5g=
X-Received: by 2002:a17:90a:d403:b0:35b:b52d:f34d with SMTP id 98e67ed59e1d1-35e42747d68mr11801461a91.5.1776086054691;
        Mon, 13 Apr 2026 06:14:14 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4131cfc4sm14527246a91.11.2026.04.13.06.14.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 06:14:14 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH v2] vsock/virtio: fix accept queue count leak on transport mismatch
Date: Mon, 13 Apr 2026 21:14:09 +0800
Message-Id: <20260413131409.19022-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_transport_recv_listen() calls sk_acceptq_added() before
vsock_assign_transport(). If vsock_assign_transport() fails or
selects a different transport, the error path returns without
calling sk_acceptq_removed(), permanently incrementing
sk_ack_backlog.

After approximately backlog+1 such failures, sk_acceptq_is_full()
returns true, causing the listener to reject all new connections.

Fix by moving sk_acceptq_added() to after the transport validation,
matching the pattern used by vmci_transport and hyperv_transport.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..e01d983488e5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1560,8 +1560,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return -ENOMEM;
 	}
 
-	sk_acceptq_added(sk);
-
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
 	child->sk_state = TCP_ESTABLISHED;
@@ -1583,6 +1581,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return ret;
 	}
 
+	sk_acceptq_added(sk);
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
-- 
2.39.3 (Apple Git-145)

