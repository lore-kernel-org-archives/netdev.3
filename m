Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545054;
	b=f5UGDh6vAHc0sOiYTmUcbNkoEvABZkJFLxxyMtu3VfjYovx1WGjng+UfZToKM+WV+/Bp
	 774GBgobW6Bu0xwrei6DTE+vMu/4x+PrJe8I3X31O7T67P4ga6oNLP4Ok6Y9Iz0rLG1eZ
	 dMRAfHxlCfrkX/97HQYGN1PYQ4sdtu5GTsJZPZfsJmAzW7OFd3TdJ0WH174IRunduFqEZ
	 leprspvNsfQuFDa7LZBSKIHVAx8Zp6UFzYwaQ7P6RZeUwN+GN6fByw/gGZ82z2VkE/4Lx
	 3G036uwVZhBkw4tWBYNvGdTUjxiRnsSPTrq3KJih5WtBJNez6lVTYM2yKvm+iHGrXEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545054;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GUJ0w581DHaViS11vjCILvwAHZsNvv+sf1oGp3ltphU=;
	b=2CYpCO7HQqrrv6cX0pTc/FvmSgT8b6GQOlx6hJGtdE8BvvteivHSFajwvK4h2tfZ0xKP
	 uncRodMjFAvCutWgHoSSsSxl8J5j1KjBYKT8LCzrmKE0ZD2nOJxeVT91dwQIMQgpaeHMr
	 s8gwRWTcUi5HsLonep/cpfEpuEmn7GN1yATXIqGPM1D9xvhJ0KluIXlBw5ZF06Fu1bSnP
	 ctDhv0FcynAfouD4Uk18sgsHydXn7AO4vypHnky3j+AV6JFsGdhEC92AXN0vCJDu8VLUr
	 QVEZoj++eK8jmUKIYpOEh5KoEiCuP1Wa32lFf4jeI/yoQTW4POQfwvQ3qLw6rmy5m8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6YWbMEe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C83606A319;
	Wed, 21 Oct 2026 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6YWbMEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B231F000CC;
	Wed, 21 Oct 2026 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792545054;
	bh=GUJ0w581DHaViS11vjCILvwAHZsNvv+sf1oGp3ltphU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L6YWbMEeowJaGpH9HOT3634uZAhui6LdlVInDVrpAGU10ANvbarCz58LaFrmqdCDF
	 9GTjkQM44g0p/jOZ/wstTkgmlMUaeu841FY7pJYPQp8dkkhA5TS0OgUg0BF3IuuKV9
	 tCBARXBSkNMHV8sQsKhr56H/wIPWqlyXnOU+3o0yX66x6EPibqEvXbV8efmFRcS3US
	 RPx1jYRfX7i/u9v8DbaYZveknAJLDFx63PORwWDPxCNHL9MKSXAtWmVJHIcZvw7VtN
	 bYZIpPcmkZSVthTpBoDKFAaFC07D88X7yblWWpGDz9gw4BrbnWxX3V1K3tlSTee9B9
	 fj5sO9I/6bvzw==
Date: Tue, 20 Oct 2026 18:10:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akshay Ubale <akshay.ubale001@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Breno Leitao
 <leitao@debian.org>, Kees Cook <kees@kernel.org>, Matheos Worku
 <matheos.worku@sun.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] niu: bounds-check phy-type and model VPD strings
Message-ID: <20261020181053.08b47324@kernel.org>
In-Reply-To: <20261020233007.71945-1-akshay.ubale001@gmail.com>
References: <20261020233007.71945-1-akshay.ubale001@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 01:30:07 +0200 Akshay Ubale wrote:
> niu_get_of_props() copies the "phy-type" and "model" device-tree
> properties into fixed-size np->vpd buffers with strcpy(), which does
> not check the property length.
> 
> Use the length reported by of_get_property() to reject values that do
> not fit, and copy with strscpy() so the destination is always
> NUL-terminated.
> 
> Fixes: a3138df9f20e ("[NIU]: Add Sun Neptune ethernet driver.")
> Fixes: f9af857489cc ("niu: Determine the # of ports from the card's VPD data")
> Signed-off-by: Akshay Ubale <akshay.ubale001@gmail.com>

Please don't sent us low value patches like this during the merge window
When / if you repost make sure you add to the commit message the reply
to the questions asked by the sinfo bot.
-- 
pw-bot: cr
