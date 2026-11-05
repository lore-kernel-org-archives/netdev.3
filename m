Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909603;
	b=Yd708FV4qZd2Kxd+ng3msRc10RpB+yc6lsFmO5VK+a3SVN48a+wgpGjSJ9jRNN8H641l
	 nUlCoMrBjg1JzI+lYv5uo5/GhKvLr5yQvqj474g7RtMmZTIG7A23pvWtOl9sbPPvT5FeR
	 AHI0VWzeT9qFGHNn21Ptnh9qAQtxspdp2QqsznK21NfBtMXZZ/1Xe2F2qLp7tjS74n2Na
	 Yrd2pQixUbEnGyAQ07XRPC0P1nemxwJzOMeBe6Be4Y2w8iqiML653WF+YScAPqjgDQcYC
	 LF+qsMew/y7UuR62gThXeP8aoA/ZsfXEtapfaZlwGCrWagxdPcf4A/594as+EQCN+2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yVXIU0tINtNyRykkZu1Es+JOorB8e6iDSm9KoMw2Dks=;
	b=clJJ597eD2CbYDZev7zd6lR6qSy9XnQbxCuM/NBiMCuBDqu+6OfxDstU779qRrShQPgY
	 pbBD1VH1qDljc7sk8qyIBXY5nJ1EeCaA2wGfym91XmIDRYRcU7tJ1XH3yDygJxXtgjJc5
	 TKkW6q1/fwqltbOvc6e2sFqoMnnI2nvjA393aOUXut+kP0Q9WaHhkgpusuCITE2cmhHEq
	 x1VaKLI1MoX2UH8x38GfAtOHVpcSIuCyNWrolYGW1BnIU/zGxqUeeELDXdR3joKw+mN8+
	 JlQuPgzpj4yO9ZQxVHcTrRm7N9gpg/FtZFCZSpxDnp2UwidM6W30pmFAwFBb8PRVONw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGL7QiNh;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17084606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17084606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGL7QiNh
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535a54bed9so3061134eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909602; x=1794514402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVXIU0tINtNyRykkZu1Es+JOorB8e6iDSm9KoMw2Dks=;
        b=nGL7QiNhOOT36bJGQ9yRP8GnCb+g6VkzTUkHZ/AYcnt5Es6fxhxwhLnY2AzUdBNx/+
         e4Wm+IWhhQrWZ6V/wX3Z9so98xDzz+xW6pC9L/BP7xYtHxgXaD7jG3/x1fpyVhnJLbBc
         zI9G5FsZZ/CjXpCRaQB9U7ueSGxT24g7v5bI+g0KWx+w3jUkVEPJToJNkF1GlS8CvN8u
         84MAr/9uSCxzlBn4kmuA/sYZYR//QdKRJ45qDfASFb6we5DvA6uqBvvIzs7QCGDo2zsA
         HDwyAM1YrHRPfeEybqphPLUnJ/oq2m/HN/SrivF7L/KVnMbVQspm9mIIw5rbZA/TXUdB
         s/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909602; x=1794514402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVXIU0tINtNyRykkZu1Es+JOorB8e6iDSm9KoMw2Dks=;
        b=K6qEbziASKWvK0/396wIQ+lcedINvHvIxOS7GbJ4kHg9/IOZgfarHTInUPNxpLS9Pn
         cYlSHjKX6fPhzdQ/lq40XsVzRcy/VFDQk5ef0/IHAtd93K4JS1Sa+gyoE2VT269yvnJm
         o4tKnLGGG/TTB4H0VMJY5MbTiEahbYBka9Q3IdoD5GR3SbO5V4uiWzgW2V9c96B1ockN
         d4cA8+GqghgmMJWgUeAFKcrFPTHpZunPkjmbn616IUI6PCB77AgXu1CRVorWG++JvB0q
         Hx373TC3ZMcBOFFEtzcC6MNmu9Ng2WKNcmm4u0+WvmZVkfnpls1cwxfSKpbQXYCvhrry
         iogw==
X-Gm-Message-State: APuU4Z8zxpmdHcxsfl/eJaSJ+6RgY9AcbgB0QUGmhOO9uY2r6H/M9Ikk
	pim9ocOiuMpCR4zvZqNoZO23iJCKURn00qbHG4ZOFdEj1lpgPC4rrxNCw6z1FvoS
