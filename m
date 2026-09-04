Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1214A3F13
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538667; cv=none; b=hu3lSWt4NQXfreG8qSyk9KYhhJQKspvgUVU0jRTGWobvUBVXN0BHSqStaeNOPvTLwRJRcB9dsGB8NPtbLxkfxnG4ESj0vemEBDQYfAEB8MF9NJxxoCaLsI5FivenMf3ZcWjCmW6vrGdeNSJ9IKOcLFEMxKpzpCNLKX0K3NERcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538667; c=relaxed/simple;
	bh=lS1WPM1cOhn1NZBNgcqvynWjVPCzQjkTMIoa1L7JOgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo03paepfqeGOFFera5a21b2tLH5qN6m7WFHI+j0vas9XTbKEHPprUCjs6WPXRRq/sMsnlKEty71AkrgE7HP3OLlbCSh+fZR8vcfcQXNV007FMIjraPiEYH3Je1Htt2LwoxXc/70QkjGby/TbkORK5hpRxWN+A1vo6zVdTnMTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHDu04k0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHDu04k0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4218B1F00A3D;
	Fri,  4 Sep 2026 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538665;
	bh=g5wtoEBGaQ8/eH9rQTWUVIixGGEBjRdYmamMGeVk97g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kHDu04k0nawHyeEgkJe0HLNLYNhCysx2eIeTSVn32qq+aWwrzgn8tWMrGBsnhHEtR
	 LW7R8lbTMlfjB0BBvCuCOiSH6tMlFJr8IKu3849flhXNSQoCUAaqbbHszd7JR3p5Qc
	 RYUX4bF4W1zE48DkGfMCpCl/mqyfbdSA+k2XG83kXfraWI3AukjE4+GaLrC3VK4JHW
	 hPdytr3tPg9f8hrPD5rS27+kBmvTk0PdXHvbtLUQT7p2fxZwk8sta01jlKumUxAAuu
	 JCClyhVMMY0kjJHJvneJt+xO027NeccfAEVFAXsEfBKlvVBafSt7tFfXvtrvm0xLxq
	 nWYUM2TfgZMWA==
Message-ID: <d456834a-3b3b-4c6b-9c36-d71f7faf5d2d@kernel.org>
Date: Fri, 4 Sep 2026 18:17:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [ANN] Containers to run Netdev CI tests locally
Content-Language: fr
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Netdev <netdev@vger.kernel.org>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
 <dc460046-82bc-4c20-870e-716dee54a6cb@ovn.org>
 <e6d815d3-ed9b-4904-8cbe-8e5ee226661b@kernel.org>
 <275ba183-49fd-45b1-881d-0f362b4c74c0@ovn.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <275ba183-49fd-45b1-881d-0f362b4c74c0@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2026 17:25, Ilya Maximets wrote:
> On 9/4/26 4:54 PM, Matthieu Baerts wrote:
>> Hi Ilya,
>>
>> Thank you for your reply!
>>
>> On 04/09/2026 16:01, Ilya Maximets wrote:
>>> On 9/3/26 6:19 PM, Matthieu Baerts wrote:
>>>>
>>>> A wiki page has been added to cover this and explain how to validate the
>>>> different tests:
>>>>
>>>>   https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally
>>>>
>>>> To help developers, containers are now built, packing all the required
>>>> dependencies to run these tests in order to run the tests in an
>>>> environment that would be as close as possible to the CI one. The goal
>>>> is to have an environment that is easy to maintain -- no heavy
>>>> optimisations to reduce the images size -- but also easy to use. In
>>>> short, people (and non-humans) can continue to use the different tools
>>>> as before, but add a prefix to the different commands to execute them
>>>> from a container, e.g.
>>>>
>>>>   alias run="${nipa}/docker/selftests/run.sh"
>>>>   run vng --build
>>>>   run make headers
>>>>   (...)
>>> The headers are not used unless the USERCFLAGS="-I$(pwd)/usr/include" is
>>> passed into the actual make command for the selftests.  So, uAPI changes
>>> will not be picked up.  Would be good to fix that in the wiki.
>>
>> I think setting USERCFLAGS is not supposed to be required for this
>> purpose: KHDR_INCLUDES is there for that. According to the doc [1], each
>> target building binaries should have "CFLAGS = $(KHDR_INCLUDES)" in
>> their Makefile. If KHDR_INCLUDES is not set by the user, then lib.mk
>> will set it to "-I$(top_srcdir)/usr/include", so the default directory
>> when "make headers" is used. It needs to be adapted with building in a
>> different directory.
>>
>> At least, when validating all net and drv-net selftests on my side, I
>> didn't need to specify extra CFLAGS. (I think the netfilter target is
>> missing KHDR_INCLUDES, I will fix that.)
>>
>> Or did you have to do that for a specific target?
> 
> I was actually having trouble with the netfilter target specifically
> as I'm working on a patch that changes uAPI and the selftest build
> can't pick it up without the USERCFLAGS.  But if it's actually a bug
> in the makefile for that target, then it's better to fix this target,
> of course, instead of changing the docs. :)

Indeed, it looks like you picked a target not setting KHDR_INCLUDES :)
Apparently the net/forwarding one also had the same issue.

Fixes have been sent. Don't hesitate to validate them ;)

https://lore.kernel.org/20260904-net-sft-nf-khdr_includes-v1-0-92455af428e9@kernel.org/

Cheers,
Matt
