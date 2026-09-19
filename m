Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355D17B50F;
	Sat, 19 Sep 2026 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857939; cv=none; b=grc8cBINWy7hASNiRKBnUj9h60dG8x5k9tOETIOiTlhEzX9vf24bRiI9t4k50mzZOuGix/9iSQSmHFzGnY/O9MaxuTVWhPC9udx1STRwo8jm3FZx/1NTdwYD9vSAzcMBDJJM8uSEpqDzuoxMNLYg/NUx8gc4i5cowsSNzJBib2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857939; c=relaxed/simple;
	bh=yFCQ8WzNYJBFC7+uDyTD06P6CArclROZkBWqqF/W3k4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7fJnI6GDgIzU++LZi1mWATXp7l3fMXz6DcRSWaVJunoaCldHFdtT+Efy4tjZAsWmgzx/KQvbYK+Uy71Jo7l/9ihAE/dwqqSLXwilaBx8iGDhXu7vwG/d5fEUkcwtEU88eZC6BUQxNjd4Ji53a2UGajrvtTDlvKG4Jc8jeT8H0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSP7LdAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSP7LdAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB91F000FF;
	Sat, 19 Sep 2026 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789857938;
	bh=yFCQ8WzNYJBFC7+uDyTD06P6CArclROZkBWqqF/W3k4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kSP7LdApt0TyYFUyR1kIJzmrZj0A7VN3ZWT85w/fYR3OaIqBzRPT8f3DisBH3OuM0
	 5/hSiFKOEiXEo8YmnIyzqlIF4Nzu4ke7H1rMdzMK2mL+m2bwMnmYn35Ga9s1/uZBZq
	 +/Ct4vgwsywKkPseZKVz6rzhIYz4PSidYDDJYxbf0ITpdF4CXITDSUOTFJWplLIG14
	 jArStFhJuOsNQEUDgLPHmi5Tr//R2oTSj/YHjDVk2NL/me++PS8Ak9eFi6opuMc3fF
	 PQ5T12e0I+MfmE41dW+/psj8Dmq2lRbBL57wgLXj4jDyllPYL2ArSqFbr/ENsIwlQD
	 nznDXEHypRLpQ==
Date: Sat, 19 Sep 2026 15:45:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Peter Korsgaard <peter@korsgaard.com>, Ziyi
 Guo <n7l8m4@u.northwestern.edu>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: catc: bound the RX packet length in
 catc_rx_done()
Message-ID: <20260919154537.15c6296f@kernel.org>
In-Reply-To: <ab569155-f779-427e-8c8f-1dc5315fb0ff@redhat.com>
References: <AS8P251MB00015FD7716F38C345619B56C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
	<ab569155-f779-427e-8c8f-1dc5315fb0ff@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 15:00:23 +0200 Paolo Abeni wrote:
> I'm sorry, but no minor fixes for legacy drivers.

I could be wrong, but I _think_ usb is "special" because
it's much easier to plug in a fake USB device into a phone
or laptop than a PCI one, and do malicious things?

I'd be happy to hear otherwise
