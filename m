Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5D3932D0;
	Thu, 30 Jul 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785431306; cv=none; b=KDyfB8vyU5uSaL3UFg2zTR+UwXQ4l/m46PQC0dmNuMbt2aWz5uZRw/zH6rvaVWT8JxRUCgxscSC8nOgJNn031nQkVkhGYkvJZo5zn+4CtbILIWQ1tdkbeVzQ8FEgetNW2IbTi7Kzx00W9u1t6EZ9x0P2js4F+wIHitqmWHPKT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785431306; c=relaxed/simple;
	bh=V+v0vb2OeKhJ8ETDfMfl8+8Kx6hO1K7XXMc210Y9mQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgWq3WkHulvZ/oDpoYAZHI6QzJjjF6O6nE5A6ZcvKMWHw6ROMb+kr/UoXETJ2kw2+86jBKWrsbSxtXNvwmOrP3RPh67633JdpHrtEggstvZOjjRcazNOBUvoJYzgiCZ46MtW9oftb4nUGcNP3D1wfDwB+lBNpD7En22yYSTM5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=HSz+01H8; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="HSz+01H8"
Received: from L30177.local (unknown [81.201.198.134])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2A9B2B00573;
	Thu, 30 Jul 2026 19:08:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785431302;
	bh=V+v0vb2OeKhJ8ETDfMfl8+8Kx6hO1K7XXMc210Y9mQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSz+01H83B51NJulWh14K9R2AoJIOTrVeqbbyUQ4pbtB/sO+6D+E/V05xo+bx2Bfd
	 C3jzRyuxBv4ruGVvrQ8X3+TQIqFOJD0xXjtJekAbydxjeRmWch99aJyJkqAvIbdT4T
	 oJspAnerJ+2Eq/cLVmMklLZLeoUCtEBc40d8u7qZIuXVLETGzdTCzhN5se1OABp69s
	 xruMrhmxuSyf+m1AJJ0uyNrNQKVHtovFzCfVP6WyIeNfN95Qo08DrtX4uVmWEhOfy7
	 gm4DZmrcJIu0i6bgyGwgN95aSNqTkNA5qUH0wRPq2tQKsh0+lzVBKKQ4vGSUfFlNl3
	 6IF9prz0cmoDQ==
Date: Thu, 30 Jul 2026 19:08:07 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dpll: zl3073x: add ZL30643 chip support
Message-ID: <amuE9yIaBsFSgRhL@L30177.local>
References: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
 <20260724-for-upstream-zl30643-v1-2-ea93ba4d85c8@free.fr>
 <4CCA3CCC-C687-4658-8ACD-BC0CB3294A39@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CCA3CCC-C687-4658-8ACD-BC0CB3294A39@redhat.com>

Hi Ivan,

> Hi Vincent,
> I'm not sure that all driver's functionality is supported by ZL3064x. Did you test everything?
> 
> I need to check datasheets for this chip models, maybe some device flags will be needed.

I checked both datasheets. They are the same registers:

  - the register descriptions are verbatim identical

  - same chip-ID encoding (base / A +0x1000 / B +0x2000 / 7x7 +0x8000)

So ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32) is correct
and no new device flag is needed: the ref-phase mechanism the flag
governs is identical between the families.

The only differences seem to be non-register related: line card vs
central system and the min input-frequency spec (1 kHz vs 0.5 Hz).

I tested with:

  devlink dev param set spi/spi0.0 name clock_id value 3733 cmode driverinit
  devlink dev reload spi/spi0.0

  devlink dev param set spi/spi2.1 name clock_id value 3643 cmode driverinit
  devlink dev reload spi/spi2.1

  dpll device show | grep clock-id
    clock-id: 3733
    clock-id: 3733
    clock-id: 3733
    clock-id: 3643
    clock-id: 3643
    clock-id: 3643

Best regards,
  Vincent
