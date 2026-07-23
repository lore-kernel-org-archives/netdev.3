Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79A4756B1
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821976; cv=none; b=BEBL0yoZ4ohAuCqu5h2Bf7BNIkSJhKxVz+R1ACOp/iNmutD0I/jovyP1RrdKh7WKGI0HQhcGi1dnh/yHfBZs6lXQruM9zU/SWIW6U5/QUoOdKMtYJRRDKCvpfSjw1wsLZDFTel14VUgNoRUJL60xRWsXJGmHdgWIcTWAmpUXMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821976; c=relaxed/simple;
	bh=0N1S729vEvkqAzUPlM5NaHjfrKOosV9WQvYlAA/QXMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYKnXmLKxyBa3+zL+SrJ8q2yudJP7vGM1Au82qSE/0gJD10ULaCO4oft8kV3mNXF+OC2iYowBi5nl03D8D0+kVvwjPhWQ5tRH21yUVjUrC+OQrsUY+GTtp83Log0yjrvif6hCYN+ZzoavqYJOmEfrUNkVkHjZqYyyMsm7XSMu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=xBO6X2d8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4m7DGyl; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="xBO6X2d8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4m7DGyl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C8041D000A6;
	Thu, 23 Jul 2026 11:52:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 23 Jul 2026 11:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1784821972; x=
	1784908372; bh=zOI2JUveFHlOx82B8Z3EnLh0iB/vOM7N8YGacsVHOrU=; b=x
	BO6X2d8e/p5YYzrvRBgEHjN6tbZ1L8tgC/ktmCSDlaNxulHxel0M/1wn/ldYP9/+
	G213y0LQ/cQ+HGCQv75qFBkPR+nSrbfqaA/OngBF3hiEuaaReX4nWHEEahCu+MqH
	o9cJs8KDZnoMCMUroUd7vIcnI8FuZKDJIjvf2et5RWaaDOrolt0Rls9V1XZTjgdU
	CQKPnukjC+23IBt+chQxasym3pI9qnOYIJIH3JljmouMwu+N1+eL2GiJX0ypFemw
	6Ts0wLdmxTuxoN9uxa3u2u3NHn5t2gRDqvi88IMxGIS27LQ70/d090H+3D3YhOEu
	uu1/fyJ5rG6Hzg8J6TNCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784821972; x=1784908372; bh=z
	OI2JUveFHlOx82B8Z3EnLh0iB/vOM7N8YGacsVHOrU=; b=k4m7DGyldIn2WIUkL
	Vp2+gCwuvOoiMEPNquP0ayDibxwFJC6yGL278uy/vY5iu3gLMKTdGSyNOxCxf10m
	dlFifJA8K2mAB0Io4ySa4NYswklVd/hl0V3Aa2VvX7JWQc3YNMlgPj94GYmibr0F
	R102BUuzJ0Lh2EZ3HBTKKhNj4KTX/kVcACFsww6W93LZT3ojdjY99RpQJtlLLVtJ
	7Aoeukuh80Y2BilS1Nerq2AvFMS2XeSgr1L3HLl9PO/eEZU5x8p/evrZCaeI/IN2
	MkzUyJzq8mY/onu2pX5E6PA0tvG0tzUMlyTGNV1/XBaZzh5EQbTp2m041GAEKNGi
	2trlg==
X-ME-Sender: <xms:0zhiap5lmaaU2huJpZtTnNVheAfYztPZDkNRacwRnGSOBOWwowWHKg>
    <xme:0zhiaoTPXtTNIqQFNNe09roC3TgP9HWZGp9KCbvLYdBVGXyiEG7Wg6WfeogZFANXD
    J_aIbwpdbm7SfI0BvYMqaq5aWR4uameKiXMh9dqDdfisK1FH8oIyEMH>
X-ME-Received: <xmr:0zhiapuyNfztSNHxZl83ztceeLFce0HiKpJ2Ou8eepRTyDR7qF5E0NAsra9HpXBqN9t42N4mrbtooSt5rXAocFVD>
X-ME-Proxy-Cause: dmFkZTGLqDcFWSVF8hUQPiUvdOXTiNFZYqwaxiuPIIS1/HXO4KGm2noHHA0vPuuZpvV13k
    XiC4k0YuWiTeZ9H1eY9EYJvhBJWtT8uOT84lxiFTmvX7ni8W+pXO1BSq7yl8ol7Tbq09d+
    wz/rKyJgVYJj3Md9K8MLX4V2Cd07fQv7XhDEW4VZGcE79znsmg84cK4wGBIRjpCpE33tfx
    BQybLJ4lBlDHUZ9gxzb5hPj2meSqndE+NEwQ2BgifoRzwKbq4wyMg6xNWf3uYpVMPLq22P
    ruHFiJ65bxl2NVZ9w6QoTZx8Vs2Cj5+xj93XpuuH4QSPME95clNWSyI+ZO048KhenLnNBE
    sK5Lj+vsxqJM+w7RDwkFQVAIZsPxdrI5hSSPLblH4zhlkcJvz6Q6xYpx5nnDNHymTw11HB
    jbGzQW4HSTLROqSerp8hOD6d5DQvea2DAfWF6W34lx06SWyBkyw9J7hZjxa7CR3I9j9aan
    bYjtDbOYHvpCsPxy5H6ia04yr+yiqfGSfojdAlAsIVPHxmeG03h2tt9jn6pYoNzT0I//Cn
    ip0dcOGpGfQuKkBV4lMiQ3jUtMNgE9Nh2Ld0lhVYtpYr/zZDs4K4rPpNeQJX4JEkG/bdE6
    bauHt+FdYikbR1l++3Gpm/W3uOAfJd6xTznSeiI9am0BO85XC55wqdQ1azoA
X-ME-Proxy: <xmx:0zhiaqYEL7apd8CJRrf4Jl7QgbtUm9DsIhZlM1Tqf-gPdZysqo-5Rw>
    <xmx:0zhiaj8o4CKsdn340yzr300mlwjTfOR3tQB631PabJn3rKQKkjSKfQ>
    <xmx:0zhiamoakQ6aRpIQ9sauoC3lpl6axZROxWFwQe3eSF3xwj4TsisB2A>
    <xmx:0zhiamHNKoms3I9vcz1pNzCmkvJiHQ9QO7g7_rJ9D1aqhxOHEO9EHg>
    <xmx:1Dhiah5KZEavSDUTFPMq-AQaSD83g8L7SVCH7RI8qfC3g6aqxBFyaXj6>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 11:52:50 -0400 (EDT)
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
Subject: [PATCH net-next 3/3] net: Limit to GSO_MAX_SEGS in skb_gro_receive
Date: Thu, 23 Jul 2026 18:51:45 +0300
Message-ID: <20260723155145.158572-4-alice.kernel@fastmail.im>
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

NAPI_GRO_CB(skb)->count is a 16-bit field used during GRO aggregation,
which gets assigned to skb_shinfo(skb)->gso_segs upon GRO completion.
While doing GRO aggregation in skb_gro_receive, make sure we don't
overflow this field.

Subtraction is intentional to avoid overflow.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Assisted-by: Codex:GPT-5.6
---
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 35f2f708f010..1a9d2a4f9a80 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -126,6 +126,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	lp = NAPI_GRO_CB(p)->last;
 	pinfo = skb_shinfo(lp);
 
+	if (unlikely(segs > GSO_MAX_SEGS - NAPI_GRO_CB(p)->count))
+		return -E2BIG;
+
 	if (headlen <= offset) {
 		skb_frag_t *frag;
 		skb_frag_t *frag2;
-- 
2.55.0

