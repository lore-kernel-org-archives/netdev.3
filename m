Received: from mail-pj2-f23.google.com (mail-pj2-f23.google.com [74.125.227.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB738D3E2
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853804; cv=none; b=uuBG8HT6fd0IO6LHvdnvjDMQFhrjCEQ/kRaf/njYHP/mwmSP2beqhd56sMePgQE8stwn6ZpGX6uxdMULOiVY4daj3NAQLAo/Wgrbk6k3k48Hjf+GfL37VWRoSccnFFsPZz4J+CmrnfBt7RhgEZbbFeoFrp0AzWCzPvjpHhPBplw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853804; c=relaxed/simple;
	bh=JzVmTdq3Q7Iq2TH3qdkMpYUeDuu0LJqEMcRNJCqtMFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYaeVVUOyUFtDvSJQsKOyf/s1tCZZpdS1G7JF2Cx+8mx5WlAmXDrScp7IP3Cts6+cJdBCLW39THspPfPhi53Ns4lYpMOgdIISS716QHanh0u0hfNTvLAzwyFegxDrIYXS8D9GCSBcXzjn/CFeL923YCeQ97A1MN79//snxJkyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSkGLWk9; arc=none smtp.client-ip=74.125.227.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSkGLWk9"
Received: by mail-pj2-f23.google.com with SMTP id d9443c01a7336-2d747f066d8so6558675ad.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853799; x=1790458599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lRiAGPXf/bDE6W3u+fknYqS6n6eKeAu3CAyIqYAtulg=;
        b=aSkGLWk93vpkFmPKP4eU5BGpqsr026Sz1L4HmhdQCM/eM4pQD+q5xWUZ5X+VGDsdHx
         fk+sXPrMbzKOHgzjUsiOnNeEBwWcJZ9zxo7W+jxoYwWlcvU/kU6HEOqPr0IIfdSlZsJy
         HlROJgXVKQTEzh+k3+By4yQ6/qFC9To3ehNs6o7firnZZhnWBUiUCCM2FF9Iw+GCY3Ro
         vgCYu/Vm/S/4DZvG5FtQwtmex/w7xK2EsoJ8NuWnO6dzjrBCfM1oIGly2q7cTdKvSdkU
         gKSGX780UkR2b5GR9xXuJJRrRCMTnd+Fey/bJOmO2pGjLdc4yt5OECDxJJFv4w/Wf3Lx
         QEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853799; x=1790458599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRiAGPXf/bDE6W3u+fknYqS6n6eKeAu3CAyIqYAtulg=;
        b=2myNQo6QYknger0j42rIsISBumFF2x97AWymA8fkOZ2iIIwZLR1oUxQobievsiE/1b
         O2DhV51CtBbd7AuA0qWR0lH3ztXo/xSmuFk2c6/MaqsoXRvTmN59nbljZBKXv/2XOXBZ
         Cq2sDBei5Y1rbod1D5OcvaZQOLJeYpWXQ+tfTeWDRqAtu9DzNNaw5gbI9F7LCT5xbdIJ
         JdrCUgJRaR7YVTJ3edNsvZ8pIdnBnmKUVCyNHptbM0vFp1rFjsdKsykEZxWMOrHQPqVm
         Z8VFU+AeuRq+BIhs38Xtx2nDPRr379+ensJ0DAEVJxVDx9ivEVIHd7ujrkcvudMVrgoD
         yHOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwK7csHlXQDbNRvbeJoQZITHRHu2yEr6VvmE7LnK/C0u5wt3ODj0f1NA2ohBe1A0VNrPSfXO4=@vger.kernel.org
X-Gm-Message-State: AFuF++li+QGs5EgHcUj+nsXW4jpvE0vBPe+wVGlCMm3SO02HQD8bupCO
	s5LTt3yMdafb3IcH18kDQ38/dsdMgOoVqRS072Z3H0W8fZWYyoyFskUv
X-Gm-Gg: AYBFou1N6lS94/EB2GWnNpVzg0vuz7Mtda6Y7KgoKHMxPPVIz0NdOqEY3+fUwc/xNQg
	RlVGZdeRd4/wqKhqHDghh6ekXi0hqxfvFDEF7OHaxLyaEWfd2EFI5+ucXSno/U3+TcspYIodWcd
	LPQ6nOHhmWfQMleYut/txZF5WlMIhu8CU8dqKDKd4wGk9FNUFVou4qghdUDUDHHVXT1JzfNtWOj
	Yugmetddifx3LR9zHGzoClC9i25zj2W/k0zQYW3cEdB8ubajqbkWrIRWn3GB1PgEriN6pC0GeFR
	Ck4Ar5QQZOfpEhQnikCUc1M+4dKAx7I9bNMjfYyLvn/HjQNTbdLo8ufeiIr6OdXnBVTOetkuQu6
	GUggfPj1mBEA7l/jReUgB3V2GhKVqW7TeXJoPZt2+m2/GOcV6WLfJ9h1krG20zhOSz8UGWfgZIP
	J0C5le+Jb1dVjOjoM5URHLK8pPjxU75ST5nYwoAA/irludQ42K+/U/ij4rDTIZwvGU4mG4LmKCE
	EDi78aRNQVNEosvLvIfs0ZgEtDgVD6g7ovvFN9n2j+/IJNZRIrI1+LN0jSmVGmGw+H/XhmetAi4
	/JfceOMM9Q==
X-Received: by 2002:a17:902:e946:b0:2dd:c100:2516 with SMTP id d9443c01a7336-2ddc1002577mr36107355ad.31.1789853799128;
        Sat, 19 Sep 2026 14:36:39 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1803813sm12928885ad.82.2026.09.19.14.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:38 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] 6lowpan: add missing pskb_may_pull() checks in IPHC and NHC compression
Date: Sat, 19 Sep 2026 21:36:38 +0000
Message-ID: <20260919213638.3314763-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `lowpan_header_compress()` (`net/6lowpan/iphc.c`) and
`lowpan_nhc_do_compression()` (`net/6lowpan/nhc.c`), the transmit
compression path reads `ipv6_hdr(skb)` (`sizeof(struct ipv6hdr)`) and
the next-header transport header (`nhc->nexthdrlen`, e.g.,
`sizeof(struct udphdr)`), and then calls `skb_pull(skb,
nhc->nexthdrlen)` and `skb_pull(skb, sizeof(struct ipv6hdr))` without
verifying via `pskb_may_pull()` that those headers are present in the
linear data area of `skb`.

When a short or non-linear `ETH_P_IPV6` frame is transmitted over a
6LoWPAN interface (for example, via `AF_PACKET`),
`lowpan_header_compress()` and `lowpan_nhc_do_compression()` read past
`skb_tail_pointer(skb)` and trigger `BUG_ON(skb->len < skb->data_len)`
in `skb_pull()`.

Check `pskb_may_pull(skb, sizeof(struct ipv6hdr))` in
`lowpan_header_compress()` and `pskb_may_pull(skb, sizeof(struct
ipv6hdr) + nhc->nexthdrlen)` in `lowpan_nhc_do_compression()`.

Fixes: 8df8c56a5abc ("6lowpan: Moving generic compression code into 6lowpan_iphc.c")
Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/6lowpan/iphc.c | 3 +++
 net/6lowpan/nhc.c  | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 37eaff3f7b69..b2be70036ee7 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1140,6 +1140,9 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;
 
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		return -EINVAL;
+
 	hdr = ipv6_hdr(skb);
 	hc_ptr = head + 2;
 
diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index a4dde85664f2..a9bf340c090a 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -79,6 +79,11 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
 		goto out;
 	}
 
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + nhc->nexthdrlen)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* In the case of RAW sockets the transport header is not set by
 	 * the ip6 stack so we must set it ourselves
 	 */
-- 
2.55.0.1082.g2b9226bbc0-goog

