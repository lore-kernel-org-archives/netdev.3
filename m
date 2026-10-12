Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA2246762
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812269; cv=none; b=M8NuQ4y43TCE5yO6pdr5kAopeEeL+i2S8CvIE1fHWA0Lh2VbxcGzxfPRYn+Qa1BkOb17ORbmUca2pp954Ezx0jeXuY6jXbAmuZWb68joOcd6PDWooZzMeMUu8fY8MEbWeroXlRUWb9Ok8CF3cOZhhZNkQvS1WV4H9TY7d+N/0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812269; c=relaxed/simple;
	bh=XfIIwn2piL8Vg4RdtbjUR/Beq6SvNyE9ZkaxsCNGhrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BryRwR7FA5+LWlLmAsmnSRHFH6MJh5CSp7kRZQxKczpJ/RTYysqtTRHRqM/1rrSS1exLE6GUUORR78YgNz3rEsl4/5KxHvEpjvTPKl9H5xaqvId2obilbvGssiBJQYpJfFzutJtqV8q0fRO51DJZ9IrlrefnsY92M2NMoQirjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/CrzV3y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/5mKraI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/CrzV3y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/5mKraI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791812266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVoAiBjHAMcorla3HPUaKN4HYRvMV3/JwljxT+atZbw=;
	b=D/CrzV3yd4trbii08NjCEM9TMjAfWME3gyOhxbtKjxxlCDfpIBmStqqAYU9P7h3NDsKhHM
	rZuV6UO3MfAJq0y77NoeamKDg2v0s5QprZIcUuWCw6WaNkHgrU1LcsOe6WvMCyqS1Bb6Lx
	74Pqsoa9lCr9//CJQgP8s0uA/cFMm1c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-SL2-rg4pMUyPr7xDRBWltQ-1; Mon, 12 Oct 2026 13:37:45 +0000
X-MC-Unique: SL2-rg4pMUyPr7xDRBWltQ-1
X-Mimecast-MFC-AGG-ID: SL2-rg4pMUyPr7xDRBWltQ_1791812264
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso14814565e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791812264; x=1792417064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVoAiBjHAMcorla3HPUaKN4HYRvMV3/JwljxT+atZbw=;
        b=C/5mKraIW9yInfthZbnmJouG9ISEkyKX00O4Bkttb4+YaEV4j8Z3qEWkvcBJv5l95Q
         W927BjuZVBY30hWkYTB0cmCxd+QxXiuKnjcpV6hp9aefkvMkfEOfbZ8OT4TFKMql+uXV
         kx/MMWA9a8cNqQ2BBc1MHyhqULaIdCjvtbLqgOkDqOeKvXa8WQOmYwyFNxjjZ0vdyHfo
         eOwy4ntm7SZJcQNW/zP9iWxIG5GkwZmjnIQsi0Om3zfNnGR9i+6vYrjuUSvVQvpWlsTQ
         XtKR5i5CqEW9wvg/DqWmlqIJcifUBA9oUwF+IRDlPmeTGH8K88RuMHHBxYDyayC827CK
         zi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812264; x=1792417064;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lVoAiBjHAMcorla3HPUaKN4HYRvMV3/JwljxT+atZbw=;
        b=oBsanjggZgpWBUGSDKA/bxyFRJ9JQiu0Prx7AADkl2MxGt7VaK27U08xV23ts02yJ/
         SPzqVSGDv5onLUlv8IThJcJDZ/cpy+PKucKZdE0ny/m9EzeFlIpzmYUUaKfRoYoXMF7C
         PJnOsJ3da0OshA60goqa+gIrfGyYIPrSE1n87fInjYsGbM9t0v9Gu3BUQFcgC90mheOm
         MLhs8s+WEuByTgH0RB8THfaZ49V4/NEtmENbTUyMBrAfhTEB81OLqy74xBDIaVO7dc2g
         CCxIk14v5aCj5+yPjDAD6YsT8brUpRxbwVyoce7nRbwxt912iIT410kBhylgN5U32oQM
         7stw==
X-Forwarded-Encrypted: i=1; AKwUvBzkDdR16E37od4RrVvpwjfHv3EF1V6begW5T5UXwEfH4yjJe2g61md5SWaHpVoF5ei4i8psatY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd2EKXU5fiSixVS+dBYFYdW2sRtoRtiwAMYOI6YsjOo0Nyx+PI
	3aOVD2q49zuL2l7PCrOoCIUOh4khtbl7rexcO18b84K0dFtXWZiPxOwyjsoz0H3im3xfj3CqqPQ
	/5SodqFQSO021eBYk2c99M4Gjb51whFrbMkg/DHdebkozOFgph1MXtRClzA==
