Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793991717;
	b=NJoamaBtIz+7q2L1UY7ToPLKKhnKdU7vNGPjgaVYveJ77AbQEz2Gk3ZVvg7Kg94gwe5z
	 m7tZN9kRmAQxAV3tlv+uqwN6IANhs10K1DzwC21ha2CPcrIGSvfX8KcVOYRJX6mbUZ5RR
	 EYlb+l/pbA2xdHu4Ir25DwSCbdmfJnqsdrGUmqRe62x51B2Bt/yCr+hIcFaTsRI3Bgu9q
	 5ng5J5P2gixGM8s6M9qkQjZ/cDo7RuRKRUmsHHvxTkNdX9ZykftyYoaHLB1ghi/b/5ara
	 8oa+rhTdmiHm3+qFr2uYlCzqUn/HH63POclcaGVQeIsq/D71xZVuumMdN56I5ZdA7lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cnari2EfkfcqWLrylXnWPpbFbNnmk3zqvy2a0yZnams=;
	b=MOTHmNFOjh0ovQJx7oGlJiy66PuqyBqOfnv5OE8K3u6FalD9aHOgh0D+f3KwtAUu8I0r
	 sMTN3sp3/dStC/fz+/baEoyb0t3IRFKcZIC2H7d78WU4/AgegV1KeyFh8/dIwBGMSrfjc
	 66O95RWNI3GlVUpk7NE/NhAmZtHLpHm6EMhuh94ZfWPfT5saDK5ks7TiPBy5u2J5R3Mgm
	 KW7EC9KI2RjzmQ3W1b5+0e6IbnlYt4kbrZWHNuKJRTdOwnz8kTo59x8MCIro0SrPCyMxF
	 GlCIxKo/9S/IMbSWt1pBAL1qhL8j/5tEOqLzwVBN6Fue61Nom45A3OIvJr5RfJTaCqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="n/GWoaIq";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F2606A32E
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E09F2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n/GWoaIq
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533202fe429so102071cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:01:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793991716; cv=none;
        d=google.com; s=arc-20260327;
        b=pCa/azXnCm05nwIiLy5hWpQKxjfr33qW8PDTbKqK3+d7oW10Q+KrVpQcqNFkayLD4c
         WKexgFFJnFyiIdsiSs+eWb2RpQbkYJqPnmRNqmjpGFkobckrUyJOepDKL2ZSGRz3EzE7
         bo5PyFYtx/x/k/NCBB9YgwdJulkVgXV/10kaYwNnoXC6e4SCjttR4f92clo+8i/Xqh87
         NIMoIsm4xKs4SJh0OKDXENTkFGw16Nc7T8u+CVs5xfPlKlZFjVzt/xXTMFjB66mmVtCK
         FYQT71S1ofPLtHdE1p+RCcKUFjJ5k5KbE69K7dO3866Orf6D3dkuST0+sx6yoPehnzq5
         9BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cnari2EfkfcqWLrylXnWPpbFbNnmk3zqvy2a0yZnams=;
        fh=i/VNYcrKileCv0sj/dWFZ24aJCEtaYvwmhr7tpb70jM=;
        b=qvFnrCjUE40qkCfRoxv/zL/F08GzJtAqEBbB8X1kevtuNDgwZWhl2Y/ULfVgUKxwgc
         zS4Sm2qUEGH0cJKtIXdectQehVx7LgC6vpZi7VVYJK0r9zuZQ+rreFziZ7dW5b6wC96K
         iIFPwyFmi3+2Og32lVuQb29D+dlH2UJLQDOmF0kgXGEaYGELjEGP0ss70qYPRxcqmvIA
         PqcTESiLU9pQzO3CzfWMJhfYQNDSbPUPs3evtURLCav+ggmiF2T2nCtxYDrSCx7Bw+FY
         TVx9vqKpPcqgJ5+wFYcCnF90IHO/qT3YdJe9jcZmQycYMcB4VXWw2r5HpXOjg1W019fE
         msVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793991716; x=1794596516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cnari2EfkfcqWLrylXnWPpbFbNnmk3zqvy2a0yZnams=;
        b=n/GWoaIqG/n0K3uOE3TDWNDavehfNcoxfnFJEKhzeRN6AjEqhfFhj/D4ricgKysZ01
         mIpOY7K7mi1A0ltKL9zD/8gEgEbagJyRziCXdI5RtGsuOaFrEj4H0gpRp+g8Ihm8vg5b
         jRW4lbPvZn7LpKWZ+KKWsO9dk+q0nf00EXLxam6RtasMR3W+mBPZftnrSeXi6ud8v/Ze
         EO/nR+sjG52YaKs02Ug8B9hPSsvVJ6+Zq1q/MAh7/QUd95b6nKWjP+Hiwa8Vm2F426nI
         xo8If/HS3KmTEASCX2pbjKfq+WgwJEQpe6hWMVQshcR4rRyL/bEp8EE3NlqeVTcGdt8V
         Ilzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991716; x=1794596516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnari2EfkfcqWLrylXnWPpbFbNnmk3zqvy2a0yZnams=;
        b=WyKyPgsh4kSXvWVe5TxYXixFK/ihhs6EpQgpBjwZLb3jH21HdM/YgXPH8BJ9pywU1k
         MMvjcm1rV/g1tIqd7eoI8Kdq5YM+6st655a3jsMdpMBfR3fRJKXccPESpxvsiFAb3TQ9
         QTvFwbJNZKQKPxImjrCcO1alIYmDvVtCD2l9MszGDakwjZRcNWHihJB/WrrHvLCz+Dcd
         79neVMT6bvK8CodjqNQI95u+hriG6uwGAoEjDSkw7q6vdCB+4x4Lq3sLpaYGY8zjrv1q
         1H8+FbyjCWkyoINGhHaCVNGttL2nDUj9u+JUqymVxBfpBc4Z0O+WAuVBUs8Ry3a3oDBd
         lpag==
