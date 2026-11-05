Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.0
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901356;
	b=jPnIo7jMEFnMVg+NSPhWieddbsk0UP2DoCtVQHkp/qmnhjd9zT7KMlEAAWsB7liyzWc/
	 8S3dzK4wxFQI2cgttTrASkFrhG3q1+Z9+NlKzN4ZRLNCsZfWfTjFWGnxMo0+1d855PzUW
	 2Q/3hIg1y3EO1OalnjAVznD58P/uUCrbQtJYD/xRAFJSVKUuCkFZfynpudC5LF+kyHrqH
	 BKocQdDB+f5qcYcg+BeIB/glmBMAcuvvEv9LD5lpX+lqcJLS83FIyhGR+ckpmRCLha7pt
	 jzsAu9TVG5th/72EGBGsZzn5CYLixHlhsAaawEL9d4oKgcejEg9I94yLQYr9Q8lFNKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KJPkIDOAYDK93RB/9c0VDv3wKCD+7XkZXq4Nusu/JJ0=;
	b=1RQVdjU9xojPISv5QcJfg5e+s+wrdSw1NYxpk5d/XMP3zJ9lt3xxcNsuDYY3nuSVWYPX
	 G1DZwhlsrJWLlv6rs34iPuwUgaAn1n6Di6xC/WOGu8fwW1IKZ8o8Hh/64hlpSv9hFOwKi
	 JRo47SLFo9eghmHbKpT6qeBcREeVq7hfjTSFY79Q7DXkZSgf2i6chrw6rkX+zjGdAnz/O
	 NN4Bn24wIpDkHfxBwCGO93Wn0txQDwRh39kOhgeiePiIH4pF16skeemGPQgZhZEUdonxr
	 sgd6gKaDM7+vS55b6+0ZGJxCggkUJbeBoSCpVXtPqe/s1nlKL4xTCHJjnI8a+Qsxqaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1kTwUwv;
	arc=none smtp.remote-ip=74.125.229.0
