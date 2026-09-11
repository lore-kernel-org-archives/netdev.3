Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32944064E
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122290; cv=none; b=lmyjFCAcM7kd9jYuB/xyi3gzdqPHerT6Ulv02Z+aoGQ27yNcGXHsmtI0Y/Efp4Bo2qyGvK1o+BI+o+XpxVo8UeYxmcqqvH7rjBgkUmcqzSPKKhL3CSM+OLFS20NQYeldKVAs6z+c4EE+xbkHSRvxAlSSX86stO9l+kl6t475auo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122290; c=relaxed/simple;
	bh=CKO+PYwYpisBL043APtaARgWQuAzKYp65Rf3nLFJ8As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrKOin6AbNvHE5EBVOa6d+xwOVJuvvVYyjeG5GJGEGrTiqQ3faa4/BzTMs7sRgDLsvTskAz0mnXzKc+2Iy5MC6u5TpkOwXWuQz4bxtHZep01clAzlKiPBUqL30JsAv5BrDuJ+U1ooIHBM81mjAG8z+vxENqMeixjduIoGMtQvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhWiINsw; arc=none smtp.client-ip=91.218.175.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhWiINsw"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CKO+PYwYpisBL043APtaARgWQuAzKYp65Rf3nLFJ8As=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789122285; v=1; x=1789727085;
 b=fhWiINswVARgVgGzdeJhTksqRu3NF3LRGYw4XvfzBq7O/z5bMpuh/uyysG0wz+aFcLmy4IQl
 khiI2zyQB+RWg6uI4vmqAxtyoyKWi9fSVTqPf5mSnaLyY6XVn2IDgd7rB62UkdAkm8P+wsiXzm0
 Rd6UJBa85ph0FpoEJ1XGH370=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 367291e8ef5c5200;
	Fri, 11 Sep 2026 10:24:45 +0000
X-Mizu-Trace-ID: 367291e8ef5c5200
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1 2/2] ipv6: make IPV6_TRANSPARENT setsockopt lockless
Date: Fri, 11 Sep 2026 18:24:18 +0800
Message-ID: <20260911102418.157071-3-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911102418.157071-1-xuanqiang.luo@linux.dev>
References: <20260911102418.157071-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

IPV6_TRANSPARENT still takes the socket lock despite using
inet_assign_bit() to update the flag shared with IP_TRANSPARENT.
IPv6 TCP and UDP sockets can already update this flag without the
lock through SOL_IP/IP_TRANSPARENT.

Move IPV6_TRANSPARENT to the lockless setsockopt path.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv6/ipv6_sockglue.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4124084c3cd79..4b3536571c980 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -404,6 +404,15 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		/* Shared with IP_FREEBIND. */
 		inet_assign_bit(FREEBIND, sk, valbool);
 		return 0;
+	case IPV6_TRANSPARENT:
+		if (valbool && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW) &&
+		    !sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		/* Shared with IP_TRANSPARENT. */
+		inet_assign_bit(TRANSPARENT, sk, valbool);
+		return 0;
 	case IPV6_UNICAST_HOPS:
 		if (optlen < sizeof(int))
 			return -EINVAL;
@@ -672,19 +681,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		retv = 0;
 		break;
 
-	case IPV6_TRANSPARENT:
-		if (valbool && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN)) {
-			retv = -EPERM;
-			break;
-		}
-		if (optlen < sizeof(int))
-			goto e_inval;
-		/* we don't have a separate transparent bit for IPV6 we use the one in the IPv4 socket */
-		inet_assign_bit(TRANSPARENT, sk, valbool);
-		retv = 0;
-		break;
-
 	case IPV6_RECVORIGDSTADDR:
 		if (optlen < sizeof(int))
 			goto e_inval;
-- 
2.43.0

