Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697274;
	b=DGHP/oWinlt51Ik0B2YJHGSfQggAY9PopClCPytXrl7z4bY62KWP4T4kGxAce+wE8KQ0
	 5mp8DaZ8N5wCUC4F4UnBb1ORriXxGbvLGMdhWwcZnb9oxwEauEywvbSScmXfTYSdXIj5H
	 sXVZ0XH5+YIVqwFWqG3It1DyEHAhEACDBsdrVjG8kfpwRY2a7UKAXayZ6xtysZ+znfSZu
	 bUJxR8UvUzjKCAei2bnF94L6Rz4nSHlXyNN/rUxml24rlOQa3HlwDwL3zk87ncmorROJz
	 uFBPkURX9b454yb0p5lggSvXW475PfkhXDqM1J42NuDIWCk0DmXJ90VRuRGM4gGP3xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i14dmH5BR+9SimyzQMrEk5iidp8zGrGHl7mp1tLTg74=;
	b=dyCsymWFZMsJv+gKSqvaAUd/LhWVJSe3smGu8qHKy17pNR2PPOpL/IYXv4UGpZM+jZHW
	 +xhHrXSEn7VBCdUaEYawIpdb/0eobZnW4yXgS5EJJf7S4+j6T84Zl+gUuPsbQ8reNEcnL
	 UXIlTA6KxlAnEzhKujmnwjgcFuR3RF9ocWxv9rWKOiioxXos72e5p2TYsYUs9XGDQE+IO
	 yg+/R++JSwDU6S7XtrUyqIVT83b/5NGoZfYHOrspZlBzbfMWQqBdm5u62TPMzzWzU53LE
	 zahf93pI0aByW4ydCijY8aJIehtZ5QXglHW6f0KI0iEy7JOdtaGjZ+SZdXtzz6YLisg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BFRA5WkF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFF606A339
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CFF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BFRA5WkF
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5383c97c8cfso140101cf.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793697273; cv=none;
        d=google.com; s=arc-20260327;
        b=bWxd02VD+FnrdQEIOFnoBI1hgs/rFPW/rBLrI1jwx9XGSNTeoWcRbk4QDWvPff5pb/
         drJbLYn2PptczgUbTHyCXkGXuuqOL9tZC4B3oQlmMyaZ/XSgV4wNodXgKNKnXys3hPVr
         WDi/KE4QHkTPNpMyWAnes9hJn2N8zWGECUSVwIsQRd4VlbqzwPKApTkVVAHydYwV/+FB
         oyQh6HuA+9e53jNAxfjUdQXtWxd7PGGk7hFZNh69Z6LjD/4kgF6hgr/PLpKhV+vOWWZ/
         k/yh8URJJA5xDvXb8YVO/moBmsw4tJUnB+d9f9h6oDZBWWQeBAN+oLYKFoSYbobuEwmH
         hW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i14dmH5BR+9SimyzQMrEk5iidp8zGrGHl7mp1tLTg74=;
        fh=juhaRqRwUPrvfrr0amLc5LYdrkOwgvNsasXKnSk+wNk=;
        b=OX7X8ImwSRffAjedCT+TZl9CYfBpRHJO6efR3YfNYBBD6jYYL7LtBOCVi6aVDT71YT
         nOMabrFT2OQPUwsJLU22HBJlx7lgbTHBhJjs0tWQBccdwPmfLm31JbA55Ct5XYHVjcIg
         yWcAbted4Y16K2YzDvujJfs9Gcpuhoss8KBuNLe60pRWo5SUftr3sC1dSzxq6VcSG4Xh
         g9jg/cJM+X6qAuV1YmCDMOIAoEBsqxy9DAgJR1XQbUiFE7VsYzpVzCiQRcmBsE4fxAZg
         DAuChUsbKrda7IEYV7Hx+uZSiMu9G3nT89IPzi0QfOgiv+Aaf5xuEBim3QoH31mgA2bg
         JUrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793697273; x=1794302073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i14dmH5BR+9SimyzQMrEk5iidp8zGrGHl7mp1tLTg74=;
        b=BFRA5WkFVzwofI4Y9qPUhFW2qtyO8NlwR48s0vcWHVm26tP/5OcdiQb7uQdbBFJ3l6
         6eWpgCHaYgj4N1eDLLQrwwhYiXTq7d11vqjE4ug1RgS0ElbGzpDYB2KQ9TkFp2okdQER
         yFf4tAgPt9WLDcmCO0BQmFV0yYbVZ8lRUw/90MMImfZoLthc1w4BHcofV8LGWl/B54q1
         nfF6Nupkbu20jzw4PqHlTu1tCWB6DY7rzVVWK6hzYnJCfcxYQPAhj2SwIldQyFdPZHAJ
         lQvb1sVV0SVYiVnLmhmTyS+xxxRLOhf7PlY2k0ra40cMDEjxCqbzHGepPLgMmkzh219l
         CA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697273; x=1794302073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i14dmH5BR+9SimyzQMrEk5iidp8zGrGHl7mp1tLTg74=;
        b=uUJGwdZ9FWCJ/tMryvn+sw7PFLctVCY3hp6Y7LM/JbUAvBYqrAcajQUbfC494sQuHH
         XQdddwf8lf0Ruij7s2oA6KXIQc09GdfKXLiVo/Lh7YCEeeouVrky+7di9Lj5GgWGz/jY
         G45kpsMizCBe1pagAuJqzyL5o5KcquRgaiXVWVYNMmP9Rf4kHewPLK8HyKUuqPWsGUZQ
         a6FlgqFklASqgjBrkD450Hi5ldol8UWg78ojyIX6A7T70trDWsXmoWTq/zdozGmE0fGD
         WnzMOTbC7gZSbdIUfLGilegTMe2nAWB+g/t9xZ3JkC7h95ri3on7KqDKqQneLmGRoVYh
         2lbg==
