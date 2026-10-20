Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529824;
	b=f9WaFCTpN2M9/5Qcql+Wd2rqXyqosGJTxrtWDRuVWBfNF+kH+juyXYaXesqiXWwcZEKl
	 /kF68EQSDZWgPCEgv5Gt5zoOEsAo5zicO80edCVMTwun+TQk0DgEBpe/B5BhMpUWzWbSA
	 lkV8RfgQsrZ9mL9Fo6tzHKP3b59qBPZZ1oMWN8V46SEggjhiw0nLxYleZYu5xp4ukoRyk
	 sTFTl+93MKa8kKKiY1wdv1rN3OedyiXaikmAp2/xq1FZvL0oXGv1vPNj3cKpCB6IZL7rS
	 qh4J1S2uoKghxxILxQe1OBJ9tYjlmZZ9OITDgArWgIe+QGPyqb7LdBjbFaFMKq2+hLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529824;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cv9aRKSX0/tOF0YOH867TlpVtpIDhyHmrDapDoadVQc=;
	b=S/W3KIsp7FX2qeEz2io/v2vDX3qQ6H4FUB3xb2PPfSWyPslfB/dwL/MBJr2MmNTzvS4F
	 tsGd9NbkwyzbWJmmoLPOnZv40K4/Sx7cm+gRblIk2dfDMiENoeqncgw6MmQP1YUKmRFrm
	 mM2AhEKSzFlSKslAp26QXUKeTHNvQuEIMArtBtOAPtHy7pj+hc2srWIZLSBW/CL0Z8/c1
	 dekveHtJ0YRNI1JI7iIpARqZyCy7Bns3HprrxgD3iWoyQSrNx/vkFr7Oq0yLD4vshZqx8
	 8UBpBozcENbGUhcnSIT/NLbxxu+iaULlcOkTr19+F+YZNIv00vB01kHOYQpEr+7gGPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XBZ4qXyd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KUl36tZ1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109A606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5109A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XBZ4qXyd;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KUl36tZ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792529823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv9aRKSX0/tOF0YOH867TlpVtpIDhyHmrDapDoadVQc=;
	b=XBZ4qXyd6Mir8haawWSMzFaSPVSkCQ+6dAxWSJiR4LbTD7Vfjv8FDsaXzlyhBGNwRkVu/X
	APODIbMVYalJwHcWWElGkJaTTtq0IhGcUumd7Xfq3g74VGIKS3D6fwNHmrs2EBgq/nAsTM
	Unrkad0ohfcHrpb+OX0w4r0wyKQD1P8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-w8Y0YJm1OmqgC1uvDtc24Q-1; Tue, 20 Oct 2026 20:57:02 +0000
X-MC-Unique: w8Y0YJm1OmqgC1uvDtc24Q-1
X-Mimecast-MFC-AGG-ID: w8Y0YJm1OmqgC1uvDtc24Q_1792529821
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1bfd5516bso345405e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792529821; x=1793134621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cv9aRKSX0/tOF0YOH867TlpVtpIDhyHmrDapDoadVQc=;
        b=KUl36tZ1h5Sc3z5N4MHGz7nzDWCkrN69mfUe6bDalDm2J/eFjYstEOl+ZNjgDbnqpi
         GKQK4jNSDYREm9K8/QHdrV6OJklAdOJNwxb1h0bR9AWRPzDrJyPAPIZ1LovHyJ4rdAU9
         v3WRicQRVTJ6FRris8jHx6p10+Q6GsWQG+pW3hs8QZ4jv6PsonpN452ogV4CwUlvx04K
         SHjn7Ha3XQSYgxhrlZE+p9bM2iWLMfdYc9CWRXfCuybhQsmGIFWM2j9vitA72T9uknbS
         XdUc92eGCc6ZJmFbz9rBnek5YZIV4/oXpWh9k4ghO7Lw72M5q+j+YZpL054XE/i3PliH
         s2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529821; x=1793134621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cv9aRKSX0/tOF0YOH867TlpVtpIDhyHmrDapDoadVQc=;
        b=T3P5frkW8bFlCMCYjtkC0N7q8Ffshc4Bb20kcV0U4Ma9nB1+44jx4DRkI415XD7NzV
         R8+R3nz1YP5XIv5sVfl72N5wUk5z+ydg7aL7rn7OnWwl1oVhqeHVMAzLoxAv7POt8Xdm
         UIv8ACYFeRGILIgcHQtBGf81no3DFjr8fYoUakpYlrY1kexsgRK13c8sp83aMhHriyHq
         1l6mxDGpUPWtUgsKR0i4mJf4hhTjaf5x+BhD2sSIRu1Pg3ufJBj9gEvbbw00lwEFtqBW
         MbXyijsw6CPfloHhCPiVhWCGOhPzUitJDd6EvpvhRSDBWex083jLFj0DoMjemu6XvFkC
         eCZA==
X-Forwarded-Encrypted: i=1; AKwUvByVwD0a2joP6VDir6uSuOdosb3XVtEPI10jy9PJ5pCB1G5ZQ5tsuZurri7nuON6qIMeGFRNmZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYImwBsO/N5cvXmtedHJIEHQ+XFnvnDmLmIniFDC4/n594dg6XZY
	XJ2CTxeXNqvnL0XEtEndl0EMZEr/gg2ffBKLFqmwWWAjD4F2r8aTSg/KvXOwRUr/n7E5mHR+Cx/
	r8DdLGxItx2e0AkFcthr2MVBNRKFm1KXiHDHoDY+a/W/krppJEuhUBdWt7Q==
X-Gm-Gg: AYBFou3b8e2ldmXIvNQbdoIiIpjnZUxj9d6vWwmotbd3JLdyRZLK7RyNf16LV+HHABS
	7iIMO5SdZhbI5KcYxugYDqPcnvseN70VePh2NMJIuO6YTXQT13k3+azd7J1luY2Bcnl8dwUTlHx
	bZ85K6lAJEX7PsS/+P6ifce4EsCYpoAQfTgoijgaN5O2YSdMyWVj1bds8p5Yn+aTRHfiQCOX94v
	bfBjDZd7dghEclqnpoflMpKbf3omQKLxmiuJ4bXGwtOWG6uZcjsdmg8vT8t/oRx8py88b9DK5+/
	Vv2SpAckgczE4PYEzW0fvkNXpPgqSBAMMhpdhCwVmlHcWhfkJMRblIl+vXV9ZmXyjGPKdQ==
X-Received: by 2002:a05:600c:888c:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1eccb55d9mr101082655e9.6.1792529820686;
        Tue, 20 Oct 2026 13:57:00 -0700 (PDT)
X-Received: by 2002:a05:600c:888c:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1eccb55d9mr101082315e9.6.1792529820216;
        Tue, 20 Oct 2026 13:57:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm865375f8f.1.2026.10.20.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:56:59 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:56:55 -0400
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
Message-ID: <20261020165610-mutt-send-email-mst@kernel.org>
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
> > +/*
> > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> 
> it appears that they take the mutex_lock below

Some of them? But
virtio_net_hdr_csum_check_disabled doesn't, that's the point, right?

