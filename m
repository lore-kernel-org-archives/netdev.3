Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEDC34F279
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949339; cv=none; b=qJjKsQKUT+25Bkh3dJDXb4anLeoqmlAqVlYRS4gFTWxdHMJZh+oFjiOK9KhFodGBGe0v8+TLsR4MQS66x951w2awR3zHJWj//P3xfeHiIMf5tOG8qad00C5N+mdFhhQXnRCFfJNX4D49TofzyBSHiLnCktIQ1mQa/DzadMXYFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949339; c=relaxed/simple;
	bh=1b8UQp41EYD2vYRDb3bSd3eZMbetw6qmeon/gCRnsOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wh3ZTfZZlmhArO/oq/js3cdchDC3SXDUws4LQ6JuqF5cIXm1AHxskFeShkQBdU5UeccNvF3pSUCSHwE4j87VSDUz1RgBPyZcXddrL3p7wypZ99gxTbzRGsr+z3M13VZB0kkKjH01Itz8KA8d+uLzDWf5nle/js3AhFeNfnKK6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVFzx5Sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVFzx5Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAF21F00A3A;
	Wed,  9 Sep 2026 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949338;
	bh=dB5iq8In3GQkvDhmH4S7ASCz4nF+Cg3Wzas+iCBsjGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mVFzx5SgF8EdPOnWA4Sm1VctixKPsSBoYDIU6b4LG9xCcGDG488xvZVtBQvXV2AgT
	 un6erw45uY33o+DmJV18kuQJ9TooDaT5dP3+I9ajD+Qr4HpuVTBfSW4sp8CmzsfpOT
	 A7ETc6duBA1fgp7zVbUCoJHupllsMW0EKZz4NmqDLbKaP6wSWbX847uf1UUbK4LHcX
	 0adKW+C57NMhnpa54b73cZl4lPLsxvSgnQS6yLjwsKTltc7WUmy4vkR7w92jBH+x09
	 Y2y+q3jmX+FJS5bUOTAgCNg5LzaPO9EBHd9upDGWKR4S56BjkG6vP0/mxgw9b+PT+L
	 0BNImliHKnJvg==
Message-ID: <6d53e8e5-96a3-462f-97d7-722e1b9f8f79@kernel.org>
Date: Wed, 9 Sep 2026 12:22:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: Some clarifications on the upstreaming process
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
 <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steffen, Paolo,

(+cc Pablo, Florian)

Sorry to jump in the discussion, but I have similar issues with MPTCP
patches.

On 09/09/2026 11:23, Paolo Abeni wrote:
> On 9/9/26 8:38 AM, Steffen Klassert wrote:

(...)

>> 4) Some patches for the ipsec and ipsec-next tree don't get Sashiko
>> reviews either because they don't apply to net or net-next, or
>> because of some other reasons I'm not aware of.

From what I saw, sashiko.dev tries to apply patches on top of the
correct tree by at least looking at the modified files and the
MAINTAINERS file, and possibly the prefix [1] from what I understood.

For example this recent patch [2] got applied on top of 96f01b53c2d0,
which corresponds to today's 'ipset' tree [3] (tag: ipsec-2026-09-07)

[1] https://github.com/sashiko-dev/sashiko/issues/48
[2]
https://sashiko.dev/#/patchset/migrate-state-fixes-v2-0-c3e2767f0d96%40secunet.com
[3] https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git

For Clashiko, it only tests what's for net/net-next, same as for the
selftests, etc. if I'm not mistaken.

>> This is the biggest
>> issue, I see the Sashiko review only after I sent a pull request.
>> This makes the upstreaming process complicated and delays fixes
>> quite a bit. I requested some infrastructure from the LF to get
>> this fixed, but no answer so far. Any other ideas how to fix
>> this issue?
> 
> I think are 2 separate points:
> 
> 4.1 missing sashiko reviews on edge cases
> 4.2 difficulty to reproduce the sashiko/clashiko review process in advance.
> 
> WRT 4.1 things should generally improve over time, with the exception of
> patch that do not apply. I think we can't do much for them, but they
> also should not matter much, right?
> 
> WRT 4.2 the current guidance is to run AI reviews before submission.
> Sashiko could be installed and run locally. The nipa instance (clashiko)
> is slighly more effective than sashiko.dev because it runs several
> recent models and its result are indeed hard to replicate locally/in
> advance.
> 
> Clashiko currently runs on (very significant) meta-sponsored budget, I
> think it would be hard to extend it's usage to netdev's subsystems.

We might need to find a solution for the subsystems for this 4th point.
I have the same issue with MPTCP, and it seems it is the same with
Netfilter (and likely others) from what I saw. I would prefer to have
Clashiko reviews before applying patches on my side: to reduce the risk
to deal with new issues later on, and to let the author dealing with
that (instead of me days/weeks after).

From what I understood, Clashiko is still being tweaked, and that's the
current priority. Maybe later, subsystems can have their patches
reviewed by Clashiko as well?

If that's a budget issue that cannot be solved easily, I wonder if
Clashiko shouldn't ignore subsystems patches: I see its value, but I
also see the cost for the different subsystems :-/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

