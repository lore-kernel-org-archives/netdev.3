Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826CC3C1D60
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486946; cv=none; b=CJBehws9tgzLY6xOKfRFL4gzRfHle3v8uaY/6b8yHeMPkgnLX062Uo0FT6PBXvl2HSR3KhisRUrWTsWFOytYy3YkLFNXRNNWQA20s0ptIm1M6Y1kCN5oOlIOqxUK2DaDdx2fzeAEtbKXpSpASfkbPNliGJEBQ7Y02o1IKJqBTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486946; c=relaxed/simple;
	bh=E+BuIG99Fs3gW60ZhBJoousphtXqpfMPQp9AyvW4hbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ17ZFj2jtIbFXIcOfbk36E1pqLxsNzQxJ+Tt3dpeC5IV5S67XyqGD7w4Qmm8+InU6k3s0Dus2S09nR9lKXKkxdo3uzDdAaiGR1yGtpuLo5ZyDaODHLBnDhX1SUvh8eXqN0v/NurwFH6F4GB3ZMUrQUmv1BFuNaViOjCWNNJVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBImNUlx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlOX6hOI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBImNUlx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlOX6hOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789486943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=piCn16bJNZqtD+Ea5Vr8Xw4q1fEfx3gnyjZeao+goZc=;
	b=ZBImNUlxy4KUCU2yjvwB/Rt4PBRKXQZkAMDSxt1kADpnGUZgFqBeVs4QWsES6MPI/Jmhaz
	3qzmfR+PNeP1LkDoSau1JixnGu5/WBbr273u9mH1ultGOkWEJjuXtLnJBKQQnGkJECQ9zA
	l1/ygDO5MtfVNxshu9t4X1SEUnpNivA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-d8bkigc5MD6_41lidYOUbQ-1; Tue, 15 Sep 2026 11:42:22 -0400
X-MC-Unique: d8bkigc5MD6_41lidYOUbQ-1
X-Mimecast-MFC-AGG-ID: d8bkigc5MD6_41lidYOUbQ_1789486941
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e823c4868so4982325e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789486941; x=1790091741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=piCn16bJNZqtD+Ea5Vr8Xw4q1fEfx3gnyjZeao+goZc=;
        b=DlOX6hOIOTQudbeylDTBlu/1eLr9D/e5UdJ9lUKctUFbOHE1dWtRspL03jEZThfnZK
         2r9x2G6W/KEs+Taf4kKG4JW04VUulVg06CzD60FHprlShrmlQBgygtTPIfwi23cu+CJn
         WUXykqvUdumij86ZGAFuDTDMOhs77zJSQAgidBG6cAb1/40T6XBMmY6L86zK1nS9NZqV
         X7NqNE0mQdI+pah/MqDGkf1n/BO8uRmbebbrYyS6C9PwdtL3QxWpVsw2vj2cdA83uyoB
         aWY+SuOz1WLFZy8WQ00FwStPAcp3qcZk7ThKX4P2+r9UYRi5FJmngKRxfMQeKB9amC8G
         v0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789486941; x=1790091741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=piCn16bJNZqtD+Ea5Vr8Xw4q1fEfx3gnyjZeao+goZc=;
        b=Y95zxReinmySbocMkI2e2ga/oRGgAdMCjB3tWWrbuxt03Pc8gfzNKreHLMvXQQVp5Q
         7pWhXbGBBSjXSQSN/WWHebBOjtW8l5IdKfiQqpFe9QW48TYmafiK9agPL76E8WyodkC2
         KPkGDgX6lKb3OsgMPZdOCRK6SSz4GZUg6+BuSslC3wAh1hFJpOgag/LUYCUrtaBlPr1+
         K4nECNR0+XZd6kUc9VuDX923e2lEitcCiY9haSVylBXqX1+Tdwy5rRPZcOGor8RdQFnN
         G9KdCwC/I8ARuB53Sr1DMaXNRfNmBQm+XS/lCHJx0cFpikhRqcfo+nnfPBOfo+iogbr1
         IlWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDzaJvguUo1E4Hvvyf+ZqXXefIpegAj65eJCYQDvjOoyeT4dAnPS+ODF3HGByOuvW63x7OOe8=@vger.kernel.org
X-Gm-Message-State: AFuF++nrQQDEWIo/3QhcMQhzKDS53DeHk8Bwu2e/AQ8tpQ+Fj9+FX/5U
	kKtlCpzJjvbr/evgeN8f7n+xZBUHsS99w4Eoq3gTcl7byArqwXhF96R02pdgmDZsknH4/Qf6DM8
	Z1JXEW+ni/sxMa2BkoMaLOVg/hiTYkvGl8AIwem2hL4Nm368rOxlvXzta7A==
X-Gm-Gg: AYBFou342cpa4iZWcIlSL0XOq4Ll+K7dB4xTGqK9z5/4Hopt5Ig/TIuoXrmunIQJhVl
	y3GdIo3yFV16xMv0LpxC+U9zq15w3mFxfBcGart5P1k87a6QKgDRcycjHwpPYkZPGosp1qY+7p1
	TGLtrjEKQa82ZbxhhgAh7V+/onG52uwvGMrJ6vw2rHPvhfDsGN3S/ASNgB55ljD3jxOoXqYt4Lp
	wE5fwJkD5AM1e/5ih7mlBBxE5hY2SmNMnq6aOZlIkNBFFQLmJXl7oynn2J2EHQYuEy4nrO0Ct/W
	VxGb+dOIwepss1irCIeMvAFgvp5lAqkrAfJgbKT8lNBstb7v00gdceYIznbCFLrPtg92wTRLXTL
	hrcDbDse7G5cUl8ZcKmFDsY2LzmCBVcZf5J/CPNFB+Z0ocg==
X-Received: by 2002:a05:600c:8b74:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49e7a658021mr197081105e9.1.1789486940765;
        Tue, 15 Sep 2026 08:42:20 -0700 (PDT)
X-Received: by 2002:a05:600c:8b74:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49e7a658021mr197079685e9.1.1789486940213;
        Tue, 15 Sep 2026 08:42:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870b39ea31sm949332f8f.23.2026.09.15.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 08:42:19 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:42:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 1/6] vsock: constify the transport in
 vsock_for_each_connected_socket()
Message-ID: <aqkcd_oMWK-QtXWQ@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-1-9995383e9a8b@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260902-vsock-guest-ns-v1-1-9995383e9a8b@meta.com>

On Wed, Sep 02, 2026 at 04:00:47PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Allow const transports to be passed too. The function only compares the
>pointer against vsk->transport, which is itself const, and never writes
>through it.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/net/af_vsock.h   | 2 +-
> net/vmw_vsock/af_vsock.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

