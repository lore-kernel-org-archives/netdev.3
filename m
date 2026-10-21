Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577475;
	b=VECo8mNWdM30BD1QRNbWk9lfLbI38ZNxobXH1X9F8VnmdYnzIx5AY9GDGmEfs71px7OX
	 0LkpZUJJAluTjcne1yauAdF3phfB1MaQIhu3awf7sGbW/IVpjgK209Gr0XhUF2oAoS6wE
	 oDd0gXNCyR7io0dr0mOxjuLJ5f4G+qfjF1TKRW34e1fCjA6rjGpTi2VPyBv5Ab1/2s32+
	 3qeHUDApS/nLVY6I1xfqR4bed4vFxHOy5V5gHTkYABklIZRdeox80Q4Ej/rBK7LxrZy8P
	 JfzYz9ugo3e7MVmMlPOpVdU9XwvAty0jT7jJ8Gwm/Z9p9IJyZeznoYmIkfHgN4oN8hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577475;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
	b=XbdTsI/JYzjnjSaXMRzB9+eZv71Wwerz/Q0i/zA7k4CmONWuYla6djw/nXCUsxubOZ8K
	 U/SlzJHZ3q9VIYtmPDsYNohPeKFrspJp/+5fJGhJmmcZzU0V8Sbl2NEQRFn2p2rROR17p
	 K+p9ZzFPSsOGU3mpAPLu9yn9aPzc5oVhvkp3FsnLWlSmBUBVKGM2gjdIJoohNPAKuVoJv
	 esB1rf1Ln1mdnIWMGXNvn5ZlSDL9+JG1+Y0VUthtWVt6uQa/AA3XowWw/fuoR0owZcjWR
	 YCQ3VUQxyVu/z9Z7UKpIZUGj1MdortTS11Jh2hGT6e5lhXvjVKez2KEvCM03nRLouTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DRJpuDgZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IjcVcbax;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14B606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B14B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DRJpuDgZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IjcVcbax
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792577474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
	b=DRJpuDgZ7LgJO4mT4LS0rmTR2Oit+nfgKj7EybX09VGAcbFwck8EgxgOKLEMi+fvZZUlEw
	ZEQ7SIOEFNXramMqkbi3fIlhVMWLKVB6GUUqUYOUJciRsvaCvjL3SDmrUt7ORVAwp2Tas1
	DQaWVlFzjGEhDHyQoMiDU9wwdfqCw2U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-IB-feUvcNS2VurGbwk750A-1; Wed, 21 Oct 2026 06:11:13 -0400
X-MC-Unique: IB-feUvcNS2VurGbwk750A-1
X-Mimecast-MFC-AGG-ID: IB-feUvcNS2VurGbwk750A_1792577472
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso2790685e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792577472; x=1793182272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
        b=IjcVcbaxw6eEvPHj34xRbuuf6RksAfZiPLaNCOPIwzViKBUbCYuyliSiWbKd1X4wQd
         LF1LZ1PUKxQ348fGtGB21Rn1IML+x/2GulZ4G14DemhDppO1Nenlausvp43OokwKOfY0
         R91koyAaBHDppwRxDmm5hIUycei2QVqo1buKuQIsBSZevtUqNaqdKUAXDNue9B5LKnQp
         9vJB8M8FqowNuKl8EkRYMdzUYDy2uYtmTqut92GxM6BgIDL0e58IJtJYgKTiE64na28C
         8ZLF7u4a6zqjcLtOo4nP1dZIlmCKwq8aaNxYer5svpwyg7lFkvUMDKmNMRwi6js1o9b7
         iL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577472; x=1793182272;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
        b=bNj/vV0Co05eTGFCBVr4tjPrvbukHNmEL+Hjg3I1nINpstExHEtp5IHTKODo8WGNYm
         HTOwUUHX9v4n0q8ZBCsMs2s7TQ793yf/pXHa0ZCHm6vf+9PZlQ7SEZ9Yo4TFrGidqkz0
         mCXWeFIHZ/I/Eb824xzBMeXVSpDNtj8t1st4pm3fU0RETV9DG3uDCC3aLu2rUJcA9F/z
         9vDH3EHqPjX2y+xR7AHj3LGRYxmfjoBAlbbwNnKu6+LyHqt3vdMpXZEfvZAWqWBI/wDF
         dbSuigThuC/DTsODE4u5EHDbqFdoKrd/jQ0N/zU5xblRpiE88NDe6NrGdY8ujrlx3XZD
         nbXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmX9BSzAetWuGjS3KFzGhjIYcYCx5F+mGfr5GtId0+ub/LvXbnTjIahr4mi34xiuWv+9o+4CE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtgEDOMvazKBRpjnuztWbk2qTzsOg03WZKeLcchKTH1ifY39Ks
	bM2LyVaW3WwQKUIkd9luIWDO7/mEmxa7cIra9cMJroJnatgSPOXA2Hcc71vEOP9/2dZNVlYphDN
	OTB7TSNML1ZIYjGLUHRRTwUDftPA/5sNfiO37vTWo9Fyptv6suJDdJS9Isg==
X-Gm-Gg: AYBFou1yd8mEldpEBchXeva7ZOnCBYiqoJHjRhvNG7JQ7yqS7eh3FJ6nDaC6BhtEHGJ
	2QHsi7vT5ScH7tHGSpCVizqDKwgvL0vtMLUVaPC8veeILhLiSlEKd54qG/ISn/Cr4UgXXvjYUzj
	OIAAl7DKIpZQO048kEn23m4WE8UxL4ZQI0npy2KV26uNQFJQgaWGBTf3RQrmz0IYmC2mDQOh/xn
	Z+laMb5KnEhtk0E85/6fpJux9YgEXQqhvOXHosUnphO22s2Kc2vL5k4l5TogPgdYfDbsm+gPMaW
	+0ToMjufnVA8Y7X7nbc2UItm7SriNGVYV1BhmIdWD6d3BsCt9vzokeM2zvEPjFiPVAD1tvbvcd6
	kG4cOfw==
X-Received: by 2002:a05:600c:34ce:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a1fd8a7d77mr31195395e9.2.1792577470822;
        Wed, 21 Oct 2026 03:11:10 -0700 (PDT)
X-Received: by 2002:a05:600c:34ce:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a1fd8a7d77mr31194065e9.2.1792577469551;
        Wed, 21 Oct 2026 03:11:09 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d699dasm152330945e9.12.2026.10.21.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:11:08 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:11:00 +0200
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
Subject: Re: [PATCH net-next v4 2/7] vsock: rename the vsock pernet operations
Message-ID: <atiPgleCntfwV4-N@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>
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
In-Reply-To: <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>

On Tue, Oct 20, 2026 at 06:15:05PM -0700, Bobby Eshleman wrote:
>vsock_sysctl_ops and its two callbacks are named for the sysctl tables
>they register, but the init callback already does more than that: it
>also initialises the per-namespace vsock state through vsock_net_init().
>
>Rename them to vsock_pernet_ops, vsock_pernet_init and
>vsock_pernet_exit, so that later per-namespace work can be placed here
>too.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> net/vmw_vsock/af_vsock.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

