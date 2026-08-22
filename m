Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CDC3C2798
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787400102; cv=none; b=TiTDJ468GQspj2lYQJeTzz4aH5ZyFSBnwS+TdolqD5UwOptfMUOiHrXMHzFCtPB+xacf+61kKjITDzsXFJpg0BaLke5aOb6O+hi9eNn/GhqSwN5nu9DrRkmcio+LyiFgM4e1xkULz3TejQ1Zs2s0bd0BOdwbBifn1u9TRbi5V/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787400102; c=relaxed/simple;
	bh=C27FE+cSKpaumiJE3RvVaGRhO9g3UjdhFDpvKaXVlFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YubnZ3I1MUwdYH58pm4iUXKWGAklfoPP3ycJ1WxdNekujgPWd0OfB9fTB049bQ9S0QdFl8ughLfoC2mb7UicLHU1Mwpj8a0e+sI6JKNO6FPExNIaqLesN0GWWX3VXVBbMtmI7Qv1S4gsjGEs4Sv36wfa1GCBkf+c72VZ0cevAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=tO+TmKlZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJTHEISR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="tO+TmKlZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJTHEISR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D3F07A003F;
	Sat, 22 Aug 2026 08:01:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 22 Aug 2026 08:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787400094; x=
	1787486494; bh=DwXtHgTH/DvUjyS6ZyqshylaT4SCZRMIiZAnrYNUBZM=; b=t
	O+TmKlZI4tk3VvO7aQWB1WTqyFubSqNK1cm0jZi7lr3rUVIj3xGjU31EZfoV4c6g
	7mIN0DlkPjCOCxoC0cR09+K+ibD28bL+qnqV9efTX3TlP3FQ4STkdeb71Z9nI/uw
	oNXr5Oul8ObzwZSOBMgo/Wod8WOOGgopE8Y7u4lrAqcxpsI2BqYUli5T+k5Iigpa
	Iy1jjFeHwoVJfpFOes5W0lsh8q7z+zr3galurXna2PJfRx0g1EWjcTXfftz3KxmK
	FigaRbWh4jAZrr1lzBIjIdvdiLUU/IEJ5iCDyZXikXNcYt7WEd07zN+y2rdWGW/y
	o2qZou53tmnRzC3qRYg9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787400094; x=1787486494; bh=D
	wXtHgTH/DvUjyS6ZyqshylaT4SCZRMIiZAnrYNUBZM=; b=aJTHEISRAoK3aWrnJ
	TGS8skFtwVbBDYbtXTohCF6/n5jcRJ5XIwoaTNBiBZ7axNV11JnDXoJkHxy8j7Z0
	G7Tjw4v1rVj7wz0GpL1toe6NJUk5pJmgumtcL90YtrDoaE8O4VX29Ie95ElBZ3Ct
	9ak1fzBX77zR7KF77YvwDIV8ewFeSxXqRsit3pnI8OznUdmzAMACyY45U68fnclf
	Fg/doaqFkZ1HkugfN7Ah2DmyQoGtW7g1lik5L1HXb81Fo8LqhYSTh/hdNaUr/mxX
	hT0lnYNaoFKTND7lT7Dg2sTtqO+ht2odDPY7AlGy3IOTCVVQoh8/Tz1eLueHEvMd
	dH87g==
X-ME-Sender: <xms:no-JahLAFVoXrhDvMukvIzpuRaRsJz__VLgueeyocf0wWM80sgl1Aw>
    <xme:no-JakvD_OhoOe-6_ePmiMB07c_eST6ukV8q5-92Ss2AP9jn5KKQrxDmOzZM6lSDl
    3oRavPVPIX0SY7O6Z4Zy3_Htl0TnaNjHGePpCpHpTx_jRTAOC-A9IfN>
