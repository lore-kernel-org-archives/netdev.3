Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B92F12DA
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399855; cv=none; b=Yf0GzzT6Ui6frLvmTCY3afTNlOv/ISLIvo3zWUTMfBoLlPKKzlBmQY1hq2A8ts/hkb163hqTVKcnjP+FwAj3A5GiyRw7MkZZUUoTOIsxkmbm2TIII/Oz4d32VBWdWJOomvMQMimkFvIW/lYfDkPzlDrJ06f4+Tbna7Tw5S0i61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399855; c=relaxed/simple;
	bh=iP3+NMv6NPULkKlmdecOfNEBw5EL7CqgpKZA69rdzWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWvWDm79UnYxCmvzbE6n5QJ/YeTbEnozbl6KV1XOmp71pkl1LTI11JAj9w0o9sQR2u2TnHsoj6H+3hG/vfvCqFZBEUNpllj+2Xd/weSlt/4lIqg8TVXwcNwg2kHdb3QVhfgdgBcm0Z1HxNv8ztV7ceOr6MBZAKUMpXOvP03Zf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=INW4/YQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2lCFQuY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="INW4/YQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2lCFQuY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA2E8140015E;
	Sat, 22 Aug 2026 07:57:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 22 Aug 2026 07:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787399852; x=
	1787486252; bh=9yMiGxfUvLHy94sr/KUqmYYYoIQ6HhmJk4hBfcLy1UE=; b=I
	NW4/YQ4HLS9F749CvbY1Wc1js3KuGfA8i0bCIZXNElAh8QTMND67BSvP3W0J5Cap
	CmU/LtLV4Z4bChLtFwEIlseNdCF/eb5PCesePWVZaNWGQ7QBNb6JTtAHlDZqphu1
	th+ZFNwyangX9k6HHVnfaFAszu6X/XinUMxa3whGB6cYw+DAcT5ScybMmdN8BzFh
	m0ccOyYQX4YRAQeBYuPHiDdub4/OTbfmiEXBj7sVNMXuEejDZD97xHTc7W93lAl0
	hSplLyc3fAqk3H/GUCqZJCIMvAUhdUTyy62FzLULmAt3JuFWCFfJtv9eDQWNAHLT
	178LjLc0ioWRDHUL9NorA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787399852; x=1787486252; bh=9
	yMiGxfUvLHy94sr/KUqmYYYoIQ6HhmJk4hBfcLy1UE=; b=G2lCFQuYpES74qJTK
	xvE6rWupPLUppiBYxCPq9onW9dxAhnaWTDQ5Kp+1W0OG4xXmEJ5XXDlSiSFinl8O
	N0cNvP6x/0Rzwa8UgMLzp6i6Vcx/6gKq67cOqYifBRkfFOJpwXM0AqyPIisIyuR/
	XM51Js/2oJ2LN/6w3/HTAqIJIrIghNc0UkLeXVzlo81RhOfZqybjseS7ieaItetk
	3cBPYxpz/cY+2GvwEAiWC2fegB1vX+kehoSrkQKm6vU/jcQdALx+5gjwpjtgEY0h
	spNmmBiVTGQbs534HG3Wymw3sBuGGO7738rC0BML88VahVs/V+93ivxIwQXeuDba
	BK4IQ==
X-ME-Sender: <xms:rI6JarChmA9lNsIB9G_zxQETg4FLoACvd-D2Uu6bMIrS5xgyKn-b6Q>
    <xme:rI6Jams_AaQM6I076-ubGyar1J59y69O0KuqpvWICi99rDr1UlQ8d4tgdGbT0Dzcm
    1UDfnnE4zBAEq8Ll2OtHH_LbHiSi-S3rlWAMVzJhcwm2jh5JbhqxVQ>
