Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C992569F14
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188261; cv=none; b=rIsdSbf42g5ZOE2UQ6ddRYPaCdjDb1aa68r8iZje+R1p34wicT7ypyehcFfDBa/UDZ1CZwdRckCOTz90LRzUJtPcvv7id9ZhD0HrFWF99jDarardWaGm7w4cNg/r3g6nGnuY0XhzzC49sGD5CcpXFWTkbFMm+E4zmsGRlBDT2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188261; c=relaxed/simple;
	bh=lWag3oM9sYGpdHyGnDE7rA3iXeVqrktsZhX6pT4UGs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVVRke9H7pcAi9YkKFu6+IxpY/pRcY32jIE9zzMWZIafyk+wjvM9vu8uG5TyYWxeJJV5FlvHJrslA4SmlU+/HJuAR5cS3ShsBSpsuMomVgxg3vbmUzvTnwiATiO/fReEOvU/QMU61Tp6C6rT+X2WQl8W6psFK7eju84cOl7syCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1wvptqi; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1wvptqi"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8623e5d435cso442285b3a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790188252; x=1790793052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qQbES28pq+4+5SdsOxa0hPCoAfkWzPeIh6+fD64KIF8=;
        b=E1wvptqiw+pIqCzP22ej2RYU8FRDFz1Ld9ldOvcLSSSbCnlwJ9BWSWcZFvnURIrw9x
         2qEFsmL20+6/NsbnqZm+1xvcge0Z8/LQQ8hGm0llzFxLjWZHaGD8nC4BgmlMNjZREm6h
         DcPAP3z/Pgg3vX5zvXXDYFNlHXWywJNjtmq2cYaD8/6gfN6g6Zyd6CdRR0F6PUpZXVeM
         kTF2ZcXZJ3Qg4jp8jLug45LdXJcUFui7Zr5p5r4s/ZUy9y1lllH077Qs+D5E2JUnK6pT
         TqYHZsj1RjKaxL38Tqonf6cVfu6CvZfKXck2ZRd4jqFXFf0zd92U0hapejdiROEeLKGZ
         nzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188252; x=1790793052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQbES28pq+4+5SdsOxa0hPCoAfkWzPeIh6+fD64KIF8=;
        b=jjVecZGJXAx1Lo1RtgIf40wucW6N2Z3RDbTmLzSJMXrA28UGl7TUdatHLTm6RneHYY
         AFdO/V9+qeJINWhK25tgfXxYMgF61VXpM+e8Xby7BoQSlspKQo5TiJi1pskI4ltIhDFP
         ocxw9LCedgxngDk2eU1VLmCHXzS8BKdF4ij+8csAguueGWSmFx4XzIS69XwgI+3WPSfE
         yrK1esxsNR1ufqBJAkw2F9iW8ir6G3Zk21L5mgZ4EtpIF5eZRCFNVKo92p8hh+wMOPH1
         pIvUcqQwmyCoSjtgwPPdANBu0aD/GeV4SYtSGq5/VSmpPFFz85f5rfP0H2iWPYsJ5y0J
         eTOA==
X-Forwarded-Encrypted: i=1; AKwUvBxW/qWnEKnm40tIhGXL+fE/mZgkNvOapR5sg39lJfx9QKmo9f90QtcvCklJZ7V7AZ1cKUbubOc=@vger.kernel.org
X-Gm-Message-State: AFuF++mYH2s3LjX9dUHdMKBglzH71U09qky5BCt9rH4sfETo4TxF1UeD
	nFkYZW4GQHwFsakwDF6pmIxwbaz3qIG7U6FXwTj7ni464vumrDMjvBjQ4z8KlGTObA==
X-Gm-Gg: AYBFou0NSr47OcEFtMgNd01gzrKeY9mEL8OWk/TwerWoveMgQiZpB3l22UA5ccNlMLF
	32xVddejYEEcj+TwmcHIiolVz572awI3M8XEOvlfNW/4QC9npIHvnmVB1K5FMyUyXcUrrkh5nP1
	6VIqIQh/2E9c6T6WCejmopoYxe441c9ySajFDf9XTfZzjwng4Ef6HKdEaKlZ1B3jX/vP+6enX+B
	r0URqERBKqwdrhk2axhIVSWGAfcx1SjYx57zFgWfAIXb6xq7NBub8HQmg/MyKXAzkJFZCl/17e5
	oATmyU/ChuoRoZPL6EyEqp/aomFLUHQAEwraTRF1seb9qN1vpMuyGdc/XjKWNAaKmBgOOpBDBDG
	7s5jCUtbQJFGGkTMt8g3SyG+YNoSRwC4tuxt+B0Bo597/pFLvHjtdEOwke3012eFrQX2dhcVMVI
	u6b9gr/NhjNHeOERyQeEwz20UB3kFkMPLwOUzNqDgQ85B9VRJZgomBe9NMqcaA7FfLeLOYlpFnA
	HsqF70npw27zXku8F01gHsPh8ljiLxs5DKS7PCS1wMc9jEMocc=
X-Received: by 2002:a05:6a20:7290:b0:3db:131b:8d8 with SMTP id adf61e73a8af0-3de0e7300c0mr45910637.14.1790188251251;
        Wed, 23 Sep 2026 11:30:51 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c12besm1736810b3a.29.2026.09.23.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:30:50 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:30:46 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, Leon Romanovsky <leon@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Christopherson <seanjc@google.com>,
	Steffen Eiden <seiden@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tariq Toukan <tariqt@nvidia.com>, Zenghui Yu <yuzenghui@huawei.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 00/10] mlx5 support for VFIO self test
Message-ID: <arQa1khEHzKOfkCK@google.com>
References: <0-v7-c6d30e8ce1e4+3dfa6-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v7-c6d30e8ce1e4+3dfa6-mlx5st_jgg@nvidia.com>

On 2026-09-21 07:35 PM, Jason Gunthorpe wrote:
> Add an mlx5 driver to VFIO self test. This is largely a remix of the
> existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> to issue RDMA WRITE operations which effectively perform memory
> copies using DMA. Since mlx5 has a stable programming ABI this
> should work on devices from CX5 to current HW. The device FW must
> support the QP loopback configuration.

> v7:
>  - Fix some compilation problems, kvm and the igb

> Jason Gunthorpe (10):
>   net/mlx5: Add IFC structures for CQE and WQE
>   net/mlx5: Move HW constant groups from device.h/cq.h to mlx5_ifc.h
>   net/mlx5: Extract MLX5_SET/GET macros into mlx5_ifc_macros.h
>   net/mlx5: Add ONCE and MMIO accessor variants to mlx5_ifc_macros.h
>   selftests: Add additional kernel functions to tools/include/
>   vfio: selftests: Allow drivers to specify required region size
>   vfio: selftests: Add dev_dbg
>   vfio: selftests: Add mlx5 driver - HW init and command interface
>   vfio: selftests: Add mlx5 driver - data path and memcpy ops
>   vfio: selftests: mlx5 driver - add send_msi support

>  .../selftests/kvm/include/arm64/processor.h   |    4 +-
>  tools/testing/selftests/kvm/irq_test.c        |    2 -

Sean and Marc/Oliver, can you take a look at the changes Jason made to
KVM selftests as part of this series before we merge this into the VFIO
tree?
