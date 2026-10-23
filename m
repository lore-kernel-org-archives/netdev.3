Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767027;
	b=jQhOZw4wBNUR+L4HtF4AzIsYepC2T9A4GuzAIV0CDzagn/6/KCdKPaIxnOB2MwfSyN2C
	 ebQYfsxaIOW07KH2ElGE4+jsbTXzR/vmUmyCesCcTDTnqov3DrdWTcrhdkXzcNPTRizsL
	 ax7PrYBwuf6GoV0lbVbEKMElyWM8tefRf/uK3EL5In5uoIOX4FYA3GboUaSuDcTDUXyho
	 jRHOUVd+QEJf4SWn83F/1fooniBG5qKL1IPKq4cllpph2SAlP7NuF1v30Ecl2xf2yA/qN
	 CxA8G7FvqOoRZN9HiT3nlknUyLd3uGBoIKle11+EdWhAPJNBiOFQakFESfX8g1hgT2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=sGl5cqr0Sn8jKPodNx0zyYTo2AHNV4DEHX4rmbHeM6s=;
	b=dI9QEwlArGS664BkjgyjzOXfs3zbfthaflvMiRzHLhQ+lFpNdX2NrhuZH+iichhc4fQJ
	 tm5gqqfyuE5KPtDD+qxOWzQf/DmT2cnJDU3LBGiOHVjhdjUjdyGLnJKu8mLhPuiXGvp8U
	 mpXjBb5jmrhsX5BIfCB0/G7+BoEkzG3dnmWhZv1iSWBVbIMYMerIMhVc7RGRXAQ8ldPZs
	 D+hB62UwLgXbXIs8GiN3zOJQaphJuUzMMTyJwfB2wu5Kb+43ZiYInEdRwdO28MVgF3orz
	 TfR26+FB5K9eSHGygQDx7m3RTqv7cXuTaeq+KCI/qOKz5wOvf+v410qL4G6NzVR85dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="oht/bhlu";
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF0606A321
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04FF0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oht/bhlu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5364c951da4so8428921cf.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792767025; x=1793371825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sGl5cqr0Sn8jKPodNx0zyYTo2AHNV4DEHX4rmbHeM6s=;
        b=oht/bhlulsrkJH3crMHISX3U7PHHsEhtuyjDgWfSd18U0DP0sVk8NcMTIoBvpNMfER
         C7uxqiGABaA9kaTZBiWszh5jGZtv1K67LFb7/cCZCHq4FOUTnTNzrcQA0XFVmhPypYDF
         5he7F82pc58PFhOIG3jWTez5dq+ixpLAhtBzApqq33aLJ3KtWO68wLS45Nn0zBM0TSXv
         Yuup5RR8HlPtQsz7Jgcm8vAcacE2MuqH6M8tO47rS9sWbKYKD3ALGAu2q8NFN3WkjI7t
         VfenpXo8Hahb3ZlgEGMttPlUHGC6/yOYealp6KtSs0uI55banFUx+PBuUexPAAYI2ZZF
         HR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767025; x=1793371825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sGl5cqr0Sn8jKPodNx0zyYTo2AHNV4DEHX4rmbHeM6s=;
        b=RB5OAQcXvb33Hj7Vc6hzPONMnYKiAK8UzLLxhXFJ8W5LnqFIjyqPQS0MtuvnRwPkWA
         LDLkB4X88EycAEgCgK2OJxOrC0FyrMKDjenXpUk9CcuvY7SKJTdjlSQSFBnohWNu0IvY
         Jga9nYpJ34a+L59G7afaXJhDCJbnpKejsgIox6kfaFEai/Ha5OK+jVITIA52Bn2wd2X/
         AJHehcU2Gm6XJDzhnqpJJ+aJwBlkw8iAuL8PvJssf9qRwkoWwY4j5RTZXYAG4lcZDD3c
         WdHK3iWJg/M6yqlkBknZLh/2ExzPLvkHuJ8QgwM7FSrjHTvYtSfA9fY6iOphnjFbUGjT
         jP2Q==
X-Forwarded-Encrypted: i=1; AKwUvBz3B9fhp2KuJNzSvOfPetGQyYn1BF81SpWkC7BLGmRwOHGUMJool9pRvEGb7tYsrQm3LVMs2Bk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsr3LKS7gclVkmeNC/mK+i4E/udd7hZGi07ywwKnpKKKeNZP/x
	vw0zDSyYBMQPiM6xCUOC0kHARjHAXQE4byq2yUJHzZSS/qbm+9Ook06fU7VPNlzEuRo=
