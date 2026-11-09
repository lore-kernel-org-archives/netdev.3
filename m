Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249608;
	b=elRybMNysYP45UMGUBhD9MNaU8AdgpGLDMHeZ40oXjsDnGYi1o4/Q/0jtICe86h47qoN
	 PM082B+c+Ui5wLzqeXgMRlsNjp7jGSRw+K32ylwauJJ6w4cgRkSLK7CxUS/EYp96z8k5V
	 MbuERuHQqFf6v1QTZQo/3o1Ytw8YbLyg3LCR+dqeEOYSTfH51hIK0p70DXLUA/IV++Ias
	 wZ75dmS12BC4lrk+7D3QoaSqaNV4VJF35Y91dtBosfBXniDlYyAjHGLvxfGio+0aCy2HV
	 +Hlm5gHiMOxqfJNZ7pZQj444A42kkCWR1LGoCB/bBa973c5vuKdkM/tGhhiH8xq7aNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249608;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=S/tP0hOoRooETdvnAz9ewufvkA/svAd+5EIKyBTnWtU=;
	b=EqjDGCnVNB3mb+zJ7Qke4khb9+45RNs9TMn9J/nfs7LEDW2PtrLfqwq42XEm1ES+9PUi
	 DDxWHFffBtP5mpD8pLtLcDyXxF/mf7X5UFYwY/fU4PRrGyDF3kzXAaGbw1CA8eMS5H7sN
	 aNHk6XVcKyhKDjiHhxh278P3zYhNDiE2oHzODsQkcSMf3AbAfyoBs3gCAX+dqzpV6n+M4
	 VSOpCpWNFTrhIw4KUA/q5AOS6/B+cDacmXH3EOjrSkk+gRsAxhr4F6FTZ3A5sKgDQs6Gw
	 GdEqRztlEX1B+GlM8CVhCzCHdprk6JY7Kk4/lwnypppNMiGhFtn3hZTAvICuGCebbzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ekaYZeua;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AEE606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ekaYZeua
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6229A1F0089F;
	Mon,  9 Nov 2026 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249607;
	bh=S/tP0hOoRooETdvnAz9ewufvkA/svAd+5EIKyBTnWtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ekaYZeuaAyjQ1emYDnfWoustyGUPxmO/Gk8CQ4WIfHOWXl8SqyNj11eP9RJQIcw/k
	 t6IpnYMENGn9YLWYq4ZMAFO727n6Af8nUC/DK0+1ig4abjj7KmRb5i/5/lOZ2bi8P/
	 KfMG44K62hBpr/3NCGO1p0qo+T0NW5cpKiN99Uk/Hx8uHnYHS/lhcURrztec9woQmH
	 mFZIFX0rTwfe5vJi8rFmxqKQoSIfV6S/mHHwQoZBRpqp78kM5sPZiwgltxgDXjKpTA
	 GrUnEtgMimu8ECpxMnqs2rdHrgB9XZEzG9e3vSutpuNvw93TD8pxW9/jtGcSaa7OVv
	 ZiWYZ6Az4TURg==
Message-ID: <851b4466-3141-464e-810e-94befcf90286@kernel.org>
Date: Mon, 9 Nov 2026 19:40:04 +0100
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
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>,
 Pedro Tammela <pctammela@mojatatu.com>, Netdev <netdev@vger.kernel.org>
References: <6f0ee3c4-32b7-4422-b69d-c879c94262a7@kernel.org>
 <20261106092441.00cf9765@kernel.org>
 <CAM0EoM=4fNFXaFUV1kh-H9Bdrt_K0yDsbOMJHWpgON2bG-GyEA@mail.gmail.com>
 <ef3ca6c4-57f4-44a7-b44e-f34e06dfb3dc@kernel.org>
 <CAM0EoM=GofsOkOdLv_-xRMRK8u5_E5BSgnqUCUcReZDrKuUEHQ@mail.gmail.com>
 <415e54b3-9bc5-41a3-a9da-3631dcb46157@kernel.org>
 <CA+NMeC9TKz3a=8JYHavHRv2UcM4GxhhnqM9QzzVAu4gKSiz59A@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CA+NMeC9TKz3a=8JYHavHRv2UcM4GxhhnqM9QzzVAu4gKSiz59A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Victor,

On 09/11/2026 18:39, Victor Nogueira wrote:
> Hi Matthieu,
> 
> On Mon, Nov 9, 2026 at 2:31 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> On 09/11/2026 18:22, Jamal Hadi Salim wrote:
>>> On Mon, Nov 9, 2026 at 11:58 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>>>
>>>> Hi Jamal,
>>>>
>>>> Thank you for your reply!
>>>>
>>>> On 06/11/2026 22:39, Jamal Hadi Salim wrote:
>>>>> ,
>>>>>
>>>>> On Fri, Nov 6, 2026 at 12:28 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>>>
>>>>>> On Thu, 5 Nov 2026 11:43:27 +0100 Matthieu Baerts wrote:
>>>>>>> Hi Pedro,
>>>>>>>
>>>>>>> I hope you are doing well.
>>>>>>>
>>>>>>> I'm helping the netdev maintainers with the CI (NIPA), and lately, I
>>>>>>> noticed the 'tdc' runners were often marked as either "timeout" or
>>>>>>> "pending". It looks like this is because it missed the creation of the
>>>>>>> branch which can take more than 2 minutes for various reasons: PW access
>>>>>>> is slow, git push needs to be retried in a few seconds, etc.
>>>>>>>
>>>>>>> I opened a PR to delay the start:
>>>>>>>
>>>>>>>   https://github.com/p4tc-dev/tc-executor/pull/2
>>>>>>> [...]
>>>>
>>>> Good idea, I just changed that!
>>>>
>>>> Please ping me when it is fixed, so I can re-enable the runner on NIPA's
>>>> side.
>>>
>>> @Victor Nogueira  is the one fixing it..
> 
> I applied the change Saturday and it's been running fine since then.

Ah good, thank you, I thought I had to wait because the PR was not merged.

> I think it's safe to re-enable now.

Just did!

Cheers,
Matt
