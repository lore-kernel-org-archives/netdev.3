Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280344A3FD
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292676; cv=none; b=MdkkeULz3FcPaBRQfxqAmeAVLKn2mm9B9MtyYE9aaSar2gUjIxwgRjRDirGZchsDeb1F836FIUDz1SQjwA064Zcy5jX5oVAf6Z+Y8yh7kXJ/JO82YnW/dkcjZ38u9v//IBAn6POuorCjpQFiK8BoEkihH/Y94Tzcr0J1Uxhf07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292676; c=relaxed/simple;
	bh=/YZKVYk/L6dyruLdxfl7WIXz33gjUDcSeoPRd9IwmHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRfCtMfjTfrgQKvEkPhdjF2lQOkUiQvz+g6u67278Q6yohu6Ph1rYJi6SpmDotIzAg/RPbhKwPdKjb76KyjnjR/rXhiMwYOsC0Cct3rt+ngOBRfJ5u5bWtrvbhkoDnqmGjklTPw80Tsqud0zyNVSPMFYJuJSFKCxNv6U+wgCKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Yf/LCaQ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXAS3I3F; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Yf/LCaQ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXAS3I3F"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 879FA1D00031;
	Tue,  1 Sep 2026 15:57:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 15:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1788292673; x=
	1788379073; bh=SiCj95U5huzbKKQRE4iCRqDxTe2vaNO9s6DJBSD0N5I=; b=Y
	f/LCaQ9Xxr7stNBtjPX2TxKM2HpM2Da3DI/FZsJdJw041PcfamV6udlmaukXDWWo
	T0+x2ui2qR/0f+Ac5x/kOJvD8W37vWPX+Edc2fK9qvxIHOvKOvAHqy8DjCPVxCdz
	beP/JrYEdRaAZ3T4oBNsB3AbPpUI7pKq4Fgp2m9UUCsTLxX23ZZ6zemVxNcVu++G
	/bg88Fo5Wu0hs/byduVa+36nW5mI1tMYrX0UnHSsJOvL2fHXXRW4c6FGYwP7G054
	AjbnOWH4wEsveKysrnY3pYedD84DDGpsn0LsLWrSf22SNsQZwzJFcDFPC0SlpCnW
	DWq4jVbqpe+CA/25xypEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788292673; x=1788379073; bh=S
	iCj95U5huzbKKQRE4iCRqDxTe2vaNO9s6DJBSD0N5I=; b=YXAS3I3FYRoEYA33/
	gTS7wmniJkejB4palbCMnKjTRJwbzst+/IWjm6NyFLRNTH5f/ITsG8CV7jxg7aul
	9fzJoxXcfYMZGVAwXPchDZG2ZltYa5Is2kVnuD8sS/D3gWKzWA4GpZ88JI04SqPy
	ahTSDAZfXv3mU0iSsfmYtB9B7UfPzoftYWVNwTQn5vz+6S3Jo5TKy5StZ2DN8qOT
	DUhPXy29OPvNAnqNsjinfpRejqtoNgaLn9AO/muT08xKG0XeP2aO3It5T/ule24P
	JisuJwTSrPCrv/o7D54gqBRfbS0NELBg4PGXg+2+rv4VA5c7GcCdl9R8o+WrgG9g
	nM9Yw==
X-ME-Sender: <xms:QS6Xam4Q8BJetOew-OJ6wp-Lvi8rJE3gXLGxQLW3zBxpewTuyme0Hw>
    <xme:QS6XaqTnls-Pu19Po1aUp5fZ2DBs5yLFq1G3ynhVEP2lrOJGopvkZYLyJ-FsvA_Fv
    dsZnxmsGRCG35OZbRwUYXjklBnUTl7ow46_qxtN47fGVrTSMm2CyQ>
X-ME-Received: <xmr:QS6XarmYVGeOf7bBzpVzSOnPLSsDsV1pyPdSaDtGAEYWETduAj26Ewyfng6gpSLqc-yORu_dFJtZUyuuTsavjPM>
X-ME-Proxy-Cause: dmFkZTGKERgzTLwHMclbJZzTkB5b9OqbLI5gd45Jp0QKvpxX/PDi7lz5bXZcBbrhmzxB5g
    bowSi1xv+S351ubGhtKMXNMJRgJWrFSdnSHxIzTw4vnG2pN8l8Bll3qfHquYZ9qn4oLQVL
    F3vL7m/EB1vMDELvk9pfYiB5iSfCVG/kv6WecTaKFqbdcUC0BF+SAAkKgVg66R3YbrnGL9
    00Yxarb7ziNCTezrgbrUOjeV4WX0enamJ8uc36HucQMVKlkDBor7yqbSJAxeI6gpWUm9pL
    cdk8ZxbZIT/SQjUHY1rtlPX+j53s7AxzOR99/kUZ8I3iYM3H0larM8s88fzgZMtaG46zVM
    Q7ByQ5ecWX3zvbisP7UPf9bTgVtbaYhzZmw3nplEYQrXmYKX3B4QcFqbPdKWLKAej2lBnh
    7A/PAHDXEdM9+DNTqlPXgI+q5Y0jtbvZ7Gs/VNV92ibklKT5voN8mG773Hxk+8hwCYkAA/
    AHCmjxTfWumUMnZekNOj7pfIxubKUbmLGEbQGe7fL8xjDh6XWXnOIHLzShiE4uyc8KiCHc
    qiiTyTjqxs2EN4SXejTg4hSTkSqtpucmSS2qqDI//y8uKi3+dPg4CSwm/gASYoqFW4Otpj
    I7+BIoriDOl001X3CdN/eQEYjxkzG3qtMORHTGkR+UEm50oJdrBtifkVliEQ
X-ME-Proxy: <xmx:QS6XauRgLlQmYQDR2Xqyc9m0aFdqctZmXv5wwAbu9yl3n9zEisoHmQ>
    <xmx:QS6XaiseJyGncTsMf7brcuFy6wlyoDHeQDI7Gh_u3t87NXnw59EK3Q>
    <xmx:QS6Xan7tEJBnPitI4wEYZNQnl4I-L-XKQjJ2nx3uaicv6IEpNhB0aA>
    <xmx:QS6XatjCnyHShpSe3PkftpNic_kUt6_ykqncGt2Fqr7XIV85vznjaQ>
    <xmx:QS6Xaj8Xe1Q417yf9CmnwBZF_r0RtmgYyq8ZVgtfJLuUDeovuEmniuhB>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 15:57:52 -0400 (EDT)
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
Subject: [PATCH net v5 1/4] net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
Date: Tue,  1 Sep 2026 22:57:11 +0300
Message-ID: <20260901195714.673548-2-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901195714.673548-1-alice.kernel@fastmail.im>
References: <20260901195714.673548-1-alice.kernel@fastmail.im>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
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

