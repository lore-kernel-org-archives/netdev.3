Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D0432BE9
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621362; cv=none; b=QmwF4lkD4j82rRPbNyKCkCUACfrNNNA7t0+QHkD3nmuxPmWwzFslocWZYoaV4L+XGe6GgTLbDdf9y/eKVW8Ah7HbQpm4Rrw17oYgnmcbE5OagKO7SOnfGYh4OD/TBva+63nMOUFvP+QdoC2Spc9RyHUX4Shx5KwzHMAHXUceps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621362; c=relaxed/simple;
	bh=VbN+Et8O+M81UON3mkIv3jA68onfR7gbv44zPP//V3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rtJMULtZ9M9pjQ0aWg/tDm+lJfgKBSQrQs2u+B24RX7y8p2+yGrKRpcWp3WkRq3fJ/QWnmpncP8GPbuJsAKTdi0dYwyPH7LkWmHcfnb/VBLkrPdEV0EtGWyia+LYm+SWwsAOdFwFZWJqtMm0XkwKtXlrC00/SxFJERcaORjrG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSFS3yYZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=opn6Jrrq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSFS3yYZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="opn6Jrrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786621360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rb/L5RRc82A7B5E2Iy9LP5QaxJKcUva6+toB0YnDVwY=;
	b=XSFS3yYZiYVGnJd1Wr7RELvLW4PjUOovysef3QXeCIXISZSw2DfJLuZ4ZZi1LljL+yeuPK
	nvZJT5oiPgHjMTXAGCbFI2v1PnmOMyd6H/cMFnasW3nXkDPNMrw1XyjFPsNwtEYUp5woqP
	wFwFbFZmlNPH93efNQvLNLVDd9d2Yic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-V_CO3XU6O92xycxnZ56w1Q-1; Thu, 13 Aug 2026 07:42:39 -0400
X-MC-Unique: V_CO3XU6O92xycxnZ56w1Q-1
X-Mimecast-MFC-AGG-ID: V_CO3XU6O92xycxnZ56w1Q_1786621358
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so19293325e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786621358; x=1787226158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rb/L5RRc82A7B5E2Iy9LP5QaxJKcUva6+toB0YnDVwY=;
        b=opn6JrrqNUffshKC8YxKYQde5957jq20Ehfsrt/+GzL++Cgl1/q8ws2HsYQLbWLP9h
         JLxMmsdJ4NLDU56Vee/WiDHWLEeS6TiDLW1xfrJI14y9anF2zMN289ojDyzIm+yJzrhi
         Mf4z1hES0UwyB8IMxa8EEgSYVFXCeDM/43ClBmV1bIPPmQSMPf4aDH5S52FzloC80suD
         8rVheZbilXjHg/6+2RyFK9WhH7vReQUE6SLnaQ6lP9Bwc38J36grGEMbPd6ecFCHcU1Z
         hCrFOIjuzw1YHPh8RkJUFR8mNCFXFuBzpC7cHuGo9FqRZ6lIaZamjFuktthJmMlCsYdr
         KFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786621358; x=1787226158;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rb/L5RRc82A7B5E2Iy9LP5QaxJKcUva6+toB0YnDVwY=;
        b=Aj8F2GeIKADEDfMVS5B1uCns3DvuDLzd6ZP04TmHPj/tMpDB138f6hZpW+bAa+w3nb
         aR0KzFjd35hLQrL7aPMNwPWmS6glbwYH17pZ/wCpSKKak1ZeabYUku6VnsIL9AilpdXn
         TQvZaRg6K8X7si6fpRyO3EW0qSxM+S77dBeReh0HtuIpQCQsT8risDPtOtvbijtcgT6F
         /EAbWRyE+z7ESmcV60dG4LOCS51upx2cOvFJq6/7Gv2JlQ1m5PZc8BPIPCUFBPJ2bzpH
         79VWRGugz9RR+PkPXnpHv+398r5On9sIuBKLtbPSXDRZsQOFLogMfmrqlf3BulbtrsfT
         DATw==
X-Forwarded-Encrypted: i=1; AHgh+RqvuCMqiWNLgPMeGjXCe5s2N2rZNCqS9vlqRS4Ir7tA/eQtwTr8uBUdewlRMjyY6ABgGURwpx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2pNvntPmUCSU8T3qoAPO52u/1jXDZiPD8jujxMVsRGtSr49j
	zT0GFaVt0Ej52Lz5JXNwN15PXrlqWY+B9ndcQYmeQlw8tmbiOQYhVUpxnavVtJ4IdAgYtzhQma5
	QXNmTXm24X+0hS5fVFFMbvsXpHJ5qyKNx9iSR335a7C1YIfurxsVZnddiNA==
