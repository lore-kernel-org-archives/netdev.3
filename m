Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9733C1F31;
	Sat,  1 Aug 2026 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611446; cv=none; b=Uqw2PLp7r+HxED0XxsqQj0P/qQvWgRK53uqAIwCzYl6PQsurxBTuPikXOZYuOZnHk+rzOZAxHlz3vNdXthAHmJruOATXeHnOMMFUuC4EGE2iSLUz5tq+6/09lFWFIT0LMwWnZ0+z+EAZLrUNVarm7s5z7gP+EpzrWVxoFsAMyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611446; c=relaxed/simple;
	bh=VK6SBqsnE5YIi1o0351TiI8AJ0uk9p0IdG9KkiMYDLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gb1XFxrJNWNYh0OyT7KAf7HlCHgQf5l9sRZEhYgE8ZFPf43c8ZM/AFn06tBHICd2Zipc5mtyPvxZE8KV6AWuMvLvuTRo+nG9SHAMQXQSHNmjcw+RyTlHok8gmQwBGKs3gIPLtMk7n9mJsBL+Jl7coIbFh6yLAo/6F/Hj/F2weto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=UUGAzCB8; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="UUGAzCB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pXMYke0VesPuOIDp/f0NqiHMD8i+P4XXtxBqjZdWrUc=;
  b=UUGAzCB86++ExaE/JgkmmpJzFJqGdVYYXUfz6ZowkbrlVUJV8sCK7j1k
   6rB2mrW7C3omFLYGtaA46w4MgaLpRuL7HtMBgIjD0rjKr6BHKhzeQIrUL
   Rx+iMvDK2BUGfZWCnhqpvPpB/3ceCeDATghN4EzzCkIe6y4rkSWVWOROD
   U=;
X-CSE-ConnectionGUID: WjfIcm84QLmTRANylv5/9w==
X-CSE-MsgGUID: KhKwzyw6SaCnw54Obp4flQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; 
   d="scan'208";a="288769012"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 21:10:08 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "David S. Miller" <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netlink: drop unneeded semicolon
Date: Sat,  1 Aug 2026 21:09:56 +0200
Message-Id: <20260801191002.1383835-10-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function-like macro expands to an expression, that expression
doesn't need a semicolon after it.  All uses have been verified to
have their own semicolons.

This was found using the following Coccinelle semantic patch:

@r@
identifier i : script:ocaml() { String.lowercase_ascii i = i };
expression e;
@@

*#define i(...) e;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/netlink/af_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 5202fe0b0..e6b1d9758 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -145,7 +145,7 @@ DEFINE_RWLOCK(nl_table_lock);
 EXPORT_SYMBOL_GPL(nl_table_lock);
 static atomic_t nl_table_users = ATOMIC_INIT(0);
 
-#define nl_deref_protected(X) rcu_dereference_protected(X, lockdep_is_held(&nl_table_lock));
+#define nl_deref_protected(X) rcu_dereference_protected(X, lockdep_is_held(&nl_table_lock))
 
 static BLOCKING_NOTIFIER_HEAD(netlink_chain);
 