X-Forwarded-Encrypted: i=1; AKwUvBzcpnJSq4cqKbX7w3uFffRFa7jsho4PjYdMgai2K1SX0WgqQGXYhSs+Hb5w0l3MjEqoZ9D5hIM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9dPSHoWGnkSUYF8HoyyG1fuWUwfa1pZItjaLbCkeE6DYZ4R0m
	zBqdl3tZkz2ZRFWr0Lc371UAGmYICU4UnWnK0UCjgF0CjwwsyVhVtl1FkDgcMditmyEMlNnuMxu
	TactG4HBet0STdF9W8s2UxUwEmxSmzW8HHnMofitU
X-Gm-Gg: AYBFou3PYmHl+PpV2KF+XCWpy/+0WsyqKSg7RCFAZaELzpHDaostIfcMWyO8Hg7qnop
	IE6GvlDgoE4NrwOufF29uVL1lDajjjAFTOgOmVWHiLB5XNyPU/+pSCC8054/fGkGOyV3LJkGSTV
	QiwioMl5aj4Kar0yf7mKk3508SrGYkhWrARUMSrbyKBQSuTdZTagqIfYIeGjh+sTqLkcoOmqGkk
	40QTFn8H0T2omoYvNfBoxeo7dHDEv7YBUsgPC0ksxDRroQkOFHwEN3C4ck3/GPXWDktPd0qyxiH
	QLJNk93KGUr3k8Zy7wuaSpUsi6sUqTRQpvm+er96fyUkaNDPk622nUvF6HRE5fDHEfTXqwsPMdW
	vxdVU+0/ITCuay3VzlBKSxRWC7NSAeBADKpye8rRUmWVpaEtRh/F+Hzsm0hY=
X-Received: by 2002:a05:622a:598b:b0:535:84ef:2e26 with SMTP id
 d75a77b69052e-549dfce05fdmr11810771cf.7.1793697272817; Tue, 03 Nov 2026
 01:14:32 -0800 (PST)
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
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
In-Reply-To: <20261103080933.GA4213@lst.de>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 3 Nov 2026 10:13:56 +0100
X-Gm-Features: AclHuK_l2TEIEs7qqznKn-9_c2yONWQ9t4tXrp8CyyoGHrPwnIyHLaBfgdlxlp4
Message-ID: <CAMOZA0+Fhq0_Pm02xGWpex06vb2y5pVzuFxOk=URZB7aq0xJ5A@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
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

On Tue, Nov 3, 2026 at 9:09=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
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
> to do with disks, except that this is the first user.  The dma-buf
> iovec can work for every ->read_iter/->write_iter consumer, and
> should be adopted more broadly.  Including by networking instead of
> their own totally weird different world.

Christoph, is this the dma-buf series you are referring to ?
https://lore.kernel.org/all/cover.1791975048.git.asml.silence@gmail.com/

I am not claiming that my proposal is a good fit for disk or accelerator I/=
O,
but every subsystem has different constraints, so it is not unreasonable
that a proposal for (N)etwork and a proposal for (D)isk focus on the
different bottlenecks (still there can be learning from looking at the
other solution).

As an example, in networking we have to deal with the following:
- typically at least two buffers per packet (header+payload)
- often, very small fragments (1400-ish MTU plus crumbles from
  data in different buffers
- extremely high I/O rate with almost no spatial locality, which is an IOTL=
B
  killer and the main reason behind my proposal and some of its complexity.
- on tx no good way for the application to pre-reserve buffers
  (buffers are sliced from a 32K per-task block,
  going to possibly different destinations)

cheers
luigi
