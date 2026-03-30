Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB53EF0BC;
	Mon, 30 Mar 2026 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910595; cv=none; b=gdJHNiDY5RraZF+bJf59R0lnKX4angM7Qa5sFTOOxMpwttmycjrM+YQLP3U+oK7cLK4ZtiT4/D0AQALJHnDax5uhTCjEKLI5uCnz7MQBN0VLyBP4H3DdWEdVsTONa4niPfglwCWNZEQaYbnunbqj3zmXSgobJ/NMC0G+bMUn2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910595; c=relaxed/simple;
	bh=Jtr7Cgs42E1wZ2l6KUsYhsVRKShVAqt0nKYjEQkpRb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIT1zPzHUdoO4PUExwdvoaoc27lK6oIv4CGJF3/jI0ZstaZ+cVypzZN/KLd8E2GwGes/SNFP7RSaWcBqOQ9Ku9cAsYHo9KPoRsPmJBaO6986tip6A78mhBB8cwXVH4dty7isH3aRt5FAIL8O1rWcSodrSRBhbe0DRt9c+Lu78MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkGMs2O+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkGMs2O+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7DDC4CEF7;
	Mon, 30 Mar 2026 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910595;
	bh=Jtr7Cgs42E1wZ2l6KUsYhsVRKShVAqt0nKYjEQkpRb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lkGMs2O+AiBpQGjIrQLrnwjSwzwLGCMzGqtOKwW3ePNzGZfdlZl4Jk9j2CuD9WHSE
	 k+rQ7MRSdNLixbYROnHQH3IKkP9hVFdxw/62zQa3ebYr0MPzpjezTwUmgnNDdLxmLg
	 MPkWrW+K3ZMZN+gKwboOaOgwYe7kGGY8Hl7cG5akv3u9uioewlen1nFVsSFyXZgOEa
	 ON+Ds9e6WnwRvD3N7cYnn3DRv+W0Hsuto6vFnmc7+l83rtCv8XClQ94PHllpN1UvHA
	 hXAD+KOuU0ampErbA7xO2UcMtwmVzeMfH1SJSR0x0grRJV4yO/yvzhV6heJRBIpV2O
	 23Z2LR5giDrAA==
Date: Mon, 30 Mar 2026 15:43:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 kernel test robot <lkp@intel.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu
 Beznea <claudiu.beznea@tuxon.dev>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v1] net: macb: fix use of at91_default_usrio
 without CONFIG_OF
Message-ID: <20260330154313.58edbf52@kernel.org>
In-Reply-To: <20260330-overture-cactus-c8eb7b9cbecc@spud>
References: <20260330-overture-cactus-c8eb7b9cbecc@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:02:00 +0100 Conor Dooley wrote:
> @@ -5778,7 +5778,7 @@ static int macb_probe(struct platform_device *pdev)
>  
>  	macb_config = of_device_get_match_data(&pdev->dev);
>  	if (!macb_config)
> -		macb_config = &default_gem_config;
> +		return -EINVAL;
>  

AI reviewer says this will break macb_pci.c which registers a platform
device and will never have match data?

Feel free to post the v2 without the full 24h netdev wait if needed.
-- 
pw-bot: cr
