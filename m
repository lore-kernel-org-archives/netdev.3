Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986263;
	b=GOmSRf1cIzwxQvBLiHMZ8XReWMAXfsD6rtsaQQBMuEtukdoXTsw13Sw8lTaen5BZuPM9
	 bsQDDXN0X7deibSMUrh9Lph4dkd8cmiwdp0JQtHeOM9qEPziQKhnWUs3JhRDwVrlNHTdV
	 UkGNrfI2FI/OzZLqaEgm49AcwXQ+zzrm+sBEWZrjJwHTw6qQ1lGgpYE5BbZNRTK4FztJU
	 N5AhS++gqdkH9XJCGRU36n9OHDA/5zLJSFHfVb6EUzyXqZsSZNjgKCjCu4GJs+PPH+OAN
	 eoiWZTpJLZueGNC/PyPsFSQfh0l/4cwE9NufoKlJ0CWy+buvsfmVUxoXT7AVK4b78Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XofOEQXNLqFn+X/AdUrRbjVcp2Tpjks1Mv/4b0yulcU=;
	b=bUCpLqDurCRMAkl037oRu6S9aOoH3s0/BAkZie08FaRICoo5SStncJd+K4l9DBrsY0az
	 bFtKf1zXTjHKeqc0AAbJf94FH9Rny6agVuCogZA8zpMt/IUR1wcAyVSgPmw51TgEDCMgt
	 tZ/QqaeLHwvsl5VGZLq868qupCYhlOII5lHNG0u7CcA3F2ZBdCcbKr92H/jGS7SDnexGW
	 TvnCktPlAmDLwFUpfA+dfGKu3h0hYMPYfUxvLRFyNNIHDEomITGVMOgPgJ0ItuJIN7nYC
	 66IpjJRd6g84NxvEqqS512NqB2r5KyyI3659i9IMS8VFMMy/BYYyCTk3yvEH0ALImsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fYsE2vYt;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64E606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF64E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fYsE2vYt
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91eb5559b34so3365846d6.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793986256; x=1794591056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XofOEQXNLqFn+X/AdUrRbjVcp2Tpjks1Mv/4b0yulcU=;
        b=fYsE2vYtjmjwrQWdM228+vJrfQI/zfz4d8EZd9hqS+Da5DuaJIGJN82jYUkEQnAQXJ
         276pcvSkMpyOUA88uoZqfJepcWaH+fDLM3PeHPPLJDoYLRuQUX7KClXiaMPEZf13t3dS
         8XHZFyigHL7ZxZuRJehfyQvVfxcrRxiGZrEzmXaZhQ4zBnxGZXUn9LMEIWIf5ZX+0oaj
         PXesfT3jlDzAeRSoucM4rkP6lStrPSVTmMAUkaFTam6eIzVTnLRJ0Bq2t1kniLeeSNAI
         PChUbgBgn1IddS4SmfD+bsmAlxXOMcHOE2hRzkm09lHStjx7NS5P6SVi6CHEW1xsdg47
         Cdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986256; x=1794591056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XofOEQXNLqFn+X/AdUrRbjVcp2Tpjks1Mv/4b0yulcU=;
        b=r+zRr6Xv4LPmjFz0hogwTqwt56hopQdurlzpiK7Lpm0eNOknUZ+zAEwbmfBnvDvgI1
         d9NS35GRr1fxTs59XI7sa1CWwpT4G/YfkksEnuVGbMKFZXmu0064KneP79BcgeVykAE3
         83l9gyo/zaTmVL4uJe7J//Jsq4tCqTyHPJubsc72c8Y9oRLlCJQXeiHR3NbYw5OZg+Sc
         o+c90ShjyRni0dA222qSvfAsO8zRRrs/6Wr6WN969kllrEdiXMAytyyFjGKfgOlObTMn
         /9pPoZhZ1+ckava10wabGBl7pbjPpRHai9BcZfxHrTWC0DYycfWgIaVy0zbszykNZae4
         3GSA==
