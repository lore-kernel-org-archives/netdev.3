Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E673955D3
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643198; cv=none; b=UfoeO/mzM8jjfKlCldGqFAWtJs3reqeWcNVteWkBnY+eiC54zIT73dxGEI86QkyuT3wheKolfxf5XGrdrcgpMMVbLnin6gFjYFF+HJueqIjPLHUD6QB6KCV24WYRh00Jqy4Q6h030f6MfSiBTO9KiLBhqau/yuS86d103IvaKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643198; c=relaxed/simple;
	bh=y1ZxZ6bn6iifQdN0di0FaK/JwoM3Lbyc9aGUXQBAQe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TowcmLY/mcFPraYWp6cBFfAXJ0jtYeJe8+ClqipmTkSo6pwWODMpn6ZvPImFB3e6+1f/cVLTpNX6r9yxVipU82x2wevHFlfD9VussxU0XdQDhN9cM/rRv9WWjWcfOn8Xz64unMWz68OW4RM6UTe0v9AvNwiFtOFlZI3lrxhWF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=s21+ADoX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuJHqwsm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="s21+ADoX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuJHqwsm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 605E67A0136;
	Thu, 13 Aug 2026 13:46:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 13 Aug 2026 13:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1786643193; x=
	1786729593; bh=OBqN4oPX5k7jbNY262d25bd+fETZWpbs7QqzWSt7ZVs=; b=s
	21+ADoX2RxiShRoW3ZRzZIwayKsiJ/hHAESwtmskXTTWUXdTJZEOsNWuwW/4984n
	fz2y78QinwZAmG87iSJJk379yzAyqzpBNEk54Ce14Rl8/FVtYa0ENTIIvKzatMgq
	pbUy5AuYp+ruyZljpZjz7mWw9FQPFg8fWCetm4DedWvHqtRz8Qo+I0M8DleBNTiN
	KQNw8LToUvqV7Gqn/Ei4MawUUAMgBY8dJpkogi6wbtpaNxou5QiPu1iN6xmKTrLP
	lM1/32i8C06z/jjeDUsluR4xKRPhYk2wH0T2ssvT+AxTtnw9OQHM3xwr0IJm4x8B
	a1iWxG5ZWBbwCOKmpmDUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786643193; x=1786729593; bh=O
	BqN4oPX5k7jbNY262d25bd+fETZWpbs7QqzWSt7ZVs=; b=EuJHqwsmb1vE6GlBY
	Ja2JnZvKKMyOJ0jvP62Mh1kIcXmwaLFv7sNty8iflAXypAivnjVLhyDex0Egrw2J
	Ut2u+TloxOHyMSvdaJCwfDN1+Aw+VePYhUR20thaZ7uECLxJ9GCVJ705SykL8wwQ
	OWVw0OttLAmBj6XdbCUlUWmaymx6mbAtNuPz0WmNykam5a2PHnLYfKEMPQeBkswr
	8LiFKZjkB0GbNAJ51M7wrR9HhE9XEBIqdpMDkNPaTYhh/rIb7ygxlmilpwfreo2P
	xvbR9bOzLN44ZdQ9Hv72pD5XQVPOCpHiUFTfbbhjsGs31XKiYvQa4hpwfZVhxL34
	P7Dow==
X-ME-Sender: <xms:-QJ-akA4hpR-wahkzv0thoCA-ltBO61rZ8dk88Xo2VKUu9cv_YTSlw>
    <xme:-QJ-aiUTdtsSPqhaepB4V63fV8n5SZQcAYCO6Ratlwr0PTM49v_jFoiQqTJlz8UzV
    kJKjnxmCWdcwltQPs4WNf_XMWofoSPBGckSccfpEeuC6DsHmftcXpc>
X-ME-Received: <xmr:-QJ-auCI_F2FKAK9FcdTt6TXNgEjNKPLor60fBrxWKNuuV8-MgulBdxcNqo>
X-ME-Proxy-Cause: dmFkZTFXctAct/qj/pWj57H0QMq77XwiOX5uPEMTQ0XsGVQzoCUvbPCvOJgbQOjbgOcx2s
    RFyY4tQx0ICSsm68Vhku925KF4Bv2oZ0+3DfN9mH+3QT2CdHmbJx8H9jq3YtHGjMjz1Eqe
    dG+JdFyU0T2HUcca0LFHWdQ/3FPmNcsrxmgZSNKZVWh5g4ZzD5nlzl38TxB5ch6cKl+Q3X
    /KgFOvTrvOCxH9XMck87HvTgKkRiQeiKFAvEGEfssBJEpQcgcSRX6XzTPVurgcMrXMa4Sw
    LvIqVjVyHtNQ3pCVeNQSwQjSCejtUAvRf8CP2VPFT8dUf88xemOoLvt8JCOKfx6nTzrnHD
    ynFN4uqGN4N4szmcOh4LerWFhPqdyR+ZcLoHZaRc58mJUbgIROk+caIldt6MAWxgZmTZlP
    anDtg2r603lpYMOnwD/ihWvY07AhzQH3DO37R+9VntwJuZEGVc24abfH9nbAcZTW6luALP
    2xNyQF4RBH0/vjB3P8of68Ioeqx6utJB8T43aoeic5nV5jG8ZZleos6HkfiDsT/TGeJqIW
    NSxAZd8ORTIUd1U3WpfZKlaDGo7fBcu1n6HBdsvH2Yc7b65yskyimrSiOhWqFLgEKCg9kw
    KUTAGXXG6myXtycujNRUe+6EQxnrXJe6XudBhFBNDVDbVfQlpGOyhmC08OIg
X-ME-Proxy: <xmx:-QJ-aneMKuq6VE8tifl3jNCA-aoa-lbxT2Auj5sjvFKKknVASkEC7A>
    <xmx:-QJ-atorr9Fao__G0n79EJ8s18J1ZQhx12Yc174ZF794zOo2Xx7mzg>
    <xmx:-QJ-agT41oLYyKcnOjM986ZhsKxyZASWD-DpNo87SuwADvTKqJehkw>
    <xmx:-QJ-alUBnUrmcDqzu8Fli7coPk_rPoZL2DCjh9yzMd6NCPZ2LCywXA>
    <xmx:-QJ-atWswKckS1oGslgMSgxGd4gyhOemHnPzIfA9Q2s7WUPqDZAaXBb7>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:46:32 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v2 2/2] virtio-net: Ensure that TCP packets don't overflow gso_segs
Date: Thu, 13 Aug 2026 20:46:13 +0300
Message-ID: <20260813174613.2920246-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813174613.2920246-1-alice.kernel@fastmail.im>
References: <20260813174613.2920246-1-alice.kernel@fastmail.im>
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

