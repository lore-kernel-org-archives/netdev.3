Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0448CD7C
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331824; cv=none; b=aV+2LEAk49Djx29KBFQhnMzOf8pG1451b3pl7q6Y1Ns5oBR1kteQ7uaTnVbuRJs5dzSXpLWwcDENQ9ve/bk2kB/QR80lTJtslrJWi5R15cC14xjoQsWrxjUKcW32SP9pXGXLHyFfeUsvQguBPW5QrvvdwAb7nt4jZGScpxZUva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331824; c=relaxed/simple;
	bh=x22GjEt7cSW637vYD40FSL+sH3AfZF5w9reTRHSznvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfyezF9hlnitaWoJJW1ovRN55fL8nyjzY62Sw6NubzAh1oYQqaUSx6hRB+yZ5HYfVLrjL1/TtrmImGSB2vBtIpzYdOLyylPbkSk4nRsOtUys2vw74XJ0/PFJeScOYtS4EwOe/ehH95wdl59U/gznLgvBAUiogHx3gE3jApnCMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erlubRBB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kh7+B2k8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erlubRBB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kh7+B2k8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785331820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0L1AfMh9DvsxqBN6xA7q5Kc35M/kq0HbrYUCNpZ7Miw=;
	b=erlubRBBuvH2DrKDVclWVwZKP3lPM74Tq+f+KbnZ9L8yaV2NNikqcW341o5xJgDva+IsqC
	H3sRKiGnX6N2ZkGESq4JGgle2GB3EfFZhLcOg+JF0u1YVP3f7nkNVYdyppZUql3BCe9N7N
	mTBWqRxgnQFsIEMN3Wk73IDDUWpLcPg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-A4ANqDHFPTuBxKcu8EE66g-1; Wed, 29 Jul 2026 09:30:18 -0400
X-MC-Unique: A4ANqDHFPTuBxKcu8EE66g-1
X-Mimecast-MFC-AGG-ID: A4ANqDHFPTuBxKcu8EE66g_1785331817
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495569acf8dso6899225e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785331817; x=1785936617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0L1AfMh9DvsxqBN6xA7q5Kc35M/kq0HbrYUCNpZ7Miw=;
        b=Kh7+B2k8ILNzxDBAn5b9z8hl2eX2CUX+tls4p4Hwn4tybEHjcyG7++KPiPoeCOJIBg
         EdYuIBRpmjKssmEwpbYx3D+qiWtP5hsakHl0otFaEYCttbWY3+b0Ebdir8wpsd6gMCV8
         CejvJ56Jv5k6uOxuz9q9lpNesEI/a9QZHpWg5WeT4SkgNue9l7ijg7B9im5P5RNHnZMB
         ZhIh33VdlJ1ihLgIE9M1GwrvuZPKiFoUshFNkF3HFeMcMxAyz4Z5OYsxYiI5QQCicXaa
         SGg9Rq0+h4mXTSyTgyzLzrrmA1Qwkp2CKik8p0dpq+Odt2VGhLNMien19bZKLzqPbuj3
         D1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331817; x=1785936617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0L1AfMh9DvsxqBN6xA7q5Kc35M/kq0HbrYUCNpZ7Miw=;
        b=qh6Z5IN1xoXWyAEDgXjPG4pZ9B/0D44J5r1KjIcu7WXTihbPPnNNBYEFhjCSMqjSlF
         tDToqCK+O+eWGd8WBpOV0ngZwfl8zk5HNWePF+cj37tX8IBsrNpBhZ6CrFHtW4VC6pBG
         9NSKqkZYQgzOVFoF7o/2703wtdlcLy6LKeFVnv0ekPBNi4ckDVks5f43pn0+8TZ1XWcO
         +Fhl1B5kGF62B3qzDyhXDPjhNIgMwfswZsSsZn8+fXxQUE2/MEtD9mLc9Neu5kB6BiFm
         5RdjjpnXSbZtJYdb4U+Q1IisqvnROnsMY6EwDD5Tp8xitazhtvwZiff3Jf+qZshUzcE9
         lHdw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4T6RcNocSdBw8GbhwNSlcvP3D3GownftQMOEoJW+qL7dacq1sg5Qx4IKZXdtirHFKGoiWcbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYhepXIfLnITwAhYEcLlg+zjBZ1J4fyiBZ5S8Nvx4ns3EqTjf
	30Ngs220ER8YGJvaq/7QV4fsiO18gPlgdJC93JI0RD2/68W9k8zUVbqdcUCD1pWgf5QrWc/hv5d
	G264dyj+WRse8srdOqn0pf4FZFzMOedqV3UhqokEGrgLCMcffhRyQ3RVejQ==
