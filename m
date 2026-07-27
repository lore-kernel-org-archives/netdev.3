Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7643E5597
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140695; cv=none; b=Q+lnjpcdV0JnRMzVjBDe4v6mNX3o0Sap/wxOLNed8iBRHnh7V3r9b03FTCXxVoWTjj+Kl2zGCQwG+Prvagpi5iontyaaApbaVcCDmhGhZ57ZH98m0l3JWYGq2pKwPNcYGrOYHdF47Wkmq/OXtxK0yNAoFum7+XFkpKRJfrxfvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140695; c=relaxed/simple;
	bh=1suIuveK1jVLK/3U/JiBvsxW+MzFeKYA+Y/R806QzeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sg7/Bp1VfmYyawyMbFJ3OLF2TJFClud3Oh9wv5TN8XJOFGvr7ymGSdGR4B8zY78A3F/VyoLlyvMrMP7+SJV/HcxuK2C7BeT8OVa/OqUTmOOAhR2Wy2AWVISR0cVqsENJFvWuocg+J420pKlNb0rPcbblEWOrA52fG06bu/PAMcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuRzedTT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hmzk1r6V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuRzedTT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hmzk1r6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785140692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnXREwCAx/g7UNDirzlmChKeTeegmq5IfXqGd1tp0CQ=;
	b=OuRzedTTeAmvsIZXDaI/4LAIz0xAwGXYPpXVtSqgppqVABVs5uIXpHIiqhebe5F0cFkVB/
	MgbXXDLXtq4Yn2pqd2G959LOL3qyD1bGQi4rjMS+Ce3jsgbwirR3NXepD2x0hHwJHAPdXu
	u6Hcz0CUrKGnGcjeRK69A20s5FeakpM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-WvejuA_KNvyHAY7SsNI0pw-1; Mon, 27 Jul 2026 04:24:51 -0400
X-MC-Unique: WvejuA_KNvyHAY7SsNI0pw-1
X-Mimecast-MFC-AGG-ID: WvejuA_KNvyHAY7SsNI0pw_1785140690
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49545071724so27260165e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785140690; x=1785745490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MnXREwCAx/g7UNDirzlmChKeTeegmq5IfXqGd1tp0CQ=;
        b=Hmzk1r6VRJrBqafLPzTSu6yuvZHbHNvZSD3ddQKuohMLubNiXwd1jNUy3b2/bJg2tq
         mnhO2oJowxvlxizV1sqyBE5DnxKO4m4NTP3LX+g+VoN57zpZZTkAendqGvDJPJABSHVM
         QKSb5Hf2AkUoPlELg8e2NfHpuXDvi5VSMlEyeymhw3bqzAHA/WAHZRMNr7HEVxhCHIGw
         5E12eGBEBrQuO2s7vshjlc+Plx5Tc332G6QxFVKAuXWXed3V4ZDJ9qaOOLldfngQJI8J
         dTh6V0295a7bVeduG10zWLT50sGVWH45ve2vqB81t+n8UScR4vyz7IUC/P5pXYl18azE
         gGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785140690; x=1785745490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnXREwCAx/g7UNDirzlmChKeTeegmq5IfXqGd1tp0CQ=;
        b=RLgMsXzfZlVHdTMCYopgTAPxxd3fV4gyGa8bbM5npdnlTCdyPEW6+Fc2xpk6hdMnUV
         Iwijtf6NPYLhTD+0/9ZoZGm9cafpYES5opOXI+pSH0FZKYMNro9gqY6bZw2tTPhrqr3k
         hX22tH6TC861japGB7xcEemw+5kGVxuTkz2Iltm6NtAbMEwGKpdVRHECL6M7smSozrj5
         mI2vWPT/aSiIxm+AAV5T//Qwc5AA6fYjMi9eou23ufWq3iM/R4lqxNVKqWNqOghAp9lv
         dWi/HDlIRSYBiKpUqgnCSf3C3ubrv+4rG1rVaAxYfYGCCUW3vzRv4FvE8TNj6lZvM2QY
         NL8w==
X-Gm-Message-State: AOJu0Yz57gVLLeewqUf+Fp6qoo4qkhCjoWkct2zmUoZBeoaJy7bauNaF
	H9F3gyKpWAOMb6Uiv3UzWf8G2Ln1RnEj4WBW5UuDYxk5nIcnBCmhv80krVkA3OQ9ebpDXMQlM2C
	NVTnz6fWciLrCY3OXYomc+fTny6mUWkPw+zqNV0fovo6zto3Hqev+Lzqn6A==
