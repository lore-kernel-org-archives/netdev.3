Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469903F9F38
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868349; cv=none; b=r32AmUHc1PAjbhz5EUL9eaHT9phA00ziVWWxW7QqwutatH4iqZfg4+pZaTb5o+64+6uoPeNNFBV5A2nUZ08QTqopZ6Oki13MT1n74F5DI1IUtn6pqSZCZnD67GBGD8SWLa7bEJDwUi1GM3nfYbDs0/ZEBiRzjxs+fxBuVhy4u4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868349; c=relaxed/simple;
	bh=IXB6vUiKWJEdqW1TTD5ocjjjxNWpstJkub6JSbsNZSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jN7Ly61JEqogSEV2Z6dbbWtKSsdWvpk1bpMF7itibxnrVFgEpHAyFSVdVmXLpCbSzb6tWtJGHg7Xsn9wGo6ibay7abQUDVwwNuquoNU7QK4+S/KnlU8oEgh//HoxvymSRnWcsOqQ7IqtiVlVNG7B7Q4O5c11DJmM469/H+ExdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hifKAnrq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFRa6z3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hifKAnrq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFRa6z3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785868345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juuGOVrGLpk4gW02kqE7+bIl9ZXIQiTKpjejvwij5xI=;
	b=hifKAnrq02bPIj2t3ZPj2hMYjcXdKCZF9o6c5rKlDC3u+ZGU0TStc0OpXmpQel1NWiDnM5
	i7oKamgr1EyagF7ankwD/gZ0MMQyxOERpjc4JQpMNItUEkVE8YP4B5kVZ/S8Ydfgsec95g
	oEapHlS1/jEfsxb3expV4QmyxV6tWE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-N228fBADM1uQdbqFCuSQ8A-1; Tue, 04 Aug 2026 14:32:24 -0400
X-MC-Unique: N228fBADM1uQdbqFCuSQ8A-1
X-Mimecast-MFC-AGG-ID: N228fBADM1uQdbqFCuSQ8A_1785868343
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47fecbb553bso73056f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785868343; x=1786473143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=juuGOVrGLpk4gW02kqE7+bIl9ZXIQiTKpjejvwij5xI=;
        b=BFRa6z3YUO7Vystjy48OpEN3NeRx7Y8tKDN7i+9WJ92v2pXxzo+4pAJTtiSEWOPmvP
         ZGxGCRtpPAIm7wLCGLDPM8tfj1LHCjeFvHQtUOF0pVYQ4oyIXEuYqQNz6o07F1OAb/1N
         lvwEUP9Tttuj2tji7ye72KjPE/8CCsP+N1VmLXEIwvPWyME2t3UiYItDbmW4l/bajTNb
         8eStGpVVr8cUk2lATrjUqpXqNeiaA46qFwrE2xjCrEZmeq0kuBfj+mAJAIrvMJv/6rR5
         Ptx1rqhT/iv6UMnxodVAdGBJKZG6lR2F3+lSQHAX7ZQRM1Z783cDP5DS9BjtmUQQQnC6
         xjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868343; x=1786473143;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juuGOVrGLpk4gW02kqE7+bIl9ZXIQiTKpjejvwij5xI=;
        b=lQBDQcEU6RlZCYk029XDWXij5We9L0xS8/ti/5ig4dnvm1JLq09TTeJtLn1cmsj+Rv
         PNR8zbT082V1023jgXSe/NtOptmyYf/9O8ISXSOq0VSlcltGhdD0UCnfVBVL17vPnCvr
         V9/z5c400e9HYd6RNWz1S51f52qeuCxCtUMpP5D2hCAIy5jBcvnoAFSPA2NGVy7CEqht
         twrVfNCRTYNBJJYuoMyHqAcN7fhQUtds4CaolFZ/vslbVHzf2MTK8yTzUlCseOwioPxe
         0ZiUJDS/eb9f+Oiv8/+oEShUZcboinpKybvy7AE0BewyYMpydmhZm7gkWrY408u9tnzO
         zVfw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2EB3ldQuOiyx7A4Czu2V7AItp54ds9sbVhJh5vBfh3IBvnboeOIgHrDYmW5vtOc90KFEyy08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBjQq8F9oA2GlwGixV0FKes+nL0bXhp9hTxgfBXKoqwxnYrsj
	jOeE3GBz9tBoIGB/bbWf1O3kFQ5/eZufrnZbv+2MpBHXVfkPhzmFLBATFj+DI1nNPnlRWAytgVc
	agQ/mfLDcOX3bcoJb7xPN0P2a53nKK9ZVRd5s70xSco5bc9NQhRF9j4RDmQ==
X-Gm-Gg: AR+sD12UoZpMnOtgaVke/Sy6omubrpyE4lkd3Y5xRJooylRxLW3UZ5LCQA7VW5RlHQZ
	Q1heW/ug+sxwe9iSpGF3yofAfqmngMefHeeEY30lOuH+Gu/U9y2+UnUjT2jipCMi1tL1i7R9j0J
	KgLSbl7l0ngEn8ThfqPLo2GN7p+xVwHXiSqqw4hJL91HnXzD7bYZsRvrfvO/Z/QfvfWWoJi0YCt
	c29CRexSWzRyOOnfNnfULx77VnOOzBdiSpaglNYdRyVbWA0K9YlWD7Y7zHwUnqpqhS8d/uzdJpb
	ZvKIKM+cJx2Dgv3RIN9jbMp8gCxFwp7yp7PHS/nVSRrOU4Fi0cN3mWxC+xB1Rp23iVoKO06FcFn
	W5a1MR0dWGXuUbDAwd8DP0NluhgvO3amJuB+xYnCEoI2sL2LLkIbBqZ9nGYgi3hZ1MX/kAMTuJb
	4=
