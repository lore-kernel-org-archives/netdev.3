Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C694FDE4E
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698369; cv=none; b=f3JDluYQIM7AyAVm4DnV2KySxh47sADhyvwp0Fp5qynhu1ZgCjVfJ6l/SbgZUGsu4omboqKc7FB5l76QUKrP0OGM9U7rAxzk08+bmlaNA3wgxbLaqSBhRFdz7ip7JFOnv5wPruvNtXZU+JDcZb/66AmiN/4//UGIQ4zFSTO//No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698369; c=relaxed/simple;
	bh=sDLvc2MZgyvTyY9gx2R0XQ0znRHniSDnRe9KAJVNqTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhLhv1zBCKpkZuKLIQibAfee/rXX0eyKSlALNpqtPl8jXPFvIyEblV7RLO5p3I/ar47RB3L2CCKIZG/nhfRkZeZfqDp4n/eiIpYAkKoYVO7VnR+XXTUoilxovhDkFmrF37Z1xGF6AG+aYZ1SYhLOxb6VBDgtoloBTMbdNaYTvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDmb5P8L; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDmb5P8L"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso12041605ad.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698367; x=1791303167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csl4wCkk0Zl0u/F6Ga5a9qQkHfeB6A6F99MGL0l19h0=;
        b=eDmb5P8LMbXaDFWOA/d479mpZT5xgA0Av5MHX/Eaqg9e0wfVjs2NaNtKfPuPY34zWA
         2BOjj2RNPKoyoaBjR42+Fdf26aNiCZy+sol3Z9m4KkMAGMQtCY9c7KyE9lq8g0R5eGUp
         0Kr0cDM8dunIvwLJUCcxinLimCA4gTqiZVJxJ2BKI8v3mXnyHmu9RSsh1EhBU3YcnISn
         L83lzm+gcTkwxeSA+HI7nKw6CxU+WbODzxhdq+bYwpt8Jye2JXhRZ6KJlt02SXJhCO1E
         iO4YP2z33vdEron46GJhxEjHJMme5GQo8/zTX4jHM6q3OTZDMWsCaOevmclTD1tqoM07
         KvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698367; x=1791303167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csl4wCkk0Zl0u/F6Ga5a9qQkHfeB6A6F99MGL0l19h0=;
        b=JeF6JdNGAspItMDgF1i3j7V9AxodxxdoXz+Soeg8lspKXMjUHpp+lImi4mjkD4Pue2
         PK1xXTH4MEP4tXrKRdtK9MhCrESPa3Xk3YcGfBxpKr5srgwpgkuN8hlkMTocvS626ed8
         89wyQpOMJqSsL9O2UYfRIqgez5pmsYjyLhnnymihcOwXvoEuSUOs1G2XWuLvchpYyaeA
         0bjR9j+Cc8l3oage7HhgPMtPy1Jsb4wSnM9EBWi/VHVbTRv6jhqfbHMNS7HXUI518miC
         o8T5FIIX2mksUnozXl7hsvl4482FykYbr4+EfdTenNNLhFw0+t3PXDSfAJfLd6851nwQ
         i8FA==
X-Gm-Message-State: AFq9FYIrNt0wdY1DjaCR8EGVLNwrHEQjUqTsjqo/O6dqglHfpw2doBSS
	oSVLSgu1FW3ppztRN9zvgsckvklwOIJMiLiYs7JTURbvLgsui5ED8q2j
X-Gm-Gg: AYBFou1lpJDDxw7PCR8DrwLiSLWOatEdlIzBMpb3BJPWp/nuMr4uO+27fQ8MPuDncIA
	/AXh1yUBWlGzta++dcRzum3WooNp0+gGTKendARBmSGY2LtPvoYjim3jZgb53inXbqg5bP+Wo34
	Nbm/GxnCHorffV2t72oEwqRyQk8vKd5JsZhep4JF4g1io0/L33PdhTydSsgDkCHuYc3eSGGGAjA
	HH5EoAZvWRTHMs6Rx2KERCidByGPTgEUz3qlXKouCRELGLO3jHk3SpaXhWE9OfELHh5g9w4QC8J
	jayTAqRlHkBn9vMCaHHnWrlV/E+acejs2lUBgvjP5Kk1sDaoC0aESz0rZTiFOwml6eJEnzWWDuN
	+XzsDGAbIJSt6IrDd5HwmBcvwJECOY8VXcGkPYqWBYKOcyTsxoUYisWYjaln3M0caapw0bWrctn
	rbf37V9VClE+N7iRVKrn2cHDxFPsnurZ8lnTRnxGoeXJx/HmZkVNOW/ApATcG/Fu0=
X-Received: by 2002:a17:902:cec9:b0:2df:9305:8909 with SMTP id d9443c01a7336-2df930592e6mr107246915ad.17.1790698367157;
        Tue, 29 Sep 2026 09:12:47 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2d8edc107sm3600445ad.4.2026.09.29.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:12:46 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:55:31 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	sdf@fomichev.me, bobbyeshleman@meta.com, almasrymina@google.com, 
	kaiyuanz@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: devmem: decode DMA addresses for TX
Message-ID: <arvfYIx_0z6lU_Lq@devvm7509.cco0.facebook.com>
References: <20260925201522.254717-1-sdf@fomichev.me>
 <20260925201522.254717-4-sdf@fomichev.me>
 <85ddcc36-7e31-42d7-8e78-a3e456e13944@redhat.com>
 <97f2fdff-3954-4d53-aa55-156672658ee5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97f2fdff-3954-4d53-aa55-156672658ee5@redhat.com>

On 09/29, Paolo Abeni wrote:
> On 9/29/26 11:43, Paolo Abeni wrote:
> > On 9/25/26 22:15, Stanislav Fomichev wrote:
> > > On 32-bit architectures where dma_addr_t is wider than unsigned long,
> > > page_pool_set_dma_addr_netmem() stores page-aligned DMA addresses shifted
> > > by PAGE_SHIFT. The net_iov branch of __skb_frag_dma_map() adds byte offsets
> > > to the encoded value, so the NIC is programmed with an invalid DMA address.
> > > This can trigger an IOMMU fault or DMA from unintended memory.
> > > 
> > > Consolidate DMA address encoding, decoding, and representability checks in
> > > netmem helpers. Use the common decoder from the page pool and net_iov TX
> > > paths so both interpret stored addresses consistently.
> > > 
> > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > Fixes tag for net-next patches pointing to old code are highly discouraged.
> > My understanding is that netem on 32 bits is mostly a theoretical thing,
> > i.e. no actual usage.
> > Would you be ok to strip the tag? No need to repost, just reply here.
> Actually the above is more FYI than a real request. I'll apply the
> series stripping the tag.

Yes, agreed, this does not look like a real issue to me either. Thanks!
