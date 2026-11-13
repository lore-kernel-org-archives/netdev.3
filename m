Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566678;
	b=ygmzrnLRgR2LEDsZKA2XsgbbG6oxgb/TBb/Sdr2Htu4qlZwtOhe0OHAxHLDyGS/rxEKZ
	 fE1Tt078PNbGHVD3rSTvYr8tTVZfMAG++NFbsMi+BK5DIQUbN30j44kinwZkVq/Kl9WDo
	 IFpmnv2LAXuhafVAh2i+IRHedACxm8k5PFU35Ho44iiQJ77JynDiECxzmjpJgSHbStKYB
	 VYHdBlPzfWsMVDkfCEUUx6ZNyxgNc3SaUxoJAVe2s54QfgjJcHBJgIi8AjTa2sS+zz1IS
	 kb2jpLVuri2RF6/+IaU9xTnO5779jMgLcTBfCh8mfKOlj9sRDJmEWZBd/ssfeJVXiNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566678;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8CsYdP/wCb7Wii3UCb9oFVMApL91yA2r+Rt4I6PWk/g=;
	b=LTHP5uN3/+2qFNR+eDALmSiksKKb63mYRVvm60HEoE7z/jxWRooSReYM0+/43AXZGBpp
	 I2PrQXMzKh/HzzIDSqOaywKRrolKlav6RR/7YrgRDwTEGUfr3r/B6id2SlW+B3Nu/f4AX
	 41xFlhAQMNdNQWQhZyOlR+a9i/iKBTgOuPHmQSovjqfegoNIy8Lh3ZDwopMrgRACiujJh
	 5xOGjpzvHk2Malz5KCKIp2hsaiypY15zaKV4F2KAXkgVXpQ/XRt3Ip0W+K/J2Jp3txx5A
	 THvTTgogz6h4DaycSOJDCGqoL4UwX0dtP9i2Kg6B0rbqcC68MEd5QrU8T6CP4h9slXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0vXN2Gm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B831606A321;
	Fri, 13 Nov 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0vXN2Gm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618461F000C4;
	Fri, 13 Nov 2026 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566678;
	bh=8CsYdP/wCb7Wii3UCb9oFVMApL91yA2r+Rt4I6PWk/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S0vXN2GmOOnd+clJilXGVM+5mFYpOeJF1uZYZ/mBnM3QkhP070C3ME28j77VYg1nu
	 XDlgVz+Mk/Owu4XyARo0LRGDrSi9oD/bl1Qv1/VAR4SAuXQSvciXQuUW3dXKqgoKjM
	 JCuq7f1tWIKZ5Sgbchs3NY2vqKdl/8Mg5nIYXZh5NZQB/iqdbuNPoD6FvUpgq82cvn
	 r0eG9X+lhimPYLswzfN+jk70OpWcflbAXc322kiyp33cfA2s2z4GuB7IdGFnST9sJ8
	 Z5nenz04/dPQ2KUrN/J/MhPhV3yfkPi9w3zoYTutZnPfmhe2f5dlbzR8DN5ctCshgt
	 JF/PvfuMvClzQ==
Date: Fri, 13 Nov 2026 11:44:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: James Clark <jjc@jclark.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Martin Kaistra <martin.kaistra@linutronix.de>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Rahul Sharma <r-sharma3@ti.com>, 
	Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Chintan Vankar <c-vankar@ti.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: mfd: syscon: add ti,am654-gtc
Message-ID: <20261113-ruby-jaybird-from-camelot-1d8272@quoll>
References: <cover.1794284248.git.jjc@jclark.com>
 <42bbc4a03679958f2ed4e195acea99fb57c68fd6.1794284248.git.jjc@jclark.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42bbc4a03679958f2ed4e195acea99fb57c68fd6.1794284248.git.jjc@jclark.com>

On Tue, Nov 10, 2026 at 11:24:01AM +0700, James Clark wrote:
> Add a compatible for the CFG0 register frame of the Global Timebase
> Counter (GTC) on TI K3 SoCs. The GTC is the system counter that the Arm
> cores read as the architected counter. CFG0 holds GTC_CFG0_PUSHEVT,
> which selects the counter bit that the GTC exports as its push event
> output; the CPTS driver writes to that register to provide hardware
> cross-timestamps.
> 
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

