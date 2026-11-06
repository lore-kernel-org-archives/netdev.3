Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988438;
	b=BISWOfYpLp0+bTyQYPyEL4iFNI4lOHOy3I3Z5IfCqam5YPT2u91pZObtmcuaRFPLQNiZ
	 zaoZ/Qe2qggatYJH7JqMgdSYr4JkOX6/djupcM2RPgVhIuWNQdYH8AVtYqYvpwXeltqQE
	 7yJwMx8av41mbDE5piATf3keSTMqhE8Y/VgpJYOJjBXs6075sC4n6gDV85VwOrr4WS5CJ
	 BPGQcILKmPpJQ2TckMGrHPFOJTUfa/4aDsYR3W9oIZ0NnVY7w4i27DAuqz5Cl0Jsg3zyq
	 MLoCWNJZW5CDP5MDGQKQdxo+HKAMk8mFUxwFcvEPpFYjJKBgsQsyl0MII2pPRsz5V2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=xsa9e6MH9/SVm3In7oNjUcANbgdM5Ae2hGRi/O5LwW0=;
	b=i8syIh/c4Qap+CKCFAKPpBxsBt9KD23gum+G7nTUZk89yuQPEi267EBMzWRfhL6lMDX+
	 FSWay1xxntUUNB72RSDKoqM8O0tkBrcVmwl+YXQJO5oOoaFjhhX5KtP4GM8do26D50K8p
	 9F0UbUhzX5VBc6mFWcbIli5XLa4Fl2c1ehxreX2K4NffSb5UGnIcsqB5/hyqMQXblQq1u
	 k4sJPglmdn+oLinz68p0MMIP4DKBghBS58mEyzH+VimWeO+4td3o1o/CxIkZEhRfiDZs0
	 asmHVG4HVOZimPbsz+yxy62AHaV2+XwJSwbuVxhuNvS7w5r9hp8NHD66MVJsFGJvwEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BYMekOj0;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90489606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90489606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BYMekOj0
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53cd0c8614eso6715491cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793988436; x=1794593236; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsa9e6MH9/SVm3In7oNjUcANbgdM5Ae2hGRi/O5LwW0=;
        b=BYMekOj0YLKZhnr+iVGVAmGRIyI1upa42CJ2T3XGuUPONpzfjEizxnMAOBorEIuOvt
         V1tD4WtF3cdKq7HNBr+RNQzsb/8dpXv7Slwh9yjySJem6KxDRha+0toC3mRIxyf/ljjW
         KZVIvbK6BTagUCEHSISTBvF6BQZ1G4UOX7ZODh58bbOrYjUZMTNeHuP01AJnpvZgj4nC
         0Z3i98k+Z9rwCS13pUoGAc4M0umoAHIDKl1uiYTToR1e5fna9zpBJhou0SOh7EuCwmDM
         RqgKGYL21aCr4GwV4a0eIUgUtZLCX9ixOJnCJIOFwdUIPE9ou9ndCwK0k8YaQCIV4E+d
         +zTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988436; x=1794593236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xsa9e6MH9/SVm3In7oNjUcANbgdM5Ae2hGRi/O5LwW0=;
        b=HgcJxk3qn2g5RTVkfX1OPu/sLMhpBIR/UmjvHNQJ6zqCm9Mcm+IlLIAZkkf9H7ZG/l
         yWYDwEL1Gf+EHkoyggqkYKNwPvu75xlWu1eRztTPpz5CVfIkX2EGQWDFShi/RqBfdfRG
         CEbWzbwdV1pFuCiSDr8ArEsuCPwfR539NSaeszx4xapw90VCHKYb90rHQlQWDnPzXXl8
         CbS7lQMspHjl6QqYPd//FWcoC+kmk3Zprn5ZRMZ3iHK8LQgMc/1zsEJJAcil6Iqxy1st
         UBB6+Q1H4RScqfNa00mmWBVo1N6QqIMlyTTKLnEHyIZw+p86jGILlvNWyS7pmEpia7b9
         GzRA==
X-Forwarded-Encrypted: i=1; AKwUvBzBlZcvdlN7JMNX5VnSp39HUW6k/ssXz9WUiuhpkXi8ozwK9YvNAXeS9o/C7peFF9f2HXSm5jA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XphFoPCKwG19qMMcAUZYB4AF9/xWZQlyFvgSjD0bBhFpIfAm6
	pelhu8r7RDxlhR2pcYdpEm4OVw1Q8iiNt2IS05UHR+TIUQiqez2kMfAW3dtznJ+CJy0=
