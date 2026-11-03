Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718626;
	b=be5jIG6edpbrrhWKucVbBV4ELBRgdj86QwRk98ozADIHxn64wnj6c1EeeqF6Bx0vkbXz
	 3lPc99ihEcSbzGJAkut5sy5t9fV/F8dhOmJ82biM9qlRAKSHsbCKRgdoxXSV/TJWCgOer
	 35Ah6Prk3qHdnVZ7fdNIRF+6A2cb0JjSFrL7u6TWQOawZVp9ZuYi8j7bp4gM8TVv0Ed8M
	 OZa4W38TQduM1aj4AVp9R3IcagAkypBmJigpJn7Ymo9p9TdMOn2Ss+sG4hQfo9t29/NDZ
	 t9deIn9N38R+BIQsgKfRjRJAx4a2qLK5xHs9QB53vh1/kCJWxx0kEtqQ9neV/4erZWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Vt7h2p23Imler/JHYQ9qmz6AHyS0w7TaI6hUPIpmc2U=;
	b=U+v6iPmAi3WkG4b20UqFyJb9K0NBBF7EoztWzYFdW90zh2wrytqZTGEj24bOVi9f3owC
	 FN6O9Vx42uAZIc4sA6LlN+aC4D/wD2fvLIIqWe+JoH5pnzPLydHQDCIV0tOkJ1vHpyXeX
	 XiWiFyBTKhcdoP3VlLFVfiu0bxdqrvK7TtWF304CuSmzvbfoaM3lkOplclb7V1HzTAT22
	 pjQIgv4+pgjDh7zQtQA2vCJ8EyOZISr9tXu5EbRB4tTqb5ydmYG7paQtGz8YuXoL85OZk
	 U3tbZM76HDu2uHgUFwqlUL5oB9c9yVUYSflHaCIdmKxtI04vUEinKdRHAioB1HOBCEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=M+V3Eapy;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD1606BA24
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ACD1606BA24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=M+V3Eapy
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53653e30353so71765371cf.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793718624; x=1794323424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vt7h2p23Imler/JHYQ9qmz6AHyS0w7TaI6hUPIpmc2U=;
        b=M+V3EapyX+HqP1fKSJAlOXOQNSBl88VyBTDoawq7gz03CsUQazeiC6Mc+WP+qPtVQn
         UsqVNPLGFj0ef4KFNPZ/tU+07pPNs80lTiQ6+n9y3KoIryIZUUn0L7chcMupFsfI6odL
         CzzKK98n1/SjNmyjDs3IfYnctsWfNLJnpnGOHZmE9A8SI8N0VwUOPtMf+WIbTPBmV1bH
         6KQ91X8H80VPkn5TzAK7Oig6tCiR4ItroxMh5i3IT0X0RKXWkI+3rGyo3oFxpQO/Qb9y
         wZtp81G5ndgrxz6ERStz97IUJBMou2SyFiM2zcPBgA1C8yID7aBtgzm3Eez0211myTs0
         WVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718624; x=1794323424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vt7h2p23Imler/JHYQ9qmz6AHyS0w7TaI6hUPIpmc2U=;
        b=l2rNMwmcnSzDOPIdJbFN35o2PfmT9czVtW6qGQQ/hX/7+TRLqqHiJtYUcPedS841ID
         0prci8TqC4DQmCZdMkHY1pCv3v+Nnsb0NL77jk1n8VIDdHetoUXUPr7egUwtKKhS4s53
         UHluaSY81hvCWayetg800SlCno0+RwpC89aomagANEPa/iaXkbGgmntyD87F/9J+i3Qw
         PevI+28e0b0bA5v50LEPu13LoN8hoOlVd6S2DWb6h4SUwMc56UL3n7miepO8YULFuFSC
         A7l9+li83DJ4Iz8CrwVlcEyJK6DAS8IUPnlSzdmZAGkV6GWpGHfvlzFnKvYxdjjeV2CH
         0KUg==
