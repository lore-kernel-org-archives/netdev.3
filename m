Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873973;
	b=uGYwty23pJfsYRb/qSFHCwYr1o+yiI2PaFw0/6YBJtyaI3UWjeY4b0DICdq4X+1iqHMm
	 FdY/INB2BPyAFWMGKbm8ATCZBcS+ruNU75YolQlZDMKcjepVMXz3WVPJ/bAHQCmGOWoyL
	 m/HQvIakR1RMomi2XC36DxPvF1KSUIQZqyXu1qIpyCRp1Q9MPoXKTLPvOK2St1BSqRiGI
	 FezZTUlNiq4psKS80ByqObQKqJFAlj/1cAQI9sHVKVMqDEOPqHNaLFc/UwaHO/uiOm+8a
	 gahqgVUWZ+b91iAKZmGEtlLlBMx0o0WOt+eppVaMMydaWo+jWlxFYKYButhjlpoXuzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873973;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/2+xR7h3rNPHrZb7MEbP97PuNvaX3QrmpfP5OQT5IHk=;
	b=Pin/4UeOHlbwuzqMQEJs0vWBt0lJ/LdnKwOnAz6eM3eEBf0+wkyQb4jZC6SDXx6Ew21U
	 2HNUQEbPWdghw/B3BpnbC24ypoIgUSDBOB1POqgMYv0FMst5M1lyWdqj6o3wDG3q1+FVU
	 9e7/0qQhCaOMQaPJ9jWqAkOnlm5J8KKuNsgcPM2rRG194ZtUSRAIusiQ9VyRdCq3bcTmK
	 OXO6t/fVFBsgHYQMOo1XQrvDxlcKxWZ6WZMOuDUFX6CMfq8Tv6tpN+RFYSLn84CIbuVTI
	 eXH2f8qMehOqOTjPtHEksQ262/cVo6yB6C/TdRIBquyje5zoXtPnwq7mUOF1u8L5kgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PY8w+zYA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HMJklcMh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F7606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B9F7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PY8w+zYA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HMJklcMh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793873971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2+xR7h3rNPHrZb7MEbP97PuNvaX3QrmpfP5OQT5IHk=;
	b=PY8w+zYAXiiVifm6btqV+p5uDBQw5cQQYVuimHjxqdacJfiJcVuJAgaOTL3MWKRWVKDitI
	mCsjOWf0L6ZcIug3KS6evtUDA2nG2AFeSAohzEmzEMrG97dg0RH5BrlnRceL6KZLKnizB/
	7WdZy/6eIV3q/m+xNIGWscRxWYF2xy8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-4Z-gc1CINMujBijEjfkoZA-1; Thu, 05 Nov 2026 05:19:30 -0500
X-MC-Unique: 4Z-gc1CINMujBijEjfkoZA-1
X-Mimecast-MFC-AGG-ID: 4Z-gc1CINMujBijEjfkoZA_1793873969
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49166c8a60dso450901f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793873969; x=1794478769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/2+xR7h3rNPHrZb7MEbP97PuNvaX3QrmpfP5OQT5IHk=;
        b=HMJklcMh9FcYEXGvdgDrdmi0+f7NbWsuCXHc0hMqdEPVp0TkQ8B0Jwpy4ReTtJzZPh
         SLE2pVTWesYvybWibzIhXsA+oZIsNutxhoV792AUzGz2aE9aYfuOTtoBPli/Sua9yeQP
         D5X2qTQGPX+DRtRiEiPbrU+/nm4dkuZwKBuHVZCchSHf3fioFSc8iDW/bdRDkgpSWIav
         QXg+UVZcMs2Fwv1bKpXD/uz8JxLfiDSngSlKMGnZt95jFNna+U0Z/dlhhREXpRzmJvVS
         njlcPJDpkfq4PB9wlB47/l3VMD0V6cDYLLM826nBbkvglvtcqFAQhs0nEB6astc5/pC8
         1dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873969; x=1794478769;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2+xR7h3rNPHrZb7MEbP97PuNvaX3QrmpfP5OQT5IHk=;
        b=jwLj536GsD+OxXCWFNSZVafDC1Vb2/L3bZSaIy0ufXUsJQu1sSreASYOX1UzeG7FGL
         W5W33KrFpBiA5R9tvR9bRpWb809PUdrVpD7UbCPNK0AIsDtzzq6XFlqJsNzHTwOzawio
         VuUj/STHcWK9cWRIE0Nto8gBnh2xAZy6kgBZAwO5/OgpTPurhbSEwEbqDNjaWOEScfmJ
         s3gsMrNt6C0AJByyK5yqrV+CJw/DKkflqCHTkufkrSkjviusJqd3bzpI50jcQkXDEVWn
         32uHphktYMVrIp6Q+4JjiAhlkqlQTJyPI2pQFUipwi7eqp+FYzlxAXgCRAXtNue9eMzD
         TWTA==
X-Forwarded-Encrypted: i=1; AKwUvByq7cgcVCQC7/GjVNBvw82YQ2MWYj+vJQybRuxYp7voOd/HrI4s9Hf0csVK0M+QR9Y0yPSlOBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sKEmVDFQVcuhq3DhS9SameJ7eOQ4OE6wrH0FUVjpqdW1Jqrz0
	4e7SQbZV4UJ491p0S9IDNkiuz3YFJptpPMSQKZvIxP0s2lBCH4xqc7H4fQ7NfrgEmkfgjeqPbRg
	+udIkzJitvF45pMuIhukCw9LAk2Mv7fTpD2KdVM5dv09vZgUvZAWRTW3oRA==
