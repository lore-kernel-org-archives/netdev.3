Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463FE1D54FA;
	Thu, 20 Aug 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248844; cv=none; b=ewkNpLFKpfp201B5W9Uc9MNl0YCsuHnxM+sg3pT/7jyCAzzP37EvOfQTBCyoxa4EkGHIZCJ9dgibarnecAX9+HNXk50oJ8NkYPc8ZK8Ydqy1QfiKTXOgCz1I1Z0c5OVG/L3C6XtPEcTGOG88JfiESQD+ThBxZxUmiEYR4I3rEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248844; c=relaxed/simple;
	bh=7PA6NmViShyWZajARwsIkdIX81nG6M8p/AJ8/lL11mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxdq4ZDwy/kWakewAUPHdT177FthVplJjadTKQMS4Zc4bys0la3if4D6GN6fsFm1mxDN4xxgq2pu0JMdrP29R4cw045l8yA52OGJDryNrO0makAvdUQAQ/HgajZSG+hVDGrGdQQcuBNSQoeXyiaZ43jdTt8cxmaZIkEDDhiPDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF7oWYFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF7oWYFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A101F000E9;
	Thu, 20 Aug 2026 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787248843;
	bh=7PA6NmViShyWZajARwsIkdIX81nG6M8p/AJ8/lL11mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fF7oWYFQdBdt0nA/3J0lpA52yebPpDglIMnDlRY9Nt7G+zivrHOzWekEwDjxtn1If
	 KmOu5Q/aYOMwjlv75HfcgfbI9xwZN+dgeyRLtVoq7Hs334YFtrHQAqUJGeIHPCB96f
	 MsPNSfW/EbFy/AWdA9qissFiUeJ2LncOVHoEBC8gb6zrrZW9+jnzvfZoQUeqbkNVl7
	 tjMDly+AUP6339cLWN225e0L54zUVA8HuUBsg2UuurIDEuqO9ARCvoWKl1BWan8DX/
	 5MmNVPGD53QYhbl75SFqTf1mlZyFChP0T9z8h4R0WuvV74Ix5pwRe5Nj3+WV08BMJx
	 LUXUzfGJ4qUfQ==
Date: Thu, 20 Aug 2026 11:00:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net] net: ynl: allow u8 sub-type for indexed array
Message-ID: <20260820110042.0f12ac26@kernel.org>
In-Reply-To: <20260820110904.28645-1-hilalrahmatullah11@gmail.com>
References: <20260820110904.28645-1-hilalrahmatullah11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 18:09:03 +0700 Hilal Rahmatullah wrote:
> add u8 as supported subtype for indexed array, this is required
> for attribute NL80211_STA_INFO_CHAIN_SIGNAL serialization.

Could you please send this as part of a series which adds that field?
Otherwise it's a bit hard to review
