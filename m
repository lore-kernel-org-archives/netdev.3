Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464435F5E8
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747424; cv=none; b=X2i+Op/y7CkNKKIjZpWt3uXUhL/BxMyCF/WaoW/thQ3ns0Xx2NP1q/givEf3FetWSzL0OixaWqTQNsxwYZpC5moe3XrvX9HJKkGdMStnNrS81th20g6SrOPcssueD5NxT+yzjcfP9pxypCRCs9YXqsaQtitNewgy0rtLU/ca2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747424; c=relaxed/simple;
	bh=LrxvWdgRIHJMniJGkG5ktOZxczbfauXkUsESayct99c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWoGRJyBOTIkHe2f9GjXkHLXG/53yd5QmMzjstm48FRZQ5eh4vMA2fIUEBN60euIppl2MeLJGfoZXGGqMW4Kl+JFkTDJOWpPSYv8Iu1Qm1L2BGXlZ3KZH8qIH9UtMhu/L6rls7IDtcXZEo33zY96nWIfsbkKOzWHWAJkSYjEOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UeHPbEtu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UeHPbEtu"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c737b6686ddso1311387a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747422; x=1773352222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4glLDJUU2drdghiYhHJwAgiicPoVmTdv4+Jl0iVHjk=;
        b=UeHPbEtul/n8ZcgvE4Zc7oQTC+W7WMsOBgQ3JwQcXwxkqNWnCOBR+kyFdSl2mbs26v
         fqNFt8psrokx4czYZgKq61KzkORe7cvKbbU6Ps4D/liRqULOeRrewW9R++o95xlx315+
         0ba8emflbCyNxDLRtL1fkMgNvqs6F7y94U3VrJagFME/s1mJHjbLixUYB8CNnRuuO5k7
         E3pbVPRt+vJ0m3LRznemlItZhUl8QbZ88Ui1BY+jjbKNvdyIhZovlh/9DO0xp5Y7kgWq
         LIitS11I/+3FggNWpwmS8FrNXA4PheiVAdMSbtFQQ5aOBfEvfiQU6hWsTT3DQKpMG125
         wG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747422; x=1773352222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4glLDJUU2drdghiYhHJwAgiicPoVmTdv4+Jl0iVHjk=;
        b=QySqcyw2kOQANIv/OisnrhXZIDuwQc/SvluNC22McLQpEPwxRiRDe8ekholFF3VNaW
         2Gsq1vQ06qkpFXem6kzEE20fjcHuvcnktCq5QLk+hCJ7YnQjOpqT9BKAPDJCJDeOSRRM
         2aSi35CsIMrDVyfL2JPke3TLXxfeiBZNFf82uExgP/6/GuKVAY4cNN2Ag5MX5YQiaOuy
         2gFRLnPCsB77+IVMiDMTzmGz3Gn0S8WEKxqCKfurEIUsIF9kjV1w0C6pIvOuCPgawakc
         D88YggaZ6b7FxdKqd2zmmI0gVD93qjfd12iny3fOc5UltmgWjSW46PQ7mmuJIi39TYRb
         /5fA==
X-Forwarded-Encrypted: i=1; AJvYcCXXiVwRP7jT+akmH6lasCRa/+WwJY1NuzSFGAQyUp27QUT4g8YvpgSFkgPkkNxHacZqtDuY1nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQveoTYgLfMn4urh2d47pwtA9z/Rr1ffwmAu/F4yj4mCdEult
	dxhIoi7Akx6Xt9YnS7MqufTKPCUOmtR+RrFfAOrxsom4bu+DAO9H+X+ZO9EQ+wpe3BkpfHsSMPm
	1WA3P4g==
X-Received: from pgbr18.prod.google.com ([2002:a63:5d12:0:b0:bd9:a349:94a3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a82:b0:395:cba1:fe8c
 with SMTP id adf61e73a8af0-39858fda3d4mr39825637.22.1772747422082; Thu, 05
 Mar 2026 13:50:22 -0800 (PST)
Date: Thu,  5 Mar 2026 21:49:49 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/15] ipv6: Remove UDP-Lite support for IPV6_ADDRFORM.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

We cannot create IPv6 UDP-Lite sockets anymore.

Let's remove dead code in IPV6_ADDRFORM.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/ipv6_sockglue.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 02c4cab60c69..b4c977434c2e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -45,7 +45,6 @@
 #include <net/inet_common.h>
 #include <net/tcp.h>
 #include <net/udp.h>
-#include <net/udplite.h>
 #include <net/xfrm.h>
 #include <net/compat.h>
 #include <net/seg6.h>
@@ -563,10 +562,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			if (sk->sk_type == SOCK_RAW)
 				break;
 
-			if (sk->sk_protocol == IPPROTO_UDP ||
-			    sk->sk_protocol == IPPROTO_UDPLITE) {
-				struct udp_sock *up = udp_sk(sk);
-				if (up->pending == AF_INET6) {
+			if (sk->sk_protocol == IPPROTO_UDP) {
+				if (udp_sk(sk)->pending == AF_INET6) {
 					retv = -EBUSY;
 					break;
 				}
@@ -607,16 +604,11 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				WRITE_ONCE(sk->sk_family, PF_INET);
 				tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 			} else {
-				struct proto *prot = &udp_prot;
-
-				if (sk->sk_protocol == IPPROTO_UDPLITE)
-					prot = &udplite_prot;
-
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, prot, 1);
+				sock_prot_inuse_add(net, &udp_prot, 1);
 
 				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
-				WRITE_ONCE(sk->sk_prot, prot);
+				WRITE_ONCE(sk->sk_prot, &udp_prot);
 				WRITE_ONCE(sk->sk_socket->ops, &inet_dgram_ops);
 				WRITE_ONCE(sk->sk_family, PF_INET);
 			}
@@ -1098,7 +1090,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case IPV6_ADDRFORM:
 		if (sk->sk_protocol != IPPROTO_UDP &&
-		    sk->sk_protocol != IPPROTO_UDPLITE &&
 		    sk->sk_protocol != IPPROTO_TCP)
 			return -ENOPROTOOPT;
 		if (sk->sk_state != TCP_ESTABLISHED)
-- 
2.53.0.473.g4a7958ca14-goog

