Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D333E368;
	Fri, 10 Apr 2026 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775864320; cv=none; b=d7vrzc5r5b+GvPEKl7lWad0bECBdQHJaMWxdqAg3huYdBSfk8frjBflSi/EqZ7+kosoDdrn0/9MnHTaUTcZmPn1c3Jj7AMBu8BdkXSjduF7APHXcNu65cHvuJshjpDVPu2Z8GYcqLPiJltQHWhOmqY5dK5jZ6i2z7LlVkPPUMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775864320; c=relaxed/simple;
	bh=2lY2cPva3CKc/NxtQaKZ+pj/giFWfBa29trZfe13XjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZH9tizz/wLNhJIr2m+6FQ2rIrBYX9emMeE62UUrjOl0sF7Nr7PIXEoeGX+FeGdsHrPHSsPNB2ltSvX+vtqwQTIB2/f6sRHdwrhWZCAZ1oaD+XwahQ1dbtH+GUf3VvR0GJaKlUFXqGI2P2ROFaJDGq+qgD0ZclLblvJ9nZBEzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org; spf=pass smtp.mailfrom=blemings.org; dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b=QQ6LDQnW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blemings.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b="QQ6LDQnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blemings.org;
	s=202501; t=1775864314;
	bh=0D/b94zewInA5OowtofcLef5XWAwRXC9yiMoOg2ndJI=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QQ6LDQnWk2WrijFDd+nhNxQ8VSF0rxfTa0vj4RpCGTa3CgrnjOC5v+HanSCe0P82I
	 QjziEqNHepz8v1CKKPLO7TktBA6beERO32hxVshrFKLBIF8Ju+CVQuh6bBRrZ92AnT
	 u761nD3zWXYDFJ3c/XBn4lpsvt0PnrudN6mZ1aCj0nqf7qMSv2WNIrWCtkwg3gBAnX
	 BvyYXb9frbJy+04wTUj+QY5Ge4Yxi0LoKzMnaWqoXTje/CG6dp17WgU1hzpTMlJ9li
	 fUQvifGvyOYNQai0hNkrGp7JL8IcjnorOisg1BKdxc3t0HR0cgeWq4QhHczUJubYXP
	 qlRKMj0CVbqdQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4fstXm4rrsz4wTc;
	Sat, 11 Apr 2026 09:38:32 +1000 (AEST)
Message-ID: <91d50a72-a121-4b24-a559-892f8a3b3c3a@blemings.org>
Date: Sat, 11 Apr 2026 09:38:32 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: hugh@blemings.id.au
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming
 frames
To: Craig <edfardos@gmail.com>, hugh@blemings.id.au,
 Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
 horms@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org,
 workflows@vger.kernel.org, yizhe@darknavy.com
References: <20260410145448.38253e3c@kernel.org>
 <20260410221220.1708137-1-kuniyu@google.com>
 <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
 <761f83cc-58eb-4b4a-ba91-d11412e7b2a6@gmail.com>
Content-Language: en-US
From: Hugh Blemings <hugh@blemings.org>
In-Reply-To: <761f83cc-58eb-4b4a-ba91-d11412e7b2a6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/4/2026 08:51, Craig wrote:
>> If the main concern here is ongoing maintenance of these Ham Radio 
>> related protocols/drivers, can we pause for a moment on anything as 
>> dramatic as removing from the tree entirely ?
>>
>> There is a good cohort of capable kernel folks that either are or 
>> were ham radio operators who I believe, upon realising that things 
>> have got to this point, will be happy to redouble efforts to ensure 
>> this code maintained and tested to a satisfactory standard.
>>
>> Or, alternatively, as a technical community it may be that the Ham 
>> Radio interested folks conclude that out of tree or user space 
>> solutions are a better way forward as others have proposed.
>>
>> Give us a few days, please, for the word to be put around that we 
>> need to pull ourselves together a bit as a technical group :)
>>
>
> I, for one, really can't imagine pulling an entire network subsytem 
> out of the kernel without any
> knowledge of how/if/when it's used.  Like intercontinental radio 
> networks, global email, ax.25
> keyboard-to-keyboard, BBS and other emergency-communication systems 
> throughout the
> world.  If you're sure the Internet will never fail, I guess it makes 
> sense removing all of this
> since it's inconvenient to maintain.
>
> Global AX.25 keyboard-to-keyboard on 14.105Mhz
>
>    https://qsl.net/kb9pvh/105.html
>
> AX.25/netrom VHF routed networks spanning from Oregon to Los Angeles.
>
>  https://www.easymapmaker.com/map/80666c4898ec6e8fa0c35add5d03282d
>
> Global radio email using AX.25
>
>   https://winlink.org/RMSChannels (1,336 AX.25 email packet nodes on 
> the Earth and Space)
>
> This is all in operation by Amateur Radio ARES emergency 
> protocols/technologies.  This
> will not pass the headline test when it comes to Linux detractors.
>
> Most of this is running on Raspberry Pi / Linux 24/7.
>
> If we want to kill all these apps and somehow force them into user space,
> it's akin to just switching to Windows - and flounder with the 
> Microsoft folks
> trying to do the same thing.

Your email Craig neatly encapsulates just some of the practical and 
ongoing applications of the kernel code in question - I don't think this 
is in dispute.

What's pertinent is if we as the ham/amatuer radio community can agree 
on whether in tree, out of tree modules, or a userspace device driver 
approach make the most sense.  If we are to keep code in the kernel in 
any form, we as a community need to find someone(s) that have the skills 
and bandwidth to keep the in tree code up to date.

I don't think this would be onerous and I have a couple of people in 
mind to nudge who may be happy to do so if that proves the right way 
forward.  At a pinch I could do it, but that'll mean a lot of catching 
up. But I think it reasonable that the responsibility here falls to 
folks that are closer to the code in question than the wider and 
overworked kernel maintainer community.

That said, I think Dan Cross (KZ2X) earlier email makes a pretty strong 
case for moving out of the kernel while still providing a way to have 
backward compatibility, perhaps this might be the way forward?

In any case, done well, this approach would not kill the apps or force 
anything like switching to Windows! :) Great projects like digipi would 
be able to continue with minimal changes.

I wonder if a separate thread in linux-hams makes sense to discuss the 
various longer term approaches to maintaining these capabilities - I'll 
try make time later today to kick one off - such deliberations will be 
of less interest to the broader LKML and other lists.

Cheers/73
Hugh



>
>
> -craig
> https://digipi.org/
>
>
-- 
I am slowly moving to hugh@blemings.id.au as my main email address.
If you're using hugh@blemings.org please update your address book accordingly.
Thank you :)

