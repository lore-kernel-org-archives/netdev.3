Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06EE282F18
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257660; cv=none; b=dM0O5q1ir4aWFcpRIiO+4K/4/iaA45IRKPVoGXzkQVS6RFpt38dOaFw0TYhd2sKNmo337kClF1pvHfoMRk1MqUCunLBO65YcDgmjYihR5+l2JkMAHFeFSo+/ZDdv6P4dUzHBfVsr895tW7nrRDuF6RVT+GSslMHKIQmeslvYDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257660; c=relaxed/simple;
	bh=ylrkhNMJjhQdmpNCeHEGM0MplUH1QDHfjzfpZMdd4ug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mkU+xxskwFPXRMSZ0qK8E4swgGtq9F2E2XxbvYbSmblAM2iwXuDXf07Jc7lvuFflGUXxI3SvCXyF3+4bKGMWOOBTOpqhj3lP+weWmeyutybp6/o2/C22kEXXJauPiysxpweeqgjD6Cvk9+PM40yRTZglVtj7d1rYP+gZflyXNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWkfDLw7; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWkfDLw7"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9393ac4961fso276500185a.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257657; x=1790862457; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wgZk9XoUR/NokfOxc/4O4ecYOQ79Gkw0psH8zxKxs58=;
        b=FWkfDLw7nH/vW18RnQnS1dgw1DRZG9KuYdHOCc6/ZqUP/TQCjOV+BggwVS9U91+njP
         GjdnqiC7KeHdID+1LiuD6YsNCkyEYPxqhHFdfIgHA9Ntk2gTbPQZDmw9ITIn0ZHF+s4t
         cqp6sHQIBUqQ6a/XzUdQiXptB36Nze6ytJEa5DMp4O2KDv0/RUsxTH0NhNl170/t5uZ/
         kMptKTwvO1chltyyo/8xFoIMF1Y1r9CSNDb2OfJJUNTC9vBXqDmFJI6IeydmqKtOq0as
         v09CwBerUoZo36QT4Jl/fQfnwxwRobf3hs78zK2Mga6Dv98PKAN8eQ9rfIpYiNqrBpLx
         I+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257657; x=1790862457;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgZk9XoUR/NokfOxc/4O4ecYOQ79Gkw0psH8zxKxs58=;
        b=xwvAO6bE41c/E5LveAV8NMFIpIGVTiTnh6PV6/oPEV+OlesAKaVt2udEksQR3x9uqw
         Bqr6nHrgBZG0cQnkTQUai3fN25QlkvmIecjhra5TITdZvKrnJiNMuiKBLzitXnKLSjCb
         65lhtKIhzKQyD8BFytEcVNLJLJewk2jJfKZ0dm3Ef4wGlqF8fdEhRXqAmdu99Gh9Dkjg
         rcMNIL9AMAHuMjHvcXzViRG7+sy8gIoCKkK88Dg6kWXCI1a6b/p6oiaPfQC/BkbXzp0o
         X3QXip6zItf080mRFAVyi1e3logbRoF59F/XevsJZPx3gLhUuyG4K9jCG2WYXMY13eU/
         2vlA==
X-Forwarded-Encrypted: i=1; AKwUvBz+xv2XgI6QzHj0e0V0RQPH4eq3FphD35TZZaD5RMYb0K19/H/2Q7CAKxq2Nn5qLZWdpMTcMdU=@vger.kernel.org
X-Gm-Message-State: AFuF++mpr8oH+M8l+Enu8+ChrvEpDBaLhZ/9gvBKmgswMM1y6FZo2LgT
	xZ5mvQO6t6u/rju5mCWcRMyrTbfQD6QjV/vC8tODY/AZRQttnWeLJvKWvTf6YaSP5oyoo3uq4uK
	BnqEDaHnMNXI3bw==
X-Received: from qknwd48.prod.google.com ([2002:a05:620a:72b0:b0:93c:40e2:f248])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:890b:b0:93b:e08e:ea5a with SMTP id af79cd13be357-93c3639e012mr284291685a.41.1790257656875;
 Thu, 24 Sep 2026 06:47:36 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:24 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/9] rds: use sk_set_nospace()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers instead of open coding the SOCK_NOSPACE
manipulation, so that TCP can later maintain a cheaper private
copy of this bit.

No functional change intended.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/rds/tcp_send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 7c52acc749cf4d4003c749a2646c2b4f87f207fe..824222c475119d91e333123c5afc9291005a8696 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -100,7 +100,7 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 
 	if (hdr_off < sizeof(struct rds_header)) {
 		/* see rds_tcp_write_space() */
-		set_bit(SOCK_NOSPACE, &tc->t_sock->sk->sk_socket->flags);
+		sk_set_nospace(tc->t_sock->sk);
 
 		ret = rds_tcp_sendmsg(tc->t_sock,
 				      (void *)&rm->m_inc.i_hdr + hdr_off,
@@ -221,6 +221,5 @@ void rds_tcp_write_space(struct sock *sk)
 	 */
 	write_space(sk);
 
-	if (sk->sk_socket)
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	sk_set_nospace(sk);
 }
-- 
2.56.0.rc1.310.g51773c2048-goog