X-Gm-Gg: AYBFou1Y2bQGK2rV8Io1YUjxwNOnnLYfOIKfmLC8AaY5dIngE9S0xl5jq+uQe3IvNGe
	aWRvgruI3rSm8MNj0QFUBNl+TV1yk0U9nhfTVAJ6gkK/ZKWyuNnxHmytIC6Axuz3Hn7N47ACIFC
	9DIzE1O8h0ON4CUIXmaI41upH5UH1ZrvXwv5RZfNPi0MUbXiRSxGo8avuD8NRAq5+88GNRNHbMK
	4xuXN3wJ2NfbA8CJ7Evv4e02CXDYEzbIshTjSEnQR+FPQh1z55cFQEc3Jr99NOBRxcogPqw4F4T
	NSnXxtc6XudEt7RFpfJVsga/A84ll9y3i0YT2mx+XW7QEVW7+tA9WngzfCePfPxzR+wkjm+g70f
	2WgCunS4YL/8TJp6hujHhzb0xHoFVF8jfLTJLg8zvnrtb9GuKX5M3JDcOs6Zc7yMHeLcFXX0FHQ
	==
X-Received: by 2002:a05:600c:4e12:b0:4a1:98b0:2617 with SMTP id 5b1f17b1804b1-4a1a2063c6fmr42956325e9.13.1791812262645;
        Mon, 12 Oct 2026 06:37:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e12:b0:4a1:98b0:2617 with SMTP id 5b1f17b1804b1-4a1a2063c6fmr42953345e9.13.1791812260429;
        Mon, 12 Oct 2026 06:37:40 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ab981asm20082049f8f.30.2026.10.12.06.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 06:37:39 -0700 (PDT)
Message-ID: <64903617-3d04-475a-b77d-56409eae5892@redhat.com>
Date: Mon, 12 Oct 2026 15:37:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sashiko or lore confused?
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Victor Nogueira <victor@mojatatu.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <CAM0EoMn6JoLVHdhX1GB1wBcw3fVZ42ePKXDqsWK-4STj87vEEQ@mail.gmail.com>
 <a3a68d65-9eca-41ee-a70a-0db8dbb0385c@redhat.com>
 <CAM0EoMmrrWhQigRLQLqhh+2jD1W_bboQGJspWdRhF66e4nspFA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMmrrWhQigRLQLqhh+2jD1W_bboQGJspWdRhF66e4nspFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/26 13:48, Jamal Hadi Salim wrote:
> On Mon, Oct 12, 2026 at 6:58 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 10/12/26 02:00, Jamal Hadi Salim wrote:
>>> Some threads seem stuck somewhere in the ether for sometime now. I
>>> asking because i have a backlog and dont want to flood things..
>>>
>>> 1) Sashiko nipa review is missing on the act_api duplicate-index series
>>> ========================================================================
>>> The nipa sashiko never produced a review for this series: gemini
>>> sahiko reviewed it ("No issues found").
>>>
>>>     Original posting (v1, 2026-09-22):
>>>       https://lore.kernel.org/netdev/QDISC-K1TH.v1.20260922072206@mojatatu.com/
>>>         [PATCH net 1/2] net/sched: act_api: reject duplicate actions in a batch
>>
>> We had a few PW outages recently, and that impacts directly clashiko. Also the
>> threading (new version in reply to the old one) tends to confuse PW.
>>
>>> 2) What is still left on these two?
>>> ===================================
>>> (a) act_api_delete_duplicate_index_refcount_uaf (links above). After the
>>>       2/2 delivery glitch and the two reposts, is anything still
>>>       outstanding from the maintainer side, or is this only waiting on the
>>>       missing nipa review?
>>
>> PW still did not handle the repost correctly. I think you need to send again the
>> patches, and please send them in a new thread!
>>
>>> (b) teql_xmit_path_pre_existing_bugs -- series [PATCH net 0/2] QDISC-6HS9,
>>>       sent 2026-09-29. Both Sashiko providers reviewed it: gemini "No
>>>       issues found"; nipa one Medium (commit-message doc wording) plus a
>>>       pre-existing, out-of-scope item (the consumed-skb UAF, tracked
>>>       separately). We do not plan a respin for the doc wording. Is
>>>       anything else outstanding before merge?
>>>
>>>       cover:  https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com/
>>>       1/2:    https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com.1/
>>>       2/2:    https://lore.kernel.org/netdev/QDISC-6HS9.v1.20260928064754@mojatatu.com.2/
>>>
>> I'm unsure who set the above to changes requested. Your reply looks legit.
>> I reset the series to 'new' status, but we have a long backlog, I'm unsure
>> I'll be able to process the above before PW will archive the post. In such
>> a case a repost would be needed :(
>>
> 
> Thanks for looking Paolo.
> 
> I can resend all 3. I probably screwed up the message ids and it ended
> being threaded to the old posting.
> How do i force it to "new"? Should i send the subject line? I already
> added "repost3" on net/sched: act_api: reject duplicate actions in a
> batch thread but it was still not reviewed.

emails are threaded by lore according to the `Message-id` identifier and
the `In-Reply-To` field.

AFAICS there is something unusual on you setup, as i.e.  the `repost` message
contains:

Message-ID: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
Message-ID: <20261003095453.4jiXbPK5mkXck0VOLiLu3sM9l-NGfDiZ4G96YKNDV-0@z>

where the first message-id refers to the original posting and should not be
there.

Please check the output of `git format-patch`

/P

p.s. I don't see a `report3` revision yet? also feel free to move this off-list.

