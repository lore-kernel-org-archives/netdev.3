Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F94CC272
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533669; cv=none; b=OiYhweOWzBlwu8kMOkCnBa2Wze4UTPgho4xeiIPAIcsFCY1qbjyIbWVYz/bgXgSP06ne/YHyd8LqPMVjSbf/UR46V0O76hguY/OstfOFjDgdPxnjleDX5HX7gfg3k4Y1DempqlR/ey/ABeNhENkqnFsWuP1N955CvpW5730Qa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533669; c=relaxed/simple;
	bh=WITSlxx171TpJ2umw3EDl1yKAvT7BZ4268uyQXszAd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Id5ccZAd0cwvHoR34VuH01eLaKmix5jak6vFcHjDZAIPutLGbEh0hpTO6U+FVxaIaBZ4Oe6W/32VEXYHScBEJvdgs4SFq6A0SowpOESpZU96P96mvFELOWEl0miLk/fL2EGr5Ut+E/nWHEhuKjfxOOpA7geLZwu4qK6NkaqKNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeVsf0HA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeVsf0HA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FA31F00A3D;
	Fri,  4 Sep 2026 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533667;
	bh=yi9/axqm6i3UeGr7m/v/Qr8R0Y+FK5okS/oATO7fYcQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=jeVsf0HAhi/5piREET6fPVzUhDB5rFVJTCxO5EwfQl/bRQg0qBZjc0FNPG/1UHWfD
	 3ngsSpL1Qw3iZa3SLP6WpY2PVAxkUMiVC0ZY6gyt/oa25PQCdzDFO39x02L6Su6vX4
	 Rw/WfR3ELla2SlqbgoENZr+MNcW+8shdNsNkeejDykWazQj/zmuaBb91SvgahscQpi
	 rEEPfeSclLTOfcGxhk7Rw7sSML63xrq7O2iiAEIF/WgZ6vk2hShBhBkCQoo/Wf8sZS
	 z45xJXPlhRP20HSp8ggabXt2KsLWU97XtHzWxl33boz/8daRC0Mvh62msRIUBf3DZa
	 1S00Tzx8Ml99Q==
Message-ID: <e6d815d3-ed9b-4904-8cbe-8e5ee226661b@kernel.org>
Date: Fri, 4 Sep 2026 16:54:25 +0200
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
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
 <dc460046-82bc-4c20-870e-716dee54a6cb@ovn.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>
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
In-Reply-To: <dc460046-82bc-4c20-870e-716dee54a6cb@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ilya,

Thank you for your reply!

On 04/09/2026 16:01, Ilya Maximets wrote:
> On 9/3/26 6:19 PM, Matthieu Baerts wrote:
>>
>> A wiki page has been added to cover this and explain how to validate the
>> different tests:
>>
>>   https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally
>>
>> To help developers, containers are now built, packing all the required
>> dependencies to run these tests in order to run the tests in an
>> environment that would be as close as possible to the CI one. The goal
>> is to have an environment that is easy to maintain -- no heavy
>> optimisations to reduce the images size -- but also easy to use. In
>> short, people (and non-humans) can continue to use the different tools
>> as before, but add a prefix to the different commands to execute them
>> from a container, e.g.
>>
>>   alias run="${nipa}/docker/selftests/run.sh"
>>   run vng --build
>>   run make headers
>>   (...)
> The headers are not used unless the USERCFLAGS="-I$(pwd)/usr/include" is
> passed into the actual make command for the selftests.  So, uAPI changes
> will not be picked up.  Would be good to fix that in the wiki.

I think setting USERCFLAGS is not supposed to be required for this
purpose: KHDR_INCLUDES is there for that. According to the doc [1], each
target building binaries should have "CFLAGS = $(KHDR_INCLUDES)" in
their Makefile. If KHDR_INCLUDES is not set by the user, then lib.mk
will set it to "-I$(top_srcdir)/usr/include", so the default directory
when "make headers" is used. It needs to be adapted with building in a
different directory.

At least, when validating all net and drv-net selftests on my side, I
didn't need to specify extra CFLAGS. (I think the netfilter target is
missing KHDR_INCLUDES, I will fix that.)

Or did you have to do that for a specific target?


Just in case, here are the recommended commands to execute to run the
selftests per target:

    alias run="${nipa}/docker/selftests/run.sh"

    rm -f .config
    config="tools/testing/selftests/${target}/config"
    run vng --build -v --force --config "${config}"  ## + debug

    run make headers
    run make -C tools/testing/selftests TARGETS="${target}"

    run sudo vng -v --run . --user root -a mitigations=off --cpus 4 \
        --rw  --network loop -- \
        make -C tools/testing/selftests TARGETS="${target}" run_tests


> The $(pwd) part is a little tricky since it will be resolved outside of
> the container.  I didn't try if that works.

Note that in the container, the current directory is mounted at the same
place. So $(pwd) can be used.

[1]
https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details

Cheers,
Matt
