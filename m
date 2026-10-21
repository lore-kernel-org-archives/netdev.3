Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575787;
	b=oiat9E3W0f80xLqIHKBK13IqRM9HO28xIVBAWoOXX2dPkswelb2e2dzGapjH2mckHhAo
	 OiJaG/8U3My1Tfna5o9t45r6+b1lVA5mYTzzrZAJvJ21qWPykxIdvjfGRkAyx52kY5gXb
	 rcqyd1Zz1h7t1uCF8Y3CA40Yc3IwZMLQW7I3lF8DvAdj0kW3kIKcDkYfqmR011Ft8RUKO
	 okVc4iWrUpfPUoXKi+TdjX4cToke94lFtysT3uOfFGOvONmRK9Bl11fh+NiIHaZaJOoBm
	 Oxbylx7hw5dutDn2AQSGqJXRi6l0fuJ5Sy5EUuyAx/pxpywlEXeIAFjIxppcx4wg+sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575787;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/6wg+cGh6J9MYyjTA2bTtWBGWLVofTB+kJ98QIYQnjQ=;
	b=tVDWRZgQxLSRZ/KTahet7NDobIX5wVvZF3VUGWtKRPXkU9ySeAKxphsxhfPfH/PjN8h+
	 N0HZmvigB4PrWeUdak24U0ftSJnMwYTtGO9kLfqmQuq+tbcNk97ahIn58yx/rdz+xM8E3
	 A/FtDp0hJmUy1ngf+csmIckzt0JGMEerMNqZ2tGEIbaB8MEe+DMdpFpTszvuPb8NH7I3O
	 dzdFEoZaDB9TansFvnmUng/OCBqmjZcNoYwiKuhIPDpDNEiQEawxaSz+8gsQFUr2dxuR+
	 DBYxouK2OPeY1Y6RyUVMrGaYaA6WzFyNbpQBn+iS4JbggmfmCDBojQO/3KnrnZ1kKzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="B3ZX+/X7";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VD5K38gX;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918D606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4918D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B3ZX+/X7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VD5K38gX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792575786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6wg+cGh6J9MYyjTA2bTtWBGWLVofTB+kJ98QIYQnjQ=;
	b=B3ZX+/X7j8MjrDLCA/QlSGkWKA7Mrsg449QIrswWZ3JtjKChCSSUrvxsTTIAGhf1Tefxog
	n9jwRonwQwhOz/ARUZrlfZ9pMykU6wAdZ3KVBHPlXwS2w3IJFOVC1uY5WAHN9lobGLfSxr
	i8vivZKfTXmeHRr9tOJY7c3SPkrJZ5A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-DYxG977nOhWE2kX-aQ7YfQ-1; Wed, 21 Oct 2026 05:43:05 -0400
X-MC-Unique: DYxG977nOhWE2kX-aQ7YfQ-1
X-Mimecast-MFC-AGG-ID: DYxG977nOhWE2kX-aQ7YfQ_1792575784
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso3718455e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792575784; x=1793180584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6wg+cGh6J9MYyjTA2bTtWBGWLVofTB+kJ98QIYQnjQ=;
        b=VD5K38gX2X20mAX57PkwBTncTsCRQPDTfzq9+SQsYTV1Vh5ExF9th49dCiF8VybNiF
         YKRlZk5MlQMskdJ8XWu/h+GB0bJhXzq/pG4ghXPOdN0oaWbJxfDPPTnOiuMiJXeUGqUH
         ghDgryKXtYJi+Wq+dQprjIva/kwVRDcNDnZBi3+44ucOdXqAHu4sipZsKRklNHfNF4/u
         MdulsVClu5upRigOYbmPMTXDG71e9N6ecNQNCh1hP4Zxso5FCEp8Tvx+JVUueTrjD5zT
         +mHUgr+OmP7e+Ji+Rio43WHt7y8kIPOh8jqT8F1sKnwckBtU7/mRHlfKqprjw5fp3vMe
         VooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575784; x=1793180584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6wg+cGh6J9MYyjTA2bTtWBGWLVofTB+kJ98QIYQnjQ=;
        b=EFe/X/anKW0QF1UtWciReF3thQ4G2OIHtdfMSTf/+dRPcsGV4r6efRMz8o7I9+ym/0
         KYM83oYakxQrPOXONIyUEz5B14nPsJRQ+/Won8g9uoQQiTvBPfjUcPMfhGBX9ogIlllm
         YdntodIf3K6Ld+5mJP+Ttu4TUq7VDbK7jqaU8oEsep2Rv9rnizuBXJQQlM+kXHpoN2AM
         fYi1b9r97p6KLnG9s58b2k5xWwvmkclimDk+rZctIlr34PCo+op7iOVmuFN2vyvTsYFy
         8IksVhib4bucMlNxi31JRePSR2q3pMrT8Xt2syWatTHVFSC9TKCER9DQHBYTUV/A9DM9
         mlMw==
