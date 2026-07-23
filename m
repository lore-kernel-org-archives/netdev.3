Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E522F363F
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821962; cv=none; b=SG8x+BpGO0jo6U4iQWFjdwHFmA3iK4F0jMgWzWTdLLES1jz4pHrSykUdAHcYi5g7Jnxr9JHBCf2n06o2bAQrPrLzowJOOQdZuHhgUjHHzQKcc52LgsErR1kpcMwqNwaBkw/fH5Sn+i2/cgyMgSpBRYT4LdnCU4NN4akVt8Em7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821962; c=relaxed/simple;
	bh=o9NP2P1uOmH63zmJRqoraPAg/xqNRahVkYyIMglxZ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUqZB3IRL57IqvOUtqqKjs5CEj28zsjjENwJ3pp3mspNwBhwOfLB7SytCJDfONm9+hKOineVXRajSBmnHSFEA2OhRk0S58Ia0m9fW6K4CGQe6DGkVL/qDhz7/cKiYPuLYL4OTUBg/Xkh7tdzXt1EYlJhn76vE+gK8C83g+IUCRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=qA3Zx1s2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUjq0Fly; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="qA3Zx1s2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUjq0Fly"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B5DF11D00103;
	Thu, 23 Jul 2026 11:52:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 11:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1784821958; x=1784908358; bh=OQNX2NfvnfJxBpndSOaFo
	bgsEh4H8cUsk8yd04XWkkI=; b=qA3Zx1s2iP6iIPD1PGqf8Lx7VKYrXYnGDp/LJ
	1hvLopozp1doz6+mmQigGPMFKGUDgc6c53U+qWMcAc8UvmgdHn7Fh9GlcUOi94Jd
	hBh2AfJXK7CuJxzc1rlYU/fRAO/9q3k/BR+opI9DfExMSxf3vzogr+DUhCga2saj
	lF83EgBxc1edK6hVDoVThNs5HJOKgSZJeHJHi6tUSspSOOFrxUT4CTGojafZZpKL
	AqFT9DrNL8Pur+rPERFiV9s63CfEVI0khApj7fMgHkZsPVAFOfqiDL76EdWSCZnP
	D0V9tVYL/iJkQ6dji2zMq4Q/NI33VGEQXmN5Vvmxb52p6HdmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784821958; x=1784908358; bh=OQNX2NfvnfJxBpndSOaFobgsEh4H8cUsk8y
	d04XWkkI=; b=IUjq0Fly2LM7VHZF8PJewnck3wu7G4s8CjpSTxJOBcQFBKt+40c
	V3ch9NnLlg/+MwEnIyamIk5CgTR68EFX+oskh8r5VIi2vd7gLZjeZBTPKOJwty5M
	kDV9RtqxKxkaocsqwQO77BjWkogcW+y1y7P/K8thsEF7fi+SW0NB34SNEM7EBBMx
	mNuIEdCjuqHV/vyzWclwDeIi4uVSu9+YSM66luAJNbVUJ1wjSCt0oZYnKbaMFa9k
	K+H+PSZFXeOPkPUQJ3Udrai49bZkm8W+N0JJLHStjpfqOIr1xqDczN5MyLokjR+y
	wMJtj1kzVeg2o6vKQ1xPLcFK6AppBNrWntQ==
X-ME-Sender: <xms:xThiakoYjLpIS-YFRP_8AoJtU4FZ1imqzE-zZq6J6LLbaWQsm6SlNw>
    <xme:xThiasBqyz2Ei1hUo2fiumsSydiUbR4JtAqUizKQfL6qtVOTEQEN-Bm4f6J9y80Je
    dKRyxAeU4_zm1562RMEiwNn19i49g3KdqOAHyvErN0WG8tDqHC4HwWh>