X-Gm-Gg: AR+sD13gmLGI8n/tjg6SVof2b4Bt78hUcivCg2Uwe0ik91qaou8xOQRttwL+VnqJBx9
	+38fPyDNNDfS25AsSXBEcl4dkDtNAcI9a3H4lNwzk91q5ZJQ2WDqs70rPnqHDs3Tjg3SZyu0S++
	zX5GKv8gSDMCegCGMzEMJE4BtLsrKLDxCy+hZEla5aHsuj3ihxKI0rnDyZUSq7ERa2WdgnKSNu0
	QrMR9dobDbv3ljr1YCrWCEV2BFk6wWRJiLCRmNIg+kyKrLBlnAk362bKhwv4Sveb9pQEi0YjllJ
	VTsiGmuyylXOMgktFl6gK1mn4M3y1R1DVXQlOZqfZic3dpqGvGKdygdl41Y9Z3bNl+E75yf2Z0O
	jJSuAo+rWGDHYUZP2yEOhbUoaaFqT9LigAw5dU0K1gQspE0+qZsoJiOjrVpyI9iiVrfl1g4jZnO
	M=
X-Received: by 2002:a05:600c:1da8:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-499821c3119mr76376935e9.14.1786621357809;
        Thu, 13 Aug 2026 04:42:37 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-499821c3119mr76376185e9.14.1786621357373;
        Thu, 13 Aug 2026 04:42:37 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499820c2897sm107064505e9.0.2026.08.13.04.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 04:42:36 -0700 (PDT)
Message-ID: <711d525c-cfc6-472c-b073-0fcfc9f95b14@redhat.com>
Date: Thu, 13 Aug 2026 13:42:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: mana: Avoid DMA queue allocation
 failure under memory fragmentation
To: Aditya Garg <gargaditya@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, kotaranov@microsoft.com,
 horms@kernel.org, ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, kees@kernel.org,
 sgeorgejohn@microsoft.com, ssengar@linux.microsoft.com,
 gargaditya@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260807210002.1695263-1-gargaditya@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260807210002.1695263-1-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 10:56 PM, Aditya Garg wrote:
> The MANA driver can fail to bring up its queues on systems with high
> memory utilization because every GDMA queue ring is allocated as a
> single dma_alloc_coherent() of the whole power-of-2 ring size. Under
> memory fragmentation these high-order allocations may fail, preventing
> the driver from creating queues when opening the interface, after a VF
> reset, or when reconfiguring channels, ring parameters or MTU.
> 
> Per-queue sizes that are problematic, with depth and size given as
> (default, max) over the ethtool ring settings:
> 
>   ring                  entry  depth          size
>   ------------------------------------------------------------
>   TX completion queue   64 B   (256, 16384)   (16 KB, 1024 KB)
>   TX send queue         32 B   (256, 16384)   ( 8 KB,  512 KB)
>   RX completion queue   64 B   (1024, 8192)   (64 KB,  512 KB)
>   RX receive queue      32 B   (1024, 8192)   (32 KB,  256 KB)
>   event queue           16 B   2048 (fixed)   32 KB
> 
> This series addresses the issue by:
>   1. Routing all CPU-side ring access through mana_gd_ring_ptr() and
>      mana_gd_ring_contig_avail(). On a contiguous ring these reduce to
>      simple arithmetic, so this patch is a pure refactor.
>   2. Falling back in mana_gd_alloc_memory() to a vector of scattered
>      order-0 coherent pages when the contiguous allocation fails. The
>      device sees the same page-list format either way, as
>      mana_gd_create_dma_region() already describes a ring as a list of
>      MANA_PAGE_SIZE addresses. The HW channel stays contiguous, as
>      advertising a scattered page list needs the HW channel itself.
> 
> Throughput testing confirms no regression. Since the fallback only
> triggers under memory fragmentation, the scattered-page path was enabled
> unconditionally for all eligible GDMA queue rings during testing (iperf3,
> Gbit/s):
> 
>                  Baseline    Patched     Patched
>   Connections   Contiguous  Contiguous  Scattered
>   -----------------------------------------------
>   1                  46.1        46.2       46.1
>   16                 182         182        182
>   32                 182         182        182
>   64                 182         182        182
Given the above, I suggest to follow-up and remove entirely the single
dma_alloc_coherent() allocation; you will get simpler code and less
pressure for later dma users.

/P