X-Gm-Gg: AYBFou2wROTmpd1XilsVYKP6/DRrtW8kpWWcb/xEtid4cbS4VAC5TMSefPNIJ8GHrY4
	OMiET0wF8HAaERjQG24yluiSMsspCH9MyJO3i3odWOkIx4wxSHkgMv3dk7bjHDSCGDCJrc1XJPx
	DfyTfkDJ09hAbjs1dhNmhYfGkOTs6fggFd4mF5M0kD6l4WvdlUDrYmbEaqPuUzM6uk263xHp4xm
	wWmXRmT8bFDD3P28Fh3ZcB3YJri1bpA5DOQBgQdN7t/477aFx8+JlQ9wnKdmd06StzUDITRjhlY
	wL6JILYDKh/wujZttxNmumIYcDhUIlhILw5iFFEuhydtM6GyCsmR2ERcCjpTUSXR63ITvxa3xSI
	YgHDxab/3rrM7olNKVHX9f6Wq/63OzccCseFLwtgaHjw81zglgjSi
X-Received: by 2002:a05:6000:3109:b0:48f:bcbf:26fc with SMTP id ffacd0b85a97d-48fbcbf2c1cmr13670543f8f.53.1793873969140;
        Thu, 05 Nov 2026 02:19:29 -0800 (PST)
X-Received: by 2002:a05:6000:3109:b0:48f:bcbf:26fc with SMTP id ffacd0b85a97d-48fbcbf2c1cmr13670494f8f.53.1793873968633;
        Thu, 05 Nov 2026 02:19:28 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844c8sm9640157f8f.26.2026.11.05.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:19:28 -0800 (PST)
Date: Thu, 5 Nov 2026 11:19:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Message-ID: <auxVKMavkOw3Ia-6@sgarzare-redhat>
References: <20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de>

On Wed, Nov 04, 2026 at 05:26:43PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>virtio_vsock_vqs_del() frees the virtqueues but leaves vsock->vqs[]
>pointing at them. If virtio_vsock_restore() then fails, the driver
>stays bound with a dangling vqs[], and the next freeze or unbind
>passes a freed virtqueue to virtqueue_detach_unused_buf():
>
>  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
>   virtio_vsock_remove
>  Freed by task ...:
>   vp_del_vqs
>   virtio_vsock_freeze
>
>Clear vqs[] after del_vqs() and when virtio_find_vqs() fails. Return
>early from virtio_vsock_vqs_del() when vqs[] is empty: a second
>del_vqs() would free virtio-mmio's IRQ again ("Trying to free
>already-free IRQ").

Is this an issue or just a warning?

>
>Found with the help of Anthropic's Claude and reproduced on virtio-pci
>by failing the restore with failslab; the virtio-mmio IRQ issue was
>found by the netdev Sashiko review. With this patch neither report
>appears on virtio-pci or virtio-mmio guests, and the vsock vmtest.sh
>single-VM tests pass. A find_vqs() failure after some virtqueues were
>set up was not exercised.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>Changes in v3:
>- Shorten the commit message (Stefano, Michael).
>- Drop the two comments on clearing vqs[] (Bobby) and shorten the
>  remaining one.
>- Drop the tool note below "---"; it is in the commit message (Stefano).
>- Comment changes only; not rebuilt or retested.
>- Link to v2: https://patch.msgid.link/20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de
>---
> net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4f9aa9c4c3aa..ffe7cd93463d 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -714,8 +714,10 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	atomic_set(&vsock->queued_replies, 0);
>
> 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
>-	if (ret < 0)
>+	if (ret < 0) {
>+		memset(vsock->vqs, 0, sizeof(vsock->vqs));
> 		return ret;
>+	}
>
> 	virtio_vsock_update_guest_cid(vsock);
>
>@@ -781,6 +783,14 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> 	 */
> 	virtio_reset_device(vdev);
>
>+	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);

I'd prefer to move this before the virtio_reset_device(), because the 
comment on top of that is related also to the next steps (detach unused 
buffers), so having this in the middle is not really readable.

>+
>+	/* After a failed restore no virtqueues are live, and a second
>+	 * del_vqs() would free virtio-mmio's IRQ again.

What will be the issue of freeing virtio-mmio's IRQ again?


The rest LGTM.

Thanks,
Stefano

>+	 */
>+	if (!vsock->vqs[VSOCK_VQ_RX])
>+		return;
>+
> 	mutex_lock(&vsock->rx_lock);
> 	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
> 		kfree_skb(skb);
>@@ -791,10 +801,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> 		kfree_skb(skb);
> 	mutex_unlock(&vsock->tx_lock);
>
>-	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>-
> 	/* Delete virtqueues and flush outstanding callbacks if any */
> 	vdev->config->del_vqs(vdev);
>+
>+	memset(vsock->vqs, 0, sizeof(vsock->vqs));
> }
>
> static int virtio_vsock_probe(struct virtio_device *vdev)
>
>---
>base-commit: 363c8c79220d0db4d65dcd570529ddda15067cb5
>change-id: 20261001-vsock-restore-uaf-send-1fc7396fa1bd
>
>Best regards,
>--
>Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>

