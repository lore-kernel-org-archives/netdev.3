Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAFC3AEF3A
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682552; cv=none; b=Yc51tikknZzOHhiurIQHhZDhTdfgFh9MFp8rVM7dc1Rp86MrthQLloqvVEdEdI3GMWz1JGCZ8BS95pRYfN21W8uMKRaacntk/TdAqoA8KzpWlCWD4JnSSv8Nq5lpE3gkqEN+HTJjULiX4xs+gGyumgKh/XBg12TgdncWD3/S4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682552; c=relaxed/simple;
	bh=IIELrcZjQaM+R/WjXfTSMq+xkgqRBe/9+IjDCcmboY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rUTytH5c0ze4pf60nzC+C7EkjFOadJYEeHsyMwAtFo7D2/J0/jBkwFlV/bX9YE1e+I4lQ65U71DPJXPQmlqXyvLwhsRRbHVQhUKu5rFELliwIsQ34v7LSR2Mh1Wcj75yDwx91Jdmk2DH5hLVCd01Yubh3IsUeM4CkDYlkhVh6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=DH+cS1hZ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="DH+cS1hZ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so635045e9.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789682548; x=1790287348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/yXPaD69b7u/Az65Ta16/Sktw7FkIXu2IrXlAc4/yg=;
        b=DH+cS1hZKItHGeqjpqxamnU3R0zjFzilfSF/5vnQu+48gUYb5zNdDgVJaMQ8wOg/kU
         kEHceQkTwoMLM4AEeJ+4YegNnuSt6iRRm+sgg0p9SB3nqc3iqt7EJriEyIuZ509RmqVn
         U618L8C/0Jxy+v+qBZuqKa9ZcA5qvztZ2GoCEvBdFf04I3CZvyRDvuyFCUTMLJedlu/Q
         LuF0Vpbryo1u1ycuUnAzg/ZYrdPTC7fnx8XzPnQPwXTNwe16HUo1MTqceJmt6skg/ODR
         QH33d6KVLYw/5VZofLUDKVR/X78qTJY5e+IX27G72QQeTcigsgvwbcI2CmCe0i+YphSJ
         oZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682548; x=1790287348;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/yXPaD69b7u/Az65Ta16/Sktw7FkIXu2IrXlAc4/yg=;
        b=ZcrL8i/pomfhRwv4xMRoHDy/Y3WevA+XexYJIW7jBH81Zc2y5Lf7WFOzIXt47kt3dc
         8eDtrZAT1M9Jny8yDJf27b4wfniGFg9Gw1rZahpR7SP73Vy4QdlO97sL0sDxAB3EcYrU
         jpEZLfm/bkFbUdCjbiUFzXFfQqzFRUVGuXNv3bSCAY2b0+Y7F3qWSDwAi7QHt9gR6vOs
         RhQ1MtsOSYXYAt+jiWO3w045bdIfrqzTY4g4ahoRxr6tYqTFVuCHIA8d1w3JcDrGojQI
         qVqYGiQ161mqs+YbObRJr9g2ZTm3aCt7VSpvyaE7QsMVSCsfs68WDRABwTet+xfcYmB1
         93Fw==
X-Forwarded-Encrypted: i=1; AKwUvBwXEl8fBRAfFkQwYQcuqlnesR/jNdEI42T8wIpkNdQC1+uQ2RFJzs0scSzO6vU5ELBo7aZTndo=@vger.kernel.org
X-Gm-Message-State: AFuF++kolL3GxXELecBJ0qDxr6l0Rg27WbmuH2t7uCSfaU7IgaXRqDr3
	t5rqU/O309SFC9y0AaQJd9ovtXeTVi52BEjLB49tgWXSKzDySCjor/VBEyKHw5LO0Yg=
