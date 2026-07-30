Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9E3ABD88
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455779; cv=none; b=iBBWdK1i9iXVOB545oGr5rGnazcAECsj88BJ5dAMkFgaTPfaponQL2qko0ZRE7KZVDe2NA71ecKXsrDrIOckWoi7vMHNIRWS9RyuBm9jInMlRl0/rWD/mvl+CZhSdAxmhELeS0fdLYWzvM0fgEFatiatQlEoHbhCcUKsKXWia0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455779; c=relaxed/simple;
	bh=OoIOh6gm9TgLjlLiyhOi+sBJ+y9/e38L4cTym5sc688=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enmT6SWy0ejXRO8hV7Xq/s2lZq2tD74VEtaCAo2x7b1hPJYLtrjAa6brALA9mq9Z8ac61zAJE7futduiEKZMUalWfmE85P5Menpix8Elr8VH74yFMLcPh34b9zlyP5soeswHX+Qk3YMPbxGL9SFlkweHy6e6bM8ZSmwhaHHBP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kH8EMw8C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AA7TWM4P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kH8EMw8C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AA7TWM4P"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CA8821D00127;
	Thu, 30 Jul 2026 19:56:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jul 2026 19:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1785455775; x=
	1785542175; bh=f6qQ9RlK3HDPYsBviKB5Tl2T7qPnd7EnhSGQ89y/pek=; b=k
	H8EMw8CScxBpcs48vu/2BHVrI4iJVHG96lW4JJ278Lz35+UgSJ8O8SyOxFIX9wIq
	/jy/Azz2djfrIY50bhG2WNkKj/rY+nFzgi5KduI9djEmwUIsWR0ZrNYBE/4mlsKC
	EMqKxNXRPRh66grOGyfmNgpW0nZkdD0bMX8SjS7JFRJsukfwcXZgEamFv2CuriGk
	/iS+dZfo9Te2IjXFnsxvAGDP9FENj8SPTvqOViaeE3GcQvLDqhevpmQUWdxb8Iev
	erwEnJUKwTzYUqGfhwvvtVNOVimwRwIih0DBRGfabdUfcFfDROUkLf1sN6/AQ0W+
	SlUaq760mGcteDc7vgn9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785455775; x=1785542175; bh=f6qQ9RlK3HDPYsBviKB5Tl2T7qPnd7EnhSG
	Q89y/pek=; b=AA7TWM4P5mJqq2Ua/i/ihLxT7gbpe8pba2KIw/ALysFHTVAZqK3
	qIaON/nbFr8O6xP5AfiA50O3n5ypqWA6XSvAtxQ2FAUAie7k8Jd5OAHpeFfDwWV3
	Htk/QKi0ybFUwUWmMJ+2QnP50C6kqcUohjP4vQPZuE9ePnOQLBLfs3/BhBRFrDdZ
	c9BMuVYCUHDn+yYWqN8IUOWLjz7aEiGgxWo4ZYJ6GMgj0rCtbhTgctQgk2djQ7y8
	0WLCq8WpfY9vPMX9bZW1rntkunVx3L49BrAlATG2KtSqY8he/JoKCTW6+AxnlNBU
	/9dkT0TnD4b+bilHNX/APfabaF3nvrONKaA==
X-ME-Sender: <xms:n-Rram2bhUn_hiMAak52B_-UBb4HxcpDgkY_yWUkU_rl-GvOmxc4XQ>
    <xme:n-RraoIWbLSwNsSy1oFuSQGKLZRwd9LuMZaXlFKTVLaYopfPX6lJY2VwBD7jCs9_y
    LfO4STbbUUmOiPgJOmyxE6pcxtf4nEm02FVVBbaeGcezdIiD9GMbPw>
