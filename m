Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2948640B;
	Tue,  6 Oct 2026 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298279; cv=none; b=DqZ/ua8+szVV6/1j98juxrmktECa5HrsVBVLc1nIIgwJbf6YrFfjOk5KMkrMy6u9JC0XsJ61sPzqhgzGBR5DFacAB1fo0rmzfgJSEFR6vVoSo+NcYBBNzIQZjHfcDQuDNxVMytvhqYCWC8MhK9vnbrSGHmGmZ/CXyQxRRKA31yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298279; c=relaxed/simple;
	bh=GDAYyUI3rMNv2MkBOgVk/qSIQaRJvxM/eep9uOqlxYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eptbomyY6EoWTBeRYJcCY/MFCWFZDcRP3rKbI1QNshle325wBUdxDGOxzaWtskK7nil9ZQ4DU1JXQiPQFrzRkYkfUAPC3LVjOISHuf4O0SV82gy0zadX9wJpLCS0arhY7vOH2ff7dPDZ3sKxpJd3qmKk3ZISgtnofLzcZQ48fHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlIdhHfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlIdhHfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C211F0089B;
	Tue,  6 Oct 2026 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298273;
	bh=848H8ANsilipSbR8co5L0rrcOJxeKBEiNkZS4zTJZZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nlIdhHfkQkQ2Tv3dIUTRwL4pKLghRzwja4N5h6DrJTSE/a8opbSgOwBPty3btB0C+
	 WfUWTauone02TufKqTFy8mZ0hf/gwVbR/ykee6jGhYIW9UeFVCyoLOC+6Q53RzA7eg
	 xUcK/EDATK4v1khyFo+1qCSTn3mjvB/LR36LGEtSXB2z9HUsUaQAjoPOjRJ8BI7sWR
	 Ph3VRetDZ8m9o08APkHZXxu7o562owcHKtO5zVG5WiYbQiyNj6Pyu51iyvzqP8Vaqu
	 ZU8ESkmUdA1DEo3hX5FzqmeMmFWSnI85vJLJ+NpVe6jRB4gj2Y+sBGiRTvGoidxKoW
	 gOdTFKqtQ/edw==
Date: Tue, 6 Oct 2026 15:51:08 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	co+2cf741c3005abc20@bugs.sh, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2 0/2] net: team: fix transmit skb ownership
Message-ID: <20261006145108.GH83879@horms.kernel.org>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
 <20261001182326.572045-1-bestswngs@gmail.com>
 <179087933843.1402591.1386346329582858474@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179087933843.1402591.1386346329582858474@kernel.org>

On Thu, Oct 01, 2026 at 06:28:58PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

It seems to me that while a KSAN trace is provided for patch 1/2,
it would be helpful to describe more explicitly a case where this arises.

And for patch 2/2 it is unclear to me if this is theoretical or not.

Weiming could you provide more information for both patches?
