Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034348A2D5
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986985; cv=none; b=Gnjk8GSC1w0Q+StJTK8fsVySxk0lzZszE6/4uPwp2jWAMtEgQ/31fCPs7i+ik1vxPN5PRYZDpnBTtoUwvmwpqNFNV4+xfGLhjOPqyFMCdu3bm1e+FEnrbOWKiNhub7gzLkfWs+nQDeauNkHehxg0ore01wdDmB8tf7iNdN6eCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986985; c=relaxed/simple;
	bh=zRZEHeApxChUmVMmM+B39U2r94bmJb8pPMSAEgaqT3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKtxSQlPRxZsT10oQtcFUyh8WLlV5WaG2crw7Tk4iglRG0PpsSMz1Z3/OR4kfUaB4eR7Ik7ZdkK/sAMfjTjL7H8dV4yd3nx7yWdW5KxXuWKapR/oTbw/yh86Knq/DgP1nfsA2XOruJSTTOZLypi3v/txDOOwkF4HLzjQJ7aV/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROnX/d1j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROnX/d1j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782986983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6Hhk+1nzIJyYPt+jQOmzFzwffhJhwBUT6f0cCcOsag=;
	b=ROnX/d1jUuITfpWawVCIihkah13gFUA+GfSh6gkaHw4cJqBZgeFrooaAKOACEfIQDIX5iX
	FCXUkqYO0LOffN4QIKR41OdDPwU2T0SHmmjk/cp2W0fgBPTP7NO5s28GUZ9hD5oESmAZrC
	9gQLKCuRpC2fzHPS1R55YAb2Aglw0XM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-x_S1hojcPcyTy75YGeR8tA-1; Thu,
 02 Jul 2026 06:09:40 -0400
X-MC-Unique: x_S1hojcPcyTy75YGeR8tA-1
X-Mimecast-MFC-AGG-ID: x_S1hojcPcyTy75YGeR8tA_1782986978
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A4AA18333B7;
	Thu,  2 Jul 2026 10:09:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E66118007F5;
	Thu,  2 Jul 2026 10:09:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jk@codeconstruct.com.au
Cc: matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next 03/12] net: mctp: usblib: Move RX transfer processing to a new mctp-usblib
Date: Thu,  2 Jul 2026 12:09:21 +0200
Message-ID: <20260702100921.138294-1-pabeni@redhat.com>
In-Reply-To: <20260630-dev-mctp-usb-1-1-v1-3-86a311fc67b7@codeconstruct.com.au>
References: <20260630-dev-mctp-usb-1-1-v1-3-86a311fc67b7@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: mctp: usblib: Move RX transfer processing to a new mctp-usblib

This commit extracts common USB receive transfer processing for MCTP into a
new library file (mctp-usblib.c). This is intended to support both the
current host-side driver and a future gadget driver.

> diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
> new file mode 100644
> index 0000000000000..9b86eb4310ce3
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-usblib.c
[ ... ]
> +/*
> + * Prepare a transfer buffer for future completion; *bufp and *lenp will
> + * be populated on success.
> + */
> +int mctp_usblib_rx_prepare(struct net_device *netdev,
> +			   struct mctp_usblib_rx *rx,
> +			   void **bufp, size_t *lenp, gfp_t gfp)
> +{
> +	const unsigned int len = MCTP_USB_1_0_XFER_SIZE;
> +	struct sk_buff *skb;
> +
> +	skb = __netdev_alloc_skb(netdev, len, gfp);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	rx->skb = skb;
> +
> +	*bufp = skb_tail_pointer(skb);
> +	*lenp = skb_tailroom(skb);

[Severity: High]
Does assigning the full skb_tailroom() here create a risk of a USB host
controller hang?

Because of slab alignment and padding, skb_tailroom() often exceeds the
exact requested allocation length (e.g., returning 640 bytes instead of
512). If the MCTP device sends exactly a full USB High-Speed packet
(512 bytes) and does not append a Zero Length Packet (ZLP), the USB
host controller might not terminate the transfer since 512 is a multiple
of wMaxPacketSize and the requested 640 bytes haven't been met.

Could this instead use the exact protocol max transfer size (e.g., passing
the len variable instead of skb_tailroom(skb)) to ensure the controller
completes the transfer correctly?

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mctp_usblib_rx_prepare);
-- 
This is an AI-generated review.

