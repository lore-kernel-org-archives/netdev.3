Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FE406822
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946976; cv=none; b=lxF/p/KTOlzplkKTmPWZQFE32S8s9O3T25kBN8o+SXPts+x+Vt4KnfiwexvtQXrBi8W+7APsrEpA40qGQ+tiQB/6V0jYqEzc7g/4E+eNLB0d4vHcDPlkK/F+3w0saoFKRqZDpICDpY0IihR58T+Vd7OxkOXlpAnnqu7GFxrPZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946976; c=relaxed/simple;
	bh=nAQBbg9Zs0y2Qf9x9IGuBTOq7gf12GSRPT0y06wSXn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pGlFbBlZCSYO33VQit2UxGXszuBqjX41mQwkxdAGwZPSMj4Jpwh/OqppzFqMzN+dnTA4ZQPiBHUBnb3EhDGx+LCgmn6ES343O9Ue6H1Z+KpuDjiNtgIj0lJGAWqDuvxmasWufGv9sWMonwP8Lf/vbgaygJzhdMF3THTMfPRuppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlmZT3s+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCFGw+SJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlmZT3s+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCFGw+SJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788946971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k5ADtFhBnmPz3rZHAoQiP2HyIk15/rYOjED5HrGOPIQ=;
	b=NlmZT3s+IakJBW3DPywyLqFFZTNROyT1ARcnQ2igyj95nUmocZNsHcbpW+yzaukS+dHybo
	nGYp+XnB0zyXt7wDQktoH4lOX1vgAsxD4glu3CMKG5UNjXvwRHqP7Ijn3SddPJ1nBilGjc
	H1TEKXKth6iFPbjRs27EpyLb/Kl2I6w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-KsYfu7QuPdqMDo-tgE8hvQ-1; Wed, 09 Sep 2026 05:42:50 -0400
X-MC-Unique: KsYfu7QuPdqMDo-tgE8hvQ-1
X-Mimecast-MFC-AGG-ID: KsYfu7QuPdqMDo-tgE8hvQ_1788946969
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a99446422cso469032a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788946969; x=1789551769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k5ADtFhBnmPz3rZHAoQiP2HyIk15/rYOjED5HrGOPIQ=;
        b=QCFGw+SJfPxIDCqTpfCv2NEOh0vlyj52QvOzFgdo59VK41YNPq8B3yu0ri3nbUuz8l
         3djv6MSjiHbyocxf3u6W/d11iX+ReS8l4RB+IXDgGV5y5YUZr6cSXgA/87Nh8ISBVZVy
         174p/zVVb8dTfueBDrbFqmddMu/kGBwC3DLPDjSaKDiVs6U4Hbld/5KT6SAMyfDW0jzL
         2F+SInIXXmMSe6PWNL0bUxH7vDN577PS90IYINKE2plovfm4Zh3er8fh9XU5GHsyukHy
         rbs4BAwnQFSS/dYUxlGi4GZ6MCKP8on+I9ahubDDpWpv5ibhVVH61xOX330x0jaP0Wsi
         iqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946969; x=1789551769;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5ADtFhBnmPz3rZHAoQiP2HyIk15/rYOjED5HrGOPIQ=;
        b=IdVZWUH+yrZNt5/LPyInK4XcuYjo2QsyJP8VI4wX71MeicNqeCexmnyR4KWKEhBISs
         gfOoeqKE/6t7WLNFW5iGSytCkBLG+vIGbOaQqT1lGODm6smIg59b8llrXA4+Rn+7YuuV
         /+CnLvckEistU61mMqcW0SnIAJBq+buCTLV/Tb4n9HCCQCON8I8ptkegC+Vzn2tfBaKk
         CcQ6aZ1yeUKbgcC11yjheAZKUNsp9f2BkY5iXm5Ui2AjBPNdi2dWpiDesC11EmCisS8t
         Agi734KaySkUyhJLUzWFxyetWmXpV2iFV5vFtertBbCD6+R/DEfiwKzWCuT/WktBMEUk
         CX/A==
X-Forwarded-Encrypted: i=1; AKwUvByJV64MVxWddC9yd+mJCGNYPZDxqCLuJWIyfpSGXfdfdlMKS3XQXKyz2OfHDmtwabUpLIPBZlA=@vger.kernel.org
X-Gm-Message-State: AFuF++mHrkUEqin8mYPdF1Qi0C+SOxNl3vpEl+/1Y9yb2s0S+kdybLNT
	0Zkgb0lmjgfYRcKP/CbD7xlpb8QDkgn7aI8np3PaoKq+jYJEyNvuAt5yaskFZTFr/xoqOnjrFtw
	VK4fZPu+hbKhQZyjVFl4INW7oUFp03CQ1vJK9OVi8GZlYgIxnP7K6G5zJyQ==
