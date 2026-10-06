Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407813CF82;
	Tue,  6 Oct 2026 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256940; cv=none; b=lnvba8YbNO3oMIZASlOnwazNnHK/2patBEMlbUCUbKWFV8bpF/+pv1Atu4k1OkYoA2mglDlTIkQsVZmkcjlHaCaSYSQso29tC+NPSKwNhHosq0JJAmaAFweGiDEIMd0heLV04P3WSZnOuMRYJt7Oq8eOLPCgpauIZSkr+EVGFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256940; c=relaxed/simple;
	bh=9z9Q2WIHRVQJcmY7xaqRUkJ6uUdRIx7BLGtIJbcXAr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVx9zF5Yah4jizOhaC0jCQK1RVFOVJBIhuzmot3sUBGS8brOPhsAj1uoBbeHkd6HOQOYsLb8s0UTT6anp5AX5iuvu1cCjhI3l/uRZ9S0qyyetyTIpIvHETg1KgyTHtPYStCkK4LC8jtayllVXrZsNbRI78dlHhvQ/6QYt2pzjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVH7/9vN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVH7/9vN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166911F000FF;
	Tue,  6 Oct 2026 03:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791256939;
	bh=M9qoeZYVegP5OrmrSf69nHM5NDLtruzmRg49INYvuXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kVH7/9vNyo/QDVPF0pNH4ho8pg2uTLr0oKJeWAcgM4h9+Tl4i6UT5FgbD19+esS8X
	 qyFMSJVeMbvG4aGmTYOH0V3zxyP13nqbdKoNr/O3w7vo3zcBYUCtuHOqPAeMqC0ryA
	 q1pY6t2iq9X5EKohe17hJ7X98ozxwCSurBb2dtKL8aSoaKDcBvCPcfgHdpenrCPnlq
	 E3/ilF34pPM50v/ZFu0646fvJr0Tr8L8ZeWuU5px1AU3I6wJ0oma2iiUPBuGt1aiFH
	 1VTHCJhhi2FSOgqzbmOfcioK/L2FwSS9VLH8eCtKsooUOBY2wc69tTqPyKG/cFik66
	 /8Se4BaNYVP0w==
Date: Mon, 5 Oct 2026 22:22:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: arkadiusz.kubalewski@intel.com, linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev, ivecera@redhat.com, conor+dt@kernel.org,
	cjubran@nvidia.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, jiri@resnulli.us, krzk+dt@kernel.org,
	Oleg.Zadorozhnyi@devoxsoftware.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v11 03/13] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Message-ID: <179125693789.3539370.5452496490999138147.robh@kernel.org>
References: <20260930233714.87679-1-arouhi@sitime.com>
 <20260930233714.87679-4-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930233714.87679-4-arouhi@sitime.com>


On Wed, 30 Sep 2026 23:37:17 +0000, Ali Rouhi wrote:
> Add a binding for the SiTime SiT9531x family of clock generators: an
> I2C-controlled device with four independent PLLs, up to eight input
> clocks and up to twelve outputs, described as a DPLL provider.
> 
> The XO is given either as a clock or, for firmware that describes the
> oscillator as a property rather than as a clock provider, such as ACPI,
> as clock-frequency.
> 
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>  .../bindings/dpll/sitime,sit95316.yaml        | 175 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

