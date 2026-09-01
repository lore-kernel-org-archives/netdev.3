Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52042931CD;
	Tue,  1 Sep 2026 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256710; cv=none; b=AXbccTa/PSfLPmRntObA8u2bheAx5/v1G/rPnfUZH+657PU5eqYhwXtz2N8MFmgIc6zogu0IXV8vSeaqdoRmRIyEzYbTneCwv8koEVmfGGX2/Qw9/9/tlwfREHuh6glvRGOOyKvRgUWBx1Rxry0LV9CSg5NH9apxYxPWHyVENLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256710; c=relaxed/simple;
	bh=ZzkvxlCG1ixPz8vK6bTV71Hau8woza5bw54+xcqOBIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJnpcXsvOdfb9sx0mSU63mNJKh2Upob48mlnhp1DrNnyvTnsKqh6KHJbR8UUKOHD1h4xmOuwD1jL6zW8ImMbM8n0Nt+R7+h2KNyltbqxXSC5d12ADyXuWagHg2awP4e3fBZ3EMEbcD0bten6uoElf4xj9aY/sxHSi58/aPahIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqYfG65D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqYfG65D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD141F000E9;
	Tue,  1 Sep 2026 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256709;
	bh=cig5EAB1yC6y3NFERncxBWChwEjQLbYEzPejDmotQJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XqYfG65DREwMaiMkAcjZzAXcPhrGYZ7dkf8rODdAGiFi0tudGi8LYNHJI5+o+UAeh
	 zcH/Lc4dgarJejrsMBlH7v9cr+1hFlMG/NcvJcMNSqyqyxRMX5e9cNr/qznbz3d3V7
	 IkE2e/ZO4qUC0E1Ww8pxm78JGSIRNlqR1k9OPAprU7fSS0ePmSjGAwQ5OTmU3YHQjA
	 kGz3f92LSyRQpuC3R0jtwyBFoBu3/DI61OPF3aZZgziVEyRGAd0TU0eYBd7kEKBIUi
	 b1NV200BlGuEQSCwndZ26limqQGKFx0f6qx0uF6/t7f1hO5mJOO4LA9zVswX4IKegp
	 OrK6MUyUrnigw==
Date: Tue, 1 Sep 2026 11:58:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arthur Crepin Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Message-ID: <20260901-busy-lorikeet-of-piety-bda3a1@quoll>
References: <20260831-wiznet-link-gpio-v6-0-abee6c5c966e@marmottus.net>
 <20260831-wiznet-link-gpio-v6-2-abee6c5c966e@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831-wiznet-link-gpio-v6-2-abee6c5c966e@marmottus.net>

On Mon, Aug 31, 2026 at 02:53:35PM +0200, Arthur Crepin Leblond wrote:
> Add an optional link status interrupt which can be connected to the
> LINKLED pin on the device to detect link status changes.
> 
> Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
> 
> ---
> v6:
> - Fix DT error: use minItems
> - Remove conditional properties

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

