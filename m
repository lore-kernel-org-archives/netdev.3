Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792786997;
	b=Y4JpBk7KOAXKxqen/AdoOcu3MNEX5zEr2xZmjIGfo8oH+iumE78vt8k0QlEijxz6V3TV
	 ywG2GNl5dq/6lkh12WelE2m/x7WtxuCRMibYMsXoS6izYWw+0lt2N/Mrud3SP7se/g+X5
	 3nweteNtkEe4nwNELTzN7YdvFKiYUj3bhsPvlOp6dTtUmFW8HcM036gPkUNeSNxAXR6/L
	 fOHRZFIDow+pCUbyDT1GkP98zfHOhKBJT+Do11TLeouyfN0UgbDzFyQ4WhzGDDVEtAWO+
	 DNBnzb4M04c4As8dgYre7eDtDhr5s2+lnZ4SEPPo6hWPJkAXCqLZsMuwWatVorKk9mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eVhNp0GGNRD3+5V43/lt1UQnV2SdTxNQyX5GFb3QiFw=;
	b=eLP9sFnXI5gjX6ePpuvIR/W+Tm74CqdE4C7CkKz7rLYwm8yIz3dmXXs/fd8ZQlsG8oQk
	 DXSGOUHHOKKRBQ7Wp55XgCUd/TC8O7eZSrlgwHFdsAGlGNSL8UZPfw03d36aEeFKuAXqw
	 pIV3qvigJSDEmYNzmF3sQc/62oaATMhIJGznO9OXcFz0WFLNMrQ5AI9wGQPj2Aie4sWn3
	 YpzlMsYdFH7UcB9Mjo8Zdd/ZZDBZ4Ddf/bZNxHZnwStk9f2ZUReEgZtxgYYE85l0tDLTT
	 +OnJh4cUoaqZbOZYVcSYshu+Wbt5sPiXuFGu8vdDbqxHz4N15feLqeLZRv4xTlyg1pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eHsEekrz;
	arc=fail smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7C606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E7C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eHsEekrz
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2db33db4de9so14545ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792786996; cv=none;
        d=google.com; s=arc-20260327;
        b=D4asTm8cGIyS5IEUaoHPzH2/OfSgpjIrNpiA/cKRIx8eP+0juqCSdzqq03y9EKPeTO
         mGXQCXmi7a4bmBuX1uFmoK0LgFbMt7i85rNwfhLkXZyU11S8chWEwap5vNWpqE+3KF7+
         eNotU5DfVT0qRz6cNpsyMOBxZlWDqFQjcg8mXK0XLoGdz9N5d35/Dv96y1f2dNbenhLa
         GLodN+g0AMAcFCam6eYuq1ZTosHzSsDyy3BYEtiDvoR0PVe1qoJkz3rgcnN6WgHNYw3H
         9zuvGJt6zFYlcStFF2yeRwKop8UVpMM3gcjMDgUB/qeAxWqZa5xeWB3L3Dp5hbHTbP2J
         ilYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVhNp0GGNRD3+5V43/lt1UQnV2SdTxNQyX5GFb3QiFw=;
        fh=4iEuEw3LFanWNczsr6J8e1ecx/qokkVS8jWKOsAML3Q=;
        b=hTt7AUMe+uiuMif2fGOFI9OniCLne40IxqHzpbZ3WgCHYgI81jQnqnxqXPca+UxsJu
         wQnRlt7rMu+vM8Cvp/nbPsD4bvN6vRgorPEcmAlrh3JStHVAEO4xUf6kaakBk4E19x+H
         hmR8ekJD3FsZzZerifXf1VXC03HjBapsQWSjXaEG4JTLVzFCYaJmJ4PvpAsC/wyQQ17W
         m7mia/1Pc40Ppz8J9zARrL3OK/n0sKZhXyOzrsShFOsCItzPBKVnCnyxBaMo7zE2cUDz
         nmD0lnWOFWterRmZoSe5BEuDNBdpPpA/o242Ptb2MuxvlOfjDp17/JvIT4tgMJkGlOx7
         iJsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792786996; x=1793391796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVhNp0GGNRD3+5V43/lt1UQnV2SdTxNQyX5GFb3QiFw=;
        b=eHsEekrzH+WNvOVjVTKwBC09LBMfF8W64lcj+llyrf0t9Ik2ourunpLhQbKexVNbyR
         8Ucx7wNPOkO4Eh5RblGLupEv/ctI+T6wqj07oW8dYvDHLtvODPLjRnSpVTaIXI8hqco6
         96iW15hHb/6TakyOBRivdCbVKZyhSEh0KdidrLUGHm+oVkwe1j/ms7JkVSBAgHta+C8O
         9nsIELnEwV4UDTUUL2fqly/kGcUz4zA5xWRU06wNmY9N8knVcrTOlui4Czl9HDMGh9E6
         BMxRTQyEIEksBH7zMxG1oHeRFOekmyykS6/V4Nk71zuPjRBu5MhgH1JL6BpwAeuRezUm
         7Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792786996; x=1793391796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVhNp0GGNRD3+5V43/lt1UQnV2SdTxNQyX5GFb3QiFw=;
        b=AnFJD6eqix67m0tRFv+PK5dhoFNJge/3ZhbEmrAIvdbluyhWsa5g9kluIO9UZRAyvg
         sdrlTl8Dl54E71zGySK/XlyJwnITmSX8b9r0rByO7QWiyoleT2cPqbcFFwouhCj2eR1a
         JtmRFreJ3ZbPOLhapzDJXD6hi2ZUogtUoUigaIbeYIA9Xd0jSJXXHd8lK2IAZdmgvrv0
         Qii+n9NCdMD/M7s2z19abzrqOtbuTp64kY7YWhaLERMY/JUJy5RS9Dwi2TYKeMg9RnJc
         DXhXZeNOCYfs6Aa/zwEsFBTOsntNnOjU6i5zcl30bY37JRHin3dRcE//lgTAQEolI6+z
         heEw==
