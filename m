Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB561409121
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644604; cv=none; b=WDUJvYZ8yiywfD5Dy+tU7QA8kKYIUwms1Vtgr+NPvvYPVIi+EAQ0rgsnFwHtgF9LBvHG4IrxDzLyiC9gx/58BUTL2hYcLge6pSWL3oBYSSah8AssAp9YH1Zup9z8xOPvdFuhEyVfu7YT+zJfMnvgf+QUj9/GcUd5t/GXjv11HM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644604; c=relaxed/simple;
	bh=ZcfPBsI8IBMNJnG/sqGin98jCO/aJb7mbPWM552l6qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mFsDeISZaUFevfzbDmfexoXFC0KBptk70Fj2QyGagQNbnP8nK29tQncRnSs+O7IiyBY5c1INRgaIatjYi6K+FQMSqgqWQk3TRFUjHg6UAAqCwjg85nnGYM6S1x7FpoLAv81i64YDbcVYaVrtBL4mqS+I6D+AP9NpCHblF6xGbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQJkGAO8; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQJkGAO8"
Message-ID: <a8c2d739-b3d2-48e0-8d96-e07307dea59a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784644585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyoTeLlBH3Olo1iRv1nlEFIv/HUSi7OqYr6amr496lE=;
	b=PQJkGAO8E29bP9vySKZrwKia6J/UQUCNN07xT3QaI2gZ3DRqUWSKqLKxhd4M8tyxxYmrSZ
	58jlpkSD+vqI4UsPa2GzlXjJ7/OPSkG0RD0jFoB+jvkYCiRukbqUoMjtOYQgzCyo3UKhHe
	cKQRV+S20XhdW8dAPGO9ZQksFhI1hkY=
Date: Tue, 21 Jul 2026 15:36:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 2/3] ptp: Add driver for R-Car Gen4
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "DavidS. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
 <20260721132936.1331318-3-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260721132936.1331318-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 21/07/2026 14:29, Niklas Söderlund wrote:
> Add driver for the gPTP timer found on R-Car Gen4 devices. The timer is
> system-wide and shared by different Ethernet devices on each Gen4
> platform. The operation of the timer is however not completely in
> depended of the systems Ethernet devices.
> 
>    - On R-Car S4 is gated by the RSWITCH Ethernet module clock.
> 
>    - On R-Car V4H is gated by the RTSN Ethernet module clock.
> 
>    - On R-Car V4M is gated by its own module clock, the system have
>      neither RTSN or RSWITCH device. But the module clock is the same as
>      RTSN on V4H and the documentation referees to it as tsn (EtherTSN).
> 
> The gPTP device do have its own register space on all three platforms.
> But on S4 and V4H it will share its clock and reset property with
> RSWITCH or RTSN, respectively.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
> * Changes since v4
> - Drop mod_devicetable.h include.
> - Remove clap of register value as .max_adj prevents any overflow.

Hi Niklas!

Sorry for being silent for a while, was traveling a bit. Your
explanation about addend in v3 is good enough and proofs that
there will be no overflow for the values provided.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