X-Forwarded-Encrypted: i=1; AL+hErE1BQIz/P8KbfLRXjuDKAPdvhZD2HsfCOPMugvY++6N/AB8uGEPqek+UTzTPZQ1e1FNXKDCfVc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JasXDAJzUMY0j+D42Saa1qRzDXTVvLljqQ7h/Ih2fmMc+s4r9
	XifkVTPUlTBrVy4RqivrXQPzKBjSnsp5JwZXDnTwFshmFge05sRrs9lf6/qiFuBdo2o=
X-Gm-Gg: AYBFou19qGw6KaT3DdQfv4SFwnMr2A7sNAChf+4nj0xcO65BKos++1C+MPm6XDRi2aB
	EG1isVAUNb64QlPISwwpsn3wA8cLNVolG+iW0YKMyKzsBKltxb0NpkCpNeduk2BKE1Ivmy28t6O
	gwee8oEFvT7CuHuOPSNGFo4aOLExWYgfKTo+eonQoYOO/tFNfAxBy0V72sbobW7jUqqHqq+zO7q
	mmGPo0BvBWyw+MKaIU5Cie19jtC6cIEnk4iFIew6fd6avS+2VOltBIMtJjjm8kIFJgmachLNpuh
	+Act6zC3RS2bJctz5Yfi9dAGvPuXqBPdzgYZXRBMc9lacUnbyiDui7NAL3vlqks+mgfrboTECM+
	MJHNa0dD5pvw+r667GifTmhXHfiJtCYnT0LnlprI/f6ThqmwGIWzxtzcPl57LGsO97qd6O1M9Ob
	G3x4TPkqEsLtLlrLN7MFyV0RQA46+/LZriiPYckHWo2SnPfv7lR9skOwSEOKRqPnKNjjR6kp6Tb
	RaCV4Zz7bYF41GfZIzA7c3/7jsvVLDWbOL7saWpleQePfH/LHTGQR8QVzCi7KSBU5Qau0PeQG4O
	8fgj57DlS2wRqIFJQicPbqUxqw3J2yPb5t5a34WY0eoFyUySXd3VaGOEtGmlEz3bplYkSRJxlOL
	midmzyDsFjZ31mJbS89Gm7slEJDoMLis=
X-Received: by 2002:a05:6214:c69:b0:91c:73fc:a5a8 with SMTP id 6a1803df08f44-91ea9742db4mr40471196d6.9.1793986256339;
        Fri, 06 Nov 2026 09:30:56 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6acceacsm25406486d6.43.2026.11.06.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:30:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPNmA-000000076Mk-3tnC;
	Fri, 06 Nov 2026 13:30:54 -0400
Date: Fri, 6 Nov 2026 13:30:54 -0400
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
Message-ID: <20261106173054.GH663069@ziepe.ca>
References: <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
 <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca>
 <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
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
In-Reply-To: <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>

On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> I drafted an implementation [1] for premapped TX and RX buffers on top
> of the existing networking page_pool. It is implemented entirely in
> the networking layer and extends page_pool as the default RX
> allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> page allocator code. I wanted to understand if this implementation
> correctly captured the feedback on this thread. Key components of this
> design:
> 
> - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
> chunk is mapped once per opted-in device through the DMA API and
> records its IOVA for each device, rather than using a shared IOVA
> window.
> 
> - TX: page_pool accepts a memory provider for pools that are not bound
> to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
> of their NUMA node; TCP copies sendmsg() data into them through the
> task page_frag and allocates its skb heads from them.
> 
> - RX: an instance of the same memory provider, sharing the chunk code,
> backs RX queue page_pools. RX chunks of order-0 pages belong to one
> device and NUMA node, and are shared by that device's queues on the
> node.
> 
> [1] https://github.com/torvalds/linux/compare/master...NamanGulati:linux:netdev_dma_pool

IMHO the netstack should never read from shared/decrypted memory. If
you put it in a SKB you have to be sure the only touch after that
point will be a DMA read from an untrusted device on the TX side
(sending it to a trusted device would be a fail) and the final copy to
userspace on the RX side.

Everything else is very security questionable.

It is unclear to me how any of these page pool proposals meet that
requirement since page pool typically provides memory that ends up
widely used in the netstack.

Jason
