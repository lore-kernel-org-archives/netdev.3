Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239713B5E08
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688172; cv=none; b=JwL4lRTEq+q2GBWckDvm4IJtS8GgTrsPM1b7wctVLEEuihVye8idrouvAwhIwWvRGCa4PlgwuD7Da5Q7mt1GuSS+Abyt4hH5HCMNgNV+m6t+TYfvut6nAL46q6UfmDfXjNJ3JrQR/uT4MaY3jOYW25PSxSLPYK/8MsC5u1r1xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688172; c=relaxed/simple;
	bh=h5g19SztFkEyFkjk0/cKFCbVHJ2HbodvOjb/zahKntc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBv7E2ou0tbtai6xle6KWh3qMv079PFDdmc/F7yhoLNGX43t2/KwDqB+zWo2U4mOOuDx9J51B4wF2cJExN079alROo97HY+Vo7vO++zXcm2R1jpGu6XvZhDQnoJ//z8a1gW/D4ybIcNWWCMvnjAZmEOCvJz8b9D48u8UVMLEpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=t9QjF8Kt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ahJH0Zh1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="t9QjF8Kt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ahJH0Zh1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C2957A00A2;
	Tue, 25 Aug 2026 16:02:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Aug 2026 16:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787688169; x=
	1787774569; bh=LeYtaEEhyDnwQ2HLainJO/J0XK6yonvKpQawt9qdEhY=; b=t
	9QjF8Ktct36mPjCXKve2X9TqK8DX7HEVTDzc6Wfk3yP8PhiKZ4U5gQ3Wg6x64zfj
	sYnjVxq4gkWUfsCNBVUZ9uULfzXYC8baCDM6DISbI95oySZTUXJWXeZbh9sgLD7e
	AkLL2NwuIDlQmLM4Jb8ZZEi44VmXJ5b5+mgx1X/Rm1U6Bo7dlPeefGEyaAcN9181
	KlhkZKYfZ0/O6zmvqrkGkRKQOzv6TvWtGh+71QEgkdwLmT4v/lp/xBSgipcdefS5
	aD5NbdLeZwwvzj3V82ac7hrwoazx9vW9a53lDOl1izbqOQpNalxIc07+yo/aV7pM
	97gNE8VaQUtMQWz7/D2uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787688169; x=1787774569; bh=L
	eYtaEEhyDnwQ2HLainJO/J0XK6yonvKpQawt9qdEhY=; b=ahJH0Zh1JHIrJ/skW
	viOcd1Tq5bgazVKt5scBqLqlsKTiZ5citCXhVKRlNQV1O28bEKbzcWI+eFt5oSZY
	zqDAMbzwvOAidFQ4I5+bRdKs5q5eKLMdq9sDn2AzgQhwBDkipX8cNc+LwJ8YFkKE
	6NW9cnsifL8hnL8t6FkHQsUsJX5Z7HPe3iOBC7ElVlkYmlQJC92bwnNFwMTpAlj6
	n2oPyOO9r8h9z2FfMxbT2X0449hpxrDoyoQ4ZU364lGJEn1/1hFn4BaaAMVohplG
	OKItEONHcs3DLD9EJU2nQI47bDO9NZMPaSgzOqxU0i3ewIw495BwBCWr03FzEZGE
	xIAtA==
X-ME-Sender: <xms:6fSNakPddEg42ek3GZTydTyuhX6RhHcuyrQTtLpcz7S3rsh6KRKnKA>
    <xme:6fSNaupaFoqKHptxI--lMZRKOeW9ByDwOL7PidzGAar-WEyDepE5toAVf5sxXmlIY
    11IMuq_0qCBwGGwnw8IS5CX-f3VF5xQhX0HeXghC7-Ih0g8gu6rLgrO>
X-ME-Received: <xmr:6fSNaj4_YmRlYBNThCIatllZ-aM23PjzlUR4TGc9bNcjW8weUa-BYKCT1lv_mLQ1RE_A3RYy4kGo6iS58RA>
X-ME-Proxy-Cause: dmFkZTE6AsBOqUYkenY0emn/Fq4qEwYrPiWZq/SKM7OOltKyjJU1ddYxOZRv4WQfFxq20S
    1VlUzvl7XNbPVOcArkBbp2gHqwweDSLzRHjv2EOGuH0hysdiIOGkC03n1cUuAMvz3Fq+N8
    gisasUsyQZ2IU0khHS/gYke8ReMsMr33YxphEdxSTOhGpJ0IbGtDZp+dU75TM0bSGAsNZi
    D5cJ75MsU2QUe15OuzopCFAdZeN7YAishYw4mjLqEY66af+RGKq2G1cIw5aV1CjfVA0x4l
    24voEZLqOdoF+r2xK4GlfuduBUxjJkLGiNKsKXMctuJDpz6f+Uuq9zBgacIbGix+V67OPw
    D/ikMLHeaiwCdXTQzMwyBispSU7wWWTDJSFTE4dkkl/F/l+UlcYLmIvueWTC/x8mrNCqy6
    nqssUtPRLbiyQM9CYQeCNPvmnPcmsGfGMz96Key68m7Y72IaLeJEzJ0ujb7jkCVIwmN8zN
    T2wGESGOse2dv33WScXvuopUms2XKDqiAkhtpaxiOtEukq0j0siimHlj2l+hcDu5m8tdAN
    pT57S/g2lxkzLaWFpst8ponpIb7VwP3KZQMC0opsoAL1L1AHA/U3n2kWyhPl+liaAkmpne
    06pxu+aWzdypwOusvO+NtRPz6FmPVRckEyuVEhvnQ5mFOhn8RaDFBy39DvCg
X-ME-Proxy: <xmx:6fSNauHoTkS1hWIXffaagKKswwSYh6cLodIwAkLb3v4F3TmLXm408Q>
    <xmx:6fSNat3Vqed00suMz3yIStKqI_75mnZczZkWUI4VnIKGiGopK3rDyg>
    <xmx:6fSNajrcTqUchABcd25AsD7CwExIQCHszw6iWZxYT9uyXR2wiGihiA>
    <xmx:6fSNaiN0Y3D9TJyIQs6yawuIgWWXA4IAE9KEtRh3j1iY__3SDU8ZTg>
    <xmx:6fSNaqwR7aisQUijBXYYGXBBhmM-ANUtJS3h5OAnqMPHzKxjx4sm8zrp>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 16:02:49 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v4 4/4] net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward
Date: Tue, 25 Aug 2026 23:02:15 +0300
Message-ID: <20260825200215.90326-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825200215.90326-1-alice.kernel@fastmail.im>
References: <20260825200215.90326-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Commit 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
dropped the IP6_MAX_MTU clamp that used to be present in ip6_mtu(). A
similar IPv4 commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
ip_dst_mtu_maybe_forward") preserves the IP_MAX_MTU clamp.

Restore the upper bound in the IPv6 flow to avoid potential 16-bit
overflows in forwarding paths.

Fixes: 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ip6_route.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index c69f1c871922..b9e8d2b759e9 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -384,6 +384,8 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 	rcu_read_unlock();
 
 out:
+	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
+
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
-- 
2.55.0

