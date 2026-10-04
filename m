Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA313B1ED1
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134336; cv=none; b=TUj6fxxQAuq1u+rOMstz0uj3M8aK530zvjFV0jpEPQHw0GiYcdEnvtS84cR2K9PID2LnDhNGuWxDK4/JAJwx19WqwXbtMgQa5ZJm/QWz4pdOdRG5Pf76Lj7exbM9TnMDmY1PCTIeanf9S1K9Q6ndCnhjeLnsJ3aPbGiz68dy4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134336; c=relaxed/simple;
	bh=j6R7ECN44unp2mCC6cIHIXevE6gt0xloJtTFudKCrPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5dmutfmZP+6mIOGrI3edQqLPlN0Mn/Ki0dG9jm0rnZdj4IaKV4QO/JpnJutdcjY0Mp5TIGSGEIKIuP1sQ8MGkDh6j1i8EoLwtrR9Uw5aVfUW8pJaABoppFfndEwCJfrlqLz5S+Uxpnd2+6ZmXkSm1Tf6HBqXZNPBXqaJsd+QHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B68ACjWa; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B68ACjWa"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8ac8eb87a11so5640847b3.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791134334; x=1791739134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UrX1mUl+wXxohAdY3g7vCwgltIUQZvOK983vfJTp2Bo=;
        b=B68ACjWaXTVohk3BNo9SzD7r+AxCjxvQsnOX75BUwskY4+8ObGY/K4ormZXbNr5Vbd
         rzOwVJJciv9lWalVsGvTbJP/X0ksc4zJJaNr8Z7T2aZAvEYTL/CPLzDGCxS92RQInuas
         7wKZF9UwFpJQI6vaw6DtfAc2oE+FBhB36sXNaweuhDQBxBi03xuXN51y54UngyqRMy5+
         srDLBcEvf9dj6nyrHF8UyGASOZdEbCMQK5858LezuWDT4dK/zL4UnGELed0m6yN4iBrw
         5BZnfyCKGtX+B60dwkfiZokiLW+dhXygJN/+uMRiOv23CrEGZQKmzm63p56H+jUv02/1
         IHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134334; x=1791739134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrX1mUl+wXxohAdY3g7vCwgltIUQZvOK983vfJTp2Bo=;
        b=o/7y2EnO76rfamNYDQtH7TKTVSa47lYlFIvnBAA4+7lf/EpxaQP7Mh6FWLrwCsp0a8
         s3hwBecojy386eZBrG5ihsL44s8hImJsAYI8LjyU8bNMmj0rOXF1SjTLmg94wwHnkFuL
         JbmMN1ZNDOBh+j7c/LcVvqRpDTMAsb57JGWYeuH/+BLb68RHJnQofmVrAs6m1TRsFvDO
         9XGy1kgkPJtrqCcZJB/td5iOogWFSiJbvaejM/Vk59UXCp+3eqwct8Y2vsuYyT8/Dhv/
         BHp7uxIrUWkRNSCwUtJdLnsR3ejxbfrPvNoxiptyPq9dhtyEyjuqAgHbKmdhnOCKgpRL
         5hXw==
X-Gm-Message-State: AFq9FYKXVfsDQBgd9hE4AIRyjI1oOnQOdOGxWq8+OetQ3AgH7lHglksH
	crz3n6fNtgKHD63xYZx0EoufgiCxomxOJJ9ztMeksZb8VCmbvdDLA8SESMj0aQ==
