Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B78426D03
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959918; cv=none; b=o++wLluBC76kfUZTis0z4mxhCNi8iaLfM3y9GJbZxgFSge2j5EPJadkytCCA9EGCauCsWELikZHYxDluGJT/hLgtbgiSKLAkOyxfr4URxAwtyvyZtkfuLnfzYvOlAFiC6eh17gQ1F8nXdLDcixcLPVTqcp4wyUHdPCNZ1Ux9UB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959918; c=relaxed/simple;
	bh=SKywH8MNPdivYCGdEihmGK/lbFOotmv3FlQiIRwxB38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbcUNHhkHi7PL3KqyVRM7PrWZe+7GAypcZ08lLDFKczJOheqMFJe0czczJBlcywye8frE2KkP+oCrkd+vKPB2NnBh/lTneIAMkP3Rb6aiOux32QlPCf0XdMDc/msH8LTGfc/uYGEih8l9ioquFiU067tzriXKqFE6nMAxrtRQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgVBtJ9j; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgVBtJ9j"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8897e83332fso2490957b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959916; x=1792564716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nNh/M3sOC7N/J+QZXKtdURAz2jbnsRv3OJdxTJpbjNA=;
        b=FgVBtJ9jCXmdaP5e3WAWbfof7fN7N51BmddrCgDw7cFxTdijC0Q/XwO0C4D1dgXw9a
         sd1t16LLhaNYYjcngY/Sx4+iiCxRvjToJ0zzj3ebYiVDPrqQgefXcolGWSh6bOs8du/c
         JHNIphpyNCVF0AdepgS4yii2MW5R34qCAhUA3UARxpmXR5Bshc/yURzE9yIUiAu35g8k
         PDzqeUuslZ5xM/twWMrmegNzdoTfEPeDLLMyFAaeeVmdCD57I79iZFRGkbfqJggSaAHR
         g4yasJuzG8zk21NIePzy9ypVImvdZDBCAmaih7TRiWEchoDdRb04gzJ2a62ZeMPiyaPu
         z5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959916; x=1792564716;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nNh/M3sOC7N/J+QZXKtdURAz2jbnsRv3OJdxTJpbjNA=;
        b=LvzCtuVmTtda8skrozQNfCBeHvT9E2zki7S2L0xbPC09Y33MzPouRRCsryKs+2UhDf
         9LFijXldRTqF4OSpEDOhfIWx5eaJ943MFpz93QvygRUsYcAfMIMCsGwYqPANExy3oB0h
         Ffd0K8AgTBSK9ARBV6JEObYkMUYMz7lwChPLgtqitdTmTJ621WJAim5sZ2Yrb5CqHf/R
         weTLm8uYOlqPctIyjftjhVtDNENY1D0Bvvz7TL3m5na4ANg4dgw7VeSppGtj6dpQL1eZ
         U+20cZgIl2Avx4uwqSQfCcwe1V8cFr8zZReKIOfTEVYDJEh0pXokDfrigMhjSZNdyirJ
         uBBg==
X-Forwarded-Encrypted: i=1; AKwUvBzePjbPuVBbDx9OkAzJZf2LN/w+a6XGbXawAy8wa6E3qlL935ITQGvkg3/kfJbVazv/PYMWS1s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPrxEOkGxqfGuXxPIqjUMKjEf47cFados8476IohGBNyRirVnW
	GDCmQpvx3E3nhIAtfvVEcvhytQjopOP6VNX61l41630DAOK7iv6DCcYk
X-Gm-Gg: AYBFou3DD5P7jRJhyZhvzbQte7y4CcC7e20KO+6ntP6pgt2Tq0mTKi1+QuZ1c8AuY4G
	sNf71MP96LLHZG61UHfAU4bpzWpeSQzB/jIzSYkw2uXfKLeRruAw2Aspv3U1iaKB9immxTI0nrx
	c9VaR6GqCaFc7Xnwi/FHsCI0sazd2xoqaoyvltr3cZouzFlmNDfh2SEAETcvd8CryKmeNRCLCMV
	E3jkMS4o50uklNnS5hWr7GnVLnp7EOjGcSKi0vgsTAcbvQgocuxjwshalvryInv3ImF8rKuHe8n
	A7ytJ0Rb/9csZwrtedJY+MGItHGkw+LeXuRvT98HlHyyxF0L+hwCjdkS29Ej8XdAyBIOfenL9rU
	vb/J/L/7w3DE2fJ5f35ptRcdtcISJllJu7vhb4grr7JOERON6dZHDRpmatdjygu5EZOVp9TaKtB
	mumquuJeI19NpliifBxI0Q3N2OC5iwfUmakdH5QDGUwrAwANQOF2/4ToSW6501lkf2BDioqpc=
X-Received: by 2002:a05:6a20:a120:b0:3d3:ad6e:9ce1 with SMTP id adf61e73a8af0-3e16bd54a69mr8958658637.15.1791959916302;
        Tue, 13 Oct 2026 23:38:36 -0700 (PDT)
Received: from gmail.com ([2a03:2880:7ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d802a4314sm701933b3a.11.2026.10.13.23.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:38:35 -0700 (PDT)
Date: Tue, 13 Oct 2026 23:38:26 -0700
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: Add reset_prepare and reset_done
 callbacks
Message-ID: <as8jYneJ32Hl++uj@gmail.com>
References: <20261011094809.790798-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011094809.790798-1-tariqt@nvidia.com>

On Sun, Oct 11, 2026 at 12:48:09PM +0300, Tariq Toukan wrote:
> From: Akiva Goldberger <agoldberger@nvidia.com>
> 
> Currently, the mlx5_core driver registers only the error_detected,
> slot_reset and resume PCI error handlers. Add the reset_prepare and
> reset_done callbacks, which are triggered by the PCI core before and
> after a PCI reset, respectively. These callbacks let mlx5 quiesce and
> restore device resources and commands around a PCI reset, so the driver
> no longer relies on the reset happening while the device is otherwise
> idle.
> 
> Additionally, add a device flag to indicate when a PCI reset is in
> progress to serialize PCI reset flows with other reset flows, namely FW
> reset. This flag also indicates to the reset_prepare and reset_done
> callbacks when to do a full unload/reload of the driver. When the
> callbacks are triggered by the hot-reset FW reset method, they leave the
> teardown and reload to the FW reset.
> 
> Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  
> +static void mlx5_pci_reset_prepare(struct pci_dev *pdev)
> +{
> +	mlx5_drain_health_wq(dev);
> +	mlx5_unload_one(dev, false);
> +	mlx5_pci_disable_device(dev);
This disables bus-mastering, after which pci_save_state snapshots it in
the disabled state. reset_done() re-enables it but the snapshot remains
stale.

If a FW error later triggers the sw recovery through mlx5_pci_slot_reset(),
the stale snapshot is re-applied with pci_restore_state().
Would this disable bus mastering again and block the driver recovery?
Should pci_set_master(pdev); and pci_restore_state(pdev); be reordered
in mlx5_pci_slot_reset()?
> +}
> +
> +static void mlx5_pci_reset_done(struct pci_dev *pdev)
> +{
> +	err = mlx5_pci_enable_device(dev);
> +	if (err) {
> +		mlx5_core_err(dev, "%s: mlx5_pci_enable_device failed, err = %d\n",
> +			      __func__, err);
nit: mlx5_core_err already prints __func__
> +		goto clear_pci_reset_flag;
> +	}
