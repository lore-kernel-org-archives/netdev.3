Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792477859;
	b=dcK7QmM3UPEiFgWBqB7U5TR+D3ZhR4GjenJu38NbwTBkMjruX9MYBu2w84yS5/pLtOVD
	 Z8znLGn8I5WnrAwYXl6Sgz43ygHTBgxyzIVo6218ZBCooyafPG8eppT+/IMCCVfZ4/SXf
	 uha8bgKs7PSsl6m7Q7b3vlrIYUgZGj92ItXrM3jYhyGgCxu1ZWnOFsZkcDItQqNmpSjvi
	 bd0rJMgent1EL/qlgwAs2YMEj9I8LpQ+zqPn+AeIAM9NS21ioT2qUY9SRPmZ9QkUG4cuv
	 FH41m+aX4OaxtbTWXX09FIT2XI61D5yhUxbZJUGb56b8+lLk8Em0pnUxjycgpLpLM8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792477859;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
	b=5NKH0Ci415yKUynml4QphrJetaw7EIWZfUxtmG5HAFVshrCy36oX6xdpteDOLYBpKRer
	 A59SBeqPKrR9XD5Nm7dZuZcf6pkDPQJ5u1cX1kMQ4DzjJb0DxHb44a5Z/DpZKKCbDSAeh
	 nux3Uq16sZ/+GnZkW0Bq9awbHzOeE8D4LxLOy6oq1SGKW5gwqd3HIkaC1DCN/+u35y3fH
	 9QeiAMb2Nao0MivmsNYsautoikQabrau3WLh793/Xe5iWPdM2+AlzRF+dECxkalc8aNoF
	 PyhHobINgjJ80/tmueWAdy8KDHkcWHZBg+5KLwrlFKsgCejgvYm5C9E4fCbiLr6EfRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XhI7KWPz;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bE1fQ0Xr;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D860606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D860606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XhI7KWPz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bE1fQ0Xr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792477857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
	b=XhI7KWPzn3rZCb7U5nGPq24YgfwALBIyc3VjY/9o3Mm3jgozhVCI5xokUixdbPffByC2gL
	/5gUIDNi716A22//Id5uGaIw1u+tZ4RtIQK70eLW5UtwOy6UpMT9mZaA8pvK4PyOYI8t7z
	zPyJ9AJ5JNxujgBKvdCm8SEqJAtFdBA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-NVFvRMU5Pha8pfbnHEu0Hg-1; Tue, 20 Oct 2026 06:30:55 +0000
X-MC-Unique: NVFvRMU5Pha8pfbnHEu0Hg-1
X-Mimecast-MFC-AGG-ID: NVFvRMU5Pha8pfbnHEu0Hg_1792477855
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af5a07314so1844480f8f.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792477855; x=1793082655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
        b=bE1fQ0XrrD5SciDTZcprPRRyeq0XAd6kEktstG38AewJCDrj+CUEcPPjJD8W30/XwR
         cesprwjN5c+0+Ihm7zm254TEOFmoENhQn0mO/WcBQgVvxB5WTPsVQ3vAZ1YQbmg1ln2n
         Cx54Vv4/D9K+nt1UFo4g4A9JszwKcdGnVvG/Emxc7TwVPEHirfmZxf8FflLPYegfKher
         YbxWXtQ3FE7+uBv0H8M0zigK1n0K6VEOQMSUsVas9zSM3qhrTu6/yHfYwblE7mUerp+7
         uqYwW0eD04cI1RCR9ZNhtUh8eJQ0JT9wBhDI7YduUqxyDrPnuagnlcOk4IFhOduF7k+i
         kpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792477855; x=1793082655;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
        b=MEzKezCxCNI1X2SeSFZgO+8tyrbHx/jMZgSUIMmIZRbfEXYX5awUc0XlOQmGfVJdFD
         QrS2ceI/9+vbaLG98L1QFz67oBdPC6o+g8t0qejblhyZ+eOrUJ1vm7Z7v5o+VM7KFgFu
         JIYw3pxRx7iEIggy1X15EptwshX9DkrsROUcqzT+AJq8BqvC1FMsDv/3bfxsGfxeOK6Q
         EPIke3tRv1u2WazA+H/aPa4l0MCpg/TWJwLt3ZNyYIJovf2yL1Rpq8o+jBOAhkiPaUh8
         2Tx0FtnDjToxa9L3Uxhk28wsaeiCyNeBKohglf0dFn+IRRvQcCW5O8bLZUGE5HT5eJB8
         7Wtw==
