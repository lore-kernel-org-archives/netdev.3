Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3403BA24E
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267380; cv=none; b=nxwhNwHvFwm7GRqrk6fYrzZ7v+gSRIww1AFDmyW68Niu+DqvbfJlzMXjnOJjb9Uzf7BGXGq9chsmdSwBPT5WwXgioKe0K9sQsp8tpy8+SKgFaHSDyO9zLa0dVr9BWxUeAWPtWmTOpXwjzNLdRsohBBZFOouoJFyeOntzJG6KLyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267380; c=relaxed/simple;
	bh=BEhdrZwxZdDWdjSIsYqTdIFrwOotOwqe2M1fDVQCDqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJ22ZRcnILljf/qF73BvpIPY7qZc9Ivn+Gre/69XBr1w/Tbr+kyuHPq/XQE595xP9pJ4JEqr7BpUr5G0Yidh+lf7fVPaO7Oe8bA66YPIO9Fle+wNkyxlE8H8J10VKslUAfCQI98T88+Bxk8ycKQ465rQpNHU5QsiXTtPWfZms6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbzHmsQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbzHmsQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1141F00A3A;
	Tue, 28 Jul 2026 19:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267379;
	bh=dPGfnwpx2CJoVmaMlZIhc/IhC6oxfjACnNu9IK+CvSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NbzHmsQe8rML9TCr+TCCk+Kyob8hjqHdkzoT9mo8Zgogi3UwvRRa85wxTCqnJUe5K
	 NZedMQPXATWLFeprTAI6quLVfDy3FdraaG/A6E6p1FiK5qiRzy9WZ3ahJghqDcfeGk
	 PBIRJYhahxwdJumy460gGluhodNgaiEuC2IkAM4TJbsmxj8j1Ku7PrGzA/l87bChUs
	 S3HE7FlyWQWSyof1FLLANqLz5iNlWNQEB96nNGOGqIPoqSS87wCGbC+JAw2rsckI1L
	 crqGKkWwekdY88T/Ti/AvNBw6Xz+ZPOEZLZaDUX1YcPyi8+sWTk83/KZpXSGW0STS6
	 hl0P55BsGKSFw==
Date: Tue, 28 Jul 2026 12:36:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [ANN] LPC 2026: Networking track CFP
Message-ID: <20260728123618.490c0aa4@kernel.org>
In-Reply-To: <6600b656-58c1-44aa-a839-b0e87b6eec18@redhat.com>
References: <6600b656-58c1-44aa-a839-b0e87b6eec18@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The submissions to the networking track of LPC will close tomorrow
at noon Pacific time! We should have pinged last week since the
official deadline was last Friday. Since we didn't we'll give everyone
extra 24h to submit.

On Thu, 2 Apr 2026 08:40:12 +0200 Paolo Abeni wrote:
> We are pleased to announce the Call for Proposals (CFP) for the
> Networking track at the 2026 edition of the Linux Plumbers Conference
> (LPC) which is taking place in Prague, Czechia, on October 5th - 7th, 2026.
> 
> LPC Networking track is an in-person (and virtual) manifestation of the
> netdev mailing list, bringing together developers, users and vendors to
> discuss topics related to Linux networking.
> Relevant topics span from proposals for kernel changes, through user
> space tooling, to presenting interesting use cases, new protocols or
> new, interesting problems waiting for a solution.
> 
> The goal is to allow gathering early feedback on proposals, reach
> consensus on long running mailing list discussions and raise awareness
> of interesting work or use cases. We are seeking proposals of 30 min in
> length (including Q&A discussion). Presenting in person is preferred,
> however, exceptions could be given for remotely presenting if attending
> in person is challenging.
> 
> Please submit your proposals through the official LPC website at:
> 
>  	https://lpc.events/event/20/abstracts/
> 
> Like last years, we have separate tracks for BPF and networking, please
> submit to the track which feels suitable, the committee will transfer
> submissions between tracks as it deems necessary.


