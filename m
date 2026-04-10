Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C637EFE3;
	Fri, 10 Apr 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821154; cv=none; b=Mcl1jQn3qX0xgRxmqfNJg3na62TnlnGRGfOnXSoquyDI3UU2enTpBtO2mkPfBpUh32O/QOve696FGcc5BsnDuad6IOGAwlnnTMOByVrzsYmlX+yTD8h2iaHSQ8groPWobmopLjhHe+cUz/2igs8KgMKm3pdiuqkO7vVXn0tge9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821154; c=relaxed/simple;
	bh=J6BP64+ovqcApdlO6UD29z7w6NRSJGoJAqCMVat2BMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbHOHRWVbLZ7r82R63nVnRs1Gg2vIoKddCJ1pYBH4S4QkruHr0KJDAG5ffZiXJDb7cGhs89ZjVTi/MQ5o7D+D9/yQAR+u/d3fPL4ApCWePB9MrE+ETtQUQeID0N3P5yG3rf4ykUNYSk4tqzLkvDPGtlAMgqqvQGX2xcvid243oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjPC8B9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjPC8B9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C8EC19425;
	Fri, 10 Apr 2026 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775821154;
	bh=J6BP64+ovqcApdlO6UD29z7w6NRSJGoJAqCMVat2BMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjPC8B9nzKdPmUxA2gIKfJhU91HvCr8JLLyo2/+Eyhz5fe/33kkLznaeEN6ZgvTQA
	 QLZRSlIEoL9+Tyi4Y3mP6/QGac4gxcsKpc41bJJas/pyoHvj2tKJC3RIRteu88ecrx
	 TOGIhy7RX/i6JK8iiuo2xtR03xSyBHCm3wBY8xLcoCd5Pek3e7X3wuujw7nEpdT6lc
	 mic4xZ9c25Le0yzPIU4yWLuI+SB3uYGL15dzuSjk1P0rgdd/0ZilwMqgQMbt3MstXT
	 9j33NKdCYaDG0nUCKspj2M4z1N2J8OJEDJwhd80V/SgbkNvrJ3o3n7G8Z1znd6XUm3
	 3wDesgf4w/5Hw==
Date: Fri, 10 Apr 2026 12:39:10 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 5/8] net/sched: netem: batch-transfer ready
 packets to avoid child re-entrancy
Message-ID: <20260410113910.GU469338@kernel.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
 <20260406172627.210894-6-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406172627.210894-6-stephen@networkplumber.org>

On Mon, Apr 06, 2026 at 10:25:13AM -0700, Stephen Hemminger wrote:
> netem_dequeue_child() previously transferred one packet from the tfifo
> to the child qdisc per dequeue call. Parents like HFSC that track
> class active/inactive state on qlen transitions could see an enqueue
> during dequeue, causing double-insertion into the eltree
> (CVE-2025-37890, CVE-2025-38001). Non-work-conserving children like
> TBF could also refuse to return a just-enqueued packet, making netem
> return NULL despite having backlog, which causes parents like DRR to
> incorrectly deactivate the class.
> 
> Move all time-ready packets into the child before calling its dequeue.
> This separates the enqueue and dequeue phases so the parent sees
> consistent qlen transitions.
> 
> Fixes: 50612537e9ab ("netem: fix classful handling")
> 

nit: no blank line here

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

I forwarded an AI generated review separately.
Because I couldn't convince myself it wasn't valid.

...