X-Gm-Gg: AR+sD10XF0Cs5oqDkMFcQHQKVGb/fLxIP25XswnocPbjv7kRtNQx6X+cG0wfAGISjyG
	UdJFwh5EFYMHb4yAP3PKwLdHTdlXC8zi/f1r3NwLCQY3GBx8yod/UYxUJnlRrVnToO+x6YGKtq5
	63ky3QiV7w67tlM4jvIVMJoGMHBpKkeq233Bmzu5oD62mq/9t2cg4PBV7aPC63S8K4KQwmAud5G
	Zks+dCnOBTjpex9oT2xiK01Vc5fsF/yF2AIBcwFNmj8o0MDpGHj2r2hj72ko71fec2fGI5HwAnX
	WLks0Byt5NsknmU8i6z3a+0Z53Qfqxu/28ci1r9JHpiXFLLzav34A672qrPIhGW11WR9vENRRbZ
	gLNuWmu3LcbiPZKHxZSr+U1MNH7bw8k6ZqLzBPsTpBQb/ktGVYoN6TA3E1fiWsNCa8c2Evy7kbe
	9kQg==
X-Received: by 2002:a05:600c:6d4e:b0:495:734e:4825 with SMTP id 5b1f17b1804b1-496b56fa45cmr66945645e9.16.1785140689986;
        Mon, 27 Jul 2026 01:24:49 -0700 (PDT)
X-Received: by 2002:a05:600c:6d4e:b0:495:734e:4825 with SMTP id 5b1f17b1804b1-496b56fa45cmr66945465e9.16.1785140689581;
        Mon, 27 Jul 2026 01:24:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499ccb4sm213193705e9.10.2026.07.27.01.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 01:24:49 -0700 (PDT)
Message-ID: <c5df2708-22d9-44de-a67a-4a68f2b091a7@redhat.com>
Date: Mon, 27 Jul 2026 10:24:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] docs: netdev: clarify expected interactions
 with LLMs
To: Matthieu Baerts <matttbe@kernel.org>,
 Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1784884817.git.pabeni@redhat.com>
 <83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
 <CGME20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7@eucas1p2.samsung.com>
 <amNS9/owsgr44v7w@AMDC4622.eu.corp.samsungelectronics.net>
 <68b50e02-c238-48c6-b2aa-98eb21077329@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <68b50e02-c238-48c6-b2aa-98eb21077329@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/26 3:39 PM, Matthieu Baerts wrote:
> Hi Paolo, Jakub,
> 
> On 24/07/2026 13:56, Jakub Raczynski wrote:
>> On Fri, Jul 24, 2026 at 11:24:05AM +0200, Paolo Abeni wrote:
>>> +both use the Sashiko infrastructure on top of different models. Reviews are
>>> +available after 24h. Patch authors are expected to proactively look into the
>>> +AI-generated reviews and handle such feedback as any other kind of review:
>>> +either debate it or address it. In both cases a reply on the mailing list is
>>> +expected.
>>> +
>>
>> Would it be reasonable to implement automatic response from Sashiko to
>> mailing list? Some mailing lists (eg. dri-devel as far as I have seen) post
>> all replies from Sashiko to thread, which is imo not bad,
>> although it could be filtered by High/Critical severity.
>>
>> What do you think about potential for similar solution on netdev,
>> since AI review has become 'basic' check in patchwork?
> I was thinking that too: it would be easier to reply to the comments,
> and help the authors to remember about them. That will not help to
> decrease the traffic on the netdev ML, but it is also possible to
> configure Sashiko to email only the authors:
> 
>   https://github.com/sashiko-dev/sashiko/blob/main/docs/configuration.md#email_policytoml

One concern I personally have with the above is that it could turn the
ML in an public automated AI review tool, definitely flooding any
eventual good contents.

In any case this discussion is IMHO quite orthogonal to the
documentation update.
>>> +Authors are strongly encouraged to run LLM reviews on the posted patches in
>>> +advance of the actual post. Large series triggering a significant amount of
>>> +AI-generated feedback will likely get little attention from maintainers and
>>> +reviewers.
> 
> If Sashiko emails the list and/or the authors, it would be good if this
> note is added to the emails, not to push people to abuse the public CI
> and AI resources.
> 
> On a similar topic, it might be interesting to mention SUIE and the
> scoring system. Or mentioning that sending multiple untested versions
> will move their series to the bottom of the queue.
I have some doubts WRT setting in stone (in the doc) the actual patch
review order or an explicit "sanctions" system. I think the patch
wording allows for more flexibility.

/P

