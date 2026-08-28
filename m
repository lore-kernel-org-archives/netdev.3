Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625203793BD
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919575; cv=none; b=G5OadKnNYzjW9JlTkzL/ZOozJS6YLxMSNo3pdfzcvTfH+6/QtjHcxO4xBtEJcYSFwqkqfAjg0QGJ65f47ohj/PaUeRhAZVU2RZTyFLyGX7S8hwkJWjvUTdEd0DTMCQAVmlCAs848sr3pDtegjbVLVBDq1wehpdYqURrms8jlrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919575; c=relaxed/simple;
	bh=A1R0s7u+JChv9Ss8a/PFkaOtOi6o6Mi+M9DnbV7Za0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePTbWptK36378nJY9yQXMtsRvuy85tmzXaFuCtboNcYdI12fQLaHekBnTN9cc5Q+KffRXMRprlo79lt4lVTCP2CCfrUjd8FHPk4BIsKydbHm8gId2nogPWaXOM8wNnBsqFJVvJrVbDM4zWylbhAVksbADWIJD5lp0Prlz3EdKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YeBjtbQg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YeBjtbQg"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9390f8a1c9eso45016285a.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787919557; x=1788524357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jeXsbVKGJ8b2tXZYkkCjnNDpr+fkfs4wKW6CIseyfpk=;
        b=YeBjtbQg5qzNwQwvgj7C2mBOlk8DmyAtHd6cVfB+AzGWCghS7kOBZb4ymqJ2kFhgnu
         yYzkklheGgyhGMQjd6dNRgTMj9Gmh7kp1ePuKQBsttyXE8N83Rmid6QjsOxNIyNu4/bo
         Jw22TuaBNhQcCyb6uZbvpLV3w27AJ5EGmAj4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919557; x=1788524357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeXsbVKGJ8b2tXZYkkCjnNDpr+fkfs4wKW6CIseyfpk=;
        b=UiTkoig69Kozm92kjnOfmWLTPPhOowtMihuksZaiOmK8d2pc0FEnUIojVn//g8H+Fl
         mu62Opd/tJH7cWeuw5ChGNqGCsfCcEgom12wu96RlUAtVluB1+4N/ukW2tbta0/QyT4S
         75sBVpaDdy5fAg7nL664J2Mk5shxomAji+WrNCpZmUxoDL8j12m5mcXdCGRDgznGSy6/
         wic7pcE7KMJhECd/OXTphX/zFCHUv/eJ8QkN6ys+TbZ2JpKZ6H5II8qUrTESrzqrg2Kn
         OmdSHe6QRt1fKKGbfbubLmltdmiPjYmdYoh345533DB9JHNR+oGij7mqW2JtGIBw5QYw
         xBVQ==
X-Gm-Message-State: AFuF++ncFOqaBIQ5GjJZFSZ99uIRNPgLwyaqQ6RoSD+3k1sabYxPIaFz
	rwDnGmZHAQQi6dOjoh6vfacMRQZbZxPnQQGcxoBqXIOudteyKUURAa1tKrB3jglTa6ZCl4uEpST
	cv3D68g==
X-Gm-Gg: AR+sD12vkQFry7cIbzlh+iFXkfI+Tg2U85P2Uc3IOQgok1L7cm8STva6Hy2u5iDiToi
	lC6V3d12HK3sD4t9qFNqDO02okEaKRdAnZ3cEDxKFnQW7FaFZ3Ni9iEod/g7H2giSiB0cY9rWm0
	JQ55u820aF+ilqYBFmez4Sql67pA0mEp9NGAudIW0VQ0Eg6v1TY5uG7l8jaFjh3G50Vd/1yOXpC
	YfWGXT1MOSKv6yV4TJX1zkhJxGaQCt0LKEl0t/LHKrYQ6xBSkvWCUBO2WMmQ4WjEhLX/o8QHXCY
	wU4qzVV3gGieUGKEaqZxGV2NithRAoZ3q/wJoycHhLfEDrlDSmlyFi4iUlRpAAh1ylyZkyoNAKl
	WDQVZ5yyLBJvM2XLxjHXAW4+PQaZTbmsKnvywtY57ZZAwdCFFUn1W6VfiSGbj35N6w0E6IPT6j9
	Pup/poJPYheO+z2lWAMbisfBTh2kPEb70SjRcjPdaHKo4GhBIhJSBiEnH9DOpJT6fZzlWRXiPpk
	8tllPxGXr/hGkLD0nar0BFN4xtiiR3fa8SKow==
X-Received: by 2002:a05:620a:27d4:b0:930:adac:1e99 with SMTP id af79cd13be357-93913988103mr688492485a.38.1787919556836;
        Fri, 28 Aug 2026 05:19:16 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740a306sm128672885a.42.2026.08.28.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:19:15 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/2] net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
Date: Fri, 28 Aug 2026 08:19:01 -0400
Message-Id: <20260828121902.66837-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several subsystems allocate ring buffers sized by dev->tx_queue_len
with no upper bound. An unprivileged user (via unshare -Urn) can set a
huge tx_queue_len and create many devices/queues to exhaust global
memory, causing a system-wide OOM:

- pfifo_fast: pfifo_fast_init() and pfifo_fast_change_tx_queue_len()
  allocate 3 skb_array rings of tx_queue_len entries each.
- tun: tun_queue_resize() and the queue-attach path resize ptr_rings
  to tx_queue_len on the NETDEV_CHANGE_TX_QUEUE_LEN notifier.
- tap (macvtap/ipvtap): tap_queue_resize() and tap_init() resize/init
  ptr_rings to tx_queue_len on the same notifier.

netif_change_tx_queue_len() is the single entry point for IFLA_TXQLEN,
sysfs, and the SIOCSIFTXQLEN ioctl. Cap new_len at S16_MAX (32767)
there so the oversized value is rejected at set time. This will take 
effect whether the device is up or down before dev->tx_queue_len is
written or any notifier fires or any ring is allocated. So a good
choke spot.

S16_MAX is the virtio virtqueue size limit: the virtio specification
stores the queue size as a u16 with a maximum of 32768, so 32767 is
the largest tx_queue_len any in-tree driver can meaningfully use.
Values above that only serve to inflate ring allocations.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn).
- pfifo_fast: create veth pairs, set tx_queue_len to 500000, attach
  mq+pfifo_fast. ~28 iterations OOMs a 2GB guest.
- tun: create 50 tun devices with IFF_MULTI_QUEUE, set tx_queue_len to
  500000, open 8 queues each. ~1.6GB of ptr_ring allocations OOMs a
  512MB guest.
- tap: same as tun with IFF_TAP. ~960MB OOMs a 512MB guest.
- On the fixed kernel the oversized tx_queue_len is rejected with
  -ERANGE at set time.

Fixes: 6a643ddb5624 ("net: introduce helper dev_change_tx_queue_len()")
Reported-by: vega@nebusec.ai
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..1d3fc0a268a5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9982,7 +9982,7 @@ int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 	unsigned int orig_len = dev->tx_queue_len;
 	int res;
 
-	if (new_len != (unsigned int)new_len)
+	if (new_len > S16_MAX)
 		return -ERANGE;
 
 	if (new_len != orig_len) {
-- 
2.43.0

