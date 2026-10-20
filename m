Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526477;
	b=aRvVqnpHaZZ0pC52QyQfer3ZZYcQOvD/rSb4BOjxsT2OOrt+qSIt91kVsb4fpywh0E4T
	 nQpygtoch7wz133vB9DbeozfZaSiZPjGkHe1F3VbJfAskG0KYm8CEWtOaOsHHuqNFfmt4
	 cLwCYHG7G4SZKtGNLKV8qzLrRuAp+7ZI8raadn3JOXMEg8sbZXKAkMbmAaQhVnPblrqvk
	 mvrkzq7jt0BgYlGBFmR7SSDgdWQMYkPpWUhpSZoxsw+tGwrFqqyQWD6MhQA1yTJvR8vRt
	 kQhWMHmGlwPtO7ddoeYT/qtUpbxzzqqFRHrnNOsacIODeHGtylbioEb0x19rwxW9eXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526477;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zI4sbiHutLhUzts3GNlZ8BZlCgpCPi+nYzjoB3+wLIE=;
	b=yZHzDAc6X8QJhbVvN8ooA6/iOrV5CB8XmYdZPa1PhBKLS729OkTHmDU/IHtiEcSR0qP5
	 U1tpVqQ5pf4PjbXNmfliLbMyB2aY14rDExW7kgALH8hNvXKhlnLuFSynFIBlVRFxFFjeF
	 SmBJ+dRzyVCvTu22Qe6pNyvetwgWeBjNcd/ZQ12K7sBE8GPN09BrTITRcQRTKa+80grHm
	 SFex9EVSFfiVlfEZjPW3jbuQMJOIe1T+Ib1xnB3IxF9I9nJQvNm6W6lolcvZN68QCTmEt
	 X6mWmyDOvoE5eK31h0kCermponeY/CRkDzvSdkTb3UPYV+fDQXtfgBbAGTiSdQKRLZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E5VdsOPX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RxSvZcvo;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6E606A322
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B6E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E5VdsOPX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RxSvZcvo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792526475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zI4sbiHutLhUzts3GNlZ8BZlCgpCPi+nYzjoB3+wLIE=;
	b=E5VdsOPXqa4xsqxi/sxSxdZgQoS6+fASz3elMJV4F0NE1tZnfU/C5wT1CjmIh61As2KirW
	e68ybuFvXA3WHVtH3bpqETZis6rQVadouIQs6o1l32Rj2XLLAHzxplgmTPqkqNfaP0w3+j
	ob4KXKPrRFezzCxmtb7dJwgwCWqCo9c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-8lscWGm-MFGP1RXHv8rM5g-1; Tue, 20 Oct 2026 20:01:14 +0000
