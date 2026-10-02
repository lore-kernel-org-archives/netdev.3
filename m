Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD84448388
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976389; cv=none; b=FVnFaGplcpc9Oeg6nqiCvCucLKcyuJvdcTa6Z7osQSRECbylHRsIO+LLT5uMy+H2rGUBgu/ZyRPwV47HP5P1SE6waenVFKpuSG/Gh/zwFYPtBmqjLhgOMNPd3cvTQ1UXBuMU+oRwV/zsiFLVQgvLUAbU2qppzWwgUZHVUU+tQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976389; c=relaxed/simple;
	bh=SkBEWpTSogqbSaw0UuqFwkVg9IiaRtWY3W7agnFxLfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDDfFqIWBY1eeEzNV/OaFIh4LuCGFvQskB6gcsm1r4a373flSNoCE0bF7T4fPX+B6a454G4jsZsPah0XfkNKNuXoEKJW5LRZeQW150sxxs2HZRwPmkK3GT8cKIzjG+37vIHb/0vFyryC9Jwoy8/K7LfRuLmHBb2RdtkfcyWrT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=Z1VaUxqG; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="Z1VaUxqG"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b00a0ac65so183976f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790976386; x=1791581186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=prCKrXxOjSoMWYxgstd/oS+K3M5uCiaV+ENlE4JoYxU=;
        b=Z1VaUxqGm0Ywrg1AXzw2VCJu8UlPZeAsML99TBFWqDdP31ji1sDhH4zUCQIUfL98rJ
         TdHjvYwxbenAt/D4DzkEgEYCgZ15KpVgT7GKwAhSLaAJYI0dWlAv9l1GwUvg3bSI9qGL
         qQpmDJltqJzv8cYdf9XpGWXwxtM4RobqRPnnl0LkIoaAkRUKsoE7TMhwkV1/3K5jcusb
         GSRXIkd17OZGIBlMT9OPe/7cx+GcKVoTZyJNg5sy+wpjHfD2pWPKIhVD3gloyqpMnMTS
         sMQRHYkJT2JPwrfiQDSpZpqTfWuHTO1wnOtzpap75aCCxn1+XsE5dw2ycRCoGOqL4mSW
         bj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790976386; x=1791581186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=prCKrXxOjSoMWYxgstd/oS+K3M5uCiaV+ENlE4JoYxU=;
        b=cAm4EY8qQoKkipkMKNtVqk75wmbByp3pxajKNFJJYDvjDMjwcCpV3hq1DQkWfnI7La
         yiQ3tSrkR+ml69S3lk732O3JDf2kgLjrWGoUQ6+EGE+7AGm710WxF9eyF7sTaaPPdws/
         HWtJDsd0SPAQQ9ielbm2Aqu1MCnh10Fjq90NdiXPr1MnN/IQrj2ZlhCCEWqvNChLsujY
         IUulQjgPGuQEWQIT8Pq6llfDF2cszpE9Fzxpa26bO1ao85cLgxsEZ41jwq1vScBaWHbs
         jgXxLeQl+E4/QeJXcDpweOi/HUWVvIBb/7uW/0cUYYAA2s2oEsv4n6reX6177se4UpPV
         im1g==
X-Forwarded-Encrypted: i=1; AKwUvBz1CYjAqaTJuar7L6SegxN42Q1cSKh4+d5W+g8jTU0wSYXom+NAnJ64fVbXFxs1X1rseXglt7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzkXaOH2/97cGVhuzPn0fx6g2CnP1GjeenTF3oDkhDaHslotuQ
	TtTln+1KdOUD5sym5jKr+urdbytOiq0AjqC1tru+mu3u5wVWzxxnm2KsQlvSZR2hh+Y=
X-Gm-Gg: AYBFou0r13AUGfwAbSSVISCQH2e30O7W7aMW0UIjvC1oLAUsCtFuXcCMojRJVSdQzBC
	AZZn2Hjuwy9GCfAibvBke5z/Yir05oF1dzbVOsLj7bvL3t50d7zigW+RH7tYvXFMhEX0BeKcsRR
	HUBdE0aRoJQKzi1PqoDEis/IstpznE+bnwyi3k4WAHbyBw61rf9pPc6HxwOvLkCD182iJSi/uOu
	OuhfD3j0R2zRlipLKg/i5Okl2h5SorlT8hrF9vWHOQ3YHmdyI+ml5ph7KKR5nlHGugPLQsSHwrn
	ycgGsTDqZlhzjzo6Le0lELTexqMHV7wYuLhKOccdY6WxPkeisj80tgAqTWpZobDkstbzILJoHqI
	rL1uTGU+/gR3PBphk6ib7YxCIOZI++g1rxEfH3c2FnTRUx/evY/LM9Q9xwSEI6ZvIUcKDlW9cyQ
	Sj67EBsCh3YV0KGD74qf8VsvyQ6iFASMr0ozyjePzNuqVjM1sDLVCoyB4zBX6jq7bp90Y3ScYTe
	Awaxdygi2W6hsSwAk3cQFWajYuhl6cbpuhIFGeIJ/boBopuN35TC/u4u7bCXWVUr3hIYazZF7CK
	CQ==
