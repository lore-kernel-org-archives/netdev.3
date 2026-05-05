Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8C3597B;
	Tue,  5 May 2026 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939473; cv=none; b=uQyOgeEDa3cpqhdYX0FWJoI04Vzwtq+f280FBz9ysol2t9EDie+/yY3PayjJXQFRSZ/Of+jpOlD7uXrRlvgCjMAC6zamhdN8k63EGSDOCqlCowIDS+2J4l+3RE5rCIwuMDhRc50GaGyEYEPA83ZYojaPZ09Ni/09XmUuhdAKoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939473; c=relaxed/simple;
	bh=FvERsU5X/C4NkndxX6+evMWWsheN225ZFhxn89hQYhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rX8p8xB8oet0sOPk1Ncj7ld+ulbkFXhsFTPEmY44ZJ9MHMV8TuHCtNVx9s5KTS/49v4wLj/OKGJiY8vDN9eUuoPoYMZOjg7HxyohEfUtdxKKvzz8vu9H4K93fv4cLOFi17r0aYc+UP7soQ4yFro7tS03jxcTxTwsSsvEfcqfwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6r3zQHY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6r3zQHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CC1C2BCB8;
	Tue,  5 May 2026 00:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777939473;
	bh=FvERsU5X/C4NkndxX6+evMWWsheN225ZFhxn89hQYhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G6r3zQHYU4BxdFGe1vLL9V3NRXcwo4pNuPmwFlwftyL6eQthBBMC0d5KKv1ftgAMg
	 jJDRPYZR3Eg3mvEJBJHj7oxPqJM1xHgeF4UsUNjDZfTwBWy8TEqiaGPhnV+r9AQtee
	 tfpivcStvbHKs6G9VSPjuW/iH0Z5EH4Uda+kDjZrtnSqHs6EayVTmJ1jo8mBc9C2pq
	 dSfURIuKmGyfU340xhC08a3b9fRotYZ0J43VmAvHcnK3CkJob4i4Lf2RwsXl82QGtT
	 cWFAhOjESlVdAaBD1tm1/7LIMc/gXoswlJ5BpIAEv1C+q3IfkYAPeeYlkW1HbE4J/4
	 A22EuGyIvWxNw==
Date: Mon, 4 May 2026 17:04:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Grzeschik <mgr@kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update address for Michael Grzeschik
Message-ID: <20260504170432.5bc3227c@kernel.org>
In-Reply-To: <afexp-hcrSrchinN@pengutronix.de>
References: <20260426-maintainer-v1-1-d74d2f4343f7@kernel.org>
	<afexp-hcrSrchinN@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 May 2026 22:35:51 +0200 Michael Grzeschik wrote:
> >  ARCNET NETWORK LAYER
> > -M:	Michael Grzeschik <m.grzeschik@pengutronix.de>
> > +M:	Michael Grzeschik <mgr@kernel.org>
> >  L:	netdev@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/net/arcnet/

Acked-by: Jakub Kicinski <kuba@kernel.org>
