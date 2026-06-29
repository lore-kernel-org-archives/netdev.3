Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414F2D3ECF
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745153; cv=none; b=u72T8k3HQYtQmEu2qwwff3aG+TxuyZoaKXtOgZ5NYLp7Hdl//B3zWWdxzlNKDSx0EvuzRmga1WbhLFHYEYVSBUKNaVksSSGOczBC89ZLgSWNRycyrtMI+NLAsk30aSY/XJwU3SWuE2LK/XVGD5euacC4bRrdYDCgl5LFbr0DiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745153; c=relaxed/simple;
	bh=U73iG2jB4U3G09IyI7yXFibzsSq/khlKp9BoHFddutI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gxhrOl2h/5s8O65VufbTRO9pwBzYW0tzMm07SunoMzwA9jCprEyWKqvPKCBvZAjHn6/BisEMlNS7zMOHajm3wOTNlZwQRH7/lxc62e0S9evAi5PuS6EjAbwVtFcAPBZqQ/WJNCdhtVkmTmi0iGk+2QdafdVLpFOMpVyTqw2AfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSvYaW5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSvYaW5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13C61F000E9
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745152;
	bh=Ty6y97JMdpTzGhE20SLOr6806cgGUcOEM1g9ulnp+70=;
	h=Date:From:To:Subject;
	b=DSvYaW5ytC8+ytMAmm4TXa38Dz2OG0MgCxa5txVSEWBDF0gb28JLGpKxJqBwbXKqH
	 fFUBxVoqyZH9b9lSJ8ArTk25cwElVU9SpTnwfyjqm2rBwe/+VwEcA3e/P+gGo7uEJl
	 C8RqdRH4Vdr7hlLhJoFMnc2Kf0JE5pJaivW7X2B7loLPNzNhCxgwKmojCMZhQVM1TX
	 GZpdDp/fqNrSa/woYMgrhuxwtFr3DRq5LKMawB1JjwHR+9R8LvlC5F8UF2tywRjS9Q
	 npUuu1xPpMbHAFuUCAb4gASTGXY0NcDXQ0lbFjKNpTbiXNBy500JG38R+E0Yq5Y40k
	 uYX93MeAGHu5w==
Date: Mon, 29 Jun 2026 07:59:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20260629075910.20c08b2b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open, and accepting v7.3 patches.

It will probably be quite bumpy in July with a lot of vacations 
and netdev.conf along the way.
