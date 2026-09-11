Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65A43DED8
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122284; cv=none; b=EHg9zn4ixCRb75mXpn0YFu9LNuyl7/kOSrgWKqBzpYCUstITFpVqvFXXMh+cFZmoYXhugDlfwOxJ7mxw6YNERmep255tgV0qRrLuyV4PkCkqPvlOB2KBeColH+dsL6wm7f4p7SnpSB89Nqb7dyAWUffjy9gLuCmthv1lQaIwE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122284; c=relaxed/simple;
	bh=l7+9c5zwjLVYxvhKf3ZRi1rGsctqjpbWc4slKLd1B+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpx6ONJ4Bp+yre4kYNDfhYm128TJBubAzjyjichC2WxwCz5CEtgp1f3Q0vLA6tk4aewCs2GLVApqf+R4pWTe1LV1rSPyFdFKYcpjAtChQnUFZpB7S05FXR52Rv5j1xZ/s0jCGjRcfrhRsuNHiToD80agFDIsAMeWr+DMQCAIkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sjn0Z6xw; arc=none smtp.client-ip=91.218.175.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sjn0Z6xw"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=l7+9c5zwjLVYxvhKf3ZRi1rGsctqjpbWc4slKLd1B+8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789122280; v=1; x=1789727080;
 b=sjn0Z6xwF0sGlctjKRr3HULe6VEpERNVoeNMqOVyWKuh0HQ0Ku2SOW0ucv7EK6qKu8FNKlfC
 ElpaJL+Cb05NxsI3v1Ydf6iB7hkQ7CY/W5ux0jEdTYeMTtZcQTLkS8Z7N6j5meAb0Lb9X/GyR+Q
 3PyEXHHHK1K6M6IiN75PlXmA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 121f891faccde060;
	Fri, 11 Sep 2026 10:24:40 +0000
X-Mizu-Trace-ID: 121f891faccde060
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
Subject: [PATCH net-next v1 1/2] ipv6: make IPV6_FREEBIND setsockopt lockless
Date: Fri, 11 Sep 2026 18:24:17 +0800
Message-ID: <20260911102418.157071-2-xuanqiang.luo@linux.dev>
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

IPV6_FREEBIND still takes the socket lock despite using
inet_assign_bit() to update the flag shared with IP_FREEBIND.
IPv6 TCP and UDP sockets can already update this flag without the
lock through SOL_IP/IP_FREEBIND.

Move IPV6_FREEBIND to the lockless setsockopt path.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv6/ipv6_sockglue.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 1f68fb64a43ef..4124084c3cd79 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -398,6 +398,12 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 	/* Handle options that can be set without locking the socket. */
 	switch (optname) {
+	case IPV6_FREEBIND:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		/* Shared with IP_FREEBIND. */
+		inet_assign_bit(FREEBIND, sk, valbool);
+		return 0;
 	case IPV6_UNICAST_HOPS:
 		if (optlen < sizeof(int))
 			return -EINVAL;
@@ -679,14 +685,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		retv = 0;
 		break;
 
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
-- 
2.43.0