X-MC-Unique: 8lscWGm-MFGP1RXHv8rM5g-1
X-Mimecast-MFC-AGG-ID: 8lscWGm-MFGP1RXHv8rM5g_1792526473
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1e672580aso19417705e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792526473; x=1793131273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zI4sbiHutLhUzts3GNlZ8BZlCgpCPi+nYzjoB3+wLIE=;
        b=RxSvZcvo6lyk1Ci+d7Q/KJ19r5bvX39NJhNNsXMBrcK7mnCLaQJ08daYrsO48hN0Fs
         hWbEwVdhG30/LsEmE5uFmzdvi2OYfQhFxT3vxoLatZbIWhRSrSuPMvOJBDg+Q4AZBm8g
         IxN6/F/y3VMBL+q8kofMTUasIB5h4oAsNU8DzbkTCuNlDp6mwmpMow7NVKpiMDcMW1js
         +sUAyl7DyHH6cBfhLqHDBojwgOCsZ6k5rlU7Mblz6FNhsu48mpM6LcHFgV6GX6I/2YPv
         efqwno/aTCqFF93leqmSfRMfzzQ5S6ZSd+H1mETSpTE7fx5xJnGCogwEDmpLX3OOny5C
         JEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526473; x=1793131273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zI4sbiHutLhUzts3GNlZ8BZlCgpCPi+nYzjoB3+wLIE=;
        b=ObijVPcyJ8mGfMZZVVs67NnQ6j6ezlCYk5bvkPL6jfCedZRezFmWRdZyW/vwVStDqk
         2cmpITeI/W0ZXIosHSInkOs2KgmLAXBhtiQVzfc3HYYzmChAWZ5untaM8AQyG1sP5A1I
         TK4fyRdLlAIkCtr+e0W8L/2ARVcOiaswanHyk9cXAi5nd07x0NsZCKDgedwhoLFRRwIk
         v2lfhkNKh24xrpipzvKnC6XHPXiwclNfMYtfL7Xu+0jrwguGRnOecUOH5i680TBO9gyZ
         xi7/qtkBtUZpBvpRQyQBeK9YX/7VBp3dUMy+h5W9NVP2qefMcpNxgIMBpYuBA19qLQ6J
         ln0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzdxMrrz00KPWjLC/Xqa1zX9mEAjioLZ2pyT8K/R3I2S/LrNtSVDcfhRbuy/LnlET4CqT8HxD8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv8PapEpSWah0ZFqFOLciLoTK5tALUDB2h16RKFnbgXwxC6ArH
	QR07XpkYHXGE3xaNI50zjOSo4ILgCVX0nQADKPnsg8571k1gZYt2cXhqUIm3HPxZg2gua0Cni99
	Qlb1FqzQyB7D0FYO0bFd9Cv+PBZXTVuU7iB/4Knm77BhUyv7JOnXkv7Xepw==
X-Gm-Gg: AYBFou13iQxQfxtQJawsH7RK1t8b7vcyzTV44yOHZ3reBzYjr15/ACMrRh/fSymB9Xp
	3Hky1ikn4w9AtV63qLQMMMuMN7JtUFZV6d8znpuJwZOtHSbplF9zDCujMvoR/Rm974M7aazGa0b
	LSM440KbQb4KuNSyq/pD3m9u4mG7bDOh5ZXf9+L+UwJZZAVPUrU/U7f3ei+RVBEDzE5XpR3VS3c
	zlWCKMweCypnzGIsE4+rpp+XrtmuxEX0UXea2DHmHTkozA/tropyZmG0eDhizEaCfwNxxoSEQje
	y1pGGk8SENEGUUoQN6STkzjNvuKrYDOb0SzHh5r5E4DIfeiMtxSqwwX6dsqW0BUkO3I1BQ==
X-Received: by 2002:a05:600c:8010:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4a1fbf8577emr14172915e9.33.1792526472967;
        Tue, 20 Oct 2026 13:01:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8010:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4a1fbf8577emr14172305e9.33.1792526472489;
        Tue, 20 Oct 2026 13:01:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb96bc7dsm22498245e9.15.2026.10.20.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:01:11 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:01:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020155917-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
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
In-Reply-To: <willemdebruijn.kernel.187d58ff2bce5@gmail.com>

On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > The ingress validation as implemented by the previous
> > patch is stricter than what it replaced: GSO
> > packets whose checksum metadata matches no transport header are
> > dropped, and non-GSO ones get their checksum completed in place.
> > Such packets used to pass with the metadata unvalidated,
> > and with no overhead.
> > 
> > I judge that this should not affect any deployments, but there is still
> > some risk that it does.  In case a deployment depends on them anyway,
> > provide a per-netns switch to get the old behavior back:
> > 
> > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > 
> > The default is validating.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> >  include/linux/virtio_net.h               | 23 +++++++++
> >  include/net/netns/core.h                 |  1 +
> >  net/core/dev.c                           |  6 +++
> >  net/core/net_namespace.c                 |  1 +
> >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> >  6 files changed, 110 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index e586e17fc7a5..b1a1c4714b22 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> >  Default: 1 (on)
> >  
> >  
> > +virtio_net_hdr_csum_check
> > +-------------------------
> 
> virtio_net_hdr_validate? In case we do have to add more validation
> later.

If you insist. My worry would be what if that validation is again
user-visible somehow and we need to distinguish users who want
to disable that future thing and users who want to disable
just this current thing.

Hard to predict the future. But I will go with your intuition.

Will check the rest.

