Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367F1D5ADE
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440455; cv=none; b=lS9dLnsSB0onzkLHdWT8Y8xOuko5+46s6piecBlwDlflksxVMe6ga6UOhMuPuiv2qTnLkpDllWZQt4FbJKuMBWSY0Zapd/6pu4yX1k/bLyYfwR+hpbzTtWGNbiKxtekJdjmG+7mIJUW7Osa2h/aQ/OQg9Ob0LpKMvqVIs1YkucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440455; c=relaxed/simple;
	bh=gHGXhrZOWUzF27PW7grMsw/KKp/8O4H77hQXuFerhXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Y5gRvHiakHO+Fj0sFh6eLLt8YNJE4hNWyreGpim24jvVy+B+Ie8tfdmioRsF/rf98wSweIgM5PHUV3RD9SD7L/xZlHCoGYp5hrVMHspIh7ft0PEbX14UcEj4OTNeK3BE7JO814y0R041MxJF1MzVgmhSwHwt6zrCgZZYf3/aeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgwVNOx2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ducSIqfj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgwVNOx2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ducSIqfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782440452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OxGcjxwlLcC8nEz7JDYi3CbjxSnldr+NBxZJ+E8h6AQ=;
	b=PgwVNOx20sWZsSxq0jG0Ge4XMuwT1TmvTL01em9ckk06ZRvIGTh5ekhraRx7vRaTN6DEP0
	Q1JSE7w6vaomDIawoICgw14uEd/yRH3woasWwJCVfv1rMBdBTzpGgdgwLVPbMibci2ncmL
	5E+Jlcc1LTzI7UOaVKLJM/XIEyuRviw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-vsdDmRjPMfGtfxeCxo2mvg-1; Thu, 25 Jun 2026 22:20:51 -0400
X-MC-Unique: vsdDmRjPMfGtfxeCxo2mvg-1
X-Mimecast-MFC-AGG-ID: vsdDmRjPMfGtfxeCxo2mvg_1782440450
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso313392a91.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 19:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782440450; x=1783045250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxGcjxwlLcC8nEz7JDYi3CbjxSnldr+NBxZJ+E8h6AQ=;
        b=ducSIqfjmKIM+oTbaloCJ/yM8WwITncJLlv/ltZwbSvo9cKqbdibfsf8uI7nwAQmRa
         7svGdkB7iscYMd9Abq9BPBt3JoTK/3ng+uVVGNMjdIJgBUCj041L27zPFmRdZ+OYe5xK
         gdmOk8Wd8GD78mtR/t/OhWrORKrNH/53oo9YH2pdJqhFxNyAkMg7FXZWRxArtRqpylz+
         89RTyxtvwt3YEExrga+npuW0gVbqexLHzcAHBP0fB/s0bUiK8MaymJWMOsejA+Hjc2Fa
         rzj/5w2Q9q2glwI8sJTYByPkhUvwFTVcTFwsCBHslm06gxmWX9C0gdYxfgpe7GDifA/n
         cuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782440450; x=1783045250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxGcjxwlLcC8nEz7JDYi3CbjxSnldr+NBxZJ+E8h6AQ=;
        b=r+Eayean2a8eCA7Cr7j9RuO47UBg2J5Gons92lKa6LmIE6VmF2zgNC87yQF4zuc7X3
         BedMc1+QpQkuOls/XmAXa3hadf2b+u+LmHrgIbvE8+mT+Rrberb/57kkIe8IyoGPsu26
         iQDHL9qwCOK9fowvDVzibZEyn9Tic50FbXl/J1rm/8KML4GWVWh2zC13QtOs0d5A6CkV
         aeyLRVpuc8vjxaTflEgmUryCo/VonMEq9vIuu0EymrIQurcZgNopQB9QGNc34K7D1hkg
         ilBBYc2iug/H6UJuixI6TucEN5YvCUvIdyC5f+A18OTxR91d51THRWb5Pi1RwsO0Pndg
         e2fw==
X-Forwarded-Encrypted: i=1; AHgh+RpLQuxklIMbjC5uezSbFkgvLxOnNc4OxM8qdhe3fkW7tFckjMtrM5OstWsffZAJ11tRoWMHIFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSStXGe8DVDc10D6tmpQJKts5NlRObk2m6jiFpaMbDX1y3Kfbz
	/5o12gOpmGL/iCxzAa2tLN5I0IEfiIWD88q6RX2elMmGhAl3eone3RmGDiqpY+dAE8DV4NIRN71
	WHzNX1OCWGsvM/nc6ICSwF/y2bUH5EUp7VPoqs8YlxZmUnKus/HO7/tE5ag==
X-Gm-Gg: AfdE7ck7mTRTal3Vt7IOGyzt6oel5MfPfLBMhIWXdSgzfhe5QOiAhbcnhwfwAzmNA0B
	z82+02L4q9hlQsUSnp/e5x7RU5m/it5pg8AqdAfYeKhAE3jU1JGEsVtZFNgHAsOMH1ZrGQWF+wG
	+f5O/wQC+UZTC9xyinihK2rVMo+2Z7/tBcEI0THH1IibFmR22Lxp1f82GmpbQMlVDstBlShaaP5
	bVO5D2ckjr8oRN2ibLoo6HxVsQFFQ43S75EChxnbWxOAG4HUlQikpBCO49Yb3A50L6nw55PCSSk
	iBoj3dc0Kp2vp/7ewjU5+SsOg+kweP6becdRwwCJf8t2wlwS8QXfydikOHUvO5DYqrLQxLE+RlL
	kPxbUYFJTWlx+2JmPJXUR8A==
X-Received: by 2002:a17:90b:4fcb:b0:36b:7ad1:df70 with SMTP id 98e67ed59e1d1-37dfa19c345mr4397828a91.2.1782440450102;
        Thu, 25 Jun 2026 19:20:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcb:b0:36b:7ad1:df70 with SMTP id 98e67ed59e1d1-37dfa19c345mr4397791a91.2.1782440449574;
        Thu, 25 Jun 2026 19:20:49 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e058a010fsm1284571a91.7.2026.06.25.19.20.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 19:20:49 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH] MAINTAINERS: Update Jason Wang's email address
Date: Fri, 26 Jun 2026 10:20:38 +0800
Message-ID: <20260626022039.96139-1-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

I will use jasowangio@gmail.com for future review and discussion.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..40d9641cbc7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27520,7 +27520,7 @@ F:	drivers/net/ethernet/dec/tulip/
 
 TUN/TAP DRIVER
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 S:	Maintained
 W:	http://vtun.sourceforge.net/tun
 F:	Documentation/networking/tuntap.rst
@@ -28512,7 +28512,7 @@ F:	include/uapi/linux/virtio_balloon.h
 
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
@@ -28541,7 +28541,7 @@ F:	include/uapi/linux/virtio_console.h
 
 VIRTIO CORE
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
@@ -28619,7 +28619,7 @@ F:	include/uapi/linux/virtio_gpu.h
 
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
@@ -28634,7 +28634,7 @@ F:	kernel/vhost_task.c
 
 VIRTIO HOST (VHOST-SCSI)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 M:	Mike Christie <michael.christie@oracle.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
@@ -28674,7 +28674,7 @@ F:	include/uapi/linux/virtio_mem.h
 
 VIRTIO NET DRIVER
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	Jason Wang <jasowang@redhat.com>
+M:	Jason Wang <jasowangio@gmail.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 R:	Eugenio Pérez <eperezma@redhat.com>
 L:	netdev@vger.kernel.org
-- 
2.54.0

