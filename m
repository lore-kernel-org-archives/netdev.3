Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D41A6839;
	Mon, 17 Aug 2026 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008977; cv=none; b=KYTzBJO+OgFKX3mX4Pl54Vemv8DvtGjNcOH5dIgRc2PaqPjyEo4TlSi44JkK403yYDY9CXJu9T+ytSA4jMi34fGLtl5iNVNUpz7urqh8D8Twn1mPfZarSs57Kujtcg/fNWOizoeIMxZO6+s47RGD47ZrgIlnWq3OlRm/Qz/TJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008977; c=relaxed/simple;
	bh=WkCtN+5pSKM5tMMjvh1elOma0OpWKLG4pw3T/Ga95J8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwzONrfumU7wSExoYU2RmPoSzh60nj5Uiiazng8GuKrfJHWbz+bzC3p5BzduCxnftARFhFfPvKF/+2xg+h5UfQ8FIjSfsS+2BNE+nZSr61w47me5ScZT0/3VVYavDrRKq2Dnr7t51oaqMuIndqk/09s7ro16/Zm5NaatlUzP91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARWKoB19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARWKoB19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC831F000E9;
	Mon, 17 Aug 2026 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008976;
	bh=Tgn0l30N1RA5o0zfTzRDM6zBNO53Z9uNVOnqGcx+yn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ARWKoB196/1BGEjEbJsyMB5Y7BzCn0l/95kDek3S1fwdkE+1jt2/7HD7ZKk/VAm3X
	 wsaO/fhmAc6CoiDeLA4fQ6aesXwr7qM5oyqh/z8Ez5cZjjcMUFrAHm467q0vPLGLXL
	 IeieFvYT3GEgUgfnrQhlaYqj9l8DKxksHhuDEdAz6cvH5992pw8xjFqOZRy5UtaNeq
	 x/JzH695tExwMzzJ05rIkZ2CNClUVOSVyunvuIHGV96x/fKRkinreo2YqBU+fe8EiC
	 QKYLkIHXySV+nPQunqJ5nRQHA9QL1UK3n/eHxDRpfJcCJIS0yrx7x6evJwhpQ6/t2L
	 sT4shR2ysTtCw==
Date: Mon, 17 Aug 2026 16:22:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Sercombe <sercombe.joel.mark@gmail.com>
Cc: cooldavid@cooldavid.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: jme: fix typos in comments
Message-ID: <20260817162255.160bce49@kernel.org>
In-Reply-To: <20260813173634.461011-1-sercombe.joel.mark@gmail.com>
References: <20260813173634.461011-1-sercombe.joel.mark@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 19:36:34 +0200 Mark Sercombe wrote:
> Fix several spelling mistakes in code comments in the jme driver:
> These are comment only changes with no functional impact.

Applied, thanks
-- 
pw-bot: accept
