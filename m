Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95B35C689;
	Sat, 10 Oct 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791618570; cv=none; b=rs7HSSEBjqCDsP01a42oiOf0k3f3Ft3aJW5H1ah2T29mZEseueWg2dVZJW5GN9VHccsKgiyMn0cHfRRxvx7HGE7uSaSYcXZ3NMN/9Hsragp/kcl8AtiLcohz214zuXK0bbe1nrZMPA14vFaO1cNGfJLLRgt728+M7W44Or4LwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791618570; c=relaxed/simple;
	bh=Klv/b8Pwn+UQ6/vgV9gS2oVr25CHb2D8ssMW8T8Khwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTe+IhfyGnozCHZCC2wqrCAyWLKOVIEdl/M5DlKwZYLYpNA3JrqFSJ+avSyEQnArrLgL/7GiaVG0d0R/8TE3x192xIJFwuf5MLopY9zghad14XkgzFKyyiGDJOqn+xsgnxO9qySKP91xJulVAjXGuqCkkTtSRxeyJ3LfOTV7fJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXBWjvUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXBWjvUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD0C1F000FF;
	Sat, 10 Oct 2026 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791618567;
	bh=5ynVKQSt5j+tv0i8SaXGizvaTG/NkoVM6iQofe2hs5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PXBWjvUhladbytSLMwh9PC/wq+rNCQIKJ4AvK3fDNMZwofmWJXbaMwYsczYex4B28
	 9988Srn/fsjN5ibQtJhRgPgUcAnuefpg+oS4RrM35q9Wv2cAiAwzNH+rHhnkq7hzPS
	 ehoIEu8t77lmacTstkFSaP3TlJUdsqVUOB5pnJPgZQU6rCFFOJMH6oKywLaVffHxDM
	 5vZ6Ep5O1UpvGWpQ+rSLqc4XkfUnddGPkbIFCWPtDaw7BFg+NYdJF1MQ5ct2idMR8o
	 OjOMgnNE4qaftOb985z+uhMU0Ed24yoM6ApQBz23iqPOHa8zBLfXbHebgJxUGJg2sz
	 X9Lt+OXa0uUAg==
Date: Sat, 10 Oct 2026 08:49:22 +0100
From: Simon Horman <horms@kernel.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	outbounddisclosures@openai.com
Subject: Re: [PATCH net v2] netlink: avoid hashing the network namespace
 pointer
Message-ID: <20261010074922.GM83879@horms.kernel.org>
References: <20261008011359.63727-2-kylebot@openai.com>
 <179142234633.2527009.9314976849845433713@kernel.org>
 <asbwfr5yXmeOQ-hT@com-75606>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asbwfr5yXmeOQ-hT@com-75606>

On Wed, Oct 07, 2026 at 06:23:10PM -0700, Kyle Zeng wrote:
> On Thu, Oct 08, 2026 at 01:19:06AM +0000, netdev-bot+sinfo@kernel.org wrote:
> > Hi!
> > 
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> > 
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> > 
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> > 
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> > 
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain.
> 
> I have a PoC for this issue, the symptom of the issue is kernel
> information leak.

Thanks for the extra information.
And the updates in v2.

Reviewed-by: Simon Horman <horms@kernel.org>

