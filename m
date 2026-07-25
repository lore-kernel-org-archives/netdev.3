Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E72E2DD2;
	Sat, 25 Jul 2026 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941997; cv=none; b=cHXYhRhBArPRyvQzJqhQNEhmTuW9y0keDcgFvoc0Jh8K2nXwQHmKdjcjPVhLsYzjSI8yHIUkUIf6rVUAkXgmGKbdkZNryN50AYBbggEESXz7zufY2RwEnuIFOYmxsBPvQQMjp8B4UsFNDOUvhsmSMDN+mAhDcfTsPHyf6CmNw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941997; c=relaxed/simple;
	bh=wMTv7ouTbh8kd01Bag4xgT8hg28FiN8AqmtebnHgpNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLi7kxXKN8Avw6bayaKs2akdEpCySvAcWfQH6NFhIeblTjrHG7O0F0ncsQ8wTp/hAW2RMCqVkTV1g/5ypmcgXSkeIe/wNeA61LuNgQdxrsHxF/EvX7ECojham9eEUPqzVS5Y0Il9Sd+YLrAlEppRvu/ykyX9Ktik+qqoxNGGb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA2UhvST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA2UhvST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2AA1F000E9;
	Sat, 25 Jul 2026 01:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784941996;
	bh=XzgySLzyI7kn1ZvUP96iUq3OPAcH6C94rAtubMSU488=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jA2UhvSTjA7f/EZ9Ybxev5I6gGDmT4xOd0GH5OK5qFpAMvE/dS3JPfrsvbLE2bF2o
	 /n/Hutdz18852HzCOhsfXH2Bx8EJofg98KGSl6xahzQyX+aC3c5AVXymo38yxuSuu8
	 jGmiknIyDbO8tdE9+hKxj67CaUYPBChabIptZkX/N+v1wyrgJlNkX2N0DV40LbQ4PL
	 pKtYL/npXpRkZF1mi6W3ka/lSQP8nU5xFwqsEqmib0q+ThrYvw7jmqDKkcjJ8bg4VD
	 RxuPFwfbaX8cSjD6jMxiUkToskLY/sZmM29+3RuSCUKDYlTFOJUdNfGifhEFn/Xm/N
	 bUc0tHW7GzezQ==
Date: Sat, 25 Jul 2026 01:13:14 +0000
From: Yixun Lan <dlan@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/2] riscv: dts: spacemit: Fix phy id check for the phy
Message-ID: <20260725011314-GKB77474@kernel.org>
References: <20260725005804.373698-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725005804.373698-1-inochiama@gmail.com>

Hi Inochi,

On 08:58 Sat 25 Jul     , Inochi Amaoto wrote:
> As reported, the phy framework can not detected the phy id correctly
> when reiniting this. So add the phy id compatible string to the
> etherenet phy, so the phy can be reinit successfully.
> 
> Note: separate this patchset as two patch for backport if necessary.
> 
> Inochi Amaoto (2):
>   riscv: dts: spacemit: Fix phy id check for the phy on pico-itx board
>   riscv: dts: spacemit: Fix phy id check for the phy on com260 board
> 
for the series, with R-B

Reviewed-by: Yixun Lan <dlan@kernel.org>

>  arch/riscv/boot/dts/spacemit/k3-com260.dtsi  | 3 ++-
>  arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> --
> 2.55.0
> 

-- 
Yixun Lan (dlan)
