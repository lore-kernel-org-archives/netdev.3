Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6473E5A0C
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702777; cv=none; b=mJXMc0hR4oedjJGet1A1zrmaSfV8Joeu3EfaMt24SbkKLic/1n1PQ6D1yJH5eXgIsC1DLCm0XxGEKzezv19I/HdPVvdT0yVVlHWErgtmVcDglI+LEe9VWRPCuMNA9s7jO3hA2+CPvweg0rdlyzurnRHWJbwTCKEam0JAFLNEk8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702777; c=relaxed/simple;
	bh=5DGBMHNqKO8hBWMRpZeiWO/8gLuazINjem6KokRy5sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgZTSqGwqS7O02TVtqv63BtdUb8kB1UBihcRkehtcxIRB1r0nqppGCqivI2uGI9jnIgLBjDwFpnWRdk0UpgiT4cvvatKGnZ/yGPNTTifjnfKU3rWlw6CK9PFq5xtgfIIvEz25m2Dbd7rUu3gPKrfNGNvsX7NhhGv1NbHA9UXrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCmw+uO/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCmw+uO/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db710396ffso11458265ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789702774; x=1790307574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILawRzLN/r3LsyBAHOfYBFFSxWw7SDBmyvoLxd7dlsc=;
        b=hCmw+uO/iWOXQCGKQhPQgLYqUhfkfPD9uEvIzd0WB3jIAUXuh0Lo7jy6z8yCQGXCdr
         qt6E+l8vtJqW2tWWQRxyGlNLdLa9fgzq2Y2Sd9jgQYEHwXYOjMKpk4VF9BfqZFenWAm3
         MdIK/8+A2tNygA8ohdzLjNKZDRAJKrlJPYSQw3OmZHR6xX2pTZwrT7dXU+Pj+LLhuCeK
         /FRagWmWX39WtGY6sDiZXqpM1i55zt/QXlKwplz7ZzgSbE05CyYEyLeHu5HOQBF2jqJ5
         OjmOZjFIKfl63DuqIIES+hxb6fmKtv6OunbxIphhUdN5tONwRu0wm7fFLnJfTpGqewC9
         oNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789702774; x=1790307574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ILawRzLN/r3LsyBAHOfYBFFSxWw7SDBmyvoLxd7dlsc=;
        b=yyykahyYpXqg9RLdqvfiibftFwdM865GN3bi6JuWjVpAFKgJZbzB/OA4/7wvVUVSXj
         O6v2r6Ks/hKFMS2GFOM89EGLC4466P5sllcpPsPIJ2gp4k65hra/kA0yLaFqZiNcMEWW
         30XM3r0xu6X57qnfmnvLNVLSeZ1AHu7sLn9/SGiEgX8QH/5HOmnWNmtcQyZxqJePt/pf
         b4p3x9DQmIY2wY2K2hcF+DZbipoEKt9sPFbRN7rFTwka/9tY4oV96X1FFXnbe5wkU7Gu
         TErVpNpN9HS2VHq+7tc5aWOpAwA5zH9SILlQfeBGqrd07fDUs6IYZrbPk04TTLGkBFy1
         ItZQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9qhr67g76/xguYzyNXxasoMv8jl90O5PRTmWGbYrOfjDNzRfVi6Y4bdB4R9BGQWXeYEXrl/o=@vger.kernel.org
X-Gm-Message-State: AFuF++mkCaKnnCDPBb6g0gFrGgAWHfVF3Rf/qu+H16CjpfcdBSEp05q2
	kHwUKD8g31M9QVONImwyQN5ygzteDDtQc3iicLnokvN0LzWo7Gd1FfYAhT40sv+Y51cRgg==
