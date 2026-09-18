Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13E3A1E80
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704316; cv=none; b=aNLtaXfoVlUt2imTd79SYfYeDKvcdEYtuaxtsk8f379gh/PsUo+NIF7FDJl8+akFWvGS43c5//SUCSfyX5pv/jO9kXpVxjXHZmjEufhnMdpWKyKbsgPg7335mDLai8RLvJSfwZa5ZKFCf4nMPAzJopyK+ROgwGlmSpauvKjKP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704316; c=relaxed/simple;
	bh=DbHpwwZHwcETFHq7bJfxk4QzBcPRR3fpqfQprJCF1z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ1tbAqCUPzIfstkANxSdV1b5zIHQpNRqCqDCX/PBUyZp+1QYC3nHqC1we821O9/KaO52xdjttkmEpGb32rrax5VS84DYI0erQQfZVnv8nVmO3Y0mTIg+NZrjLjCu7hMpEll31Fdx0TzrAxJ+lJo3xGqXEuwTALpd3JsTI5vRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrobaThB; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrobaThB"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2d747ec6185so1771565ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789704313; x=1790309113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugi6RUPBClqMIR7An2++qau8YtbA8aE1nyg7UAqNky4=;
        b=lrobaThBqmkmmwQD3sN0GGF26ayUVmjraBdBz/k6NBZNnzxTFZ/jm9f94Wwkmeg+wa
         g/bhy8hI09cnkqQceGTtzL1qaFgCal/wHcQPvGjKTBuDfdTrzWv4g1cRUHzoNHH8epBU
         C7xi/NeJ3YR5EF5RQhmThb5sWiYZxV7pooNg/GxgWluuowG8NnDKxgxq6//SOM16kmjn
         jPYH3ebj/gaglbKn3Jy2tpHw6iCmxpuQxgZxO30CV4wvVrqe9yMszTJo4S0D40ts0bsq
         2h2g9mslLw26JHLRC6Dx9xG5y5OCq/BHs3sB/0eO9ZkaVS0I4hU0wMY7XvJoUQcx3JIu
         wpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704313; x=1790309113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugi6RUPBClqMIR7An2++qau8YtbA8aE1nyg7UAqNky4=;
        b=SO8Z/bbdw7gJeEld6AnwW4ooWhuCkgbw3S77xc9iYSKjGChEJu+MTswmQBZ7vLTs9T
         Xzo7odnNSdnOg7enUUUSKQX5YgPJtcysJ8GGoannI0+NqoDEuBfisyGwrHvcwXe+bpv+
         jhmQKfkoF6PhbGR0X3a4x3Qw21ROE7w98XPb2AMj828HR412iJk8Fw19KNSIazOFVpDI
         HCOpBmNrdnAJpKrLWtDDymlNhSh7cMKutY9kuC4/x2IQpy3znS5frzWHTIAaJwRKkUbV
         tUD5DeHXE/HMyHXNuzM8TuoHXwqwhWhGR8iAtkWILD5NcIW12ISoWsXeuWpFpKoigvaP
         oABQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlq9tGor4YwOBOXZUgiCM0zRhwtbsoX6k1ZJVRH/6gCgse4Eg0hjvnQ5VrGY9cE49VZ44yZe0=@vger.kernel.org
X-Gm-Message-State: AFuF++nnlw6FB8IaPp02+CP2nQzTg1/YHXpVgVrsLgXENBhgnFiNJl+6
	fe9smd3imsNTG9y+iVy6m4IseIq6Gvv5id9jx/BbGRVE7HIxRRP1tiwf
