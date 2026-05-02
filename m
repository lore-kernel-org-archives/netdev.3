Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B37274FD0
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777745431; cv=none; b=A5cFi79CoMqfFgvMYypfOBgCdKbNb9UB12GYw1rIgKJTHSZhSlBIPK1XPmG6sF2LxfAt4ZhUSMPHRR9j+XEaherHHP/qYQkMjHAzizoYikg9bjPfZaWheJdUZw1HuBiVjBPbvznZIv974WAFCCQ+QqTi4ggf0Qdb8Rb1OOVUsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777745431; c=relaxed/simple;
	bh=GhhyptXKbfjTbh/iaJFgkwgj9UeoMJDy+bHnZWqt8Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxoHrxVVRIRtg4Z2HKqs2q9pjO2rak70EckqfQLCd6LY8eHl7QuqdhjEPlx92HY6fj9+5SbX63gNIjlEiBV4VvRwRVeMa/sgjbQY9y2eqOkCPxuRI5eWOyikLPRi6an6SlzkdliHvMslZeIwIJ3wEdvFu4GvBjhKEt8p0ATU+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyyYaiXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyyYaiXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8513DC19425;
	Sat,  2 May 2026 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777745430;
	bh=GhhyptXKbfjTbh/iaJFgkwgj9UeoMJDy+bHnZWqt8Hs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hyyYaiXh+nra6JwiVSbe9/rXVqcfif3uFAV77CN+aNueVsKKw52Gl+FxjRb2HyWK6
	 ibuiX0Z8Of3IvF1gA2DL9TJ1J3mReFVlCCaukOoQ9DPa6G/gVVSkDuLw6fQX0MZNgO
	 tvIQPPDbhjsvadK8FDsVowLmwwhR7MAQ8ra0azuSitqhJlEbYxIeWvXs76nKL/uer9
	 66HFC3CRS0M1S3UWURjDltMqY0zIm8GLKYCe+mOZy26N2efYXnlDN2W9l2VRKkhG+A
	 Eli/lpfZrZC9S+xWwaiL6j+9H/Qu2em80L/EBgfNnXt2uAINZxW4VTxk1LvaXZlaTL
	 rrZi/sKg+ODqg==
Message-ID: <63c0e51d-77cb-4b05-80a2-adebe3317cd5@kernel.org>
Date: Sat, 2 May 2026 12:10:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] tc: use ll_init_map() only when needed
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260428082851.3240821-1-edumazet@google.com>
 <18134b6e-8944-49f4-9bb0-2903aa00d28a@kernel.org>
 <CAM0EoMmHMMsAbORxETh72c0=CyyAY+PhXReXwP-woGp31YOkHw@mail.gmail.com>
 <CANn89iLTH=_=qYS6RzqpGeCo2FuuVW70h_yRycy2L59G+APiew@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iLTH=_=qYS6RzqpGeCo2FuuVW70h_yRycy2L59G+APiew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/26 11:25 AM, Eric Dumazet wrote:
> On Thu, Apr 30, 2026 at 11:20 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> On Thu, Apr 30, 2026 at 11:36 AM David Ahern <dsahern@kernel.org> wrote:
>>>
>>> Jamal: waiting for your review ...
>>>
>>> On 4/28/26 2:28 AM, Eric Dumazet wrote:
>>>> Some setups can have thousands of devices.
>>>>
>>>> ll_init_map() is rather expensive for them.
>>>>
>>>> Only call ll_init_map() in the following cases:
>>>>
>>>> 1) tc runs in batch mode.
>>>> 2) tc runs in monitor mode.
>>>> 3) tc dumps qdiscs/classes/filters for all netdev.
>>>>
>>>> This greatly reduces RTNL pressure on common operations.
>>>>
>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>
>> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>
> 
> Gentle reminder, this patch has not been merged.
> 
> I have other patches coming that depend on this one.
> 
> Thanks!

fixed the long line length and applied. please cc Jamal on all tc
patches; there is a MAINTAINERS file for iproute2 to indicate who needs
to be added to patches.
