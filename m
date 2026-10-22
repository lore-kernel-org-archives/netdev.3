Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699956;
	b=PShpV/pjXPpxaEDh97DkhHV+hLsVtdA1sVyroPHxb6ADeRSDHgNw4z7dxBoKePirvbvo
	 7ZBciR5oc80ea3xHWkwLA2pxHszn09KmJTcYGcRKiee5lfzmlw2Tf/BrCa+SXUY9RlX3G
	 lxP85FJmdY14M/R48K+/1AMtrsZxjja63D4SKsA1LajrPhDkJuGseE4rFtl2zx4SPEW/7
	 0BM7jNK7iVOhXeQ17DFxOGZRuNOvbEBgTyhNEaooxlCuYU2V3LxXpJHFJlQAIfTnhoqTb
	 tMwXJ2on2pXl2xnI8yETMYF/ADwg8+PyHARkD+CpffCTsFjFKGYCFodv3ksHcFx+/Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=I8JrjL/Toni0rgHeKLxMi210agLPfR373jhOEmm9NDM=;
	b=3IFor2n9tvyrqJ5fu3NpbwLQl9kLvKeybPN/lu0LGE71yBVwZEnvQRM6XGoQl2VkEFSO
	 8sUehOTn6vbXb6zrgUK47+GJBiByRhQKhuJBH8VnHplu5JjxwlpElVEtPHugRSyF7KuVH
	 6lnLc3PLd/9L1Fzpkwgz8a4fuVpwHQfTi+tQzPmCLgHL6naymPj1buhvYeNT+NNQoHkhl
	 IvlYath49P/a54mKlirknQv2Dul9GhaPEKR3M00H9h9+MZcVPZyTr83ilp0wN3/y3VNFy
	 NkwxnROnG+0GyzC9yvPVkpda89WD2qKfpUiUZh1oLJRnfNwQQv4FsNlu371ceajOFIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bEf24BE7;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCC606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89DCC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bEf24BE7
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5364c951da4so1325841cf.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792699950; x=1793304750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8JrjL/Toni0rgHeKLxMi210agLPfR373jhOEmm9NDM=;
        b=bEf24BE77jeSVrye/0K8bqAhBtq3l4ipVokvy1WTo9I171dh1cPnLebWZP98ZbHc1p
         AY82b/V/Z8Ber8ZWp8VUWvVQdVKVcws1+qTT8I1nIkiiUcBGdUJt2If+NgtXZWXT8aBs
         uKfYqDijGgrn/rN6GkRbg/nS7tyReOXZC1wz27PGG3UX69KRZ1voQbKcO/EJ7VCH+ev3
         9w3+gkzOCiUWskxpeRuVsDRp3YDSWCkTFq4QinNxLt/YPbd0DW10RzKL39WEfK6b51Xg
         gE0pjKAlKmDwW9sqvGKBvCi87C9mbwgaQyyqQUYs4WaTKD+zF6NXq0IhdXGPVmv9ZqYX
         i7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699950; x=1793304750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8JrjL/Toni0rgHeKLxMi210agLPfR373jhOEmm9NDM=;
        b=wk9yNuiOTzZDrA3mKitSHAEw2qeX8tgnJTraXLVnfGMoK7EZ9RbyzJLKNhYb1QBkFC
         QTuSr4pgZPp1ZXrkGsI7aHTMR0AlL4DrcraXGCyv43O93aHEUIuZoZUsL7c8jKlcjU1t
         ipA7XL+wr75rLlWwhACm/poNP4VLxJrjaiPD7XMF8zEwmS28wi3IlN9sZbug/9qsVZsx
         kDNe/Nue0PKVeO+8DrRkkfzE9ElNWTqYhpcQsGWXQey4KZwH2LX0syZgZtZ/YPYkwqta
         rSPkHOSSuHK/cqqPcBfIkVWMt7VpkH44sXojbl1MVYuBiwc7ktHJGp6QAX9wFAQLgjd+
         AkAw==
X-Forwarded-Encrypted: i=1; AKwUvByI1gXX/4aZ4UIvhzhkRV7uzOCq1WeAsd/wvaCfLMsAHfpTukJfVn3R0nYRAs5+l51sZJmSAdM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbX/84euNFbpiScEXxcWNorwe9kNuoT6hAnt1fRi4s2E4AI38w
	WBIvGOptU6WVO7GDHijesC4lEhdm1GFeDbhBKWB24XUPgUE8t2vUdB3gM0jKQTDZZ3o=
X-Gm-Gg: AYBFou2tYzFJo3YZeCOjCLX1X6WIwuanw8Tyd5dEkoXKyDFwjETmRtx3L/sheME+7MT
	nZscVYaS3fT+iINgJPJNgNEq6sa4/tLMQg/0aLyZ6aFFcWR/BdDZ8JGewUeHnbNM6Us/8mzogxK
	Y4GWchZmcprN4R/Zc/A7Ut8xpBeIwxUK6O5DKzO1FfuCo2TIGVeOa/xxlBzW/2g8Y2wooJvl928
	rU4sJVRejWNM9kB8dPDVGszKLB57IA9Ey++SzYfBwNtqzxBcL0UqrBPjlfa8nFX4xYhOWKsBodk
	Srx3YTL1ch/r2dFguaHPlXSq1yIg0GytJQom0pK4umSNRU54rDL5f4tqyQfJGzINrCgHboN4RBY
	SQ0Gn/rPIVetyAycZFNSR1kMXKP4W12URK+tCND2UuzueRPsAU+dd2XrCgpihanDngK93M/j1JQ
	HL7v493MBgUkInJX0HhlJ7maBRbTsDY69gXZtHy+jJNnK/IOdOJnzizRFWKA8/wEQbOEmZKxdvR
	jMogWGG/ugoOG8dPnlLHATOGgKC6OQUUqtXAco15z+y5WbCy+R41NXFV+7ji0VDiRAU3E4Xvf5Y
	MJxgOnhvq56Nf4/8Vm1jcqIJlk4gdMPTCsn+KA==
X-Received: by 2002:ac8:5a85:0:b0:536:6378:c7fe with SMTP id d75a77b69052e-5369b8204d9mr99553871cf.47.1792699950468;
        Thu, 22 Oct 2026 13:12:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c14da10csm1768631cf.0.2026.10.22.13.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:12:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJz9J-0000000FoSN-1XEC;
	Thu, 22 Oct 2026 17:12:29 -0300
Date: Thu, 22 Oct 2026 17:12:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Luigi Rizzo <lrizzo@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <20261022201229.GH3381610@ziepe.ca>
References: <20261003212241.3432303-1-lrizzo@google.com>
 <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
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
In-Reply-To: <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>

On Sat, Oct 17, 2026 at 07:11:28PM +0200, Luigi Rizzo wrote:
> > We should probably just find a way to describe that this is a POOL that focuses
> > on physical contiguity in some configured granularity.
> 
> Before embarking in a global renaming, I would like to get opinions on
> acceptable alternative names (possibly with a short prefix usable for
> identifiers in the code). I could think of the following
> 
> DMA_PMAP (for PreMapped or Persistent Mapped)
> or, ahemm...
> DMA_PISA (Pooled IOMMU Superpage Allocator)
> both using dmap_ for internal name prefixes

Can someone explain what outside netdev would use this? And why you
couldn't do this in the netdev page pool?

It is not a common workload to have the DMA allocator be the one that
allocates the memory. Usually we are DMA'ing from memory that was
allocated someplace else.

I think Robin is right, this is just a special case of the dma pool,
and it certainly shouldn't be something as grandiose as a subsystem..

Jason