X-Gm-Gg: AYBFou1kXPY0XG2DWZLlypJg3v2hG+MEeFiwV9qkp3tmtNh0rP99jRw/dx4d4pIOD4T
	mJDrNUfqa85+nUsRXfVGX/Uq8GYpssFSp9A6GLgvm2uk/i1wSwEnVKLE7IKJ2w1cWPRqhfiLQa/
	WDKoHX05fnyYnMoJJTAvQEqLfF1tEJblq6nm/ri8ZIQeCxRaVpWyrmUEJIHm9Cy/WFd+xl/ECDB
	uOuwxUA1uKFzgh/Ney1xbM3suGndOOQHKsl60fKaCs6pQOpRT453QxEQrLYDucL04+aUQqP0jHb
	vuVnwJ/3YtJ0gAIHOVxKzqPiuMWDEcBTJPweZz7uaQoPFY7Gc1VUL6rKeJZ/8KN8T70Hfq1IQgI
	NrHcjCIDMI0D3pdGWQngKP0nKB8O8ev5dKsf856F+KSR6BD8Xz1Kcjg6mJWtYKYp285TO2Fsnwp
	J4EFgFO7Fc+SbksVsFDoMu3icM9lwaipX4EhrnSP5zkazqNrrcGe8JAnhCkw0i3eMAnWW1uqhCM
	huKSAh7hJ1VGc76CM5vLcgbhPFkQ0HjWCe2EerpHDpE1+Excyyc9vWBkH0LWo9cMHsPhlZlk24N
	17mew9yMcD8xJJ0qVvDszuYMXRRugg==
X-Received: by 2002:a05:693c:881b:10b0:351:1bdb:e3b7 with SMTP id 5a478bee46e88-36f75b2c6e8mr275702eec.15.1793909601973;
        Thu, 05 Nov 2026 12:13:21 -0800 (PST)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed312sm590869eec.19.2026.11.05.12.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:13:21 -0800 (PST)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Justin Iurman <justin.iurman@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next 1/4] ipv6: fix transport header of forwarded GSO packets
Date: Thu,  5 Nov 2026 15:13:06 -0500
Message-ID: <20261105201309.3182307-2-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105201309.3182307-1-tactii@gmail.com>
References: <20261105201309.3182307-1-tactii@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_rcv_core() sets transport_header just past the fixed IPv6 header,
and local input advances it over each extension header. Forwarding
skips that walk, so a GSO packet with a destination options or routing
header reaches ip6_forward() with transport_header at an extension
header. So does a packet forwarded again after the router processed its
routing header.

skb_gso_validate_network_len() then reads a bogus TCP header length. An
overestimate makes ip6_forward() answer with Packet Too Big at the
current MTU, and the flow stalls. Since commit 7fb4c1967011 ("net: pull
headers in qdisc_pkt_len_segs_init()"), a bogus doff below 5 also makes
__dev_queue_xmit() drop the packet as SKB_BAD_GSO.

Before the MTU check, set transport_header from csum_start for
CHECKSUM_PARTIAL packets without encapsulation. Otherwise, if the
packet has extension headers, skip them with ipv6_skip_exthdr().

Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
The Packet Too Big stall dates back to commit fe6cc55f3a9a ("net: ip,
ipv6: handle gso skbs in forwarding path").
---
 net/ipv6/ip6_output.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a..60ac56afbd06 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -662,6 +662,23 @@ int ip6_forward(struct sk_buff *skb)
 
 	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
 
+	if (skb_is_gso(skb)) {
+		if (skb->ip_summed == CHECKSUM_PARTIAL && !skb->encapsulation) {
+			skb_set_transport_header(skb,
+						 skb_checksum_start_offset(skb));
+		} else if (ipv6_ext_hdr(hdr->nexthdr)) {
+			u8 nexthdr = hdr->nexthdr;
+			__be16 frag_off;
+			int thoff;
+
+			thoff = ipv6_skip_exthdr(skb, skb_network_offset(skb) +
+						 sizeof(*hdr), &nexthdr,
+						 &frag_off);
+			if (thoff >= 0)
+				skb_set_transport_header(skb, thoff);
+		}
+	}
+
 	mtu = ip6_dst_mtu_maybe_forward(dst, true);
 	if (mtu < IPV6_MIN_MTU)
 		mtu = IPV6_MIN_MTU;
-- 
2.43.0

