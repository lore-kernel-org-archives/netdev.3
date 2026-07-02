Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79830B53F;
	Thu,  2 Jul 2026 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010245; cv=none; b=t+9var2BPaSSn6Whxoqy7EzxCXMBvjaqFuuhgIW81QSr/MEPE4WgRCX5kSZBG7HvM5VYEhjbDpF5E3ulJFRNSnsuUUrvvLOCUQi5HE1ra71MWsA4/LKWdnqtnRt81mBR6y6ve8hh4Lhh6EZEM5aInznr29E92Gj8xRl+JJjjAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010245; c=relaxed/simple;
	bh=OVh5hq9AqE98I+fD5XeI33KlTHSAGbbN7vCuIRJjZ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRbfN1RPmEGvZYqsvFeZUH/Bt/6zCWF684g//zcN/0oIOOeBX6yKX0gsIFKbtNMlNWF+6Hk9cgroZb3ZHq6lFDax/hiFoRM2WkiZm8aWHoucTdP/ZmFa6EtY10dOfdMKCl+SAyoN9xSqWwKUwzhzsIyiL+skQr1Ecgzz4qU9gpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZST56m1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZST56m1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DE21F00A3A;
	Thu,  2 Jul 2026 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010244;
	bh=JYz2t9rOB6Xr/OOk1r6hBAPIGizcFH6efsw9sdj+Wuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WZST56m12/dPfMnjxUmbQmp1RfAlmgKoAVEw4PIMZ4PlBncoDVOpPHLhXYP7UxCWh
	 w2WX+KHS3/yrMGg5LCd2XYhuAdJMjDQxwlHGKGw9jqZsaKzD+/KFXkvXy7F7G5Qsg3
	 knE0Vqs2EZSNPAXhvJCivRI9fSLzOrLQ269grsez37WOv08gbDiYAht7bRYkYFPRE6
	 ISdshM4ZM+9IRGOao127qU4ICBLcYBvu8TPw2ecv6dw6wdipSuAmq03smCaRYbYvJO
	 pDlvHdbEJApBzIrzmr/WVzeLXYTFZPdGSv7hCjscCBFhpbkozKXxQQAaUzW7F3vlOu
	 CltxHKPd6Du9A==
Date: Thu, 2 Jul 2026 11:37:23 -0500
From: Rob Herring <robh@kernel.org>
To: Manikandan.M@microchip.com
Cc: krzk@kernel.org, pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, srini@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk, richardcochran@gmail.com, linusw@kernel.org,
	arnd@arndb.de, michael@walle.cc, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Message-ID: <20260702163723.GA227454-robh@kernel.org>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com>
 <20260702-utopian-termite-of-perfection-f1f3ec@quoll>
 <860213fd-6a4b-42d4-a8f7-7308e070f09e@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860213fd-6a4b-42d4-a8f7-7308e070f09e@microchip.com>

On Thu, Jul 02, 2026 at 06:55:15AM +0000, Manikandan.M@microchip.com wrote:
> Hi Krzysztof,
> 
> On 7/2/26 11:46 AM, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Tue, Jun 30, 2026 at 02:54:00PM +0530, Manikandan Muralidharan wrote:
> >> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
> >> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its
> > 
> > What is SFDP?
> > 
> SFDP is the Serial Flash Discoverable Parameters -- a JEDEC-standardised
> (JESD216) read-only parameter table present in most SPI NOR flashes, the 
> table contents provide basic information about the flash. There are 
> standard tables which are specified by the JEDEC standard and there are 
> vendor tables.

Is SFDP present or not discoverable? Or we have a table of discoverable 
parameters that itself is not discoverable.

If it is discoverable, why does this need to be in DT?

Rob
