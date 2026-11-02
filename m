Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640613;
	b=t/F2a19/oAlhu2MasC6iOnDWoqvXd3M9tiaIH4rbINMZ6rz386qxCsm/M6pB9i16Pv+Y
	 zixGUDhRUp8hZ1aj+lxCN0VW3nIWyGitWIgFMoqDexL1ipC8oEZpdOnmbX4Qtx2zJBivO
	 QbUDggskGocYN/3mqPyxMeW9+F7MvssHaLBHHg9Dt29faCtCqwRojKgzTdzCk8B0ebSsQ
	 O/2TI/phqJeQjebhbNGMFpbKPhHWLsiXY5R6kJkreNd76n9YhZyqRPP49f/o1HDXBiA13
	 WlKuHIqNwR1iwrzO/dRkz6Ymip0hC26aZeeF0okjoljY+InGAruO+30ya/FM/qSfZTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640613;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
	b=NYVPKgkve4yAI+lTfsDYYWXIjpuK43hYWX1wBttQ/Hz0bSK63xTgRELg2oRyKEV4CR/C
	 r1jknKaDOdFmhYsIpw2wn5DzPCyE9CHjpoVVtI+KUPK6TbJ9ukM2Ma56Wqs98sQemtWBH
	 mT7saE4ZiCpNhm6FrOwhYgOZY3NsI57G4xuNrAwT1JIFQUeriXGxRyl1M9IuSqZsw1sk9
	 1abKrT78aKtu7ieNJ3QkgdUBRAtA7dosCBMH7iMDFiIwy1z9ZKZIWYA+AgW9ZfUQpVb2q
	 a6Pbqh4xsK11GxKHlZKkqkVVGfkQjgtlvMR+PEVB56+gOHVX3suM9nfoXd7RP7gjf8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVHqKo+c;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O4pI9YlU;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686DA606A5AC
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 17:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 686DA606A5AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVHqKo+c;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O4pI9YlU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793640611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
	b=cVHqKo+cR9hVdRp1gzTzOB/gO+4Bn1DxpQ+r2nfHdNNUg5zRVkKpD20/bc3WGMp0fvGXlG
	knCu3vQkM2t5YKrQ+cYMcP9d5UYUz02NU4LTexEoVGZ8B4et0ohJ3ujfCrnc1iSS8jCBHK
	UJilzCTU6vlv7xjzgyVpBGjgif7jB/s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-DktwE9_CPyqar3fYHdPYWQ-1; Mon, 02 Nov 2026 12:30:10 -0500
X-MC-Unique: DktwE9_CPyqar3fYHdPYWQ-1
X-Mimecast-MFC-AGG-ID: DktwE9_CPyqar3fYHdPYWQ_1793640609
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso2880213f8f.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793640609; x=1794245409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
        b=O4pI9YlU92DDxrrSy6abElpco/qX3degbuogWx2SVyZyGnQ8Ljm8FwI4vtxoPyfDyC
         rhCe1JAnalublysmvZ6emIRr4ywccBIFc/TvwrdeH/FMuISwOSIg5cHb6MSYJ7MzZu0y
         yFsgAi16SjhXDtpLRy7vETL/sUyNwc/N2NMNodNJ1l9y/dGEvLTF4VA2p5XJdmE7+kzQ
         kEebFLK9C9ODAhgFXrTA1Gqx4IU7k9Bj9P3/jQPyW7Kmze2YxH2EFHVfP2KGGOCElP4M
         G9zeKnZ7EUvP59V4zJiHeV/v/BkOMR99FE1/Bjog31DElcdlOg1M5UQSgwPTzPtD52Vm
         ZixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640609; x=1794245409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iS3CAxGQE93xDrvwr4yw98qv93SkzvwRHW7OrIP7aI=;
        b=jkuDUUd7X5+gRbfaZ8njhmWvzauTFMvNfofPxP0aOp21WwXMKi7Ev2KhThwTPXz4pw
         jTvlBmYIxM7ev26gjihDgZigEwVvoxAuMmsR66X8By3enaxu2BIYESy744a1eK67H8YE
         rw9JlpT0k8XjQrvf+JtPVzxhjGDWXzblSAoRlPvkxDXLolms9K4afbhYLDwZDUVC6R2/
         5DHfWh2JlIYZ1hZ4ehkcLq2OWgVs469TKV4T0v1wWQfxiwGbh7N/pxtpcAiBP/MBFlPR
         eYSE2TgUydJ+tciIzHoNkyM7iXOys1D+BDaL2WsdqmNkOdMYQD6OBzr38uOXZohZh4IV
         1zQA==
