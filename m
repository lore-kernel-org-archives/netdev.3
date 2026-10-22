Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660954;
	b=K3qHa3A6UVtevKpOpsX+OjfMmxQrsla2lWmux6bzER+onkW4RF1Y8HfOtx0Ne8AZakMD
	 lyw0h4n4sLT9PkTNzpwMYWrK3RKYoTpc5ZbTHqfGa9/6ZO44Gvn5fT/M3xBTzcF8DsjPA
	 g4JgTJ5AQ9rehqX0AdhBTqxOHkFC7MwjxYwj/w0Rvty4B7ODCEPW0rTvwdNVn4KWHKjDa
	 YTIumdnDwg1Q5OXz2TwwTBnKa+R1lKtnZfjhk42RAMAqH8DsKoikQb1b2HnDdiMxHc/0U
	 oDGyDoE0xu3yRclisys4H+H/fy6enuuyNG8uJIEkqQAaQnqAPm2u8mpoIWm9sDIL0UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KHrjGIKj3LtSYhmTNTSDNKH4bA+fqymxMTnF7ZRbzBM=;
	b=33j5SzHZJN/w8Rjr6RTyLbNhpe/bWpo5msC1PeyI4J9iV0QYJS1N8Sdj+NrNfufxYaDc
	 0tdfPGRrPqogHDMicD1aRdtOBrjWXVFUNf75jSdOJtrQzl3EZz+lddvpPurd2hWMXXjoo
	 zhNyt14W2VhhzS+USnf/91OG26lqIiSLYzHln2V+bwqmq9Z/DyS59QBLjByeXXx7RovZ5
	 tAYiB5+kjdVkRTm8MAyOkobjFhQ4Fx7P4r0Wh9FvncFwfHxNNzWpunRgXpdTUYPRvzc+U
	 ERE3LEQnWPk5qcnLlpY84a6wEHlUaQsFHdUIdH5d/EPrVHJ09UuoIxf6tnb6e3DD+Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wLkHg8e1;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782F606A328
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A782F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=wLkHg8e1
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-917b78dfe30so23231436d6.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660953; x=1793265753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHrjGIKj3LtSYhmTNTSDNKH4bA+fqymxMTnF7ZRbzBM=;
        b=wLkHg8e1uDIj3B6f48nDMwfgxTRSqVRBZ2aJS52EMJ3sCjo+Mk1+qz8N9C+ifyz4/E
         yguykozGkdr22K8IeyHzX0/kjVAA4LXOowbF8x42g4iMTWCQyEn5TUkkuTiupR3H6x71
         RFohGwA4pYV4a4ALbnwwZS8Hxg0EGLpS5nCaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660953; x=1793265753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KHrjGIKj3LtSYhmTNTSDNKH4bA+fqymxMTnF7ZRbzBM=;
        b=h/RXJk4vJFCp4ZGebEFyajX4WtrGAEWJA95p+ywEl7FycInrxkduIunjzBHfsQz9BX
         +MT5oJ9wa0Ky7qvthv5uU+I+r+ZhQjTXfZQRgxqSsKjgnf62ir6WErmPxVVa1gFwcgXs
         b/VNJkRH2PeVuHAZCFtkZi1EdeoKQ3zHOrb7gjru492q5+GydOzkRkPQJlaclg3r3sgb
         y5yYWwO45EblEDP5lfRlqFx72TdgApIRFdkKqllVV82D7A9ljNogBMbzjz+oeWY7wdDj
         qtUpnKed9RQjXSg9kwah52gRbYgNH/d8mUSstiaUcTKwZA5JrIi40wJ1rXNNstwO7Iud
         aJCw==
X-Gm-Message-State: AFq9FYKJJhRVUy4vJM+gNnT5fAzbAaAOTm798Fp/FkFRjq8EXkPvub5j
	Jjqvj2YOus5fmTro7X1R9ZEzVTFCQYmWNXtA0qHcb29EnpUpnLVmQMTjVpLYz1KcxnTY1isi1Pl
	CFtI=
