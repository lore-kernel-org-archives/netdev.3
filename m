Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798147;
	b=Nz7z4Tk6P0FEkVUw+HLX+KAm7x6kOP/UjL7bfzJaxu9Hn6VXACWNB02uNTIfPjhgXwsq
	 ewvHexKkJkdWXWFYmzEI1Zj5iOGTvjdi+M8cQfS/u/wPgL4WVANlF/cwJa7dNrxhnYI+k
	 bloaA4T9Pes0EgmWoR4qqvQX4FMa36P3xcSgsNp1PDTCk5rLgyFT6b+QTjo9uQIuFhtQP
	 C6GTMo1F19I+WTzzHq6xMRDUQYN19thduCpBPZ0jsOSnHyw+6aIXzKWI0DfJhw2WOXUrV
	 ZRGPDn5oIys8vP7JbXPGU3EbEYDOgYisX+qbOw6oxRc72Y2IoN5jWS5Jd0v9YQEj3vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798147;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-Mutt-Fcc;
	bh=cweYKUfQfPNBI8VU6FrLwRgYq4BFUF09qYh0EQWkf/Y=;
	b=fK4HYS+xfoaYKcj32J37y0Oyf5uhwJUkkGqfWpAi7k3YTA/Zvh9NcrLQRw5gPCuzmLDj
	 I8oJXzcGI9MQbzJFdWL8You2lgsCJlqS4Ruq8kmRPYtfq3LFS2qAx6KZZftokUJLOfkZh
	 ji0p0D8OecrQmzlYrULKaHY5h0Dubhx8D1PI1ZROAiEOE8Sgi1dgVCDKcCYAe3BKibhVb
	 2Z1tr+DSXNz6DuROf4X28PV91v4DRwpQfBGQnWaq0asiESgcYv0Xk42P7FHI/WDIBQHhY
	 luT/NZ1q3pVBYkFPMjeLc4rujbawCzw39LTHJkhQb4Zuc/QdB95IJLnSyvrSdFvgaAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgLJywsR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VOVSISbG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FEE606D80E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3FEE606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgLJywsR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VOVSISbG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793798143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cweYKUfQfPNBI8VU6FrLwRgYq4BFUF09qYh0EQWkf/Y=;
	b=GgLJywsRfjEmFZg0nrxYgcHv0OFI+rdY5f+7mzBbU1QQHYLozfipX/ztwRKvnMFxDQMonH
	XW/t9c/85/k/swh4l447YMbUfL+8DL8RzmrAGIyhwMaMot/fmzD8ncU5gKcI35C8FKwFdW
	rfoPBDm+WIsWVALDulKxwCeIHeEEi+c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Ug73vZpFMu6Ql6_7KcVZBQ-1; Wed, 04 Nov 2026 08:15:42 -0500
X-MC-Unique: Ug73vZpFMu6Ql6_7KcVZBQ-1
X-Mimecast-MFC-AGG-ID: Ug73vZpFMu6Ql6_7KcVZBQ_1793798141
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c41dae9db9dso100075066b.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793798141; x=1794402941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cweYKUfQfPNBI8VU6FrLwRgYq4BFUF09qYh0EQWkf/Y=;
        b=VOVSISbGoBrQReIGqksyUICgNy+eJf4wMReAqEH46PcS8PAFArdrRqVJ9+kYaebWjk
         nLcgy/OgDP8pc9BPvjxtKwkVvfEl7E18th6JpsVZtvNJGwO7diitmJzSSdE+ZmumLkqV
         FXP7VqeijeAN96Zk7UrAAYSCeLaf7Q9jt14waqw160Dx2uu2QsTFb2Ycp6zE6LpuiHSQ
         Iojgf4t6UtoQycLHDacI4iwEQ7G2E1hPPQrTYdJNje8iUoMm6xiwvDnUJ4v/0aawwuXr
         obx0SJ9dKCOepT3cgfVjCY+dIcL7xXxRjVy/ntXKofAKG36j+AOM+QPgNZzeh3UpBSS+
         niQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793798141; x=1794402941;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cweYKUfQfPNBI8VU6FrLwRgYq4BFUF09qYh0EQWkf/Y=;
        b=0xSQO6/AiXKFxxY/VNKkKGAW/HrfDPxQ/QLzjG4V1Qt5f720braJQUKB0AXGURXBpP
         FZga52SdBdC9yfN83pB9ueP9S9TyFlMcR5DAm1D2I0g6dc43ReI59T+PmuBRwi6fjs7s
         H83U28b1k6q58mDO+7jWlZspDux+nQA/jK0ARaNv7AHOyTJj4v50lNXPIKGTCizDz0SM
         9EWcIebH18kSzRT273AVtPCH8WzrNtmGtpYy38RM7wt97RTYYzNUsNbZi0YDHvDzY1kZ
         fjwyhrB0+6Nd8JH+IKU3YxnzSkP3NnRq8QYRiyouK0D4iCmWOsoG5Ftzgi1nkUlPalbj
         bquw==