X-Gm-Gg: AYBFou2PHdqwu/WZbjTu/3kQJWpEV+b9XyMAzb4DqGoymq4+sDIN1TL44CkeMPWF0Q3
	H0t6NJPnEE7YthXRdYIbjPpZh+7Iqm1mFAZDcaOa4RdQgwENcJ09yKcd81S8EfgsX3xegTrzUyo
	b0yidopZm6PgTsolpbftSb2hxxUrAnnFCAS+NGsw+bE3rwPbqUBl/JGcu+5LhOujb2T7XMFHYXH
	XudbHfz0ciJjxU09UkikXUsUqw5LuQG6YrRC1xr4Rbw6aHWdCogA4cxZ+mTWoyeij0VPopQKhgT
	A7sXE/AqyRxtJn4E9yWFuvAAlbMs0+7eLq1CM7TuysWncmBi0qXwQMDBr/7ansaD9bcoKorLver
	NobKj4KG96zQ2AMBlAX3GKpaW1GtLLRnFNAHU3ysVxd8fze3hMY74PzXoU5zA8lUBY9ix/XQ4OJ
	Htw+RST7SoHhGr03gWJEn9JlnAauOyesJDqcPcVm/sah1e5Ej12CGZyNHgzpDovwHvyDzsgPj4T
	fN0lEJ1I3Kw1oJxMBosYEGV1sufb/ELgiVd+b0GBt+o591fJyJJRNxqmtqlvlvagZOjckFI4ha+
	3EsBVYb0SmYgVDn0ECgkYaD5D8uYc+HLJBcXpViQi01StWI=
X-Received: by 2002:a17:90b:518c:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39e54e3f439mr2781326a91.16.1789704313097;
        Thu, 17 Sep 2026 21:05:13 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce065314sm1155861c88.14.2026.09.17.21.05.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 21:05:12 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com
Cc: sashiko-reviews@lists.linux.dev,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH v2] vhost-vdpa: drop the parent's vq callback before the call fd is released
Date: Fri, 18 Sep 2026 14:04:36 +1000
Message-ID: <20260918040436.47982-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907173931-mutt-send-email-mst@kernel.org>
References: <20260907173931-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_SET_VRING_CALL releases the previous call eventfd inside
vhost_vring_ioctl() -- it swaps the new context into vq->call_ctx.ctx
and then eventfd_ctx_put()s the old one, which is a synchronous
kfree(). The parent vdpa device is only told about the change
afterwards, when vhost_vdpa_vring_ioctl() reaches ops->set_vq_cb().

Parent drivers cache the pointer handed to them in
vdpa_callback::trigger and do not take a reference on it, so
throughout that window the parent holds a dangling eventfd_ctx and may
signal it. The documentation added with the field describes what
signalling it means but says nothing about how long it stays valid.

This is the same hazard that "vhost_vdpa: assign irq bypass producer
token correctly" addressed for the irq bypass producer token, by
moving vhost_vdpa_unsetup_vq_irq() ahead of the vhost_vring_ioctl()
call. The producer token was only one of the two consumers of that
pointer; the one the parent keeps via ->set_vq_cb() was left behind
the free.

With VDUSE the window is directly reachable from userspace, because
the device emulation daemon can inject an interrupt at any time from a
different fd, and neither side shares a lock with the other: VDUSE
takes vq->irq_lock, vhost takes vhost_dev.mutex + vq->mutex.

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x76/0xe0
  Write of size 4 at addr ffff8881084e8788 by task vduse_uaf/2987

  _raw_spin_lock_irqsave+0x76/0xe0
  eventfd_signal_mask+0x69/0x120
  vduse_dev_ioctl+0x337/0x1a60     <- vduse_vq_signal_irqfd(), inlined
  __x64_sys_ioctl+0x120/0x170      <- VDUSE_VQ_INJECT_IRQ

  Allocated by task 2986:
   do_eventfd+0x50/0x200
   __x64_sys_eventfd2+0x2e/0x40

  kmalloc-64, freed 64-byte region [ffff8881084e8780, ffff8881084e87c0)

One thread loops VHOST_SET_VRING_CALL on /dev/vhost-vdpa-N with a
fresh eventfd and then unbinds it, while another loops
VDUSE_VQ_INJECT_IRQ on /dev/vduse/<name>. This reproduces in 5 out of
5 ten-second runs on v7.1.6 and 3 out of 3 on v7.2-rc6. With the patch
there are no reports in 3 out of 3 runs on either, while the same
workload still gets ~30000 interrupts per run delivered into live
eventfds, so the path is still being exercised.

