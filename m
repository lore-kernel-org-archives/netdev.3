Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED823372C;
	Mon, 26 Jan 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442343; cv=none; b=pLygN8Cmzk2sMqgQLL3LiMKh6n5wXyYBwULvZYhkQsJRbwo2JEPaJ76IqWGWJagzfiozvQEIkbpYchpSSMEijhsD4rit2guaZ0QfSPPSNaWYb7q0SV/0NqL7lRYa+cDLu/dJ141Eh+w6W1s0sZkeUvdSANidk+d+Adh29z1ynAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442343; c=relaxed/simple;
	bh=n/lls3phe2cSkmNEQQEG19GZZOfLotDDwfl5PvbxnT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXrBVzGPAn18YI24estUIJZ61C0CBeEMPfbERVtzvJ2Y132TxqUzgl6hYuZCXPGqOSd3B5JqR+0XSh6JYXouc6Xt2cDiiOA5+vKUGzJo/7WhscSJZH0qj1HjBRc68QaNF3gy0hTkjH/00o489eFBeWauqzs0vtUL6R/pzNUDkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9rl15vP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9rl15vP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5ADC116C6;
	Mon, 26 Jan 2026 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442342;
	bh=n/lls3phe2cSkmNEQQEG19GZZOfLotDDwfl5PvbxnT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9rl15vPO8eDYA/wP2UCmAcf8MaGFjvDS8q2zpDw1stXc46IqBOYUezgLIsJQg8fX
	 teqs0OD4JGYzmu+dPZpx8SUQ5RjyVZgz68Srt9/Sj8kApasf9nI2Jd0LvF3yRQmpQh
	 L/cZJ7yVXUIQLC6TgMqFQq+417wLmHGB5SdYNBeu3z8bH/JM+zD1ZBUvaR1x6S0RKz
	 xO/DPRe/VX1eb8YcZxA+1BBjO0pgQjmmHCkxrtTLd6revV05ubVPmjjc/t7gaZHliP
	 9/XmNPn2fQdI/e0Z7p3/voMjIgl9JIZOHiXxdzLgxIFZsLQTVIHwpAwAqiJ9zXmDxB
	 zfbaWXtzSBY7w==
Date: Mon, 26 Jan 2026 09:45:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Frank Li <Frank.li@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Paolo Abeni <pabeni@redhat.com>, linaro-s32@linaro.org,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: net: nxp,s32-dwmac: Use the GPR
 syscon
Message-ID: <176944234037.2470745.663646756174541534.robh@kernel.org>
References: <cover.1769195864.git.dan.carpenter@linaro.org>
 <63369be0ec8a49294462f7ec061a7066b8ce9425.1769195864.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63369be0ec8a49294462f7ec061a7066b8ce9425.1769195864.git.dan.carpenter@linaro.org>


On Fri, 23 Jan 2026 22:51:15 +0300, Dan Carpenter wrote:
> The S32 chipsets have a GPR region which has a miscellaneous registers
> including the GMAC_0_CTRL_STS register.  Originally, this code accessed
> that register in a sort of ad-hoc way, but it's cleaner to use a
> syscon interface to access these registers.
> 
> We still need to maintain the old method of accessing the GMAC register
> but using a syscon will let us access other registers more cleanly.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v4: Fix the formatting issue Rob pointed out
> v3: Better documentation about what GMAC_0_CTRL_STS register does.
> v2: Add the vendor prefix to the phandle
>     Fix the documentation
> 
>  .../devicetree/bindings/net/nxp,s32-dwmac.yaml      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

