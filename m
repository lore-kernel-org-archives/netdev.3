Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58450347FD3;
	Fri, 30 Jan 2026 04:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746537; cv=none; b=jO/eYcZGacUUFUD6ra6qYWQV2Cb1JbL3hgL/hRSdOn1TjcVhCVdedsKRw5UMxlhqLI1QcyQ3UlcQUQd89SkwERjsC9Bzlx0S5DYKDWfzTgdlZcKgFdKINYKE2zu5TDELqOLV1A5CvWaABeaK9b3ZMjCPX9XdrrwLHkeLII+/TYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746537; c=relaxed/simple;
	bh=Rub9cw2ln9KYCbS9XFc8VVbW8/rmxLnoMpV7jfhXOR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHsR3esIR689VjDpaebPtpmrycBVvBQh+y4VcSaDPdpPmSu1jdNz82ompFA5eSi/c+Y8Kr3IjDVDcbj1foPLIwdbw5yiM9Qz2JcU20Iw1MV05QyHijIEDa++RymUy1bp+JvesV6TcuKgrEoGhdZGi+dzfSAnegWFac4ncRWD0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7Smu8KB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7Smu8KB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F6AC19421;
	Fri, 30 Jan 2026 04:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769746536;
	bh=Rub9cw2ln9KYCbS9XFc8VVbW8/rmxLnoMpV7jfhXOR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7Smu8KBT4S/m+LEQ1gmVdvqMc/eP2eL+DjOXxHjX+29Z2ZfkHEnUDkrvWoR3OXeV
	 aN77Yod0UBsxSYqzLLCNk6PlTfFecOCRdy6eG3oEcOaN53Lurg8LD0fopO0OP1M15Z
	 svgjecEeY3O8wztbfxMGGl4PQJKHpiEJZnIZon8PCFfxUvp/AavuDhyDCXLKuaE4vx
	 sgsvJuX4jrdM15knk4wwgxMN7R4SvE51smgmkj/a0rr40EJT7D3l1k5uX4OzVnjkWe
	 Skd35sUqER6V7PmAIUJ0dQNPGhje6XCq/JzZwX/nh7IaVw4AeOH+osTKqSlqjfhRAU
	 tVjzCxdNs7E/g==
Date: Thu, 29 Jan 2026 20:15:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/8] net: dsa: microchip: Add KSZ8463 tail
 tag handling
Message-ID: <20260129201535.317d90bd@kernel.org>
In-Reply-To: <20260127-ksz8463-ptp-v4-5-652e021aae86@bootlin.com>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
	<20260127-ksz8463-ptp-v4-5-652e021aae86@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry for the nit but:

On Tue, 27 Jan 2026 10:06:47 +0100 Bastien Curutchet (Schneider
Electric) wrote:
>  	case DSA_TAG_PROTO_KSZ9893:
>  	case DSA_TAG_PROTO_KSZ9477:
> +	case DSA_TAG_PROTO_KSZ8463:
>  	case DSA_TAG_PROTO_LAN937X:

This..

>  #define KSZ9477_NAME "ksz9477"
>  #define KSZ9893_NAME "ksz9893"
>  #define LAN937X_NAME "lan937x"
> +#define KSZ8463_NAME "ksz8463"

this

> @@ -457,6 +526,7 @@ static struct dsa_tag_driver *dsa_tag_driver_array[] = {
>  	&DSA_TAG_DRIVER_NAME(ksz9477_netdev_ops),
>  	&DSA_TAG_DRIVER_NAME(ksz9893_netdev_ops),
>  	&DSA_TAG_DRIVER_NAME(lan937x_netdev_ops),
> +	&DSA_TAG_DRIVER_NAME(ksz8463_netdev_ops),

and this - appear to have been alphabetically sorted previously, now
we're just adding at the end.
