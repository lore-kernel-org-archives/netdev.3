Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218ED4CA772;
	Thu,  8 Oct 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474015; cv=none; b=Duz8ymIA7ea3GnBTPcRrn/Z4+FT1F19tlWxhYkkXp0MnVhvJVWr1pT/Ru3sifLjjG5Bhs7lOFv71LxddzmY7aFADcbwWTLk4vDnxda01km8ikadD4DuBnWIXUkvnzYdDD/vA54vgtbOLLChGCaPdWcphRfY9Ve1Eec2BHqUhGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474015; c=relaxed/simple;
	bh=WVOiUuKP+uBh0z7olFV2mvuGUPdL4r5Shaskc+lK+O4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ht8t0CvY/avh51hK3xTHjAwkiOEAPQ1Cnv6NB19oagNsLm1E2nJjBEEddvsFMJgv+Fudjbed2Vx8bx71Oza8/3YrhR5v1kffLABNgjjPDwwVvJGYCMN9soVSWNbtYBgOjY0iSSQbMpr9WDVeRZwUf08I6sddPbem+jLZPC5ygQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKTrdfXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKTrdfXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D461F000FF;
	Thu,  8 Oct 2026 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791474013;
	bh=7yzrfah2OreMndYvs/1xEFVzdCbRCtBFgLKAA03xbU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CKTrdfXg3a16el4Lfas/U4dtAVDTlePSL5+dLgC3g3Jp8FgcGkO8FdRX5aDn0z2TH
	 rCTEuUKhKvJ2DQSrnZVOUhVnlY3gyuGulmUp1MWM4jyRc47z3un7f58mAabj4ZYdTL
	 trpkoljS8mO3l/1hf+Ugwi0SraO5/ofNR3yTqeIMBVNkpdRVcK77ReY8o1i702iI1/
	 ToPsUW6dzCyxS0znwNzXnrgqt032tati4SXCkKKvkvxKTcQaoS5iKmcZ8L+cU1ZdDd
	 3V7x/iXfA+DvultHwpk/j1wIIAA2Uj2fkA6HChhyyx8vuTaZPcUiaAyy9teCztFnc1
	 q6zXWKCSX5gzA==
Date: Thu, 8 Oct 2026 08:40:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
 netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
Message-ID: <20261008084012.53e34d5f@kernel.org>
In-Reply-To: <179141094859.2527009.4935200551311639225@kernel.org>
References: <20261007220311.113827-1-omermetekaya0@gmail.com>
	<179141094859.2527009.4935200551311639225@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Oct 2026 22:09:08 +0000 netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Hi, please answer these questions, and try to include the answers in
the commit msg of future submissions.