Tell the parent to drop the callback before vhost_vring_ioctl() can
free the eventfd, mirroring what is already done for the bypass
producer, and restore it if the ioctl fails -- on failure the swap
never happened, the old context is still installed, and leaving the
parent without a callback would silently drop that vq's interrupts.

Clearing the callback only stops a parent from starting to use the
context; a handler that already loaded it can still be running. For
parents with a real interrupt, wait for it with synchronize_irq() on
the vq's irq. VDUSE does not implement get_vq_irq, so that case stays
covered by the teardown above.

Fixes: 5e68470f4e80 ("vdpa: Add eventfd for the vdpa callback")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
v2, addressing the review on v1:

 - synchronize_irq(): valid, fixed.  Clearing the callback only stops a
   parent from starting to use the context; a handler that already
   loaded it can still be running.  The teardown now ends with a
   synchronize_irq() on ops->get_vq_irq() where the parent has one.
   VDUSE does not implement get_vq_irq, so it is a no-op there and that
   case stays covered by the teardown alone.

 - torn read of the callback struct yielding a NULL cb.private: I do not
   think it applies here.  cb.trigger has exactly one consumer -- apart
   from vhost/vdpa.c assigning it, the only reads are in
   drivers/vdpa/vdpa_user/vduse_dev.c -- and VDUSE serialises both
   sides: vduse_vdpa_set_vq_cb() takes vq->irq_lock around the stores,
   and vduse_vq_irq_inject() and vduse_vq_signal_irqfd() take the same
   lock before using the fields, so VDUSE cannot observe a torn update.
   For parents that do a bare struct copy (vp_vdpa_set_vq_cb() is
   vring->cb = *cb) the hazard is real, but it is not introduced here:
   this function already performs the identical three NULL stores
   through ops->set_vq_cb() in the existing else branch below, which
   userspace reaches with VHOST_FILE_UNBIND.  Defining the store order
   and the matching loads has to happen on the parent side, which this
   caller cannot do; happy to send that separately if you want it.

 - retested on v7.1.6 with KASAN: no reports in 5 out of 5 runs with the
   patch, 3 out of 3 runs report the UAF without it, and the workload is
   not slowed down -- 16k-19k call fd swaps and 1.5M-1.9M injections per
   30s run, against 10k/0.9M measured for v1, with 48k-89k interrupts
   still delivered into live eventfds.

 - rebased on the config_ctx fixes now in mainline.

 drivers/vhost/vdpa.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a317867..e1def23 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -767,13 +767,46 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			if (ops->get_status(vdpa) &
 			    VIRTIO_CONFIG_S_DRIVER_OK)
 				vhost_vdpa_unsetup_vq_irq(v, idx);
+			/*
+			 * The parent caches call_ctx.ctx in cb.trigger without
+			 * holding a reference, so it has to stop using it
+			 * before vhost_vring_ioctl() drops the last one.
+			 */
+			cb.callback = NULL;
+			cb.private = NULL;
+			cb.trigger = NULL;
+			ops->set_vq_cb(vdpa, idx, &cb);
+
+			/*
+			 * A parent interrupt handler that loaded the callback
+			 * before that store can still be running, so wait for
+			 * it to finish with the context too.
+			 */
+			if (ops->get_vq_irq) {
+				int irq = ops->get_vq_irq(vdpa, idx);
+
+				if (irq >= 0)
+					synchronize_irq(irq);
+			}
 		}
 		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-	if (r)
+	if (r) {
+		/*
+		 * A failure here means the swap never happened and the old
+		 * context is still installed, so give the parent back the
+		 * callback that was torn down above.
+		 */
+		if (cmd == VHOST_SET_VRING_CALL && vq->call_ctx.ctx) {
+			cb.callback = vhost_vdpa_virtqueue_cb;
+			cb.private = vq;
+			cb.trigger = vq->call_ctx.ctx;
+			ops->set_vq_cb(vdpa, idx, &cb);
+		}
 		return r;
+	}
 
 	switch (cmd) {
 	case VHOST_SET_VRING_ADDR:
-- 
2.43.0

