Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538441;
	b=YcCOf6VDN+YtMepM//btUZ10fOzQpcTRnEEzM3FcJPNiozUhdcwfm/ejdPtW8QnVYkOo
	 YLppC0ZvwGkS7y636XbRO5Ru/eOcxUuXnEfE/wSLg5UqPm1uMw7DdN/6W372nIgrSiQL8
	 ANsXfurEaOwJ41OvS/63xElpJpV/hTef5moH4OHf8AMbiE6PSLyxJRaR+KVYrAO36/uYY
	 Yll7dI6VTHFi+ck6QRDKccnArckBC23/dtoJOK/SKZD56UP5YiKr8VlVpIp1lgIiFLp1n
	 ZuA5poiTgx0c1gTHwmULfaoNF5HqIHe/hAGGsELl5ERdB9qXnsB3fvD90ilWAxs+yTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538441;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P5fko3A9W0gmx80fHOluIXSlmSb91oJTUY13Ek4gCSw=;
	b=ZupIBV3OsIQHHALvaVSlgrMdVELH+kcRnfoVY8lFxV5z59hoJyBvf0knhIUww1cgRNhE
	 oTHt6IbYcORtCQKxjj+GRZpg5wSmDVHLuoypKm4sy8bZPJvq/f3XKIY6Ei/xnGipAS7Mi
	 GXu8oKBvAu5N8M5UGDyFOjE2FPJzgr2cBLkbax3YrPhBer9qdhK9H/+elYfknFXyX1ggG
	 4nBH1O61wbY+a/f5X+tGwSHa/9bArSbIiQoQfPwI6vGvlByO05quzZlcUAvapOcyxarMX
	 xD+eIJigNCc/M5tQvw+q2aEhc/gD39SfBN8sfGk4LZN9zQwVRqLktThLzhu8VUwQWTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOO3im+7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="Ue/UIrpr";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF50606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF50606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOO3im+7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ue/UIrpr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792538440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5fko3A9W0gmx80fHOluIXSlmSb91oJTUY13Ek4gCSw=;
	b=gOO3im+7T0jHqNyBUA7byCUMNLOYstoaaEcnNT9tJ5RX/w3lur5T9o0cVKvOMiq6xtO0vv
	De2cBvJ7zHO58oMxNKQaLBWOgLmJoz36/avKeZQCTVIxOdLgc4vtY/2gUnQOq/DGuWXIIA
	JVpkuwnqduv9V6jVOVtEj6XDxYuBcNM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-LquZI9dhNeG2oEsS9mIL_A-1; Tue, 20 Oct 2026 23:20:38 +0000
X-MC-Unique: LquZI9dhNeG2oEsS9mIL_A-1
X-Mimecast-MFC-AGG-ID: LquZI9dhNeG2oEsS9mIL_A_1792538437
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dff112181so92405f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792538437; x=1793143237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P5fko3A9W0gmx80fHOluIXSlmSb91oJTUY13Ek4gCSw=;
        b=Ue/UIrprYHR+2XIIAYcBHSmjkR7zGegvXtlSz7Jt8tWZvBDV8M1fah4wIjTmd8Cp1n
         q9aNpJ3rq3lPhXkzt1sjaOZIfuwvzjDd4IpgGyWH2T8vooQDgdvS7d0awY5X9txSa7Qs
         f+hzeanNcZOYNbByt/VTBoJ3RNsHq1n3ReI25+2Cd2uqRKHuwxi0b1gdrBEM0leA6LQO
         kGw5k9dxv5yyxzu1A8v9bJZMBag6GexyX9ytTg0NkNcZZPDX9Z7tFIq/UPP1RPXnvadX
         QwjCDwhVN8FrTSPuuN0X45t57WwPrrj1NCSM1VXnXeo9VC0LXaS8J6yOGA3p8qiOefz+
         u9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538437; x=1793143237;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5fko3A9W0gmx80fHOluIXSlmSb91oJTUY13Ek4gCSw=;
        b=1LFhEUWV7eHjdg25iYMtcadqggHE/vTb66PjNbMVGtgyaXstXUMuZM2tSuTT7tid3s
         8iAkMcp6IpHY2Mux54/uob6CKDl9dBlc2Ht/JWvMGQAWKetspIkI7s9avxd4AfENKqP6
         dE1HY8s9U+XYL9VM77VROFvXBHzR6BmT1hsUpVxKaWSaSZsy7E0X1nsW4uZg5E1saVcE
         kNhTVd5gsykCZxXoj//hRuMiY3yG4kQf3GbEc2GhCFavl9+SLGwHmMndZIuIx7RBYGd2
         5e6M+TtIhSMvx+/VDWhzlPDcroy+2gm57oqfG8dM3Az/yAn5S1gTT7pWaA6dziLY5gng
         M8MQ==
X-Forwarded-Encrypted: i=1; AKwUvBziuigaG8nncyKVgkHkGXff6E16MqB/VDcy9fW9ncS4I7yjOvhJj6YxbacXPEJpLDsBkBcsLC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmMBsO1nuXsxQ16RJLeF6SeHEtVpiYUi9B0IvhVMRj13BQ0x+R
	Veb+abM8gGhVwSRYJVKS0hAKqT2K4NBnFSysmzrt+e6IlrNd7Sqlcff7PrfaMULmP4LphUAo+SC
	x2TFph2IQ5GQv5tYOybSKCJRD0Tdbvrm3AeajSr9qLXjUTyJlo3hk/yf2Lw==
X-Gm-Gg: AYBFou0Thboy40SG7yRa1mCGcn4gxDIEH6K+ZF+9YWeKH5rYsII6n3x2blKLGU+vpDH
	1wIwZPhIzrb8Ew6zC5MnGZFl7kk++AZXCFXePojwY3BKbsXeX8OGs/s2tjbFBXWZMpSK3c0iDcb
	tjf2iuzdSi0V2bC3/TtalV++A64XjZSuVgOzZIp3x/ohjNcDXySWyW6ZNKOUGcoIvzesvbVVyUH
	PEgcqG4ny3aorlJ985o97NXfmvkL6BlwC0Kf9DQNAF+884McSuEre12PUFUac+1itSFn601CWyr
	GnzkV6OeNA0yhMmjZFcDbzPC1xyP3GhnRvNhJ41Mkl5HQSugNGWcje69dgvyD45RbxDzHQ==
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id ffacd0b85a97d-48e2642ce22mr436291f8f.2.1792538437173;
        Tue, 20 Oct 2026 16:20:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id ffacd0b85a97d-48e2642ce22mr436239f8f.2.1792538436673;
        Tue, 20 Oct 2026 16:20:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0a2sm1544348f8f.10.2026.10.20.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:20:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:20:31 -0400
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
Message-ID: <20261020191918-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020165610-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.34b42ddc625c5@gmail.com>
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
In-Reply-To: <willemdebruijn.kernel.34b42ddc625c5@gmail.com>

On Tue, Oct 20, 2026 at 07:13:42PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > > +/*
> > > > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > > > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> > > 
> > > it appears that they take the mutex_lock below
> > 
> > Some of them? But
> > virtio_net_hdr_csum_check_disabled doesn't, that's the point, right?
> > 
> Yes, but the statement is then too absolute:
> _some_ (or most) readers don't use a lock.

don't use->don't need?

