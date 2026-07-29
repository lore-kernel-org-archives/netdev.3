Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9423A9D9A;
	Wed, 29 Jul 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306187; cv=none; b=sBVa3QV+kqfhQYhL/3zJ0AOqrqAJMFsOOiRnCG7cIY89hQhjfaKftkpGwJkFJOV4cTTrsmTWXl0QuUfjWrwwD3gXcKRLEuKOwTmXXcVozy3d+fj1a719QCeADpFj0/Lx7/VbI1AqZWAQzWDoG4IMBDi0tXYtlTOckOteL2FGuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306187; c=relaxed/simple;
	bh=m5SWNBxQdtMePzyMDKJ9Fi4VAu3iaNx82enXShg6uMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6XQqh8zCVBpyKXKU3Apc5rNXtUFbgSUNN+g8Z96W/h1ma1gsXnmav7EzqoooA3WVnTloRcZk6icMZGi+nYSQL3cMN5LTICiN3Gr/nVZ06aOQTwbxYe5Nm0TwRH3mRn3x/Aj8vZUSwDFRIW57nyY+fPXWfXJojOc/H5ioQZcnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3AAutlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3AAutlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3843B1F000E9;
	Wed, 29 Jul 2026 06:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785306185;
	bh=hA/U9ooyyT4N+H8fqyLDL8P4Nj8V96DYvGvtGFRQdSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X3AAutlg1b0d4uaufadLTBrecOm+SBXOXEarl8Ydbk8/Y8BafAFkmwbbjM25ZJy2O
	 H4nXwNfzmeysu8+jK54ARg1JAbp86xbroWSSRpqx65NmtMsxp1Ht9CZ+F48fN/WGjD
	 RYmaF4BUDcbOohQa+GReRzqoRS3llCRlf4M3hJTxWtfNztC6WgCFjIgtLShfx7jQHw
	 UMOP6FGbhqUsFfs6XaBUBUWJlJpFR29Dv/JbusdYGrUjWL6jA1SSjErmIApE69X09G
	 MiPdBVY97Z90ibrM0phck2sEKDP091Drqqd7rL8hpJcQsvbSNBZg8EjecLQ5YBpmXg
	 O9LVRVsO94Rug==
Date: Wed, 29 Jul 2026 08:22:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v19 01/10] dt-bindings: net: dsa: Document
 support for Airoha AN8855 DSA Switch
Message-ID: <20260729-mystic-goat-from-asgard-d6c2d8@quoll>
References: <20260728154846.1828945-1-ansuelsmth@gmail.com>
 <20260728154846.1828945-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728154846.1828945-2-ansuelsmth@gmail.com>

On Tue, Jul 28, 2026 at 05:48:28PM +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 5-port Gigabit Switch.
> 
> It does expose the 5 Internal PHYs on the MDIO bus and each port
> can access the Switch register space by configuring the PHY page.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Just one SoB.

Best regards,
Krzysztof

