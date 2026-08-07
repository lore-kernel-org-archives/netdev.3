Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014434BA20
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124915; cv=none; b=PGYOP+oEuhtk58VKinkzxpfMFOhM7b6siJM+Cc7zTMmS8Axp5DHhF7Fr2C6ukV2IWC/izf0bueDLtffg674C/1rAHaGT/RN16FO7CGwpDzUtF9pAOkTRGhAWsXAwFhjhENTBSzqlhK81wXSz+9VhTFJbEM8XpHt2llml9NbFMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124915; c=relaxed/simple;
	bh=B2dhcUAy99nJ6Q8/2A/3L1wWVEyE/AbW7wE9iaKuQWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsB75Mo/BnUJV6zaNaq8PP8Xj3729Egnz0amtlU186ywjhnDK5Clz3I50KZXvkTRlfbPC1pyAPsdGRkXyGQBZaYTQ0CI99CTdKzU4VtUpEkoTt1mOQnqpLtbEkU66J4K31ZP7zL/r7rHfYs1X/3lrBmNWW82UdfZieuNf8L6XLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RUNoTSIQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RUNoTSIQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c16ac21acso23023141cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786124912; x=1786729712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5IgWT1wGp6cqflJGNJAuwwfXTXvrfSYmZSZMvhYv0I=;
        b=RUNoTSIQOr7hxR2MvzQYz+TKhubjcVPdYCRIhq/p9n+anptqVMW96Z5V/aUxhOqZyn
         jqlL+lYkbpJRHRD8dReO6q+HVKtGOTbiCAuoygUs0QR7fvOI6XrUHbC2XSHopJ9FbNKK
         jyL+Vfnt3fc5nAV26iXex3Le4zf/gxiOhtu0dRsiDCuCrd6d6rJrbZDXw/ZJBBKRoHG9
         a+yCPFGdl9oyyxudCjgwNOU+ehf2tI+cLSeKOXk3Kt0tvK1PjdfUtSJGFB8WC9ZJFAmg
         xteMd/qhUx5ovrhmqZ9X3W83nMzKgSRnIkjNwTN3CnwL4mSuAo05MCQugHRCHc36mumz
         d3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786124912; x=1786729712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a5IgWT1wGp6cqflJGNJAuwwfXTXvrfSYmZSZMvhYv0I=;
        b=Dk5LWvs3uSCNI1k8VwWRKkAI7rVCmVqIwdeuF3KNjTnAfmqEmn2LKNcLvuUChAatXn
         ePTpXSYoWKa9dKDmtJDO9Uo2+U6m+hpLa0C4stSZCw9XPGdzYEro1hy2Y0BlDA+pg5SZ
         DXfY1hn3RQPdPfs4Sqvjy7ClDn64Apd0dsGs/Ym7HJ3lVNVTid5hdb0zVMAismU23nRM
         t6zLjB+st5lgHaA0qRN5riJY+F3zFJz8mZruTNdKLbocbXl0wjQvCw1N51iTvYisW1Z8
         2RxSdPvEQOZPhbgyRjjG3cba0dvLK3oF8FbVHxpl+vmBXu/KLv2MYwkTtaKMTK+zQ7IZ
         t4Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rpr3+DvF1DQ7swyfhVZ32mYFXsyMohDJhS2V2XPuWwIdHJf33UUdc8lKxRgKZRToLLL1eiWYMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAnrLgnRDJeOqhZcyq4rnqB8mamKmKe2nvUvHxQexEiUYfDp5
	iaF0mB2kFG6RbhcNBgWU+hQ+A7w5qihv+roaPQIE+hYxFaSYytIRFp0tDL3nEccapXY=
X-Gm-Gg: AR+sD10oH/uqDkwWKffVnycHVVo8pfl/rp4MRxiUiIJ2FVMvX6QoPIgFHS+6d19G+Wg
	GgAHsL6D1yuoNNnfpN4qmDxMH5JN15RYKdQ29fjZLegYoGDutnfKcyLlP0A2GmQsUk3zwZLGxxD
	Anz9qajQMOwNG1U5dQMFBgQztMU8E4bmKFEQxPcRHtd42C4JhFI/qLwEZ6qsU66/+qZ82HHBNRs
	OcBU5bx2wpCGmH8+Qkk7D6Cz/PjBuKRh4mPDavHWYAEORn3psm7Cbpsfhu4o/k+SUaG1EGgIfMF
	ult8nMeBd5Rsl7JksMG5FX34W9eDsA6sgZTE9IG7I8sM1kSFU4Q4OEkWQEGH/4zbz0BhCH20XyR
	A/Go1F/FHtOgXzbEmxFrvLMRdO3H9hG+THUPodrXO1cxGlqsaCk6MuNLrpZLi207UEFm6HiJ6e1
	q9jMzvlbFfT8pmtvXgMz6cB8s+eTfXBa2Z86VR9Q==
X-Received: by 2002:a05:622a:c8c:b0:51c:2340:bbdb with SMTP id d75a77b69052e-52d18fd59d2mr61313441cf.26.1786124912297;
        Fri, 07 Aug 2026 10:48:32 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d166297b7sm17136451cf.26.2026.08.07.10.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:48:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsOgI-00000001ArF-3vYh;
	Fri, 07 Aug 2026 14:48:30 -0300
Date: Fri, 7 Aug 2026 14:48:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	dtatulea@nvidia.com, shayd@nvidia.com, moshe@nvidia.com,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH rdma-next v3] RDMA/mlx5: quiesce CQ polling before device
 shutdown on reboot
Message-ID: <20260807174830.GF200537@ziepe.ca>
References: <20260715082307.1593915-1-chenguang.zhao@linux.dev>
 <20260716084211.GC70906@unreal>
 <c2c5dda9-3228-44a3-a4c9-89e8cc4501bc@linux.dev>
 <20260716105008.GD357857@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716105008.GD357857@unreal>

On Thu, Jul 16, 2026 at 01:50:08PM +0300, Leon Romanovsky wrote:
> On Thu, Jul 16, 2026 at 05:03:37PM +0800, Chenguang Zhao wrote:
> > Hi, Leon
> > reboot -f skips orderly shutdown and goes directly to:
> > 
> > kernel_restart_prepare() -> device_shutdown() -> mlx5 shutdown
> > Upper layers may still hold live CQs, while ib-comp-wq keeps
> > polling — a use-after-free race.
> 
> The point is that this flow is neither RDMA- nor mlx5-specific, and it
> works as expected. mlx5 shutdown() stops the FW/HW, while the kernel
> stops and tears down the running threads.

I'm pretty sure we are missing stuff in the driver to synchronize
everything while it is doing a tear down or health recovery.

Ripping a driver out from under a still-running subsystem is hard,
this does seem like a real bug, but I also don't think the shutdown
handler is the right place to fix it..

What was the actual UAF scenario, we should take a look at that more
directly?

Jason
