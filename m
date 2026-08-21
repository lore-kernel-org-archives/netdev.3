Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C2393DF0
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308396; cv=none; b=Sk7Bk8ZCtVfl/gWgPGnPlKK+kjKOp/TZOY/F4Q5+Tmpjt2OHV27UAMA1kQf2ruSOmfn9GMbms24kx2DNiVqQfQ3AwLp7eGUg3tbEhb4gzFz9oNtEPjlRsKGcjqcBYLZPrWjnwFK6HpYN1JiYCQRr1KV7DnFQS2EzoRVRfQ2k9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308396; c=relaxed/simple;
	bh=P9LNGp4ErkxhdCsTUyDwbamdFttHanhpRzoX604x2UI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PGet9+ZRRqGZHUxrenGQKmwVh+NKUYMNXVtpaHxS1Gc55kB/XXNrQGX+7zqByylY8hXj9HgwdOdfQ8QgKafJrMe7cchYSETrgig9e2KWl2Ic77x47yZWcdwDnYIndXicNz5W2jRjXQPdIv4V8p/XQ/7HVuKgbhDxYFqap0pJIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch9M24/g; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch9M24/g"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8111c0c7561so12968707b3.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787308384; x=1787913184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZJG1RQ6i/ZR/FqUkuEQhANL+pwQMNfsxmBOMfyZT2Bc=;
        b=ch9M24/g25CCliIkmjJU1zZvAaiepCNyvJDX7DjUfftSa7xDAQHzpD4yVv+aroD8EY
         CVm8RBrbiynN2MlY+nYHSVHWNdcth4ZZQ2CoscYG09EdbBmlWix07xMh841xq8mS0hVt
         NChOP3lfxJWOl7T9qlsaWC1xY8jz8R9ZuKcesOsGt6JZcXbv00PMQPJZx863lZN5/r7M
         u+nqy7CptpLHhGzn00UCIzHQIIjf1mbS3UfsaVICpHhNw/xKmDfatpYwVe4ktzlN1PFO
         VN+Qxz+X5FecILHdu2lybAPOgkycrGbdSX5dQBAqxFMOjF5fnU76+0ojOkfEMURFtkn4
         ikFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308384; x=1787913184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZJG1RQ6i/ZR/FqUkuEQhANL+pwQMNfsxmBOMfyZT2Bc=;
        b=Q9BX96atj2n97r4dR6hr5q2BR2Cdji4K3GWSmMVvgxixJsCGI1HJRsI4yL46DPe4FA
         nhs6uzRLc8hnnePtanxEyI0UtjMQ1TTRKnaGa2d8+uNlOs5xYuvKbCtvZi9lhfacYJsR
         RMlgEUkYJadj0XURSA5K3GNOwlGoV29doUhFKoQ/ijYgeUCUq6cb/b9jaHH36JMe80dt
         BoVK7fcT/zMy1ttcr8A1Jf0WhRZB882DkKTL+TpZlhMGtKiYVRbT3aj8nPbq3aB2Oo+D
         vbCrC2pMYBLShXRGqMY94tJ1NsnViZ2OmQnQtawJK4IcJwyE6w3SxqZntBrCps5IMnkg
         RquQ==
X-Forwarded-Encrypted: i=1; AHgh+RoItk8pt52y7RF4JWTsEXlM33GZwpzmn5zrOTCc3Pj/11+HrFHri2lB02Cn1E/SvROvHAtsCLc=@vger.kernel.org
X-Gm-Message-State: AFuF++kQecpxDAwPdDzLsKWfEA/bXfjKKEi6NyRahqeUpPLTpyI2rWD1
	B/mKrLlcJjwjqSWZ+gnOYGFR5bpTC4n3EhJIhuqYDGqiDertRNogGy3N
X-Gm-Gg: AR+sD13dTYKVFQRjyyclVrsVJ9XyoKO1Wn5/CixEEoedrnUBSGCztp1wCLZFiUSwop7
	ypo73VNY9hbvrLzSsN30ZdvNLTFRKQGyGE7nao/8TIckrf0jUebeOD6xQ1U++pFCWB7jSBEhZfS
	nT3FGZSpeY0NHnlDLO5pBUo++Mt895bIAgzydE0bBtzGim1SKfae8y8IX7q7pmzEGojGfFpu2yx
	FPoese6vjlLN3RA4WT4dGQLTR5Odw2D0Y5fAbQfF2SzyM4X/qN6r+Y7BNgBZmZ42B0031X0R4nR
	G3usi7os5p2U4cBOAmuH4ATnv1Ha3AdBJ6beCeXqz8BHlScXv5xTckN7ngHZdFfmx0hL6XxJTj/
	oxYcW/bkrUnR+fXu+QhmnMaewMIl0TLVkZE3cSpHWTChRrdnWjRqZ8RG5ekVNrues0HbGESl9Kw
	rn/GSYa1mV5gphlw/hAis3xaZwrUNcVtrkywAvvmRUI+1BdTjrmRDguXhkiMtPv4P/odViHLdkq
	3MP
X-Received: by 2002:a05:690c:e68d:10b0:81e:eb11:6e5f with SMTP id 00721157ae682-849f6c946edmr17102527b3.34.1787308383954;
        Fri, 21 Aug 2026 03:33:03 -0700 (PDT)
