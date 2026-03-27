Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2B331A63;
	Fri, 27 Mar 2026 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575821; cv=none; b=IvNlpVv/eH2y6seeqdjPiHnUUWr6F7Jm1eE/MHsOO4Dc0JYAo9CIdZRhVQQHwY/GNl1LgJrKuvzTChUfpm4Qt+LtioGAHXsh/r/AIbYfYlIhCk46MdlgwbobbWpTAacrJ6AfTakLAnKzV9mGFjllY6QtzHcD3tHDxsZOKab+EvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575821; c=relaxed/simple;
	bh=iiCnivrI3+fK1Ik1PMZAHClyS5F+z72Tq+mPnjBj2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSmUkcRQE4esTtVwaNPka3uxRv8HyTrd6RGsvfcxPmegVIhUGLUQnFngNwYYYMmpW7gg195vF9UystTPNfY5drzQt297HMmH6026baIzSktsTgd+fchYBLz5jNV41LGNFDOxYNJyflqwlmCI1EmjnGta6dQyX2S0B9zv5vrShVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIGVhIuH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIGVhIuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CB0C19423;
	Fri, 27 Mar 2026 01:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774575820;
	bh=iiCnivrI3+fK1Ik1PMZAHClyS5F+z72Tq+mPnjBj2Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WIGVhIuHjwV5IYDKaNMshGTJ6CKlt1wYMaCt8i4Pe0NuSnuoLbjDkPFTYdHd7GfYV
	 9zdE1lBMkE1VBLtbPd/1blL9X2SCDgYmnOefWqbdfQ7ta+7G1XKcsvvk7FoZjYMDHv
	 gCcFb3xOlS/XWf02qRvxlYB5eA0kFIM/sZrj1ORmIBAt4whUMXmNZMkzIt6nGZRpUG
	 /jlNhejXrO3VfXIGpnJvAuCFlF3IutjqNx/99kaVXw9lobw1AWU1mTCUb2jcNNRZ32
	 cU9h6Pv92sYpHemYNvDuqeS9FlEcF5LGc2geVK1neKlwnlopI1UDyZz/DpaiqJHLQ6
	 wDsSd2ePz2ncQ==
Date: Thu, 26 Mar 2026 18:43:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
Message-ID: <20260326184338.12dd5c6f@kernel.org>
In-Reply-To: <3688a285-7f98-4afa-80ad-697094cd7b97@lunn.ch>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
	<20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
	<3688a285-7f98-4afa-80ad-697094cd7b97@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 13:47:43 +0100 Andrew Lunn wrote:
> > +	if (phydev->link && prev_speed != phydev->speed) {
> > +		val = phydev->speed == SPEED_1000 ?
> > +		      AN8801_BPBUS_LINK_MODE_1000 : 0;
> > +
> > +		return an8801_buckpbus_reg_rmw(phydev,
> > +					       AN8801_BPBUS_REG_LINK_MODE,
> > +					       AN8801_BPBUS_LINK_MODE_1000,
> > +					       val);
> > +	};  
> 
> This is unusual. What is it doing? Please add a comment.

Also - nit spurious ; after if () {}
