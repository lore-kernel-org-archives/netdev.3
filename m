Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE2305670;
	Fri, 11 Sep 2026 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091085; cv=none; b=YqLkYQA5jrXTohfVGl6F7kvJ6iGbLkwna7H/QWp91+A5qo9NhdxIJJxIEiGjk5NZDB9hnIR7ocUtX8hkdNsMARNrf1Ss/fi+i59mVmQsxgUBMDEYwEJ+b02CtgbZPdVXGWqze1RQOvL1DGw/Lp5dzCnRow1C6aOuyPqJsNSEdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091085; c=relaxed/simple;
	bh=7kCH8YBa2l720dLWwC6N+lcXkex7iH58ctC8fmBFn7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l75GP1wXkkTldPMdamvN7HxVWrZB4/rc8jngKDGuc/y9dWh4BwewPGpLd9A2jBo9exRYBtnG1fpDt68QkqI6lj5FhkNrCAHrZK4UCxNiXZ4uxiqtJD8e+QZereF3tWFEdSy1jNc7LBiKKTuDJsFQt2kj6PJAUF/Msvld3zCDBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/46G3Gr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/46G3Gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1F31F00898;
	Fri, 11 Sep 2026 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091084;
	bh=bA+YQDpiY1H3o2xbcwJTZGxX2ufCri9JPCmBgElD1zQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f/46G3GrTCAi6oyYjzduD7t8WP7SZH862KAB8RKH+jcrkN4pbzREQwVPqS97WUq5R
	 97rpKNqTHmWT4UJnD4ZBLKtakT2cReoVEnY7cniAhjWYFR28Z0DaDyu+V4NF5PTjDY
	 tf+GGElm/HAfJ/zgSmTeYhqcNIPQca6+L05/CuKiP3XALZSmlHlldRhD4TO3jLqr52
	 lUfpqwsGhn9XaX4rKcte3xcsPsNEDoZMu7yz9sK7jFRvNzYiNOzJM+R7vecHCgMfjN
	 9HpQCbE20Z29zpcYqpBinzw8W8Eld6Sdd9FGFWdODVwkxxwH8Jehnnk42uwaawsWTh
	 talCtEw1q95JA==
Date: Thu, 10 Sep 2026 18:44:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Windlin <gawindlin@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: use str_enabled_disabled() helper
Message-ID: <20260910184443.08547606@kernel.org>
In-Reply-To: <20260908200309.533537-1-gawindlin@gmail.com>
References: <20260908200309.533537-1-gawindlin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 22:03:08 +0200 Gabriel Windlin wrote:
> Replace the open-coded ternary condition (? "enabled" : "disabled")
> with the str_enabled_disabled() helper from <linux/string_choices.h>
> to improve code readability and maintain uniform string representation.

It does not improve readability. Please don't send these sort of
patches to networking.
