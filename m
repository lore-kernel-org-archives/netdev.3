Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21045392828
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792238709; cv=none; b=BclIndKBFKBxoIgtbQr2UpfDQbu0OYdjXHzqlz2ThoqN+lLTO3fglInN8RdbifRYlmShLn5vwm7Q9DQG+oqg+YeaSFpSrjrQqHc+3fMFsySqMIepI/v/VHq15+2JdulW+ewz/2T5V+Vwarb3wAUgyHyeRZIJKNMycsANDWwEP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792238709; c=relaxed/simple;
	bh=Uhqf6kEDaVk5sdN1pEgcxFC260gFONWp77GIpmEdMVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDsddEEAH26wf+n0q6KTAUj5Gi/aiAdzJQ35xOLCgN4BdxWgJdrTRDjeDmaRgTevY8fOJxEDdpUafb/MqYKYZyO7szatJur+AGMCG3GK+CW7FeFRpOGgRJ2B4nhCLQxv1OySLBOnvjjXGzldwjmfsOezHuQpk4BssaizdFyiDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyYOGloR; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyYOGloR"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3ac92391681so181614a91.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792238707; x=1792843507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=shPj0JpAvHjJzhITuPzL8gL8dV599qsdcXL+y8yPBvI=;
        b=WyYOGloRwlCMpBDiWpb5Qd86Y8koRZg67hGD3zmnd/L3BIeH783bcI9gq/4b4KMnOc
         4LuuJ7d5htJPh+1XVuLf4sbfFBgn6tKydOfY0EPu/pRALdhK/3L8DqtEhf/Iks0atNt2
         Ub152fpwtoG6JbBMT/KuEqsgu22TbFFFjhF4H8UVFVeJIGrhj7MKjlNRVe4OmsglDZJ2
         kpgg8bVuTmq7MHn0G/mKAXVq6agfSvNWrxJrWfnOs//csMKHUI/DSkoAGxlsjWdFxdKY
         x7DnkC37chLX4JtvBqNmSTYw7A/DRlb8L/1IUzcHjtfIm4cCCj7CCj9YTQAIEF/N0BmT
         Hkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792238707; x=1792843507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shPj0JpAvHjJzhITuPzL8gL8dV599qsdcXL+y8yPBvI=;
        b=o7tqxu0FyKNvughLSptkrX+GZ6FbgPEatUHblbWseP9l+rC5Ta7PX8IR6K0tsiy9rr
         bqPIQ+h4ot6SEf2gFuq9ZzFH0ImjI34CKdlCGx9tkhaDFS9czCQIqphnY+dxgyGDrVWG
         /qQqyBShtVA8VfmivxHhhEJkaDysHK0jueG4ySMnPSQ1/W4xRdAQMDd7nD3KdZkIOkcZ
         5jWzBnHsOw1PiuG0YxTGc5iHweKGvYP0avkITlhIgOfHV6yY3ylEgrQdWVF4sSI8W5+n
         SZAErALnIOLaT51PbxWgR7bO8Mp1MlcRDOu4WauvvL4M6GMQ//pBDDFDY81luUVhJ67g
         Ef5g==
X-Gm-Message-State: AFq9FYIAQg8DVe2sRCu7BFxNLpKh3cObHUdWaGUMaBERgSBtHTXW9mqG
	GEMchHtVCBG2IyV3HtgpbiAELoyJMt8uUsJNhJcocnDq3jY2uZKGuoRa
X-Gm-Gg: AYBFou3FRIOD4fW2IqKgwDhoe0BBIBKz6Fc8wHbTOiBFUwI28L9lemeCg4fUjA9IZpC
	80lPddO2SnNEJrv/3UrgMqYqtEhqg2xusjmW8TZ/Zv0mVrCqaMf599cpJOyyN6zhIGdDQl2muue
	zmGQ6AQI43hyR87Gd87P2/UfklKmdjxs0BW9Vp39tYJy7K0NVj7Ro+xT2kDVDTXAw8JNWaalfPe
	OMkZDsh0tORugAU9qZpEfdr0ITOCWvn0ojp8qqOpTAu7NT2qCT4gz3JOUdKqgBlBhmUC/uZczXR
	P/qMX8ASKworS6Yl2Ekj7TQrqX9FrIyJKsFQE66ezmWcPy7QKfy3+FlAoaBsjFJuNqkBckoW837
	UMCSC42qRBikuviQf2ydY94DgKpg1FzScn0EcMf+Nhs//3KmC/GXjQsUWVgH+5B8fF9K2vnDx/D
	2d1P0FCllitOtwtZUJ+Ena2IU1DSmiwt2PnC9mQaj1Ijrfnirj4QLbpGt1yDvK11qMuINjp+xsK
	IjnNDk2ZCW2IONUWWBa