X-Gm-Gg: AR+sD12wxj2BCIV1ygJFcw/jIvdpwOa/LYSymgdgdlXu9iazp0+7M0b/YRgsXXp+6E9
	us97zqJEpuK6P/fyY9eGUmSm58b+5LaWCB/WHXyo+wO/RKWKDveFiHmQil9dM7KVuxs+AnP6aoD
	STVWNN0xCeADRkWI51wp25YwEs1NRDAHsQGYIF7aeNC8DMOGPai06sIjIc3NS7chkemTbblE6x8
	qRXZyW1ovwj89A52pZnzasKUJAWkRAbRBNErCWN8yHCgIV43B+mEi0Ie0U/tyR9xz8aqAlmYN5H
	lVP/t+xIGXUP+vXuJ2Ureb2whv+r9Z0ZHK9p5/9DSpuQPZRu3L2L2zXP/FUHUmAstUf8qUvd55D
	PcQ5n1G1p0vrxfjp5wzSwi8NvY0t8sYy4Z4iU6E67enw=
X-Received: by 2002:a05:600c:4eca:b0:495:7379:17b1 with SMTP id 5b1f17b1804b1-496c6585036mr74945725e9.30.1785331817193;
        Wed, 29 Jul 2026 06:30:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4eca:b0:495:7379:17b1 with SMTP id 5b1f17b1804b1-496c6585036mr74945125e9.30.1785331816437;
        Wed, 29 Jul 2026 06:30:16 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef48sm7507460f8f.21.2026.07.29.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:30:15 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:29:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <amoACichDryCaVsG@sgarzare-redhat>
References: <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
 <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
 <amn5vWcyY0f5ErEM@sgarzare-redhat>
 <e7ff506a-850d-4d7c-8346-c6fef9ad8553@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e7ff506a-850d-4d7c-8346-c6fef9ad8553@rbox.co>

On Wed, Jul 29, 2026 at 03:20:38PM +0200, Michal Luczaj wrote:
>On 7/29/26 15:03, Stefano Garzarella wrote:
>> On Wed, Jul 29, 2026 at 05:46:29PM +0800, Nguyen Dinh Phi [SG] wrote:
>>> On 28/7/26 16:21, Stefano Garzarella wrote:
>>>> On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>>>>> On 24/7/26 05:43, Michal Luczaj wrote:
>>>>>> On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>>>>> ...
>>>>>>>>>>> Yeah, we need to handle that part better, I think it's
>>>>>>>>>>> a leftover when
>>>>>>>>>>> we generalized AF_VSOCK to support more transport than vmci.
>>>>>>>>>
>>>>>>>>> Speaking of leftovers, I have trouble understanding where
>>>>>>>>> does vsock set
>>>>>>>>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>>>>> checks for it?
>>>>>>>>
>>>>>>>> I can't also see where it can be set TBH. Should we remove it ?
>>>>>>>
>>>>>>> I couldn't find it for listener side too.
>>>>>>
>>>>>> Removing sk_err handling from vsock_accept() solves the problem, right?
>>>>>>
>>>>>> thanks,
>>>>>> Michal
>>>>>
>>>>> Yes, confirmed, removing sk_err checks from vsock_accept() does
>>>>> solve the problem.
>>>>
>>>> Okay, so maybe better on going on this direction. WDYT?
>>>>
>>>> Stefano
>>>>
>>>
>>> I'm still a bit concerned about how connect() and poll() interact
>>> here, even with the sk_err checks removed from vsock_accept().
>>>
>>> For example:
>>> vsock_accept() now lets us reuse a socket whose connect() failed (call
>>> it r0) as syzbot reproducer does. After listen(), r0 becomes a
>>> listener (sk_state == TCP_LISTEN) and works correctly -- it accepts
>>> connections.
>>>
>>> But poll() on r0 still marks POLLERR, even though there is no error on
>>> that socket at that point.
>>>
>>> As I understand it, sk_err holds an error that has not yet been
>>> reported to userspace. In the blocking vsock_connect() case we have
>>> already read that error and returned it to the caller, so it is no
>>> longer pending
>>> Shouldn't sk_err be consumed/cleared when vsock_connect() returns it
>>> to userspace?
>>
>> Yeah, makes sense to me, I'll ack the v2.
>> @Michal WDYT?
>
>I'm worried this patch does not address the non-blocking connect() case.
>Could vsock_connect_timeout() set `sk->sk_err = ETIMEDOUT` after connect()
>returns?

This is a good point!

So we still need to remove `sk_err` check in vsock_accept(), or set 
`sk->sk_err = 0` in vsock_listen() to have a complete fix, right?

Thanks,
Stefano

