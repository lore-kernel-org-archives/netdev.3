Received: from mail-qk2-f6.google.com (mail-qk2-f6.google.com [74.125.230.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59A3E9286
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789299395; cv=none; b=RtSXKq4sL9yLgogH9tCUM7kRRItQ6ce0p6D8ImWZNVfczFIul9O+hZKIWkrQH2O76F5IxahIV3Yp2Y6NHrSyRqVuRejLY8rLzXduWWgWc+fxCWFm7VDMiEC1TMYusJDSzeQuvU7T4HK8Pqbvt9+vcV6lzBkVjMnoDJq7QNtKHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789299395; c=relaxed/simple;
	bh=s+yn8heHjHJXCmboNyulsK9UYhxqQFZnQizWHkohj2A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fPJne9vA2qRSoJp9Xg5d/bnPeUlUblBMRZRbpjSxzTRSwGFiEhoLHEK/r9vahF2l7axe9GYfueVqXktDEAYigIQ6PeuPqXav+JQ9gkNQFpdzFOoXbr1fIYCnnbrIpF1IWCae5xrSsILepHd69h+xcqqRJOwMxyBrHn/Pfy3secc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oO/l8DKO; arc=none smtp.client-ip=74.125.230.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO/l8DKO"
Received: by mail-qk2-f6.google.com with SMTP id d75a77b69052e-52fa263dd47so14876101cf.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789299388; x=1789904188; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+K4Q6mA0B7cFhrdQfvjltB31JYYm86Jr0HYn9YoOBBs=;
        b=oO/l8DKOsVxS7iqPW4uDO9YQXdWgeTtBVa9d98gxPlbHFWpDq5ylvtO2huG7oQME2Y
         zKLHvBSYAS8BW4FPSB0EXIPFrO5iHXZXzAZzliYtpcDDPr6fN0CO9Y983ZgHAHoz66Ed
         1BzNHmoWbMm7fZOy5woPvt9GVrsQWuoayXQRuE/IwDFAhzOwG0gl8MEfEHlQRt1Zjsx3
         dNBSsIN9KTqFd9/266G9Fr2zvurXArTjb0Rweh8Mdn6gWrbXw5OC43gyuu0YJKS9x3EA
         spIfxR36PbKDJlrUw0lnrXkhmt41M9CHTro8YK5n4zNj6jpcGKuCWVgzJEkbMEZISoGS
         J/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789299388; x=1789904188;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+K4Q6mA0B7cFhrdQfvjltB31JYYm86Jr0HYn9YoOBBs=;
        b=jTwHmmS/Ni8UqElshEvXrfj8tFCsWjpfHbfkB9vmax6qrs3TVIQrMdPiQAcc1+dQeZ
         Z4EQHYXdxy0uF2sYMkuT2ZokkDSqIXFFtuYTjSveNjTNUOd4tQM1bCLAQFf1hegbD3ep
         u2R1yHusuXygRPmW09zMKyS/VAcWwHMjPFIdUCEjOrKDoG9UYA5WuzVtXAEMC50rJRpN
         vAhhX1ChPcKY6Pcx/KzNQ9QYbBEpJLj0jDO+tAcb8md6sOgiDLMAmEsNoZSKxKQ/5nv1
         LCMW3Djmyg33E7s+rt08IgMz06xhOnvsTyqaon2DpaQXb3vHWI598NLKc0o65mH5Aj4/
         qllQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVEqo/1uAepyG6wN4W3o+4DcEyXECxg0ETABAxhcOBYiXXDZdbkJCgnza8IXpF7Z7nslEMxT4=@vger.kernel.org
X-Gm-Message-State: AFuF++nD6SaxN/0t68UbQoeX1Y5UhgAmDGzleJ9QWIvp6h2Ik95Ty6+0
	eyw+tA94E5aJfXqKjjn2l48qSQXiSBjpjQvFEHoJNShC+3HrIAuDyh7BHjXq8pZ0og6cqg==
X-Gm-Gg: AYBFou2aPO6WQSlTZZN9z9dV47wJBtEd4mEmwxGCyFf9A0fE1yno46XAJ2A6jS1F+EO
	122LSWGwyDS2ojPGV9NfZpIcnZbcqnHhqCc9ZKpKJAfR6+uI+XN0UisW3M6fRjQrxy4W1hp6RMP
	+lPeRmdI/cZ2hWbjKj6YjpyITS2ykkasSdbElzBGGi5lYsnGEbVFdqcJQoyED9qDesHXryWxGJw
	sxnAa8v0WTIxyHeB732qf20ep5Cr0pmV7LCryadU9my+Gv7e1y1ILlW9SA0cMJPJbtQkhmM0fav
	+2CghVf/O0p2s5vgGEEkwVvgCK9SqgFq1H2eYt10wSaZpqKubWvDwLzzD7HQNOabrjRg4/f3Nd5
	qp7N2EO9tcvPL9+I10lHHz+FRI487wcIaTem/cXuO0Egzvje8rxnN1Ts/xE6xNuLrr4fbuI1Ggo
	A6d6HDGCBZFJMuYL8rQREI8MjwjI/qFCd4etv9nSU+zt6jip7dfgvb2E5hkIfXuiGXP1jdROMbW
	ycGCuDqM/oYbnRT4vRopGkvKwE=
X-Received: by 2002:ac8:5996:0:b0:530:b2e4:d59d with SMTP id d75a77b69052e-530e820b6cemr86862271cf.56.1789299388158;
        Sun, 13 Sep 2026 04:36:28 -0700 (PDT)
Received: from hhost (awork062063.netvigator.com. [203.198.28.63])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca4b9c54sm68504331cf.20.2026.09.13.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 04:36:26 -0700 (PDT)
Date: Sun, 13 Sep 2026 19:36:15 +0800
From: Xingyuan Mo <hdthky0@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	Xingyuan Mo <hdthky0@gmail.com>
Subject: [PATCH] sctp: reject forged cookie peer_addr with unknown address
 family
Message-ID: <20260913113522.2674588-1-hdthky0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0

When cookie authentication is disabled, COOKIE-ECHO peer_addr is
attacker-controlled. An invalid sa_family made sctp_get_af_specific()
return NULL and crash in sctp_transport_init() on
af_specific->sockaddr_len. Reject non-INET/INET6 families in
sctp_unpack_cookie(), and also bail in sctp_transport_new() if
af_specific is missing.

  BUG: KASAN: null-ptr-deref in sctp_transport_new+0xa7/0x350
  Read of size 4 at addr 00000000000000b4 by task poc/682
  Call Trace:
   <IRQ>
   sctp_transport_new+0xa7/0x350
   sctp_assoc_add_peer+0x153/0x850
   sctp_process_init+0xf9/0x1180
   sctp_sf_do_5_1D_ce+0x464/0xbc0
   sctp_do_sm+0x114/0x2990
   sctp_endpoint_bh_rcv+0x280/0x430
   sctp_inq_push+0xdd/0x100
   sctp_rcv+0x17f5/0x1ae0
   sctp4_rcv+0x2b/0x40
   ip_protocol_deliver_rcu+0x25b/0x270
   ip_local_deliver+0xd1/0xe0
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: opencode:deepseek-v4
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
---
 net/sctp/sm_make_chunk.c | 4 ++++
 net/sctp/transport.c     | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 84a4c97d0f75..7c8fe4b38cd1 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1855,6 +1855,10 @@ struct sctp_association *sctp_unpack_cookie(
 	if (!sctp_auth_verify_cookie_params(ep, bear_cookie))
 		goto malformed;
 
+	if (bear_cookie->peer_addr.sa.sa_family != AF_INET &&
+	    bear_cookie->peer_addr.sa.sa_family != AF_INET6)
+		goto malformed;
+
 	/* Populate the association from the cookie.  */
 	memcpy(&retval->c, bear_cookie, sizeof(*bear_cookie));
 
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 6ea55b9fbde4..cd1a604d6f8e 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -92,6 +92,9 @@ struct sctp_transport *sctp_transport_new(struct net *net,
 {
 	struct sctp_transport *transport;
 
+	if (!sctp_get_af_specific(addr->sa.sa_family))
+		return NULL;
+
 	transport = kzalloc_obj(*transport, gfp);
 	if (!transport)
 		return NULL;
-- 
2.43.0

