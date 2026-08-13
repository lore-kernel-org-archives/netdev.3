Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D083839A9
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643186; cv=none; b=GlGkpF7HAUQp41y2ySwikkBXJAUEZH0bbNBZFNcru4eRC5aESeKDou73jGGedufli5bG+w9w3HbEHBVrDgrmlEQrit8LJ7rQ2QckfsOMbb5WYTkbtLrvU6RJfuwfuaVOTRy+swDwNN1pQWCCOfkQ8FeI/Yq5FUqn6C3wZ7Y17Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643186; c=relaxed/simple;
	bh=YlALe34Y7cruiqOaEqz9A114EXJqDVlc4vZu44JkF64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKadCfedeM6CM4ewzuOvhFyfwHV4IW07hGV0GVPxYzXkZj+RqwOxb6QSeLwmJbm5+0+TUFepl3G7dlJvkeXJOrjNnVvFamqlSuze+qh2oQ0d+0euRWMlUi6xlTsL5yPazIx8h82cHmHqWPBbbzIy7VePqB9QzHYg4cYRI/yNbVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=CJWl3onv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=el7nyQ3Q; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="CJWl3onv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="el7nyQ3Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 691CB7A0123;
	Thu, 13 Aug 2026 13:46:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 13 Aug 2026 13:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1786643181; x=1786729581; bh=iZPMYyb32ChbOfnVgaVCW
	8ryTStckyz7EvRz2EMTM5k=; b=CJWl3onv6mMctgOAsAzvg0hlk2QCIEVFrSdDE
	V7WX4bQ4dcwFjPva7WAj3fbLRJREY/bNNiQy1rUMBLgWF+QFIYxKXSRw4pFsZdUe
	bYrmB8mcsA2hhDPfvX7B8+zxpp14pEi7ElS9zgYTZLL8O5uvkOW/1kSOvJYzK2yk
	NL+sPW8ZUfwx2/vy3yfh1PivVc68vTVAPfrLQgzZDXZnkxhOXXmXMQOdndMTyy4c
	LOZUtkogd5D9IRtvEeWXg9tr+lYmY37yAeea0XY1O1lCfqUR1a8Istn/DORnmxgx
	WVGixNoO4XbwqL2wYeuKSBYROphEeVU7wsPdPwg4J+OzZv3pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786643181; x=1786729581; bh=iZPMYyb32ChbOfnVgaVCW8ryTStckyz7EvR
	z2EMTM5k=; b=el7nyQ3QloKuyutgkwuUgvi2j5dmbniZDVHuqovGbS+fsvWypMT
	SfG0I18ah5TJGrdgyHEcF0aJ1umqXZlXSIDn2U2OjSst6tNIaGX19v5nRLStnEcT
	4UKMLH4Id3YfY7TdeZ7P7KQyvHwFZbJuCN5qEW11QKEIE5sbXuVLYivGxD03Tuna
	2nHJPkiPe6mfaj5mYyY9uqdKk4N+tkOTHIhWIbjMWRTWJBEkkw+6v8NvBsSFqpQs
	PWYz5Ac+8ocOOU+diIf91GKlIwr9MNN4hV8Tb8LVL1c28HDxXEeZ7TsuWSmtZDlS
	+ZPz9/8VgCbjI9yRxnXvsyF6wo0holDmyiA==
X-ME-Sender: <xms:7AJ-alcc_xFZBZv-wGzdF0Xg1l5SsfcOOkZvfXM6cnSWPY1QYx-e3A>
    <xme:7AJ-atlPfvaC3B_NJC3tGDStZEFiLDotm8hylKtoKZNLVGTRbWgpp4kc3J_NyEjyz
    pHEaeCI6lk64VnKYLW4k_NPdsc0yUTjTS3xcEWiKJv3rrhLsJ7v0-Yj>
X-ME-Received: <xmr:7AJ-akqVV-be3PtqpnuiihDDPjmLlmTvg1gjlFAF5EC1CI3lul93POIYrzU>
X-ME-Proxy-Cause: dmFkZTF8BwqCxTF9Ta1+fxJ/kYd2xBghwlXc5hlC+mGTL3rNsj1ldzvH65QtVlZ00TiRJc
    3zpmPumsXnZibPMzUyxCrkE+JKvK1T3JGviiEtFWuHkmxk1rdicQt1hyQT5bqy+pjS3aNk
    VXs4DgO/o5rJwee3gB9snQ/Dwlji+w/cDloHliS8dKdxEGrksb8Oz7NDFw8IflN1aA1+Fs
    yx5hi3GBKE0ikHxLP8QiLk5tDgMVoip8GayaIGAu+ywlKkMi8iCvGzRh9YKz8Uu3tzQI94
    +WW1FaMTg11RTXWAm243RkaGsWNAmBwWJ4fXraC5cHjtQd8W6VEnZ72o0ikaRahLGpE1oK
    iiVTsYIEIIZYA/keB9wOQKX2nhpE30vIinP4iSQLIG4ggDRtCbdnDHmmzDR78ME8kmeUYg
    R3IQfMqWon4b3YWqYZxcgC0ZV8d63NH/c6/QubaDO/hWeuL6tFVzyqoU1CRagECdbJNrjy
    Eo+wlF06Ge5GbWnHGfu2kEecWzeH/3zMqBeGCH7UEvS78VOeOaZ4idU29TsTQE1/P3fzjH
    986HeiYzN7trWcThSFA8wYlcHOCxgJMDXDtWuRBlyfPEp7sK0ghvt4IMY9gCbDzwiCCT1f
    O2qDAngaWFY5vHRx+3K9JyiIntGPWglRzywNpLoNmVL7AEttyR7D2c9VfdxQ
X-ME-Proxy: <xmx:7AJ-aqEwCqv_xZBcT0QZyFmzae8sjuknPvPQxIo-oOJg2-KY9fDg5w>
    <xmx:7AJ-aqRfngHGwHCtn6t4mJ039tyc5AEvwy2XcIZQ8R6rY--8ya8Y5g>
    <xmx:7AJ-agOENpG-hOl66lgDtVaz0risvb4o-FFrM-rttWJvMN1IDieXjQ>
    <xmx:7AJ-anlXeHxs8u3Gix66fqCyzqkZKII-ofQB1lhCHVbCYML1Wpf5Mg>
    <xmx:7QJ-apkrDBo22gti-b_P3gjTrp277aVdRXGtuEZS3yugCVmOAZJlU7wS>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:46:19 -0400 (EDT)
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
Subject: [PATCH net-next v2 0/2] Guard against gso_segs overflows
Date: Thu, 13 Aug 2026 20:46:11 +0300
Message-ID: <20260813174613.2920246-1-alice.kernel@fastmail.im>
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
primary possible source of too many GSO segments is also addressed:
virtio-net clamps gso_size to >=8 in TCP, as suggested by Eric.

v2 changes: dropped new checks in fastpath from skb_gro_receive and
__virtio_net_hdr_to_skb, replaced the latter with a silent clamp for
gso_size, kept the cheap guard in skb_segment.

v1: https://lore.kernel.org/netdev/20260723155145.158572-1-alice.kernel@fastmail.im/

Alice Mikityanska (2):
  net: Guard for gso_segs overflow in skb_segment
  virtio-net: Ensure that TCP packets don't overflow gso_segs

 include/linux/virtio_net.h | 4 ++++
 net/core/skbuff.c          | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.55.0

