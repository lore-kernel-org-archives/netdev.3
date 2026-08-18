Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC03783C6
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027191; cv=none; b=LhZX2GOQ1pPbU50kTBJ5/5/jlyAYzhpW8p6M/AW2BRaHRwwWBw2v4Hg81kN3ulQy7XOfi0PFu64dLP1Pa/AVDsIqmOZ2yYAMgR2z4qVYL1txVRN0YxLndyw4RSK2bpdaldkUnSMlUiG3zTSnxx82jH9HSYnrHNOTubbgOgtTgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027191; c=relaxed/simple;
	bh=0EL2LR7po/s9DUjjNqlWFSV+gjd+xJ1WILPheMV+JFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sptY6KJk6q5xU+k51Hxo1jlv3cdOdDFTimcwK3p03Be2eqokE1N7JlylNaM8e4FiRyvKEsrvyy+mo4TEOJMd/ngVApFfmx4s04VW9iOaWesaXhI0aFgpMx8c2Daa3W+SbnQtpvP/Hbo2imsWJcLchH0KfpdYDjhdci8rn5zH+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOqN33aI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOqN33aI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3811f512167so5844285a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027189; x=1787631989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjmxRYlcS6K8pKZdReOoWwINkSByDyWzsirONrxxVnM=;
        b=fOqN33aIBXf0FKQDGweWmi5sNbXbXR8vF7juCxZCb8dRSI93aXRZC5muYsJkv/aj5I
         Ao9PMk2AcVGsfyz2xoEvNdml4OvPQ/Wf5phH/xzl32h/aZedMzbL4wc8zkIA5TGSgYnj
         rEVUex20XsYevxPckd6iqdI7VBzWLpohEDJmeb7Zu6p60Gcm5hYv4jOFa4GqVHs1j6k8
         Hf474Tu73CvasonRW3WfH3pmqE/V7FrYBMjHvB69j//IkPjx84md1WOL+Rd7zjh8tSiN
         bF+y3jkCs6g60NL2OTHGQgy2o7SwAK4KBFJfFlGyqPPS1A5xpEsISfhiuUzXbGQq789n
         aubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027189; x=1787631989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjmxRYlcS6K8pKZdReOoWwINkSByDyWzsirONrxxVnM=;
        b=JQPuub5lrYHEuEgG38RWg8U632v3M3quOL7cfef7LCngTI/XM3zYOGbzZJIFG6/3jN
         bmQXPof38aCPnXSWpAkJhsTNnrAIsKRGGqhOleTVva6MjqTLflFJzB0rgzSXzn47n/8g
         xJzl8F8sFsPCBz5iB06vycRpx255afgFQRmUAYPTtCJhj5zj1QvW38vYgp0NXArTjoFx
         P+UvxfdX2dBrnvx0sgBbYi4peIcLEo5FzgHKK3S6gTjJfZTdsv12K3N7tFfJGdOQQZ6v
         R0/kv6NkY/jDu1DonkiO+N5ctL2WcxVoWgY4UaYxXtlkQerIoKdauJS+/sQ9nDKQyu4I
         xjpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwJn4DAIiihABJHgXoUoONISMKPYAKaQP1JWD/CM3vwM32FBAbmkozIZ8fGw+tPWVJ5SPUIwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CiB4oibTX4N+E8lt8n1WPEK+k/lHKD4Xup+SBqviCJy7E8YY
	607Ef0CeUI039JS6JVBihCFdvZTst5GZyAmYPDqr46hs4K7RjYZGngHi
X-Gm-Gg: AR+sD12Hb5BArgN5puB5T+FX47Vv/+E+2/4A2hj7iItal7S1WIJiY2lmQ986B3PaEnV
	aHhjpFTCV8MG0y6Sa6QxUOogNNFVuDSkjLYYHkIkAEa8J+GewB4PFLqM93Dr+3ibXxRfXNSvLll
	64O8dx+Yhf3e3GGPfmfm04DSWZ1Byb1e0t61aCKhVZjfuz0a1euAVDVNBUL4B/uO9Fp63HVFtpf
	/c/6L67XMpcAxfY2ScJ065dFAuwT8R6t8kO1dD9T7ZlyRu5o8oBs4Jcr4sz+vMI+OP2jvhhCavQ
	Zsr86OSr9BuCTPil21aw4pBY6+cRLw1eYr9J2z5YyuuWewHtrXWwRLtQDYKWgEld2Xw0th4EShM
	jWIGQ1EB5seIjkJXVfeaTo5YTLtAg52MPIfLbxQcUesMQ2FTpmXFcfp5MSTJ+qaR50E7oMDiaUk
	z/wmLKC85oEDoxgNKsEleKBq6BkiVhPr3gkxBdbM0KvBwQNBjE/VfQQtAjXew0DjBm
X-Received: by 2002:a17:90b:1801:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-3955aa0826emr5406167a91.17.1787027189224;
        Mon, 17 Aug 2026 21:26:29 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d1b0143sm4527762a91.0.2026.08.17.21.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:26:28 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v6 0/3] vhost: fix device IOTLB feature lifecycle
Date: Tue, 18 Aug 2026 12:26:10 +0800
Message-Id: <20260818042613.281125-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both vhost-vsock and vhost-net can leave the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. They can also replace an
existing IOTLB with a new empty table when a later feature update keeps
ACCESS_PLATFORM enabled, for example when updating logging.

When the IOTLB mode changes, the vring addresses previously supplied by
userspace no longer have the same address-space meaning. Leaving those
addresses installed would allow an old IOVA to be used as a direct
userspace address after the IOTLB is detached.

This series invalidates the vring access state during IOTLB transitions,
makes IOTLB initialization idempotent, and uses a common teardown helper
for vhost-vsock and vhost-net. IOTLB mode changes are applied even while a
virtqueue backend is attached. The device-wide IOTLB is dropped first, each
virtqueue then clears its IOTLB pointer and cached ring access under its own
mutex, and the old table is freed only after every virtqueue has completed
the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses for
the new address mode before data processing can resume. When
ACCESS_PLATFORM is enabled, the usual IOTLB miss/update protocol repopulates
the new table.

Changes since v5:
- invalidate desc, avail, used, logging state, and metadata on IOTLB
  transitions;
- apply IOTLB mode changes while a backend is attached, following the
  per-virtqueue handoff suggested in review;
- apply the IOTLB teardown to vhost-net as well as vhost-vsock.

Jia Jia (3):
  vhost: invalidate vring access on IOTLB transitions
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

 drivers/vhost/net.c   |  8 ++++++--
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c | 10 ++++++---
 4 files changed, 66 insertions(+), 6 deletions(-)

