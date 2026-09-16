Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0A372ECD
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561725; cv=none; b=l9EG9MgUbXxvaCTi1lNlhh3kB7EaeprCcRCJSLOwj3VjtZpBqO4vZsAFPDEDOfTdffcm3+VbvHR8Y4Zxcg8opkmj81XimX3G9nbS/1MLp9oVVT6Z1AnSFhKOa7yuAMg2zwqJPk4HNgCz9F/0OD6NRtXm7kK6T0JatkLIYZrY0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561725; c=relaxed/simple;
	bh=xl+U70fbkUqzVeG1dKiFnh1LU4j3E1hpm3qW61N6DYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwDHkRaV4V4glUcgh2n5N0/HvNosArf9beCvfgZW4kDBNcohvpmVQY0Jpn432lSJMZODm80F7+KGjnfWUF52qmYNkpGBA/gcAmUhqm6zTsnPU5ASFuQtoUeH00hRyLg2mLhfJ7KugtTgWjKE8RiQW2YvzjWTD8/3l7PdJ8emSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL3lyEyR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmLu0Llv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL3lyEyR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmLu0Llv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xl+U70fbkUqzVeG1dKiFnh1LU4j3E1hpm3qW61N6DYE=;
	b=fL3lyEyRgxo8EHOTAo8CiomxsMnS1L1CkvBtgtgTM2MkYSt667t4fhwyixWHaEmMgNr+VN
	9gdKCmCpoZzGba4Plr2+Mhfo4Y0wMZO1OREI3MWv+ew5VpMpbBT+dq6e7gmZeGxTQW8vnp
	/QWwRfWEI8stwzLVM5ND0oAEPDErnCU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-bp6FqJxpOtueiQ_PzwL6ow-1; Wed, 16 Sep 2026 08:28:41 -0400
X-MC-Unique: bp6FqJxpOtueiQ_PzwL6ow-1
X-Mimecast-MFC-AGG-ID: bp6FqJxpOtueiQ_PzwL6ow_1789561720
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso51409465e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789561720; x=1790166520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xl+U70fbkUqzVeG1dKiFnh1LU4j3E1hpm3qW61N6DYE=;
        b=PmLu0LlvrmLJEt/TDCQbxgMR9bW7qo5UUhlySx/9fcdOjTJ7tFFL0WTNdz+r0449vA
         ILc2/Hmy4fMpRS94j/ROt7kPj79jGIH4h5g14sOhOY2kQ4uQpqF81GK+M+IljxD8X5JD
         ekuI0M15WLlf6sftHGVoKYCnUQnGgJHVIAfCxQv/SjqZaTyIr5TEitKds0BahNY7dJxF
         P9fvSMpiSLFfYPpgVz1ENq1ieeQty78wk3shwUOt3Rgc9Wq9F3qgnLX5tLskuT9s7juD
         JIL9wl7z/VM3TUyjM1kCTcIZmYeeG6VeWRnDjpehVcajIGyBFqN4rzj3ZJ6UCT7kAGhR
         aN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561720; x=1790166520;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xl+U70fbkUqzVeG1dKiFnh1LU4j3E1hpm3qW61N6DYE=;
        b=EdW3gmZEdvihrjA8h6mOIItdFnqqNbBX8Zeg2TKcsRh8EjdLGk1v1A2ITbzkXM/yxY
         nNadkbBq8ARCS8ViI0d1kIQwGsuJfk9M2o9bfMbKyn4Se6t6CnTbOQwp5SZe5xvC/b2h
         KghFs1RTjCOhgI7Hq2rnWz9BvnElEE5NaAD/D9Yii2Ov9hb/gLXPB9eoBr/9bp7tC2Lc
         P+rYEFHX84/0AvXu60L78Qq/nUapE/Cg7erRndJczlyoVbAtVKv8L4JhWfN34zflS0lQ
         itKxp59jJii8G9+P670duKyEvUv/JvN3EJ2bIAPvFcRb64jBjJBHO5CsAsHJxwgeSB2s
         lIGg==
X-Forwarded-Encrypted: i=1; AKwUvBz3H+QWgQK5pRJpPsDKh4bHgMnfPmoJcBB2ONp9MS3CX6Pk+DqL+1ivx/JMsJIUf6sTnfUUNBY=@vger.kernel.org
X-Gm-Message-State: AFuF++n1k2NA6l+y1A5ZNXQS5zZObBpD41TwHVHMdaRlvHR1u75ak2uF
	8V4roqiAPEk6Ca3PyNGBo/HH3G8Ud5kG6NOPQ18Lzj3+eD6YEtDZk4/2PkzCMDe71vVzPvyvH3g
	eEf6hxvnxOlgJzB5nshxZK36YPGvBsVfEGzT66BmTFVUqtIQfk9yTNQXqQw==
X-Gm-Gg: AYBFou3EjJjHSeYl4ZFMr9xsdw16xjnarP1CYBG0cjifXdrqgEEqHTO72DxWguqbaTF
	1V+15zu9p2lcyeirCSHDCLaA+Zux6XRjVR1FKJJQPQdcIDLqCRPhkAgXwu+jsD8uAFtAyL0o6ZS
	75b/W/ZPQXcRe9AquQYwaJm9eHklxtEWlDAumJRF9evHxeQa4250978mwJwCqVKeYJ/AswN9M7y
	QND1uyq49O+vFjCRkNoZC9HadmtVU9G/yL4Avnjph9IVjUHpEKaJ9mEaW9RUg8VyVB840joTpNM
	NTvUFqncP4XqPQaHWcy5W5LZzO3+RC+nJ9AIOm2hJGBjE5Bz1EFVhSlGXbL5EIeFaem+r4oSvX0
	oqTXKh6P85Z1zBMqxp01rxUbdo6nz2baL36cfLuzCBIZlRg==
X-Received: by 2002:a05:600c:6592:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49eb7326586mr62422955e9.9.1789561719784;
        Wed, 16 Sep 2026 05:28:39 -0700 (PDT)
X-Received: by 2002:a05:600c:6592:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49eb7326586mr62421665e9.9.1789561719193;
        Wed, 16 Sep 2026 05:28:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7642sm6490127f8f.5.2026.09.16.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:28:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:28:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vhost/vsock: Fix socket state constant
Message-ID: <aqp2w_FZlZoR2lFY@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-1-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-1-a1d9abb472f7@rbox.co>

On Tue, Sep 15, 2026 at 03:15:12PM +0200, Michal Luczaj wrote:
>Refactor under Fixes missed one: SS_UNCONNECTED (1) -> TCP_CLOSE (7).
>Until now, sk->sk_state = 1 stood for TCP_ESTABLISHED.
>
>Fixes: 3b4477d2dcf2 ("VSOCK: use TCP state constants for sk_state")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> drivers/vhost/vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

