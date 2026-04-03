Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B3359A6D
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250046; cv=none; b=FCWVMYXkl9/9TjxSRsXBu5pKCF5bz4oXF5IiP07hhUXfgjk1vWq4+iJTTFOfBUU40jFwdUCZPDdYdFOW+ovcVzJpb3Ex9nKQor/WKuH1ZyIF4ewyxHPRRY8CIVTrmRrBrSVVuz9zljvU4WwTM6SgDyGmIWeQc0jucRzDNnp73D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250046; c=relaxed/simple;
	bh=XPKE9366I21wKdn9VkP0f4AJzYuYGZTwQKTuEYgVFS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEtejDZ9iLjv8ALN0Fxo47azBwBRznIHueMAvQoJ+zomggmf1qh/XQUxzgtc5NQqSbw7X5A5UwIG6psufj07BbHMRt15aZ8E7cH79lUc9n5JvH2hseRqlbzAB6JHfHpI+Yn6mepPQVTw90K3HTottGbRGP5CdYOkf5soPE5t9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP7DrXQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP7DrXQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE488C19424;
	Fri,  3 Apr 2026 21:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775250046;
	bh=XPKE9366I21wKdn9VkP0f4AJzYuYGZTwQKTuEYgVFS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qP7DrXQGUSfM7XFWiFiGpv/+yO8RI/Gb3pVbO8T3pyu7ztGv4Ac4BWB8VRhSdN7L/
	 og8zOB8MEDhIo3g0wVUSkEyytD1JETH/qPTBWYLqFiKp5ChrGinUVcoeH2JBIGuRjE
	 CQs446PsE9PGKb+KigJE8HmY4WVTVMNp3fKXcC3i3y2sHXSk5Cjg9n1TlLn219o98Q
	 nDy5mZkYPv2fn05X/MBs9PGHP/HjTwayYgXZWidMVeUv+q6TiwrIygDykmtRlF6fPY
	 1+vR95cScpL8e7qLmG8l8WYng8qzqEK6DqC2e7+Ig9zY8d33GVdI0P0DStSvkAOfMI
	 ZqyuJOvxurGJw==
Date: Fri, 3 Apr 2026 14:00:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v3 0/7] net/sched: Fix packet loops in mirred and
 netem
Message-ID: <20260403140040.7aeb565c@kernel.org>
In-Reply-To: <20260403120354.6e926c05@phoenix.local>
References: <20260326181701.308275-1-stephen@networkplumber.org>
	<20260402131618.21624737@phoenix.local>
	<20260402174906.0ee218f2@kernel.org>
	<20260403120354.6e926c05@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Apr 2026 12:03:54 -0700 Stephen Hemminger wrote:
> On Thu, 2 Apr 2026 17:49:06 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Thu, 2 Apr 2026 13:16:18 -0700 Stephen Hemminger wrote:  
> > > Why is this marked Changes Requested.    
> > 
> > Is this a question.  
> Yes a process question what is the blocker? What needs to change?
> More review?

I think what happened was it was posted at the same time as another
series for netem and made TDC fail. Then Jamal said something which 
TBH I didn't completely follow so I left it as Changes Requested :S
Imperfection of the maintainer, I'd say :S

Please repost if the series is good (presumably once the other
series you have pending for net goes in?)
