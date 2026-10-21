Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576124;
	b=ypvNdejgi2LBx0I9B3ss2LZesbs7q8ssqVr8+k5tOHN1eA60NpJNQ/pjETmvZLXzUAAI
	 0sc0PhcFzCkKDnumF6HzAkqW1LhQj4MU1NEk2zOu7cu6edqkRPYGjQI2wTZi+TvPBuELK
	 k5qp4QEYQ3p4DSHJEUskb1DeYMLd7e0tbhYQy9NB0QSEixQWpMvdK+3+UvQkvfBVPFZmF
	 m2uCW7+NCaagvBmqqPDLu5i5v6jXCOM8JisCszFoyUS+OyVHX54PREpMmMHdTHkw2BqhJ
	 bvvqpaVDj5z8bK0f4F4qmdxei1a+LH0AgcJjoItBGs6Fj+LLmo5anAjm+5WmMxNXERA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576124;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
	b=gxErxeDh/lZl+IGwR7+/UES3xTUlrRFCsX96u+rudcm+PNfW0DvkXIN23XCz31K6hSOj
	 S1Bhcl2vshN9vvLu8fxaktksEaQfPCRycWCrg4+5Lhe/YvZSWGWBdsogAFuK6zERsaua/
	 apz2VLqWgXPv4CjbHxBwatSXnXYWUX/fUSGdTxCCXMzTiB3CgwSViWYJKTGCBa3l9aHUU
	 xuQVEMV2oMBl9bqcXwhe8w1k3RxsvvyBeoSHvksta+13kLpVzb+2bS+tZMS5FD1iF22ob
	 hh9TfNp6KfRKSKVdGc6IYMrzdw3xwj8uGwJvCjXyS+7wRfHQuNmuxy/LWwKUClX3FMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iAyP185u;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fOIDGL33;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B9606A32C
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C78B9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iAyP185u;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fOIDGL33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792576122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
	b=iAyP185u9WCtzmuB8Ga4yrARIPQVN7dKL8XtML1yGN+8qXVmsTraOqIDXcwem8ihrFkYoG
	iIUyEFy2XXpoXNT2BCTzcuhDTEFBTrtLcuJS0slTVJolgVae53OSzvK1ZSON2zR7BDGAre
	kS8k+OU/t2Ux1AFF43dYFz7wyb0kp6Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-ExYZndgwM_-0ATRWwYLuuQ-1; Wed, 21 Oct 2026 09:48:41 +0000
X-MC-Unique: ExYZndgwM_-0ATRWwYLuuQ-1
X-Mimecast-MFC-AGG-ID: ExYZndgwM_-0ATRWwYLuuQ_1792576120
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a01d1fb07bso6570865e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792576120; x=1793180920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
        b=fOIDGL33NTrxPKx+BfsSsDVnXGS4e8t1HJJGUsc3zBeYFcQ3ytvC0qEBRWjlfcyZrr
         ZCckOHMhq0gDAviC7f++/hBeFg2lT7fA0dttpTW7BGm1HhGK9eEMaPmE7TDHycXFjXHk
         h7isdhUMxs7yCNSiurFJE3JaxJ7pN3pn9BsYs9SHANIIphkdRwNpO4FR9itNunWMSxhy
         771t03Cx22KDx1i08QAh+IExKyggLErVRHkGmOFSmSqteiSE5s2VW/g06SXItYaSgVJN
         K4stLeA5BBNcDnmNyRisJHaTIbAhf60v4At2UHbhm/fT0XdPXzWoegysEI2GbNcnjv+Q
         j4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576120; x=1793180920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3oOP1y+9aN6aMBiBqwXHlYcfXTBVxTTDMi2tTB6X1Pw=;
        b=PuRrbKX4Mzx8aPs6Dx5/csa6wW8vmcKzSRsTW84CR7P3Hr4wQxtyAcSgtzAZGW4jQW
         TegdcrG3ka4g+8colYOCnrlYl9Fm2xax2yR6z38xRl3TEWCrbFvOcvYiSoucJ293rnQh
         GjRGWO1/fvN1d7GRZ87sR1SYn1/0iShDLu6JGxMYEmHNAEM0oYEGRUYUOkJy+cfT5bqO
         Uc4ztgRoHVzZjs9mkEqySqDGGSDhCCf34638pVNiERyJVVgYJOOsIaMQZ+NoCGfYIMaz
         Q3HCfMQfSHVHNAvpTl5BDc5eEQrSEb7Cmo2Je5jCTY7bFY0ACmZsTqzEFporho4rnbZ+
         0ZvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqbUhaMtNXSLSQNNSrJGKWRgdmkHpjm0zllRyWLI3lApQKyETSaEkK71LAqu6AVM+Aoskkw9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwimWhF2zXBSo2rHZaiesIPr6jc4kldB17TFr2ardAcB2wKqwr
	VHiseltOSSjlP7iYv91SenMgHuMnQHPPDCm62C/B51dVp9Ith6lLpBs2zzkt7BGASTvn+NC3v6M
	B2n5qLn/1PZFp/mfD1DdqCr4boSn3m248yph9nNc0VxsQKFp/kURm9cB0VQ==