X-Forwarded-Encrypted: i=1; AKwUvByQqu4hEIxAD67O7Lha3T/RK4zie7P5xgMkZje3aiwwwru56TAZSvRz3EfGSzNpDMsaWk5cvM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nYms7R38lomEHOaUAHYc/u67m8Z6L4QF2v1RZDXVFyU3e77px
	1urQKG1ttE8Er+5Yx66Imw9kNKMa1Zw3x/kN7/6qLY7A92V52GR+zKhuegyyxWr5DNBUbymeIse
	FdgcjTmMKRsDr+G55a9fpTCuW/4sxk+PTEb+SXF0I
X-Gm-Gg: AYBFou1+Zii9iJ2lHFLx8ZHARPOgeEh2Na9oz4DGdhrnoT3cXMXIMqNVTXgr8FitRwu
	27yMkHbA6p/YAqGVEjgGVGuxwaimirXCp2o7cKnsPxtPFsYLsWVrRWktu9kDgdMmxBZXxSNnmDp
	Grm6e++9CXe/sBrVhx9zp7Xz6BP8wpmJY/d1Vo9bugNYpx5pAVj+83r5agvB+zQHTPneiFPOifR
	rl6I4mAdjHigvdidT9H3lmw4hELgXcZBh3E7ojo6cTNNidxPCzj6qa/4qZUU0cjmdAgxe6qcSWA
	HfO2uV9T7OEOOZR3GIc+eMKQzJ6+lG17mLXqRd6eOGEg8pdWVHJqCXDBGLSSzkbYcuWnrVxcLX+
	5u0QjL0tbi86+1zdxk1DApIqSY4fKXQl6vwIeaQ==
X-Received: by 2002:a05:622a:90c:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-54f5c235197mr4277431cf.5.1793991712760; Fri, 06 Nov 2026
 11:01:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca> <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca> <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
 <20261106180714.GI663069@ziepe.ca> <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>
 <20261106184346.GJ663069@ziepe.ca>
In-Reply-To: <20261106184346.GJ663069@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 6 Nov 2026 20:01:14 +0100
X-Gm-Features: AclHuK8RLl1nJ3Ebb-rbtl0GPWPY_LeKIqNGDlWDxF7jQ269eiN5kMKC-Dmlr_c
Message-ID: <CAMOZA0L3c0zWvvVF9btAxQSox_hQTZP6W1sK0vgYPQ2OMJtS8Q@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Naman Gulati <namangulati@google.com>, Christoph Hellwig <hch@lst.de>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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

On Fri, Nov 6, 2026 at 7:43=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Nov 06, 2026 at 10:17:38AM -0800, Naman Gulati wrote:
...
> > This problem extends to generally reducing IOMMU overhead in
> > networking - taking the dma map/unmap cost out of the hot-path and
> > avoiding IOTLB thrashing.
>
> Sure, that makes sense, but just having a pool of entirely normal
> pre-dma-mapped memory is quite a different problem from what launched
> this thread...

Since I launched the thread, I guess I should comment...

I wanted to address multiple problems, in random order:
- IOTLB thrashing
- better security than DMA-FQ
- reduce dma map/unmap costs (both on the host and guest)
- reduce/avoid bounce buffer overhead in Confidential Computing and
overcommitted VMs
- not just for networking, also for disks and accelerators etc.

Now it turns out that one way to address all of them was to
- create a special memory allocator, which distributed ordinary  memory but
  with additional metadata that make it easier to implement large
iommu mappings,
  track lifetime etc.
- hook this allocator into relevant kernel subsystems so that consumers
  could use it with little or no changes.

As it happens, the first version I posted last month was not terribly clean=
,
and possibly not terribly well presented, and had some redundancy that
was unnecessary.

The next version (hopefully next week) is hopefully a lot cleaner,
and i think the best witness is how small is the change to pagepool,
basically "if the device has opted in, ask for that special memory"



diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b775b6305fb78..e12ba47a20e43 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -16,6 +16,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
+#include <linux/pisa.h>

 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -602,6 +603,8 @@ static noinline netmem_ref
__page_pool_alloc_netmems_slow(struct page_pool *pool
         */
        if ((gfp & GFP_ATOMIC) =3D=3D GFP_ATOMIC)
                gfp |=3D __GFP_NOWARN;
+       if (dma_map)
+               gfp |=3D pisa_rx_gfp(pool->p.dev);

        /* Don't support bulk alloc for high-order pages */
        if (unlikely(pp_order))

The network tx side is more complicated because, as discussed
earlier, we need to be sure that the leaf device is one that needs
those special dma-able buffers, and there isn't (or I have not found)
one central place to hook into for tcp, udp, zerocopy,
security things etc., leading to a plethora of small hooks


 net/core/skbuff.c                                            |   42 +++-
 net/core/sock.c                                              |   62 +++++-
 net/ipv4/esp4.c                                              |    4 +-
 net/ipv4/ip_output.c                                         |   19 +-
 net/ipv4/tcp.c                                               |   23 ++-
 net/ipv4/tcp_output.c                                        |   12 +-
 net/ipv6/esp6.c                                              |    4 +-
 net/ipv6/ip6_output.c                                        |   19 +-
 net/tls/tls_device.c                                         |    4 +-


cheers
luigi
