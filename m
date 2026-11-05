Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898126;
	b=U0y+scqFrZRqGpX3FiXTvAeQIknjf4PhtMncTV9gNrX96LxTsYIF8clNCdjXhThqtsN5
	 1TO9X4r3TvEfglGqBtBTgDNRDbuLMC8rYheB12TsinsocI7sSsaVLFXHHzI4P63i0IkdU
	 OC2C+eaA6CxZ6f/R/a7IdG+oTRLmPF+JyMWt2ouLMu5SuAyFGYqEoLWiOYFLchqrQJzs4
	 sIGMhEFQMG0m0dX7ZoXKrWU+9+43x6xwv34S93SW+swURtKouT+mR7tKN34D/pn/v+bF/
	 yeW7KVgvOEFb2f0Tn5Rtof2GEG11vF2lbWmPkUP3IcWHPBzYTdKKYn3ESDrk0CDAHqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
	b=ThEpF2RHGtFst/LnK1SV8HdV7yo1YCgqyX4LV/QOP/LmvOKLODmahxLGaWA5IUxY+lcr
	 5P6ptbV23S9bWi93+o+2eedw/kImN9JyfsMM3VtHvpzKXwyoAHPSitmuc4h/95XAbcxrs
	 MnssfhDRzfYezcBjCwMhcDKq5Q8oNGiC3CR1jML1bLDNge3qCvRjZIO6x9HAmRca+jnjL
	 qTKAdIf1OyZE+Y/p3bS/kk0iTRDOCUAUJkUPvxbWURW+XyUK45Xms334aUbeMBjCVt2cW
	 2BqiZP8svMSDfGEjsGcQBxwY9GLTCe20Pj9J8Mkvn/7y52BKz7rENil7rm07AZT5A/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="UT/D8aSt";
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442C606D806
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1442C606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UT/D8aSt
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc365db987so1379054137.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793898125; x=1794502925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=UT/D8aStYb7dPEp/Z1PTR1znD76pBm0Z1nPlORuFlgDbzwSX/aHEaMIKgxREgduhMs
         7b184i+9WuyWU3kP4ECdvxL5tqJCBp+sE58xftFr07RVMuYSe2D0AHX1L8wkHJuC4lcP
         6d7IEtulMVc64pTkfBc/dFTnsuyCXdHVpF//V/K2Xgp9mPmSNI4/p7tLi2H5V42yljeY
         GtO1ChQ2JjqDeaKC4B9biWxL+z3aUuPX/f+FWBrD4U/FW4Q80YjAWhMK/Up13oskn2O3
         3V6ObKXKjzYpPS1tL8mHYVexmV3sD/kfJUj7ToJWfvaytzTBimAL6fO0bssiuf+AQf9l
         4B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898125; x=1794502925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=YR2zfpGX+fMg342z4frVA2zAjnN7AOx+IYrwsKGkReFilck91WzlGJlS7ld0cRz/Kj
         L1U1MIJfCaJsbb6fYoimIB+Me6sr9A+utAkv+lQspuoKo5idxpNIT919qSyo6u6vX7lq
         iK5KyHPLMWOGdJHK2GYlUgk86T4iTnOqZ5Fgh9GWqOo+GWc0Ip85UUbJfRFvTCA0Lnfw
         dBqwQEyoshAFCzVW1rG6bfKtOD6XaAa5WwsIpSyumi+xkrrBkklCLJrotlkWmUEWZNX+
         7Dhf31Ykc9xPZrykPBjZ+GdlxjHgJqfr6X0JRG/Y6hQ3zSWArhXltWbBfG7ocYCaw9CC
         sN3w==
