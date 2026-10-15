Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20D4CA779
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052260; cv=none; b=d4qK2OuK4wZWDr8v4QbTDCsvaAzvgv5z5Qt5q7G083bOf61oxywtCMKhZ6NPxq5LInbD0I6JC92FffT8lX8XBd6dmHeHB874EbV14P5vxSgRy40SbvqqDJM7IApFt/P5ar/4Nclx3+xGPXbPOYe0eJXGM7Mx+N4kq0TdaYKgNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052260; c=relaxed/simple;
	bh=/HnoRr6jTN7lhWQJjX7agqNJaK5Mj2EZ7UCIBTgv/SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNb1XBcPIrVZkc0fNmmeyhRlhlHwxUOMNPiIijr4joBDZVct3mjCN7dqSNThNdPjPE528FyKX+FCxRlDXjN+W9kEiK+98+wC7dlUo16uLHHN+zrz2jHBebKZs43Od4wUpj26qNW62KGSeBrh3l0OlABGmDKxC+T6HuUUB1XR5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e++FoW80; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e++FoW80"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49ff680331aso19303345e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 01:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792052253; x=1792657053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1wKZanZE44fFdmkSv3uEQgs6bQ7hBbf+Whca0W3g7zo=;
        b=e++FoW80yrrKTpIUOVXRJksmP/Rz4CMOF+4us3VnOgQbFzr8aYizm9GIn5FnI7oEgr
         ELFqMrzysgT6TCRbOSYrSX5WYIaaqX8AhuakaMqnrzYePxceQO7S4RFn+jau0epVrwRz
         q510/y8ZeV8EBUO3d9ZbrCh6tuXOnlRWWGx3KjuNyflrxuM9KpEt758up6TauiET+NvF
         SXogO2LLRQQCrStH0nq/I4Em2az0J9mqHYU/5ukJsy2NDW07rAQOiEMCIMltvpN4PRIq
         k9ZGJqRUdgO4xxusBBvViw4oxgKtNzrn9tij6lSIkl7l9yE8R1iYN4uf1/tHSNzdel64
         YZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052253; x=1792657053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wKZanZE44fFdmkSv3uEQgs6bQ7hBbf+Whca0W3g7zo=;
        b=ZoQqfd4XAEXyl2pLVFBT0qwEDZMwFKAzHQARRdSbd3dO5ZiKDvCScTHj+ZLRoC6DrQ
         lyg2H42WdZKEZa/avYPUUTAfTzOI1DJC7DFJSbMe1qZFYIXqbt209hatD3ju2P4yesHV
         rt0v+A3tPcGBTFbc6MMiNVS1oRPebtuGAP5XZkFgyODJF8nYJP/+QRDz8gDKR1l0EQxw
         3WccRfSI0CTA7cPKhgLA1KZpgI3spvZO6nMbM5e4C/ArSzWnI0dn7fLRURPD5FJLdu0D
         uLTnK/drLyTb1eAPIFm+tQRl9x5IIFSCV4wYI7tZpFGOn6XAgXxR7LGjOVMxRKq2MQuZ
         AtkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9rdjiqwhvLLMjkflj4hj4Y2epZwFDaQvWiC3AW11E5JInwcm7qia0U5WAbLdlE+o1NR+xcjc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJakjsD6i84AyYMEW3c3m0rvmvJPdW8OwljCrjTw2BYilmurGL0
	I3mDOoeHTa3lZ7dbBjsVujxKTXnPOAT94RgWMX4YLtD/iunhm+F4tQvB
X-Gm-Gg: AYBFou2hoVc8YxYdcpUF+J1w2PhsuxYcAPka05GIN+AxOoPto2e8Hg7qyYMWkSzvPZg
	GlSz+2Xg3uIkLeA27xC/aY6tihH/EN7xUUSKkaea3sWUXQiNb0YgQbWihMh0GB9q9RsBYEAfcnO
	iffNI4nSePMzbhUz0oWsEhP808de5G6Re9cQqy/Vev0rxYzM2Dyrse124Py3UpKgvCjJul8XwuS
	qaCIRhSXk+YPA1yPGrE4ybb5HBhcZR1pWnXm4nE9wVszjzrMnBUrKVTC1QokT3gxtt4cU7NPw0o
	177uoF6JsFNadRMeRrc3sWk1X2hhHaR1VYR7iUR29KYTUbCMHyB55pRwZGmthj7408yJSVBlPTW
	AcO5KY56RY/ZQmLfvhl50fcmsYXFUOJfTuQUq7g/09L9/X9dBjytumAVmAjBBDnlxVSl9KQI5kf
	q0l2NvjsIgcm/1Bg8yFi9yEsNPGvs9L1q0oD/3MRi879axXs75sDDLoQgaLUIfcR0NebrwYkrSJ
	/l2disPbX1Wxuz8tyRQPtJqrG6kVkktKzPF5b7Vaj7png==
X-Received: by 2002:a05:600c:524a:b0:4a1:8824:c9ba with SMTP id 5b1f17b1804b1-4a18e49234fmr374111135e9.18.1792052253328;
        Thu, 15 Oct 2026 01:17:33 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm16930322f8f.3.2026.10.15.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:17:32 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] rtnetlink: comment the RCU waits in unregister paths
Date: Thu, 15 Oct 2026 10:17:16 +0200
Message-ID: <20261015081723.404990-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_unregister_all() and rtnl_af_unregister() wait for RCU readers
before tearing down what those readers use, but do not say which
readers they are waiting for.

A missing wait is then easy to overlook: rtnl_link_unregister() lacked
its synchronize_rcu() until commit 3b70edea393d ("rtnetlink: wait for
RCU readers in rtnl_link_unregister()"). Add a comment to both waits,
naming the readers each one waits for.

Suggested-by: Eric Dumazet <edumazet@kernel.org>
Link: https://lore.kernel.org/CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
v2:
- Drop the comments on synchronize_srcu(), its argument already names
  the readers (Kuniyuki)
- Name rtnetlink_rcv_msg() and try_module_get() in the
  rtnl_unregister_all() comment (Kuniyuki)
- Mention the rtnl_af_ops walkers that do not take ops->srcu in the
  rtnl_af_unregister() comment

v1: https://lore.kernel.org/20261008124423.11543-1-parri.andrea@gmail.com

 net/core/rtnetlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 15bffafbf0a9c..d73dbc2c8ba0d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -526,6 +526,9 @@ void rtnl_unregister_all(int protocol)
 	}
 	rtnl_unlock();
 
+	/* Wait for rtnl_get_link() calls that rtnetlink_rcv_msg() makes
+	 * under RCU, before try_module_get().
+	 */
 	synchronize_net();
 
 	kfree(tab);
@@ -843,6 +846,9 @@ void rtnl_af_unregister(struct rtnl_af_ops *ops)
 	list_del_rcu(&ops->list);
 	spin_unlock(&rtnl_af_ops_lock);
 
+	/* Wait for rtnl_af_ops walkers that invoke callbacks without
+	 * ops->srcu, and for rtnl_af_lookup() readers not yet holding it.
+	 */
 	synchronize_rcu();
 	synchronize_srcu(&ops->srcu);
 	cleanup_srcu_struct(&ops->srcu);
-- 
2.53.0

