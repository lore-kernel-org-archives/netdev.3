Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FDF37E5D1
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220460; cv=none; b=Ofc37CPKnSkaPF2SENXQqTOU8Md8RaXsY0YqCk1jWlM+i4ymyFfaZGtdDKExd59jKkZOVaMoeoAal8Y2Juno8a1rkFUav2nhCF3BghAlmag9XFrBOYorNDaKW1It6/EFMmWEKnUWIpbIGvCYfexesQqceC0GlDfFX6gOLjU2wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220460; c=relaxed/simple;
	bh=wzaMXtcdgpE7+fSGmah4FUmNUZubEptioqAA871qN1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAp7nQBL7itemm/8x3YCn54TlvOaWLSC++LcgmS9SZfV3P6Mq/obRMwOKLqAr0rVNxLci853WDYNP32fCLN3/XC18nEwbbfcLc1m6k+tL1LdGpap6CWGxZmaiEokr6y1XdBeW6XvWIAbo0OREIUxtT8gfbHXKdu/t475EOGr0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E8H3zD61; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E8H3zD61"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wzaMXtcdgpE7+fSGmah4FUmNUZubEptioqAA871qN1g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789220456; v=1; x=1789825256;
 b=E8H3zD6190pSsMmKc0a2Tl1wYBaVuWZGm3DejNXcolDf8k37Z5UOVFAavw1LJrRVSAK1ytDk
 3xHCWvWA5IIIqLECpeDBMmvYXgz36GGE0aAa2pB6Vv21doxpWEokrIwFUsfKcnSPUwqmTLLg6ZN
 FfHzyvXvuqipypC4SsRu7kCw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de80f2347108c150;
	Sat, 12 Sep 2026 13:40:56 +0000
X-Mizu-Trace-ID: de80f2347108c150
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net-next v2] ipv6: make IPV6_FREEBIND and IPV6_TRANSPARENT setsockopt lockless
Date: Sat, 12 Sep 2026 21:40:40 +0800
Message-ID: <20260912134040.215664-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

IPV6_FREEBIND and IPV6_TRANSPARENT still take the socket lock despite
using inet_assign_bit() to update the flags shared with IP_FREEBIND
and IP_TRANSPARENT. IPv6 TCP and UDP sockets can already update these
flags without the lock through the corresponding SOL_IP options.

Move both options to the lockless setsockopt path.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
Changes:
v2:
  - Squash the two patches into one and drop the cover letter.
    (Eric Dumazet.)

v1: https://lore.kernel.org/all/20260911102418.157071-1-xuanqiang.luo@linux.dev/

 net/ipv6/ipv6_sockglue.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 1f68fb64a43ef..4b3536571c980 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -398,6 +398,21 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 	/* Handle options that can be set without locking the socket. */
 	switch (optname) {
+	case IPV6_FREEBIND:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		/* Shared with IP_FREEBIND. */
+		inet_assign_bit(FREEBIND, sk, valbool);
+		return 0;
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
@@ -666,27 +681,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
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
-	case IPV6_FREEBIND:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		/* we also don't have a separate freebind bit for IPV6 */
-		inet_assign_bit(FREEBIND, sk, valbool);
-		retv = 0;
-		break;
-
 	case IPV6_RECVORIGDSTADDR:
 		if (optlen < sizeof(int))
 			goto e_inval;

base-commit: 348ea4642f56ab3dc93621c8e3ab0ccd0e5f1782
-- 
2.43.0

