Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732AA5B1EB;
	Tue, 21 Jul 2026 00:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595168; cv=none; b=iLLlBQuFCpyhA2FmNMFVGokn7gN3hM+y42eecMG7UVjCt/wAMiPlJkY+XjyzjhVx2lLUXfOdMcsukOOMvUNNNpDUapZTdu7bV++qSIr9JO6gWQe3lAb6CLx7L07SEW2G505f0CDnNnD1G6xRCVCucnG/DpP2tUw56ORK5aA0WYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595168; c=relaxed/simple;
	bh=roE5aYGXlUtbyN5zsBTzFzX94rQlN4sYy7HOvfWaW4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8NcY4iaePYghUTuUxKGiAUiwygilMaiyYzyCavEaf/lBGbKX0Fhlc1uDIMaFrx422U3Ow3wnzEGH03jl/dwRV1l+jDHLSpdPx8TuKs/Dy0c2LfKQzAMgXEznB3EyWsHoilmPq5+sAJGl4VUOZ1/YxgvM6mcEHXtCeYHiNG/OZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFXaGE2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFXaGE2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65B61F000E9;
	Tue, 21 Jul 2026 00:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595167;
	bh=h+fkmxQikmJPIse8sboIlkXxWKrw3bL0tjMFEZkWXz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iFXaGE2YghVFdVeU85G89GtgPJu6hQSciWy1kJ6J77c8sQVyhNr+2Wasz3Z7J16Rg
	 wTBWyfDeGouG/U+dP073yFRp1rpOifM4GgjL0/v5oRii1HcUKY5dRABlpW13ER2Kws
	 zKcO4+GUI8gFHdw05vtYWXS1xRLRI1aqDYWOfb23gtXCPGbU8P4xl7yxuB4sDyU7it
	 mCq5r5edxQF4WB2GRZiBjiVHPyMfCpBi3Gs0pLJNn9ajwzRAi920hKl0BEkPl7+7oH
	 Ec7pBjwXJ6Xhoux+UAoQ0LgsAJdQvYrw8eOpMrkmA2uFEDpcsyJNMFU5iZMweDL4+C
	 QFTd/r6WqptNw==
Date: Mon, 20 Jul 2026 17:52:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <rmk+kernel@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell: fix return code
Message-ID: <20260720175246.3433bbc3@kernel.org>
In-Reply-To: <20260706120637.1947685-1-mwalle@kernel.org>
References: <20260706120637.1947685-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 14:06:27 +0200 Michael Walle wrote:
> Return the correct error code, not the value written to the register.

Applied, thanks.