X-ME-Received: <xmr:xThiaiezO5bJMxmfIkIMK6mqINmY-pqpQad6P3nUwUJm4LGv9u-OSYfJRYcvOoeNSVgmoJxFGlJ5sTmYAngA4gGh>
X-ME-Proxy-Cause: dmFkZTFUCOnSmfgs9CaJ/0VXpt0o0YmBTXqoBbpZoC2ykqKa1Qy8yx19nM8dfMsLykrLn6
    mHYyincJltFDdePVqYtCP5xc/F7KSdS7lgxe2mVPYm7siaZcZViWBWROOR6d2DN81YTU84
    Zj3HcU7wJGr+Uqo0BzVf/H3hW82I3hOZOHf9R5UjiORMc8kWjr2rNY3J/M89bsa+QrM90Z
    kH+hOsJjlz3dTF/jm9oP6lprckaPn07KnNZrJXzrXEPJVqmuMXra8VZO/Z13dDkLP37PKi
    438GPhKYZzkfHaBosdHxOnhZjfKfJO6YgLRpXvbJNEku1HBr2rRDRvDTsZyPnvRHFAjdEL
    BGsesm4u3czfVcFvOM14RddzFEZIyUdTVi60oRnMT1qjZ33DBtxiAjq3Lz3l8iVBgZjlvY
    DinRfHZP1+Luk/3AnXlPIq1FvfG0TuJDF/ipqexwsaF14+U61SspDqHVP5+nA5sKY6MBQE
    /5TTGyI09gW8QJN4dwPMrY9P/L8nENwyhtEf8Wg8+1M0ZMSBUITQBtiuS2+X7hNGr4MP70
    Jue69SbZhQNBbZ++FMcwn3p0hRc6PkwlMt8nxr3P6rYjGGkxywVcd6fAXHkV/7diuC4QNn
    vgAXvZ+vK204kLwVTGLmHlJ4nQtnFeMJwWTl1HN6hF3AICX0umEDbF6CBP2g
X-ME-Proxy: <xmx:xThiakIIS5hl5T21glCAL6sVlQhvffUuV28Myxhn8cnIJ9D8ZAJG_g>
    <xmx:xThiaqvZ2y93P8hpqTz9d1CM6JvUrKkZxp1GAnlr7QkMXRyCSvlXCA>
    <xmx:xThiamatsu5isnHI0lTfynCznh1RFwwkX8lg4RcRzy7ATg8yE3IZrw>
    <xmx:xThiaq3K1CkyoLVJS3HuHiu_VAwJIA1bkC2IQBQ5gUqKSLPWLnBFWA>
    <xmx:xjhialMO_A3Cd5RzKy99E1lo916mBa7OtRICWn3mJc24lI7UQ54i_cuz>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 11:52:36 -0400 (EDT)
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
Subject: [PATCH net-next 0/3] Guard against gso_segs overflows
Date: Thu, 23 Jul 2026 18:51:42 +0300
Message-ID: <20260723155145.158572-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

This series is a follow-up on the discussion:

https://lore.kernel.org/netdev/CAD0BsJWzSr2zduf5v3mVC4zd=Lj6ZAoC+V42-VBdg42aDY8XXw@mail.gmail.com/T/#m1e22fca273c36cc8844e516505d3251cc1418fea

skb_segment is patched to avoid possible overflows in partial GSO. The
possible sources of too many GSO segments are also addressed:

- virtio-net blocks large packets (>64k) with extremely small (<8)
  gso_size.
- GRO aggregation checks the number of segments before extending the
  chain.

Feel free to drop patch 1 if you feel that patches 2 and 3 address all
possible cases, and extra robustness in skb_segment is not needed.

Alice Mikityanska (3):
  net: Guard for gso_segs overflow in skb_segment
  virtio-net: Block malformed packets that overflow gso_segs
  net: Limit to GSO_MAX_SEGS in skb_gro_receive

 include/linux/virtio_net.h | 4 ++++
 net/core/gro.c             | 3 +++
 net/core/skbuff.c          | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.55.0

