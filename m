Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53B40800A;
	Tue, 19 May 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204647; cv=none; b=X6JEV5tWhZtqpYqv+QZfB4S42pn1OH5eZTGJYuIhDkVQFisVkRI/B/7rFCUJGMJNoBpXfZAEEHOzt7V5VTdA2J3/xYskWJSCRojTawteY4MoSuZ2pUii9Pfh5ofkiLFNkhldMUS47DIx0T4YE1urudYxidXWl0zbOG4+7RwmlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204647; c=relaxed/simple;
	bh=Qh++lhUKc2GEnOSkvpPfGXNlaOBuxtKg8NyCS0m1GLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpevQvuyd3EjgVscb9EYPnTZKOE/J1lCnsf8B+qDPiVP8NnzcVTQEMDkfxqrFmW4owRWLfquhGs+9+QdOGSjhkXL+ilKq7sXJp96fTh1Dvq7hMy3Z5xR2xBa/hlMxw5YAZmZSjdjeJw7b5WiOk4l1q7zvk9bLOwf+/fAoKWnoMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OAGrsgnv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OAGrsgnv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=d2Cjp5n6ZMGvbntn/1A9dXkisAVm3vLJrx5KqrG6uMI=; b=OA
	GrsgnvsUE2UqTv5dRoThwkMpgQWGXFxnGebqgRBi6Up4n3poS+3xq7dla8Apa1gmcvKGw5obvuuKj
	oaSFiXK2OcgBVF2NtiK13Zq4ktpGILF3N96snn0T+CDSUjCRq9j5B5INWb6GGpjrTR5Qz8GOBpkUt
	+iXwK/3u/EiJPzs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPMOu-003h3U-9E; Tue, 19 May 2026 17:30:32 +0200
Date: Tue, 19 May 2026 17:30:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: dsa: Use named initializers for struct
 i2c_device_id
Message-ID: <2130bc0d-c877-459c-8105-9caac7710794@lunn.ch>
References: <20260519145722.1590298-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519145722.1590298-2-u.kleine-koenig@baylibre.com>

On Tue, May 19, 2026 at 04:57:22PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> While touching these arrays, unify usage of whitespace in the list
> terminator.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
