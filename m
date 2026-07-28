Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27493644C6
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255453; cv=none; b=mj1MoQA/JrbdyC+zdXd7npCbzTXbtwX/VREZIs+DmJGqWzqGoFxvlnYzpE0TQyImDgq2ysBt1L/0uZp9B9tv+JGLeQlHv8NdI1Dx3lnmaJ5OMyFMdGpfyGg2lSTbvGOSDec3ivEUPBFElvCcXa3oxeZTc+rZ9gwUgtqo1rIypfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255453; c=relaxed/simple;
	bh=Jl2S5Nrzb1p+RgZeuCHn2OI7/B9RrRI05wiyW6MNm3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZfMNgJDumZFJgDeFO4X686nRSeV57HoDaQXceoy3okGNaRNDhNEaIRZmnM4PvC7ZRUzUjsa2wkLKPuMCMP/cVdlrn0pz663+ZX373A9LSemnv9I1A7QQOSwK0yov+HpLqH8gu95Hg2CKHIuHPGYQS6Hm7YqRdUpelq5dHvVWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIGUqnH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIGUqnH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A511F000E9;
	Tue, 28 Jul 2026 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255451;
	bh=tPLkJo1hZ0lZvLFmnE+Tqc0StknZQeTLE/WDQ5uz+1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FIGUqnH4AZfjQxDZadGXG12QNtOIXqhF/pEttJMqcn3Y9fbJZ7vDzy3pDVZ9XtJBt
	 36fEDm2KJNB2tV4Rs2dfpUc0c/wrc+NAD3tgQs7QZJNMp3xjKuj/rr113Nw8XL+f9G
	 AiYeQp9d0WASBp4GBHrXfD/RDXiIChBr3yLna+LgKMAEc2/9U/Ggm/mFtNzCVBXNg2
	 PpHWz36DgBc1kcGIdq8679PUckQZElRYHO++dNq+pfbRF8dGhEZ7lojhtruUeyNmLj
	 8SsVe20VXZePn5lcgy9FHrtFr20hsjjA/Cp5/Org4T/hsRl7VRQgmuoBK7xqx6lb3f
	 2mQoxar8xvbOQ==
Message-ID: <b39fa14e-1bd3-4e02-8d44-648628303197@kernel.org>
Date: Tue, 28 Jul 2026 18:17:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC] docs: netdev: additional info requirements for bug fixes
Content-Language: fr
To: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
References: <20260727204724.2787038-1-kuba@kernel.org>
 <20260727152517.312895f3@kernel.org> <amgBCpqbkrEIiCuh@krikkit>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <amgBCpqbkrEIiCuh@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sabrina, Jakub,

Thank you for the patch and the review!

On 28/07/2026 03:08, Sabrina Dubroca wrote:
> 2026-07-27, 15:25:17 -0700, Jakub Kicinski wrote:
>> On Mon, 27 Jul 2026 13:47:24 -0700 Jakub Kicinski wrote:
>>> +All bug fixes must clearly state how the issue was discovered and validated,
>>> +and how the fix was tested. This should be done in plain English, not with
>>> +special tags or annotations.
>>> +
>>> +Example statements describing discovery:
>>> +
>>> +- discovered by a non-AI static analysis tool.
>>> +- discovered by an AI code review agent.
>>> +- discovered by manual code inspection.
>>> +- triggered during code development.
>>> +- triggered in CI testing.
>>> +- observed on a machine in real use.
>>> +
>>> +If the issue was not observed in reality (e.g. it was caught by an AI tool
>>> +or manual code inspection), the next sentence should describe the
>>> +reproduction. The reproduction should state whether kernel modifications
>>> +were necessary (e.g. inserting a delay to widen the race). The commit message
>>> +must disclose if error injection or loading a special kernel module was used
>>> +to trigger the issue. The reproduction steps should be included in the commit
>>> +message if they are short (roughly 10 lines or fewer); longer reproducers can
>>> +be posted online with a link included.
>>> +
>>> +The testing statement should explain whether the fix was tested against the
>>> +reproducer and against kernel selftests.
>>
>> We should probably also add that the commit message of a fix must
>> describe the impact to the user.
>>
>> FWIW the intention is that we'd either quote this text at people
>> until they comply or even get an AI bot looking at all patches coming
>> in and deciding if commit message is good enough. With some tuning
>> LLM should be able to check that the 4 items are covered.
> 
> I see what you're trying to do, but making regular contributors append
> 2 paragraphs to their commit messages (or ask their LLM to generate
> them, and also fight for an hour to get a reproducer that actually
> does something) just to check the box seems painful. Reading the git
> log with all this stuff mixed in will be worse.
> 
> As someone who's probably never sent a compliant patch, and who has a
> tendency to forget new rules (especially those that are inconvenient):
> meh. I don't think the commit messages we've been writing all this
> time have been so bad.

Are these rules mostly for new contributors using AI to generate
patches? I guess regular contributors are already applying these rules,
either by using a Reported-by tag, pasting a call trace, or describing
how the bug was discovered, no?

I find this important to understand how the bug was discovered, and ask
for a reproducer or another sort of proof when this is a "potential
issue found by an AI code review agent". Otherwise, that means the
reviewers have to do the validation, which will certainly take them
longer than the author to generate the patch.

I don't think regular contributors have to change their commit messages, no?

> OTOH maybe that's the only way to handle the volume of AI slop
> "fixes". 2 more paragraphs when the commit for a trivial 1-line fix is
> already 2 pages long doesn't make much difference.

:)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

