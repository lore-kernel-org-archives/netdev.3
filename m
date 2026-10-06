Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85543B2FF6
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327954; cv=none; b=r6D/TQAnzVsY5KU0gQLjG5bzntGFWueleIwQbXaf9hAHEACi3fjgKhzPhjyd4rJ2gOEVZySetazoaeX2dIaqdoQ0Lze9kPBHXjB32BwAmthH0Jm52NC6c58/we5GSJcl3vdjwlesARiHSDVDSIzhxNIeP53VEELLw41+r8wBTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327954; c=relaxed/simple;
	bh=5BpkrLZY97uL1FdXLp63OTgG4V8hBRYT6rR7n/2vtuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmdgd3Hh4wvwAuEJHAK85HWCLsQp7L4/9fqvjwj8/Hi4avWs1WcoyfgnaCCOslc1wNc05Ez8JTwz/0rY8iWhdrniF+AZJ/flzvWtipdQKRoyclnGyT63YPLa1Lf8uNQLAI6+SDuFjXcQpH3wdjKpEmcCrvboi6cx3vnP2TQS4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W4TluYht; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W4TluYht"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-93e6fb35f91so89430085a.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327953; x=1791932753;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JS9sujGGiutACLePH3caaNDkIbwRefKQrzm8Gh8SOvs=;
        b=l4TAUcxQCzgiPFR0LA/yLIuVxR9LAY/WfRazhWbHAez6kuQx4A4QbIFCHTk+QpZ8om
         t0sOS7jgiiZ9/x8pkUyTIRFYNrqov3eCAxcH/BPm7VLGIs0vGigYBhWbXE9O965ZkQ91
         axgIyrYZI7weMJvgxm1Lc/D4Fe4YQ6aPtLib8F5PNpbDA2ChrwvhVCYSstupXyl4L68j
         xtN8Sy1eHN+J2Sai7WrTnD3aOXVJ+zJwuz/qdOlABQeCvNG46t3lGwYoMAeF9dvfqMH6
         ucy6H0qdv290W+y2KJzygh1L4zqZVrYpvCXm03e6vZSCS3NUKWGtAcf6DqbjqyZESkLM
         GXzA==
X-Forwarded-Encrypted: i=1; AKwUvBx4MM+kDS3Ba0cmG27qLGYmlq2AKAHTvyK3KoIeNQXa2twWPYspZY+VxXd85yzZub39+RjeqEc=@vger.kernel.org
X-Gm-Message-State: AFuF++mFxeKHl8bv8fKP0KX8YARCnBouAGM+Qu/ZYzUj1ddfIBUHS+Kj
	8QVFn82TobAiBo9tnppwcwPDJf+yvrLAP2iOVTX/w4eL6pyu7MiiB+tOL93UA2+raRmr3tYZ2Be
	048GWo2SJR19GyougIaCjyX/aGx4hMP0XpKn9ZjYgLTbvx/UIQMiPfcI2Vec6XMubySq07d7Mo1
	NQVWyhwkj+31vUk5sDu5JjVyicUafoOTWYpVwnwT/09bp/x9wp8BY2Iw1oNjIGnCVgmLMYeaKmb
	RDSGT2y6w==
X-Gm-Gg: AYBFou3872M68C+O0TRaaoM1eozzYQVr6c10lSgvyHbBbPiusGjCjrTWDOcLWJcFNtW
	b6ku3nIfGv1yUMLCVgIFmMQDHU3geFAGiemCA0AkXDCe9in84O0XGBzssHVqzKpPVm8TlBA8Y2p
	Ud92XKy8L1OMp/MV0+ljS53RybRqoHhtb81I2pKXGDqhsR1n0x0OhfY++k4c0Nk9R/DGG5d6odr
	g5Jr12fR6LMcRXtNepVzK+czAGcCwzIVomH1aKKAVslom8GwFZ4KY0mnpyF1tVZz3dGp8+xoB1e
	S+9+MgoMZ8q+nTorP4ERWUnCkWtOJT33Ldv1sdkfRFo5S/doHs2jXZs9bZhDA0G7xwl22Qi7q6l
	ypdnPCMxGiqjLxIIXg/kgxHcPiNKrpjA48OWUFAOZefmCki+C5ZDikKM1HbKVAYR4C1aUpOtizG
	L/lMvUqj37kDvK+DGsBCdNr4M+BF0oGuOMmfQd
