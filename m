Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577686;
	b=dVPPjq0R+yZaBWSwXHCbFKK9EkIKMfrhOoDKDGCdm0/+3DV0iSMdLzG7m0Jlu8aTVb0m
	 vlI980Q+vnsfz8xeL0+I1sCt79s1oWzwSmg7xdRHIMedmka85JmVKMtw1njTv0XUm4mjq
	 hV/z485c/Cj1dm6qMtrAXvlN+hVRk5DsOdVMNXdOG95TfAAKck3NEuPXmySYZmdtYsAtF
	 HkmJECArvKYxQIWBpCJDSUeZEaqAbPtTFfwst3GkyG1YFWG/7DSnAqIxzdJMS1BUIDPNK
	 FgUi+SpAgkc8XfYELWzIT/j5JuI3gODGbHEq1LUlFaNX/vbacIP6pWAsjP4NoN8BnVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577686;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
	b=PIgZC9ThnsBJN0CIt4nhpWtFPuflQXPw2/qrmTSztjG2JPaFxeMnUqdkKybB1gPAsw4k
	 OBp60WSaWIhNHsVUplLzbq+1aEaIcTVK9fGGcebW45Si9RwaeBzZrU9DYfGGNfrKTqHcN
	 QQSvC6/xKaPi0OD1qrpopPKfZjQesPvoJPwziXAZ/cBIj2VY3p2U9wks5YuRZAglDIXlm
	 V/M4nIZclcfLxJrV3vER2SvyJy/qgD1q2IiBCS0/PJovGDPMcGGR1jdASHevU3mmIZh3W
	 Zwf4k5vOoqOrSwnccbc8XvyPZjFK2LUb97TWAr+Oj72/+Fm1oHfMMl8BSpjoJux8HRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpixcOcI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ejAaswOC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04C606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF04C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpixcOcI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ejAaswOC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792577684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
	b=TpixcOcIc+qEmEDiQ0FLw+S+qtpggT3NqH0RIXuzC8XKV/f9YbgNr3ahFBE7fZ+GDb2aiM
	MJ8Tu/HXmRNLwBcF7ACuwPEadiowaMAmgZJ/st10hS9I3uA3Zr1aRYCnlG+rN/XIpsvwi5
	q+58VurQ3uB5vhiS4wynDKnC3HLs7QE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-D6QZACwAOB-8nIOn4K4KJw-1; Wed, 21 Oct 2026 10:14:36 +0000
X-MC-Unique: D6QZACwAOB-8nIOn4K4KJw-1
X-Mimecast-MFC-AGG-ID: D6QZACwAOB-8nIOn4K4KJw_1792577675
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c415561aaso377619f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792577675; x=1793182475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
        b=ejAaswOCkEY3H7XHMvAZgqt+YFWmaA2GRwEj+PstMfsG6vKej3aW9Mc3rh9fAEWYEb
         pg2JMCkAPE82ExN+TJKKaHRxxf+3uJRlOUFuBXopOsn1ymGHjdcQSgg7go7o2YFOI6B4
         5Be9HrAfZ3MzPuPr3CKBSUBj4Qny302DJ5AAyOadKTYOToXS4tMVBUuwRD052omVT7J0
         MD1H88CSDfGxOULqFgCsw8YcCa6ZqWGbgLZXdbr5TZ9li9gphxupZM28UZ3UNFe32CXU
         Z6TO6k+AYwCq6yZ5V00AlM8z7dgnk6dWXWcf/KseDK8hkirdiHm+lEyFTAzhw2dNekkJ
         r8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577675; x=1793182475;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LaMrw0UGiuCnM59eNBEdevbmBZ2o/qyOQGg9zp+WMrM=;
        b=u4ZccKZnFIGVs0CXOAD7fSJQo5X45a5F0LzhMg6SQM5OBDPs+tyICDH7OM4jLsw5nP
         WF9h+75B5KFZsUROtVO+xudwl6tylJbf8veNDeKGDSVsKTkvHyqG1Y8hqLc4u6bZbaop
         BcTQnx7Lm9ShdKSdgbaTZcZwcrtyZwxRsGaJXrd2N/AIhCf9O/Hni/BxZOIp2rmA/NQY
         DSUpOUw8c0P9pY0I/uZoyojseqLtUt9VuvVVa1J+I7Hxum5z6S0kPG+n3lHa8WclcR3u
         eUwCKMBppJx/2hdoNKTteKLvfkp0N8DAGnweF0mW4ybnry2O4uEOt7F9ey13Bx59pvZ0
         kqAw==
X-Forwarded-Encrypted: i=1; AKwUvBzGcpm3Nubk5i+lIf3ekx/NBue49w9rEVDmvUl5/Gpc13lmqEaLf75uHXMi84Kxa/xYuTE5rO4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWAsD+mP3dwtS5yt9u4Z+ZD2A5Ol5MBV33gRXMWi7cYzx3a2Z7
	LYXcmOYisLL6YCkSQMFYYiV9rQB+qF5N9NJCPcWqUBIa+YAxAiS30/BuNzX9ENGiF6A/U6ZN8kU
	kfm1fne06ocUQnwRKsmKQ+xIECZuy5MiVi0+IsMi6/ngfwl635hrFP/NJ5Q==
X-Gm-Gg: AYBFou2isB7F9VoNU7WOOtML6570UhK0VNVTnmrNC+hyHyhSy4mTX1Ujm5vJV0Rjk5U
	ClDKGHJMpO0T7egyOyu7l9S1b4Q/JL6sLxNYu0tbNpPP72f/6wOfOg9+mQXYOjq1ipNm0/MGHp2
	lvndOUKexchRnUwHZuy03/Ltcn04bN09vgspAz7al6Dh2DlzrcY6nUzX0Eb4USpgvVMlc3aYRGK
	UzI+XM5/GC/dIeu9gGhEFY4m4VdzeJePV+GXiMpv0GdPeghp60e+kOxzLcej1lzVb7qbwWQQL1R
	JIMcQOqQyaifnY8UK4jz/H1cHiPki9ZOQXH5BWU3smH4kkMnWddhxEDj8EVqbsodiANZ67O1Mhe
	Px7u2Dw==
X-Received: by 2002:a05:6000:4213:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e264bd584mr3754092f8f.28.1792577675499;
        Wed, 21 Oct 2026 03:14:35 -0700 (PDT)
X-Received: by 2002:a05:6000:4213:b0:488:8931:b1b2 with SMTP id ffacd0b85a97d-48e264bd584mr3754032f8f.28.1792577675060;
        Wed, 21 Oct 2026 03:14:35 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm4512724f8f.1.2026.10.21.03.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:14:34 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:14:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 3/7] vsock: pass the netns to
 ->has_remote_cid()
Message-ID: <atiQfOneKTIyhGHX@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>
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
In-Reply-To: <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>

On Tue, Oct 20, 2026 at 06:15:06PM -0700, Bobby Eshleman wrote:
>The transports only use the socket to find its network namespace. Pass
>the namespace instead, so that a later patch can ask whether a CID is
>taken in a namespace without necessarily having a socket on hand. This
>will help with avoiding CID collisions when devices move between
>namespaces.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> drivers/vhost/vsock.c            | 4 +---
> include/net/af_vsock.h           | 2 +-
> net/vmw_vsock/af_vsock.c         | 6 ++++--
> net/vmw_vsock/virtio_transport.c | 2 +-
> 4 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

