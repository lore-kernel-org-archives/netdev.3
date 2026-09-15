Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23771237707
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438271; cv=none; b=vE+FcMUakkFpOtT4M+RWYv9uGqOMKyX3J/g9IYisnd5Vt59agTqcvx+uPn/j8YOzfpp58vPkhMTyHOJM3hTLqzRa8ljL+ptQ1wkkH8YJs230y/SyBTXPI6ehSPikuJFICQOnQ5OFCtSU5F9jO29PcdQZ+kemgPZRj3lL4oWKF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438271; c=relaxed/simple;
	bh=BAUDQ0X2RQhu4SfCEyJFYaaQo/2zhAf9eD13pb7SKGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTfzv8YIuM8AbQuNDjrqJ48jxWKPxLL6DPuxaIOBmmAdDI1jH3fPx0IVrOS/mFg8R0U/H4SA/4/eTEpVVsquLHCehCnDS4Iv/RlwwkeeIRkvEbUyuLOiBO7apLvKcTXX04HfpzvT8eFv90fiNnw4v6GUuy9aeDX/5jMMqC1s8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AELqkXZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AELqkXZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0331F000FF;
	Tue, 15 Sep 2026 02:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438269;
	bh=i7Lym660i6Tg0E6nEa1sjSiGeqj0B85+fcytfh/YqS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AELqkXZ6fzYDAuMntrSqcPXQIRw6wWHfJBDQITbd4pZ2OWx6N81H7yIG2GrVpMB9N
	 9gPQ4p6K9V6qpnOLbalE6jEgMppgv66X0h9j3EEBdgmx7eftR7c+uKUkpPkcysSybb
	 kgy2NDB89SyelgGYWw33cV1GabCWBEnDLg/U7l5ew3gvk0/+MHlV9pp3gI7tVhxdPB
	 Rh+gYSLYpcIl+bY4ccozITUYT+YcF/8gvLozQ41GHcAuK4WF2Jc8hYIUcbhS/kqbfL
	 Q1W4Q8pgZy5SqOvPwje7ZX0hEyReCCeP2vpf2dVCRIa3qOnNrMWvfK70rrOw+mpctS
	 NyTl3kt15d2BA==
Date: Mon, 14 Sep 2026 19:11:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in
 qdisc_alloc_handle
Message-ID: <20260914191108.55a1a4f1@kernel.org>
In-Reply-To: <20260911133146.3440982-1-victor@mojatatu.com>
References: <20260911133146.3440982-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 10:31:46 -0300 Victor Nogueira wrote:
> This is a less intrusive fix meant for backporting; a cleaner approach that
> uses a per-device IDA over all qdisc handles is planned for net-next.

I don't think this is net-worthy in the first place.
We have a ton of code under rtnl_lock.
We cannot provide any protection from malicious netns admin from
overloading the machine.
Nothing against the patch itself, but if you plan to do something
else in net-next let's just go with that from the start..
-- 
pw-bot: cr
