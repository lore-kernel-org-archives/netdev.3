Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB0547075
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419252; cv=none; b=Fw5xPoMmU/Lk68UJw2tTC3LEkSAB0RTS9qufpVqlds7DrI5N8wgNp3rqZQbDmyBaNtquwBys7G2zIXSGlck8sgMCeRuaxCv6/FDK0OjnW2HeeALzwsLvBYg1mddiRN2+uUPl0S2aYat/xC/rsemkZViFylmmhR7LulcRpTYAhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419252; c=relaxed/simple;
	bh=UxhSZk/3bbsFNd9KagZpOItAcKkBo1mdFK7esW3TQp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXPqenDQs7hteOw0yup2PhkFtwDKVSUNu5PgIUsxIcxZdMJ8ivc1UREPN9wgGANBj5MNFg+vQ+R40wFD+Wv6LNevJChzEjMgmQu4aVcnFPEVer0qu9P7Vp1CsLUMn73Plry3DfmrgO2AldPkMt+kph4bPQOsRdOCptC6vVDbOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5Up3ZpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5Up3ZpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BA81F000FF;
	Thu,  8 Oct 2026 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419250;
	bh=rf8mCHmAIXnksUKROD+QJtiyB0PuFfOntr9lPK9HPyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I5Up3ZpQBNjqX0ZVcCCJzx1IoMQOf5Pbf50/6HkFTHzuDmgxX1bMi0Vl6WLXHhxl1
	 g0xk1ikTYnPph1FR9NhCMsXvmCG1CVCc/RK+n82ZIY+Bge0J0LSy27zJ/Bt8L5iUu/
	 oW5tzwWpCYjYCTtNa5QYGuCxWmcMpjJL+6uLu+hq1gDBZUZRNvAcp1OhaBUeIJbvBC
	 3kCw2DuVJ+V1fHmzxFhSrV9OIqNNXrT0rcjfbm/Y3DNH6PdigHfC3KliOwMvrGvLeq
	 uB/UBNthQytXo7Posqjh6T9eUxzgj/QsaO51TnWfSNxg26kvTG3ID50aBEXjN6MHfR
	 80oR4EaHV+yuA==
Date: Wed, 7 Oct 2026 17:27:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: iugfdin <iugfdin@proton.me>, netdev@vger.kernel.org, Heiner Kallweit
 <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/2] r8169: preserve checksum offload when packet
 padding is unnecessary
Message-ID: <20261007172729.505b4649@kernel.org>
In-Reply-To: <20261007153438.GV83879@horms.kernel.org>
References: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
	<179098478410.1174319.5605355405318252998.r8169-1@proton.me>
	<20261007153438.GV83879@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 16:34:38 +0100 Simon Horman wrote:
> > Signed-off-by: iugfdin <iugfdin@proton.me>  
> 
> Please consider using your real name in the From header and Signed-off-by tag.
> Apologies if I am misreading things and that is already the case.

Legal name is indeed required. If that's too much to ask - we can
certainly live without this contribution.
-- 
pw-bot: cr
