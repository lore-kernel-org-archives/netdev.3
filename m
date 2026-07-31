Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150A3B4E8C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490981; cv=none; b=kqgZvFpCB9mGf6C56q/qEcFWHKn+8dRj0BXkOjg2bHSTxfYSqqz2zzLGIhvSKTk8TIFc8TVM8LZxKbnZRLCIV0zYM194yyErsOkV23hhWeGZifjQTpmrz8scBmqOHNlZwjCgpso0y9UsniF0xQKwgXGWzjLLSo36MbtuGos1iec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490981; c=relaxed/simple;
	bh=+5KbLAgsr484mrs/2xnyHAbASASnNmYePbOsbFUAfZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubrtLCXU+nPA76lFTGDNZJ2bcsPJGUhIuAH/Y2ZIbaY43NVWRYJK49apT1fFc/Zn5WfGGgjms5JaUQWOhSKGv40fYSFi6kmymKEhJ7cPkyicpWWL1whNUx9L5VbFFJ7XnuTSCVfghZcHdF8/d7vuKBtj4UW6IYPl+kotj8TfV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NgFwIegI; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NgFwIegI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s90I95cqWZRNcWn4F20gIgV3rAltWyRXWysS8MQwPcc=; b=NgFwIegI/FEtWXDV6wKlsOMI0W
	p4H1KFlu4DgeQn/aLXa9RIkKqGEdc1ENltCJsc2Ugndc4LZ1xICkMMBcR7pSjLNImEC9aRCctZWCa
	8f+xOwVHg1XW2lkiKIPyIlCEmtpjHCD2zQ/kvQe9QA608+AheY681YAxTenGXYFO5Y7ZUedJZ0EZg
	7LlmHJU2KTV0byaUY79BucPkSQaE3TlhRK7xw7MTnmKx+tSW6nVX/FG8KzGh1F01nVjmGjeCA24sQ
	1sLeRv63t+O0okdQSzloZl7/HNcfAnaDtYKZJKUrV10furURDwk8gB30JDdA52Z/+9Xy257nCNDXM
	BXqKsRSQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpjlR-009v53-2m;
	Fri, 31 Jul 2026 09:42:50 +0000
Date: Fri, 31 Jul 2026 02:42:44 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	Rongguang Wei <weirongguang@kylinos.cn>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Joe Damato <joe@dama.to>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Chenguang Zhao <zhaochenguang@kylinos.cn>, 
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v13 2/5] net: wangxun: add Tx timeout process
Message-ID: <amxs3A1lC7ijwE8W@gmail.com>
References: <20260731061837.12672-1-jiawenwu@trustnetic.com>
 <20260731061837.12672-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731061837.12672-3-jiawenwu@trustnetic.com>
X-Debian-User: leitao

On Fri, Jul 31, 2026 at 02:18:34PM +0800, Jiawen Wu wrote:

> +	netdev->watchdog_timeo = 5 * HZ;

Is this needed?  netdev_watchdog_up() already does it, no?

	void netdev_watchdog_up(struct net_device *dev)
	{
		if (!dev->netdev_ops->ndo_tx_timeout)
			return;
		if (dev->watchdog_timeo <= 0)
			dev->watchdog_timeo = 5*HZ;

