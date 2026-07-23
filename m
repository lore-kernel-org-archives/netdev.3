Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7447A879
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821969; cv=none; b=UZm4KwAgc0fEdVAhf8Dnxzs+M38ZtOvlCetm4+RTcmPzFM9UV95z6k92bRhiqCp8sGUWp28BdDpeNSIrhu1vgKP3VE7VBkr9PipPv9pZ+FtPtmGSFY/QtTyqL9ptVoNflOOZDuOyKj5vAiF/FuUjVZu08++UdxoRAd4VjylakrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821969; c=relaxed/simple;
	bh=BD0vX8cDUXqOTFCJKp8z+JtZ7nLDeYBOjN25AdYZKb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHP/P5nb7hH5AmPp971PV1nzXCI551lOvxXHusQ0EfuSFBF0S4uoiKgbfSlpuP80Mn03srx5sNVKBcFWoUikSllYjPM7hR7ZdqSNw9w3rA7mdEdHG6VJNClt91I9P4GPC00L2QXJrTp1IDx6umodMicjX8iZeoyBB1DXNccFY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=eVjlYVwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oJcRSVeI; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="eVjlYVwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJcRSVeI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 67E2C1D000B2;
	Thu, 23 Jul 2026 11:52:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 11:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784821967; x=
	1784908367; bh=lqXrDLB0zVkRbZagBtYy8DzueqpDmy0iX10Ao/UGjAU=; b=e
	VjlYVwqifI/hmEYYYkl3gOc2ylzH0WBWz7iSXbCJIvIKMDed1VLJTT6JFA/dPRfS
	6dNmH9fEd1F4CQKafaWj2NAKblGMqJU2TljuLrixjPHVPdTsMAg1b50BfadWM+Uf
	n3xjyAgzP+qERBllCQ8rxhzww+ptHsDlwrHu5lTwpNEsPDBct0+wLfnWEejytGPF
	+memnQtkCGcl95dMRX4IhaoXCePXjM4+YYyZar2gsPW64tsYtLoYcdJIfgZfCM0U
	HEVAQ+zIq0myGI9dpMVLYAtF3ZiEfndjL/B9jXfvT0/XkYcrIihDB4CMD/F+rpiN
	bnjpgIGNJj/qG/TBkfGFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784821967; x=1784908367; bh=l
	qXrDLB0zVkRbZagBtYy8DzueqpDmy0iX10Ao/UGjAU=; b=oJcRSVeIq3iJAi7Tt
	J7G9QQ3vQkLZneu2lf1ljvOTJUh7acavrkiKwbW6HqeLPA9BzDFXYdUu00dsCVo5
	TX+v58Ummra+XNQqYte9WSy7cADN4sjacZmLZJGOl01T3tj7HKW71xzO8fzX+SJB
	oCQvAKnPW6VDnS3rPTPvf4pMu/3jn0cdgJPeB7/1ZsmZ/kOKEnysY0/yfRb1/r/b
	l/Yw0izGvwsB2buXLJM5hITQBQgB7Z4UIAQ/nYbFxbkI2ftMhmT/AS7SIp86oHof
	41MRxEkym041mulC0GdWd/8NEOkc1evECBEktnIG43CYkQAjThM6qVmUoEmb3Ggw
	aAVAg==
X-ME-Sender: <xms:zzhiasQ9F1TT2rHqg2D7xF5kaKE5abYGJP7gDxnjm9Jg0TrIVfAMBQ>
    <xme:zzhiarL7LfqiJPJ8SoQMShpdyuJaMmL9-Yjb4WpE497B7SkNMPDHmxF7jetoOQwIU
    t0HtpmR42I3vtJ6wdBvIm2vIPZcUhdzNFrB-3lLrunrZ55owDkSEEM>
X-ME-Received: <xmr:zzhiajHWhNXNgWeKJ8ZymUrtNpyi9qOux50b5zMAG0sjl84jObWIjGCeyQMob_UQl7fWWl1wKQx73k2LAKPZv58E>
X-ME-Proxy-Cause: dmFkZTG3huzurTGhLGHYJD4mCXAiubMRleDKkKJ5z5Ym8XpOzgnC/qnXNeXyXGyR3IG8go
    40drBCZaB/uQiEM0PLYJIWjYztE/m6WmjMwqbVqmaAIVOJX9u49SE8mXu7lDna9o3YTvBC
    BzdwKvzyfosmjHLzTO3HrrN/U/vlXi8NZpdg/YBW9GW3ulOp5L1lIKRsfzItzqHwPhaWys
    8tPtVhYmk+ZFqrrnwJzO7ekbtmbqVwyBo4QC54NxZGqzW9uX2fJb/ThTrF3UkZFtp2z9Nm
    RU7pTCaxQAEUu32HWirH4DiExkWzBrTkBvu4xqJ2lhrWiDaen1iNrgJUgQhHYDLJDS4aiO
    sVn9+gX1bwrBHiWKUrvvFKsgLJvZI9FNIhlgWoIfQu6VMYNqSw2P8sLpjJOsaRrrwNESNR
    +xaZxf5yyvEJSurQMUGRpSwXutHSc//GGtlXAXZgzsq1y5t4au8L3YlvJ6x46rTG0YqbGD
    a1tS1aJOG9bRBQu7BIchr1rQVTYlRqGN06xKuOH3aKELAQlMmkASL5QkrWkkfIOxTmL0ce
    A8TRFFA3D8gKEV5dGBSJjPnULc4cQFDekzwH3ceCT0sj6Ns6fd6ibnuQutDaKQU4dGxqqj
    Rmeh0LJxOyammJcS+HLyjqAM7STxJhP84l0rOE/Up9t77lrxLvW7c9B4/4vg
X-ME-Proxy: <xmx:zzhiaoTvITkeeyFNGcqxiIBrNaPmHKV8tcClwFfmQeKfLg_AT_cbpw>
    <xmx:zzhiasWc-Stt4ZO5rqJF7_e4KAgFEfGHKrIayh46_CU_WeOCthvXMg>
    <xmx:zzhiangboGwp-mVedAkFGyn1LGNZ7KPebttDYH42EpoToyy5FnlhXg>
    <xmx:zzhialfUaC37IFnWru30Sp0pNo8pjrXSC3LqLPAer7v8cLzByOXizQ>
    <xmx:zzhiahUA5cqigTY_GHzTmDYgsPgHI4PRVQ-uo-E8sGRmFTUYHbtL-wrK>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 11:52:46 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	HanQuan <eilaimemedsnaimel@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next 2/3] virtio-net: Block malformed packets that overflow gso_segs
Date: Thu, 23 Jul 2026 18:51:44 +0300
Message-ID: <20260723155145.158572-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723155145.158572-1-alice.kernel@fastmail.im>
References: <20260723155145.158572-1-alice.kernel@fastmail.im>
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

While the previous commit added a generic guard to skb_segment, block
such malformed packets in this commit altogether.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 include/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index f36d21b5bc19..11ac9460b16b 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -188,6 +188,10 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		/* Too small packets are not really GSO ones. */
 		if (skb->len - nh_off > gso_size) {
+			/* Block packets that would cause a gso_segs overflow. */
+			if (unlikely(skb->len - nh_off > gso_size * GSO_MAX_SEGS))
+				return -EINVAL;
+
 			shinfo->gso_size = gso_size;
 			shinfo->gso_type = gso_type;
 
-- 
2.55.0

