Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABB23EAAA
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684121; cv=none; b=mSAcwTFqS1Xp/yaOSWMtQSM3niVmli5+dsrS4pT/fYLXKKwIYnR/rC/mVv/o+G8ewMpsMJBpSKWZF42gVFfOWSahhNpxkQ4wpQVVvXaQnFX6UKcO4Ji3h4Kw8cXAXP9y7pEAS8vXovAs85slhWRtPDwNAZ+4Wj1f6SqOzAScerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684121; c=relaxed/simple;
	bh=EVddpeTgM/HpCNw2l6UpEh+upuzQpghioF82iUe/+ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8Uxudj0UxPJS/I48wAyjCoPY0pOvIMKhe7eWpqTkPWaGQIxGdzqUPfAq/0/uxRNl1OhL3SYXwkhRw5V5l7B1NXNm3JpyitAWYHsXrNTGdZi3TsXzcrD27uLRhup+5eSZdN2xBcBCgLI8X7uWmiFu5dYzpvDKdok0lOKwWfc1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpXr4S4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpXr4S4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C950D1F000E9;
	Tue, 25 Aug 2026 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787684119;
	bh=3k1hKTehrUpVvtiwu9YTDweDyGAdzznlCuy7rBA31ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fpXr4S4P3Wc7hixNMvMcZVyBiOqSCdoP+kJRPAmluH1PFHnDBXvn7ZT2QNBYGxT7v
	 X251aoeqjUGYnJQAIDrGYIYjKQlr8EEfnYL4+cgAiMAkHnYQ7tuFsxAsV253R4M6gj
	 dcbvsBxouWo9VNjE/0mSDZtRAa+kQwx0X53xoXqeHVnX4ykbbRXn0dyUz2lzRO1Q4/
	 NSa2Ejz7OKo97+8xb/ld88BofSrdU4T8adFb+DYFM07FbZkI0TINbutWKdB9m9MpgO
	 xKP84Fv5agF9omLSexZnrATk5/I4RcXWiHkAY2YelAoQ2TXPmJ0NZvVsIXdNcK/xbo
	 Rd4e7UAwyCBMg==
Date: Tue, 25 Aug 2026 11:55:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "edumazet@google.com" <edumazet@google.com>, Boris Pismenny
 <borisp@nvidia.com>, "kuniyu@google.com" <kuniyu@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Message-ID: <20260825115518.2b925e90@kernel.org>
In-Reply-To: <7bddbd246387fe4dfdc1e638b50d44a73aecdc83.camel@nvidia.com>
References: <20260822225524.2328465-1-kuba@kernel.org>
	<willemdebruijn.kernel.1157fb673940e@gmail.com>
	<9d75871db36b1801eb381f5445c10fd29e2ad8a8.camel@nvidia.com>
	<7bddbd246387fe4dfdc1e638b50d44a73aecdc83.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 09:52:09 +0000 Cosmin Ratiu wrote:
> Option 1 would be to only set req_qid on _changes_ (edge transitions)
> and keep it 0 otherwise. Also make it mean queue = req_qid - 1 to allow
> the use of queue 0. Ideally, only the first packet in each direction
> would have req_qid != 0. These packets cannot be decapped and cannot go
> through HW GRO, but all subsequent ones with req_qid == 0 may. dst_qid
> is of course != 0 in all packets and is honored.
> 
> But then you need to make sure those packets aren't lost, and maybe
> retransmit req_qid until it gets received. I thought about it a bit,
> maybe using TCP acks as an indication? Or just trying best-effort a
> couple of times...
> 
> Option 2 would be to just disallow HW GRO with req_qid.

I'd go with Option 2 FWIW and revisit it later if we find out that more
NICs need some sort of workaround.

> And option 3: sport selection to get the desired RSS result makes this
> interaction non-existent.
