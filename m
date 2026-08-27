Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9F4756B4
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837317; cv=none; b=eH9epnDe4gOFcEyVuvJX9Q9bdaBoixYEWpZC4wRkXP3NiBldE+799Q8gNVHvkUXMB4vwqdpUAVLeBia5CsQ5BPMmdBOuE5OEn2bEOR/tnGRuHjN9ugE8E9GKHdHR1LygspStC/SqHDox4O0+LBj8uze1FNKtUo5JrJRedgu/HsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837317; c=relaxed/simple;
	bh=cBDjBsRPvFafrLzK8QKceBIFqQhgWO51ewcm1BJQqZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fchpt6Ro2jraDe/1/XsVK72ebSZ+wez9A6KVtvoPWpmmn+IP56XQMHiIFcmuSElLjiEDtwx7sFEYjnjo9ttkvZ7Q07XQpJVh9XD5mKwfZVbc5iW8BU7v8016n7YekDD16WZCfWwYqrLKzj/RgG6S9XeWvvIIrfEQz63X6kxdQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc3UXhfe; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc3UXhfe"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ea0b7d137so23480857b3.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787837306; x=1788442106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2JnHZVVZ9o5Z6lh0/e0hb8IIjiL4gIL7y0yXaE1Cb1o=;
        b=Kc3UXhfeFYmhKMldB7V98mT6ZaCd61Q308mheXin25diScdp+l3pJWLomAKGhWYwr2
         AjOPrCRa1M+vyaa3UGYqWk4wNQuGcwb6+ElQReusluhve2d0JG4JhZh5NiL/XznDHf/t
         zOw8ylUT93Fi+QRDuy1dBGbTYXZlJOgfXFHtU7phq9Bt6fbxLmzGwpfLGjbFXV7oDiXH
         5Y9I6GUCR9RmYj0Gjr3KYsS2iM1c2clvPcj2+HhDFfd7Xk0S/4mVkwctYOwt7VLARRZY
         P3HFNb2LzHB1qr1J+9JRUh618TKZGBbGU1ZZwihJioa58pTrzNVMgjKnQ2y7rBVrRoP4
         ZyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787837306; x=1788442106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2JnHZVVZ9o5Z6lh0/e0hb8IIjiL4gIL7y0yXaE1Cb1o=;
        b=i552fVWonqbcEZjtgUoABKgyYqf1M+3gLmz2hcd2t0pwh3ROKTr0MfCPacumXQyfRW
         vN5h5kh2yfM/9EYPwgJ/JgDQy+yEkxoxB2QNClBjiFqINgYWlSIyWSq06XnW0eCUQKg1
         rerydirIHNCD/2rdAcnf7FDhHZ+jQ76hnP0YFlUgLdk9DBORzm9mv1cVrYn0u+t2/vLy
         9pQRFVHVPPC0QJd1PZgPXJX+iUcbPd0mK371/2eSAv9M2J8/7eMPpVvu5sfCMXfJaA0Y
         qPCGesxv9VNZ0XGWWgC1K6rnDaUJpXUWFl2VVXRvQOECs2dYl3McvMUBA/YPFT8gNK00
         +ChQ==
X-Gm-Message-State: AFuF++k6+zDHV+J7hi5mfIT9lNkqC0GJk6Bt7+MmWAz/dJWvgVMAnynC
	7aNMS7N95M2qsmbpSCd2vR4hcDhkAUlUs+Y3zbKFIpOKeTuPW/czrFJ+oZVRMrDkarc=
X-Gm-Gg: AR+sD13cRQSGECmtZII9IwKBMFk4uahpDy6n84dA6pdTkuGyGKMrjOUEyg8+FiLZGTh
	1m1bRz0FiHLygv+oKana9Usmh4QGNMW4/3n+m0XA9uS2gQPHc5fP3XnQ4hPU0tq9/lxAjaMI8P0
	e0iUI4W9XYtFLqDPFD2KfxEzaACu9CVIjumINJq8XCjEs+cUzl1wy9ngzZ0VoMziYoMXJyjnAWT
	SoCcVQvuBe1s6tJfsnMNY6c9rL9si0lvUKNQ/dmr79I27AE+aBJQvKojLrbjipARudqtizFF0GX
	H8AFrGEMVXhFcDUNxIwC/0XU2J4XM+X0wNqbmkTuDi7OtNYr6veHh1OXMWOKb6NZMRddMU4KLV8
	zqpFxzkCOXYdZj/MWmiukNTaqR6Txd+QLsBtEYbqWELesPYYkQAzUJbWsEpTlpD0e9NEmXizuFk
	7sjMVNVRtN4+j8jf3Wj5iT53lqdzRgdhWIC2LLpzyhHTXSNZqQinL4A2I+Cf5x89wgLg==