X-Received: by 2002:a05:6000:46cf:b0:48b:ff5:d297 with SMTP id ffacd0b85a97d-48b12741723mr4903984f8f.25.1790976386011;
        Fri, 02 Oct 2026 14:26:26 -0700 (PDT)
Received: from localhost.localdomain ([197.51.72.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253ae9sm7183149f8f.2.2026.10.02.14.26.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 14:26:25 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next v2 1/2] amt: mark relay data as a UDP tunnel packet before sending it
Date: Sat,  3 Oct 2026 00:24:57 +0300
Message-ID: <20261002212458.34247-2-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261002212458.34247-1-omar@blockcast.net>
References: <20261002212458.34247-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_send_multicast_data() encapsulates the multicast packet in
AMT + UDP + IP headers, but unlike other UDP tunnels it never calls
udp_tunnel_handle_offloads().

If tx checksum offload is enabled on the amt device (off by default),
GSO packets (e.g. from a UDP_SEGMENT sender) reach amt_dev_xmit()
unsegmented. They are then sent with neither skb->encapsulation nor
SKB_GSO_UDP_TUNNEL_CSUM set, and the lower device drops them:
__udp_gso_segment() fails because csum_start does not match the
(outer) transport header.

Call udp_tunnel_handle_offloads(skb, true), as other UDP tunnels do.
udp_csum is true because udp_tunnel_xmit_skb() is called with
nocheck == false.

Also reset the mac header of the copy before recording the inner
headers. amt_dev_xmit() pulled the Ethernet header without moving
mac_header, so inner_mac_header would point 14 bytes before the
inner IP header. That makes tnl_hlen negative in
__skb_udp_tunnel_segment().

Suggested-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---

Notes (v2):
    Found by an LLM-assisted review of drivers/net/amt.c. Reproduced with
    the selftest in patch 2 (x86_64 KVM guest, CONFIG_DEBUG_NET=y), tx
    offload on, UDP_SEGMENT bursts of 8 x 1200 + 100 bytes, IPv4 and IPv6
    inner traffic, 40 runs per kernel on net-next eb0c18404c89 and 20 with
    this version of the selftest on 071876fd5048:
    
     - before: 0 of 900 datagrams delivered and tx_dropped +100 on the
       relay's egress device, in every case
     - after: 900 of 900 delivered, no drops and no UDP checksum errors at
       the gateway, in every case
     - with only the skb_reset_mac_header() call removed (two runs, an
       earlier version of the selftest), the packets are still dropped and
       DEBUG_NET warns in skb_udp_tunnel_segment()
     - tx offload off, and non-GSO datagrams with it on, work before and
       after; amt.sh passes with the patch
    
    Not tested here: hardware UDP tunnel segmentation offload, hardware
    checksumming of a non-GSO CHECKSUM_PARTIAL packet (it now leaves amt
    with skb->encapsulation set, as with other UDP tunnels; the selftest's
    egress device has tx offload off), a forwarded GRO packet as the GSO
    source, KASAN (the netdev CI's debug kernel ran v1), sparse, udp_csum ==
    false, and amt.sh on the unpatched kernel.

 drivers/net/amt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 0277e4c..a8236d4 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1078,7 +1078,17 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 	if (!skb)
 		return;
 
+	/* amt_dev_xmit() pulled the Ethernet header without moving the mac
+	 * header. The tunnelled payload has no link-layer header, so the
+	 * inner mac header must coincide with the inner IP header.
+	 */
+	skb_reset_mac_header(skb);
 	skb_reset_inner_headers(skb);
+	if (udp_tunnel_handle_offloads(skb, true)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	memset(&fl4, 0, sizeof(struct flowi4));
 	fl4.flowi4_oif         = amt->stream_dev->ifindex;
 	fl4.daddr              = tunnel->ip4;
-- 
2.50.1 (Apple Git-155)

