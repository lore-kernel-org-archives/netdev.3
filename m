Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4773C457F
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213065; cv=none; b=mP7t82bOSMRt77q8/DPfwYXi9DeGoTk3uf4Ab5Qb1oqgUWAuUp3LW65cJt2H5dMhak/4MCubGUk+YE6IUBPIAwt/L0QC9TweuvbIvU5R1POZl4HlR/V36yluSR9KyRi/a8oct8fmVgNxQWMKK/MdCekj8RujDjbDSXCY+PZaZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213065; c=relaxed/simple;
	bh=ru4qweuJqGlhKUthy5/6S5+Rr1FUsZoR9Bxo6pxBe84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P97ohq2yPfjfNlK49zCKwhHHFsUqAjP83XLymJG/xs8dffZWWrDbrxNuCa+aXH3PgGsowDDIha5hY60vhm2XdB9kVMYk9LQ9hnTyUrbbWbZbE3dsxBv5F6pz+CU9DbPNObpUyfksAOh9d0oOqkpm55gy6JBP/XHzkm3oPCZ54ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWGuLFLL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWGuLFLL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceb096e675so22463095ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213063; x=1787817863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x78ErVeCRHN6nIR5BE2bLaNonVUmCkwh6pqCr+oiUKE=;
        b=dWGuLFLLZEHINFCmRVl/uuhojokA6rfZWuDUqiyBBNXrK/SzTAQ+59pPbGpdNCCWu9
         WbQPszq+BbQxq0yUfJGmIKh3VJqlk9DzJkVGWc+cY6xfD0lzQFMM31zkKZW74qEMLmq7
         mFV+lvRJwUdwZQnStAOgr7j+K5QP6iEnPJpDfcoHu6h/ZKdMAn7bOcrlw2LwLKtHkb4J
         r+6F+Hqih4v6ZXpImURcasZlGZhbeuHlevRLAY4wwiRfvzt/FSYckTv/C5L8B1cTPrvw
         oQaZ0dJUheX9x2F3PpQqCYSxT4o4jm3OnTLbU74VFPkvb9XYHOFK+4u/lCRv1OO3G0/v
         N3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213063; x=1787817863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x78ErVeCRHN6nIR5BE2bLaNonVUmCkwh6pqCr+oiUKE=;
        b=QmrFBd+K7M6oJ+ZA3Sjj6Sq1+SFoNOMvZYE1tTmbW28ocOM1FbwgN2KeiB99blg9So
         V5ARkIPDsQt9rBEP8/kiUgbjrqmJGEWF77amg/A9QqGKKH0LfyNcC0IBwk6eU62TR4MD
         CDZ9JS/EamoHBMY+R5w32F+bKyyBM0uYrsveizm8/AHFTvAyK9ivsOY/7BrgDEHES9OH
         vHct38OMIcSi9LkhDMOU0YCyS+aqz7K/WTTqu0QUH//Q0XKUF0Ys9iVDQHlauI+jKISJ
         6fOKWA1TFRam4jnBxx5H0GPa/0wD5Y3nwZhOtsbAIPV0KNopsHNiaImrHZDuSOVEsedw
         Zu+g==
X-Forwarded-Encrypted: i=1; AHgh+RrDcLcz4HOx5s2fGjkSHFHVXmOuHDPejVlE+chaaT0BtuxRbi6nn/MBuKZwxBV0dwpo+1bdlKk=@vger.kernel.org
X-Gm-Message-State: AFuF++n43h7Ip6CJDmtxKBQiOAxgy0eSjzUDgbaHQPom2yXde3dyaZC7
	pHVdjvQ5kwoWVjT/47iYn4qVH4VYbp/uXBeTVzBLu4t0qMazwIjcpmsV
X-Gm-Gg: AR+sD110azlzwAhMA0h2GZG+9FM/vHE2GNkKS8opqZvz1PYQrTYREUHMoqYVMw8LWYJ
	r+FDMuN70lPPQGmGK2ktsfO/rsUTf6fHkr9FynR3cuoaeQl33oHRfnno6UJRd/LE4PB9lyjhkya
	H322UFgsLMy9eNQgyi4U/b65B1HoaJCXt9re20Jz5PUdoP75pkUA9TwNS/lxKbrbgY/0RrctvKd
	YgO6HqRq5wPK5hAahw7PIjHRZAz8Uj1k7tTZJ5jOSsrYe0GYWLplnCbmrgf8GtCKXMV1hrTqXfL
	vbf8cZg1HhrmGQ302fGIH+EgGBr5oqCxyTmwvKiFc+aNwvqcJpESf5pUUMsRU9CriaFJy/iZUed
	8EiWThVXMYYHJ5zG9S/1jaS9YF2vJano2MYrm901fTwKUqfLHW2KeWA6rwSRKcddejbIZqEwWNy
	xJaE/IKNaGro6hTvFBjfukfTAKGLzQrBNaVsefyeSSjPn2JHN3W4L3mOYPmgfA6nQdemdVSQ==
X-Received: by 2002:a17:903:3887:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d5fd740167mr200442945ad.9.1787213062229;
        Thu, 20 Aug 2026 01:04:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e175sm3556075ad.50.2026.08.20.01.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:04:21 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] vhost: fix device IOTLB feature lifecycle
Date: Thu, 20 Aug 2026 16:03:29 +0800
Message-Id: <20260820080332.313933-1-physicalmtea@gmail.com>
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
virtqueue backend is attached. The device-wide IOTLB is dropped first,
each virtqueue then clears its IOTLB pointer and cached ring access under
its own mutex, and the old table is freed only after every virtqueue has
completed the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses
for the new address mode before data processing can resume. When
ACCESS_PLATFORM is enabled, the usual IOTLB miss/update protocol
repopulates the new table.

Changes since v6:
- rebase on the current vhost tree;
- remove blank lines between commit trailers;
- drop unrelated error propagation changes from the backend patches.

Jia Jia (3):
  vhost: invalidate vring access on IOTLB transitions
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

 drivers/vhost/net.c   |  2 ++
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  4 +++-
 4 files changed, 58 insertions(+), 2 deletions(-)


base-commit: b282418bc366194677eafd1dad180d92254586ac
-- 
2.34.1
