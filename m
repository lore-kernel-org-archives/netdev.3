Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1A390981
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260941; cv=none; b=lPDTQnrD0jn7VRkY1+dOSrX691hNo9Fx+E7utdeZ7XM5dRZ5gQ7qkFmJ1RF1sUmW9rwNIoeofng3tCT7G8ID23B/9TWsft61MJ4DB0UcHB3PsdHOtssObZGAba8dDUQATCrIa6h0+qd+/yp2FxWPxcqzmK6dTB+Xot78OIb+PaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260941; c=relaxed/simple;
	bh=acjZUGKdaecj3tiJh85zgGIvI7UQ49rmRl+qboc8Y+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izg7QFEWBlbXwY9HEUKXWFgXqS3b7KJNQth8vlWd9IiKTpgnXbAwoQo/STq1qEkMwsmPye0eUYRuf2J/EL/Oi4DFRToBa6c3cWIhjlhqN8cT05UyvjRzlqdZMRITtg/G0Okexg+D47q8ER6ROCMowdMQn5IIEyfFDVZaxfRZX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSkWMa2k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0AAC77Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSkWMa2k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0AAC77Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781260936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf0kmFuUAiZnL7ib1dVfO8bvzPtJWeke2Juu4JRQHGY=;
	b=ZSkWMa2kvgACZXbR+gPlQC50PBPO47Q0riIr+BV8BH2ysciH4Op/QneUp9QImHfmUincSr
	lZzkdCIE0SYqvLlyya2BEvGgP3c/Qsh42kxsWhmk7rD8l0vU/0SvEVCGZM8f8LVSyTeuF2
	rLLYZeEX2ldaK/eHoSvChhM6hEGgR0w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-60yp0pOfOXiiLF-FuEBcxA-1; Fri, 12 Jun 2026 06:42:15 -0400
X-MC-Unique: 60yp0pOfOXiiLF-FuEBcxA-1
X-Mimecast-MFC-AGG-ID: 60yp0pOfOXiiLF-FuEBcxA_1781260934
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso499652f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781260934; x=1781865734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf0kmFuUAiZnL7ib1dVfO8bvzPtJWeke2Juu4JRQHGY=;
        b=F0AAC77ZqT+DkwBBaOkcYkY9CIVS1Fei+vF59e3gmyQzj2RL7ppiriNKUxbWN2c2cV
         tOYu9EoAvlE89fF2L+Pwq10ssn4zzrOyOBI6DOS7XUVwbNPjb2+G1XoVoZ5jLbCeW7Ye
         mvGLOOQfe5surQk/t0imacF8eZDqLaZ23PgSZ6zbq9AqpPHkx5coBPnPyyGiB2DUqjIP
         uuJoQgdZIewYvIhacN2oOVoplpGRSLZKTVS8AEXgoX8xsddvfsCbVWzHTWDVWr+d0NYy
         bgcH0L4hJ1oVQqJDaCjyinEG+RhlnuBf7XkJ7nhwb5ohu0c37m1Cm8km2PfmmjkmNY7W
         tRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260934; x=1781865734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf0kmFuUAiZnL7ib1dVfO8bvzPtJWeke2Juu4JRQHGY=;
        b=Bm1bSfNmt/fJhbigtGwSKjZUxAD7M0Me7o82ksesOIkZ2Jk/Zsoo1RR385Zh6I6XeG
         gBzzYMLyISM4BiF6E8EmM+0fPHs6ZxclC8ctl4l7Hah+GePOVFMtcUAHgVPqA4eonUyx
         BnHf3Je00Gq7SqJ7mtJzyS74yUhjH5K9Y1dBN6Zh+fZCx3QJ0dcAVsqkLU5h1oaZ8r90
         V71BCdp9r0K1vschYI3IYAkq680SehKsl0U/urjRdoGlwffPd8fgPwzclvt39kxX//Qa
         gOaPgJGa6eCw1hpBqGrOzeNev+z2hWdY5CAo1c3aVy3oBNUE4kK/F8kfQn+aJKiJ3dhp
         WhVQ==
X-Gm-Message-State: AOJu0Ywj0jrOxMP1F6snAkWysbA9N+/tMlifrdbus5pOqqIaUG9RQhmp
	gHuZwR6AKusrfpZ3MFxErQ6isdN1krPmaWkw0ZhfrLKewOc+Izp9+4gLvJjz0boc4xuG1IVaYMR
	AjT+NgCeJzRzu91clZLov/tTguGDA7hQ27C5ekHvbuugxWKPD7pTU0R9yOA==
X-Gm-Gg: Acq92OG7SB7Q/Nzazkm3QTJLbQH0ZQ4HO4lSedRKrSlTdTu2MvJcKPA6yQmTDXNgPk1
	xCubC4MEbmeJHrCM/miD86/J7B/Ax2di4YEOJQz+S+HTp2OpjFlx+3nSZYTiyTRlbOlxkq5kyyh
	gS347Rf8ZH7RgHpX0EjHqW1GlsZQK7xdBIsdUdBtEOOaGWiAdtBTwDcFvgbma/yQO4oPl0NvhCG
	ybcePwka7v1cDje0aq8oi9wPymoi9KaBbIWO+OwiAYFxHtrBfrcNeR5WiJv0pjxN5Q1DQfD2IhM
	ncnTK4XWW50KV65hDefFK4WfBDSo8I/JrVLGquF3uU7CZerG+COlYqQxWWzLBYDDxgSkMByVVNK
	jP+6DHn/ZJyzk5829EHiXcu2ug/5fTAMoRSAYUys2pDUFao6TAXC1Tn3/GNp3UgqRfL4C1yU=
X-Received: by 2002:a05:600c:58d5:b0:490:c2a2:e91e with SMTP id 5b1f17b1804b1-490ec523a8amr17826275e9.34.1781260934147;
        Fri, 12 Jun 2026 03:42:14 -0700 (PDT)
X-Received: by 2002:a05:600c:58d5:b0:490:c2a2:e91e with SMTP id 5b1f17b1804b1-490ec523a8amr17825945e9.34.1781260933709;
        Fri, 12 Jun 2026 03:42:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d0fb23sm137795295e9.15.2026.06.12.03.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:42:13 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:42:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock: fold sk_acceptq_added() into
 vsock_add_pending()
Message-ID: <aividdU8rpTLexuR@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-3-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-3-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:14AM +0000, Raf Dickson wrote:
>Move sk_acceptq_added() into vsock_add_pending() so callers cannot
>forget it. vmci is the only transport using the pending list and
>is updated accordingly.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c       | 1 +
> net/vmw_vsock/vmci_transport.c | 1 -
> 2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

