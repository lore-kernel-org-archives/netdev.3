Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792765864;
	b=p63xC1zlIx5VrvCf0yYFZaMAcUFZ4Ax5jjlXE/eoLW2SjoSKWGpHE5HhYkuNstLWiNlR
	 AXPMu/pRNxx8SeGsNuqJDPK36gzJ7Vkq4sYJkAzqTt/ArwPSGpemo1Fw1Qw+bcAr20LIs
	 +Zlf8ldGT6FYrpS4zyC+UY6zuPiJiTLE2ECE2bFXfM0jfezD3M0CWoldrcgWVbSaye+x4
	 bTn7wFFgqf51J2z9Uf41vdsC2xLzp9WhZhuFBxKxFml1NHdyLQKRD538zQYmaCI5DpYqz
	 xLdM5JTSqJzalO2GTN+io+egz3mpyRbg8Dho1pNr2ovK8mXOFLnX/rVms7niMfGQQVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s3FkMl8OhjMqOhi3zpzbiZNiNsx48LLQzOlCjP1CveY=;
	b=PnFpPXoNn3qCibqKv5zdlFNwbIplvlWN2ADcIFIuPE6sqckJfFF3W1NEIhDwpzoCE/32
	 GErTUKlCKTaoNvlHXx4JH9dL3MAEZT9HVR34XpR+NNyzjg4XG7//zQ6C8bnop5DESf217
	 R64vIWeZkS2uRQXf8xBUd5fstPM0bGd+3V/oXubCqpYymOGPdciKdyDB5Jp1q84Ntr8Qq
	 azKR4dptQsYz9KWaIH8WGz+XD9wimlbIzV5QqO4DyI5XpvfuUZ1h8pyYmXwyZIpgTFBDc
	 H3MpMD9qnHFbmzmSPQ2UGHrXKbnI4kU2dqMoDnGfLfNpTQcHqPn+YJHjh5ioGhAey6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VVIFg6tb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95294606A329
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95294606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VVIFg6tb
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db33db4de9so71085ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792765863; cv=none;
        d=google.com; s=arc-20260327;
        b=Amcx8exiBIoWhzdQxKbNLmZccMfq81dvHjxGJFjAyZ2wiRvDmaW/DxGPjwsS53R4dw
         DQmoigzZkPfuylkFFtgUpIbjNHFBAmWAoMhC8STyxP6gNV6YSBqIwAc4loVS0uKr3BBv
         G87yVQREyUd4ChEEhMEHVJqJg/pQ0RHzh5Jxy3W4HhgavIsSPZTniQ7ZDTBmIkD99jMr
         fyT7cIIgeBO0JhJIlZSwjnx9Em410pQ8GeWZMLcP3VwLWtkZBJVk1U6jafpc0wMGBfrU
         YE+OTsHdkrdDXJOsUQgAClgo7Otasl/bJMjXtbxIMlhUGxJUN744+EQVc/tygVtC7RKs
         s96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3FkMl8OhjMqOhi3zpzbiZNiNsx48LLQzOlCjP1CveY=;
        fh=qk0HeKmTIKTUf+0Qbw/atc4bH3CQ5A/OsADLdhTZNtM=;
        b=KAcK2Em5m38/av2j5Y3vspVIfiUbE5uh6noMYLFPWm5Y4Wm2iAAlCEfcERxtgCfiZw
         BxUIuYWcM22IXrGOZ7dgRllJj2pFg3cxSL+BgcwNmmlUjrqxYBHbI8z+Au33z4buuM4t
         2IpZJclyQr6dAuDZIsladA8MmTFjEwMTKKMPnrIY05sVKCN/I9K0N8jsFLbv6VIPJf56
         PQEmiVrneg/6VQ0uD5f5z6gWkTAVglneDKvadwMehiHx2WT8088278Ly+edSW8DlQE8T
         rJYnh4x9DKqDoVtOgaLn/TGLVW0Cf/EpEQo+G147oSie3digv/Oe55cSVQUlqa5IVLzi
         PPMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792765863; x=1793370663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3FkMl8OhjMqOhi3zpzbiZNiNsx48LLQzOlCjP1CveY=;
        b=VVIFg6tb7WK4WNH/I3L6DFNDUrzYJ8o1O9kJJIOL0mZjbDHHGac5RMiQ5AsP/FqpYv
         1Dt4Jc4CBdbhHms0jG3oJH6xf8Tj+LzES5uC5C5CYoNAXzPld4yvlCtqXp3+F9mf0spz
         +3BusVjz7rkrm0ohoVloTAShTDbfxn+Rcr2g/VyGdDdplOcHciqKZgZmgBE4eYfT0qJl
         qhFR3JTcIYt343vm3g8Uh8JKEgZBCoIcY/Fn5sFRoo7c8899zyI0Y2kjALu+M9xDlJeA
         7upuI8KJB6SYRwqoRToLV67mbyXPbUJP4w9MoEyNB9cq5p8Kfjr85sCMlI79SsK78Rsf
         UeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765863; x=1793370663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3FkMl8OhjMqOhi3zpzbiZNiNsx48LLQzOlCjP1CveY=;
        b=LMoRxm9WXLwzgCrtVAJVKVtV3aALtTbhV7656KTGCQVbUdTBQ2WFmgL3hZWsvuj/VX
         zNt8Ag/BTjcPFv4pKGUHnZRORMyO4cle4JXIT4p5BfQh/Sq/NyF7iqN/ujKlXssUWDlw
         BV89O5iJBpIeI9v1ZebpFw7kP9ojkmm0+zSZaGSML0IgPLKhSFtjg7hy7wcp1pk9oQgG
         AIeB8hUyusMLn2B2qQ3hMkO9p+UqOr1t3lZkhJt4FgMEFHEsIQXf/zGE7UM8+iFVZ7k3
         973MRYSNzwlBs3oOmVw0JW5+IPOHQAHw6keM6IWEwq5u4BMXArErLnsXnjiFKkJd8MuD
         FuNA==
