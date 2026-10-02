Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABC479864
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936701; cv=none; b=cj7YMI8FYEvKuGnCqo6jxoRVbUhmQQweXRjCdKvFhAUuGAHANP9Hi4ihwT+4ZWMf5Hy9jJ0BLWEggo/DSLUsHnTLdYOZqBOBV9+OtK2m213DIxS60KUwnTZ3LAsnPl6uX0Cee1lZLdbhjMzXQ2h1ID96+BcGOKbVrnetskMB1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936701; c=relaxed/simple;
	bh=4YJzicPTBuoA7igIVyVUJWSJqbvRmUaVYRLTcvOh8LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkHxWZOxO/Y9YA/2EItCnmU0yVjCnUFxQIPnpdTbE16ukqwpKzsjHh2/m7tc9ik91As2TVH7UJhQ5j+C8+ydvmJ/ekE+kkml1f1i1jxA97X7QfBX/qAxUV8e+q1m5nLSiVARHVbaSfmcZ9yp5ZIhN1KvVw3n8S4qzsnjxP1ULzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Gh7GVUSo; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Gh7GVUSo"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afe3b2383so2265238f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 03:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790936694; x=1791541494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2jhGHzuBi9orZg4iibCNwyA/QKReX4TldXys9igHWcI=;
        b=Gh7GVUSo+ZZw/wX5kXj88RY8wUPW2Lv6SMezZWFnPJSLlZf1sAzzwjqZtUTNgqYfuZ
         BqONU/vKgpzgAK6gXO3lJvm6BgtcFKCR3pi5Z6JF+1rjdHmPF/l//3UhgGlsxFnJiEtU
         W41d4Yq2w4FlZRew1jutG7WMjBAISPZ9gqqB/WSIDPsLofITo/ZBcAAI/GOedrzu8U18
         MMKnygO/pzdCYe7ctJtAE14Di0VQe7hWliSBgSPfe5uwA5kXmd6+s83GRYUrj3qcEMvU
         lhRxwKRdu+Z9VZoXJTkjThKVmvGNIYTjNNVmRZOy45Nx8mJwLcxYsmBXgEwmIyn35tEX
         Sy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936694; x=1791541494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2jhGHzuBi9orZg4iibCNwyA/QKReX4TldXys9igHWcI=;
        b=RJd97b09jG+yL0Wj9xW97eNlkIgvNKDoD1eQk5bKb0E9SminI3eMUr9HF2w7zUyZz+
         OLswLjwwsIYLomvbAIzVYC5QX+ZUJdREFfE3P6Jhfkbi16XZrSPL8bWWpTETmiqn+Mwo
         nPlhug1/BEQHoNM+LRromu87juYdBsBv1H1E7kw29+2IloOBzN8Dqd0j57goOYmeDypd
         WvVdBfec5b1JLu00wQ6njLUmuS0a7UEFZPf1QvCCoGFcCXGaQoVRufjnAZFqZhJOQuKs
         MejtrLFA9UcN2jInMUu/P5pAYrK8kDpZ9fyr16EaVq4aqMblG9iy6SezywZYhqxtBidg
         IRHg==
X-Gm-Message-State: AFq9FYKTBMHJXsfNgRAx1G5uD9Xs64kEW6iUbpiPu4DHx+IRDnE2L7Nd
	MB4F3Woo/3WxspYp6mpmoX+aUJ+9/kmu6bgB5voz6t5krZpFCqnR9SASdGzkxSRL/I0=
X-Gm-Gg: AYBFou31XThSRbRt0ohjaY2tgqXo8XNH6d1Oh5+TYpOG1lGdoYXW4hn6I5dB0yCrnFF
	CKnaom3AwaPIP+aF9wtdW+oBuS8uzUGCT2q+7G47+vijLfXMunBvwz8sbFXQpR+R4Z7bRKu/Btr
	2qAmE1k2eUuCstVvWwXHqjdIR6gxyvUxTS/bszFfU7CfKJ0YCVWoUEU3zCacObQUUTRctuySI2Z
	aOzLHq7G+TxZuEtBAZRGPJI7pAiiVAppU/KtuPb7DXiw1kmebNfnNdCxhbKhqolqz1AvoEMa5E3
	+vfGx3sJzzauA2FDGIegMAaR1S13vmCwdjMqxi1QwOVborIe8AuHKoG0edzXbqdjE3Tl+H6ZZWJ
	RhW3vlKrS3LeVEHdLS6MyGlEZIvTG1KaH21AsMOAEk+zteUxHdwPirNM+fXMzuFb4/HQOlbVvfr
	myNb3bapC7d48DI493KJFQMQVTk/9fXE7R0EwoHzTyESm9jg1Ecy4DtRlQKbx+eMoOThYoEM0/r
	lr5Ud0P
