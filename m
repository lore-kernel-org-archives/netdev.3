Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8313E9F82;
	Tue, 20 Jan 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906654; cv=pass; b=hc0WYYOGV8GW2yUFYpvoEUe9Pe5soBIKruSrJU9gYPEeSiwekdwUdHZBTjibzmWLGgYJ74brp6DKBbQoplAKDsViRvMekDZEts4Ysl3hX5W3SLtPqjKD2U4W936/fFsyDftDpvOgwKHWVoaKC3lmekwHdHYI8qbqyQMqooIwQDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906654; c=relaxed/simple;
	bh=hLhhaaiGUK4UAPYUo2Wht+3suThBEz9Cj77yr1RmrCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpudcmA2hZGJs/+tFpmU8VmPmdI25O1yejkUsr5fdCs6zT8A0eYyzeDAgc1/lUR4ZK21hJXurv77F4Tko7zOjYqqrfznPeoQvtk/8kLpuwskQ6hMwtk7OYxOGn0zigh7R43XAdiRgHm8NzPyYSE2X3FXT3y0L0rZcbfHyJFhQxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=UfbY76hC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="UfbY76hC"
ARC-Seal: i=1; a=rsa-sha256; t=1768906567; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ak6+zhg/djoSET/jxpadpQyRcrriZ+Hb4IrbOf1xk69NlUklGQMlAFWHFwmYe3Yesq3b5hQ22GYGsF+HGH1Bt05MaD92p74uwnxUUFvPhFQ84McpHwHIm1iz+EQW9QgEc5Xc5zFv6FwCsoa2iYSN8/h5UXVatAvvTisNw1EldZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768906567; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ONSVQRKcPO7Hdq9rjeCJBLbi+rJef9ClGejj6CnM0wY=; 
	b=NOJakvj5baRnkmXoB7LumnUit/KQxGV92PkXR478iuA98Tdt3Of/28od+qlx0Eepp+TIkIeLBAt5wPapNsAjtx9Doj78v/gkaJqNN5QnZPeD1wRDB6IAZiGhCl9gjGgBF3uF+8QEDy5fAE724YLlr0+UDLbM8smzAJ233CuTkzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768906567;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ONSVQRKcPO7Hdq9rjeCJBLbi+rJef9ClGejj6CnM0wY=;
	b=UfbY76hCP8zX5WETuGgn6VZM3NN+FjaN8LWv69wwAVNk0zvq8H3HC8pdZHJp2V4c
	sfOY8cbsd+bhCiZhPaWpES7/nq72N3qz3r2DaTdaXMj1PJmH1Q7eUkPXygOtrxsg6XT
	wISiqo24iESoNSprYd3gvxcv3ZhFDNNxXiO9pccg=
Received: by mx.zohomail.com with SMTPS id 1768906565127972.0399174349235;
	Tue, 20 Jan 2026 02:56:05 -0800 (PST)
Date: Tue, 20 Jan 2026 10:55:43 +0000
From: Yao Zi <me@ziyao.cc>
To: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: Add support for Spacemit
 K3 dwmac
Message-ID: <aW9fL7r0AM0flALJ@pie>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120043609.910302-2-inochiama@gmail.com>
X-ZohoMailClient: External

On Tue, Jan 20, 2026 at 12:36:06PM +0800, Inochi Amaoto wrote:
> The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare
> MAC (version 5.40a) with some extra clock.
> 
> Add necessary compatible string for this device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
>  .../bindings/net/spacemit,k3-dwmac.yaml       | 107 ++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml

...

> diff --git a/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
> new file mode 100644
> index 000000000000..58dd98f79e8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml

...

> +  clocks:
> +    minItems: 3
> +    items:
> +      - description: GMAC main clock
> +      - description: PTP clock
> +      - description: TX clock
> +      - description: PHY clock

Why does the MAC require "phy" clock? Shouldn't this be handled in PHY
driver instead, or I get its meaning wrong?

Also, I don't see "phy" clock is acquired anywhere in the driver. Is it
really necessary for the MAC?

Best regards,
Yao Zi