X-Forwarded-Encrypted: i=1; AKwUvBx2jIjL3L6dbjWLkqL9zWtO2q3gqot0uyKOq9gnRXYHLorL3k4rcJ90Y097riWtaq1Kr3pZ7+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCsY+cQJmRulpJl27oIVgMH3zRf8dNr2gOM2qOejgLUpWg+5Dj
	y6zTFBhl5ROaEPrIX8sv4dBV5IKkx6X2pmYwpK30uXeqjonRQHZmR5keGROe6ii++INekdtoBvI
	meohHzeOLvFg5MSNJul3+za8y236awAr7vlZ/1aR+
X-Gm-Gg: AYBFou25vFeE+SrvotRjj0tXVC2bp5O5aKvVr7eZxSPtY4lbXUUHU4Iro4Zg11FyRP4
	mYWkw90ObJgSF3T6cT/TFEXJxZm2yuxt/AorIRncJZ8dv82hH0/csxxzzmC8wvPO6+GrrAta958
	JwK8FyZzWgUTWeX9h87CXb8WOO96ATyH7vjda0JsLYS9w9Q/r3JLrKT40xHX2Keg+qCQIifvlcr
	7dYr4G4KmpJ6dLOGo+4ypIq3l3B9i4XbjmW+mcrwaEJ4IWPasXZD8ISzu+/4het4ge70+5u/pbJ
	PAmC+g3pcyLvgOmuSOZnzsDmG5QPMlxESnJn3Xpht7mqzL//8KRTYfzAqwAAZKMGi7RuhDQ2OT8
	ZX2CvN2uxG1Qx7a1ztwPi1wt7shw21aO5vAiia4PfYVxzDZ4Fhv4LO8TY5FM=
X-Received: by 2002:a17:902:f683:b0:2ea:7180:3abf with SMTP id
 d9443c01a7336-2ea7f512f16mr4025665ad.15.1792765862249; Fri, 23 Oct 2026
 07:31:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
In-Reply-To: <20261023140107.GC3977851@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 23 Oct 2026 16:30:25 +0200
X-Gm-Features: AclHuK9d7tFq_s1fhJmYPVN1-JncgZCOvwLUHaeunw-YOxbh9iZtFoxmVAkcY88
Message-ID: <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 4:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Oct 22, 2026 at 11:51:40PM +0200, Luigi Rizzo wrote:
> > On Thu, Oct 22, 2026 at 10:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
...
> > > Can someone explain what outside netdev would use this? And why you
> > > couldn't do this in the netdev page pool?
> >
> > I can try.
> >
> > Regarding users, the next target is disks (not included in this series)
>
> Disks don't use a memory pool, they do IO to folios allocated by the
> page cache.

I know. As I said I have a separate patch to cover those IO buffers

 block/bio.c                  |  21 +++++
 block/blk-mq-dma.c           |   4 +-
 drivers/iommu/dma-pmd-node.c |   3 +-
 drivers/iommu/dma-pmd-pool.c |  14 ++-
 drivers/iommu/dma-pmd-priv.h |   7 +-
 drivers/iommu/dma-pmd-user.c | 390
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
---
 include/linux/dma-pmd.h      |  53 +++++++++++
 mm/filemap.c                 |  27 +++++-
 mm/page-writeback.c          |  13 +++
 mm/readahead.c               |   9 +-


Disk I/O is still potentially affected by the same problems
(cost if io mapping/unmapping, iotlb thrashing, bounce buffers
in confidential computing...)

>
> The only other candiates I know of besides page pool would be the
> existing dma pool users. I don't think they are so performance
> sensitive as netdev.
>
> IOW I think this entire series is only useful to netdev.

Well, the series provide mechanisms to address disk I/O as well.


>
> > > It is not a common workload to have the DMA allocator be the one that
> > > allocates the memory. Usually we are DMA'ing from memory that was
> > > allocated someplace else.
> >
> > Aside from the fact that dma_alloc_attr()/dma_alloc_coherent()
> > does memory allocation + iova allocation/mapping,
> > this is not what happens here.
> > Maybe the confusion comes from one function name
> > (dma_map_alloc_pages()), but it doesn't map any thing.
>
> > My code (in this version, and more in the upcoming release)
> > mainly implements a specialized memory allocator with an
> > API equivalent to alloc_pages() and variants, but ensures that
> > the order-N blocks come from contiguous 2MB blocks reserved on the fly.
> >
> > The physical addresses of these blocks are recognized by the
> > "dma allocator" (I suppose you meant the entity that allocates the IOVA=
 range)
> > so that it can apply specialized IOMMU mappings backed by 2MB IOMMU lea=
ves.
>
> Why? This seems completely divergent from how anything else works in
> DMA mapping, and I don't see a reason for it to be anything like
> this. Other than it makes page pool work a bit easier
>
> Frankly this looks like you had AI to transpose a bunch netdev page
> pool into iommu.

(yes, AI assisted, heavily human-guided).
Frankly, it's very orthogonal to pagepool, given that it uses pagepool
for what it does well, and it provides functionality that pagepool
does not have.

Anyways, reading your next comments, are you suggesting that all
these functionalities should be implemented as pagepool extensions?
(2MB mappings and iommu backing, proper allocator of fragments out of large=
r
pages, device-less pagepools, multi-domain mappings, pagepool
as memory provider for skb heads, pagepool as memory provider for descripto=
r
rings ?)

cheers
luigi