X-ME-Received: <xmr:rI6Jap-qkFOA_mFJo9mBOrQzJ0gMA4mQ9lUg6sTCj8htTaSQ6ccgs6AHiT1dOg>
X-ME-Proxy-Cause: dmFkZTGieKHeAxnH/iR+FE6N6OcyVm7Qn3RL6YH7XC3AtDbxzppyY8MSJ/1YMdQgU6rtjD
    z9nt1H5AkWp2Andn6Nveva+6C9NpZq36JTxE/z0APl1V1oRpEE/v8xVQaDcipfZAfIDr7w
    0q28WqFRTWagD5Q3OvpWJcYiyfzBlaX6/O+ksDPHmOj+CORUh5kJLqcqf1rtqDyruFHxut
    6iy3g3kYQD8GB6XqZhLmxWcdIuHx0r/eayzqtcIzyzq7reVpU9vCKz6mcsL2F93gSQvMFr
    iTr09/DDAlLQm6sXhwo3Gb4IFwgEjy75IkWgGba/F7thrJsgso0ULzBqnGnRzwMYD5pVD+
    A55aJMGUI8J8mpatOvpDg7HBnuOA3/LV+tpMmaEdtojc2Zef4Fh+6+uU1il4TlTAVGRVUI
    xM9GIh77cNt5xEQv6+Kgo1Zyj33BPVfBmwTcu0XP64y07tBVChcGVfUHq2O6ILy1cFv9kM
    4OHSaDtPX9n6NtxVsdEhzxLXfvc/xkwPULrRm2l2VXikkRZeeGaM1sBogOVpY35ugtK0Dl
    l6EE9XQcCXPd07hwUVyGPNUlSJQgYaSUXkJi9GG+w9RGdVibGxHzZAPx7jnAFNuFIr+24E
    sVY4+5blwZz/8RIV+otnEM/BxIl0xaH5G6LpEQreiINzoh0xT6HuhaKHN3NA
X-ME-Proxy: <xmx:rI6JatS-lViGz0RpClrhF2VbBbWPhvxTTnGCwiSEUybJMiki1rqdOA>
    <xmx:rI6JarVLIOc9QvFJBVLOD3eEaTgfc5ZH0pD9HyABkyuLeCtSj6v6Dg>
    <xmx:rI6Jav9ZgW4I8gnxEd5CtGxBi6C0xV2hQDZipB_hu0n_RJa_yDN0SA>
    <xmx:rI6Jar38vZ_H8oQODxaQM8HszNA3v5R_RRhBG3y82vpS_uYUe3yRPg>
    <xmx:rI6Jaiyv6D3v8oSYIqsKcUdTl-TMpg5Tw7_zS7w0L-KsY_SRsPVflvif>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 07:57:32 -0400 (EDT)
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
	syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
Subject: [PATCH net v3 1/4] net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
Date: Sat, 22 Aug 2026 14:57:14 +0300
Message-ID: <20260822115717.1161782-2-alice.kernel@fastmail.im>
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

This commit bounds cork->base.fragsize to IP_MAX_MTU to avoid a
possible overflow of UDP length that triggers a WARN in
udp_set_len_short when setsockopt IP_MTU_DISCOVER is set to
IP_PMTUDISC_PROBE, and a large packet is sent over a netdev with an
unusually large MTU.

Steps to reproduce:

1. Set device MTU bigger than IP_MAX_MTU + 20. cork->base.fragsize will
   be set to that MTU in ip_setup_cork.
2. Set IP_MTU_DISCOVER to IP_PMTUDISC_PROBE. It lets maxnonfragsize be
   set to device MTU (cork->fragsize) in __ip_append_data, rather than
   to IP_MAX_MTU.
3. Send 65528 bytes of payload (+8 bytes of UDP header, +20 bytes of
   IPv4 header). Device MTU allows it (it's only one byte bigger than
   IP_MAX_MTU + IPv4 header, and the device MTU is bigger than that).
4. The UDP length in the built packet is 65536, which overflows the
   16-bit length field and triggers the WARN in udp_set_len_short.

Note: IP_PMTUDISC_DO with IPv4 is safe, because ip_dst_mtu_maybe_forward
always clamps at IP_MAX_MTU, unlike ip6_dst_mtu_maybe_forward.

The Fixes tag points at the first commit where I could reproduce the
overflow with IPv4 and IP_PMTUDISC_PROBE.

Fixes: daba287b299e ("ipv4: fix DO and PROBE pmtu mode regarding local fragmentation with UFO/CORK")
Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Assisted-by: Claude:claude-sonnet-4.6
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
 net/ipv4/ip_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 74e095b6b7ca..a24cc8ee11d3 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1303,6 +1303,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 
 	cork->fragsize = ip_sk_use_pmtu(sk) ?
 			 dst4_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+	cork->fragsize = min(cork->fragsize, IP_MAX_MTU);
 
 	if (!inetdev_valid_mtu(cork->fragsize))
 		return -ENETUNREACH;
-- 
2.55.0