Received: from mail-dy2-f0.google.com (mail-dy2-f0.google.com [74.125.229.0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592B606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E592B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1kTwUwv
Received: by mail-dy2-f0.google.com with SMTP id 5a478bee46e88-3117f9b9e64so275655eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793901355; x=1794506155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KJPkIDOAYDK93RB/9c0VDv3wKCD+7XkZXq4Nusu/JJ0=;
        b=N1kTwUwvpB9XGiNqY3oRRDkzMFpGtl/3/7auXAzY2if4gWRYBUHuPntVBU4+TUujkG
         W7jJELMjM/8dRVIN8nB3i2Rq/SIHnr6VLrFzvLb7rxQHGkwUoZZY33BfAt41D5M89+jH
         hxgRIA2vm1sRoXNbc5lwnZBzfH/NSIr0NAITPAVv7u5S7aeArsy8IefaR/+uMyx3XMBq
         mLyXgvolIQ8QbxRTvlRYD2RpHFWsFLg502wzz0gs2+mflVzlv1OyU2xJSxhpqsRql6JQ
         lzH3vQurUPNHdCD4wqRjKVppVCXRrwDctcJyqVt8TV+Bp7zj6pzbUE4ZfVvOb1N06HOI
         0JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793901355; x=1794506155;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KJPkIDOAYDK93RB/9c0VDv3wKCD+7XkZXq4Nusu/JJ0=;
        b=BZhEEQR5jzI2rPGFNJDLy5GOK8VPMA3eXc5Gl7fAbIXR/16JXxxKjQJi5uFja1zEXV
         i2Nz4iAUp+7ZngsgF/ClZKdSE78hfTXXEEl9jSSk0cC/5AbAbVjsCP/Z3ZQd1+8+rhYu
         0UiWV3dOMjkqb4cR7tq+mkmLrqpbdaVjzOw9E9X+Ra1iCaCCnOOfJJqMT1wjg4ga2Fjy
         saD4GjIQd4ymKsDi264cqqnoZnAzDz0cyHwHWBbOErfzXlnCP/veO8oUCG9CaWVRgR+L
         u7c8mkrZxvnQFvXMIYc9oPxiJL61RWriBCpsUsKYWNb20/yu8mjP2YiCfyvJ8dj7vYcp
         34SQ==
X-Gm-Message-State: APuU4Z9OBwqyL6yzK+fEwHjX9+BYjuE7eo8WDf+CmDR1K0rQUVFRnRox
	LsGeoZRE91zV7jsqKjnythxIAalKlVZuPCktNZote0fZ1Bpta1MJu+mg
X-Gm-Gg: AYBFou3QJXiR21DWdRHv+wp5JDPFKnPtwwAvj/cZTc91HXZg6+eRpwE2JIcdrYBrKAr
	RhiLrLle0wd9112KHLKROU5/vIM6/+auXgUOv0ve2ZRtVFhH2VRxw1pL4b0laOK21EAe7fKFgOC
	TF/qGiWZE2pgIP8bK08VkHRs03Egjm/JO8BC4bQp1ODEg9g5cFyzoTI+Il21GD60izHBFCW7Q4/
	ZOl5ukQOHHtr9YN+Qub5fzTz4r9zl+cEWcjya2mMVNnaUf6+oIQD0OwHb2ZcOAIkZXBQUBbXZ6s
	lTqYbKVkc4jAaQKQUSe984EUxxM9z7n0IGyjOBHcr/ez86z/Vc8/0JpfPmqyfxPCyjzLAxjDHz7
	jq44W5U3+V9pwYM771Q1qkJYX+LBEqNcqZK+MDLukg3L7fgSa6oJjDEa+Dkp202SDz97vcE5aWW
	4mQy4MzlDSxzq69CHrW6ZK0iPjVIolXa4UVH1CGTukN9Bo0eEd/8abrSuSCxYZvRKgXJNE9tOou
	4fWon75qyCqDgMbQ3sVnqQV5YNHSriWZHrSYvQFhDrIllD12G4VweUeoiwkHZjKNDNznHFZYcgt
	JONT2iVheOI8PZQMwgLelA==
X-Received: by 2002:a05:7023:a5c:10b0:1a9:4d51:8c33 with SMTP id a92af1059eb24-1b24f460f1dmr4221448c88.18.1793901354912;
        Thu, 05 Nov 2026 09:55:54 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:65::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b86fbesm18947609c88.1.2026.11.05.09.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:55:54 -0800 (PST)
Date: Thu, 5 Nov 2026 09:53:41 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@kernel.org, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, sdf@fomichev.me, 
	bobbyeshleman@meta.com, asml.silence@gmail.com, razor@blackwall.org, 
	daniel@iogearbox.net, leitao@debian.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: devmem: add a per-device netmem TX
 frag size limit
Message-ID: <auzCRJidvMSIOcKc@devvm16445.scu0.facebook.com>
References: <20261103235152.1904727-1-sdf@fomichev.me>
 <20261103235152.1904727-5-sdf@fomichev.me>
 <18e4e1daa184cadc.3137322e32382e36372e3935.ceab9.0000sendgmr@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18e4e1daa184cadc.3137322e32382e36372e3935.ceab9.0000sendgmr@google.com>

On 11/04, Mina Almasry wrote:
> On Tue, Nov 3, 2026 at 3:51 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > Devmem TX frags are bounded only by the net_iov size, which is about
> > to grow up to 2MB, more than some devices can describe in a single TX
> > descriptor.
> >
> > Add netmem_tx_max_frag_size, U32_MAX by default, and cap devmem TX
> > frags to the limit of the device the binding is attached to.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  Documentation/networking/net_cachelines/net_device.rst | 1 +
> >  Documentation/networking/netmem.rst                    | 6 ++++++
> >  include/linux/netdevice.h                              | 2 ++
> >  net/core/datagram.c                                    | 1 +
> >  net/core/dev.c                                         | 1 +
> >  net/core/devmem.c                                      | 1 +
> >  net/core/devmem.h                                      | 1 +
> >  7 files changed, 13 insertions(+)
> >
> ...
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 3ac700d37e59..ba2f887dcd39 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -12350,6 +12350,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> >         dev->gro_ipv4_max_size = GRO_LEGACY_MAX_SIZE;
> >         dev->tso_max_size = TSO_LEGACY_MAX_SIZE;
> >         dev->tso_max_segs = TSO_MAX_SEGS;
> > +       dev->netmem_tx_max_frag_size = U32_MAX;
> 
> I wonder if netmem_tx_max_frag_size should default to PAGE_SIZE instead
> of U32_MAX, and have drivers opt in by raising it after verification
> (e.g. SZ_32K for bnxt and U32_MAX for mlx5 in this series)?
> 
> With U32_MAX as the default, large frags are enabled on all NETMEM_TX
> drivers unless they opt out. For example, fbnic also has a 16-bit TX
> descriptor length (FBNIC_TWD_LEN_MASK) and only avoids hitting
> dma_error here because its tso_max_size happens to be 64KB today, and
> gve hasn't been tested with >PAGE_SIZE devmem TX frags yet. Defaulting
> to PAGE_SIZE (similar to tso_max_size = TSO_LEGACY_MAX_SIZE above) seems
> safer for existing and future drivers.

Hmm, I did not see fbnic :-/ That sounds fair, let me switch to an opt in,
should be safer, agreed... Will only option mlx/bnxt and most likely fbnic.
