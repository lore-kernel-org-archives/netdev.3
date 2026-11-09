Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243487;
	b=cprjUrtvULsC83BKrFG0Z/p3s+E/LADOft2sBuh9E29DZZVSTtd7pTYS/EKhDGzVDspT
	 g5S0CLqv0oms5qF0n0fpcXJ6COvJHkQBTbDO4tBCrLhMa7DUjJAfWnOckf+sjGcG8nsrx
	 Tnq1API/ygWr74BXHItjwHhLGOrvlc+EIT7qKS4KbZyALS/cEhK13fGNG3H3HfJwSrsUO
	 BBwXScdHNVViWtqH3dmI/b+RyyZjf04oA4r5BwtcAXaWknAZ4Wti1nMUXIe6SncBYjeSj
	 wWYJgFy2fHGRfbtiXc2rgSJlaL884OSYaAN2v289e+kEJ9aRCu1z2KLLyQBAfJEDELg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243487;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qTSJoOQNq41a7+ua1n959owhk2NtqkpvVLWZgzjVhXU=;
	b=Vr177XVrMlyngb6zktbSe6ZYwtqwWMcpYoBnGb1ENjPPtrdr2HGOe/tP5BOQa3QBfGIa
	 +v1qChv6DCfeTEZ4MhQLSOPGyjV4ItHWFWpq0ckskzICvA31se+HuRk0tr1ZvX27zexwr
	 igoXXrwHaJ36ZVTTUWLPzUNDx2G5R6y9NIU82g3e8uZexEaHdWDh6sbb6OIlyNAmaCBTf
	 /yW/65suiHzBkJrha4INThSs4upskxMfaVgby6Q6bLRDO1Ib9fFyEzwyWQIs9VK4RmGTC
	 Ewece3F8pb6cwWGVkQP3RkHI/3yfcnDwCN6tO1NcESZdr9Q4ozXzLy6B4SY2AI9JZzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gIi/vBL3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69829606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIi/vBL3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C0B1F0089F;
	Mon,  9 Nov 2026 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243487;
	bh=qTSJoOQNq41a7+ua1n959owhk2NtqkpvVLWZgzjVhXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gIi/vBL3ZZp5OORZUxrhabv9BkjfvlCVndT7vVNjtMksiCShT3NUqqpvCoE5fV61U
	 Qip1oaScNy2PIBsoFLtrBD8ySohYlY7XaPO2/QNRGAWMp8MNG6uHqFCRQJgmFtkKmE
	 53YTw54p08AIbM9CvpsdTxyUpddMk7LsOirebIqzMAT4Lxxiq5jAz0QBdTLV4j/p/x
	 kMlMqsqwYvpom7jkhF11W5+f7FxDpN4iuQYr9qxbNi8fvvdqPFSoYKUZUnhx/2pGaR
	 0ljlm2T7JGON2Ytgzb97gcCvIWCHmGMw+Jz5C74cSnqAHGb8jY0HT2RNrybfrw7uO9
	 i063PsWRlcdzw==
Message-ID: <ef3ca6c4-57f4-44a7-b44e-f34e06dfb3dc@kernel.org>
Date: Mon, 9 Nov 2026 17:58:02 +0100
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
Cc: Jakub Kicinski <kuba@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>,
 Netdev <netdev@vger.kernel.org>
References: <6f0ee3c4-32b7-4422-b69d-c879c94262a7@kernel.org>
 <20261106092441.00cf9765@kernel.org>
 <CAM0EoM=4fNFXaFUV1kh-H9Bdrt_K0yDsbOMJHWpgON2bG-GyEA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAM0EoM=4fNFXaFUV1kh-H9Bdrt_K0yDsbOMJHWpgON2bG-GyEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jamal,

Thank you for your reply!

On 06/11/2026 22:39, Jamal Hadi Salim wrote:
> ,
> 
> On Fri, Nov 6, 2026 at 12:28 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Thu, 5 Nov 2026 11:43:27 +0100 Matthieu Baerts wrote:
>>> Hi Pedro,
>>>
>>> I hope you are doing well.
>>>
>>> I'm helping the netdev maintainers with the CI (NIPA), and lately, I
>>> noticed the 'tdc' runners were often marked as either "timeout" or
>>> "pending". It looks like this is because it missed the creation of the
>>> branch which can take more than 2 minutes for various reasons: PW access
>>> is slow, git push needs to be retried in a few seconds, etc.
>>>
>>> I opened a PR to delay the start:
>>>
>>>   https://github.com/p4tc-dev/tc-executor/pull/2
>>>
>>> Another solution is to let the tdc* services running and doing the
>>> monitoring themselves. In other words, you need to remove
>>> "single_shot=true" from the config file. It might require you to update
>>> the NIPA repo you are using to get access to a bunch of fixes.
>>
>> Keeps happening, I dropped TDC from required runners for now.
> 
> This was an issue related to the indeterminate time it takes for the
> branch to show up after creation.

Just to put a bit more context, having no results from a runner means
the CI cannot validate whether the batch being tested was passing all
the tests or not. So we need to wait 3 more hours to get results. It's
not dramatic, but here it happens regularly, and it should be easy to fix.

> Matthieu, Victor responded to you; the overall proposal you made looks
> good. I don't know how we can fix this, but since Pedro is currently
> away we saw this mention by pure luck: Can we change the contact email
> address to hybris@mojatatu.ai? That way if you send an email there,
> one of several people will see it and respond.

Good idea, I just changed that!

Please ping me when it is fixed, so I can re-enable the runner on NIPA's
side.

Cheers,
Matt
