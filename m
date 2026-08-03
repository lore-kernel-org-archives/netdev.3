Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668023043DB
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721712; cv=none; b=gDVUFm0VNbQhoIMByB2ZsrH49fnJbQnDMLhHkWsZml1wa7QmkrHFmiK1W84PWuqadAN7Otr0BQj4GJJngOKJMTDCnkUeVwU06CX/5eqUuNxwFXsWmcLfiFjGPLBgwXjY6dXfSESgw9i4dhua7Zhfnyf94z9nIyE8VWv0r38oMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721712; c=relaxed/simple;
	bh=F5jjXvOUykyUu9zaFjniBFZS1TJ9Ywm2mqV/IlHg49A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4yokzS7QlQHAn20WfZOJExwn8OtyxBh0ODdpU0K7c68L64BWUf6HpmZHVFZDGIlWTjMVTNlA+NN7DG9WGDrzy1dpkc3jo0RPuSuZ7UIHQigeE1Mi0MRM46B8Le2WtKOtbp1ePzbkN+S2y8luIfujoT76eW+UkwbXRHJ5m52+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBx2Ne9s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBx2Ne9s"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cad8076b01so32013405ad.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 18:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785721711; x=1786326511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HsrDyLiG2SqFngrsM9H92PhXRSraWTBf1HxDTa+ur0=;
        b=iBx2Ne9swTp6Bma3PYPm/5tO6vrXYIn59TbHwbGyzYQNGxRsr0X6/H8Qujj6GbhXXX
         YRHFSSDFA56DZP85QmuUhxt/KZNoa7pSBVzZcE6hIlQM9I8EBQFekkO5Ix5Acac7kLG5
         BBP4Q7EA0SB0et7lhPxPHFL8C/EgTANcSUBf+GkwjaLbxZZ9kReodvvBnYiQxt4yR1na
         lDPx2yVYjlCUnF8JOzaJcFCO64IeihLAT+X7gM3WsTcw7IHZJAODUjcnc00yqQcMhuPI
         EUucZMkl39oOPVbnKBye9MI0Ns7HnxA8rXwR3sjdpJOHADj5//524qyYPx8+t2RLLJ+J
         qsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785721711; x=1786326511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HsrDyLiG2SqFngrsM9H92PhXRSraWTBf1HxDTa+ur0=;
        b=hOpWTejemfwz8tZZv+g8epHiKJITaQuPNM/Sq7OwWU8ayDGU1Jxm8C3jULA6YOkmu5
         jnLzkhzqViY/cMS9opflLuB0WWdskRMD7Vc0ftWCAiG0Y5XlzX4AdOUdAqtrT0riDsJe
         0Yeai+ATCmn/SxSojGyTmYZg7eF/X8JEtkCw7d1fn5s5/cNOBho+vg2JdLxH1S7+RJ2p
         dUZZE4xICQvxMzf4TnN2dCpWuC8OEy3SmipiKEjexbRHAl0CM11FdPickp1aMWPNuyIA
         +hQZny9KBsM/Mcs7GwAiwYPvHm3FF1WWMpmN0usjItjJ0ssdQvZj2UCRXNjGVD7eyVwk
         A2Pg==
X-Gm-Message-State: AOJu0Yz8M0vo7JunzkamaJxf/+J16bV6SIFxJbAu61NaBdQY+I6Z9YGA
	8ZRv0J8EEsyiuqiZ8s02L6x6+yNwUYBZUrbN/Zg5eUrv4PebxQQ+WwDarO6hUP63NhWwTPJj
X-Gm-Gg: AR+sD11idcP+udHJ2T+u/R5oL3ZeuLk8IUEZgzQYRfGFNQ0Z2OfCiRMBwkqzLZw1oPk
	hUymQZyWWn5N6esonqFNbtPLmks3sqKP2N/lgPejewmqDeocnUMol1XqD7ZxX4u/p3sJMc8/3tC
	mzMWWW2B2sbOonabuWcdysIFjfFq09ayM3RAF7G9dziEFJQRH/bK7qeDTG/FfVCTLKnoe35+u70
	SCuWG/RhQTw9Vv86Z8phatZxxFimVJLOxFWTdKRkrpmVHg7h4aSp5yjc9syxu6xm5wTdDHSaOA+
	SBS8mF/mwYfnvb97sf3nlZGMonpV/vqt0WAQcGqUDREqeANdGLeQun9p+qUclIVr7bl4TxGUkqv
	yls5xVbaOv0/qPmLjIJRFi9bo+SCMmNm5BAvtDWCJrEAq7Sno5RMdpeuNA6WSX5Ucr7+8PEaoxw
	A/iZMMdVCebWakHNLfijFkdc6ZRb5+sqJCcWDgEJJiY47zagPp6G87KB6TaIVpLYxckPfMyBu2z
	I4PTj0slp6pTDPuhzfm8qpY/Ft5Jf9m8jCY+rWvay0K4EAKHw==
X-Received: by 2002:a17:903:1a4d:b0:2cc:df15:91de with SMTP id d9443c01a7336-2d0524a2b59mr81446775ad.42.1785721710586;
        Sun, 02 Aug 2026 18:48:30 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb491sm30422855ad.42.2026.08.02.18.48.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 18:48:30 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: reset the vring metadata cache on vring reconfiguration
Date: Mon,  3 Aug 2026 09:45:14 +0800
Message-ID: <20260803014823.68623-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

vq->meta_iotlb[] caches the vhost_iotlb_map that backs each vring
metadata region, and iotlb_access_ok() returns early on a cache hit,
taking the hit as proof that the region has already been validated:

	if (vhost_vq_meta_fetch(vq, addr, len, type))
		return true;

The cache is reset on VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE, on
device IOTLB (re)initialisation and on vq reset, but not when
VHOST_SET_VRING_ADDR replaces vq->desc, vq->avail and vq->used, nor when
VHOST_SET_VRING_NUM changes the region sizes.

With a device IOTLB attached both ioctls are accepted while the vq is
live, and neither validates the addresses at ioctl time: vq_access_ok()
and vq_log_used_access_ok() return true early because the addresses are
GIOVAs, deferring validation to prefetch time.  Once the cache has been
populated that deferred validation no longer runs -- vq_meta_prefetch()
hits the stale entry and returns true -- and vhost_vq_meta_fetch() keeps
translating through the old mapping as

	map->addr + addr - map->start

for an address the mapping no longer covers.  vhost_copy_to_user() and
vhost_copy_from_user() consume the result with __copy_to_user() and
__copy_from_user(), which do not check it either, so a subsequent used
ring update or descriptor fetch accesses memory outside the region the
IOTLB actually maps.

Reset the metadata cache whenever the vring is reconfigured, so the new
addresses are pushed back through iotlb_access_ok()'s slow path.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 drivers/vhost/vhost.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..77c96993100b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2126,6 +2126,14 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
 		BUG();
 	}
 
+	/*
+	 * The metadata cache holds the IOTLB mapping that backed the previous
+	 * desc/avail/used addresses and vring size, both of which are being
+	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
+	 * region was validated, so the stale entries have to go.
+	 */
+	__vhost_vq_meta_reset(vq);
+
 	mutex_unlock(&vq->mutex);
 
 	return r;
-- 
2.55.0