X-Gm-Message-State: AFq9FYIDO38BKKsR5f2RwwWWbJxsZODnCaqf4lhzehtX4xe0UNQf+NoB
	OiUhRJjKqtP+p7/VoZ2/NW43f6eb3cEG6Yz7aVuQ/FLmtEJpBtvR4ZoutCrOR1XF6FUaYTzfzLr
	YJ5QJILszuk0USzBxVlv1CCHbIgnOFZfYShU2im3rnm0eTiC6Jxo+Cy14zw==
X-Gm-Gg: AYBFou0SDxe9UaJH1IX7lk12NwM7KYo5d/F3/RUM3X2Eo702iscxOHsLHLacv0UMHEH
	9m05n7V2AFzq87/OB2tH7aCUPLLM8vetfme/K7cZeTH878J0cr6oSsAeD0eXCIj/1n00sxVkyJR
	y/N+b3vbREBUYhfNO2ttYCrCvMhUFHLr9P3LRI8hNR+M/auTamEz3PXjOJip3j3VE2LzkOG/tRo
	Fm+F41cp016ZkH6ApKGUKeu2fAuDzSSq36nzthiOD8eh4jD7nGqbGDC4qCT+TxorEYTCfS02lcB
	XBuUS2bh387iDst4oOR5Rzxi4nRlbrfs3CsMejAdHw35zHMGkUEijNCbM5915+F7Ovflm08q0pz
	HuBhYVQ==
X-Received: by 2002:a05:600d:864d:10b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a1fdd399dbmr19403445e9.21.1792575783730;
        Wed, 21 Oct 2026 02:43:03 -0700 (PDT)
X-Received: by 2002:a05:600d:864d:10b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a1fdd399dbmr19402975e9.21.1792575782925;
        Wed, 21 Oct 2026 02:43:02 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm4305321f8f.52.2026.10.21.02.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:43:01 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:42:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] vsock: support SO_INQ on stream sockets
Message-ID: <atiJD80fftOEaKp-@sgarzare-redhat>
References: <20261016132716.272018-1-devnexen@gmail.com>
 <20261016132716.272018-3-devnexen@gmail.com>
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
In-Reply-To: <20261016132716.272018-3-devnexen@gmail.com>

On Fri, Oct 16, 2026 at 02:27:15PM +0100, David Carlier wrote:
>SO_INQ makes recvmsg() return the bytes left in the receive queue in an
>SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
>support it, AF_VSOCK fails with ENOPROTOOPT.
>
>Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
>As with TCP_INQ, 1 is reported once the stream is finished so the caller
>reads again and sees EOF, and accepted sockets inherit the setting from
>the listener. No cmsg is sent when the transport cannot report the queue
>length.
>
>SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
>messages, not bytes.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 35 ++++++++++++++++++++++++++++++++---
> 2 files changed, 33 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

