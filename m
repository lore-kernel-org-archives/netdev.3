Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DA3B42CC
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688163; cv=none; b=ns2XbdYWLMdnQIMYrFjgb0BdDpktWrwpf0Ihn6FkGMEZgmbJsvJgheIsOGK3WQXXyw73YSM1ug+yZukcZN4q1/aZ35ksALGC6IIR6YI2HoEL8i+AleCL5Z+ducgi+TjFXBKPx+fBh/LnC/T4O3ABaUdOlX1KJTIANATcVOyB21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688163; c=relaxed/simple;
	bh=ZKaUERDMGZnAIY5OMdDRn3CUnu4nw05mP4Pr14lhJPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ebnbkfvpl2M0lz+KHTe3J927rSl8XD53do1Io1wpTUx/AD5hL87YjgINfyrsDL9AwXEpv4x+smDJmsPu6ifwwrHeTfl570UaYcvM8EdmJTodicNregHuctCxLei39idqsT6Dfg8uuo2PoNqyvGAlh2Wp1S2OYJakeqoJ2hL9Zm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=JZ+OqZrZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TE8EmAO1; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="JZ+OqZrZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TE8EmAO1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F7391D00181;
	Tue, 25 Aug 2026 16:02:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 25 Aug 2026 16:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787688160; x=
	1787774560; bh=2wl1tB57oKKl/+BK4wxd+wuZ3TFQXvsZw6wMOYUXOQk=; b=J
	Z+OqZrZMGr26iNpV3XSUIi7I+2RztlAk+8CNqcr8h9pOmFaxw4iYWOVOa/UdglOW
	OB/m0H7Ol8abIDZ8V6Dm/eWOy5v8OiMmcy1MLCF34iia4cBFChdDW5e15Cgq8CD7
	eTdTdVTB3mcyXc9TETLzLRyEbS3OL4J45TyLHyvZNSEdDItK2w5JllGpX77wpPLA
	XRXJwof5Bwp52t2Jwbjk5OdlM2avBEc1be1om8zcxoJ7sBt8LTqlJNbAZd4bMaaI
	//k9WT5BcyNm3KJn36y0xrADiuFptw0nyZD2XsISfBgmQmmS/uvbf4490zuM5PmG
	ze+kdxUyrspfTcQPMUgaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787688160; x=1787774560; bh=2
	wl1tB57oKKl/+BK4wxd+wuZ3TFQXvsZw6wMOYUXOQk=; b=TE8EmAO1lYg4i25wj
	axO7BvOn8hvAJ5meAmm6Kze1IeYy3af8Ic4wIOIhd3KHEtyBqRnXNfGn7rMlDZvB
	DI7cKZAgb2SDPaCNqgFoArnEzlXwAcI0YOvqe3T7S29mnnc9H8j6Sj6xqsJiP7d2
	pHzcQSnzA/iy+tJRdgOJ/KqwdZFa/rj5icZyWDw3xSCVc6Wv1T+aOvFzlYbqAqLD
	RljLVOxmmaUaytVtzkrZ/kavigZ+4t3a9puOrHcDfvlJM1jAp5GyAAyzp311JFL7
	hzKYKb2G0rDymcx604+ORkZ7mUJcd+peBYnNocchA++aGGQmI6TZICWa00TfVcoq
	ERPjw==
X-ME-Sender: <xms:4PSNaqRE3xCHRCBV1waS-_aprU91XNmRu5OWsUfMN2onMiQqFnmt5g>
    <xme:4PSNaqKmIM3suMGCi3r2LVjzpsZduxm1hXcR9EEzi3ThkLZUCSYtyPEiQitdABdST
    anfS1AsXXMb5D2KQzPwaHr2KCZDAfjcznTY7SJKeTEVVCNWShCdOQ>