X-Gm-Gg: AYBFou1gBfIDymyKkcdulMR/Ux7DMxcXf+CGSHv9eR8g1q6/6bclY8qGxMBpODNIQEO
	i335TlNvZOUjVpgFZg5PlQjcGvGXm/t8eFgs2OvXE2G5IGGlSfEuc0Z3OHAJGjUJd1+/VqDJOXi
	x/XJBeowBXLMAyUbuAivBopLIFzvZkLIuYT3CniuefC0ryg58mpN7RqRGRt14VkYWFYYr/v/LBc
	MP+ucBqu1TA3TpNR9VT8kHgjVA27tAFnz2chjlAVWz4ZJ8DWmpxoGBSPe+qeBJH3dgM8LPG2HZI
	OgB1NBHCO42QlCTlplyVJMOFek+/HtLrnTzenLLpgN90vx8sV34by30nnbQR9n3vSkJMKtGUv/G
	tVZZIEjQJUZjFMck3V+TVzhzaTl5aWn7UteY6x8HhkJmgGshbQRlvWQsJkjEr/DG60mVefemNaq
	ll6iBmZH6DFQgFVIOQzzAGBlLs1it1pO/jgURXoalxcMqNCOK9QgrMgegDmUoE/iGelfnkduPoe
	BM/CsN8L6WCbDakyHhct5tNi8oC/ovvClQyVeCXMlezr1ApHrj9kAKf5ksYNyB3lFSh8luHqx5V
	mQYZlOa4f/5I+b+9hf+1rUcNyh6JMVHfjuRQ8YJjbJhjd3BJJ0g/fUytoCbhbEZ8Yc6ELDLrC2o
	kGGOyGUxxIw==
X-Received: by 2002:a05:622a:480c:b0:535:a5fa:edff with SMTP id d75a77b69052e-54e15b63c63mr47814391cf.63.1793988436090;
        Fri, 06 Nov 2026 10:07:16 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e231d0710sm26555871cf.2.2026.11.06.10.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:07:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPOLK-00000007CW0-3s9S;
	Fri, 06 Nov 2026 14:07:14 -0400
Date: Fri, 6 Nov 2026 14:07:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Naman Gulati <namangulati@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Luigi Rizzo <lrizzo@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20261106180714.GI663069@ziepe.ca>
References: <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
 <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca>
 <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca>
 <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>

On Fri, Nov 06, 2026 at 10:00:35AM -0800, Naman Gulati wrote:
> On Fri, Nov 6, 2026 at 9:31 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > > I drafted an implementation [1] for premapped TX and RX buffers on top
> > > of the existing networking page_pool. It is implemented entirely in
> > > the networking layer and extends page_pool as the default RX
> > > allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> > > page allocator code. I wanted to understand if this implementation
> > > correctly captured the feedback on this thread. Key components of this
> > > design:
> > >
> > > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
> > > chunk is mapped once per opted-in device through the DMA API and
> > > records its IOVA for each device, rather than using a shared IOVA
> > > window.
> > >
> > > - TX: page_pool accepts a memory provider for pools that are not bound
> > > to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
> > > of their NUMA node; TCP copies sendmsg() data into them through the
> > > task page_frag and allocates its skb heads from them.
> > >
> > > - RX: an instance of the same memory provider, sharing the chunk code,
> > > backs RX queue page_pools. RX chunks of order-0 pages belong to one
> > > device and NUMA node, and are shared by that device's queues on the
> > > node.
> > >
> > > [1] https://github.com/torvalds/linux/compare/master...NamanGulati:linux:netdev_dma_pool
> >
> > IMHO the netstack should never read from shared/decrypted memory. If
> > you put it in a SKB you have to be sure the only touch after that
> > point will be a DMA read from an untrusted device on the TX side
> > (sending it to a trusted device would be a fail) and the final copy to
> > userspace on the RX side.
> 
> That's likely a fair callout. TBH I'm not very familiar with CoCo and
> will spend some time understanding the constraints. I kept CoCo out of
> my implementation as I approached this solution from the overcommitted
> VM problem where we are trying to overcommit memory in VMs and use
> these pre-mapped pages to avoid using bounce buffers.

Why does overcomitted VM use bounce buffers? Do you mean this is
about getting better memory clustering in page pool since the VM
paging granule is 2M?

Jason
