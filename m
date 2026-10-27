Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091378;
	b=iguExjrnNLz3xhD+2g1L95h3hdWz832V1lZHuvz2h8WPxxwk+UNumRKbzLyV7bSncqoc
	 tI+FsgiBOwjYZyQhKnu88bFOPOLcAkbMD7Ne1AOtAql/vq3oH4o0Pl0f9oHUlwFTWUq84
	 eS1MwijGMC9gU4unyMDbHJT21TUonaV1dodHsP44dD4nyr8UE/pfrTpiWbbWJiZqldag6
	 Arr9Io5dp3Nvdn6q29eTrg3UVnH5Q+y7YMNKcGXfu+MyMRWkn8cXqmPSMD5kqYn3ge77z
	 uenWO/g7S2Ljqeuzt0P+Y0F/ucpKyZHvs99B4FHxbaCQ6nM/7dMJSHXo94uVoWYtHuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091378;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HyrhFsYs+REFUgaFVShlaZ9e8ld3lHCKJ+hBUTNdVHw=;
	b=em7qb6hWTb/BBUDLuaXAqAuaGYW4YXtc2dc18DM3lM43ThTPcKlF2W35Elb8NokO3kLx
	 jON1E8FQv2z8jTtlFHod7tVLQdeQ/M6LqpRIrtTV9Idp8mZ6IE8xM+uJiQE55BQO1Vk5F
	 7CDDlsA7Jg4Nq5ogOyOY8+Hp+v9qySbPqSxacD2OhkWASTrAhsM8un9JCOvSLN6pNRZ50
	 elcHV2n3s6oCKhlfaF026bhE5hmv2JsV1Bai3Ape8lZQebfDOwP98pXUsYFAGDXUWoXVt
	 mxfxzk3OAA8hFOo9yFqKTKH8wmUVAaBzxsaSj91jtz1jmdrNox5liSRfMFKXrQ2yW/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XVk4s9uZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hVG4Z9Rz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60151606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60151606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XVk4s9uZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hVG4Z9Rz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793091371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyrhFsYs+REFUgaFVShlaZ9e8ld3lHCKJ+hBUTNdVHw=;
	b=XVk4s9uZMvalsel9zIsIkXhztuP0qeiTnGFF1MpaiHK3eYxJ4pPHA3iWdBu3Q+aLWk47l3
	GDBpFZSekfJZu6hzGTgunFWkEJHCfNagTcqBjfxx5z22Isi+oo9uUXAWtFO9AHbARS2Mbe
	paGP0Rep85wLtTLxZtOQrpE9VMUN8qM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-3HWfM3cnPX-iJEfPWpqZ3w-1; Tue, 27 Oct 2026 04:56:09 -0400
X-MC-Unique: 3HWfM3cnPX-iJEfPWpqZ3w-1
X-Mimecast-MFC-AGG-ID: 3HWfM3cnPX-iJEfPWpqZ3w_1793091369
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so35958985e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793091368; x=1793696168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HyrhFsYs+REFUgaFVShlaZ9e8ld3lHCKJ+hBUTNdVHw=;
        b=hVG4Z9Rz1dB6d2izFFKRdGgemqvVFgxclc8HXtnYV2qslRbk5JEoRgmgyoDLQ3nVMk
         QaRuB06kOKz11LulRDJJakWKTgz4nNHX9I/FAjilMQh84UQq/8cWaecyRxnKBXpFQmUA
         yCSqToXeTLfUL7S/qHJQVeXcDi9WkcZgDezn7vgYdjEQUMEFFX+ai/+UaIG3CbhEBKeV
         ow7p18V+l46aMX+JF/DzBSPSaQVtzTGaK7hQ2pi/hrVkcXE+w+RycqbL+hVqqdpFR2pW
         328iUdS62GzahwKB2yvRmHPutBubbZJMoKTYwsAolWfYG1wy/EyJ3B5MMScmf+AZaF7k
         qjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091368; x=1793696168;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HyrhFsYs+REFUgaFVShlaZ9e8ld3lHCKJ+hBUTNdVHw=;
        b=eOmn+xLOZbgExaN2ffqagDUc5rqkR+ZNenYo26V3UJ870yohJq51GtUCpAFrsS0RJm
         FJXEWAbUb20h8sG+K1QiFZ5DNE0ttiBsmig5KtWPPIszpFWSvgG9El7VHKKd6E16Y4CS
         yNI3vq6mS4XJKDxwhhWnYe7aJon8Fk5XGRvwc0bdzaxLK1BQpt09MwChmmyuoBFaLmSb
         jIWjZefinciGmavonpW6nXk+iZZjBPybBP9d9B7/cQMwJeWL1aFuxjq31UFfZGwPp/l9
         PsGpbdP/ID1avSMx+y3GOlUl3S92exkcafy1CMxJoEW82kWUfju5YgqLNL+aQqkGv1Rw
         Djug==