X-Forwarded-Encrypted: i=1; AKwUvBy+l0jtYKzMNKpyF78JLdDwAcNFWUAf5LtKA4IQUF7XQe8HmIFBqpB1fozH1QOl/U0aoaP9Wzo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKw49Ad6urSo8A2vL7QsvDE27i8cb4h8h5Tinqk5sWEJWcpeNiR
	W2wq7wfCUXpbMhLDH3uls2d+fxPbZSVzENjjRQR/2eMlpC4dswVH+Hl+pY1F3vQNMcCSrCxPmQG
	/xv5oygyrsBu2WrDJ/vJPR8sBgB3TUFMiyyUrfns0yUaqe47Sv3NHUeC7BA==
X-Gm-Gg: AYBFou3yRcNtUOPVdsPHdCifoQiUWp2hMgsxxngPgdpdQ05w1sRI1wCvuelBCps9CwE
	oYcWpqBI02GR2AjPYwlwsGKSFXqS5dZ5BiycN40N9wt8JmsV8srEHhz0jSCBqt6mYQdmu/yqDLT
	BFdZukSri1LA8JI3ZGoGcZZ02oeLNmAY25KjOOpbbJBx+ToJBZUWmPGekAOClM7JX60Ew/Ynw5s
	X6X2lxKSoQOgxq87MWBFSP4D+3nqVPbP+RBDC9/qB4iFRHOiWSSxMH+4AuniOLzuWDCS//3Hs4w
	dt9BFu1u6cOPoVPJs0PE3qmq26o/TIAaYHsXQLJLsXH1hzWTr91C5a1+8PDzKZHg5gp9Ecd8DlO
	rXSm+3F7MIHwaIj3Lr7I4KNrhQ/Uu9tsvF7xfSLO5pA==
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr165297285e9.1.1793640608987;
        Mon, 02 Nov 2026 09:30:08 -0800 (PST)
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr165296615e9.1.1793640608457;
        Mon, 02 Nov 2026 09:30:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a8d60ca0sm1461205e9.7.2026.11.02.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:30:07 -0800 (PST)
Date: Mon, 2 Nov 2026 12:30:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Message-ID: <20261102122942-mutt-send-email-mst@kernel.org>
References: <20261021070242.75009-1-fangxy@xiaopeng.com>
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
In-Reply-To: <20261021070242.75009-1-fangxy@xiaopeng.com>

On Wed, Oct 21, 2026 at 03:02:42PM +0800, Fang Xieyan wrote:
> move_to_indirect() accepts an indirect descriptor with a zero length,
> setting desc_max to 0. __vringh_iov() then reads descs[0] before
> checking the descriptor bounds, resulting in an out-of-bounds read.
> 
> Reject a zero-length indirect table in move_to_indirect() so the
> caller returns -EINVAL before dereferencing the table. Also use the
> converted length in the warning to report invalid lengths correctly
> when the vring byte order differs from the CPU byte order.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>


Isn't this already addressed by
Subject: [PATCH v2] vringh: reject empty / undersized indirect descriptor tables
that you posted previously?

> ---
>  drivers/vhost/vringh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..ce4f5a02c8d2 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -197,8 +197,8 @@ static int move_to_indirect(const struct vringh *vrh,
>  	}
>  
>  	len = vringh32_to_cpu(vrh, desc->len);
> -	if (unlikely(len % sizeof(struct vring_desc))) {
> -		vringh_bad("Strange indirect len %u", desc->len);
> +	if (unlikely(!len || len % sizeof(struct vring_desc))) {
> +		vringh_bad("Strange indirect len %u", len);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.50.1

