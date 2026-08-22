Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96B3C3F71
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787400099; cv=none; b=AUIg9Y3t3QwMz9r0BteX16O1h6FDL7tXeW6HMcKB4uI76/yLz6eVE36cH8HKuywCVKZfgUhoL2ku7ZD7KDhCQ9nRuUIDjJELle7/lEgIf+zctfnG+XnsL294oeDuKsAex6ONeIE6vNvk9YkaKO/cr6/+bXx3pbrWgzjcVn6+kLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787400099; c=relaxed/simple;
	bh=yMOm/056GvTp16706N7HmzakAYUWNlEzBbq72ZFtobQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=diCJzQlPi35bnr7jWzwnvr/gDBtYIX+ti6h1jsgEPUQu5lLony8h2tMf0KNFcYNE0efcFr/8Wb93Q0SMAmUjGkz2T4wb/IHu7qkZ1uubFJjVIoVcZacXaIqeQhtzfl6FuL7OAW0o8yAIfO90ShiwIrDNKAz3zXazgr3Ghn2tzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=f3u8VstD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fA9hrQx5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="f3u8VstD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fA9hrQx5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 633D61D000E5;
	Sat, 22 Aug 2026 08:01:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 22 Aug 2026 08:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1787400091; x=1787486491; bh=NYvzR76V4xFlYRsJ3LOs3
	1O1rmtPm1G4P2uttxmhqV4=; b=f3u8VstDwMhUtNYFfdpkrlxF7nT00YtUtZVSV
	xl14yFNW9s/BlmoYxPB/uyzJTh8BQ99wEMlDufFzl26u3BmZhksolN54+vzUmy1H
	tFNXqcRIyoBVEnc/bbEWkRo5gU725gJWayQ5tURYzuxcGKdre0v/f7+H60lz98GB
	pFuXmnfotwKvBkApnBRxJ+ZEcis9TPpfs6PcA2mMQ8hBFhyXsGKM4rPjitfZmBvH
	ahzo8MHiI5KH9j2YPXCqanPKCLKEfgKQx+uYo9MrX1kr/uIgvU0xRlQlOIiPmvgp
	OlamVscincResLrhMDy+nO3tSmjtdgStKnfpvO4GcVzHjE9IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787400091; x=1787486491; bh=NYvzR76V4xFlYRsJ3LOs31O1rmtPm1G4P2u
	ttxmhqV4=; b=fA9hrQx5ICfIJu0aR/bNh+vUUONOVmwHP/w/YxU/zyTRbV3yDK2
	I9v71hQp5zGaNDdEfxSCLPXk08MA38f+0GXwIIMVUoPJ28EH+dQ6swjY86EYJC8U
	QFKy4mxWg1su5teXXV7qLU+OVnSea/o5QKt6Om8F2/XEsQUnoSPxe45ZqxpICrpZ
	XXfPXXCE03uJ5zzUAJRD33Yrfgp41tJz3RXgNvt9dB8A3tzjzmS9vXz9utYOdObj
	Gt3+IIDTEQu+JiZ9Lo2m1WY4BFTOkHxFhUZ2OxrJIlYFcsNpO60tCPvb3APc4vux
	zl+nhhAFgfhO4a5WcjIL5o7RFRPBp189xbA==
X-ME-Sender: <xms:mo-JauwpEngQ55HM5d1JrSX_52qjlNgZ32K6QKvyuAff1sXiJOuH0g>
    <xme:mo-Jah2xhxVOpfhRl_S4xvTaeiRFAd3VZ4Rdpadyy1BRrCHG04arDIYmxbLTGh4AD
    c53k6oAxyyaKoKmpwXZ-BKFIH1_nfPQiQFBnAmrjBXli2YXn6r9pgI>
X-ME-Received: <xmr:mo-Jav-BTZuV9qQ1OuFK7AkQJBnq52uSjgePBukejqEif77FhrthNwpZ6DQpYQ>
X-ME-Proxy-Cause: dmFkZTEbFGsJtOmWAkilWJFIVsACxCNmjImBuT8faZAPiIV1FujtLUHykhMAOjv/XU/Hgq
    cGXXgMdV26n3YISQESQGAm+HSLg8mSyppLmiK5BMIpOHHFbhjAUFJcUIPrfmefBoQ953DP
    8A9+sZOi5TnFDctSbUl6mb/4ThoT3M7Z7pIhe9bdEYUHpy9VipUrdvzLscTZZ581vmZUJH
    yanIVMPkHiexO1JxKImWv6jZQvuiljpZpTa+cXlWuZ7Y1C08AfvVBTHMuXB5HaitGDPwBq
    uKKbx72vGzp9iZpUaRGoeXnsvM2ShgDEsYBc/JZ1SIDzHexPB3IMyfrqYSrzQw5693sjs3
    5aqNN67dsPlotlD0HDwoYlC7YhIJk/eCTBGZfJDnCu+/h4lTom60ynrd3WbM7siJUOE59r
    ZEo6zCytNMzk6LqgDvUUeNZZzTiBN4dkth7jGn4DFiEaFjoDqL8xY/8ploqmzz0sSBrwVu
    2xk6SNLJD+kFO24eLporcQIy4EHatsYU16p61rYA6m2SbiZ4HJ2WTP/yV7kQNPGGgXEI/C
    wokD8SNih/lbM8Jk15Wp99SKwlzwuuWST9oZqgYq66ugovR9msM0bcVGeEfO4y45UwBVaW
    yilI0VJ7gjuy7GVhUg4AG5mgi+bM+n8azKq+UTB8HWDfWRSVLaUTAZ0fVwMA
X-ME-Proxy: <xmx:mo-JahTTkm9jaAVGjd43zD3jEK9nvHwdqdQdrJdQiBtwcQPMcjHf8Q>
    <xmx:mo-Jamlf6W1st0xeu3xGLbxSOTuCFjeWm8VAo5chPmE0qGzdyeISGw>
    <xmx:mo-JasUzaFrF1fjCm3DpMidfWYBsJySmJX_KKPygNvn-EABx3hoI3w>
    <xmx:mo-JarckeSJOcl1oDeH58LHagN7BRJ06xSSWyrsRvbQ_xWQyTmF8MA>
    <xmx:m4-JalMdvvLVSFl17bkuGjbW2E3xahRTY24d8lj8PH1l0ngY1hXnrHWa>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 08:01:29 -0400 (EDT)
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
Subject: [PATCH net v3 0/2] Guard against gso_segs overflows
Date: Sat, 22 Aug 2026 15:01:15 +0300
Message-ID: <20260822120117.1163423-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
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
primary possible source of too many GSO segments is also addressed:
virtio-net clamps gso_size to >=8 in TCP, as suggested by Eric.

v3 changes: Reordered the patches, added WARN to skb_segment.

v2: https://lore.kernel.org/netdev/20260813174613.2920246-1-alice.kernel@fastmail.im/

v2 changes: dropped new checks in fastpath from skb_gro_receive and
__virtio_net_hdr_to_skb, replaced the latter with a silent clamp for
gso_size, kept the cheap guard in skb_segment.

v1: https://lore.kernel.org/netdev/20260723155145.158572-1-alice.kernel@fastmail.im/

Alice Mikityanska (2):
  virtio-net: Ensure that TCP packets don't overflow gso_segs
  net: Guard for gso_segs overflow in skb_segment

 include/linux/virtio_net.h | 4 ++++
 net/core/skbuff.c          | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.55.0