X-Forwarded-Encrypted: i=1; AKwUvBxZajlZb4qs3x7Psf55cFZYMQX59g3724jS64QYxTWyMa7k1eZDGDZBoKz7mRXkgQLtaIvriUU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYvW6Wvz2DctOs7wS5uK+w3iaenGRqyK9QcD15Mh0I0F2h7obZ
	8E4ZoipaXROHvZEC3p1eyDBcdmXvc9Vnf2UWfFks3hNoBJL9kITsH2M83NkO9aoqu5M43Vo5MGh
	JmXVEPB12/HnzI8wxlOlc9fWhlozhsKJO0zoDbK/LnAJ49YFG5VdtkMDzow==
X-Gm-Gg: AYBFou0y/dRDdyoGb4vup9UZpIlt6LdCSl8AnKdWZNv3hLJjCdDSoERFuNUIbUWHn9q
	j/2c8Jj5UQH7ypr1mFKDzhh+ZKS+KOeWcB893BgwocrSdZZZByyYRb0j5n9TUeMx+bSeXtqqssL
	vmPt7aGkLKvB0yc8s39UevdVxRxWD1Us61GeiQXxbfZ7vrFmhK9soBocUKPn2t0iNssvKEW4uLZ
	4z1DDe2HBqe5o0+oZfF7JZd9MPJLExiZ4a1hf7Tb9p8GR/MSNW0RwpGKO3NGZHtFiMUxzNI1Mpd
	ehjtRh7a3tXe8PGgZJ5WoPr/Izz8UhTGzUgsvulBGZeRycSTMV4cs4x12sNnXxcm3+vbsTgNVFS
	Kbjmt5NVQPJaN9k0xO6sltATyc/EE4pEHbDH8cS1PrLdEEWGcu/Rq59C+yMHIt7km0WpUlFV5YQ
	==
X-Received: by 2002:a05:600c:8183:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4a35ac9d234mr149428965e9.10.1793091368568;
        Tue, 27 Oct 2026 01:56:08 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4a35ac9d234mr149428265e9.10.1793091367861;
        Tue, 27 Oct 2026 01:56:07 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ae28sm259883715e9.2.2026.10.27.01.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 01:56:07 -0700 (PDT)
Message-ID: <a3c08b59-7eae-4a1b-aa0f-042abe024525@redhat.com>
Date: Tue, 27 Oct 2026 09:56:05 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net/mlx5: DR, Fix out-of-bounds write when sync
 to HW fails
To: netdev-bot+sashiko@kernel.org, tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, netdev@vger.kernel.org, acassen@corp.free.fr,
 valex@nvidia.com, erezsh@nvidia.com, gal@nvidia.com, igozlan@nvidia.com,
 kees@kernel.org, kees+treewide@kernel.org, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, mbloch@nvidia.com,
 moshe@nvidia.com, prathameshdeshpande7@gmail.com, saeedm@nvidia.com,
 william@theesfeld.net, kliteyn@nvidia.com
References: <20261021074949.3471704-4-tariqt@nvidia.com>
 <179275275762.3134.7548579754182364985@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179275275762.3134.7548579754182364985@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/26 12:52, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] After a single SYNC_STEERING failure the pool latches into a
>    permanent error state while allocation stays open, so device SW ICM…

This one looks legit.

/P