X-ME-Received: <xmr:4PSNat8eu3LtSUtYo2ImQviGIiVeWQslUGk3qrXCymTdmOuVy-W3R-dNlevEU2XrC2DiVkJlnplRSdkt0BQ>
X-ME-Proxy-Cause: dmFkZTEm2NXGay558zJdoSuGbfSQsWX04vj9+40/IDiYrCU5V1A1up2jLsFXqdOOy2sdVf
    BQPMAJHkXRvg8Z7In1DWsP1lQj0JiIuSI8DuGjj8VLgrcF/YBrezhFgcGPii5l7P3a92E6
    826g+OrKx9+Y67BmxCQRew7WFafFvsiHg/FT1+nnWbKz1vdu1RCUve8dbOhwOq4cYLFP6z
    Y6J1pnA21O1Wac5MoK5lRD5S99tGlbVzbRH+Yf6RRaqQzbJGKeswsz8metuvYexYWfS/od
    SKxVgAPovDQmssDoa/jcmJKgJ2nz0oBRKKBa7+ThzCn1YRuaqQr7T3hrJKW3i7DLPIytTw
    apSdzT+4ji0Yjatpq3a4tFXZgLRmbFOVw2yY3lnohjPmcUnTe+9MlTWKLAhSoSUWH7O0lj
    6dCFYQuTGEXdZ/XqLN9JPpLOrcKRCPHb8neYvxEQ2cajz/IFVF3aawOAuvxRhDZG6f/WHN
    3ixD9y47wLX3SqADAKHugjmAQ9kAP47b3lPHbfBEu+FR+B0ppced7DseVTm2PoWH2KkJ6F
    mMUazV0+7anLKP+zBozTfZnQlHtX2BRVvNCR75c+jT+2/FjoR6mIP7AA6dkeAYPaWXeE+a
    j+SIIoCAoJYSedTT9F55Cz2GYdmU9EnAeMDSuizEiAPXK1Bt7+lyZ491N7Vw
X-ME-Proxy: <xmx:4PSNahKjY-okk3pqo6XQdJwIvSlHMClg1iqYnYHC6yr7CnUKWsxwyg>
    <xmx:4PSNasGfsdUgpQZLOBSEX1RIreeiFRhQEI8qIX-AjnwGahT8_KEXQw>
    <xmx:4PSNalzevmk4KIErrFWUituLdimVBGp2qXF0Bq72gUTcQgxB-2iQqQ>
    <xmx:4PSNal7FvqeFvjlYaqaHcRgEnx8Y6VexIHmP9VsQhKB8M3pUuIGnFQ>
    <xmx:4PSNaq0xtFWHRpRYdl8p76l99UUrAU8S93_yAETGJwQv6GqgdyqFDI6Y>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 16:02:39 -0400 (EDT)
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
	syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v4 2/4] net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
Date: Tue, 25 Aug 2026 23:02:13 +0300
Message-ID: <20260825200215.90326-3-alice.kernel@fastmail.im>
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

This commit bounds cork->base.fragsize to IP6_MAX_MTU for UDP sockets to
avoid a possible overflow of UDP length that triggers a WARN in
udp_set_len_short when setsockopt IPV6_MTU_DISCOVER is set to
IPV6_PMTUDISC_DO or IPV6_PMTUDISC_PROBE, and a large packet is sent over
a netdev with an unusually large MTU.

Steps to reproduce (included in the new selftest):

1. Set device MTU bigger than IP6_MAX_MTU. cork->base.fragsize will be
   set to that MTU in ip6_setup_cork.
2. Set IPV6_MTU_DISCOVER to IPV6_PMTUDISC_PROBE or IPV6_PMTUDISC_DO. It
   lets maxnonfragsize be set to device MTU (cork->fragsize) in
   __ip6_append_data, rather than to IP6_MAX_MTU.
3. Send 65528 bytes of payload (+8 bytes of UDP header, +40 bytes of
   IPv6 header). Device MTU allows it (it's only one byte bigger than
   IP6_MAX_MTU, and the device MTU is bigger than that).
4. The UDP length in the built packet is 65536, which overflows the
   16-bit length field and triggers the WARN in udp_set_len_short.

To avoid breaking sending UDP jumbograms over raw IPv6 sockets, limit
the change to UDP sockets only.

The original overflow bug with IPv6 and IPV6_PMTUDISC_DO seems to
predate git history (verified reproduction on 2.6.21), was fixed later,
and then reappeared in commit 427faee167bc ("net: ipv6: introduce
ip6_dst_mtu_maybe_forward"), which is chosen as the Fixes tag here. The
overflow with IPV6_PMTUDISC_PROBE reproduces since its introduction in
commit 628a5c561890 ("[INET]: Add IP(V6)_PMTUDISC_RPOBE").

Fixes: 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Assisted-by: Codex:gpt-5.6-sol
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/ip6_output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8fc4766c8da9..550965058991 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1432,6 +1432,8 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	if (frag_size && frag_size < mtu)
 		mtu = frag_size;
 
+	if (sk_is_udp(sk))
+		mtu = min(mtu, IP6_MAX_MTU);
 	cork->base.fragsize = mtu;
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
-- 
2.55.0