X-Forwarded-Encrypted: i=1; AKwUvBxdwiVepzTQ4cqw8HX/4A8FcI6fdKQCGyAFDdB4uF5kOd+oGDbRr2XIjsM81fNKO+E5u9+WFkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xBw+ZTPcM3RPt3cShM9SXR9FEgU1RgO6qsyjo8o0AWdxILPws
	Ri2FxvylaKnTkgjA+ZEk0pBh0dsu4u1l7GL7wYWRnyv3ojq6+v2EaiXH2ABUKjwTnao=
X-Gm-Gg: AYBFou14UFqz+T0dWpatlmUvItJKRJcciZVTRhiT7PCBGLJlghSkBjwjVSl+F1KLZf9
	EXZOLoqM1I0z6FnCIxeUDmXA6/dWaoK5RNgo2u/9lu4bA5O2SUhni1fdDfyN+NGuESI0nCbGyqN
	A8LTIFBC6c1917OjILT7BTvIYpKVWCT5NtRF/A3nRtH+HCOqbWRR5WnOGvDSsYIVaGT5gtujFpG
	mNVnauuE+RRA1y0n/ms+CWdN49X8aNQk4YBUzD6xZnQtcyO2k3f/MFUvinN1zGQ95y8sdGFJCJ1
	RyxPSZPFRS1yGOrskxBeuPnZ05pf9uOZZEFunRWL2HMTx3WfgedyLijQshH8KzjKfQDrq5WTxRU
	10Y/sB6UKTShefB8yRi7AUss61P1xNHbyl7C0FPwUb16Vt3QQd+3eGHRDE3yUv+e48E2yqV5ov8
	0sgaSUxK17ml5gsHn3J84haYFlzBftXiSJFZK1yinKXaeA+dKlrW/yq9empEbJ4CkPSvWQBxbBB
	fn1bs/jKtNcuvtf7c8fKYUkTNTH/maxJs64nKTKLY0UKmmmuUZ7WRy/8YTsKLuJWByu9KZvjqBF
	556S57Q9+aVjmMOAJxl0tz+Khp94XMR+5JMFAtY1c2wIdsJ9TwSJ+ZxNogi39DbMgvm0IigEUND
	jvgbWcb+E0w==
X-Received: by 2002:ac8:5a06:0:b0:536:26db:d4e2 with SMTP id d75a77b69052e-542b639bb42mr236124421cf.15.1793718623983;
        Tue, 03 Nov 2026 07:10:23 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49dcbasm27980831cf.6.2026.11.03.07.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:10:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOG9V-0000000DAq9-0szH;
	Tue, 03 Nov 2026 11:10:21 -0400
Date: Tue, 3 Nov 2026 11:10:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Luigi Rizzo <lrizzo@google.com>,
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
Message-ID: <20261103151021.GK3889730@ziepe.ca>
References: <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
 <20261103080933.GA4213@lst.de>
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
In-Reply-To: <20261103080933.GA4213@lst.de>

On Tue, Nov 03, 2026 at 09:09:33AM +0100, Christoph Hellwig wrote:
> On Fri, Oct 23, 2026 at 11:50:23AM -0300, Jason Gunthorpe wrote:
> > > Disk I/O is still potentially affected by the same problems
> > > (cost if io mapping/unmapping, iotlb thrashing, bounce buffers
> > > in confidential computing...)
> > 
> > The disk folks already have a proposal to address all of this using
> > io_uring and preallocated buffers. I really doubt yet another version
> > is going to be interesting there.
> 
> Huh?  If you mean the dma-buf I/O it doesn't really have anything
> to do with disks, except that this is the first user.  

Yeah

> The dma-buf iovec can work for every ->read_iter/->write_iter
> consumer, and should be adopted more broadly.  Including by
> networking instead of their own totally weird different world.

I'm not holding my breath on that one..

Jason