X-Received: by 2002:a17:90a:c110:b0:3ab:f38:2b43 with SMTP id 98e67ed59e1d1-3aceeeabd7dmr1791948a91.34.1792238707370;
        Sat, 17 Oct 2026 05:05:07 -0700 (PDT)
Received: from LAPTOP-QJLDGQ2L.localdomain ([112.224.225.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f4cadsm7815593a91.12.2026.10.17.05.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:05:06 -0700 (PDT)
From: Boyan Liu <yymhvert@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+98d7de09cd94fec5@bugs.sh
Subject: [PATCH net v2] seg6: Fix unset mac header in SRv6 End.DT VRF decapsulation
Date: Sat, 17 Oct 2026 20:01:44 +0800
Message-ID: <20261017120144.3059-1-yymhvert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SRv6 End.DT4/End.DT6 VRF decapsulation unsets the mac header in
end_dt_vrf_rcv() so that the VRF device can rebuild it for packet
sniffers. The VRF rx handler only performs the rebuild when a
sniffer is actually attached to the VRF device (ptype_all
non-empty); otherwise the packet continues up the stack with
mac_header == 0xffff.

Every other receive path delivers packets with a valid mac header:
NIC drivers set it in eth_type_trans(), and tunnels without an L2
header (ipip, sit, gre, tun) reset it to the network header after
decapsulation. skb_mac_header() even warns on the unset state with
DEBUG_NET_WARN_ON_ONCE().

If the decapsulated packet is an unexpected UDP GSO packet,
udp_queue_rcv_skb() re-segments it after restoring skb->data to the
mac header with __skb_push(skb, -skb_mac_offset(skb)). With the mac
header unset, skb_mac_offset() returns a large positive value,
which the unsigned __skb_push() argument turns into a huge length:
skb->data moves far outside the buffer and skb->len is corrupted,
so segmentation reads out of bounds:

    BUG: KASAN: slab-out-of-bounds in inet_gso_segment (net/ipv4/af_inet.c:1383)
    Read of size 1 at addr ffff88800da7ffff by task exploit/149
    Call Trace:
     inet_gso_segment (net/ipv4/af_inet.c:1383)
     skb_mac_gso_segment (net/core/gso.c:53)
     __skb_gso_segment (net/core/gso.c:124)
     udp_queue_rcv_skb (net/ipv4/udp.c:2476 net/ipv4/udp.c:2466)
     udp_unicast_rcv_skb (net/ipv4/udp.c:2620)
     ip_local_deliver (net/ipv4/ip_input.c:262)
     seg6_local_input_core (net/ipv6/seg6_local.c:1640)
     lwtunnel_input (net/core/lwtunnel.c:465)
     ipv6_rcv (net/ipv6/ip6_input.c:351)

Restore a valid mac header, pointing at the network header, once
the VRF rx handler returns. The sniffer rebuild happens inside the
handler while the header is still unset, so tap behavior is
unchanged; when no rebuild happened, the packet now carries the
same mac header state as any packet received on an L3 device.

Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
Cc: stable@vger.kernel.org
Reported-by: co+98d7de09cd94fec5@bugs.sh
Signed-off-by: Boyan Liu <yymhvert@gmail.com>
---
v2:
- Move the fix from the UDP GSO path to seg6local.
- Restore the mac header after the VRF rx handler returns, preserving
  the VRF sniffer behavior.
- Verify the original reproducer, datagram delivery, and VRF sniffer
  output under QEMU.
v1: https://lore.kernel.org/netdev/20261010073015.7665-1-yymhvert@gmail.com/

 net/ipv6/seg6_local.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 7b5212220185..5232c9e2b7d7 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1113,6 +1113,14 @@ static struct sk_buff *end_dt_vrf_rcv(struct sk_buff *skb, u16 family,
 		/* the skb buffer was consumed by the handler */
 		return NULL;
 
+	/* the VRF device had its chance to rebuild the mac header for
+	 * sniffers; restore a valid one pointing at the network header,
+	 * like any L3 device without an L2 header, before the packet
+	 * continues up the stack.
+	 */
+	if (!skb_mac_header_was_set(skb))
+		skb_reset_mac_header(skb);
+
 	/* when a packet is received by a VRF or by one of its slaves, the
 	 * master device reference is set into the skb.
 	 */
-- 
2.43.0