X-Gm-Gg: AYBFou3x7twd/1lJZP+QWSYFpo176asdDfffyPf4+P4lkDvDJgCK4Uapf39otRPZDLz
	kRadndQ0dzFzqiLviI3dczxDI87+XUKvFM4Wtb30Pel1uK+XAjGQYkR5+OQr3wENLbKaSCX3TOI
	vATw009Nfa401bXvsALkWZnKJJUHR7d+BxJ1rNt5GSJb4f7+ChCapnj4nZ7jnuUVfykn2EMTUDW
	9f5VpzNAfuICOAI18RbEp2LYxs4vLzye8SfCeeHdAbke8yVuEgIKpU2j4rw8PBKcadHIb0+M+AE
	UxuamgqaLeB3Xd7+7g/xhzeizOaQ8gYtWJrJTZplK6ch1NnZhINqJ1TQn2xOavdNN2peLsKezdb
	yC1SbIJjf2FQo4H5XORRT/p317CHlxPYVGaX4Owuo2I7kSZRd+MiY0JM/K86zErJa2iHMycYtO3
	4ifDF4M9eXVK+vOWn/WGbhJdhua+WgDjIrnd4wvZE1VoRNGICksOLqJ1s9w22N8ZxLZvzHPr1q2
	8gVWNqWNKXbe3e2ZPXK/gGs7RcHlOT0BDMmkgU=
X-Received: by 2002:a17:90b:4b11:b0:39e:4c97:ce0a with SMTP id 98e67ed59e1d1-39e4c97ceebmr3098526a91.43.1789702773711;
        Thu, 17 Sep 2026 20:39:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:79da:8b9b:16b2:8431])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144cdfe957asm1039280c88.7.2026.09.17.20.39.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 20:39:33 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 1/1] nfc: llcp: reject connect() on sockets not in LLCP_CLOSED state
Date: Fri, 18 Sep 2026 11:39:20 +0800
Message-ID: <20260918033920.85025-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918033920.85025-1-ndaugoing@gmail.com>
References: <20260918033920.85025-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a socket is bound via llcp_sock_bind(), its state transitions to
LLCP_BOUND and it is linked into the local->sockets hlist via
nfc_llcp_sock_link().

Currently, llcp_sock_connect() only checks if the socket is already
connected (LLCP_CONNECTED) or in progress (LLCP_CONNECTING):

	if (sk->sk_state == LLCP_CONNECTED) {
		ret = -EISCONN;
		goto error;
	}
	if (sk->sk_state == LLCP_CONNECTING) {
		ret = -EINPROGRESS;
		goto error;
	}

Crucially, it does not check for the LLCP_BOUND (or LLCP_LISTEN) state.
Previous fixes addressing CVE-2020-25670 / CVE-2020-25673 added the check
for LLCP_CONNECTING to prevent duplicate in-flight connection attempts
from corrupting the connecting_sockets list. However, they assumed any
other non-connected socket was in LLCP_CLOSED, leaving the LLCP_BOUND
state window unhandled.

If connect() is invoked on a socket that has already been bound:
1. llcp_sock_connect() silently overwrites llcp_sock->dev and
   llcp_sock->local without releasing previous references or freeing the
   bound service_name, leading to refcount and memory leaks.
2. The socket remains linked in local->sockets, while llcp_sock_connect()
   links it again into local->connecting_sockets via nfc_llcp_sock_link().
3. When connection confirmation (CC) arrives, nfc_llcp_recv_cc() executes:

	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
	nfc_llcp_sock_link(&local->sockets, sk);

   Because sk was never unlinked from local->sockets, the head.first of
   local->sockets still points to &sk->sk_node. The second
   hlist_add_head() sets sk->sk_node.next = sk->sk_node, producing a
   self-referential loop. Subsequent traversals of local->sockets
   (e.g. nfc_llcp_sock_get(), nfc_llcp_socket_release()) enter an
   infinite loop with spinlocks held, resulting in kernel soft-lockups.
4. Furthermore, if connect() specifies a different NFC device index than
   bind(), the socket remains linked on device A's socket list while
   being assigned to device B, causing cross-device socket confusion.

Fix this by ensuring that llcp_sock_connect() only accepts sockets in the
LLCP_CLOSED state, returning -EBADFD otherwise, matching the state check
behavior in llcp_sock_bind().

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 net/nfc/llcp_sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 5558d8a4d48b..66f12e9af2fd 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -689,6 +689,10 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr_unsized *_addr
 		ret = -EINPROGRESS;
 		goto error;
 	}
+	if (sk->sk_state != LLCP_CLOSED) {
+		ret = -EBADFD;
+		goto error;
+	}
 
 	dev = nfc_get_device(addr->dev_idx);
 	if (dev == NULL) {
-- 
2.53.0

