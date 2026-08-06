Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307233815FB;
	Thu,  6 Aug 2026 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980765; cv=none; b=OE+bLIm2o+JYubaiyxiTkb243XF7LIB1Rdc1K0/faJE5AbOje6vFqO8TNoJV2Jpdc1D9lTWFz4hd8ZQ1Wu1EF3CquITFsOvmy6MlkHf43h85jvgVxlSfPUMAje4HmYm9z7DQgD+ueva5B8Al9MgRdxBQ/hEyuGpjVrv8Y981hbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980765; c=relaxed/simple;
	bh=1SaprbfaI4ZOs7k5gBJxJxelfHS7qx2Zp+q7ENgkH2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEV8PltOajZ0uOS+044qD7k5RCt9UGe6WjRMxAvguU2+Im6ygrhCd3EWw6bMn9BtM8QvCWZ0BY9HEJt4VXCFQDlm0Uo4Wn8Mk7Yjj3E6DqsEq1iXL1ppeZh46j3kyXgtEGdwkFzaEdxDLiNPpEWD7vIKZUcQrKOpDIZ8Vq8s/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at9woPAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at9woPAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7071F000E9;
	Thu,  6 Aug 2026 01:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785980763;
	bh=ld/q5+St1r+SzHJST9cey9ZHJTyBGe6NpmrBrqsZhH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=at9woPAyhYsrowaIj7GRAvTCxBZxXi093zAQuV0AHDWl7/WBoNFL+j84lEW6d782j
	 Pj9WwwHvOLf4U7nGpAIyKDZlrsT4id3QS2ggJeKOuOKCY3oNRFibwlaKCmsT/VRduF
	 sLrnY1RT4ZrVE9SEuSEMdc2ooXkqAFAEgQLHCTCLgI1btJkrMEdQOurzhP/DFRlhI2
	 KSg2xtwPSOCvQtamXfxHetpNXkzel5xS640Wn7J2DB5I0sZbn4ugW1+F6zbG+FGF0c
	 hNss6dhNIOlkNm0Kab6mNpdp4NTq+AfmtuRtdEp9Jdog4gFQP+eV3UUweZ2IbOzBSy
	 XknZnATjfom1w==
Date: Wed, 5 Aug 2026 18:46:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis
 <afd@ti.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: dp83867: support setting output-impedance
Message-ID: <20260805184602.31c274db@kernel.org>
In-Reply-To: <20260804-v7-2-topic-dp83867-v1-2-1ca79eb54eef@pengutronix.de>
References: <20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de>
	<20260804-v7-2-topic-dp83867-v1-2-1ca79eb54eef@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Aug 2026 14:46:34 +0200 Steffen Trumtrar wrote:
> Currently the dp83867 supports setting the io impedance to minimum,
> maximum, default or a value from a nvmem cell. In situations where there
> is no backend for a nvmem cell, the value can not be set to anything but
> minimum, maximum or default.
> 
> Add support for the ti,output-impedance binding, allowing to specify the
> impedance via the devicetree. The existing boolean bindings for minimum
> and maximum take precedence over this new binding. The nvmem consumer
> still takes lowest precedence.

Compiler says no:

drivers/net/phy/dp83867.c:549:67: error: incompatible pointer types passing 'u8 *' (aka 'unsigned char *') to parameter of type 'u32 *' (aka 'unsigned int *') [-Wincompatible-pointer-types]
  549 |                 } else if (of_property_read_u32(of_node, "ti,output-impedance", &val)) {
      |                                                                                 ^~~~
../include/linux/of.h:1491:17: note: passing argument to parameter 'out_value' here
 1491 |                                        u32 *out_value)
      |                                             ^
1 error generated.
make[6]: *** [../scripts/Makefile.build:289: drivers/net/phy/dp83867.o] Error 1
-- 
pw-bot: cr