X-Gm-Gg: AYBFou3d1Afh03/ROFVPxciHAIws1nGhU3iSp6XNm4OgF2En2Wv1XQxb3LNavb7oje8
	67e68LxoMGyYlPPpbPCCwKQbIQtUceNpeDTKGHJDM9FjCJpRLOOdyydYhCrr6NbEunXUpCz0v9d
	IScllH5WrQGcRKXW2mO+gb027GFJb7GedUU9PzWMFRqAu6aN02pm2+ajjtwI/4SZBeMZMyQKBk7
	SN/KYg2Nbyt8qPE7vGBhNWNORqk/dNftpIlrmWQsGdMVEWRR+bHBPBqkCbfTKXvylhEnAIBDZrF
	EB9FW2E6MQQairRrC7WV4WnfjBXVr+ybktv4yIe0YArhhd6IFlI7dBeh04XZSgViqvk7ZGDb1aM
	UBDBr6FUl1h1JUdo4LAfIqIoQrdB5T0UoOgrAVyyTTXp7v18wR/RziJbhKxDr2sbGG49aU38F23
	QwJ2amI4EmWTId7M+7J9KiWGk9VQ+PhmxPJcxmCkDIYj9aY+v7UrgMQGs0nky5Av+hG8Avx9U+V
	4L7T9eQjgJxuX8ivdhmcpmNVUGNnNcVxJ10IBMLvj4ozjE=
X-Received: by 2002:a05:600c:83c8:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-49fc5851e92mr2295905e9.30.1789682548680;
        Thu, 17 Sep 2026 15:02:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:744c:a1ba:d233:283a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm106258905e9.13.2026.09.17.15.02.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 15:02:28 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>
Cc: pv-drivers.linux@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] vsock/vmci: harden datagram receive access check (netns bypass + cached_peer race)
Date: Fri, 18 Sep 2026 00:02:24 +0200
Message-ID: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vmci_transport_allow_dgram() gates delivery of incoming VMCI datagrams. It
has two problems, both in this one function, fixed together here.

1. Namespace bypass: the send hook vmci_transport_dgram_allow() refuses
   datagrams when the socket's netns is not in global mode
   (vsock_net_mode_global()), but the receive path never checks it. A socket
   bound in a non-global (local) netns therefore receives datagrams from
   peers it could never send to, defeating namespace isolation.

2. Data race / stale ACL: the decision was cached in vsock->cached_peer and
   vsock->cached_peer_allow_dgram with an unsynchronized check-then-set.
   The function is called both from the lockless receive tasklet
   (vmci_transport_recv_dgram_cb(), no socket lock) and from the lock_sock()
   send path; lock_sock() does not exclude bottom halves, so the two contexts
   race on those fields. An interleave can return a stale 'allow' for a
   VMCI_PRIVILEGE_FLAG_RESTRICTED peer (and it is a plain data race
   regardless). The in-code comment claiming the fields are never modified
   outside create/destruct is contradicted by the send path.

Add the symmetric net-mode check and drop the cache, evaluating the decision
on every datagram; there is no shared mutable state left to race. The now
unused cached_peer{,_allow_dgram} members can be removed in a follow-up.

Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
---
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -529,18 +529,25 @@
 	if (VMADDR_CID_HYPERVISOR == peer_cid)
 		return true;
 
-	if (vsock->cached_peer != peer_cid) {
-		vsock->cached_peer = peer_cid;
-		if (!vmci_transport_is_trusted(vsock, peer_cid) &&
-		    (vmci_context_get_priv_flags(peer_cid) &
-		     VMCI_PRIVILEGE_FLAG_RESTRICTED)) {
-			vsock->cached_peer_allow_dgram = false;
-		} else {
-			vsock->cached_peer_allow_dgram = true;
-		}
-	}
+	/* Enforce the per-netns mode on the receive path, symmetrically with
+	 * the send hook vmci_transport_dgram_allow(): a socket in a non-global
+	 * (local) netns must not receive datagrams it could never send.
+	 */
+	if (!vsock_net_mode_global(vsock))
+		return false;
 
-	return vsock->cached_peer_allow_dgram;
+	/* Evaluate on every datagram instead of caching the decision in
+	 * vsock->cached_peer{,_allow_dgram}: those fields were an
+	 * unsynchronized check-then-set shared between the lockless receive
+	 * tasklet and the lock_sock() send path, which could return a stale
+	 * 'allow' for a restricted peer.
+	 */
+	if (!vmci_transport_is_trusted(vsock, peer_cid) &&
+	    (vmci_context_get_priv_flags(peer_cid) &
+	     VMCI_PRIVILEGE_FLAG_RESTRICTED))
+		return false;
+
+	return true;
 }
 
 static int
