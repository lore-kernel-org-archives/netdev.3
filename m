Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431930;
	b=R9Yqs4pIA0mlHcttSLWZeVF1YvokKbdLQodlrdJhIqZp6zEPu33d+pXpSzZtDK7aYmI7
	 EOYj2zYUjaPZRPo8KDY7ysEWpIKF/iLjR+FHk5o73bEN11qLK8zUV/HnPzxboQQcQsYfM
	 uGSbxN3NrTEgFSrkyjFSsCFPCjUdnj/8dcDhdwHwp4Awlz3z8WvYXqBwmBYXllXyzpFLB
	 yMAT7kP7/MHC3fxuFYiQPSoiCHuDZwE5UcCXnv3jAzNELvNK2tUt3XRhUO+5F+26eMLnw
	 E3vZ8e8gpB5heFUpQfQr1mihWy5+G9mR0kOD54CLQhvx1Y9T6y6aIbqOtSQ5udxDjYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=R8+wlNGYlxpYSaKxrbBJvwUvjiV/RV0FPa1D8XSztvU=;
	b=sCv5CKiPB/PHYRvwwRAog7Au29a/aDwnhYbViVJPB0OTFOj3+tiLZcATPVcgeGlasvmk
	 ihlho2zDGtGlLc9THiykWMEbggw7pZ1HevmhWO1CHGSMR6YX3QetVucah3pN0YF94nWaU
	 dDEDeM9xpKamNR/Sdj7ysrlyHBc9Hp8UivgRNAJg37jONTXh7FHODstptjFlq3sNaMvtV
	 l9Q37ZQPY6frBsMlN8OXZ4N70g1Md9oU0TrEqikcqPYXK/pcARwyfbnUUDyNkDpZS51CK
	 x5X2/CSfYgK3VT6vKS4Bp+c2iLPBzUA937arPugMqwu0EygLjsSyUSUjtQXR0rhHz0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kaifengw.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LQD2GTB6;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1618606A328
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1618606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaifengw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LQD2GTB6
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so5080582eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792431929; x=1793036729; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R8+wlNGYlxpYSaKxrbBJvwUvjiV/RV0FPa1D8XSztvU=;
        b=LQD2GTB6PLaX0bThFWl+XZffdUyTcAuaAN70cm1yC1ySpTFQt61Xhf+TIMJ+jlO+Dl
         E/8Yi7LkjO+6srGPAROMw1udnTy7czZITXsXnmd7R7DDqu4gMNPLvmzO7lttyNh07so4
         fmcK6q+2JX0a4M5skig3LJW7TeLuUOd7eJ3+AV7V/JGqBvz9/fCGDPNnDIqlJWxbHx8m
         kUHckyhvpC6jd7elQVLe/0ktcRaPQ42Fog6SX5nJyfYEALrDxCKkTLgsDR0IbVjJCfm0
         EqPp2je/fDGr5RiNDLvMqQuz/yCEp8mNOKa56ZmgXZfnqT20zHVVMthX6am++RJ/H2JQ
         KlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431929; x=1793036729;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8+wlNGYlxpYSaKxrbBJvwUvjiV/RV0FPa1D8XSztvU=;
        b=FsrGBXHED0WCsQLp3K1aEu7WwgmkBjpllCxYtGQ2J+wMX3MExWFM33lMilwU/pkTEi
         71+omdcJPU09vbylur3p0Q2kLys0MYITyp4rguNGgiAdSw1Z9xII4V403lyO4hPGNfht
         lJh/3cS+z86XpJPE9bLS7MAOUsVvWYiQ06x7T96mow9crtIiBHemPVhbjuO8wlHJI5se
         dGosKUwlErEQC6WvaA9e09Us5FQJqOCgyZdG8MDc0pHXSPB/AYZHPKNmX6Kqr3C9M94M
         oviVvm/6DmbpBch/jdrK9/m5YUHjUECSLnPWomHoj5KYfTgHIc6kto9cURDPWSavRXvr
         272w==
X-Gm-Message-State: AFq9FYINjCqif8jorYO50AGBliy3FRx4UWeJ/DY09exI1sPwXWXPYMP7
	U6/2Aj+oLioNy+FhAn3OyaLLONcyc1+dmz1yUF/7WKMcxh+HlBp8RG+zDYjypJ7nfBO+w5Y61Xd
	rYVVgRSmqJcwy+F37ldwiGtDbyafqf4fqakBdhnqkNXMaJ1wlxZYpnr2CiBTFu80/xSGy8cchV3
	uyVXEyfps9/vD22R3qHDQi7LL8ZKKgkWW9Ju2I7bDF0nzFdHA=
