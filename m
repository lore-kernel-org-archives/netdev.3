Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F13B4E9E
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849876; cv=none; b=b1Fu71zxT+Nwh2EDi1EqQ42f0+4yxS4+yWrY4QvqJ+gAIoewQXjmA7hphaedDDBSEqutZsXcPwYrQuq/0FLRFXXT14qetgVePrwH1RTSsiI83r8xsR0LQ66wZ72V08XVLUT2LNeMzgXImlAO6BAMx06CnKEA5Y/ha7PEQo1IDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849876; c=relaxed/simple;
	bh=dUdFDVqTzQDPNI8dPEkhLuVWoA942/H4IpUUxhUFDEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXBxG68p56mpMhZleFUX4FSJpotsqPn7bQv12mfrXsc/40xFbul04DnyisBlj+qOrlXCAWMPiLTLGFx/nHcve1U+YMqAA2zX+gcwBM0T1UlG2+15dq+mK27pZXn5BE4sk0hLAtSnheviSX6PnOp2c2P5wlSlkjkHBrDn6palsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpJdj8BT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pkeXGRvO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpJdj8BT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pkeXGRvO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790849873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOthZx3yTwvPTr4Ura6Gt3ofRbmBrIyhkJxXxQE8kK4=;
	b=FpJdj8BTpgcLMKiQ6s9hUY3IRkV2A/hrOJIQ9NG72aInLkViwQws7sh5Dzrzsg7x7ODNKC
	gghqzJ2UFQ379uQVKDpydcgf18xyql0g/H97a0kkMYsNIQ2G61yPZlV0mx8LVGWQg14+be
	NpoGtBOCR9Gqdk18TmBS9iHxNZAcSWk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-_fDyJ5_zP5e85BMmNE8stg-1; Thu, 01 Oct 2026 06:17:52 -0400
X-MC-Unique: _fDyJ5_zP5e85BMmNE8stg-1
X-Mimecast-MFC-AGG-ID: _fDyJ5_zP5e85BMmNE8stg_1790849871
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a020cf06c3so2987465e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790849871; x=1791454671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cOthZx3yTwvPTr4Ura6Gt3ofRbmBrIyhkJxXxQE8kK4=;
        b=pkeXGRvOJ/5Db9ngRqFP3f0baQ0cPIghCFQf8L6ioEwixv0BTrHQ5M/70OdpPuJ/LL
         Vc3UeYN+NcupvuMXV9QODKr0IBCwj9k4khWWVufESQNie10HLVZlQheWNx8zHpVKW3Uq
         Ep8ezQO3GwyTEUcQq+aDoXXIWXIiKZnVux2HG16wCrbo4P0sT352rUZXJVCRzQ3wPbUM
         c/gd4jue60FMMOdJjiFwRqJyX1dww1pBTMGTIJTDpu7PxQajrPhO1141YYJHrGLXbj8M
         pPo9551vcWtc1Rbs9sTD9ykuI1EMNxFtqLpNI6Lea6JuwpUArMFu5T98HkWu7DEioPDS
         b71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790849871; x=1791454671;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cOthZx3yTwvPTr4Ura6Gt3ofRbmBrIyhkJxXxQE8kK4=;
        b=cgRUhw1mOyVrHDDRR831ktAd+ywtyFvuEbHPX8qimj9gUFZIxaYXAi9re8vYGzwykq
         BrhQWXgHWSJ/LwZxnKYUrMgECsTj/oVrcwuigbkVp9oogKTftMWbA3ylUhQvmw3alpIz
         Fi6KTp2RlswtZxiih07U7WMxNAOTnO12su3WNrDOuH3ShZqJesWnWaIbJVmzUf7RDvRo
         cdfviTJs3CtYXPa5om2n/oWruf5qZEpfhsLnrBvuB6oWcsnE/eUJ6/EcKqi5YPFQ4QHp
         oNlbS37pN0IY7xqgei51k8mywF4pPvV3RwHBVxWkkKK42PoKvsQ3N9xMeQnH7D/piyZf
         /P5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwFF/1agwhF9waHH7bjh3PNKrhUjXPkuIu8FVPPdAYKQ5uj9m+tyNCDT1r+Gbr77tr/fsaqU04=@vger.kernel.org
X-Gm-Message-State: AFuF++lknbdxFPLGVaF6E3BpXiRkMICmxTzqJhjwcOc7gbiexfoy9s0d
	hOWMzr+SUupeohBxM+oPfYV60pz7H0oM310aon4PKIiznTtg/nnbYPpiHu7k59iqikfvJxYWBIe
	rXn/4lLhlcSe3OnwJNIed2ps/7vNu7TTBCDuTNuMh8MOyvtdvESSVMgNr/g==