X-Forwarded-Encrypted: i=1; AKwUvBy9aFREo3NX2ZWwVnMIwRGS9cla37dXb4RBYvnDB1PQvYbgvBduoV9q64Zrm6/LGhy5IejKqUM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8o0QsPbx+zUjs74YVBUZ/XFNPj13Rc3pXyiSloBCHK6QFs0hiw
	CbZZX1M88CKKjaetvz+fkIH4HZIwQ76tRBnNtMRYtZwzzWfikyyle9Q5e1ytRN2cxzYGimOREQS
	jucxEe4RojJNHP6smjS0CXrR7OWpVM4tHyP8CKGz0XopDQ6Tr0kJE0D2Jaw==
X-Gm-Gg: AYBFou25y2bYapb2AlyahNHeYYdKyQx/3EOv8N5R7zc/cR954Rya//WWnwXoVzlZ6OG
	X7/uaI3OifznbW/cooCe7EimtJlDwWbdLKroQO/f7/4/+ffuODJEpovKO+hH2BZ/yBu3KjAM0zj
	P6fO8usHyK5Kd8UPNiBf7ubyeHby+EZs+iteIrscKaBKa025n6f/97pGNRfokDfgcyNdlFEN4c+
	yUecuvqW0o5szdLWGRjKH6UGlAXSX2bEx1RIuSLCUQTBLvKKTEHUEUh0RlAV2xnLDhrsfV647Nm
	T2ASafQatpaWIcyhua5XcQaEnX6aEiZZlpfcb1MamlrT0y5wzZ/mFjkHo7xQVIZLmfIRCd64S3o
	OyX8nlguUQUTybdNBbqu6UfsILuUbpxzcWU3RWDtPTw==
X-Received: by 2002:a17:907:96ac:b0:c49:b8ec:a9e3 with SMTP id a640c23a62f3a-c4ca7abe67amr1635744866b.43.1793798140907;
        Wed, 04 Nov 2026 05:15:40 -0800 (PST)
X-Received: by 2002:a17:907:96ac:b0:c49:b8ec:a9e3 with SMTP id a640c23a62f3a-c4ca7abe67amr1635741066b.43.1793798140297;
        Wed, 04 Nov 2026 05:15:40 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e48d0dcsm68849166b.70.2026.11.04.05.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:15:39 -0800 (PST)
Date: Wed, 4 Nov 2026 08:15:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh,
	eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com,
	kmehltretter@gmail.com, linfeng.sun.dev@gmail.com,
	lirongqing@baidu.com, longpareto@gmail.com, mst@redhat.com,
	oss.patchbox@gmail.com, p@1g4.org, phx0fer@gmail.com,
	physicalmtea@gmail.com, sergiiushakov@google.com,
	shubham@octane.security, stable@vger.kernel.org,
	stjepan.poljak@gmail.com,
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
	tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu,
	xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com,
	zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <20261104081535-mutt-send-email-mst@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1a577f9402c1780cc1e663f48d5dd54c02051b09:

  virtio_pci: don't take the MSI mutex under cpu_hotplug_lock (2026-11-03 07:32:14 -0500)

----------------------------------------------------------------
vhost,virtio,vdpa: bugfixes

Just a bunch of fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dudu Lu (1):
      vhost/vringh: Fix IOTLB permission in putu16_iotlb()

Eugenio Pérez (1):
      MAINTAINERS: add missing virtio/vdpa/vduse/vhost headers