X-ME-Received: <xmr:n-RralEfo_11DtoxPVbUtFvq-4Kre9S1Wbas77Rql5-hxgSZkFtJGaNI6Zs>
X-ME-Proxy-Cause: dmFkZTGejty1900lLlGOuXjzuMaoHW05+PwJX1YhckigMghD9qaop7MHxLP6sgjxZ8u0Mx
    +rNfNbcPung2KLP5lFUK5JHyV0cl83bgJcjDYhZbTdokmpaSQw82SBvwHIVZFOOB2X6V0h
    zE+YfJ47wsPckVfxFkXoI9S9bCyaIdkc/z4W5z5RGiUxW8lkdtrGM6HHkGf2bBFp7FVm3n
    aWH7XyDynDwkAmltAdUfUxaUXuzGFD40/aADUsTWqDw13vOUnEx8wa9YJRTg4pDb3Q2JIy
    hNZpc/S4LT4UiOFTRrxmsPJ/jPSiGozJhVeSLAhW1V/51gGPtXfLEQ9cVI02jT7sLBlnLg
    7AC8HnsbkwIdSbb1iy5NEpi2N9d/IHoLTRvbXWmNFQaQJSwMgDyk6QdDmx5OPWBaVDVZXg
    8+s/3fYCxCJhVOorXGjqMUNXJ+dBcM/yRr4Bnre+vxGw5P38jhf8t0lSujvPCl+0Af8/d7
    QA7fdvxnyiEGEn2DIZC3bjBE3qN+zv0rwS0sG6vjJ2itb2mVafjvSRSR8EcfwK8JZputqz
    SJDpRXn2Pu1XKa9iVLvsokE93T+YbK92m6OH/tthr0fQ6J12XiSwG0+IQYrM6J7zno8DS2
    PtHpWNHrQZ+64u2acc5fcCTJIDcghRnXnGKW/aPFrU73BCvdoZgqOYbI4h+w
X-ME-Proxy: <xmx:n-RrakU5LB4byUk5-nef-Ld9fAHige6QAB1Ca5MoWIJp8POFBu5aKw>
    <xmx:n-RratzuIl4IgBMVo35T87EyCFqWyfNmn85RFv8IM0auyjNb222f_g>
    <xmx:n-RrapRZAVNkV8I8SVNQrS6emwr8Ono8vKdtkJxbnTRXq6Q5rAHU6A>
    <xmx:n-RraphsQf2krdNhAWII60qNgZ5q-F5w_tLTdkdXz2xUEUFEN5qOqA>
    <xmx:n-RrahWlPAqEBOR1hIQIROIb_i3RkF3ACiwkWxUobDCcWlNaCqk9zKGh>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 19:56:14 -0400 (EDT)
Date: Fri, 31 Jul 2026 01:56:13 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC] docs: netdev: additional info requirements for bug fixes
Message-ID: <amvknXK480S7zxD-@krikkit>
References: <20260727204724.2787038-1-kuba@kernel.org>
 <20260727152517.312895f3@kernel.org>
 <amgBCpqbkrEIiCuh@krikkit>
 <b39fa14e-1bd3-4e02-8d44-648628303197@kernel.org>
 <amkzn_79gJWAjGEV@krikkit>
 <20260728160820.3860b3de@kernel.org>
 <amtb096CVcSxaXeX@krikkit>
 <20260730135027.6252ed70@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730135027.6252ed70@kernel.org>

2026-07-30, 13:50:27 -0700, Jakub Kicinski wrote:
> On Thu, 30 Jul 2026 16:12:35 +0200 Sabrina Dubroca wrote:
> > 2026-07-28, 16:08:20 -0700, Jakub Kicinski wrote:
> > > On Wed, 29 Jul 2026 00:56:31 +0200 Sabrina Dubroca wrote:  
> > > > If that's the case, good. But "quote this text at people until they
> > > > comply" and "get an AI bot looking at all patches coming in" doesn't
> > > > sound like that to me.  
> > > 
> > > IMO it's really very useful for reviewers to know if the author
> > > triggered the issue.  
> > 
> > People usually add that information if they did. If it's not present,
> > we should assume they didn't, and treat it as belonging to the "AI
> > report/other-tool report/code analysis" bucket?
> 
> The ask is for info about discovery, repro, test.
> The sentence you quoted is about repro, you seem to be talking
> about tool.
>
> I think all 3 pieces of info (discovery, repro, test env) are valuable.