X-Received: by 2002:a05:6000:299c:10b0:485:8cc8:1f5f with SMTP id ffacd0b85a97d-48b12752b10mr3058775f8f.42.1790936694153;
        Fri, 02 Oct 2026 03:24:54 -0700 (PDT)
Received: from localhost ([2a02:168:9d56:1:9c5b:8aff:fed1:19b4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b380faaf9sm4599449f8f.22.2026.10.02.03.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 03:24:53 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Bruno Produit <bruno.produit@trailofbits.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] xfrm: espintcp: reserve partial message during allocation
Date: Fri,  2 Oct 2026 12:24:47 +0200
Message-ID: <20261002102447.148835-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

espintcp_sendmsg() builds a new message directly in ctx->partial. If
allocation fails, sk_stream_wait_memory() drops the socket lock while
the shared sk_msg remains unpublished with emsg->len equal to zero. A
concurrent sender can then reuse the same slot. If the first sender is
interrupted, its failure path frees state now owned by the second sender
while TCP may still be consuming it, causing a use-after-free.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reported-by: Kyle Zeng <kylebot@openai.com>
Assisted-by: Codex:gpt-5.6-cyber
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
Changes in v2:
- Add an ->owned flag to espintcp_msg
- Use ->owned instead of a local sk_msg

v1: https://lore.kernel.org/netdev/20260922145335.2016559-1-bruno.produit@trailofbits.com/

 include/net/espintcp.h |  1 +
 net/xfrm/espintcp.c    | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/net/espintcp.h b/include/net/espintcp.h
index c70efd704b6d..083c11373c16 100644
--- a/include/net/espintcp.h
+++ b/include/net/espintcp.h
@@ -15,6 +15,7 @@ struct espintcp_msg {
 	struct sk_buff *skb;
 	struct sk_msg skmsg;
+	bool owned;
 	int offset;
 	int len;
 };
 
 struct espintcp_ctx {
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 3e72b9f067b9..68b9201c98d3 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -251,6 +251,8 @@ static int espintcp_push_msgs(struct sock *sk, int flags)
 	struct espintcp_msg *emsg = &ctx->partial;
 	int err;
 
+	if (emsg->owned)
+		return -EAGAIN;
 	if (!emsg->len)
 		return 0;
 
@@ -274,6 +276,12 @@ static int espintcp_push_msgs(struct sock *sk, int flags)
 	return err;
 }
 
+static void espintcp_unreserve_msg(struct sock *sk, struct espintcp_msg *emsg)
+{
+	WRITE_ONCE(emsg->owned, false);
+	sk->sk_write_space(sk);
+}
+
 int espintcp_push_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
@@ -291,7 +299,7 @@ int espintcp_push_skb(struct sock *sk, struct sk_buff *skb)
 
 	espintcp_push_msgs(sk, 0);
 
-	if (emsg->len) {
+	if (emsg->owned || emsg->len) {
 		kfree_skb(skb);
 		return -ENOBUFS;
 	}
@@ -336,10 +344,11 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			err = -ENOBUFS;
 		goto unlock;
 	}
-	if (emsg->len) {
+	if (emsg->owned || emsg->len) {
 		err = -ENOBUFS;
 		goto unlock;
 	}
+	WRITE_ONCE(emsg->owned, true);
 
 	sk_msg_init(&emsg->skmsg);
 	while (1) {
@@ -368,9 +377,10 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto fail;
 
 	end = emsg->skmsg.sg.end;
-	emsg->len = size;
 	sk_msg_iter_var_prev(end);
 	sg_mark_end(sk_msg_elem(&emsg->skmsg, end));
+	emsg->len = size;
+	espintcp_unreserve_msg(sk, emsg);
 
 	tcp_rate_check_app_limited(sk);
 
@@ -383,7 +393,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 fail:
 	sk_msg_free(sk, &emsg->skmsg);
-	memset(emsg, 0, sizeof(*emsg));
+	espintcp_unreserve_msg(sk, emsg);
 unlock:
 	release_sock(sk);
 	return err;
@@ -549,8 +559,13 @@ static __poll_t espintcp_poll(struct file *file, struct socket *sock,
 {
 	struct sock *sk = sock->sk;
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
+	__poll_t mask;
+
+	mask = datagram_poll_queue(file, sock, wait, &ctx->ike_queue);
+	if (READ_ONCE(ctx->partial.owned))
+		mask &= ~(EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);
 
-	return datagram_poll_queue(file, sock, wait, &ctx->ike_queue);
+	return mask;
 }
 
 static void build_protos(struct proto *espintcp_prot,
-- 
2.53.0
