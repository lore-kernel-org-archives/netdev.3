Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A038F935;
	Wed, 29 Apr 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446587; cv=none; b=jq22719BiANz1fKsosruFgutrVpQTWuXFKHpy1wBRN0c9KAWggCm2qQaTtFEtbS6eqrtEzy4MaJd3WViWYf21nbzZrP9rWYF4eeUZIltT+S+G4RDkPrcu9m60DPEyUCe0cLb0c752IGpJUzy470IU5sLjdKVWPMJgmmijJp8Pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446587; c=relaxed/simple;
	bh=APiwUvJaaQlM1Vpx7K55AnRbQCiuyxbtZA7W8/1v5ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4GQ3cHYgNHKakblCrP7iwyy6De78QJXNa+npXeRG4SWd1PQ7+6glHGd+9dEvrhoYyLgb/iYa+itzfwUSz+KAPEaCsYimIopjVhJuUCFp760/uX+U+PoEim9RQw6PfkY4y7WTX8RC44eQzr/HjCVyFGtnmvDt9BMwbkaRBiAaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmQARFoX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmQARFoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FB5C19425;
	Wed, 29 Apr 2026 07:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777446586;
	bh=APiwUvJaaQlM1Vpx7K55AnRbQCiuyxbtZA7W8/1v5ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmQARFoX/ipaQQkeK1vwHVlHe+hz9XvIHTjmSIGxHDXrbMGvAn5sloo1TQoRgjKyX
	 OEctAeqBvLau/CSoMAuJEFHWwQC7FqFvnBHty0x5GR/uBQ6zzMC7DLbwUqyqqKbbR0
	 EdZ9DwH5IRmE0tYlvDivAgLDr0AzoBKo0aFQ0g3smQb6wGxbDbDotwHtzeiz7GLFXW
	 POk67QLNF4zxo4+MzKkIy8rT+TJZ1chyW7KFQmLyD7qJLJHwBesdf78ieRddk89QpK
	 V+gMoOsMf9EEU/n4xKcaS6nb9UNCJJHf/u93TESboIyFFSssgpm4vz07Ja2xePUseg
	 1Uu+2GXTD3JhQ==
Date: Wed, 29 Apr 2026 09:09:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v3 0/4] net: dsa: mt7628 embedded switch initial
 support
Message-ID: <20260429-impossible-archetypal-bear-607a7b@quoll>
References: <20260428185510.261521-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428185510.261521-1-joey@tinyisr.com>

On Tue, Apr 28, 2026 at 09:55:06PM +0300, Joris Vaisvila wrote:
> Hello,
> 
> This patch series adds initial support for the MediaTek MT7628 Embedded
> Switch.
> 
> The driver implements the basic functionality required to operate the
> switch using DSA. The hardware provides five internal Fast Ethernet user
> ports and one Gigabit port connected internally to the CPU MAC.
> 
> Bridge offloading is not yet supported.
> 
> Tested on an MT7628NN-based board.
> 
> changes since v2:
> 	- fix binding issues found in review

Which issues exactly?

This has to be specific.

Best regards,
Krzysztof

