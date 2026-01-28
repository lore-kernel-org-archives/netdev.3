Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40235FF64
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608778; cv=none; b=ocv9I9m/x0xErt97PpzRdPHrwXTQF2ZesZ1eI8KyoeywerIF2hJCSnA32KKPyr9ZCaCiiNJ7I8paFcOS4NdmZXo4Z++Aq0a4NKRfOsFEFo1TZte8enQ9/2afyhL0JQECAy63LoNtlvqXyZRsYvWhqhUVYSixfzFcohCcwLMLt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608778; c=relaxed/simple;
	bh=EorS8hagQBRowaXPwbpjvOXzCd6m71JaXJ9r4LAAKq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGhsPjrlcWcSciOq3ByUIlcSE77d5XKaTVQKEpEV+299kTKxa7G0LN85qVxeRdnA8KSJN+8RnBagP/j5DwZkr088n7f43t7qtb6/xc9ib2DkIPcjy75iT1g6m7xCCoz48f8FI0wwOdVqBgw3FFfXNgmHLvCB+aDKYuzQxIBPDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1xcV3p3z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1xcV3p3z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yCLp/WYmzR/WwDszP0fVgxuC0bnGWlUYh/spJT+JQUQ=; b=1xcV3p3zVxwhwNNAwReGEUkFVm
	SVM5cRmjMNGcrpwx0XKJMW/qT/svDk2sEel1kltFnN/0nceTWuVJ6mVvJRDNPcCfPHanE4eKbYVwQ
	V0jp9AeykDuOR88nv5ih3cR065sgyLJjkbsPlgSIB7zffhnzZA08PaiAplZUNO4cxVT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vl650-005BxE-8N; Wed, 28 Jan 2026 14:59:34 +0100
Date: Wed, 28 Jan 2026 14:59:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heinrich Toews <ht@twx-software.de>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add
 microchip,single-led-mode flag
Message-ID: <6871816c-2732-4c5f-9f10-1f9773d5f23d@lunn.ch>
References: <20260128133842.1173406-1-ht@twx-software.de>
 <20260128133842.1173406-2-ht@twx-software.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128133842.1173406-2-ht@twx-software.de>

On Wed, Jan 28, 2026 at 02:38:31PM +0100, Heinrich Toews wrote:
> Enable single LED mode globally for all non-CPU ports to indicate
> link and activity via a single LED per port.

Are there other blinking modes? If the LED is capable of more, you
should be using /sys/class/leds and the netdev trigger. If the only
thing it can indicate is link and activity, this approach is O.K.

> +  microchip,single-led-mode:
> +    type: boolean
> +    description:
> +      Enable single LED mode for all non-CPU ports. In this mode, a single LED
> +      indicates both link and activity.

Is there a dual LED mode? Triple LED mode? What happens if this
property is not found?

	Andrew