Fang Xieyan (4):
      vringh: bound top-level re-entry into indirect tables
      vringh: add regression test for cyclic indirect descriptor
      vringh: reject empty / undersized indirect descriptor tables
      vhost: fix used ring index wrap in vhost_add_used_n_in_order

Jia Jia (5):
      vhost-scsi: preserve event ordering
      vhost-scsi: do not relock event vq mutex on send_evt fallback
      vduse: avoid infinite loop when no affinity CPU is online
      vhost-scsi: do not count PI bytes in the data length
      vhost-scsi: fix page reference leak in misaligned I/O fallback

Karl Mehltretter (1):
      virtio-spi: Fix virtio_spi_config kernel-doc

Li RongQing (1):
      virtio_ring: reset IN_ORDER state in virtqueue_init()

Linfeng Sun (8):
      vdpa_sim: serialize IOTLB updates with dataplane access
      vdpa: invalidate DMA mappings before releasing memory
      vhost: fix dirty logging for in-order used ring entries
      vhost: reject invalid IOTLB update permissions
      vhost-scsi: validate event queue descriptor direction
      vhost-scsi: reject delayed virtqueue setup
      vhost: reject backend enable without a kick file
      vhost-vdpa: initialize state before publishing cdev

Maoxia (1):
      virtio_pci: add missing newline to the pmcsr error message

Mingbing Zhai (1):
      virtio_balloon: initialize wakeup_lock before virtqueues are set up

Sergii Ushakov (1):
      virtio-blk: clamp max_segments to virtqueue ring size

Shubham Antil (1):
      vhost-scsi: zero misaligned I/O bounce pages

Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      vhost-vdpa: unpin mappings by range

Thorsten Blum (1):
      hwrng: virtio - prevent use-after-free after a failed restore

Wei-Shuo Chen (1):
      virtio: use consistent virtqueue terminology

Xiang Mei (1):
      vdpa: fix double free of the reply skb in vdpa_nl_cmd_dev_config_get_doit()

Yu Zhang (1):
      vhost-vdpa: drop the parent's vq callback before the call fd is released

Yuho Choi (3):
      virtio_blk: Reset device on probe error paths after DRIVER_OK
      iommu/virtio: Reset device before deleting virtqueues on probe failure
      vdpa/snet: Don't discard the DPU error in snet_send_ctrl_msg()

Zenghui Yu (Huawei) (1):
      virtio_pci: don't take the MSI mutex under cpu_hotplug_lock

chenglong.ma (1):
      vduse: fix VA/PA confusion in the coherent page fault path

sungbyeongchan (1):
      virtio_ring: use shadow flags when detaching split descriptors

zhang jiao (1):
      virtio_ring: Initialize id field in packed indirect descriptors

 MAINTAINERS                          |   4 ++
 drivers/block/virtio_blk.c           |  45 +++++++++++++-
 drivers/char/hw_random/virtio-rng.c  |   7 +++
 drivers/iommu/virtio-iommu.c         |   6 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  10 ++-
 drivers/vdpa/solidrun/snet_ctrl.c    |   3 +-
 drivers/vdpa/vdpa.c                  |   7 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |   7 +++
 drivers/vdpa/vdpa_user/iova_domain.c |  11 +++-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  15 +++--
 drivers/vhost/scsi.c                 |  68 +++++++++++++++++----
 drivers/vhost/test.c                 |   4 ++
 drivers/vhost/vdpa.c                 | 115 ++++++++++++++++++++++++-----------
 drivers/vhost/vhost.c                |  36 ++++++++---
 drivers/vhost/vringh.c               |  29 ++++-----
 drivers/virtio/virtio_balloon.c      |   3 +-
 drivers/virtio/virtio_mmio.c         |   2 +-
 drivers/virtio/virtio_pci_common.c   |  12 +++-
 drivers/virtio/virtio_pci_common.h   |   5 +-
 drivers/virtio/virtio_ring.c         |  13 +++-
 include/uapi/linux/virtio_spi.h      |   2 +-
 tools/virtio/vringh_test.c           |  41 +++++++++++++
 22 files changed, 347 insertions(+), 98 deletions(-)