X-Gm-Gg: AYBFou107IU6dA4w8ovMJsXlu/0/Oo/ZbA+4FVTTAuq5MXQGqXiv2acYA/T3Km1p6q7
	92c/fw2gx5acurp5IbL3N33iaKke2EdIWQP1nuveoTIjMgtLOkfkS/ym9qxqw/j6zF7DGUFfujX
	QyPtckSwd7xzomTitPy3i+/xOv6SgJGA7PJoiabs20uCp5LaaxLNtMBEPtJ70/frDDJpf1qE9Tz
	wfBgt9QDYNDYfHyl8Xk9f09GezOEewTUWHqqY6EoehMoZkGpjkjpSzJEbw7ituaIrLWoHb6tp46
	G7GWpLPxggrZtrs0gh691LSfDa9sfnepwY3jM7reOoj8HfF4qENg0M9f3UIWLq9AXwHnxMsVAcx
	N
X-Received: by 2002:a05:600c:a40a:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a01b12384emr64730805e9.27.1790849871438;
        Thu, 01 Oct 2026 03:17:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a40a:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a01b12384emr64730455e9.27.1790849870881;
        Thu, 01 Oct 2026 03:17:50 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.112.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690e721sm5651491f8f.20.2026.10.01.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:17:50 -0700 (PDT)
Date: Thu, 1 Oct 2026 12:17:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload
 length
Message-ID: <ar4xDQliGcCQEfSA@sgarzare-redhat>
References: <20260930044147.3818241-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260930044147.3818241-1-4ncienth@gmail.com>

+Cc Will that touched this code recently

On Wed, Sep 30, 2026 at 01:41:45PM +0900, Daehyeon Ko wrote:
>vhost_vsock_alloc_skb() sizes its skb from the total guest descriptor
>length, while virtio_vsock_hdr.len independently declares the payload
>length.  Since commit ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs
>for handling large receive buffers"), large descriptors use skb fragments.
>
>virtio_vsock_skb_put() currently changes only skb->len for a nonlinear
>skb, leaving skb->data_len and all fragments attached.  The zero-payload
>fast path skips the helper entirely.  A guest can therefore retain the
>full descriptor allocation while receive credit accounts no payload.
>
>On Linux v7.2, 455 zero-payload skbs retained 30,255,680 bytes on a
>256 KiB receive buffer while rx_bytes and buf_used remained zero.  A
>full-payload control retained 265,984 bytes in four skbs.  The existing
>SKB_TRUESIZE(0) queue budget caps skb count but does not account for these
>descriptor-sized fragments.
>
>Set skb->len to the fragment length before calling pskb_trim(), then trim
>to the declared payload length.  This releases unused fragments and lets
>skb_condense() reduce truesize.  Move the zero-payload return after the
>helper so zero-length packets are trimmed too.
>
>These skbs are newly allocated, unique, and have no frag_list, so the trim
>does not enter an allocation-bearing path.  Keep a warning for a violated
>caller contract.
>
>The fixed v7.2 image left a one-byte skb with no fragments and reduced
>the zero-payload queue to one 960-byte skb.  The build had no compiler
>warnings, and the run had no sanitizer, WARN, oops, or panic findings.

I think this is a requirement for every patch sent, no?
Why putting in the commit message?

>
>Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
>Required configuration is CONFIG_VSOCKETS, CONFIG_VIRTIO_VSOCKETS_COMMON,
>and CONFIG_VHOST_VSOCK.
>
>The source reproducer is available privately to maintainers and is
>omitted from this public AI-assisted report. It exercises the real
>allocation helper and VSOCK receive queue from an in-kernel module, not
>a live guest virtqueue. Guest control is source-confirmed, but live guest
>end-to-end validation and deliberate host OOM were not performed. No KASAN
>splat is expected or claimed; the oracle is retained truesize and receive
>credit state above.
>
> drivers/vhost/vsock.c        | 6 ++----
> include/linux/virtio_vsock.h | 9 ++++++---
> 2 files changed, 8 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index abed1fbcf66c..fa59456abda9 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -400,10 +400,6 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	payload_len = le32_to_cpu(hdr->len);
>
>-	/* No payload */
>-	if (!payload_len)
>-		return skb;
>-
> 	/* The pkt is too big or the length in the header is invalid */
> 	if (payload_len + sizeof(*hdr) > len) {
> 		kfree_skb(skb);
>@@ -411,6 +407,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 	}
>
> 	virtio_vsock_skb_put(skb, payload_len);
>+	if (!payload_len)
>+		return skb;
>
> 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
> 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f91704731057..31358683e23e 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -51,10 +51,13 @@ static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
> {
> 	DEBUG_NET_WARN_ON_ONCE(skb->len);
>
>-	if (skb_is_nonlinear(skb))
>-		skb->len = len;
>-	else
>+	if (skb_is_nonlinear(skb)) {

Would be nice to have a comment here to explain better the reason we are 
doing this.

Thanks,
Stefano

>+		skb->len = skb->data_len;
>+		if (WARN_ON_ONCE(pskb_trim(skb, len)))
>+			return;
>+	} else {
> 		skb_put(skb, len);
>+	}
> }
>
> static inline struct sk_buff *
>
>base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
>-- 
>2.55.0
>

