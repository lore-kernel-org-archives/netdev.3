Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A663D348B;
	Wed, 29 Apr 2026 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458428; cv=none; b=Vs9+ETFS0OqER/InKXEpTkPxls+95U2FL3BInJiH4vPml0Syj1TO1NdBWS/RZk4BtkReLjizsJ4zgIq0cGHS0+/phh928cpO/oQWkkL1XSverwGlx1iJ5M6cPCAuIkkUZyBLoVRWabpSqKtEVuU7kFKJoTWXxe8Pcs/eIj0QxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458428; c=relaxed/simple;
	bh=DlpxBcfc3bnKCpxJ5lHCdxUsFOlwBNR9X5HKYoOV/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHdneErKNKEdXdt0ceDuYs73eGFXP+8wh823ai5K2f155tvAbBqIEgQDKxQdjIpTF/ZpfPmjDsUJsQdgahrhVDv7B+M+kMLzK3PMLZShsKQthb2N4u2En7ZuUAP1lV9MVepZO2MIo56lCiL6yY2Z1p/ppAAsd18XALd1HctvPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFkH8doX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFkH8doX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C303C19425;
	Wed, 29 Apr 2026 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777458428;
	bh=DlpxBcfc3bnKCpxJ5lHCdxUsFOlwBNR9X5HKYoOV/X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFkH8doXUAfGNsg3KhrRMqTgnBnC+h5WHzRkzRhTrO8aPl9dgNJ1/4kz7kHrHZXfM
	 dej4vM9QiKj29HXOYDn+dh61ybGAyV2T7DLplY+8ZsaVRDKhkWeSZ8KZYINzUMEf7g
	 cLroP+KtXhgPLvjjncb7lllWrn9M1hKsInOrDJ8tM2xaQZdsjPS7a4bobzwGFm+KdD
	 jn3ARACYKHpj3EGcWWpT1SbhAlM4ZqVpe4oj8EuXdTNgjeW1m8hIM3aSpHl6PD0iY6
	 SekUQ8uTOVqr0FlSg1kDZTY4+tfjp8cnPos/QO4rCQIZd5hJObFudUhP64T5xYiZJo
	 uaYiKYqbIbp1A==
Date: Wed, 29 Apr 2026 11:27:03 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] net: Unify user-visible "Qualcomm" name
Message-ID: <20260429102703.GX900403@horms.kernel.org>
References: <20260427070127.18471-2-krzysztof.kozlowski@oss.qualcomm.com>
 <20260428161444.GU900403@horms.kernel.org>
 <ac91a635-4aeb-4fa2-a00a-0e3425caaea4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac91a635-4aeb-4fa2-a00a-0e3425caaea4@oss.qualcomm.com>

On Tue, Apr 28, 2026 at 06:28:24PM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2026 18:14, Simon Horman wrote:
> > On Mon, Apr 27, 2026 at 09:01:27AM +0200, Krzysztof Kozlowski wrote:
> >> Various names for Qualcomm as a company are used in user-visible config
> >> options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
> >> "Qualcomm" so it will be easier for users to identify the options when
> >> for example running menuconfig.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > 
> > ...
> > 
> >> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> >> index 88df55d78d90..958dbc7347fa 100644
> >> --- a/drivers/net/wwan/Kconfig
> >> +++ b/drivers/net/wwan/Kconfig
> >> @@ -38,7 +38,7 @@ config WWAN_HWSIM
> >>  	  called wwan_hwsim.  If unsure, say N.
> >>  
> >>  config MHI_WWAN_CTRL
> >> -	tristate "MHI WWAN control driver for QCOM-based PCIe modems"
> >> +	tristate "MHI WWAN control driver for Qualcomm-based PCIe modems"
> >>  	depends on MHI_BUS
> >>  	help
> >>  	  MHI WWAN CTRL allows QCOM-based PCIe modems to expose different modem
> > 
> > Hi Krzysztof,
> > 
> > Sashiko points out that QCOM is still used on the line above.
> > 
> >> @@ -51,7 +51,7 @@ config MHI_WWAN_CTRL
> >>  	  called mhi_wwan_ctrl.
> >>  
> >>  config MHI_WWAN_MBIM
> >> -        tristate "MHI WWAN MBIM network driver for QCOM-based PCIe modems"
> >> +        tristate "MHI WWAN MBIM network driver for Qualcomm-based PCIe modems"
> >>          depends on MHI_BUS
> >>          help
> >>            MHI WWAN MBIM is a WWAN network driver for QCOM-based PCIe modems.
> > 
> > And here too.
> 
> Yes, I did not unify every single text because I believe that might be
> more churn and not that much benefit. I think it is more important to
> have a list of drivers in xconfig or menuconfig nicely organized and the
> help message matters less.
> 
> But if you wish, I can replace it there as well.

Thanks for clarifying.

I have no strong preference and am happy with this patch as-is.

Reviewed-by: Simon Horman <horms@kernel.org>

I see this was marked as changes requested.
Presumably due to my previous email.
Let's see if this helps.

pw-bot: under-review