X-ME-Received: <xmr:no-JapWT43g6WIBUGTRhGkxEeWj7-BY4vUTcuJzU_8WzanQeid88yGlqZlmjDQ>
X-ME-Proxy-Cause: dmFkZTF8eHbotNojuskFGaihv314t1CtxNKhClkNLvhvr0eo68GAxCWQuGfoQCS17Vu4XY
    QXefPX2xmPqMvARx7TJpIP8Vt7eVqPviG5O6pb+TBOg84LEo0ouJZ6Td8TKWC+2cGQtGUU
    3n+Pgo9hWAxtnEretjfn0L5/FqL/MK+5pra3yBULzFVmKvxdygn0AA54j0IjCUhOdm/1na
    1GaLM2AKpWwrQB4Y3+vGltdxKwytE6MQ9Jjq2ek28Hw7HO0ajA5t0zYHIi8IJX9nWaj1VG
    s4Jn2oXwH0WVIyBRw7N7/qqGJGrQ7QjEYRx17IGkmkyWxtiIe3So/VrRTZWmnYWD7F9fSu
    QSjp4IULVAriHpzTnbM8pp5DW6R1AamhXZrhHw/pumVR867JgqY/Av0UHbpBsxjGOunkgN
    f/5ip1KrECN3cli1d8yky/5bnxPGL+OepgZdpcMTuMNImpGiW/8moSVDZCI0jFhxLyuBNn
    /qsqWaVOL7OBo2jgFY2CJ864EKDFC+U/9XhzwVSowmchm6z/Zu+5CEwsuQSHCSBJNiS93c
    vAl+jQaSX8jOAuseY3qxI29phvuMFB4S2MyoBJpYeMCx369rvAzvHyAUJLc0ccB7fcxwxA
    kDai087kIXoXjnzkiY5aHUUVIfHBcAZoeiPkVlKTAAlI028lXFbhUqeBapWg
X-ME-Proxy: <xmx:no-JavITjea3iBpw5ZNPI-vBBbQYBq58CDev02OsVRgNW-9OtfJaoA>
    <xmx:no-Jau9xZj2YXykmbTjdWdJTl1SgsgR3KzBys5vWlAKDlWNA1Rqn1w>
    <xmx:no-JatN61Vg7e43z73YobPqG9P1OgHK_ntfK9Wn3TTrIRx9VLi6_sA>
    <xmx:no-Jaq35vknR84gycfAKiq8WJmbqI3xq4wHuplpeTvsGWaM5rN_e4w>
    <xmx:no-JahqC6BTWhaC4YmUJO2n70Sd2fiCnCD_50PU8xEpek8JpGjJNEpuD>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 08:01:33 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net v3 1/2] virtio-net: Ensure that TCP packets don't overflow gso_segs
Date: Sat, 22 Aug 2026 15:01:16 +0300
Message-ID: <20260822120117.1163423-2-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822120117.1163423-1-alice.kernel@fastmail.im>
References: <20260822120117.1163423-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

The user can specify any gso_size in a packet crafted with an AF_PACKET
PACKET_VNET_HDR socket, even smaller than TCP_MIN_GSO_SIZE = 8. At the
same time, GSO_MAX_SIZE = 8 * GSO_MAX_SEGS = 8 * 65535. When the user
crafts a packet with gso_size < 8, there is a risk for partial GSO to
overflow the 16-bit gso_segs field when dividing the SKB length by
gso_size.

Adjust gso_size of TCP packets to be at least TCP_MIN_GSO_SIZE = 8. Keep
gso_size of UDP GSO packets, as gso_size=1 is valid and explicitly
tested at tools/testing/selftests/net/tun.c:649.

Fixes: 7c6d2ecbda83 ("net: be more gentle about silly gso requests coming from user")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index f36d21b5bc19..c381b916c1b5 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -6,6 +6,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/udp.h>
+#include <net/tcp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
@@ -179,6 +180,9 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 			if (skb->ip_summed == CHECKSUM_PARTIAL &&
 			    skb->csum_offset != offsetof(struct tcphdr, check))
 				return -EINVAL;
+
+			BUILD_BUG_ON(TCP_MIN_GSO_SIZE * GSO_MAX_SEGS < GSO_MAX_SIZE);
+			gso_size = max(gso_size, TCP_MIN_GSO_SIZE);
 			break;
 		}
 
-- 
2.55.0

