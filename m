Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9641DEE1
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483377; cv=none; b=AOgL5VeH8bjTMry+E7M2Vw2b75PF0wFU6htSH9EQ1933lj05nmw/VDZjJPwGtmecj0EQwnNkCh/gd/WjykYBvyd/M7GzqEbg6dFgnTKqaoTq2VjCZTMm/lpT3CRpBxfa0Ir2cPNTJN9G/0DeSTm9zQ77IH2GVB6eGS1L9pQglyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483377; c=relaxed/simple;
	bh=XN/rifqNvJQDtxhcJX1CkOjTxm/idHUoaQKoCIcr3J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMEhdf7EhfOxiRpyY3YpeYXKsXDxDXxAV965HI7ivlx9CAw2Sy12xEFQ9bV+sdkitxyz1iQOdMDbE3Txa6ggA8B571XjB12g3nhnxG3IwehW8kQDacDi0yfVrGtyCJwGMoy9Yeq5DcqcmnANDVblI6qYTaIMtgmLIJTuutEwgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHLshkuD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHLshkuD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so444958b3a.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786483376; x=1787088176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=duzXNp2G2UESyfsX/Nv+I5To/x8QlNagRZc9TfujvZ8=;
        b=iHLshkuD8hBFuauu4Di391vGvcjQPTjaGzzEbn5A5oegjFPuo2toVazuiHN6PYmxAb
         /HpeaZ7L7FPd2yTnQjuluPzw2qiaz26lrtn3pQu1kZ4cVTxgo5BKjGilTiLxUTwV4eT6
         em6hDsWoiS+ZCtPV54S7Wg1VaWBad7TAFpQWvmLxaNR9V1eBftl8BqCFF6hraUieoE84
         BM/SD5uATWeSfQY/znDz3wI7Go4cW22PGFkMHMFP3eDnMDiuxegNYylALhxUhHMkIcHZ
         Bf7aMENNcRKgAG7GIoc3J9AIIgV16iuBudza6Y2fGq5QIb8b0/ewFob6ACmvz/5WZYnS
         QJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483376; x=1787088176;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duzXNp2G2UESyfsX/Nv+I5To/x8QlNagRZc9TfujvZ8=;
        b=cujKo01s9jZvMjpNAC/qr+qCEj9AVC+gwm+pofiz0wpogncGv9gAph7/T1YZNS4zhY
         jUoZx1be/fc8u0p8winUNfVN891c/yaXr8sxKaIWnP3XxFwnKQk1iNfa2s4hAHn5DJQz
         5F3i58qOf8LADR2ffRKZNSpmYzFtX2uI6cleCLCZGoIiuWXdu9XNtHlYvngwmAWBLJlz
         yWsVbJT4Z9rcz72ws5e7Q9QcftS0gMC+KW9AahnZZqfxDgMUIwFTYnVjmLMLZzk17W5U
         TYYyBXkifzEiKM5TJQJY3JYYH/t5L+l10HEPty8Qxc7kkrIx2BRBNM5YE0HiVmVL8aaQ
         9p6A==
X-Forwarded-Encrypted: i=1; AHgh+Rq+cgBXVejuan339tAoYcCTk/bcZeuuN/ZjomeL0EM0NuD/m9PRkqTDwyoMMbNftW0cPmFkIrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI87QCdDrC81P2Qxe8F9f4kqQsvI4ikzL55rdxoyilWqOZgC6G
	mXT/oQgHohqZ49gdofHGV9QvW+/2lu/Qy7YeNa2j753asOBLYG1OqhWCOg5DRL9INw==
X-Gm-Gg: AR+sD13INdkrVA1VOdZgh0QOqassLAS4JGN5almThkNZYd6YCtYAaYzHd8Vj+QhOGqS
	fvaDvaLJQxHPVq7Fpfz9qU4+BY7MgK7ZOldM1GKOyBwCB7HoNtty0imX6d0JcUlVTHfA+o0WC5R
	Nl9zLNzG6ENgfuphtSjkfQfveGTnlNxlqriCkKZW1CghBqIUd57kCpY13hARtXzodhZlDZzdMhO
	74noz45Ql26KWM4rIW3CEuIwAu9vYHSb84cZ1JhAfom7O5zlfLtyOmyShMMZtAvEsZ1PUbvxPhd
	BarJc7j0mBZ+pwobBcHFBZ3qiXGYYrQOSk6VFrqEzJGIJUNO4gsT5xP/VCeTVRZV6YZs3hwq5PO
	Z3YqzwcapAmhAC9dCO1ijFccgJ9pcZPLchXhYYymTPUUAMTAxylhNss/w3V+SR3LowPRTe2xBDq
	vJLwq0lLkGIm8wrhTl/IqjRogF9w+V1fMO9O69XCgSLEHt/kkX5eRW2u39uA2yW9szn4K/jh99b
	XAAEbrwbekCRUHtdooPEVLSaCGcfA==
X-Received: by 2002:a05:6a20:a105:b0:3c3:a168:edc3 with SMTP id adf61e73a8af0-3cc2bcbf252mr7676629637.38.1786483374995;
        Tue, 11 Aug 2026 14:22:54 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbed8bdaeb5sm1461553a12.11.2026.08.11.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:22:53 -0700 (PDT)
Date: Tue, 11 Aug 2026 21:22:50 +0000
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
Subject: Re: [PATCH v3 11/11] vfio: selftests: mlx5 driver - add send_msi
 support
Message-ID: <anuSqnU7WPy-9enn@google.com>
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
 <11-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>

On 2026-07-16 02:03 PM, Jason Gunthorpe wrote:
> Wire an MSI-X vector to a dedicated EQ so the mlx5 driver supports
> send_msi().
> 
> Each EQ can be linked to an MSI-X vector, and the CQ can be set up
> to deliver an event to the EQ. Thus, when everything is armed, an
> RDMA WRITE posted to the QP generates a CQE, which generates an
> EQE, which generates an MSI-X.
> 
> To keep things simple this just re-uses all the existing QPs and
> CQs, so they generate single MSIs during memcpy.
> 
> send_msi() drains any accumulated MSI EQ events from prior memcpy
> completions, posts a small signaled RDMA Write, then polls the CQ to
> consume the resulting CQE (avoiding stale completions on subsequent
> test cycles).
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: David Matlack <dmatlack@google.com>
