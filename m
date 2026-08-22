Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E693C1414
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399862; cv=none; b=B+dVKMwNbWqwLzD6SVYEQbUouZz8pMWFUAXmjmicNKA0UEwUqcZ2qs8BIOtBHpGRC6AEJNwRP2WebroXDjltnnnKnNMczJbiG7VUFQIWcVc61qrKWaK1t2rNHmKytY8lcsy9++QwO6E6jx8MLRnNwJMDlCCY8gmvwY7XcmAyBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399862; c=relaxed/simple;
	bh=2MRHR9ZTEBodDiGxnNQoxHggJAMedQwPnmo88bbb9gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUCS/Tw5zJhgmoZlLjpI1pfxaTRltMGgNeBDBjAt+TwS60wAKXrUWsABVJKmkpkjioQ6Qs4Wm/PWwprnkPyh2KHA6F84vD6ij0use2Flru90lPG26yO/Wm3eLx7kohG/89GyFw1iCT/vIMEVin3Su8K/kfmB0j5OBfjU/xT/Yy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=d6vWFoIe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLuyKJE7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="d6vWFoIe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLuyKJE7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 56F8DEC01A3;
	Sat, 22 Aug 2026 07:57:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 22 Aug 2026 07:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787399860; x=
	1787486260; bh=rAhuPWRGhQ0dW4KS2BWIDeG+QRVNZ8BekBCh88F5af8=; b=d
	6vWFoIez2wWrW3Jpcusvov6D4+qjPL+WJSGavP9x1F49dAxXc2CyRbogXJpi6/PP
	E+vGeUK5Sia44l/YAPsWt54Uj+eLmTVNBo7VozvT8GYzHNNU4eNinWDIMNecnnLL
	E515Ah9Z7COSnuwZbCOt8RzmRMJPlIWwJWi3Jwaa3c1vvKMpioYDah/CTjSJ1iLo
	TXjoA0wWCEQ1Mzz2TmYw6xpnm10PHpBKeF//4XimSwSvT/RZUi/+quXcJmYXQCPg
	uFEAMcY4IUlWW6E99wMwT6aOQWB0rskVRbvkVzfbvX3vHIoL/V0DTECC1I4s6anH
	+qA4zSNYiDhX5m2UVJwIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787399860; x=1787486260; bh=r
	AhuPWRGhQ0dW4KS2BWIDeG+QRVNZ8BekBCh88F5af8=; b=VLuyKJE7c9bReBHjf
	Z7OGtx5SCqAD62onFWOQcdgdCk2m6VPKFlL8pAHnXmFCY9s7mtUwC+ESre1XAJOD
	GgImJ+4vb3Jqivx4TvpB7I792yiEg3LvzSiXTXvQaCuqpeB5wMGyQUshbFEumtwa
	C5huCk9o9kD32zr6EAYIeg6URLWaaZRD1IURCYKdQNYf/lDJmuGtcWLAzzg51Jaz
	Xk9qpxJtRQ62MrKI0FaL9hfPXO4xruEW8gaoGLKh0aHmjdQXRW8zTIXOl20KlRwc
	/D2l5PYkGx9AojTJPEqX/CcjY34oIssIt5ps5nNIJsXA0iNi46CMUuadv3ImanV9
	BpyEg==
X-ME-Sender: <xms:tI6Jak_7_fk8kKuWqAiJkfIeydCTqZYB3IIgrQkQ3xEfoPqHtZttrg>
    <xme:tI6JaiocsUwVDJLXsn5cDRQyt48v2arodcldriJiTPJaNL60qVhM7KSVXUzTLaxvx
    KJ4Tvn94nicGTm1OMXuqQhPAgbWLbHy_22zfzKaXS8VTHFkMVAhJg>
X-ME-Received: <xmr:tI6JanJZ3I6roiVhCxLhkhNsqu0t5koTkokMuX2qIWXU1tfDn580GJeuRGP7gw>
X-ME-Proxy-Cause: dmFkZTFd034jC8nUOw0TOn41m7WJNpQW59w5hf7L9oaBLHsW45NsiTTFVnR/zuULPxbddD
    ASf/reVYZ8Ev8NV8PUNiSobbfuBZ2gIV3b/e0/Mx/2J/+k4tfYp3wuPXcykYBq8NGisp4i
    SY2lINF5nemTlUi+U1oMLwTJZfpU5yMHp3qjGDCnjEqIwnmGwXAvfvIDLOjYBbqlxBCC1o
    alHQlTTgtSPhnxRJlDfvBbnqcCQQXmGL+XIRvfxHcxJK2JOyaSxbGr5QHDz9Tzsv9rmhB+
    nb+3DPKBrR0lyxBwr2dHkSZQbAye/GlnujXKDqzalusrMlR7h8K2riepHjwevI648FBzB1
    Hhf+V3yDOMaZ3RrSW9owUucm19ZuubFkV/Wa5vazyWBzOkQKf4fZrZVX1zDGIJyo90Eixv
    MURkC3UTllgjZ8tM65SDeFOH79CsGv6web+xucf9uiN0sYgqqr/+FLLE2rw3lyMhEKtyOo
    8qE+r/52EcUOP2lWFMe0EeN8rszLCmpY4E/2CT2U0Fcdwoqr/XfO8Mh0FfQTOJDvNAAlFK
    XFNk4+AP911q/MAxYdwm3SW45SczOoFdx+7Ha0Kpnr/h37KEKfHNfJXAXQ5RVBex2tuH+L
    KZublAm8Yg9Yz331M3Fpm0jKZr8kjR59bwi29KTpDb5HJBjm0Fp0LmkJUllw
X-ME-Proxy: <xmx:tI6JalOMMLbPMeE3gMp5gUNdmJ0K2vTL9IcFF6bm5lBArPlIGfEtNg>
    <xmx:tI6Jakqd7JS_f_zCISqC9NgY4jR4CBLiJ_LMsZgS0ZeoJEFc1MTvcA>
    <xmx:tI6JaoJXNaTHN546OooT4C4A5rnt700mKph7gLXRVToXgajmhr49SQ>
    <xmx:tI6Jar0B89yT3YutvqVPoUg2Lj2NuIeuaZIumPH2nxQFEIhrNnoIUg>
    <xmx:tI6Jaljp6UHBAO8tULbDyfCQO5evHmUZ3_YtoJsclVJLmvT1f6CGfZyB>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 07:57:39 -0400 (EDT)
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
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net v3 4/4] net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward
Date: Sat, 22 Aug 2026 14:57:17 +0300
Message-ID: <20260822115717.1161782-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822115717.1161782-1-alice.kernel@fastmail.im>
References: <20260822115717.1161782-1-alice.kernel@fastmail.im>
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

