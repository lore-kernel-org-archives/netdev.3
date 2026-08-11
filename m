Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA783F4854
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483315; cv=none; b=IJ0dK6uy3SehRCHPdkckJtJqmq31qDICfAfzqOqcInp4t1MWWNEz5ehkEvwzeI5BBZdVMJWCcEvCkpiE68c4U+T+AorgQzs1bMTM69U2DOd9SH0jTnrHHws1Iaqtw7oY+lSiW5N1ACl1SLLql6jkPd+7YInBZschp+agyECduA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483315; c=relaxed/simple;
	bh=Fs1q1LuXAYTQ937j0F968WLbSfpvhN7jSqDN7Jd6uBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHB4eWQL3SRjrx6psR02tWGV/AdcDJRRSulxZkby7SsXFCYYR+oNPMBF4wRufLJ1TBqgPqJWezH71TOg26ZOTaY9E24Q3ic/Hmc/BcEK3UN9Qj1Ih7fxnBjPpbQpS13RPlzWn79aX4vePq5Qh+wPZTMrHUfJiQw+P2SHVKs3y3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCnsIJii; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCnsIJii"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so5372665ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786483314; x=1787088114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GgcKeBktnliFILPgH5Yp5qgxA2fPy6McTHeUrYz6elM=;
        b=oCnsIJiiAa+BgmeANSpLE+VLIkqqf6si5TmkXYqWUN7rwWASs+8tCFt8sDy9jf45GE
         dNZQHLhAJuuQ219/ZhzhV9yMo1LlFBPYZo90lR6Vj4S/c1yJ+ncXs7pC37Hibsaol2vM
         OZNpADAY7eNS5dxoHhjOMCAvS7K1rUa3m857YFfWUi19LDam5t19cwLQ8ggmCwBb7idD
         ZASg0IS3qgO7u+iiNRV4wdmUzVJHr9b+vT4jTUDYToVoL50OEPlT5rrc7NsGal0EK96g
         IhYKK4MXhwdw8ywAhnlhd5iEHD7LRmQwUFyXdxmmHfu4S5ktCLUSPmcXp98j9LYuTu/n
         7h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483314; x=1787088114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgcKeBktnliFILPgH5Yp5qgxA2fPy6McTHeUrYz6elM=;
        b=eIZTtO6R4wUmLwtGS1GSghwsLO6EuIygI4tU2qnDZYPm525m+MDboqndHO2tuXjwK8
         li39FKtgpknE/t0zls48ufIo6ZqSDVQfmuJlU+AGWo9TB/Tex9fl2u0JsKH2o4Fj8Rfv
         1/SpDL3n7luahqxiVaiuVadUMr14G73j+gUmpe36yrDFIoY7aNfvqpv3KXwwCt4aCvo2
         96lVikTKwkDDgLqGem5cWjwbbzAcG9zgNVlCmBIuE3pZgW7kR3Y72I1Q//IXRoIVYuga
         AuZeX6g4Rtre9Ef2Gf+A17Ud5rKmUjCSctxnhZhhX3Y1GF7rKl2zcznHL5HpH//0J7eh
         6dfw==
X-Forwarded-Encrypted: i=1; AHgh+RpVkzTN+hgAfjcYrke/yAftRI77/CgVTAnWmpDJ3Wio9BQB+MkWqMzmANNK+x3t4Op7en6fMFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpag8dbNKZ0EQ5VjkkhM6BBbX3HrYMWMdXvF8qBYU+/ffbxVr
	Qw0sciFbnc+4rhjJLF+0z4uH7HdhMtaeQPzveCTF4PZqGUi2fGOALfiQZUZnyVIOtw==
X-Gm-Gg: AR+sD10rD1S9JRSK0jVcxQ7z1hEsgKm/kbg62aDXBLw1/ua/PhT84Uyvhm+0jZW95Ki
	JJNDliHwgzaTldSbZNGawySl38NIesIXadVHhJd7gMULE1ndk+z5ZcryCLeaGYjayxv57kOrkcb
	V5DahzBbgTZPrSmBIOhRCZHsmmui0zQyUJJJ3s1CekKGTf5TnsS45Zd4h+xFg7KlLKFhl+pSzva
	dmpPa2ISnEkKwOWe60KwiZqexvXtsTDUjtYW6xFV5Euko4aWuc1zsYXW1F6s6IVyX+bwbH99ooW
	QIBK1lyRgVjLBQsg95SnVo+YkrvahVzw3o8sZlmqyTS7vado0/2tUikh46hNLftmlj8MIM0tDv9
	4aJsG1FbfIYRXRiXL8ryrvN0Nd8Kbf0eBn8kLoiU+YnYHz3zTNF9T0YTDmehq8p+BciAXDOxSLC
	1BAgwsRVzXZCcL+5kxIGMbgrMUFPtou/jAFqHJBBuCEjgnM7NbszquSq7dKppNRx/8lEWA+u0kH
	qNz9Yt3CKp1kZZxbEgmVT5b+27FOxi5dTeI6Sc5
X-Received: by 2002:a17:902:e946:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d34535651emr6182815ad.1.1786483313141;
        Tue, 11 Aug 2026 14:21:53 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315f29d82sm12934165ad.20.2026.08.11.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:21:52 -0700 (PDT)
Date: Tue, 11 Aug 2026 21:21:49 +0000
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
Subject: Re: [PATCH v3 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Message-ID: <anuSbSEiEfCC2MUR@google.com>
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
 <9-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>

On 2026-07-16 02:03 PM, Jason Gunthorpe wrote:
> Add an mlx5 ConnectX selftest driver that programs VFs and PFs
> through the command interface. Create the driver skeleton with
> probe(), the command interface, HCA boot sequence, and all resource
> allocation up through ALLOC_PD + CREATE_MKEY.
> 
> The driver implements vfio_pci_driver_ops (probe/init/remove) and
> registers with the VFIO selftest framework.  It matches the same
> mlx5 ConnectX device IDs that the kernel matches.
> 
> init() brings the HCA to a running state:
>   - Command interface setup (two-slot: regular + async pages)
>   - ENABLE_HCA -> SET_ISSI -> QUERY/MANAGE_PAGES -> SET_HCA_CAP ->
>     INIT_HCA
>   - EQ creation (CMD + PAGE_REQUEST events for PF support)
>   - ALLOC_PD, CREATE_MKEY (PA-mode, covers all IOVAs)
>   - Force-loopback capability check
> 
> remove() tears down in reverse order through TEARDOWN_HCA and
> DISABLE_HCA, including async pages slot drain and FW page reclaim.
> 
> The driver region (~18MB) holds all HW-visible DMA buffers (command
> queue, mailboxes, EQ, FW pages) overlaid as a single struct on
> device->driver.region.vaddr.
> 
> Data path ops (memcpy_start/memcpy_wait) are left as stubs for the
> next patch.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: David Matlack <dmatlack@google.com>
