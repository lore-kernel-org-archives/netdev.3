Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985883;
	b=ivqZgXbiIK+xLDSVT7k40vVwkDmcntG52svi+3QyubGfDllpC+4Wlt/LbkZ5USOyUqBi
	 7y82Qji2DftY+DnW9/G4muS991mG/IiglmkdYnrhehn3zqVxl7vzxwVv41TngPqwwBGl8
	 D8PxqPaXOfNFkKFEqBayXFqIhpnXncS/wKbRTG43vh9wLiLSJR3hSDKHMd4ibEVOp+cT3
	 GT3yogxcTLqfz+TAIPRmIwv/eMgWKQZ+VDFURmcTcyPPuH+6Dsb62ndWWhQ5CI3jPT8DZ
	 /MV7vpcNwyOYRWeRurWI7JGnMuVws7+Z1jSBF9eC/4FFksdfFsYlMoqOi/tSieETkpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985883;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vc9FDm1jdSv08RCJikGA4q65oVTEKBJT/nuMt0yXvOY=;
	b=fSX6xXYBHp41ozRMssTB8uSTbPIFbRBO3DNzmiT/oaExquy6O049rh6y/ricnf6wp7jn
	 CT4/0Ipv45EB9h0GF3y3B0XjT37ED7Ejp0ZUN+9fnJkathwELXQWrsIROxxSGNN04iFno
	 zDF+MSpwT9ztxZWoKHGFld79+vKHBO5PAQcCuWkomf15lqnCabh12o4vkTiLd4MoWHsQD
	 SDN7p5o83h7sEu1VpeFG7X+aeKjFvhWBYU94Pr1TaWtA+uT3M6YvpINDIJhXA+hLTKbDL
	 krhbQY0rCSVsBz86tnjMN2W4Dyb6yCgNo+dPyHHTYLujZiIGx0FR+e04i8fysuooF2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efDlUz1m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B8606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efDlUz1m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BD11F0089F;
	Fri,  6 Nov 2026 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985882;
	bh=vc9FDm1jdSv08RCJikGA4q65oVTEKBJT/nuMt0yXvOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=efDlUz1mJR6UdI+AD5Sy+ox7osUxw8h00DeyZp4hc5VVe0g1e9dDX9QwiKzzmDi1m
	 Fagqug6nFLBCYLMM7J+UQWN4r7/i/5UkLPwo6TIJtgxn0BK8huTZjgmiWbAkbaQIza
	 U3YrsmrVowG6jb8eGsmwaRUTMc2OMRpXg8WpZQg+1jSbW5NKNSj1EAk1lrMzIB/9uK
	 2Er9nnCSzOktrCtO7AxdvcsrfHwiZIYtDTNH9eTVfNJpTy9l5p15OHE1A1Q/Y0vKM3
	 p2osci3IdqYtJMU2j4Ob8pYi+TvG2gGJlMOlCIbrrD/na57yZWQ0d4hMA1itS54e3U
	 aczLSzk1pshhg==
Date: Fri, 6 Nov 2026 09:24:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>, Netdev <netdev@vger.kernel.org>
Subject: Re: NIPA: TDC: delay the start
Message-ID: <20261106092441.00cf9765@kernel.org>
In-Reply-To: <6f0ee3c4-32b7-4422-b69d-c879c94262a7@kernel.org>
References: <6f0ee3c4-32b7-4422-b69d-c879c94262a7@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 11:43:27 +0100 Matthieu Baerts wrote:
> Hi Pedro,
> 
> I hope you are doing well.
> 
> I'm helping the netdev maintainers with the CI (NIPA), and lately, I
> noticed the 'tdc' runners were often marked as either "timeout" or
> "pending". It looks like this is because it missed the creation of the
> branch which can take more than 2 minutes for various reasons: PW access
> is slow, git push needs to be retried in a few seconds, etc.
> 
> I opened a PR to delay the start:
> 
>   https://github.com/p4tc-dev/tc-executor/pull/2
> 
> Another solution is to let the tdc* services running and doing the
> monitoring themselves. In other words, you need to remove
> "single_shot=true" from the config file. It might require you to update
> the NIPA repo you are using to get access to a bunch of fixes.

Keeps happening, I dropped TDC from required runners for now.
