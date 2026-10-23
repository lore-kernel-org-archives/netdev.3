Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780209;
	b=SFZIpsPJxI86RoGwWRaq13MPMADcEsCAh91jeUFD8fMfh/tmlufmP4AQTtqUP+t/Zl0T
	 /LRHzbP37IfmHLAY23wChQLewrKQ4oO/+j/5VKfuxCi8idbMvAnQp6jauX9YQmqOVoggR
	 uNPjnBlJWyRezS8vFzY2yW/xK9naPci86FK5mB/+pfPmT6BAtLRnM4M8AUvkYdMpTPqee
	 BRcD9ICZK4SjZ40lM9TyJz5WQAYcNsKjmtuR0V1oHvFxm8OT9E9QbmTGBr0jfFnWx0/oo
	 CRXB0uZy6m10CQeMngJtHEjJcoH1QBmz2pTNzhAigHyoqljGZE/JP4pcZW/Hoam7MVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780209;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Content-Language:Subject:Autocrypt:Organization:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=RJHkW4P9rvkXZylcA2oob1/AdCb9LZb0okom+sgf/YU=;
	b=t7HJXyGvylJ1fx845gHFzphFhc9uc70gv48zETa48Gk83GkdgiczA7D0WV5CBLENStZg
	 COhdMQEsP/x+OpGs8MH7RkEcY9t41uDeokbUZEnNlK0Ahbd57D9n8836/mRbGB2W+t3+J
	 38i0EfmM8zB3HZhw8ZgihK/BoSUcR9K156taGuQSo76J/N4uOhl6K5AiW5Qgi2mH/hSXp
	 fVwKjOeS/xqrdiwXWpiQT85rulXw7AUnj6aHSGuuE7xCwJApu043SWSaLdhiJuxAxrIFA
	 I+SJwQ7/JWfqjiW4C23ODPNd1VaKSun63sCt/4o2qnwhYGgOMuzir/XOYBqY5+hqW7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LD9lu6+i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980FD606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LD9lu6+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA291F01825;
	Fri, 23 Oct 2026 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792780209;
	bh=RJHkW4P9rvkXZylcA2oob1/AdCb9LZb0okom+sgf/YU=;
	h=Date:From:Subject:To:Cc;
	b=LD9lu6+iDYTy6LzHTmhGSOEm6GsciXTF/2G6u9334wT7tNjA64f6f1ckxkrCGV02K
	 f/fjKECHJNzDYmaVKneL+THL+0jOovw8XN6OJNPmcswFMfUtv9PXLVptRd4XdTcPi1
	 IdOIRvR1H5xI7GZe+vBCXDuQTtctjGbzEPJoWt0cy3sHkYQgUNsQWPDwLLrkiStQAo
	 i/ocGZSj/kAXHS8RoygobRkNY5NK5gbyri7ml3uCNT8tlxJOHodCk7kMfcT+yKBXtN
	 r3AokgN2zcjHK5dQwW/rZ9hp/aqyKwYna46Gv9b2Qp5EqS3oxSP58bRHHQ32yHAj7B
	 S5kGezp5bCp0A==
Message-ID: <5aec31d5-d042-4263-b3df-fa5a6a1399ec@kernel.org>
Date: Fri, 23 Oct 2026 20:30:06 +0200
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
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Subject: [TEST] Intel's Netdev-CI: a few flaky tests
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
To: Adrian Pielech <adrian.pielech@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>
Cc: Netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Adrian, Przemyslaw,

I hope you are doing well.

While looking at the results on the Netdev CI for the Intel runners, I
noticed some tests are quite flaky or constantly failing. I marked them
as "ignored" on the Netdev CI while this is being investigated.

 https://netdev.bots.linux.dev/flakes.html?tn-needle=intel&pw-y=0&br-pfx=net-next-hw

Do you mind looking at them, please? :)


Regarding tests that are constantly failing, I guess you are monitoring
the results, and you noticed that gro_sw.py is failing most of the time
on XL710 (i40e). If it is normal, it might be easier if you block the
known bad tests from running on your side. Note that around September,
there was a split of gro.py into gro_hw.py and gro_sw.py:

 https://netdev.bots.linux.dev/contest.html?remote=intel-i40e&executor=i40e-XL710-Q2&test=gro-sw-py

(gro.py was failing before)


While at it, some tests running in our lab with Intel NICs are also
flaky. Maybe that's due to the same issues?

 https://netdev.bots.linux.dev/flakes.html?tn-needle=netdev-(E810%7CX710)&pw-y=0&br-pfx=net-next-hw


Thank you for your help!

Cheers,
Matt
