Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5523A3E97
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542978; cv=none; b=mgPNpwS0Vdw1blsUylDc/GSS0rAIXl01dTRVSkdK0lSejTSlvOsB+V4DBnxt05YNo+v0p/F3cltUqYrD8n98gyoMO7p7t8zohKCQqCU/Lda9WQodgmFtgDkUAvJhkbK98db433YOxy0v/Phq8QCWjbWEHvQQ/xQjbe7bh9dmNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542978; c=relaxed/simple;
	bh=fxqKP5mD6jyMxS9EIijNNzxiP9Djv0Rpi1zOOlnylF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGr310OlgecVCiE1wHNfIAC0Qsi6tvFV2tlEJz/TQ1v0wGLaGmMqWMjkf/ihS36MQotilZ/Clz88zvLdgawdHCnE+GjjCzWKSyyxqfr9h6JpK5vspeG57187zR757lLj0xJc1OB7UxRW5QhtkrJw0eFg6P9faOUiSgpBBe8FAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTHxbqPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTHxbqPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B5A1F00A3F;
	Fri,  4 Sep 2026 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788542969;
	bh=3zxhunDzD83Nu2icpqKCQzMCeOeK90tXTynHVK3ibkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TTHxbqPXHHsZfaVH1+fb7MRA9kp7XNHuMdnyTxKwrwqMglZQw+/HOHL/ivdK4+V4E
	 X2bqWxR1ONBrUhoKEZRf/ZIcGTlR6FaZhekJrtyoRwzB5W7dT42NruJbLuxyRs8ip6
	 wboStkxKelOWM0Uu2ybuunT2ePPruIU0e0EH/yO/AE0WNKAqAQItHCi8V6bt0uAC5d
	 l0hXr8zxDMlfl19bVCNFM/JNpXxOOtYZMOZdV6VMHr4v/1OTEgwuxwifqV/4Uht28K
	 tqBuOKCLQtiVghzobrISrNUJ0pmjgTs46cdP9dFNwTGk2SqcMAKWwUWi0B2VUvqYeO
	 natVQxqw7RlyA==
Message-ID: <0ca86f9d-4ff2-49de-b5e7-c022de8b65bc@kernel.org>
Date: Fri, 4 Sep 2026 19:29:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [ANN] Containers to run Netdev CI tests locally
Content-Language: fr
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Netdev <netdev@vger.kernel.org>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
 <appsQWUIC9-5Nze7@fedora> <bf2cd349-7d1f-4ace-acb7-948dbeada200@kernel.org>
 <apqvJmgi9ZKmDDrW@fedora>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <apqvJmgi9ZKmDDrW@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hangbin,

On 04/09/2026 13:44, Hangbin Liu wrote:
> On Fri, Sep 04, 2026 at 10:33:18AM +0200, Matthieu Baerts wrote:
>> Hi Hangbin,
>>
>> On 04/09/2026 08:59, Hangbin Liu wrote:
>>> Hi Matthieu,
>>>
>>> On Thu, Sep 03, 2026 at 06:19:25PM +0200, Matthieu Baerts wrote:
>>>> Hello,
>>>>
>>>> TL;DR: containers are now available with all dependencies to easily
>>>> execute all static, unit, and functional tests in an environment closed
>>>> to the Netdev CI one:
>>>>
>>>> - https://github.com/orgs/linux-netdev/packages
>>>>
>>>> - https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally
>>>
>>> Great! I've been struggling to set up the local NIPA docker. I'm following
>>> the steps from your git commit description. Now this article saved me.
>>
>> I'm glad it helped!
>>
> 
> From a user‑experience perspective, I think the static tests work well.
> They display the check results clearly and save outputs to the result directory.
> 
> However, for selftests, I do not see any difference compared to running vng
> directly on my local machine, i.e.
> 
>   vng -v --run . --user root -a mitigations=off --cpus 4 -- \
>   	make -C tools/testing/selftests TARGETS=net run_tests
> 
> Do you know how to make the result looks like the CI shows[1], that each test
> has a separate log dir and shows stdout/stderr.

Mmh, I understand the issue, but that's mainly kselftests related I think.

We could reuse python scripts from the NIPA repo to generate .json files
that will need to be processed to be presented in a local HTML page. But
that seems overcomplicated to put in place. At the end, the 'run_tests'
command will output a TAP format, which can be parsed with different
consumers [1] (e.g. tappy) or a simple "grep" command, e.g.

  grep -e "^not ok" -e "ok .* # SKIP"

An alternative I suggested a few months ago [2], is to print a summary
at the end of the "run_tests" command, e.g.

  # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:1 error:0

Can you try it on your side to see if it improves your user experience?

Maybe this simple patch should be taken in the net-next tree. Often,
patches modifying the kselftest framework have to be taken via a
different tree I think...

[1] https://testanything.org/consumers.html
[2]
https://lore.kernel.org/20260625-sft-run-tests-print-totals-v1-1-bfe588266249@kernel.org

Cheers,
Matt
