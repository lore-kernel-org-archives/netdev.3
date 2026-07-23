Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E8472F99
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821966; cv=none; b=UDTtHgXuCRwk/mCCpJ2oY1ZY8VhZvCa14ant+hKetZOxcHiQCSwMscAL64Dj9iF/WJbAlzKbL3vcF/7l3515F4O0YlDIkidAjxDnQgRCVfrzMVoqXeVci0LRAFwngAMOPki69WBK/d5+dNPlALo8tderNa8S0OxMRk1aTOxA3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821966; c=relaxed/simple;
	bh=3LJxdnMq3dIhVD2KlUZINgP6ymBHF1gq6LrGgQ70is0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy8yt17QGLWW+oyj0Q2AW1z2hzvFRsYcdISidcfq3d5TN3d0ELjyDctBXbRfbIcvidx8ClYx0cwV+HsEYFlvazwZ6K33XroT3UaJMt1A2YVPtryej9Nl0Rc3bs0rVvIZNnGu7ivAKxINprMfuqI3XHs5wESl+bSWHoodOEER+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Kzaay0X6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5kMsRzZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Kzaay0X6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5kMsRzZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F9ED7A00CE;
	Thu, 23 Jul 2026 11:52:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Jul 2026 11:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784821963; x=
	1784908363; bh=/s2o46y4Uk5NH0pLy01RjxXAtgKO5uRXNy5njznw6qE=; b=K
	zaay0X6YS7QwK+JnOC7Wq/O0mm3Y3dtjliWD3LwUlOV/IDf45lRVpisf+7EzpGKU
	WMtyV3TOybfAMmCHEJ7J4HLWH7J7VmMDQ/uqMf/6r8q4RSs9vbIcMQ7VNVAMHHvu
	WH9d9f08+4eAJbTUcAUiQdEbwhkE5/3owd0BzJizfJoSINBunjyPG0Z2Rg3Xaa+8
	vwOnFhpUvvs94FPe7Pb7Xr72TW96fLhozTm4jgeniVn3CCORQuWRwl/P/ZoQ5Wm8
	zMNhBVlAS7HqthzOl+RdSAYja5nrc6XOp6IZLUTkmuX4cwnQtcAjw0x8ZDfgdIOu
	xJ0XZUpFZONBStUDNPrDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784821963; x=1784908363; bh=/
	s2o46y4Uk5NH0pLy01RjxXAtgKO5uRXNy5njznw6qE=; b=Q5kMsRzZ2Iizh2E7B
	w9jobWYHeCTKfcSGaxnjKZE3w9vbkfTcMXhsvmz8mNv2G+Ope3wa+CPd9zBFxT3U
	1MQDTOB9mtC3+Jtqxa+XuwzW5yOGKirLNPHi1DZJbf3TylQVQ1ysf3qlxCbt8LTv
	/kuClnZ0aWP1x9aujBYGLRj7+ZODE2c8DhJ+rpcwmGRqxEtjdfcLWS71xd6hEHp8
	61sZaKbhbAOaESy9qfLlkUtphf8fW1RocviuvVJzlogdsTkJqojPMxXrGL/3mNtg
	zf4EzY5kFMEDuhWMcmzE1OHMj8+znz8tWnKRAQpuixSq54WzAEKF2Zk+rGsAf0MT
	oArrA==
X-ME-Sender: <xms:yjhiapnrxs8I0EHjgLkgf0Fz8XECS_iNMLZ2hlSTd7oo6cliVANYBg>
    <xme:yjhiaoyFIKo--PPu_vAzmzR_vlj0ghuD1b-KpYsiRVcl5DzGbKtQCtKOjLc036eQS
    an9aRtJqU2-2ZDJtnMmsxJUZ7QR4XhA77rm0slB93H1WYWH2s_KvG-7>