X-Gm-Gg: AYBFou1FX+tK8I0/9q2+NFgWbCaqHsCaeEZbuomIgBxmf6B3WOcT/gLTaf4cqOVdPGx
	08pO3V0s43oOmdLSO1Sz3aYfRy8kGFjYF6iKknEPd7oNJTXjbrxGw2VuAlppVKO8pF30Ali+Tux
	78UIdCvuvQLs3/kjVvov2MYBIGZJ357i96OmeJOGslGSPeVMCC3EuTkD5Mds1/rd97C4MZWS1Ij
	SyiZ2AWYDaQOJTiHiASxIxHaS7iaB4I1xPIW0Q9tCV6joVOw/B5SPOz+RnoSHYx0HpImHIYFS88
	IFdU7agOSheMk2dRm6q33E7lnjnQ/cynCtl/R5OES9tqXgdaX7MXV7msfEkm2ts1epoff+0gU/w
	mp1NX2m4BtoFuqey6sc4e6XIgSK2dFT+y65KK95QJXxfMMlkqGSVHU2DXVA63mTJWKSfxxRUQIU
	YyvjpQ9Gd1yBzBEvIYurQi1i2wGM/7LF7spQWE03U5sFtcPIJj0wowc2+8A/dhnSCZVt3T2RB8U
	mZHiwO8ORea1De/HqTYOTKcGPlg0iKazQBu9Fjixiion5Xh/La6PVvXoblMHSR5V/kLLEKIeswM
	wx3MSAIZg5xZUqSxog52tBDw7LIa4aoW56cSMd7VZGsCSkQ=
X-Received: by 2002:a05:620a:438c:b0:93e:5cf8:e5aa with SMTP id af79cd13be357-93f57f7fea9mr895797885a.61.1792660952636;
        Thu, 22 Oct 2026 02:22:32 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:32 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/5] net: tun: keep TUN short linear copy hints safe
Date: Thu, 22 Oct 2026 05:22:20 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
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

The issue:
A TUN skb can be redirected by tc mirred to an Ethernet xmit path, which
calls eth_type_trans() and needs a full Ethernet header in the linear
area.  tun_get_user() currently validates len and the GSO header length
only for IFF_TAP, so an IFF_TUN | IFF_VNET_HDR packet can set hdr_len to
1..13 and leave fewer than ETH_HLEN linear bytes.  The redirected packet
then BUGs in eth_type_trans().

The Fix:
Reject packets shorter than ETH_HLEN in both modes.  For IFF_TUN, where
hdr_len is only an allocation/copy hint when GSO and checksum offload are
off, raise a short nonzero hdr_len to ETH_HLEN instead of rejecting the
write.  Keep the TAP rejection and its NET_IP_ALIGN adjustment unchanged.
This preserves valid no-offload TUN writes with hints below ETH_HLEN while
guaranteeing at least ETH_HLEN linear bytes for the redirected consumer.

The maximum receive headroom advertised through tun_set_headroom() must
reserve the same linear minimum.  A large upper-device needed_headroom
(for example an L2 netkit port behind a VLAN in an OVS datapath) otherwise
caps good_linear below ETH_HLEN and defeats the clamp.  Reserve ETH_HLEN
for TUN; the TAP branch already reserves ETH_HLEN + NET_IP_ALIGN.

Conditions to recreate the bug (repro available):
- create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
- attach ingress mirred egress redirect dev lo;
- write a virtio_net_hdr with hdr_len=1 and an 8192-byte payload.
Unfixed kernel will panic in eth_type_trans via loopback_xmit.
In a fixed kernel the write is accepted with hdr_len clamped to ETH_HLEN and the
packet is forwarded without a BUG.
- no-offload acceptance: a separate check writes a 28-byte IPv4/UDP-shaped
  packet with hdr_len 0, 1, 13, 14 and 20; all writes are accepted.
- high headroom: create an L2 netkit pair with headroom 4096, put a VLAN
  over it, and add both the VLAN and the TUN to one OVS datapath so the
  TUN receive headroom is raised to 4100.  The same hdr_len=1 jumbo must
  keep at least ETH_HLEN linear bytes; without the setter reservation it
  still BUGs.

Fixes: f42157cb568c ("tun: fallback if skb_alloc() fails on big packets")
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 drivers/net/tun.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd07..1e235c2f0aee 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1193,7 +1193,7 @@ static void tun_set_headroom(struct net_device *dev, int new_hr)
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
 		max_headroom -= ETH_HLEN + NET_IP_ALIGN;
 	else
-		max_headroom -= 1;
+		max_headroom -= ETH_HLEN;
 
 	tun->align = clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
 }
@@ -1830,6 +1830,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		align += NET_IP_ALIGN;
 		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
+	} else {
+		if (unlikely(len < ETH_HLEN))
+			return -EINVAL;
+		if (hdr_len)
+			hdr_len = max_t(int, hdr_len, ETH_HLEN);
 	}
 
 	good_linear = SKB_MAX_HEAD(align);
-- 
2.43.0