X-Gm-Gg: AYBFou0EDdDhlji68j3U+rnr8qQ6RUr46YG5ICHSw8JNcIAaadfVOmcUBDvlb+i4Kku
	iTrRrTyIv3k49ixmfGOq9To43plRnmieIWCPzs8wIYp7wcElFsZxp2QfmcppE97VCYy1E1VlVoK
	rerqhF+GqX9ni2W16mRaPeppEvMStg3Kfcvh0LYXQDQUXkoz/gs5OatkaLkmT+MDx5w0k/U32lG
	alINaC1Dyo0XEVk5nnEy39vaK8AhswU6+H5w1cwhM0mVxB9s3nrLBq22RSi7WaZiUdO6uOKUdbv
	0b430BtSKFn89wgLXLxy0yMyFDd4ALqbV7g3PDx27TsBEoLw1py0oyHVKBcgOCforS4HL9Sc+D2
	zjKDV/Zl+XxfFcJKkX0B68KEu62djaBS05w8rIwayPXaJdgTjvWoUnZet+GjF8OynKlOdjEPwoJ
	wUOfR7hVZeanHNEUMAY/+lEEsF50LbGLRdOzvAsiS+8ZUmbAdUW0H5XSpAJVuiDbkGzjRopsKUA
	fp9CtgAQcLkqNuQXmtZJKOO6/ZR9ASQO5pbcY9G5BKSs8AMEAU7dW2Rk+nZJyu7zg3Wfs5lgXk=
X-Received: by 2002:a05:690c:c4fa:b0:8a9:9c3f:906 with SMTP id 00721157ae682-8ae3a4e9ac0mr34442507b3.43.1791134334059;
        Sun, 04 Oct 2026 10:18:54 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe64d5sm30414437b3.48.2026.10.04.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:18:53 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	daniel@iogearbox.net,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] net/packet: ignore timestamp bits when testing tx frame status
Date: Sun,  4 Oct 2026 13:10:53 -0400
Message-ID: <20261004171847.186954-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Since the commit in Fixes, the tx completion handler writes the frame
status as TP_STATUS_AVAILABLE | ts, where ts can be
TP_STATUS_TS_SOFTWARE or TP_STATUS_TS_RAW_HARDWARE.

Two places compare a tx frame status to TP_STATUS_AVAILABLE for
equality, and so fail to detect such a released frame:

- tpacket_snd(), when packet_xmit() fails: the packet is silently
  dropped instead of an error being returned to the caller for retry.

- packet_poll(), on the tx ring head frame: the socket is not reported
  as writable.

Mask out the timestamp bits in both. In packet_lookup_frame(), only do
so when testing a tx ring frame for TP_STATUS_AVAILABLE.

Fixes: b9c32fb27170 ("packet: if hw/sw ts enabled in rx/tx ring, report which ts we got")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/packet/af_packet.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 6ff16eef24f4..1cabe292ebb4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -398,6 +398,10 @@ static inline struct page * __pure pgv_to_page(void *addr)
 	return virt_to_page(addr);
 }
 
+/* Timestamp bits that may be set in addition to the frame state */
+static const u32 tp_status_ts_mask = TP_STATUS_TS_SOFTWARE |
+				     TP_STATUS_TS_RAW_HARDWARE;
+
 static void __packet_set_status(struct packet_sock *po, void *frame, int status)
 {
 	union tpacket_uhdr h;
@@ -519,6 +523,7 @@ static void *packet_lookup_frame(const struct packet_sock *po,
 {
 	unsigned int pg_vec_pos, frame_offset;
 	union tpacket_uhdr h;
+	u32 mask = 0;
 
 	pg_vec_pos = position / rb->frames_per_block;
 	frame_offset = position % rb->frames_per_block;
@@ -526,7 +531,10 @@ static void *packet_lookup_frame(const struct packet_sock *po,
 	h.raw = rb->pg_vec[pg_vec_pos].buffer +
 		(frame_offset * rb->frame_size);
 
-	if (status != __packet_get_status(po, h.raw))
+	if (rb == &po->tx_ring && status == TP_STATUS_AVAILABLE)
+		mask = tp_status_ts_mask;
+
+	if (status != (__packet_get_status(po, h.raw) & ~mask))
 		return NULL;
 
 	return h.raw;
@@ -2948,7 +2956,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		if (unlikely(err != 0)) {
 			if (err > 0)
 				err = net_xmit_errno(err);
-			if (err && __packet_get_status(po, ph) ==
+			if (err && (__packet_get_status(po, ph) & ~tp_status_ts_mask) ==
 				   TP_STATUS_AVAILABLE) {
 				/* skb was destructed already */
 				skb = NULL;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