I'm just trying to find some space for bad memory (I still can't
remember to add "CC: stable" to my patches much of the time) and not
bloating the commit messages.

[on the "talking about tool" thing] If the information you want is
missing, handle the patch /as if/ it was the lowest class in each area
(because it probably is). That happens to be (I think) "no repro, not
tested (or just selftests, does that deserve a mention?), found by
some tool or human code review". That's why I mentioned "tool".

And I think they kind of mesh together. If it's been discovered with a
crash in production, it's "more reproduced" than just code analysis,
but actual reproduction for testing purposes may be impossible without
hacks. syzbot has probably generated repros for issues that will
rarely be hit live.

> > > Also, for downstream backporters it's useful 
> > > to know in case of conflict whether to invest time in resolving
> > > or the patch is mostly theoretical and waiting until next major is fine.  
> > 
> > For downstream backports, there can be a number of differences that
> > make an issue either easier or harder/impossible to trigger. But sure,
> > that's a useful baseline.
> > 
> > 
> > If we could reword the statement to include something like (with a
> > formulation/presentation similar to your patch, this is a short/ugly
> > version):
> > 
> > Fixes should describe if and how the issue was triggered/reproduced.
> > This information should describe how likely it is to happen in real
> > life [stuff about delays/fault injection/etc].
> 
> Here we'd ask the author to judge likelihood. Which is hard and takes
> effort. My goal was to ask for pure information, no thinking effort.

No, sorry, this was meant to be a reference to what you wrote:

    The reproduction should state whether kernel modifications were
    necessary (e.g. inserting a delay to widen the race). The commit
    message must disclose if error injection or loading a special
    kernel module was used to trigger the issue.

> 
> > If this information is
> > missing, we WILL assume the bug was found through code analysis
> > (whether by human or tool/AI) and not actually triggered on a live
> > system.
> > [something about such patches being penalized in the reviews/queue?
> > I don't know]
> > 
> > 
> > my concern about having to add a bunch of uninformative text would go
> > away.
> 
> I feel bad enough accusing people of using LLMs (even when they
> _obviously_ do). I don't want to accuse people of not testing their
> fixes based on information missing :( I'd rather first ask them
> to add such info explicitly and then shout at them :)

Then they can add the information. Their LLM will probably generate
the things you want if the doc says "patches without the info will be
penalized". (or they'll start claiming it's been hit in production? I
don't know if those things are good at lying. but the humans might, so
I could see the drawback to this idea... or the LLMs will burn a
zillion tokens to generate a reproducer?)

I don't think "Found while reading some code. Nope, I haven't bothered
using fault injection to try to trigger this." is valuable at all
(other than maybe saying "I found that without AI!"), and I'd prefer
not having to add this/not having to read this in git history.

(I've probably spent more time arguing about this than I'll ever spend
adding this stuff to my patches :) Well, not if you count the times
I'll have to send "ugh sorry I forgot again" :))


> > > I'm also guilty of not adding "impact to the user" info, but that
> > > requires thinking and theorizing. The ask here is to purely state
> > > the facts.  
> > 
> > So just something like "possible UAF/memleak/deadlock/some unwanted
> > behavior" is what you expect here? That's totally reasonable. I
> > thought you meant something more abstract.
> 
> Right, my patch doesn't ask for impact specifically.
> But the direction is right - ask for info the author already has rather
> than require the author to theorize about likelihood and impact, or
> do extra experiments.

Agree. I just misinterpreted what you meant by "impact".

-- 
Sabrina
