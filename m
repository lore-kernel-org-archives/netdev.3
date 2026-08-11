Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C247CA91
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482889; cv=none; b=hCo20M8D5NM9GEUoDbAD1FKW6ntdSZJzygYmFOccnD0QYwoUja3p3Zpnxdk6vll7wGRuTjV9rZ+6QWjoNjxE7DsGGvlJxES3kzBIa9Z6r2MpAYd1u2qoLy2DJqguMUhWos48tC8c4cAE/SrLtTYpZf4edPjdEoURxeKId9hTBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482889; c=relaxed/simple;
	bh=vELLWw0jcQS3izlB2sdDvaRC3WcKac/J6CTcP0dIWC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUvPcrSqOw4PhPZ6l78qxRSZOWsVnLyGVqU4QdPhvlVABITAvpaSWt7PW0GBGo0VFR6gBu4uVzMOLMM7sLrPE/gVb4kByBjdW/5/j6xQJR/wth0YqmhII97JWRSoKLODBwNZ/oq0A/1jqA69W6I8IsCxGObW1wrFNghFNzq5rU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+MFTJjL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+MFTJjL"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84867f07d63so379546b3a.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786482886; x=1787087686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bsIA9G0uzM6tK8/PrMCXpabodZWsD0MRjRT85WaMGF4=;
        b=H+MFTJjL6DsFW2bzdPklh53KwLU1o6fu5ZdLvHvRyYZBSRBDNXc1mfw7Rmn9vx6wuB
         TVL7t3DDP0gxCQVFmbfKbcee4LFVgaOGZOaUQx9FJF3AYplQJbE9EDUE87C5KLY9x3VM
         K3o0LEMu+2mAPcQQ2tWaFzZBlhDEcv3QXxFikaf8A5j61EaZPghIAgORHVnuYl11g6P9
         ut9OCBpauyhJ5uYP+FdxMdDsJ2RZsV+BNdYEG8y3aRr26tm9HI5uHwS2ON5THX5QAZ9h
         bsXvRj3D6ROk1ILtMYNTwLm5ueHhrmCD6V1SuuEoA7k+faqDM810Sa50pDHDK93z2YRR
         sKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786482886; x=1787087686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsIA9G0uzM6tK8/PrMCXpabodZWsD0MRjRT85WaMGF4=;
        b=Rs+kKKOv+TJpI/wFnWrg9pCOKPz0UT9HXpoe/rk2p+0q/fbtLr1ElMG68ghvgL/Qyj
         PhnVk94BsFnl8Qezk+3GVy9Vbc38rytqw4jP9PSkdP5gicQroIfz4dEhH7+TXOQsEhRY
         7cScOqDrBwRaLK6FeOTBgq/GtRJR7egHIAWU8atndJhOVPfVrEgTFt6Z7NANNeGpy+9l
         zZwpYJUZlJZlTA2r2UlnZQtXZgEjsUwhkh4X4bOf2MWyUlhpt6XOSgIU5/W8Nrw8Wa0T
         7uaZ7cKzgMFhBb6BVk8tsQCYcCdaRqo5wF6v2UquCO159+BRcWuXXC+xw0Lmt7Z9+7bD
         mGDg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7sVawfLtcEsiWXeeNBkp8COzHByUKTgQw/DM3FCfMaw7800SVC4i+/DB7g6r589oG8GlMqsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBURWqE3xoUhuuwFkN59PFm684IHMfBsYfNy0Kl13Wxy4421r3
	gdZy1QIfs/lQXpoDuPEClS2QxrmAaxCJET52kLEuM4FhUjXYDhGCwP2ZM/cbTKBueQ==
X-Gm-Gg: AR+sD13wBfifseK6HxwWlc5JzOYhBkhLHtseL245dgmn9eSZ3eAmutm6IrKAELW3nI0
	H/1ODcG5oQ+aQw9jwI1S6mXan0Yhwc8wTo0/zbtjgE5sxbOqmqd6ptlzsaXPhCbpnGLlUJJ5Juv
	8ag5Zf90QTCOtLAfJ3or5ECKgr3MOnYZpO3EP8/Z/QDWcMGtS64W5rbyqM9sR5tqnUK8evo0Y9m
	GZFD9oPYqqE4sKWV8RsZQkHUcCZMpveJbMGsnZfx3WN4EFT3LZI0D4OQBRRjBgmEXeT3vOVqaMG
	GPAj29sHNJAEtVDhJf/xkkG2xLDVfopUtkCmtt33eYfezxoBSsvf4+QDV4wwsvZKoeYik0PCEhE
	TSvuGeO62I1xTZbh78AEqbnxT19RLsckd8uldVvjoi/YOndbbwQJfleDCu7qH+6x9qpTIb/ejsG
	vEYIm6PwzxGSBeVV4brvOjG6O6wGBzMfB+/VxdHJ7I0eestmB+OKZOizC4cNlW1hYDs68d5WXpp
	AbiWYK1UGCt6/7nkAiZJx7U3FU0LQ==
X-Received: by 2002:a05:6a00:1d98:b0:848:4c0c:9482 with SMTP id d2e1a72fcca58-84fb5596c31mr161407b3a.35.1786482885795;
        Tue, 11 Aug 2026 14:14:45 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1f2645bsm237399b3a.50.2026.08.11.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:14:45 -0700 (PDT)
Date: Tue, 11 Aug 2026 21:14:42 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Justin Stitt <justinstitt@google.com>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 06/11] selftests: Fix arm64 IO barriers to match kernel
Message-ID: <anuQwhVv5UhjS_ER@google.com>
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
 <6-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>

On 2026-07-16 02:03 PM, Jason Gunthorpe wrote:
> The tools/include readl/writel MMIO accessors on arm64 use
> inner-shareable barriers (dmb ish) while the kernel uses
> outer-shareable (dmb osh).  Fix them to match.
> 
> Add __io_bw() and __io_ar() definitions matching the kernel's
> arch/arm64/include/asm/io.h, including the dummy control dependency
> in __io_ar() that orders MMIO reads against all subsequent
> instructions.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

With the changes to tools/testing/selftests/lib.mk removed,

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  tools/arch/arm64/include/asm/io.h | 20 ++++++++++++++++++++
>  tools/include/asm/io.h            |  2 ++
>  tools/testing/selftests/lib.mk    |  5 +++++
>  3 files changed, 27 insertions(+)
>  create mode 100644 tools/arch/arm64/include/asm/io.h
