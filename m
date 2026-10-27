Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139358;
	b=oGsFwgGAW4muhnCaoCW4oCWKhjgMHwWNA8rmL+ePiOmOF0+nu2Qxyb+peqCt/IMRutM0
	 Eo2rq/4bEYF9UGgIiQuPhQrWZn9j8BeGLi+gwEW6V5ontv19cjBR2zGNY7hO9BbkzwBod
	 8OK2HQLD15MK3qABpuvH8i1YKZYEEmbcJGUb/BmMJlqqBiOvHgjrHrlfwOyvtI7LEwOPU
	 WJBonTXymVtjpypBAcOiTRASJDIAu43Y8Q/sDWRE4G/eu40ids1luG8khi32sgIklwyuo
	 7sLDipB1V/bOA6Z70IjEy5hEicjSCgUjEwY5D8IhQQnfi9szznKweO0sUYCqtejCNFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139358;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y3nxSYf+nGkg2nxC5jubGB9hyg1F7JfBoH2ZNuefTn4=;
	b=xM86+GvR/agxngVN6Cj33Wka5NrYd/TBVog3VdDutxC4AHPFAYusgWPGbYsomBMM5IhX
	 NODH8isqZFvEe6V2U7WiTNaA7heClfd2g5rYcA3oCXOl72N9nm0ghkAvbuOtV/urZhLE/
	 REOLg+JK4JBtOKS1ActiwHdkAKIDmM7Uqb0gJ647HgV+Qj7gFyI6YDOfaaJ2DAJwZPqkR
	 JGhIMq9V3YREIEWKaEeqzajEvGTmxzLA+rMz7HENDkuSerSZvl5tjxG+IhLrZHt0OnT5W
	 rmgLKRWxCc2CyZusUs+UmM4DgvxjF+l2aeeamOiVMnA4C9cjJ1wm+UwjOkY2rG93B7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1+H9NJ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AA606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1+H9NJ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A161F01825;
	Tue, 27 Oct 2026 22:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793139358;
	bh=y3nxSYf+nGkg2nxC5jubGB9hyg1F7JfBoH2ZNuefTn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F1+H9NJ8LPsdTHvbYrCVZOqu0iZSdxaLLERyvf52XuQN2xvx+ie6VRhiUUi17XT/L
	 WNlY56Kc/CRn6sbpcrtVUA4bUl1JUo4rNtCKS15isEW8bQVFc8xHalJ/40U0OmM9yt
	 v+FtBl2/3ksrxXN4VwagnJY9u+g5HItaGazxFxQfSgbDDDKfK6njblNW7ADLB9Ewtj
	 +1hje9lQLb+RM5YyJuH1nTRgy1Tz81r+C00wj20mAkA9Iex2cnAUBRXX8L4MH0T/Gm
	 QjBpq6hYHBaknG+GqqTkw4snxurubvouQDgxOQuO/eE1BbJ5tADxNF2xjCuy50JwVi
	 N8jOMH8ZI8rGQ==
Date: Tue, 27 Oct 2026 15:15:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Petr
 Oros <poros@redhat.com>, <netdev@vger.kernel.org>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Alexander Nowlin
 <alexander.nowlin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 <maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
 <sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
 <richardcochran@gmail.com>, <horms@kernel.org>
Subject: Re: [PATCH net v5 00/13] ice: E82x: timestamp processing logic
 fixes
Message-ID: <20261027151557.6365ef68@kernel.org>
In-Reply-To: <0f0a865a-cefd-4896-949a-2b4d72121b4a@intel.com>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
	<5abb5015-eee0-41a6-a4b6-5ca9ed0a9f0f@redhat.com>
	<0f0a865a-cefd-4896-949a-2b4d72121b4a@intel.com>
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

On Tue, 27 Oct 2026 12:32:30 -0700 Jacob Keller wrote:
> Would you like me to make a respin with just that subset, or can you
> apply them? I just checked and that subset successfully cherry-picked
> easily with no merge conflicts net, and appears to build fine.

That's too much of a cherry-pick for me TBH.
Could you please respin what you think is ready to go in?