X-Gm-Gg: AYBFou1u9JSNOEk6eIqj2noIuTXNWO4EhGd8kokkfKCmgDmEFDwfj2PUOtTIRsONVRT
	I9GkpmJYJfMriO/60fNtYCF3JHEpxHkle0ElQuMM+07kvFt8/DwHwyBUPQEKQOQU5b9HKpUxbXM
	xes9QPl8KxTDiLzfq9he0q2zdQXUMk9dNeM7QOLTUs8Db4RXb2X7Wg9qJ2zPyYLx7+WTnd1f8ON
	s4f2vHpVfc08kNpzqHpID1Uz5s8sTn2mepjRyRQ16PoqRPhSz3pRU5y+LwTAXSwlkidfQeIYYrp
	1WUB6eco0NLnaA5cihS3z6phMACD6r0sNSbbYv8MC1HKrFRbSaAMkuQlqGeA2O1lIHxDscMsGcI
	Ll7MUv2pLBDD008C/Rbfo4iU=
X-Received: by 2002:a05:6402:2552:b0:6a7:ea54:390 with SMTP id 4fb4d7f45d1cf-6a7ea542471mr11986144a12.33.1788946968898;
        Wed, 09 Sep 2026 02:42:48 -0700 (PDT)
X-Received: by 2002:a05:6402:2552:b0:6a7:ea54:390 with SMTP id 4fb4d7f45d1cf-6a7ea542471mr11986120a12.33.1788946968355;
        Wed, 09 Sep 2026 02:42:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9857ce120sm1226086a12.4.2026.09.09.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:42:47 -0700 (PDT)
Date: Wed, 9 Sep 2026 05:42:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	astellman@stellman-greene.com, dongli.zhang@oracle.com,
	eperezma@redhat.com, graf@amazon.com, kmehltretter@gmail.com,
	linfeng.sun.dev@gmail.com, lvivier@redhat.com, mst@redhat.com,
	nikhilljatt@gmail.com, physicalmtea@gmail.com,
	xiongweimin@kylinos.cn, yuz08559@gmail.com
Subject: [GIT PULL] vhost,vdpa,virtio: fixes
Message-ID: <20260909054245-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 48a4ee65e677559776349128e6a81a6041986c99:

  vduse: return compat ioctl results directly (2026-09-08 03:58:27 -0400)

----------------------------------------------------------------
vhost,vdpa,virtio: fixes

Just a ton of small fixes all over the place.

Also includes virtio and virtio-rng MAINTAINERS updates.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Graf (1):
      virtio_ring: fix stale descriptor flags after a failed packed add

Andrew Stellman (1):
      virtio-pci: return IRQ_HANDLED after non-zero ISR

Dongli Zhang (2):
      vhost-scsi: use kvzalloc for vq array allocation
      vhost-scsi: clamp max_io_vqs module parameter

Eugenio Pérez (1):
      virtio: add Eugenio Pérez as Maintainer

Jia Jia (4):
      virtio_console: do not free control-out buffers on remove
      vhost/vdpa: reject VRING_NUM larger than device max
      vduse: validate virtqueue alignment
      vhost: invalidate vring access on IOTLB transitions

Karl Mehltretter (2):
      virtio: fix use-after-free in unregister_virtio_device()
      virtio_input: stop callbacks before unregistering input device

Laurent Vivier (1):
      MAINTAINERS: Add a section for virtio-rng

Linfeng Sun (4):
      vdpa_sim_blk: reject out-of-range sector starts
      vdpa_sim_net: check TX pull result before RX copy
      vhost: limit outstanding IOTLB misses per virtqueue
      vduse: return compat ioctl results directly

Nikhil (1):
      vduse: do not take dev->rwsem in the virtqueue kick path

Xiong Weimin (8):
      virtio_mmio: disable IRQ wake before free_irq
      vdpa/pds: check virtqueue notify mapping
      vdpa: alibaba: Keep DRIVER_OK clear if IRQ setup fails
      vdpa: solidrun: Free IRQs after request failure
      vdpa: ifcvf: Put device on unsupported feature error
      vdpa: octeon_ep: Check dev_set_name() in dev add
      virtio-vdpa: Use queue id when setting vq affinity
      virtio_input: reset device if input_register_device() fails

Yu Zhang (2):
      vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
      vhost-vdpa: protect config_ctx from being freed under the config callback

 MAINTAINERS                              | 13 ++++-
 drivers/char/virtio_console.c            | 21 ++++++-
 drivers/vdpa/alibaba/eni_vdpa.c          |  5 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |  3 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  2 +
 drivers/vdpa/pds/vdpa_dev.c              |  6 ++
 drivers/vdpa/solidrun/snet_main.c        |  6 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c     |  3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c     |  7 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c       | 36 +++++++++---
 drivers/vhost/net.c                      |  2 +
 drivers/vhost/scsi.c                     | 49 +++++++++++-----
 drivers/vhost/vdpa.c                     | 88 +++++++++++++++++++++--------
 drivers/vhost/vhost.c                    | 95 ++++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h                    |  4 ++
 drivers/vhost/vsock.c                    |  2 +
 drivers/virtio/virtio.c                  |  2 +-
 drivers/virtio/virtio_input.c            |  9 ++-
 drivers/virtio/virtio_mmio.c             | 16 +++++-
 drivers/virtio/virtio_pci_common.c       |  4 +-
 drivers/virtio/virtio_ring.c             | 38 +++++++++++--
 drivers/virtio/virtio_vdpa.c             |  5 +-
 22 files changed, 342 insertions(+), 74 deletions(-)