X-Received: from dyox39.prod.google.com ([2002:a05:7300:7fa7:b0:359:ff6e:96f4])
 (user=kaifengw job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:88d0:10b0:35d:ea6f:b85e with SMTP id 5a478bee46e88-3619e926239mr12480074eec.1.1792431928540;
 Mon, 19 Oct 2026 10:45:28 -0700 (PDT)
Date: Mon, 19 Oct 2026 17:45:22 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019174522.55644-1-kaifengw@google.com>
Subject: [PATCH net v2] tcp: reject devmem tx with fastopen and repair
From: Kaifeng Wang <kaifengw@google.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	asml.silence@gmail.com, almasrymina@google.com, willemb@google.com, 
	kaiyuanz@google.com, sdf@fomichev.me, linux-kernel@vger.kernel.org, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_sendmsg_locked() enforces that devmem TX can only proceed if the
zero-copy path is active and a valid dmabuf binding exists. However,
subsequent branches in tcp_sendmsg_locked() can still intercept the
message before it reaches the devmem zero-copy loop:

1. TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT):
   If TCP_FASTOPEN_CONNECT is set, the socket may have a valid dst with
   NETIF_F_SG (so zc == MSG_ZEROCOPY and binding is present), but
   tcp_sendmsg_fastopen() -> tcp_send_syn_data() will use
   copy_page_from_iter() to byte-copy from the iterator. Since iov_base
   represents dma-buf offsets rather than user virtual addresses, this
   misinterprets offsets as user pointers and copies the caller's memory
   at those addresses into the SYN packet.

2. TCP repair mode:
   If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() similarly
   calls skb_copy_datagram_from_iter(), byte-copying from the iterator.

Neither path supports or makes sense for devmem transmission. Reject
devmem sends inside the Fast Open and TCP repair branches when a devmem
binding is present. Checking inside the tp->repair branch also covers
the case where repair mode is enabled while sk_stream_wait_connect()
drops the socket lock.

Additionally, drop the !sockc_err gate from the devmem validation check
and return sockc_err if set. Otherwise, if a valid SCM_DEVMEM_DMABUF is
followed by a failing cmsg, sockc.dmabuf_id remains set while binding is
not acquired, allowing the Fast Open and TCP_RECV_QUEUE repair paths to
proceed and return before sockc_err is checked.

This pre-existing issue was identified by Sashiko AI review on commit
125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
hit in production.

Fixes: 125755776bc6 ("tcp: reject non zerocopy devmem tx")
Fixes: bd61848900bf ("net: devmem: Implement TX path")
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Kaifeng Wang <kaifengw@google.com>
---
v1 -> v2:
- Move the devmem rejection checks into the Fast Open and TCP repair
  branches directly, also covering the case where tp->repair is enabled
  while sk_stream_wait_connect() drops the socket lock.
- Drop the !sockc_err gate from the devmem validation check and return
  sockc_err if set, preventing a valid SCM_DEVMEM_DMABUF followed by a
  failing cmsg from bypassing the check.

 net/ipv4/tcp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87ef6d5cbfeb..2792923f0748 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1169,14 +1169,18 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			zc = MSG_SPLICE_PAGES;
 	}
 
-	if (!sockc_err && sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
-		err = -EINVAL;
+	if (sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
+		err = sockc_err ?: -EINVAL;
 		goto out_err;
 	}
 
 	if (unlikely(flags & MSG_FASTOPEN ||
 		     inet_test_bit(DEFER_CONNECT, sk)) &&
 	    !tp->repair) {
+		if (binding) {
+			err = -EINVAL;
+			goto out_err;
+		}
 		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, uarg);
 		if (err == -EINPROGRESS && copied_syn > 0)
 			goto out;
@@ -1200,6 +1204,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	}
 
 	if (unlikely(tp->repair)) {
+		if (binding) {
+			err = -EINVAL;
+			goto out_err;
+		}
 		if (tp->repair_queue == TCP_RECV_QUEUE) {
 			copied = tcp_send_rcvq(sk, msg, size);
 			goto out_nopush;
-- 
2.56.0.385.gd3acb90ef8-goog
