Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EC2F25F3;
	Tue, 11 Aug 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433235; cv=none; b=nbXebxElN7hG4787U+m3LUfXzNm58a+A8ATjTz7wUTo2VjKuhFW/RDT2qO1P4bCxtq+j7By/xuWhxdTYnaUrX4lsdy2YPVHQxYPfH39g4KH11aij4lXOJQflz/LUXIWGZySlLjizvinnfYQ9076QF3KaRrmyzpMyWTd9zVpE8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433235; c=relaxed/simple;
	bh=XaaLc3Etazh3IfSjf3Ph4ISxECQ69dzvv2/t4G+mqAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hi2Ikl0A7SBw0nwEtJPTQ9KmhtDOSwU6Pf/ARH9bvArMMc4nkzrQTP8gzlSusQ8iBJg2ExYhKaE2WRXSoOXEJcFESnsraY5+1uNOOIx2sP5npQMipf66g3wrwVjanJ0GRC+08JcgCA6I9LLCauCX8IVaQ87F48YwD2sqMp9+lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVWwXsgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVWwXsgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0821A1F000E9;
	Tue, 11 Aug 2026 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786433234;
	bh=YA1aV8qm0WwaJXH6VgSEnxWWmRWkil287/c9v26zVjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OVWwXsgbnEnf1AL4bmpZilkotWNOLrU3G9zO5JQMQePk9P7udiRtQ093laBXM9xXi
	 QqSF+RYmahVu0kypSzO6ufPnY4Q72roSdvNLk6pbL8N3inPJ3l9X6BnGFEK9opZ1vQ
	 CfAWMAtkPFRxUOScIKveKjOH7V/PH74levybUNn5SKOcA9x/P57qrIk4LZrs+Ddg9C
	 l7ifRHpmR4D6/pK397MeKZpga6qB3Gl8B+Uoz+KrP3+KOR66L9wdY3m/XP7OTkAtSi
	 W7V6+VE6kT3flxHUKD+euwwIzdlGQww/LcSbNtvW0s1AAsPCnV3NLpEwGvZeNDiPFC
	 uuHuZHEoF7qpg==
Message-ID: <9aa4be43-dd3f-49ea-bd1d-5931a1687c75@kernel.org>
Date: Tue, 11 Aug 2026 09:27:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/5] dt-bindings: mfd: x-powers: Add AC200
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
 <20260809-submit-acx00-of-dynamic-v1-v5-1-bfa1f8518b28@gmail.com>
 <ec826a71-bf33-44cc-80e0-dfc7e92ceb61@kernel.org>
 <CADvTj4r==rKP4ThVZog51MQ2AVDLZNFwrPH+uDLFV2wGZueAtQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CADvTj4r==rKP4ThVZog51MQ2AVDLZNFwrPH+uDLFV2wGZueAtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/08/2026 09:23, James Hilliard wrote:
> On Tue, Aug 11, 2026 at 1:07 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 09/08/2026 22:28, James Hilliard wrote:
>>> The AC200 is an I2C-controlled mixed-signal companion IC containing
>>> audio, video, RTC and Fast Ethernet PHY functions.
>>>
>>> Describe the parent device and its shared input clock. The Ethernet PHY
>>> is represented by a PHY package on its MDIO bus, with a phandle back to
>>> this device for access to the package control registers, so it does not
>>> require an MFD child node. Function-specific supplies belong to their
>>> consumer bindings rather than the shared parent.
>>>
>>> The input clock must run at 24 or 27 MHz when the Ethernet PHY is used,
>>> matching the rates encoded by its documented clock selector.
>>>
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>> ---
>>
>> I do not understand why MFD and net are combined. And nothing in top
>> part of cover letter explains me that (which I asked already - any
>> dependency or merging is THE MOST important information. Where do you
>> put the most important information which maintainers should see
>> immediately?)
> 
> The AC200 PHY control registers reside in the I2C-managed
> multifunction device. The AC200 PHY backend therefore consumes
> the regmap published by the AC200 MFD driver, while the AC300
> backend accesses its control registers directly over MDIO.
> 
> The managed syscon registration change is used by the AC200 MFD
> provider. The net driver itself uses the existing syscon lookup
> interface, so there is no compile-time dependency from the net
> patches on the new syscon API. There is, however, an unavoidable
> runtime dependency for AC200 on its I2C provider. AC300 has no
> such dependency.

Runtime dependency for new drivers is irrelevant. Patchset should go via
different subsystems thus should be split to make maintainers life easier.

The only reason to combine it - which is nowhere explained - is to agree
on common design of expressing child relationship with sibling phandle
style.

And again the problem is that cover letter explains nothing. I went
through first three paragraphs.

> 
>> Bundling it together suggests this is somehow incomplete and later will
>> be finished, which is wrong by itself. How to fix it - decouple
>> dependencies.
> 
> Could you clarify whether you mean that the MFD and net changes
> should be sent as separate submissions, or that the driver
> interface should be redesigned so the net side has no dependency
> on the AC200 MFD provider?

You organize independent work targeting independent subsystems into
independent patchsets. Simply act as maintainer. What maintainers are
supposed to do here? How much time they need to parse this patchset and
apply?

Best regards,
Krzysztof