X-Received: by 2002:adf:fec7:0:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-47fec519ff8mr1867057f8f.16.1785868343490;
        Tue, 04 Aug 2026 11:32:23 -0700 (PDT)
X-Received: by 2002:adf:fec7:0:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-47fec519ff8mr1866989f8f.16.1785868342939;
        Tue, 04 Aug 2026 11:32:22 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23e5efsm1936070f8f.27.2026.08.04.11.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:32:22 -0700 (PDT)
Message-ID: <dbd0dc17-d097-4254-b6f0-59eeb6e69579@redhat.com>
Date: Tue, 4 Aug 2026 20:32:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
To: Sven Eckelmann <sven@narfation.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>,
 netdev@vger.kernel.org
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <5248054.31r3eYUQgx@sven-desktop>
 <37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
 <4072288.fW5hKsROvD@sven-l14>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4072288.fW5hKsROvD@sven-l14>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 5:05 PM, Sven Eckelmann wrote:
> On Tuesday, 4 August 2026 15:08:01 CEST Paolo Abeni wrote:
> [...]
>>>> Note that it's preferred to avoid fixes and stable tags for changes
>>>> targeting the net-next tree. If the fixes are really minor, both could
>>>> possibly safely dropped. If there is some real problem behind, such
>>>> changes should instead target the net tree.
>>>>
>>>> Can you easily rebase your tree and adjust the PR vs the above?
>>>
>>> I have a different statement from Linus:
>>> https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u
>>>
>>> This is why we started to not send out net.git fixes PRs for things which 
>>> aren't highly critical or for Linus' "just merged for this release commits"  
>>> late in the development process.
>> I actually think netdev preference is consistent with Linus'ask: move
>> the "fixlet" to net-next.
>>
>> The additional twist is the ask to drop the stable and fixes tag
>> (otherwise stable will be flooded, too).
> 
> I find it quite unusual to drop the fixes and stable tags - just so Greg+Sasha 
> have to use their tools to figure out that these were maybe fixes and need to 
> be backported? This already caused problems in the past and had then go 
> manually through literally years of changes (LTS releases!!!) to figure out 
> what was lost in the backporting process. Yes, the years in which it was 
> disallowed to use Cc stable@
> 
> But to be honest, I have no idea what "fixlet" means here. Is for example 
> https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260731023333.70727-1-heminhong@kylinos.cn/
> meant by it? Because this is for example something i don't consider worth 
> backporting. It is definitely fixing something but I never was interested 
> enough to do it myself when two or three other people tried to send 
> incorrect/incomplete patches for it and then disappeared after promising a v2. 
> Which at least makes me think that it isn't worth the effort.
> 
> But maybe you are talking about something completely different.
> 
>> PR are a bit apart from plain series, hence my initial questions WRT how
>> problematic would be stripping such tags and how impactful are actually
>> the things addressed in the first 6 patches.
> 
> Sorry, I am lost. There is stuff for which people have actual PoC code. Afaik, 
> nothing for an RCE but enough to locally be a minor annoyance. The things 
> which have no "Reported-by" are things which I have problems with on my 
> installations.
> 
> And about the others: The "bla: avoid CRC corruption due to parallel claim 
> add" + "prevent CRC corruptions after claim flush" were a problems I had (next 
> to another which was not yet posted to netdev) but has a "Reported-by: 
> Sashiko" because it was also reported by Sashiko when posting other bla 
> patches and I think I've stolen the example from the commit message partially 
> from the Sashiko report.

I'm sorry this is getting more complicated than really intended. The
rule of thumb is that real problems actually bothering users go into the
'net' tree, and other stuff goes into net-next without the fixes tag.

Jakub is actually the one usually more strict about the 'no fixes in
net-next patches' mandate, but he actually did not raise the point here.
If he is fine with here, I'll not insist.

> On Tuesday, 4 August 2026 15:16:54 CEST Paolo Abeni wrote:
>> Please be aware of net-next commit c82ff94592fb: the expectation is that
>> submitters reply proactively to AI review comments.
>>
>> Specifically it would be helpful an evaluation of how critical is
>> problem reported and if it could safely addressed with a follow-up.
> 
> The LLM situation is really starting to get 	unbearable. It is like cutting of 
> the hydra's head - it will directly bombard you with 20 more "and now for 
> something completely different" reports. But preparing proper fixes is now 
> also not ok... And at the same time, LLM tools are becoming a must-have for 
> posting patches and now I even have to start to write rebuttals/explanations 
> for these reports. I get why it is helpful for you do see comments from 
> authors/submitters about the Sashiko reports - otherwise you have to go 
> through the reports and figure out if it is unfunded or even already fixed in 
> one of the next patches in the series.

You are not alone in this painful situation. AI reviews are striking to
everyone. LLMs improvements make every day harder get "all green" reports.

From maintainer's perspective the most difficult and time-consuming part
is assess the impact of the AI findings, especially for code
subjectively less-known. It's not a matter of simply reading through the
AI report text, is requires context information and analysis that should
be more easily at hands to the patch's author.

Providing feedback there really helps a lot with patch processing.

Thanks,

Paolo

