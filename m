Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E52D8364;
	Wed, 23 Sep 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122872; cv=none; b=IAtHBG/DBefBo+YnlGr3gUKoTHsdxJBt3FdJy/9VGPs277Hi0gklv3CZjlRcTXma1tYkNO4cyunmyHP9F2Nf5vkttxKhdJG2yJUfIMT2Je6pJd2RnCQnh52bj5DdtV3VPMKETpZbevpf97YXDRsyeidUBLA7g35iqylXfNRxEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122872; c=relaxed/simple;
	bh=giO1ZIKP0mFR/FkPOEifG1Q78vinp8tTBn4oAZoyxM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZfQ9fQHimcsqhjKgy540PuktEDxMEtLa2/agCKzgsAapDQ0r4lbTGcRigBIVwP6cwRNEbaGVZrZJipu+RRMr9CCwbb+n5grA89N6lVjmlNmub1uOFefbJG30qeuwu9AgvjmeGp+Wgd5ef2XqLOAZDIVK4yA8WhcLscBTzgCJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP5W3GZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP5W3GZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2BD1F000FF;
	Wed, 23 Sep 2026 00:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790122870;
	bh=uzB1bIu4DCAXkv+EdyAIgxF9xElFNSnl6zM2ZgAtCWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UP5W3GZlkEXz0RmChr/UZd5XuxVjbLtw/24ppTpDkV7iRPvGRVoFmS/7rTsUDKWbs
	 TQEuHvWtVPskwH4QBnZoOYuNkgZ8O3GRJGjuRxa/Wk+GgMAsQlJOow7q+0DcEFEmyW
	 PpyjJgWaoPsn3EZIY2g4hD8/DaiMrrWFQDaxiXQLvNUSA4dztpn8duHDqjKsP3rv3n
	 XAS7XoRlTEYPuWL4QpBOMztATDHSMTbO085x9nfyYi/uITT1IbqZr0ZYUCscLmLpFa
	 0x2SBL42d1tEDMDJb/u564g1YjuxtuFFkLhHTNDH4g49MEn7ckFtHlP9eRZb4gCdj3
	 Gz7d2tqU9o3tg==
Date: Tue, 22 Sep 2026 17:21:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v22 4/9] mfd: an8855: Add support for Airoha
 AN8855 Switch
Message-ID: <20260922172109.1e666b56@kernel.org>
In-Reply-To: <CA+_ehUyFH_ZSsjhp-U9WBFoRZR-ZMWnNQ5pY5vAy1LxUU5hSsw@mail.gmail.com>
References: <20260915123812.14747-1-ansuelsmth@gmail.com>
	<20260915123812.14747-5-ansuelsmth@gmail.com>
	<20260921134410.13a7173c@kernel.org>
	<CA+_ehUyFH_ZSsjhp-U9WBFoRZR-ZMWnNQ5pY5vAy1LxUU5hSsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 12:14:22 +0200 Christian Marangi (Ansuel) wrote:
>  I also didn't receive the email for the AI review... Did it broke also here?
> If everything else is ok, should I send new revision or maybe we can pick this
> and I can send followup for this warning?

Clashiko gates on build and kdoc being clean, to try to save tokens.
FWIW this is also how the CI (kselftests) are gated.
