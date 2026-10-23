Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795210;
	b=nWAcMAVRRVVpYCfkUl6XlKjnu+cuP5l4ZwL+FcbueUwb5Tu1B5vZn+pKZV7JaVPPopf3
	 NTM1MeYA9pI+iUNQmnBGwLZn48w5/tqEYIjKBTMy+xCvJI37jIOKSlbuyNH23/N/Wg6az
	 GPSWBAkGGd0E4zxZiwoFA3Nmuao/M4iCTigcdLbAe9EwJrp5SgeCWDtZ0YD3FSDPgZfSX
	 4fvpa9hOsPPtsz8PxSxZxM/JLwOdYpSDyl1jLFrsI9T5UBgNSadRerUTGH/znm+ilrdnB
	 ltDaNoLkEEeAA+VAgMxlY3bW35wXEQEXjnR+aEuL3zjLxSRZS2NqiL/+wfKapZPXUqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795210;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3cl5lHcyU92W7R2/27I911QEyhbkxo2mdttjM6T3r0o=;
	b=q8GkwAEgC7E9p+413NAclOAl/mtJDIMjWMjCNsb90C9hLepyMqEHApZ7HcO6vqQUdjIU
	 hCFnCZnOmThGOwOC/Mh4Wf3uNtcajzFW5+Qxd41xNGaKa7jGQHkpFMeoc0K/RA77Hf/3R
	 xVcyQ3tA63N7B5GlqvnYN/ZkqzVQXsYete6tPTOwPedViXKyV2c24W8C3K7CYDj1lQrZG
	 v5ExnC0CvsKAVWiZss6ztqGsCRn0a3mcSWWYVQOmxRobi8ts+0HgdX7OBQqaavbzb5kWE
	 sT+3q9J/xZ8/wxxWFx36cRYjR3a7DGloGbFuW2hxBZ/7ov9jStdMG5OWZn/pP6kLiMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abQBkFbb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC5606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abQBkFbb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC4A1F01825;
	Fri, 23 Oct 2026 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795209;
	bh=3cl5lHcyU92W7R2/27I911QEyhbkxo2mdttjM6T3r0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=abQBkFbbrUFGgxGXBoBfn5OAVmC4ahP58nuri+eWYQTFOBLLvEZcGkVmXg+hPKzrs
	 4HjWSG2kIqXpotFHAnOS4na6wLrtPwsvsNbaAB56VE9TMNUYGKiIviR2TAtenqieHX
	 6e4Rn3ZgIU9dNVwF3QBTwNkGOi3p2Sv1+aHFUNbS2ceFGUUZ+m+GWkJBPNjaQqK673
	 piJtdoYrd8dUxyeEyavDqUECMnbrdmYlBc4o4CEEugAcL8RCMQ76cMqJt7CIkpUYf4
	 2yolUR2X6b5CmRjH0z1lW/PzKj1yEh+yjQU6meG2aT04Wzj3PLVuwKToBZPpaFSEri
	 jj6aDPjQQPOFA==
Date: Fri, 23 Oct 2026 15:40:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grische <opensource@grische.xyz>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net 0/3] net: stmmac: deliver frames with Rx checksum
 errors to the stack
Message-ID: <20261023154008.333a24cc@kernel.org>
In-Reply-To: <20261020190319.884375-1-opensource@grische.xyz>
References: <20261020190319.884375-1-opensource@grische.xyz>
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

On Tue, 20 Oct 2026 21:03:15 +0200 Grische wrote:
> Grische (3):

I released the AI review for you to look at.
For v2 please use your real/legal name, it's a non-negotiable.
-- 
pw-bot: cr
