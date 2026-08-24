Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B241F346;
	Mon, 24 Aug 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576550; cv=none; b=D1VEM94GSCnzcmkTkeOVQ6gn+M+zuJDGcx0tUIcT4Xl42epjgRqEdp4sffNzju0Vxh/J4EvkR/RvKxnVdSQ04YVBRwKyw0Rj6Sejt2gUaC6HQqUa/2Jt+cTzdqpjaxBeQgVOf6Rvc4QsEW4/PERyg+nD6Th7UzKcNO8f+9Plw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576550; c=relaxed/simple;
	bh=1B86zSs0I0OPdq4TgqagrvJrJGq2lJksezEMfenS0ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1fFjT4fjXsS9qC+7ufb4DsMmy8KE2b+uceVtvjsKebmazcA4aGAro814vShpsPoWEgaIUgeVYZT6kmT/HrfGhbn+4TXQbJFyLsRDx94NtaVUuXI/XIhDj6w8OtVtgGzw1d83oEPXczdNrNif6uerX0GeKTubBPl0tfgLhD9UEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAXAlsB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAXAlsB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA341F000E9;
	Mon, 24 Aug 2026 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787576548;
	bh=y8ON5O0xRBk0V7eazOYZ/PBPMVkJFX+oDefZP75ITo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GAXAlsB//ww2+SwkpB4AA5DlL3sAO7k/cvomeQ5iLYocYMO7kmOh3Rk+zUQXn9MHy
	 qFh5bHxra40SvdQI1qz0JVQQbgWpcURmLe1TLDNb4kGnXsSangBAUeM8FQFSnwxRmA
	 IWYmOPzguZNRher0LWZPLcOh4Q3RbC9Hjr17OrNZ/btK09UUxp0PekZlzgsewrXYqS
	 YxcN5MtOrM+vG7h/6tfgmfaLAhoPk0U1UsEDc8dt88CK99HzpL6wur4UMOS3piDbfF
	 5Wn09sJy/ykGqs54KyVGTtS4Knq3YeWu3Iw0l/16biJLqySyl8L9xMjbKw1Gc1IDx+
	 AlVQd8d8xp3hQ==
Date: Mon, 24 Aug 2026 14:02:24 +0100
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2-af: Fix TL3/TL2 link config ENA clearing
Message-ID: <20260824130224.GT265046@horms.kernel.org>
References: <20260821055445.2517568-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821055445.2517568-1-nshettyj@marvell.com>

On Fri, Aug 21, 2026 at 11:24:45AM +0530, nshettyj@marvell.com wrote:
> From: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> Clear and restore the ENA bit for each TL3/TL2 link entry during
> SMQ flush instead of repeatedly using the same link index.
> 
> Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>

