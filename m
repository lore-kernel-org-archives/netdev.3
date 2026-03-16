Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB0A35B126
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694949; cv=none; b=tPpJhD9VI2AWzz8IBFkz+z3gg8bNMQK7IHtAVfNc+syVBcP0Wq+iHiGWE6CCEYgM55PGpp7ik80GUDXuJyBQZ/whiu2jbntrNXJZNY0HrmANr6/+YVNUw7ROMtF45aUBosyMxd6V5vlhb9hqKvgh+k0ryiAajVRSL+GS8iBnxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694949; c=relaxed/simple;
	bh=clFfAapLposgODwSVOgRioct5h0pswpgRcVBIoHAreg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umu+OgaHHu9JqDs4ujBnbSIP/NuS5uVmF4vg7jmsX9ChvE+SGYXT3WvKxLTlVhR+QcO4SaxBbkn405rOqp6V84BLrsl8Awblyln30QiLTeu32OlqesS9z1WNDv9WBo0KAZVuzJgVVp+4dtQvoJRY4LInZC7WZKoRpOonqqKy95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=MI98/Wtb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="MI98/Wtb"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82989744ee0so4674840b3a.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773694948; x=1774299748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rGEOeHBziMkO8NOwhTu0zAUiSPeT582b+R/Bae5NL8=;
        b=MI98/WtbZQNL8aLFr3HR0cXGsPHXWlT5VzUtj3mZHEp5kLEnuCXdZRjnT7ce7WiZGg
         YvX+38UiAAvshwojypw8Q5B1lfKzljBhXwijRYOUY0O1lvpXvOGpf7qF52pz9+Nlysv3
         UYQjD2uQWs4i5zqhEeZ2W/c8T1IN0v7hIkHk/MofzSm9d4rOv7oi9kYNKzf6G7otYHn5
         OeRJHmT6Mpf5Cs4aYxIqFPH9JEmu1JYPqe2irQm17CAQRSeLkkuhW1oTB/GbiFFQrdqo
         24enZUVySbXnErJScCMM0bCaMsiu+GFHPiMSkGKvsdonNOxdIytQhEIVOE7XSqc1L4+m
         5A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773694948; x=1774299748;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rGEOeHBziMkO8NOwhTu0zAUiSPeT582b+R/Bae5NL8=;
        b=YkEUu65ZlwEbNhLYLfiUiiaYqAfOzn+MUqFzVCpgKxHnMdVRPBv7SyquxFyTQJCq52
         k7jkSMZSQTRje5DNbRDqPWBtM9TtbgpBt3XG87tPYgDYN3sZcj3DixfdkEA3M5BMWidu
         S438rq+QRdTlh8PX9KWOU5wr+0ipqG0c2yKFtubwsZkoAxhEsgHfWJQp7iJukgKvXPP8
         fSV1EdbzCzBok/c2qYB5FeoBPX03UCsANKRRxq91PKyPh5GAd/iZ3FlEgJ5dXlFAeIAk
         md+6fCEUS4VzXxhYPHM/i7vcwb3jk8oqbQ55ak6hXV6FjnsJVkQ3RK8+Six9Mpz9DjVT
         ffDw==
X-Gm-Message-State: AOJu0Yxtx99GRL3EYW7f7WC34ulMpRFUyg4sDrx+xvFkWGDcFluErXgF
	tdBDNYkkGX42Jhz+znRdbxvvo9zaPFRb1A+CFpGXSYzziWcMZrKXLYgoCRNXbiplCmw=
X-Gm-Gg: ATEYQzyaWUQBjzPfw4bNGTj1b3IZcyqWmvMLlhrJdcbLYH4w8PwjthD/9kGhdpkY0Z5
	OCOhLr5N8ZkA/VEgRc36FnO7JZDzit5FNP1qohdk5jZJG6M+43F+H0Y6CLqz7+k87qiHkLyDlOM
	FV8TNgWOovZBO85ue2OIG3/t+U1/I/cum+TNdCSz7QQzi6a2nd+HzYg4ZuKE+bjEOjDCJpgp/Mp
	Bm06gUKvijlOVdLme9tn6VYPnLWoFFZJ04n/SsHZXFUkd87nq+tcsU1LRSZOvXFgdULyVHoRjok
	eyIQUD1hUjQrTKLjiOqnhVE15fWhPvMq55/KphDZxuUvNeZoKW3kP05LYpfC71NX4gqEDeTYw2L
	xeTXKUm7wv1TPu7bIEwNYb5YJV0S7Hmhd/aodTNT0963wFKIShWYIXq+zi744xDLURgvL8wNHHy
	kXlbGm
X-Received: by 2002:a05:6a00:14c7:b0:81f:3cac:38a1 with SMTP id d2e1a72fcca58-82a196f5893mr12202997b3a.6.1773694947630;
        Mon, 16 Mar 2026 14:02:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072422desm14800519b3a.1.2026.03.16.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:02:27 -0700 (PDT)
Date: Mon, 16 Mar 2026 14:02:26 -0700
From: Joe Damato <joe@dama.to>
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC net-next v2 00/12] Add TSO map-once DMA helpers and bnxt SW
 USO support
Message-ID: <abhv4mjRyJooCjun@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
References: <20260312223457.1999489-1-joe@dama.to>
 <20260316194419.GH61385@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316194419.GH61385@unreal>

On Mon, Mar 16, 2026 at 09:44:19PM +0200, Leon Romanovsky wrote:
> On Thu, Mar 12, 2026 at 03:34:37PM -0700, Joe Damato wrote:
> > Greetings:
> > 
> > This series extends net/tso to add a data structure and some helpers allowing
> > drivers to DMA map headers and packet payloads a single time. The helpers can
> > then be used to reference slices of shared mapping for each segment. This
> > helps to avoid the cost of repeated DMA mappings, especially on systems which
> > use an IOMMU.
> 
> In modern kernels, it is done by using DMA IOVA API, see NVMe
> driver/block layer for the most comprehensive example.
> 
> The pseudo code is:
>  if (with_iommu)
>     use dma_iova_link/dma_iova_unlink
>  else
>     use dma_map_phys()
> 
> https://lore.kernel.org/all/cover.1746424934.git.leon@kernel.org/
> https://lore.kernel.org/all/20250623141259.76767-1-hch@lst.de/
> https://lwn.net/Articles/997563/

Thanks for the pointer. 

I agree it's the right approach. Batching the IOVA allocation and IOTLB sync
across all regions is a clear win over the per-region
dma_map_single/skb_frag_dma_map calls I had in v2.

I'll submit a v3 with the tso_dma_map internals updated to use
dma_iova_try_alloc + dma_iova_link + dma_iova_sync, with a
dma_map_phys fallback. 
