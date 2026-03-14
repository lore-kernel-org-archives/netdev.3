Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C82FD660
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504048; cv=none; b=YsAcZYbHsZVSuoAazpGhnQbgWKJt94OWKJe5Xu/AlOgkxZj1ki9iuQL+UwaodY+lSsBPoxVIaMzmOFNiqHZlpa53VbIUINiX+lrLpGy5xlpiIEtOP993Er7hgqvCNmoU4J/aevnwxYsFYLTB0xi9Bju0HSFv29v92/EiCZVbf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504048; c=relaxed/simple;
	bh=gqLWbR9NaIYgp6RVyaSXVbskqC3nMTtE0fryxKC2hs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpAXti++xzpWmPHJJO4QTMy5WuSSX4PEdRHX8eb5nhuUcHDk41b2QRMqXfzKzYCG5sJKKOMBGbUZJ77f1hZAYQmqfN1Fs9aSY30bgo3QoBM3LUHVZ3RhCGzTxtjemq2Z4XjJZsZzVRAM0YkNvGwN96yzzFPVz/CpaUfFa5SCZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXSsHCxP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXSsHCxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31466C116C6;
	Sat, 14 Mar 2026 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504048;
	bh=gqLWbR9NaIYgp6RVyaSXVbskqC3nMTtE0fryxKC2hs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XXSsHCxPTGo7/T8Y+RJ8Ly98krL3Jg7aROTnQ4lGsG0FAWTDs/THTWHaNVuJmxkdr
	 X7nir84HTEw/DnxFvrl2/WHsNqsMsrcPQ8VT3ZvgL+VdKCzw0sIK5Q61+SbpXoYZys
	 DEGNKd/4Jv/ulJpKiwm33Sa3k1AJxYhbG9hxdkA2LVLig4EZmyiAIhKm6UaHR3ywDf
	 SuD5h6f1G4I5usZZaJnd3r9OT5NuLXrIt0jLup7MxfpjeQVy0mKSanYkaQsJSIspBM
	 Qf1SP0URvIr/HWskPX9x9ayoYPKGIfrPHbPFKLO2VSP83I+Kw9/F6wHRb9ycvF77dx
	 C7K4mUBN+hGDg==
Date: Sat, 14 Mar 2026 09:00:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] netem: fixes, cleanup, and selftest
Message-ID: <20260314090047.3461b3a0@kernel.org>
In-Reply-To: <20260314085123.52203ca4@phoenix.local>
References: <20260313211646.12549-1-stephen@networkplumber.org>
	<20260314070902.4025c388@kernel.org>
	<20260314085123.52203ca4@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 08:51:23 -0700 Stephen Hemminger wrote:
> > On Fri, 13 Mar 2026 14:15:00 -0700 Stephen Hemminger wrote:  
> > > The netem packet scheduler is widely used for network emulation but
> > > has not gotten enough of my attention lately.    
> > 
> > There's a few tests in tdcs which need adjusting:
> > 
> > # not ok 363 d34d - NETEM test qdisc duplication restriction in qdisc tree in netem_change root
> > # Command exited with 0, expected 2
> > # 
> > # not ok 364 b33f - NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root
> > # Command exited with 0, expected 2
> > # 
> > # not ok 365 cafe - NETEM test qdisc duplication restriction in qdisc tree
> > # Command exited with 0, expected 2
> > # 
> > # not ok 366 1337 - NETEM test qdisc duplication restriction in qdisc tree across branches
> > # Command exited with 0, expected 2  
> 
> I have a basic infrastructure question about testing.
> Some of the new tests can just go in tdc they are just equivalent
> functional test in different format.
> 
> But some of the traffic tests where it wants to make sure
> that delay, clobber, etc are working don't really fit into tdc
> which is API test.

I'm not the right To: for these questions.
You should really put TC maintainers in the CC list next time.

> And lastly some of the new tests are designed to ensure that
> there is no regression from recursion bugs. Is it ok to have
> a test which might lock up the SUT. I assume syszbot does that
> all the time.

Might lock up when there's a bug or might lock up just because?
Former - yes of course, latter dunno.

> How about I move the the basic "can you run these tc commands"
> into netem.json and leave the shell script for the traffic and
> regression tests?

If you mean adding scripts that have to be run manually - I don't
think that's a great solution. _Some_ upstream CI has to run them.