X-ME-Received: <xmr:yjhiakNb2zDX9tCdc7hQZ1DCzRxMDAiLvaq6IC1qC0vBKXkwrvIvAjPvnrAtypV7Zj_Kb5EfIH8TBnu32DhHvlGk>
X-ME-Proxy-Cause: dmFkZTG3huzurTGhLGHYJD4mCXAiubMRleDKkKJ5z5Ym8XpOzgnC/qnXNeXyXGyR3IG8go
    40drBCZaB/uQiEM0PLYJIWjYztE/m6WmjMwqbVqmaAIVOJX9u49SE8mXu7lDna9o3YTvBC
    BzdwKvzyfosmjHLzTO3HrrN/U/vlXi8NZpdg/YBW9GW3ulOp5L1lIKRsfzItzqHwPhaWys
    8tPtVhYmk+ZFqrrnwJzO7ekbtmbqVwyBo4QC54NxZGqzW9uX2fJb/ThTrF3UkZFtp2z9Nm
    RU7pTCaxQAEUu32HWirH4DiExkWzBrTkBvu4xqJ2lhrWiDaen1iNrgJUgQhHYDLJDS4aTH
    M4manf2W3+cK+OKqbvRlgM2mhSqOK3XKmLvSgD6CC66cFtWW5vOmaaqle0KsqdCdKJqS3v
    glHNLooXfpZwTxvczic6lIZhizfvi4rGQmUh3VBqjUuRFOKAfgpUHUMWv5Syhw1Zsz2uv0
    eJdA2OEzcASVAiifIkPV8PJjgkuMr3NrFp3Apd0ZcPfSa2ktlEvzKzyNSN/Juzm4NPBKrF
    Qh8bekUzWJt22/y9uJY4PuPM8b3XpuPCStaxerJh1PgicQ1YPRBQpfZma3IfTOcrRf0m8f
    k7kE395HdpRMjD+AOfwMK963oQfTlXUTUkG+c7BMJvG/tGimv5dFybwCIIaw
X-ME-Proxy: <xmx:yjhiahgXzjKkYsUJvxIlU9u9iZ1qG0ASIEYS-mXPnXwjNxMB4dcfTg>
    <xmx:yjhias_CgvndVxvMSxDBrKaCdQMLMqdMsBC_q-vIyqxW92Z9J_h5Kw>
    <xmx:yjhiamI-doKLZa3JZ5kIMqzafXVa32uKxXtjCVWUxwuTxC8WWvf67g>
    <xmx:yjhiatbTcmuANqstclTi0z1VKm4HzESEGlvCrTtTdsHiPW5-UBIU_A>
    <xmx:yzhiajXniD9gwI_SDVPHse4rmA3xA7B5SdbvxGVw0IYqROtAeVfDyljG>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 11:52:42 -0400 (EDT)
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
Subject: [PATCH net-next 1/3] net: Guard for gso_segs overflow in skb_segment
Date: Thu, 23 Jul 2026 18:51:43 +0300
Message-ID: <20260723155145.158572-2-alice.kernel@fastmail.im>
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

skb_segment calculates 32-bit partial_segs as len / gso_size, and then
assigns it to the 16-bit gso_segs field. The division might overflow in
some edge cases where the SKB is BIG TCP (65536 <= len <= 8*65535), and
gso_size < TCP_MIN_GSO_SIZE = 8. While normally this can't happen due to
TCP_MIN_GSO_SIZE, an AF_PACKET PACKET_VNET_HDR socket can generate such
a malformed packet.

Blocking malformed virtio_net packets is implemented in the next patch,
but this patch clamps partial_segs in skb_segment itself for more
generic robustness. Should len / gso_size happen to be bigger than
65535 in partial GSO, skb_segment will now just produce more than two
output SKBs, all of which will be valid with gso_segs <= 65535.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d7d53a7c58f6..da6f8342b619 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4854,7 +4854,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
 		 */
-		partial_segs = len / mss;
+		partial_segs = min(len / mss, GSO_MAX_SEGS);
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
-- 
2.55.0

