Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47135BDAA
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129619; cv=none; b=g2Yb1HXQn8CWHAkdI6eOUX+7KZKHD8iQDDcMG6ioRoEbSxP3tQMCPmGjbq/h6Me3dopNYI9t0kQevLISh4nhdYdFkRxJ9DjdK/tQ2AJy3zAuSiSTlrKLRuwlQ83NRAK+RrQDU0QlEWJprSgeNIz7/Bv1aNUOwt3+xjU7XdgJ4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129619; c=relaxed/simple;
	bh=iXNPFgRMZJAlDF2LqfBpWrcJwLx9bw7ZrkEmWXNAUO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC1aVbcKBok+L4/niAsKnkLu6OwCiALHDzl6I+4itPOq7CgXHLM6TsThmhFmu5AxcGMaN7dWrYKQcsVAr/UO3DlUGYCDskHUOi4Wy7QWodSE757k0LilhIN93wxjXMGLN7Z1dmBWshzA1z+UwvYJfEpX4HXMSRI6wUrbWyL8QnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7p7sk3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7p7sk3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614211F000FF;
	Wed, 23 Sep 2026 02:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129617;
	bh=HLjIHCoDtgwMsEjVUL8GzY87vY4NzLuLoY0MTkfHKxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D7p7sk3HPHHwAVHj/kTGEHn0X3hO33wYrtAcsYurveLCscZ64c56YBZ95ggTttHa0
	 jgP/GtE4AnLQkMlDOI8yGe7SN8PNrmWa5mDxFzpj/gKYrjJ0jdIWEh+S+Ugq1xBAec
	 82dx83BRlykm3kmal7mSdG3O7aTvyyHEi6sM0O7KWtnEii/vPfwBBqUyr6KdFAX64i
	 4TvdEgNhngpW/52PlC0RfxYPZ0kqcqF5kk9VfeT6CsR7PoszrNkrlVBIN54hrhlFKT
	 mHxKW/iIL60jKJcqaghwfFcnQIWaXN+8NEs1HznRS7BqDcQKqeLopgoXKrDSe6yTHS
	 4LeIaAsjZb3lw==
Date: Tue, 22 Sep 2026 19:13:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4] Add config phase for dp83td510e phy
Message-ID: <20260922191336.4376773e@kernel.org>
In-Reply-To: <ba60884812731055376a8e541a84bc03dd9a1717.camel@sprinte.eu>
References: <ba60884812731055376a8e541a84bc03dd9a1717.camel@sprinte.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 13:37:18 +0000 Julien Blanc wrote:
> +		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
> +				       DP83TD510E_RCSR,
> DP83TD510E_RGMII_MODE_EN);

Looks like the diff got mangled this time, pls repost
-- 
pw-bot: cr
