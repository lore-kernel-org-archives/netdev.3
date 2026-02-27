Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29215261B71
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224214; cv=none; b=d/5s8dVQWKwiTZ8SHDC0Phcqq8AmfyQi/e8noU45IF+QN8tp/yKz45XhhKUNM0fNHqc9jO5NGVjo3T+U9FJ4Runf1hcI4iHycPsCVKoGK3BbxaPsZftS/m56mL04m9b+8V6+L6vgiXGzYoQRUPJ5RfgUE6pSkroHhS5tjrLh4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224214; c=relaxed/simple;
	bh=mVle4ytW4J5vmpgGxb7eoplyg61Pv0xhWPF3sgrQdE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z23cR58woUHaqDL5w91h1Cbc3DHMGDqon13XtmaKeTBrMYAYSgCt6N6wJLffLsc9GPPLqaAyNZuMrrA8iukUPpp72T2xBeQcR2W61YEnljxqqt5US+HPZSIC8QSU8sQD2SaH3665xwk0L+WVlRXc0sUnApBW2AFwAgs3ooxUSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJsE4v2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJsE4v2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB7DC116C6;
	Fri, 27 Feb 2026 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772224213;
	bh=mVle4ytW4J5vmpgGxb7eoplyg61Pv0xhWPF3sgrQdE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aJsE4v2tLtiuFbTjX21Brii/I5EV0y6wSXBWNpfmGnu9ah8J2sHng5m4ihXr0nbvR
	 x/z/eEJSMUN5pb3UBNE0tCSckcbrRhyIvW+mX4sGOH77iqFL1xs4d/SxRMj3Wv9Z2z
	 9BMl/nPzqIUTI7DDHolirzisFNAZFku1axtYT+DeFVuZ6RaEMo8uPlHDvin5st7aPm
	 PHLlqppWBxVRa3UozUlNTwTQoWuwzXkhErUlllVVuqcjzoJlDnUZ38f2A9lko5w+9f
	 YduFIRGis+qX0CKL5X0+dfjxK3LYYzOYSbvJEgyK17qVzBFWhnMCgOwluaj0PYODEy
	 sRsbV8iKEBpZw==
Message-ID: <6fa8c88e-d1fb-42ba-a0a1-f8aa6802b454@kernel.org>
Date: Fri, 27 Feb 2026 13:30:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ip/netns: avoid redundant mounts
Content-Language: en-US
To: Chen Linxuan <me@black-desk.cn>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>
References: <20260210-netns-redundant-mount-v1-1-0b1ebfc1c79f@black-desk.cn>
 <a9197cec-d406-4201-98d4-a06820b220f3@kernel.org>
 <CAC1kPDOs4MP0=89Aa=Y_nZmVY2_9WUgfQs0x=wd-FPMFedrVqw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAC1kPDOs4MP0=89Aa=Y_nZmVY2_9WUgfQs0x=wd-FPMFedrVqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/26 6:21 PM, Chen Linxuan wrote:
>> with this patch I am still seeing 2 entries:
>>
>> $ sudo ./ip netns add blah
>> $ cat /proc/self/mountinfo  | grep blah
>> 337 92 0:4 net:[4026532418] /run/netns/blah rw shared:344 - nsfs nsfs rw
>> 338 28 0:4 net:[4026532418] /run/netns/blah rw shared:344 - nsfs nsfs rw
> 
> It seems like your old `ip` might have create the /run/netns mount point.
> After remove all netns then umount /run/netns, and ip netns add blah again.
> You should see only one entries.

Fair point. I no longer have the patch, so send it again and I will try
a test in a new VM.


