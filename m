Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD953C6A27
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579059; cv=none; b=AAigrvhQltvRScxdrhpOrKtTXz5jXId+ZThzrQGMPPP81Q7rZdziIY8rj4RJcmgm+gXa3YiZZivZvIf7LVKQO1VDZNFQrKVs9SdhUVhynpekTIRTp2y8vgv28RE1hWwnYG2jWuA3AFRvfu4IrpuhVcKp7M3O2N/FNYLbTyKL56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579059; c=relaxed/simple;
	bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsPZ+NZqqk/gpw8LfN6o82tAfOkFljroou1ld04H/uyQSotP8VT6WAdAD6rsuFQMzp4edqW0eczD4OD4X/x1btKOdp2ykgrlo37G3FJni2SABuoRyInosXUdd+oI7mTUxZ1wunj2+6P9D6TIwH60u2kZdq2hE+KGJH38hkLPzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3y6/t2t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0dOqWa6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3y6/t2t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0dOqWa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775579057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
	b=N3y6/t2tD8od+9DHEOxIH6+crqez0e1gw5zLSZrv4844z4fjikjBvxK8UahbUdkE1x1h8Q
	JKaAoPP9Nd0rJPev0PxBtPqcPXL8EkpdcFaCTWpyTWxx+kWJYhJGVfG0Hlj7yYY/2nQaMr
	Slunzd7e1TdxpJWuNzkWDf1zrzULB6g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-Pyvi1AFBNpKCD2Zh-S9A0w-1; Tue, 07 Apr 2026 12:24:15 -0400
X-MC-Unique: Pyvi1AFBNpKCD2Zh-S9A0w-1
X-Mimecast-MFC-AGG-ID: Pyvi1AFBNpKCD2Zh-S9A0w_1775579055
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488b966e9dbso10116755e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775579054; x=1776183854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
        b=F0dOqWa68hvq1b6GqGUJspT/UnsoKX2qPPWMDnrnlgDu5G0klSecMReVPwXzUKOPlh
         dB2Zdg0wkFXPXnLUTxxNleX5afsLmfgxBHOvvzEEIaOAhJYfDY5zbgkUyoWy2sqD7b0M
         DMXegUSEM6tWtQiUe4EMmww68irm3gy8TRrTXgFLwNkeaW/9idBSEtHOQW6Ou5oosG9x
         rJcApJH3OiEjaSb8MfPREadtKNNOpnTLYTrX6qXuvKJF1cCj4VB2wOU9zlcc0rs7o+qe
         48DwO1fgjw26eqvN3Nvs4D/5OYFCWBvlvZnf7SRSvqrGQaCKSZQr5tImRegA6gE+YN2H
         3Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579054; x=1776183854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
        b=Co4EmgczEol8xOzBya/Ghl+VDf86LJgWh1kXcq/jSCHmxZbUbBA1frF57qyjadzyTC
         /fqOu1B0MPWmDhC+xoGovEqlAZvsAWwlcafTl1S83yVsdDB/IxICuOS/7Xm1MxyJ86Zg
         L1dJTkzzqgzsXrlw+Y6RFQoT6nrtpAr1xKELZkaQ43u3O8jqB6OvBv7OTGwIeaNfTdzx
         A0rKbgorVN36nX95dkJ+4I1QhAbb1yF1btHFlwqNwQOFL8GhLJKhUdnGrS9Pfa52gaum
         QNNQ0L3vEuBCFtp8xiwrbwjCx/jMJm7ZTDVLzi/tDY8FgOC6Vm0WGtuNEB9f+M9G3pPU
         d4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXEykFjUCRLOgDAqHviikqF3YgHj4w9ff6W36q+WiTZqerbiZ1NKGcf9Gfta2MbY3WLhuqC0Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHjvnqqmqTbsTf52r6IkoNVE/7GPqI11Cd8KocL2inR5TqOCa
	VxeDI/IPb0ikqDYEmsAv7fXu92vKSPzVZ/lxZtQe0zR7zquj7eTrwHOBCg6CNwdvJ+33Hx5Oknb
	QkBIAebLfws9xTL2euqIDKTpHB5VqItbqblibMFcOESqUmakAXGnZMqBlVQ==
X-Gm-Gg: AeBDieu++MjO84qNGkXCG3HLlPObiehlEWnNgNahj+o1Pv3CiGsPjVDEkuIn23Io/te
	TYsIo71X43sc4mRhRxI/9aKiL9obUt26KxMFE0XE7Io1IWqv1iQXZNhPf8vuKwtSyBp5vEvgvUb
	AYmVnZ0N1hiNPtzXWA5Ud7eD1R60+pXIwNPcUufNle+u5qX1+QnOc0FKAMUtgqL/TLhyz9BU2jo
	q79eq17T/MCpRBznBHWYIQkpevlgZYXYctZv5fnRW32ad/OvA/VGKmtslAypKcUaTQBKn5U27fH
	6RQTCSh7rnmdXMuyEsQFfUY4EVXdyHjFLdiCSOJ8wbwGUj0eLSHauTmMOv4bds7PDwE8qBkJDyL
	wojQ1fk7+EEFRa1tMCtvE0VFKW1U=
X-Received: by 2002:a05:600c:1e1c:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-4889978da83mr251016195e9.15.1775579054549;
        Tue, 07 Apr 2026 09:24:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1e1c:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-4889978da83mr251015655e9.15.1775579054035;
        Tue, 07 Apr 2026 09:24:14 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm1043018385e9.2.2026.04.07.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:24:13 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:24:09 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adUvaIOLFcmC7tgt@leonardi-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
 <a236c546-3a0f-4690-8ff7-ff8934db0539@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a236c546-3a0f-4690-8ff7-ff8934db0539@salutedevices.com>

On Tue, Apr 07, 2026 at 07:16:24PM +0300, Arseniy Krasnov wrote:
>
>
>07.04.2026 17:31, Luigi Leonardi wrote:
>
>> `virtio_transport_send_pkt_info` gets all the transport information
>> from the parameter `t_ops`. There is no need to call
>> `virtio_transport_get_ops()`.
>
>Hm, one more suggestion, but not in this patch: may be we can also remove 'struct vsock_sock *vsk' argument
>from 'virtio_transport_send_pkt_info()', because it is also included in 'virtio_vsock_pkt_info *info' ?
>

Yep, good catch!

Thanks,
Luigi

