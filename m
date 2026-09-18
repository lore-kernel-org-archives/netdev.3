Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D250B8D3
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748193; cv=none; b=VL2c75ZSGRafQwl9P7l4scxZRyjxtdsYN+UOSTEmyULzxQkgTGY8BcxDrJUWBKh3SYnrENEqy5vOWyJfnzwGwFPh82D9x+LaskePOMA47yI+B0xYvF9cn0DfQpgyhr+n/sqig+TKUmq5+wWxJBg1nU48vvzWLuHIoz6CCoAX7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748193; c=relaxed/simple;
	bh=V1Vgw189PewUkkXY6PoxTrR+sEzVvdtR/WWvrXH2D5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMuG+VSaQ+cyTup2SAAmV50cO5W5DUWWFWD2U7gJVFAayzqq/mFlZQoY0HMQnP57sYbj2wBlbm6NL7ewtZmyEAQUCcyMe56reKJZH7kaeOnQTNV033Q+wYdvPA9KVjBvdPNFrhG7rPlNqo7jsW9aerEmwpAWm1lkypALixycuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBPY6hWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBPY6hWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1D41F000FF;
	Fri, 18 Sep 2026 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748191;
	bh=6fL7cO5tVIM63eK54R/RaNxjdlVzu8HQPC6LBeqWH7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NBPY6hWpIIh63wlILctVZKOkKUPwh4jN/hvbxi9HlzyZSlGGu+AVbbR3m9GH5k2Fm
	 SkM/hIH1RP09vBUuyvQg6cpwi1hc35Dm9EsChX37XeZ7D6tHP0S/Hjxd09ZpDs3mkb
	 j7lWnCsXkPLoJCFQqkh4RKVryWWu6kvCJ0P+xdD6JO2E4h8yZD3i9TgUCvVoTXc255
	 78zyGxtvamdS03MJojU2k1qJyN0TMiVG6oh8GrsF4YqEnD/aOYh4KcWrL57r58+Q8r
	 +PCzEM5kFz0u+l3ZV35L5C8/rFfdJZKzHdoWlF0Iz29lDeL2ViZbnLKlfkEUhv1qvp
	 ZwRq8DbqaK1Ng==
Date: Fri, 18 Sep 2026 17:16:27 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com
Subject: Re: [net PATCH v2 6/6] eth: fbnic: Handle FW mailbox completions
 flagged with an error
Message-ID: <20260918161627.GV51261@horms.kernel.org>
References: <178942023343.7700.9423398932961964439.stgit@ahduyck-xeon-server.home.arpa>
 <178967953049.22033.7278929297475041564@kernel.org>
 <CAKgT0Ud_RezDQC0PVav6OOX_ha8ErkVMs_SWqn8_Xk5dSUrTzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Ud_RezDQC0PVav6OOX_ha8ErkVMs_SWqn8_Xk5dSUrTzA@mail.gmail.com>

On Fri, Sep 18, 2026 at 08:17:06AM -0700, Alexander Duyck wrote:
> On Thu, Sep 17, 2026 at 2:12 PM <netdev-bot+sashiko@kernel.org> wrote:

...

> The modification this way was intentional. Basically the most likely
> place for us to ever encounter an issue with  DMA is on mailbox
> initialization. Doing it this way reduces the driver init time as
> instead of waiting 10s for the mailbox polling to fail we just burn
> through the DMA failures and get to the result quickly indicating that
> the mailbox is dead.
> 
> Doing the same for the other paths adds extra complexity as they are
> interrupt driver versus the mailbox init which is synchronous. In
> addition at mailbox init we can only have one completion in flight,
> whereas for the other calls we can actually have multiple so without
> context we won't know which completion it is we need to release.

Thanks for responding to Sashiko with your reasoning.

Reviewed-by: Simon Horman <horms@kernel.org>

