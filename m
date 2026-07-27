Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D32E7390
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142470; cv=none; b=NHhnfykTACQizsqS5m/frq8XXc3MP/NP3F5pMMf5GpNygMb09wd3lSq3jsiYMtF/Wtw26C16ZlNjB0PWo/TjopQprFvnFGpahs0k+G4gW2R9x1gcqS8eDUQknIVkJeAQqNYzwDmcmw99GZVYH3BbEfIWqw0ZA8fSCMNI1T5U29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142470; c=relaxed/simple;
	bh=ULq/kSzjheGweecV12Gw62bj6IcMm9gGOzY6cVx0Ua0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/J4KCtuAaBxUqVfAo5Iq2LFzSqHn0hemDR9/VX2vfKkf/ah2+BaqpUlcjrBSkHI48MCXp8jtl4/az7zejMYhKPVab0CqewsC/2JFFUWZiJBlSwnhvsewXLNGQ1t+TL5ZEnPrmc/KSmfc7pwzsyKUxCCuVfC0cDCLNQ/vhWFx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7wM0TJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7wM0TJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB32D1F00ACF;
	Mon, 27 Jul 2026 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785142469;
	bh=kHTPAOVQWinbhFXxBDzqMaptukAQIttXbok1Cgi+38A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H7wM0TJUg3UaazkYyL66OytGvTefpmK3pL9vRhRGwLFhkd7hKMj7Y118qaNOaUhx9
	 SeLN5lTEK5ZOLXt/zFlAHG9Q0j82X+Noj5OrubfE9Ug+L7fTjluQEdfyG1EYhao1s2
	 wVRcp5CXaWLPcX1czubPpDsJYjTCrEokgAOOfxC2NCQ96pQKSuE1q0YtIjjT9OeSWJ
	 2RKfOBFRB5WQ/0stfSpjlLComLcoP4xzX4IkD42nGi6gLt75bX1SzswoU4TKQa+zcB
	 AkIjtPiZca4VKmvhmKqussaVCAEhWS+/FPVTwEqp46uCENGL2iG6SOi+8WGV6uQ7XH
	 4EleqqvN2d+mw==
Message-ID: <668c6399-0507-479a-94a2-870de5a23739@kernel.org>
Date: Mon, 27 Jul 2026 10:54:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 2/2] docs: netdev: clarify expected interactions
 with LLMs
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1784884817.git.pabeni@redhat.com>
 <83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
 <CGME20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7@eucas1p2.samsung.com>
 <amNS9/owsgr44v7w@AMDC4622.eu.corp.samsungelectronics.net>
 <68b50e02-c238-48c6-b2aa-98eb21077329@kernel.org>
 <c5df2708-22d9-44de-a67a-4a68f2b091a7@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c5df2708-22d9-44de-a67a-4a68f2b091a7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2026 10:24, Paolo Abeni wrote:
> 
> 
> On 7/24/26 3:39 PM, Matthieu Baerts wrote:
>> Hi Paolo, Jakub,
>>
>> On 24/07/2026 13:56, Jakub Raczynski wrote:
>>> On Fri, Jul 24, 2026 at 11:24:05AM +0200, Paolo Abeni wrote:
>>>> +both use the Sashiko infrastructure on top of different models. Reviews are
>>>> +available after 24h. Patch authors are expected to proactively look into the
>>>> +AI-generated reviews and handle such feedback as any other kind of review:
>>>> +either debate it or address it. In both cases a reply on the mailing list is
>>>> +expected.
>>>> +
>>>
>>> Would it be reasonable to implement automatic response from Sashiko to
>>> mailing list? Some mailing lists (eg. dri-devel as far as I have seen) post
>>> all replies from Sashiko to thread, which is imo not bad,
>>> although it could be filtered by High/Critical severity.
>>>
>>> What do you think about potential for similar solution on netdev,
>>> since AI review has become 'basic' check in patchwork?
>> I was thinking that too: it would be easier to reply to the comments,
>> and help the authors to remember about them. That will not help to
>> decrease the traffic on the netdev ML, but it is also possible to
>> configure Sashiko to email only the authors:
>>
>>   https://github.com/sashiko-dev/sashiko/blob/main/docs/configuration.md#email_policytoml
> 
> One concern I personally have with the above is that it could turn the
> ML in an public automated AI review tool, definitely flooding any
> eventual good contents.
> 
> In any case this discussion is IMHO quite orthogonal to the
> documentation update.

Indeed. The current version looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>>>> +Authors are strongly encouraged to run LLM reviews on the posted patches in
>>>> +advance of the actual post. Large series triggering a significant amount of
>>>> +AI-generated feedback will likely get little attention from maintainers and
>>>> +reviewers.
>>
>> If Sashiko emails the list and/or the authors, it would be good if this
>> note is added to the emails, not to push people to abuse the public CI
>> and AI resources.
>>
>> On a similar topic, it might be interesting to mention SUIE and the
>> scoring system. Or mentioning that sending multiple untested versions
>> will move their series to the bottom of the queue.
> I have some doubts WRT setting in stone (in the doc) the actual patch
> review order or an explicit "sanctions" system. I think the patch
> wording allows for more flexibility.
It makes sense. But at some points, I think it might be good to clarify
that sending multiple "untested" versions is not acceptable, i.e. the ML
is not a public automated AI review tool, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