X-Forwarded-Encrypted: i=1; AKwUvBw1RNZNWjDvOFqWVJmgG1kWnbc1wvBUchaKNOQxSHFIrCXN40dqCDYrasER2RaOVojqoPYGnQY=@vger.kernel.org
X-Gm-Message-State: APuU4Z98O7ba6Enqa0j3OwMcNn1BirZzwABdNMTbzfYMo2VYMOMMj7XH
	2QwgTTBOMxCFqXKxYagnTIu8ZPIB74abGf0wWuKd0IWI58/ONP+gqNPWBT0pBN2+NfM=
X-Gm-Gg: AYBFou0BQpM+Jud55fc/o1tpp06H1Y0i1ObJqyzCssSPm7ArQTy3YQIqEVqhoIJCXkm
	RxC6KaEAhS2LIXX6meYsO0Y5FsHTXaQAkOntnt7y5nnswfcXxmTtsSR4Omv99VtaF5X/zYyydVZ
	cSTVQo4YQV8yI1KuTC1yOXR5C/HADEXcbvKCIimSP4jgVIdqJcHGHdJHyD67OQIyT2oGnqc3T5O
	EF++YmoWL33xx/GxRYKS3KcVww43QZdRRpYzRnyDfZSakf+IywCuZK+GLiuUCd7INoJH5EV3ZO+
	8/QLGGOyue/zUaLIrovX5IWDH0HVQErwwyESY0iy+LFD1HFyYDKvHPsEhGVraHKfGGajn4F53Zq
	o+iegwW7d2M8rOH8F11LLN1ho/S8ri2FiCUwZhTQaF+jcHJIaBSdNnGkAzkh4SOIoYbEuhqtGh6
	Wv+dmgi2g642uvXcU2s1PhMjlx8AofArMiY1gqaZsYSGxMCeXo6xpDFaRzWetzznBY5KKaUlpQn
	2aloA3rLc4Sfh3SE8n/wtQmU+HszA9dYRQc9/V6oTiZxZlTwRAUMsRYJfZni1xPLjf9j97bMLnP
	4q2ZnhEWa5E+nBOLUXnxK6RR/ozYpt0Z4rq1GwcmsW+zMBPfa2peP0hOJeN45D67ei+HVYQQNq/
	/s/+UJ3DW5oCW8slWGAPSQwyxf1GBJ48=
X-Received: by 2002:a05:6102:2c1b:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7d2a16c7f35mr120203137.33.1793898124846;
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm4619225137.3.2026.11.05.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0qh-0000000388I-28Zd;
	Thu, 05 Nov 2026 13:02:03 -0400
Date: Thu, 5 Nov 2026 13:02:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105170203.GC663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:23PM +0200, Leon Romanovsky wrote:
> +		(RW) The requested trust policy for the device. The initial
> +		value may be selected by the bus before the device is
> +		registered; otherwise it is "default". The policy is resolved
> +		to an active trust level before the device is probed.
> +
> +		The values are "default", "disabled", "adversary", and
> +		"full". "default" lets the bus select the active trust level.
> +		"disabled" prevents a functional driver from binding.

For making this more general:

"disabled" prevents a driver from binding and informs the kernel to
provide containment of the device. For example a PCIe device should be
unable to DMA to memory.

> +		"adversary" requests operation with the restrictions that the
> +		bus and DMA layers can enforce for a potentially malicious
> +		device; it does not isolate DMA by itself. "full" requests
> +		normal operation.


"adversary" informs the kernel that the userspace wants to opt into
any security defenses the kernel may have to restrict and further
validate interactions with the device. This may have a performance or
functional cost compared to "full". As an example the DMA API and
IOMMU layers will avoid exposing unrelated nearby memory to the device
during DMA.

> +		Successful resolution to an allowed level commits policy
> +		and operating level before driver or DMA setup. Both remain

"before driver startup"

> +		fixed for the device object's lifetime, including through
> +		failed or deferred probes, unbind, reset, and driver reload.
> +		Later binds must resolve to the same level, including when
> +		the policy is "default". A resolver error or disabled result
> +		before commitment leaves the policy's writability unchanged.

Not sure what "resolver error" is.

Jason