X-Gm-Gg: AYBFou0i7CCW+AQK1b2LjeqoxgGu+qxHVLfwO2u2K69hWdezHagX9t3r+rz81nwjHas
	0QIN2csyaVmOiybDIIY/y6SvsfreRWiRZytDo87KObyA6na5BZyXneFkaK+ok6yRUxC0RJI7yOa
	CncNmk9tjnDCLK1bN4M46r7NZslYD1NxQsanUzQsIwog4DarjH3MY6pEOUCReUFD/db3NNtMtzp
	ZUsPLN2c2Bnmd5YW4/pBCD7N7g1cdqyKLMPXDZxvkNwSsQkmrxbqRY3Rd6E5SdGOrGSUb+7KZS1
	UZJY17O/LlCEaVkiJF0f4dGzitzjzxWEbPkAO9PDj0Dqvz+1yKxy/mbSfCWakhSzUvnpRrXXgiG
	w15H5UBFbs2AplxDK5uaIGGyAbkqVcwg1M8uLVNl9Y5TNxFKtts1DZNOkBLP9aZtX14cb3wruFO
	ICRvNjrNOnYWiXBdeHYuJPnyn/2aW6RN0gNzerLqc864zArhwXpwXBTVkKWxIlkgFBDbnnGvZPD
	glQso96t9GKss5IB/ydZDPtH55BD8RU5NUdbjT5/aZ4ecfsTXaqLx5V3lPhRx5t7HTDnWU8iqR6
	1GAELETSX3YFHW839JoB2oHDjATLh4MqvlBU5g==
X-Received: by 2002:a05:622a:3cc:b0:536:7669:7eed with SMTP id d75a77b69052e-536c2837232mr34025651cf.21.1792767024875;
        Fri, 23 Oct 2026 07:50:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c1846ff0sm18130901cf.19.2026.10.23.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:50:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKGb9-0000000GkTD-2sYP;
	Fri, 23 Oct 2026 11:50:23 -0300
Date: Fri, 23 Oct 2026 11:50:23 -0300
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
Message-ID: <20261023145023.GH3977851@ziepe.ca>
References: <20261003212241.3432303-1-lrizzo@google.com>
 <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
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
In-Reply-To: <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>

On Fri, Oct 23, 2026 at 04:30:25PM +0200, Luigi Rizzo wrote:
> On Fri, Oct 23, 2026 at 4:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Oct 22, 2026 at 11:51:40PM +0200, Luigi Rizzo wrote:
> > > On Thu, Oct 22, 2026 at 10:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> ...
> > > > Can someone explain what outside netdev would use this? And why you
> > > > couldn't do this in the netdev page pool?
> > >
> > > I can try.
> > >
> > > Regarding users, the next target is disks (not included in this series)
> >
> > Disks don't use a memory pool, they do IO to folios allocated by the
> > page cache.
> 
> I know. As I said I have a separate patch to cover those IO buffers
> 
>  block/bio.c                  |  21 +++++
>  block/blk-mq-dma.c           |   4 +-
>  drivers/iommu/dma-pmd-node.c |   3 +-
>  drivers/iommu/dma-pmd-pool.c |  14 ++-
>  drivers/iommu/dma-pmd-priv.h |   7 +-
>  drivers/iommu/dma-pmd-user.c | 390
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  include/linux/dma-pmd.h      |  53 +++++++++++
>  mm/filemap.c                 |  27 +++++-
>  mm/page-writeback.c          |  13 +++
>  mm/readahead.c               |   9 +-
> 
> 
> Disk I/O is still potentially affected by the same problems
> (cost if io mapping/unmapping, iotlb thrashing, bounce buffers
> in confidential computing...)

The disk folks already have a proposal to address all of this using
io_uring and preallocated buffers. I really doubt yet another version
is going to be interesting there.

> Anyways, reading your next comments, are you suggesting that all
> these functionalities should be implemented as pagepool extensions?
> (2MB mappings and iommu backing, proper allocator of fragments out of larger
> pages, device-less pagepools, multi-domain mappings, pagepool
> as memory provider for skb heads, pagepool as memory provider for descriptor
> rings ?)

netdev shouldn't be touching iommu, it can get a 2M page and map it
using the normal DMA API. AFAIK there is not such a big reason to need
any of these layering violations. They just make it easier on page
pool..

"multi-domain mappings" is that just for page pool because it can't
easially keep track of IOVAs for all the devices mapping the same PMD?
I admit hacking in a special IOVA range so every netdev has the same
IOVA is certainly a creative way to ignore all layering and solve
it. :\

But you could just figure out a way to keep track of the per-device
per-PMD iova mapping..

That said, if you came with some much narrower series to request some
kind of 'globally shared iova' during dma allocation that might be
something dma-api folks could agree with.. It seems like the only
actual DMA API request here anyhow?

That's a bit tricky since it is impossible as a general concept, but
maybe you can come up with some way to narrow it..

I'm still not convinced this is even right for netdev, especially
compared to what Dragos has been working on. The CC stuff seems
actively dangerous. Unconditionally always using CC shared memory for
skbs is completely security wrong. What I have traffic flowing inside
my VM between containers or something? Does this end up putting those
skbs in shared memory even if they never hit a physical NIC?  Same
with a TDISP capable NIC, does this unconditionally degrade its
security?

Jason
