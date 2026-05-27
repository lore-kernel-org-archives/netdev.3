Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E3219E8
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923238; cv=none; b=e7X53ehFuVdhY9qYHwv9lzniquC3TnSn3AYKkyPQ4i7HzKH+D5RL4R7DvGn2tTAlhmBltNnJDx7Mruwm+afoHPN0nnrNbhqhoZRQ+E5tugyH+imzalCHaI+cQv8s4TdZjCoya12eRhstEbyMCyx8vZk1LTMfDdGuiJTIbyICzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923238; c=relaxed/simple;
	bh=W6obAhP6PCYR5rhunNCnMBDk3RscY52AknMeg6sxGyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVt8lbQDcT/yLaiG8je/M5JU3vwROTTLPXiDuQgcCLhhOZ8UaLYODUSENCswTpvSAK1L7D7YdVIx4khrFo28i1uUufLWQjyiEnnpeBfK/5zeI+UIivswTeN3i6j4YdrQPtRD620PHTqfFXjN9r3LOwnABOs9WrjPiO8sHey84wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgjTHk0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgjTHk0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D011F000E9;
	Wed, 27 May 2026 23:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923237;
	bh=g88PR7qF3idSr7KQdx9j2J5RWimgQFtsq87ECfgIZs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CgjTHk0ScNaGILOAqahyeIfWxgB9waARhGzKkarQseznQOGZTJMqoEonV6ZUGkQVC
	 cSb/C2mKR5IOXVgOBS7+TkyLrQ/wRuJyaUF29AHcY6hoLAwDKHwg5MY7miVdy1M1C9
	 RcIaHhCSST7zpuhA0LBzH1tqE4Pu2xNdxwhvCeV29I4/Se121dp/JGnS6fvyz0Dro2
	 CFdaVdfqxImsP4/rmxz4TfYUakK3/FQ2qLnFwr5vvSWPqbQ0qo9r1Fob7geQDlI2ku
	 e1ua3aQFZ0tmbw2sfxdXagYUIcWIoMOd4nLo1zMDzMcoHPI0ClGWySOPKaDv2TXTYB
	 X5xR0Il5fv1ZA==
Date: Wed, 27 May 2026 16:07:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Ido Schimmel
 <idosch@idosch.org>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260527160716.147e240f@kernel.org>
In-Reply-To: <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
References: <20260521135310.GC977@cmadams.net>
	<20260526175743.1f2c3761@kernel.org>
	<20260527010641.GA21073@cmadams.net>
	<20260526183122.348e44e7@kernel.org>
	<20260527215135.GB16443@cmadams.net>
	<675083b4-e015-4ff3-836c-798e0a971194@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 23:59:47 +0200 Fernando Fernandez Mancera wrote:
> On 5/27/26 11:51 PM, Chris Adams wrote:
> > Once upon a time, Jakub Kicinski <kuba@kernel.org> said:  
> >> Sounds plausible, pretty sure we knew this commit was risky to begin
> >> with, but we had no direct proof that it'd break real life users.
> >>
> >> Revert is the right course of action here. Would you be willing/able
> >> to send the revert with your problem description and a Fixes tag
> >> pointing to the reverted commit?  
> > 
> > I did want to add a little more test note:
> > 
> > It's definitely an interaction with NetworkManager.  If I stop NM and
> > run my VM start/stop test, nothing unexpected happens after.  If NM is
> > running and I do my VM test, when the next router advertisement is
> > received, NM replaces the privacy addresses.
> >   
> 
> As someone that is experienced in NetworkManager, I can confirm it is 
> related. NetworkManager is querying the IPv6 address and when the 
> connection is configured with ipv6.ip6-privacy=2 (prefer-temp-addr), 
> NetworkManager creates a route to make the system use the temporary 
> address for outgoing connections by default.
> 
> If the order is messed up, the address picked will likely be too. One 
> could argue that this is partially fault of NetworkManager and that it 
> should check the timestamps or preferred times rather than order.. but 
> well, the rule is "do not break userspace".

Right, plus the justification for the change wasn't very strong 
in the first place. My internal compass is still pointing towards
a revert.

> I hope this clarifies things.


