Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119B3B2FCA
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352658; cv=none; b=mT34BL6kfqT736K726ponJxeTpNEOzyKJ4TJvU/cE3hv53VQ8E/GtXTB9EDRMKfnU61LY571gC8+TpcyEq6G4gtMcIlmh0ZjOA4Vo8yoElklwRkrpUXn5h/ZhmBnXAjQI9khmrsOo64IF+k4EVcsgNr3lXLAjbZBtg4UlT5+mkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352658; c=relaxed/simple;
	bh=CnZq6n4lbArF4xO3Li8H/zaf5RFPjl2mChGqONYhzMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX4JfMOasOv6TWOBLz5mnlM/bpDcw/5uPsa6YUzaMDBuB8GSzftGMbWjwI+Y3u//A3VEqA1D85i4J0ct1jpkuARkrNniG5Ja7kfNj3EDAIURO/SCn+zfXc/ksJ9B85ZlJCMKeM/MyXWH/yWGiczRnIcCmHgJFvATby1EBf5t+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNNhxrPp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNNhxrPp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccf2360620so13222585ad.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352656; x=1785957456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoqhwluyb9WMKHWbPCTqTwB3rnIRyxwcbgywXIfiH+8=;
        b=oNNhxrPp2F7fpTFp3FNqmTvgzVrbM9vnTEizDwS8/OjTaTVib5eYj28HWuK08X+XIM
         /roOWh93JVyPrj7fjHIXSHMlPEC6GCHueDambTdK6XqkONXMX9ufNNIPJJXxAcMF3ByL
         5Tyl5/n4x8Z9nErMKv5KzPboAZDQMyKwVsMO1HX2eUdbl7bWPFiPisQBUnaChmlN9HQ+
         g/Z0ww00m5gOmS/Ui/X6oLRg+s3gOcM+8NKFIOzz4Ld1qdxsaiWW/4VxTO9eIx0Wlwld
         Yg5/AkyNxpomUq3Flva7Esm7I4spqiCsd7i/jzRUfOQEhfLGwf1T2SVs2bLit2ONnM7X
         k3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352656; x=1785957456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoqhwluyb9WMKHWbPCTqTwB3rnIRyxwcbgywXIfiH+8=;
        b=RWC5ssPcGkJoxIFpmmX2cp8Dx2Esh1s5/5mgUGKXmJXR1DNLqtF7z4d4ynP6/6Ukrw
         ZBGV11QXCK6CPCcv22nQ+g6wRwJUrbGrTTpTF8M5tRU96bkpBuYfmfPPpPa5mrnRg/qs
         8NZxtjCyy7tET8IEih8Pez/Iy6Te9GOdG2XJPZA5itNjuHhJAAhvfUwF/qhw0+iGX/U2
         P4TSa5JwP7nhONT557SRVj12+68PCo2ch9hrQY/2+8zWsc5X39nAg+3WKNjQeY3syelG
         wPbJaQ4TefpuNIumAA9riS4AanPZf3rQrQG0QsHPaBqXrJZndqns/uO0uH4BDSWh/auJ
         4J/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqBwIASeixpsSozXJH93aG6wBQ+icK56dbPuOBxPaT3EQNqwbFK3XADXh+nHsfuycKXILZzYxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybGKLs0wnVducSOGWkCMs40ZTb6Ur1kdETSURpurGqJIxluGBM
	giOFB47uUEYqANI2dilF15N6C7X3Kg92xNLTSFBAwpDW4dUUEC7/f2R5
X-Gm-Gg: AR+sD11GOjjqXayzLRf/13p0OKoQnbUbmv95tarRJY4fgjertomILyvyWuit/85Wsmn
	I9BhWmoFAfsttjOa5VDgNYg/1kt6zJgSWKoUJhur/rM8pZiBTmM7PUU4yximX8+6WCZJB7JW4Wk
	ooVMUsNDfRb6mXve4VlRwQCDjQvVsv7X7Kzuk1OlVBhM+uZX4GpoXfYeiDB2y8MdJ3QmPJPJvxU
	IY+B9taeiMGeP4BX3DeZpaJh1V4BSAQFqih2BHwMRZndm3EuIRmjhzcoW6fYDEqgvQcc1t3NEnK
	6IVyOvlE6ilTV2ic4m01UMitNn2HWIQ1YFl7dZDr7tPAYMOR3lOyZO84sBBZaK6oXzplbpv+kY1
	OzQbCU39YECkTgGrY/Cv1Leu7u5NS2m2Puh5JZfv0atTMXIk9BVZ7j+8LOanr4BNbwrQSONWMtG
	jzxSV2rusY7iLevYRHX9fjJvK8CtdIs/szHcA6e5ilwENhHe6x2VcIEqYeM3kKCmpuHqY2
X-Received: by 2002:a17:90b:39c7:b0:387:e0db:bc24 with SMTP id 98e67ed59e1d1-38f9938b014mr120587a91.36.1785352655805;
        Wed, 29 Jul 2026 12:17:35 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f81543abfsm833349a91.4.2026.07.29.12.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:17:34 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v3 2/2] vsock/virtio: avoid refilling the RX queue after teardown
Date: Wed, 29 Jul 2026 12:16:55 -0700
Message-ID: <f9c8c1d64cad9d262f305d02ffe164c2f900fadf.1785352330.git.bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785352330.git.bestswngs@gmail.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com> <cover.1785352330.git.bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
made the RX worker jump to its common exit when rx_run is clear.  That
exit still refills the RX queue when the buffer count is low, so work
queued across virtio_vsock_vqs_del() can add buffers after the virtqueues
have been deleted.

BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
Read of size 4 by task kworker/0:1
Workqueue: virtio_vsock virtio_transport_rx_work
Call Trace:
 virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
 virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
 virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
 process_one_work (kernel/workqueue.c:3314)
 worker_thread (kernel/workqueue.c:3478)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
...
Freed by task 141:
 kfree (mm/slub.c:6566)
 vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
 vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
 virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
 virtio_device_freeze (drivers/virtio/virtio.c:658)
 virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
 pci_pm_freeze (drivers/pci/pci-driver.c:1098)
 device_suspend (drivers/base/power/main.c:1968)
Kernel panic - not syncing: KASAN: panic_on_warn set ...

Jump to a no-refill exit when rx_run is clear, leaving the normal exit
to replenish a running queue.

Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index a8e1dd95ba8c..96c9fe8d357c 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -638,7 +638,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
-		goto out;
+		goto out_nofill;
 
 	vq = vsock->vqs[VSOCK_VQ_RX];
 
@@ -692,6 +692,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 out:
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
+out_nofill:
 	mutex_unlock(&vsock->rx_lock);
 }
 
-- 
2.55.0