Received: from jdoh-CompSec.. ([141.223.124.60])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84512c408a3sm37632227b3.18.2026.08.21.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:33:03 -0700 (PDT)
From: Junwoong Doh <jdoh.kernel@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Junwoong Doh <jdoh.kernel@gmail.com>
Subject: [PATCH net v2] nfc: llcp: fix NULL pointer dereference race in nfc_llcp_send_ui_frame()
Date: Fri, 21 Aug 2026 19:32:44 +0900
Message-Id: <20260821103244.72313-1-jdoh.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_send_ui_frame() checks whether sock->local is NULL, but it is
called by llcp_sock_sendmsg() without the socket lock held, which opens
a window for a race condition. Between the sock->local check and the
sock->dev use in nfc_alloc_send_skb(), llcp_sock_bind() can run
concurrently and set both sock->local and sock->dev to NULL, which can
lead to a NULL pointer dereference in nfc_alloc_send_skb().

Take a reference to sock->local under the socket lock and pass it to
nfc_llcp_send_ui_frame(), which now uses the pinned local->dev instead
of re-reading sock->dev. nfc_llcp_local_get() also pins the nfc_dev, so
both stay valid against a concurrent llcp_sock_bind().

Fixes: dded08927ca3 ("nfc: llcp: fix NULL error pointer dereference on sendmsg() after failed bind()")
Signed-off-by: Junwoong Doh <jdoh.kernel@gmail.com>
Link: https://lore.kernel.org/all/a89d0419-8bcf-40a2-b52d-3e5d911f11da@gmail.com/
---
v2:
  - Changed locking to refcounting to avoid holding the socket lock
    across the blocking send.

v1: https://lore.kernel.org/all/20260725115556.1250160-1-jdoh.kernel@gmail.com/

 net/nfc/llcp.h          |  4 +++-
 net/nfc/llcp_commands.c | 10 +++-------
 net/nfc/llcp_core.c     |  2 +-
 net/nfc/llcp_sock.c     | 10 ++++++++--
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index d8345ed57c95..3ff9729daf63 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -201,6 +201,7 @@ void nfc_llcp_sock_link(struct llcp_sock_list *l, struct sock *s);
 void nfc_llcp_sock_unlink(struct llcp_sock_list *l, struct sock *s);
 void nfc_llcp_socket_remote_param_init(struct nfc_llcp_sock *sock);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
+struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local);
 int nfc_llcp_local_put(struct nfc_llcp_local *local);
 u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 			 struct nfc_llcp_sock *sock);
@@ -243,7 +244,8 @@ int nfc_llcp_send_dm(struct nfc_llcp_local *local, u8 ssap, u8 dsap, u8 reason);
 int nfc_llcp_send_disconnect(struct nfc_llcp_sock *sock);
 int nfc_llcp_send_i_frame(struct nfc_llcp_sock *sock,
 			  struct msghdr *msg, size_t len);
-int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
+int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock,
+			   struct nfc_llcp_local *local, u8 ssap, u8 dsap,
 			   struct msghdr *msg, size_t len);
 int nfc_llcp_send_rr(struct nfc_llcp_sock *sock);
 
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index ca89fe967d6a..1549ed2631f5 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -740,11 +740,11 @@ int nfc_llcp_send_i_frame(struct nfc_llcp_sock *sock,
 	return len;
 }
 
-int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
+int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock,
+			   struct nfc_llcp_local *local, u8 ssap, u8 dsap,
 			   struct msghdr *msg, size_t len)
 {
 	struct sk_buff *pdu;
-	struct nfc_llcp_local *local;
 	size_t frag_len = 0, remaining_len;
 	u8 *msg_ptr, *msg_data;
 	u16 remote_miu;
@@ -752,10 +752,6 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 
 	pr_debug("Send UI frame len %zd\n", len);
 
-	local = sock->local;
-	if (local == NULL)
-		return -ENODEV;
-
 	msg_data = kmalloc(len, GFP_USER | __GFP_NOWARN);
 	if (msg_data == NULL)
 		return -ENOMEM;
@@ -777,7 +773,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		pr_debug("Fragment %zd bytes remaining %zd",
 			 frag_len, remaining_len);
 
-		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, 0,
+		pdu = nfc_alloc_send_skb(local->dev, &sock->sk, 0,
 					 frag_len + LLCP_HEADER_SIZE, &err);
 		if (pdu == NULL) {
 			pr_err("Could not allocate PDU (error=%d)\n", err);
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index cac1b5487064..52e72399d731 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -143,7 +143,7 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 	write_unlock(&local->raw_sockets.lock);
 }
 
-static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
+struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
 	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
 	 * we hold a reference to local, we also need to hold a reference to
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 5558d8a4d48b..4d38025e8213 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -787,6 +787,7 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
+	struct nfc_llcp_local *local;
 	int ret;
 
 	pr_debug("sock %p sk %p", sock, sk);
@@ -819,10 +820,15 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			return -EINVAL;
 		}
 
+		local = nfc_llcp_local_get(llcp_sock->local);
 		release_sock(sk);
+		if (!local)
+			return -ENODEV;
 
-		return nfc_llcp_send_ui_frame(llcp_sock, addr->dsap, addr->ssap,
-					      msg, len);
+		ret = nfc_llcp_send_ui_frame(llcp_sock, local, addr->dsap,
+					     addr->ssap, msg, len);
+		nfc_llcp_local_put(local);
+		return ret;
 	}
 
 	if (sk->sk_state != LLCP_CONNECTED) {
-- 
2.34.1

