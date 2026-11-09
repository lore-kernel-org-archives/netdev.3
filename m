Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245510;
	b=e0MGiBIMKIY1IPeik6kXPe30/NcR7hiOOH+VuQ2wqwP5al/X+KkU++amZcUcFojOB9As
	 I8QEi41DTlqIR3bmd/B10QsxGUhN+IaxP9+a/v+jckjFuewLzzLIHmSiaBS7riw4JemUJ
	 lrfhlkDRaE9YDGIJHX1JeRA7SDTo78fhbewRjDqXHgxFyhzR7+t2BOLRwzu+XOciHvAbu
	 9ZXeCuQHjvobmCdLeSZ/ipB0qtCYu5BdtIUXV2FxtDXs5/VJw7xW0Vbj/36kYz+TgOD5k
	 Yos6mvZlbi1CzqJLVJ61kZy5U628nghPWaRx8eo5Gdy+ZuXGr/lT3SHqn7ineNqPDTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245510;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iivDdp7Qf0V/j06fkEq8diK5DNsZmEeVI16PsWw3qmM=;
	b=njgTe2olSfOEggXGE0GXJV+I3hmei6AzI2fZl0xmorvKavgXFWVGCjmf6yYTzWDLo1xm
	 47X0/Gy5TeLwfeNOh88SixPARYPtMo9rL4VPFN/80c0hTn6JPnwYgRlL4oTSKwmwIaMic
	 o/KksOmwZD6d4HV8LXQD6JH3Ky/a1VM64YDLDDdZ5C/xMmXMd1E7d5q7UplwyT5HiU+TY
	 l/0H88MVgqFLvrhhLmxe3OuNB/Ynluz9N+RsA/Uklwz26D0Qj5h7Xg7Zw5GHIZFlnk9R/
	 UkD69PdmbAxipqq5OXlio+PH74m78LsHCf3+92j65342KKGYRUGDngpz7yrKuHN5JOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHJjBR6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6F606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHJjBR6X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A946E1F0089F;
	Mon,  9 Nov 2026 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794245509;
	bh=iivDdp7Qf0V/j06fkEq8diK5DNsZmEeVI16PsWw3qmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oHJjBR6XJaN/ysDCsHd9lVK4EYzPHxtTGcr3js3ReijeWw5DdbjuOtAjaEbjne8nG
	 TxsdeZOXYQrWPBLMAAZy2ur5rUyyckCBT3a9Ro6i3m95kgoHdb+C4RGOyhaoQC7uUe
	 6goW9KeeeggGIDl1yQ2og1iZJsphf6RVKLYa03QmOzEYX5S5S1S5sl7haj2lR/MU1x
	 onx0WFsjlLhnYPMSZJbm0/BUCI/dyz9FcoMhrIfQLP+jnQEvQbVJ4oPH2BfFx9722f
	 uv/HlOI23qzX28q+Lj6w7tgwvoFi+GjZyJCATPV0UnxTT4QP47o5rHeaPZ01lPxovQ
	 SprvBm5y+5eZA==
Message-ID: <415e54b3-9bc5-41a3-a9da-3631dcb46157@kernel.org>
Date: Mon, 9 Nov 2026 18:31:46 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: NIPA: TDC: delay the start
Content-Language: fr
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>,
 Pedro Tammela <pctammela@mojatatu.com>, Netdev <netdev@vger.kernel.org>
References: <6f0ee3c4-32b7-4422-b69d-c879c94262a7@kernel.org>
 <20261106092441.00cf9765@kernel.org>
 <CAM0EoM=4fNFXaFUV1kh-H9Bdrt_K0yDsbOMJHWpgON2bG-GyEA@mail.gmail.com>
 <ef3ca6c4-57f4-44a7-b44e-f34e06dfb3dc@kernel.org>
 <CAM0EoM=GofsOkOdLv_-xRMRK8u5_E5BSgnqUCUcReZDrKuUEHQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAM0EoM=GofsOkOdLv_-xRMRK8u5_E5BSgnqUCUcReZDrKuUEHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/11/2026 18:22, Jamal Hadi Salim wrote:
> On Mon, Nov 9, 2026 at 11:58 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Jamal,
>>
>> Thank you for your reply!
>>
>> On 06/11/2026 22:39, Jamal Hadi Salim wrote:
>>> ,
>>>
>>> On Fri, Nov 6, 2026 at 12:28 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Thu, 5 Nov 2026 11:43:27 +0100 Matthieu Baerts wrote:
>>>>> Hi Pedro,
>>>>>
>>>>> I hope you are doing well.
>>>>>
>>>>> I'm helping the netdev maintainers with the CI (NIPA), and lately, I
>>>>> noticed the 'tdc' runners were often marked as either "timeout" or
>>>>> "pending". It looks like this is because it missed the creation of the
>>>>> branch which can take more than 2 minutes for various reasons: PW access
>>>>> is slow, git push needs to be retried in a few seconds, etc.
>>>>>
>>>>> I opened a PR to delay the start:
>>>>>
>>>>>   https://github.com/p4tc-dev/tc-executor/pull/2
>>>>>
>>>>> Another solution is to let the tdc* services running and doing the
>>>>> monitoring themselves. In other words, you need to remove
>>>>> "single_shot=true" from the config file. It might require you to update
>>>>> the NIPA repo you are using to get access to a bunch of fixes.
>>>>
>>>> Keeps happening, I dropped TDC from required runners for now.
>>>
>>> This was an issue related to the indeterminate time it takes for the
>>> branch to show up after creation.
>>
>> Just to put a bit more context, having no results from a runner means
>> the CI cannot validate whether the batch being tested was passing all
>> the tests or not. So we need to wait 3 more hours to get results. It's
>> not dramatic, but here it happens regularly, and it should be easy to fix.
>>
> 
> Agreed - we should have caught this sooner. We basically claim
> "nothing to see here" because the branch update hasnt fully propagated
> (although some of the time we catch the branch propagation)

Indeed. Please note that what I proposed in the PR was a quick fix. As I
mentioned earlier, I think the best is probably to let the service doing
the polling regularly, just in case branches are created later than
usual due to other issues. (But then, it is certainly better to switch
to the latest version of these scripts. I guess the update should not
cause issues, but it needs to be tested)

>>> Matthieu, Victor responded to you; the overall proposal you made looks
>>> good. I don't know how we can fix this, but since Pedro is currently
>>> away we saw this mention by pure luck: Can we change the contact email
>>> address to hybris@mojatatu.ai? That way if you send an email there,
>>> one of several people will see it and respond.
>>
>> Good idea, I just changed that!
>>
>> Please ping me when it is fixed, so I can re-enable the runner on NIPA's
>> side.
> 
> @Victor Nogueira  is the one fixing it..

Thank you!

Cheers,
Matt
