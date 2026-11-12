Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500874;
	b=lyAkOyx/TmIrLkMIm4lM8P5WavdzFVxsGFENxFz4MxFoC1laNcO3w5egy6zx+ajT77KZ
	 WNjhzVNTMdmek5C9352VAllAw2+583e/qqEdSR6O4uFYrfCVR1P96KFMxhK17DIa92YWm
	 bSlAIgLzqoK+OmMYuPf+SOJK7kZLd5iX+BJWemAK6vwI/kmCGXZoFytAC5Po7yrWVLO4V
	 1yFdVdXXA/TbLaNfHNDczdm2Cbn/IxG+ovG3+irP3P8EOr6ORL+ksvyBIVBOvZ7ILMEzj
	 el9Iu33iugrKppeSCxXZ2+mZABhsOdOx4820qveTZPX8u1oZzH117p/Ixqv9lS9C6yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500874;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kmfb46M2I9AYNtsOkzGJVWlMMFJGA4yiFZVPGuW7CwM=;
	b=lfYU8nIuTxffiO+t5Rjw4u89HmuYy2+D8uL+wc3KTo8jCyLStAS9WRUvBLzYfjBjzRQS
	 YfDYXmPBiK72LPSAxBdvuLomA1mmXbsA9WYXZza5TRYx98S52bfbO0gGtkPbsgSwXRS8N
	 7zQ7IqYsUVAWMZwaFI0DChLrJgqfp/qmr9K/ITev+9jFP64BAcsgCGk/ewBkXK/3sUemf
	 uK7lNiKA9YiXTTDFkx2w2vA00da/e6ksBxjd4XjQqHY4cyjb9GpcVgWppnD7sZEwbDbCL
	 EFls3GGJSk5NQ6KbPcsw4k7C2Gpx18E4lBbE8rmfoBSvaIvs+MIPPchxhbpZECYafPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwiSq+Pf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E64606A321;
	Thu, 12 Nov 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CwiSq+Pf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315391F000C5;
	Thu, 12 Nov 2026 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794500874;
	bh=kmfb46M2I9AYNtsOkzGJVWlMMFJGA4yiFZVPGuW7CwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CwiSq+PfKJM6HLv7OZB/ibYykBApv7ekBHEpi8ZZ8JJJLPAmcEPfhvLJxYPXtLxYI
	 X5EPubjxDz6ZAYkuE3d7j3a3+G3znkBmelgxHVACdDjv6dgGRdgxN+cEeLnOLXuyq3
	 sdL5r80drNhPubN/wTc/kEv29bw8rnVdL7thv4V/6Gvn0sxEf/ptlt09OiS2muro0t
	 EVW31K15N7GpxUVMjeJUklGxXvmnyiboFfiUaWe9376RS/oL+TqZyNmoxIQUGXxMFM
	 MaOTfoi9GJ4fUVwIT7aMj9jtuCDCPx0Nn9lPG5cAOwYx885yeRwg10Rls8I9LI+n5q
	 rDk6+u3Gxi+Yw==
Date: Thu, 12 Nov 2026 08:27:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Breno Leitao
 <leitao@debian.org>, Eric Joyner <eric.joyner@amd.com>, Abhijit Gangurde
 <abhijit.gangurde@amd.com>
Subject: Re: [PATCH net 2/2] ionic: limit TSO segments to the Tx ring size
Message-ID: <20261112082753.6ee90fc8@kernel.org>
In-Reply-To: <20261107-b4-ionic-tso-max-segs-v1-2-67c248a5b681@amd.com>
References: <20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com>
	<20261107-b4-ionic-tso-max-segs-v1-2-67c248a5b681@amd.com>
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

On Sat, 7 Nov 2026 00:23:44 +0000 Nikhil P. Rao wrote:
> ionic uses one Tx descriptor per TSO segment, so a GSO skb with more
> segments than the ring can hold (num_descs - 1) can never be posted.
> The driver never tells the stack this limit, so such skbs are built
> and handed to it instead of being segmented in software.

Trying to adjust the max dynamically seems like an overkill.
128 is a tiny ring in practice, I'd just bump the min Tx ring size 
to 128 and set ~128 as the max segs?