X-Received: by 2002:a05:690c:a7d5:b0:81f:238a:1709 with SMTP id 00721157ae682-85749dcca8amr53133527b3.34.1787837305439;
        Thu, 27 Aug 2026 06:28:25 -0700 (PDT)
Received: from 2045L.localdomain ([99.153.3.24])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b5c7f3d7fsm9586367b3.17.2026.08.27.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:28:24 -0700 (PDT)
From: Guidong Han <2045gemini@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shmulik Ladkani <shmulik@metanetworks.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Guidong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: gso: always scan dodgy frag_list for linear heads
Date: Thu, 27 Aug 2026 21:28:20 +0800
Message-ID: <20260827132820.11815-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_segment() moves frag_list data into the segments either by sharing
page frags (zero-copy, requires the source memory to be page backed)
or by copying. Sharing into a linear kmalloc head is invalid, so for
SKB_GSO_DODGY skbs (untrusted GSO metadata, e.g. from a virtio net
header supplied by a VM guest or an AF_PACKET/TUN user) the frag_list
gets a defensive scan: if any member has a linear head without
head_frag set, NETIF_F_SG is cleared to force the copying fallback.
Without it, segmentation dies at BUG_ON(!list_skb->head_frag).

The scan is skipped when mss == skb_headlen(head_skb), on the
assumption that the frag_list members then terminate on exact mss
boundaries, so segments never cut into the middle of a member and
page sharing stays safe. That assumption comes from GRO-built lists,
where every member holds exactly one received segment. It does not
hold in general: the first segment also contains head_skb's paged
frags, so even with mss == skb_headlen(head_skb) a frag_list member
need not start on an mss boundary.

Such a layout is reachable from a guest: it sends two IPv4 fragments
through virtio-net, the first with a forged gso_size equal to the
reassembled linear head length, and conntrack defrag appends the
second, kmalloc-backed fragment to the frag_list. Forwarding then
forces software GSO (gso_size > egress MTU, or the egress lacks
NETIF_F_FRAGLIST) and panics the host: an unprivileged guest can take
down the host and all co-located VMs. The same layout is reachable
from host userspace via AF_PACKET PACKET_VNET_HDR or TUN with
IFF_VNET_HDR, given any conntrack user.

Drop the mss != skb_headlen(head_skb) test so the scan runs for all
dodgy frag_list skbs.

Fixes: 3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting gso_size mangled skb having linear-headed frag_list")
Cc: stable@vger.kernel.org
Co-developed-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Guidong Han <2045gemini@gmail.com>
---
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80fb4..e97b27ec13fd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4796,7 +4796,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    mss != GSO_BY_FRAGS) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4804,11 +4804,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				/* gso_size is untrusted, and we have a frag_list with
 				 * a linear non head_frag item.
 				 *
-				 * If head_skb's headlen does not fit requested gso_size,
-				 * it means that the frag_list members do NOT terminate
-				 * on exact gso_size boundaries. Hence we cannot perform
-				 * skb_frag_t page sharing. Therefore we must fallback to
-				 * copying the frag_list skbs; we do so by disabling SG.
+				 * The frag_list members cannot be trusted to terminate
+				 * on exact gso_size boundaries: head_skb's paged frags
+				 * take part in the first segment, so even
+				 * mss == skb_headlen(head_skb) does not guarantee the
+				 * alignment. Hence we cannot perform skb_frag_t page
+				 * sharing. Therefore we must fallback to copying the
+				 * frag_list skbs; we do so by disabling SG.
 				 */
 				features &= ~NETIF_F_SG;
 				break;
