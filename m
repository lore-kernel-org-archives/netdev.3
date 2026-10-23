Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752842;
	b=bLCu3ZqHO6ScgHFUxj+GlftJCowZ3bSt1a3QpXSJzfJ9xIr/LxoNBehOCtr9fG0yqZFt
	 6uItwpyxYwFlMoP9F5CSCS6Q6R1zxXFxyeJEoq2/UOB0xKqbl9yEsRztN2CxWZhENMqop
	 mB/G+yl+EgaFfO+kt5fAeXPJH3RUQlprFLCOdn1PDZZHcghAR/BwfxdAeVJbDHop1GT9i
	 V6Zdp6h9jgPt/FbkeTkTYpzAEP9jpNVvM8RSTULpkgTrGlkwH4PW9w3TItmnxpAwrsIkI
	 4StEPhi5E90w2lRyhU7hKguG0mV71r+qyMh11kZ9ujA7GN4iTIHPUq5TmgmbhbqrcGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752842;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MZ8NpIYPnlGXMQOlUfqmQ9hbqT25RKQJ31W0QHbqyC4=;
	b=ar4bauuQ4MYLg6nip5ymxVFLSVc6IalGmBqIFcROSTtpHQgSNj9IJEQo9u0VzAuCXHw8
	 KMiZ5mAgy7lQilROudBpdCeyeFoWVKdg4Qvzat/hKo86wrjpj+wHZudgDKcCpmamX8tG1
	 4NjiiXf/x4EVzWtIooDbnBwYgCSBWPAuD6fOmprz0uJS1VhS6P2y9moqQI8aJnETrXSiZ
	 G+bVwMKYuu68sYRbMXdpNUAtEHx/lz05ZN5B5EG66luevy+Qe/BQbTGAkYowHL3BMjUFW
	 oZMAvc9bQonFWyhdUWf4d+jsq2Ne0QQHDGEltYMVPio8N9ovE2mhLTSP7R7ma2h8kqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSaHLEWP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B08606A31B;
	Fri, 23 Oct 2026 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSaHLEWP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBCA1F01825;
	Fri, 23 Oct 2026 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792752841;
	bh=MZ8NpIYPnlGXMQOlUfqmQ9hbqT25RKQJ31W0QHbqyC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSaHLEWPI9H8m0bPTSzjL1qh53dmhcdPOwx60K4UZ2rMjMqoIxTXdT0WLjExSSW4z
	 s9tfW85JTIznEhF18GRfFhrP8TtTnUburywjmV9IzSGkhboGz1+siHMm/0lc2exLgx
	 Q5fOWEBs1kZql/XTMDT3HRmjgK4bES6KbaSvtfKcKwgv10ul7UX5K/hOacF+3U4NME
	 J8rmMM9k8T2is6arL3SKVUsr0Zlv7oTYQa5qgItEhSEhrmfcGtjJxY77EdgGOvBpDT
	 kwUcBB556cbjnoJaaFPepBQgIMf7btxZmtxClKx2etV9wyQ0seg5sNoe7/Ifrbw9uk
	 V39Xd9/A1bdJg==
Date: Fri, 23 Oct 2026 11:53:57 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: sparx5: fix tx DCB index drift in fdma xmit
Message-ID: <20261023105357.GI708417@horms.kernel.org>
References: <20261021-sparx5-fdma-last-dcb-v2-1-7b8fabdb9239@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-sparx5-fdma-last-dcb-v2-1-7b8fabdb9239@microchip.com>

On Wed, Oct 21, 2026 at 04:04:59PM +0200, Daniel Machon wrote:
> sparx5_fdma_xmit() advances dcb_index before checking that the FDMA is
> done with the DCB, and does not undo the advance when the check fails.
> Before commit f4aa7e361ae2 ("net: sparx5: use FDMA library for adding
> DCB's in the tx path") the next DCB was always the one after last_dcb.
> Since then dcb_index drifts one DCB further away from last_dcb on every
> failed transmit.
> 
> While the ring is full, this drops frames even though completed DCBs
> sit behind dcb_index. After a run of failures, dcb_index can also land
> on last_dcb itself. Re-adding last_dcb loses the frame, because the
> FDMA has already passed the tail of the chain, and that DCB is never
> completed again.
> 
> Fix this by making dcb_index the next DCB to use, and advancing it only
> after the DCB has been added, as the rx path does. dcb_index and
> last_dcb now only move together, so dcb_index always points at the DCB
> after last_dcb.
> 
> The issue was found by an AI code review agent. It was reproduced on a
> sparx5 PCB135 board with a modified kernel that forces 63 consecutive
> transmit failures. Afterwards, about 1 in 64 frames is lost for good.
> With the fix, the same test loses no frames.
> 
> Fixes: f4aa7e361ae2 ("net: sparx5: use FDMA library for adding DCB's in the tx path")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
> Changes in v2:
> - Advance dcb_index only after the DCB has been added, instead of
>   rejecting last_dcb. This fixes the drift itself (AI review).
> - Reword the subject and commit message to match.
> - Link to v1: https://lore.kernel.org/r/20261020-sparx5-fdma-last-dcb-v1-1-fb9a956196dd@microchip.com

Reviewed-by: Simon Horman <horms@kernel.org>

