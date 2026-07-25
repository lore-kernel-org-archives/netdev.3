Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08737A83B;
	Sat, 25 Jul 2026 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784967262; cv=none; b=GHvduxTUz0GuRVLhTwhwPtzQNOp4LAWuC7BP1ne30GRxsSRsm8OubjmXuM9mmWSqmuJtyKH03eUYMU1l6ky5qTxIIb5KiOwgAJC1YkVVnuIkWGM4gLbVNgIv+rswqLl0TK6OgDDhk4Ao3caD3dYBxC85YIiYy9kVHE6DzR85U6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784967262; c=relaxed/simple;
	bh=UNioxEkaO8EJAWuBo1DYcEOj9l7/qEHDoucEsmStjFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N75Go4VmjY4GkYa0+2CJIdcNJzxipt6JNHoZoy/EG2ZIAFLtZX/BXVrHNwUgkN23CQzxvlbhqP+0pGLZ+gvYQJ+uliz7i0IsheBaexjTpAfZjnPguhMdhptv22QU28EJctYYUiGUj0dYYnKdJ5/bRsTw1AJ7nkcdTVB5CIqTHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=OnV+l0Wo; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="OnV+l0Wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1784967180;
	bh=Q1wNwR7tIvEW59tXnUAq4uObdZlbHctBQ2RgzD/ZM+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OnV+l0WoJv/sdyIlExO4Gq+PhEkYP7GycUj9fdFV+6B+X9lmoUo2HdVM465G4NDmp
	 jSPSjOP0LHhtUg0wjigtySnOYMnYwSnh/qZU68PbFEQGRZ9VquOnmzubejei6WVtSm
	 al5IOoSka+a8eFZYsL8HAyxWVHMTK6XJ4V9fRPQj76UHF0o97ia+HnXhnuSOj9GTNj
	 IJln88Xh4R5+xdRyCtrfiz/FL1h3w3MaQ6Ab+DtLUjAjJfC4eIW0e2ASMlTztvJP/z
	 Fmxt7yNYLbW6psc9gNctMhp7KpFzNelIWFneA4Akg/plsstQDkFrnNG6nrOAdqYiHL
	 tJNrTkBVQl1AA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 9F302B2200E0;
	Sat, 25 Jul 2026 10:12:55 +0200 (CEST)
Message-ID: <9545227f-77ef-480d-bb55-6caf1124627c@freeshell.de>
Date: Sat, 25 Jul 2026 01:12:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: dts: spacemit: Fix phy id check for the phy on
 pico-itx board
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20260725005804.373698-1-inochiama@gmail.com>
 <20260725005804.373698-2-inochiama@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260725005804.373698-2-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Inochi,

On 7/24/26 17:58, Inochi Amaoto wrote:
> Current phy framework can not reinit the phy correctly, as it will
> assert the phy reset GPIO so the phy id can not be readed. Setting
> the phy id of board pico-itx manually so the phy id dectection can
> be skipped.
> 
> Fixes: 74657a376960 ("riscv: dts: spacemit: Add ethernet device for K3")
> Reported-by: E Shattow <e@freeshell.de>
> Reported-by: Inochi Amaoto <inochiama@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260712045233.800748-1-inochiama@gmail.com
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> index b2a7d2d0d3a8..b9d2de878f38 100644
> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> @@ -196,7 +196,8 @@ &eth0 {
>  
>  	mdio {
>  		phy0: phy@1 {
> -			compatible = "ethernet-phy-ieee802.3-c22";
> +			compatible = "ethernet-phy-id001c.c916",
> +				     "ethernet-phy-ieee802.3-c22";
>  			reg = <1>;
>  			reset-gpios = <&gpio 0 15 GPIO_ACTIVE_LOW>;
>  			reset-assert-us = <10000>;

Looks good to me, aside from commit message spelling and grammar nits
("re-initialize", "read", "detection"). Yixun may just fix in-flight, my
R-by and T-by tags can stay.

Thanks! -E