X-Gm-Gg: AYBFou2Ol6kGkCdMO4QBUrE3Qdk67MGJFYmR3ypIA3RQ8dVcod6p0uN7R16z7dg8eqM
	EFJxm72tet8fmnVNeC8EHrnLf5tS5KnMNtoC5iLTeQSCnK4tyYriYJpv6kiSh/dFDOYWhscYkPC
	MMDZl0sd2mCyr6G1Jx4SdTpUQkbJZX1VsvIe9bHe5+KVtzhLiHm7SfedGoZwX7yJKpr3u+e5tiC
	Uz60iXvaL3gxJczFSEKtIN8Vu6Ez6z9saOBKmcQn5bTyHKlSLI5VUcfzA1B4cwesyimUSX46Eh6
	osykRwiEAxOx4GCSQN5AhdIgfY9LXMwfJoI/p1ZRKWZYl2OJrLd6iMYWgFd5h+mRxESu0WJtzjq
	+DvPsEw==
X-Received: by 2002:a05:600c:6085:b0:4a1:d0e4:2bc7 with SMTP id 5b1f17b1804b1-4a1fdafd610mr29312435e9.15.1792576120181;
        Wed, 21 Oct 2026 02:48:40 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:4a1:d0e4:2bc7 with SMTP id 5b1f17b1804b1-4a1fdafd610mr29311875e9.15.1792576119740;
        Wed, 21 Oct 2026 02:48:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1b227dsm52096435e9.6.2026.10.21.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:48:37 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:48:30 +0200
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
Subject: Re: [PATCH net-next v4 0/7] vsock: assign the guest vsock device to
 a network namespace
Message-ID: <atiKKS3piuBLEiSd@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
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
In-Reply-To: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>

On Tue, Oct 20, 2026 at 06:15:03PM -0700, Bobby Eshleman wrote:
>vsock network namespaces let a host put each VM in a namespace of its
>own. A guest has no equivalent yet. It has a single G2H device that
>cannot be assigned to a network namespace.
>
>This series lets a guest move that device into a network namespace. A
>new generic netlink family, "vsock", supports the command
>VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace the
>request was sent from. The namespace's existing ns_mode then decides who
>may use it: a "global" namespace shares the device with every other
>global namespace, and a "local" namespace keeps the host connection to
>itself. The device starts out in the initial namespace, so until the
>command is issued nothing has moved and no mode has changed. There is no
>explicit unassign as assigning the device back to the initial namespace
>is equivalent.
>
>The command requires CAP_NET_ADMIN in the initial user namespace, so
>that an unprivileged user namespace cannot claim the device.
>
>Connections that can no longer reach the device after a move are reset,
>so that a namespace which has lost access cannot keep using a socket it
>opened while it still had access. The assignment holds a reference on
>the namespace, so deleting that namespace does not move the device; only
>another assignment does.
>
>Transports opt in through a new netns_assign_allow flag. Only
>virtio-vsock sets it here, because it is the only guest transport
>that I am able to test against.
>
>Based off of Stefano's original series:
>https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- All Sashiko fixes (see individual patch change lists)
>- Link to v3: https://lore.kernel.org/r/20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com
>

Sorry, yesterday I started to review v3, but didn't post comments :-(
I'll send on this series.

Thanks,
Stefano