X-Forwarded-Encrypted: i=1; AKwUvBxFUL+lITXq9vHqT1cG5ACsnyPgJfXsx0MH5zC9zAGJto7kgIzVZD9FwDGPK0Unq114jIdgpgw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjB9IL4wvPfz0neskS22w8h2p4eRDABU7bRo6wuLnALqsReWVY
	IqqqKu+qZ4NWXmI8hKcBog9xmLUHQ1AdD+6vzUtBE8jYT/6b3J39bkMKbylwI1zc7Eq01VhbTRX
	9biyhiFMFBUG7YDxS+StIig+00jVciTjXf/RChkKequBHTOWIWLiiYad4Bg==
X-Gm-Gg: AYBFou14QkZsZHILfKwCnMJ29eU58fQ3HP1W+a0czhMdXLTciBGyUEOmyyPnMzvL19v
	CGt8C854RQRekZwpuSUFAb+J5rx9hL9VQmzBdpZfsbduN4jrCFkMIsgqXBIu9o1yj4gGs0ISfcz
	vKjprewGymd7BnDgILI+ABdakbCukDcnbKdY9zorGl8R5RU/438UBn7JK2vkWgfB+eKzoB9CeDS
	NcparbyN12FwKzJsLEBuqk1Lx2pmHStC45+CEp3m6cSw0RTjzDzKjpOs+iVw5FDwRMW1s3vOpW8
	c/9zRkVNuDESSavSML4TcbNTCfoMYOqhTEYTtkQW2RoNmVp/lTR3YY29UhNYlBU0+SFfUw==
X-Received: by 2002:a05:6000:1887:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48e07978bfcmr21309158f8f.7.1792477854577;
        Mon, 19 Oct 2026 23:30:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1887:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48e07978bfcmr21309119f8f.7.1792477854028;
        Mon, 19 Oct 2026 23:30:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8214e1sm3912561f8f.37.2026.10.19.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:30:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 02:30:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: torvalds@linuxfoundation.org, jasowangio@gmail.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020021924-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>

On Mon, Oct 19, 2026 at 03:14:46PM +0800, Wang Haoran wrote:
> Eugenio previously offered some additional suggestions in reply to
> my patch email. Should these also be addressed?

The following seems to work for me. Testing would be appreciated.

From: Michael S. Tsirkin <mst@redhat.com>
Subject: [PATCH v2] vringh: use get_user/put_user in the use_va path

getu16_iotlb()/putu16_iotlb() pass the address produced by
iotlb_translate() straight to __get_user()/__put_user(),
without access_ok checked anywhere. Not good.

Switch to get_user()/put_user(), which are always
correct, and safer.

But the fact is that accessing user memory like this
will sometimes (rarely) race with page being swapped
out, trigger EFAULT, and it should be retried
from a worker, and vdpa_sim currently does not do this.

Fixes: 42823a871fd4 ("vringh: support VA with iotlb")
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Notes (changelog):
v1->v2:
    Use get_user()/put_user() wrapped in pagefault_disable() instead of
    access_ok() followed by __get_user()/__put_user(); the helpers are
    reached from BH-disabled sections, and __get_user() is not a valid
    way around that (David Laight, Linus Torvalds)

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 2 ++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 ++
 drivers/vhost/vringh.c               | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 76dd5b0828d7..325ec8f0ab85 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -347,8 +347,10 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
 			smp_wmb();
 
 			local_bh_disable();
+			pagefault_disable();
 			if (vringh_need_notify_iotlb(&vq->vring) > 0)
 				vringh_notify(&vq->vring);
+			pagefault_enable();
 			local_bh_enable();
 
 			if (++reqs > 4) {
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index a6514b5ccd86..964cdf422467 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -77,8 +77,10 @@ static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
 	smp_wmb();
 
 	local_bh_disable();
+	pagefault_disable();
 	if (vringh_need_notify_iotlb(&vq->vring) > 0)
 		vringh_notify(&vq->vring);
+	pagefault_enable();
 	local_bh_enable();
 }
 
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12ba1..74836eb60c7a 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 		return ret;

 	if (vrh->use_va) {
-		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		ret = get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
 		if (ret)
 			return ret;
 	} else {
@@ -1251,7 +1251,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	tmp = cpu_to_vringh16(vrh, val);

 	if (vrh->use_va) {
-		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		ret = put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
 		if (ret)
 			return ret;
 	} else {

