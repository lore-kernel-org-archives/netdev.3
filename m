Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD91B2E7623;
	Thu,  2 Jul 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976617; cv=none; b=IkyTDnO99wiPg8c26y6Eof1xOMRIDL7PU+9AFQD171aVG/0aoxkM92Qi1086rzH/k51WFuM8wiu36hz1U5o+M7xXXJdMMUB0VwBf/gQlkqYFL5HoPuUnkKfty3OvWuVKAIMZWWA/0/jA0xVsR7i6c7CC+U0R3Bp41PZwEifWalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976617; c=relaxed/simple;
	bh=mz6kpSwenSyDyq+jc+Xzo5rVqpd4PDETu21WHvNuIC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VulWvDH7+vIkbokkHRPGFtnMJD1jxf9nVb7TyJPf4iAgvPitIaKso4B/TeeVA4N5AQ0gfGMzteOXO71uyFucn/+X00m1OGUed+BYwz47I4/rTSZbOHZ7Os3AuTM6EUFk5eMrXxgZHUasoxWr3XIkN86P6Y68gWgBWPlf0mB4Aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1iXbTVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1iXbTVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E63D1F00A3A;
	Thu,  2 Jul 2026 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782976615;
	bh=CbaFYIOViQSibxzacLKgp7bobWt4ngmZUAMzi2iTiII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l1iXbTVxKYxCmtxTRZOhU7/Zwb2yERfnH2mvsymV6Rh+ik1cTkXCzb4+Q07v+drdO
	 KqVQujeps3BQ3hsZsxMjtCFczTbWpWX3pRXKjsD3Z0gexanyqK4mOJ3Ax8zFYrOLlg
	 lyMzleTOntdl2yslq3C5EwRHhBpxCW8XJtbE0dqr8OzGImHIoM6L8lqFrJDD02Z4fe
	 j4XsC1xm99jp5Km8LvV+3OjhU+5GlHvqLo+vogn3d/0+aJnm23voaP/sP5UmfjO+i9
	 NwB3Ym++dviUeVGVEhbHdwqwFIndt+YpuV/xFoJIsCQ/jvsQrECxW5npHsLZRxNEK5
	 2nVocPJtN+hJA==
Date: Thu, 2 Jul 2026 09:16:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: altera: Add Agilex5 SoCDK TSN
 Config2 board board
Message-ID: <20260702-prophetic-kickass-crayfish-1fa2d6@quoll>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630133108.27244-2-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Tue, Jun 30, 2026 at 06:31:06AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Add compatible string for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
> board variant, which uses a dual-port TSN configuration where gmac1
> operates with different MAC-side (GMII) and PHY-side (RGMII) interface
> modes.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  Documentation/devicetree/bindings/arm/altera.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

