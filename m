Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204652F6931
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434664; cv=none; b=fjVz31Nx1VJTnku6g1Fs+FVzRQ+nuR0l1/BOBRp+sbtUZxYqNDly2jdsH39SgrGF6vcFvMXyPk2UEAm6eEkuuhIPZaPIfanYS21I7bNEBkFYAZwv3tipZAw2025bumipm8bDlduGRXfFDlZWZYpUxASJNR94u5ghJ3bzqLa6BAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434664; c=relaxed/simple;
	bh=207W1+rTsYC5kTUHb1twyIx3nnLOYKr3uJzMkZjmqEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1K9m6yHF/dkNXpSTPUDo/vmDPVuPC6aUlBxqIAno6umrT5tu7Xa3V9oVtaB1NCmvs0aqUbQvEEk7kN6Qops3IAOef9OoWbjsa/0Ok2y77LDG97gJaeI6xu4aprfn/exrhMyT0U0V2Gb4ZXkmiEzdpxkYy8Dvl+39MGWzdJi2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS+wTp/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS+wTp/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656231F00893;
	Tue,  2 Jun 2026 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780434662;
	bh=1S5Qy5LiZAtTQ/GWIprciFLm9LRuLR6crDrT+UJfqXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nS+wTp/jpTCDQM4/x0oD2VrwNqdQEBd8LcwlOon1f9pRM41BxeWojNcYo8CXjjg5W
	 g6FQzidFb3SZv3/lo2zxdLNHhoFrrgvGRe0Dt7qR9NuwyElUYQ9E0l2eLpq8b2R7nK
	 QtSqYvTFxupLGxG3WtyAHT7+BxhkjH9liEDiqGP/C5toC5B8cT2w5Xv5xixZagNM50
	 b3JQ0b8fnuNzGtJRGbXdhjtCrTEK3vO8jPW/e2e6ENd3Y1t3EOjM4RvNCCacEGgim9
	 XLL4ZOpOxsoDguZwTwiF7skmBUsawFxgYH61wtWoiYdPFAwFKPcsyaiHzYaLE7cpHt
	 SPaGhQcOtUi8A==
Message-ID: <32c20500-8a76-419a-ab79-5ec68d2de6df@kernel.org>
Date: Tue, 2 Jun 2026 15:11:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20260601143242.6729-1-fmancera@suse.de>
 <f97592a2-6690-4511-a98c-dacdeedf6516@kernel.org>
 <bc71f624-e4ce-47b7-9dae-13ad0db76ad1@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <bc71f624-e4ce-47b7-9dae-13ad0db76ad1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 1:46 PM, Fernando Fernandez Mancera wrote:
> On 6/2/26 9:36 PM, David Ahern wrote:
>> On 6/1/26 8:32 AM, Fernando Fernandez Mancera wrote:
>>> Currently, modifying IPv4 interface configuration parameters requires
>>> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
>>> ip-netconf exists for monitoring these values, there has been no native
>>> way to set them directly through iproute2.
>>>
>>> This patch introduces the support for that via 'inet' at the 'ip link
>>> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
>>>
>>> Example to enable forwarding on an interface:
>>>
>>> ip link set dev enp8s0 inet forwarding on
>>
>> If an attribute can be set this way, then ip link show needs to show the
>> values. What's the plan on that front?
>>
> 
> I could introduce it in a follow-up patch. I guess it makes sense to
> introduce it for ip -d link show only, right? I am happy to work on it
> anyway.

yes, -d only.

Will give Nicolas a chance to review.