X-Forwarded-Encrypted: i=1; AKwUvBySrJf2Ase7U8fWDgIjipH0+2+vO+CKsJDcw5ByTM3dC1ibWP/9XcP6NcKZdWAjoa9r1oMDx0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWpI61FfBN7nnZVMsjzno3sAcH1u4JfPZEUUVWj81TmSS4+4dm
	Mf2KyschFvASqBAdt9JEYp+AnYNVFMPpjHI7kxqxisHoMnm+xUT2tiT+97n5xYZW/+sHSiC5jXL
	CYIeb3YGf8VciRjbGD7O4/VJONCTFm4pZ8KO2Bnqf
X-Gm-Gg: AYBFou0T/qJqbIRj6OQbeiLRSJIYsVse9gibL7HYwbG8vNPpJ8TtX0fV+adyX2Z4sWI
	YTjTzOKRlUnGach+U4IW5eHKdDyv4k5OCge8647qQlgPXv8ybf4ZbO9AnR6Wor/wYQFemr8BoaW
	l2s4sOi4+PJiL+mOf4FIgPxYbjeUZ+iB//81xHhIdk67fNLQr9WE2SIQpSyCXMyAg3duSyCRXli
	CLWN5HyO5RwhIPnGrtqshPsXIANIiFHSOTulZNzAIQCshCK15V6ut/cbhEsUSCtNXZf2WdwgoTw
	KR+T1VPlSIqi6T0tUjtJfJi1uqO5et1m6r8x9P1jDXIDOOOe6zQ8KT8G7aYiP3pWVCdEM5aOyjF
	GvO7JcoNs6dTlVMx5/ghjAR8rZrfOjVzXH47Hgg==
X-Received: by 2002:a17:903:3c6f:b0:2e5:4604:c37a with SMTP id
 d9443c01a7336-2ea9c34d519mr322665ad.18.1792786995276; Fri, 23 Oct 2026
 13:23:15 -0700 (PDT)
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
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261023102756.201315d7@kernel.org>
In-Reply-To: <20261023102756.201315d7@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 23 Oct 2026 22:22:38 +0200
X-Gm-Features: AclHuK8d6JZsEGtM0KlZDv9ie7EsPXi4sNCVttMkACFig7Laogxgi1nYEIBjAsw
Message-ID: <CAMOZA0KZi1EkJaAFKfwOm8jo1ydyGh=W1RE0iMfte-ZQkOx9AA@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
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

On Fri, Oct 23, 2026 at 7:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 23 Oct 2026 11:50:23 -0300 Jason Gunthorpe wrote:
> > > Anyways, reading your next comments, are you suggesting that all
> > > these functionalities should be implemented as pagepool extensions?
> > > (2MB mappings and iommu backing, proper allocator of fragments out of=
 larger
> > > pages, device-less pagepools, multi-domain mappings, pagepool
> > > as memory provider for skb heads, pagepool as memory provider for des=
criptor
> > > rings ?)
> >
> > netdev shouldn't be touching iommu, it can get a 2M page and map it
> > using the normal DMA API. AFAIK there is not such a big reason to need
> > any of these layering violations. They just make it easier on page
> > pool..
>
> FWIW we're entirely happy on the netdev side to add this to page pool.
> In fact the initial RFC I posted for "page pool memory providers"
> was addressing this exact use case. I didn't push it forward due
> to low time and suspicion that IOMMU folks would prefer a more generic
> solution. Since then memory providers were pushed forward and merged
> for dmabuf, and we have netlink APIs to configure things. So adding
> large mappings should be SMOC.

Maybe technicalities, maybe not...

Getting a 2MB contiguous and aligned page is only the first step, and
the easy one.

Next we need to split it into 4K fragments that can be recycled
without waiting for the entire 512 of them to be returned.
This is not rocket science, but requires much more state
that what fits in the struct page, so that's another layer that needs
to be added to quickly access the state from the pfn.
Essentially my dma_pmd_meta (because I could not/did not want to/ use
fields in struct page to access ).
Doing it in pagepool could reuse some fields in
struct page to point to the metadata and simplify the implementation,
but maybe leave people unhappy because now something may
require an extra indirection.

Then there is a question of resource management: when 512 fragments
come out of a much larger page, deciding which one to recycle matters a lot=
.
Without a strategy, there is a significant risk of stranding a
lot of lightly used 2M pages that cannot be returned because some
fragments are in use.
Again no rocket science but that takes some compromises (sorting
based on usage ? periodically drain old pages ? etc) between
effectiveness, code complexity and runtime cost.

And then of course adapting to zero or many devices...

cheers
luigi