X-Received: by 2002:a05:620a:1a0d:b0:93e:653e:6981 with SMTP id af79cd13be357-93e9b0d4bc3mr99670885a.11.1791327952452;
        Tue, 06 Oct 2026 16:05:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93e990d8cbbsm24703585a.8.2026.10.06.16.05.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:05:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so7530838eec.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791327951; x=1791932751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JS9sujGGiutACLePH3caaNDkIbwRefKQrzm8Gh8SOvs=;
        b=W4TluYhtWRFWg83y05RkMN+hlPEGxHqrJwAAc4+9Q0qstA95IM66x1ZwHTVawjhmWB
         UpO6FiI2sCcmtw8NtNgGpD0qHnCBFw4uyn5oqf1EsFe+5lW3KQ6uCHeLZF5C7HZXzZlS
         kERNOA5gJaHJB3/wTjXBq2EKinfbTrh6MdA70=
X-Forwarded-Encrypted: i=1; AKwUvBxvXoT+GTyrv9dSameHznZC9pOvqOVPD5jctZYdssF0D0ACdTOXPO8RCzdoJjgQ8vzx9cP9eMg=@vger.kernel.org
X-Received: by 2002:a05:7300:f00a:b0:343:bc3c:6c38 with SMTP id 5a478bee46e88-3515dea001bmr264333eec.31.1791327951130;
        Tue, 06 Oct 2026 16:05:51 -0700 (PDT)
X-Received: by 2002:a05:7300:f00a:b0:343:bc3c:6c38 with SMTP id 5a478bee46e88-3515dea001bmr264302eec.31.1791327950384;
        Tue, 06 Oct 2026 16:05:50 -0700 (PDT)
Received: from [10.14.4.255] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515affdc9bsm1579570eec.25.2026.10.06.16.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:05:49 -0700 (PDT)
Message-ID: <61e7e89a-c04f-4700-8387-5cbe776460ba@broadcom.com>
Date: Tue, 6 Oct 2026 16:05:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
 <179080972360.31693.266631430009737406@kernel.org>
 <20261001184130.2b7ab18a@kernel.org>
 <897ffc5a-48ad-4516-89f2-0cdac082d7a8@broadcom.com>
 <20261005182721.776af8b8@kernel.org>
 <a1dc7c80-acef-479b-ad03-dc83164d77c2@broadcom.com>
 <20261006154407.64ecac6b@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261006154407.64ecac6b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/6/26 3:44 PM, Jakub Kicinski wrote:
> On Tue, 6 Oct 2026 15:29:01 -0700 Justin Chen wrote:
>> On 10/5/26 6:27 PM, Jakub Kicinski wrote:
>>> On Fri, 2 Oct 2026 09:16:15 -0700 Justin Chen wrote:
>>>> The issue was hit in production and I verified the sequence keeps the TX
>>>> disabled in my standalone test. I tested on an internal development
>>>> board with bcm77122, but should be reproducible on any genet HW that
>>>> supports power management.
>>>
>>> I obviously meant that you should respond to all the fix info requests.
>>> Not just this one in particular.
>>
>> Sorry Jakub, I am not understanding what you are asking for. I believe I
>> answered the questions above? Or am I missing something else?
> 
> I mean other threads, immediate example:
> 
> https://lore.kernel.org/all/20260929203400.1588868-1-justin.chen@broadcom.com/

Hmmmm. Looks like those missing info emails didn't hit my inbox. They 
were sent as I can see them on kernel lore... Let me see what happened 
there. Florian submitted more patches, but these should be the only two 
inflight from me. But yes, I will answer on the bcmasp patch as well.

Thanks,
Justin
