Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D84364EAB
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129699; cv=none; b=FAacuo23Kl2cMHec6kgecuYIv1H7QFBnvwa4NSzFCYLtCyM1egWcvVwovPxkAWw7zlfxRSGhBii41gyLtvRLFXIqxwURcsh1i+hRwRds1cg13jDgUIjzkRVgX6KLcXyFco5ieV5TcfE/A/S4m9vJsFJ1O5rkFXj4TZXGRzhm2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129699; c=relaxed/simple;
	bh=T9eBhUtD7DJAjCOIN5rHp+QhsMo7TcL7Rwzb0+0BgO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkD9njRfpbK1Rj1Dy/PSZYDj/fwgceAMJTXKGNPj+YJ4VUUeroox+Agwj1FnPrbWc0nep/BH8GZqoWuZjCKgYkIWE/NqxPEscwWGKN5I+QLCZjPHJB+v5swtCALdhYw+CHBITGv206f6pnNVP5yCVhBzCCb4ACFmWOjWap0+Q5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SuxbIDPy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqStyQB6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuxbIDPy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqStyQB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787129696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=77481jAD0+x71yyQI0+UVKtdPo0kVhQyKn2fVAxrMBY=;
	b=SuxbIDPydI70yPWC3f5Z+p2n9b5/s+5kABSkDztuqkaYiY2R8LMLU3Zsvn/Odw27oDYzXD
	D9T9XSk/+zMijakdJBFQP/l1Pm8jk5GVlfNBmPsC+ou8FVsQ29V323n5EinybTHiBbAB7o
	GV0Z1MvecshvERtj3FYobv2MDWHmO7s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-fvaUxhj2ME2ttnNqybQxtQ-1; Wed, 19 Aug 2026 04:54:45 -0400
X-MC-Unique: fvaUxhj2ME2ttnNqybQxtQ-1
X-Mimecast-MFC-AGG-ID: fvaUxhj2ME2ttnNqybQxtQ_1787129684
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f835ac1aeso470573f8f.3
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787129684; x=1787734484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=77481jAD0+x71yyQI0+UVKtdPo0kVhQyKn2fVAxrMBY=;
        b=dqStyQB6tJmJPnjGVKZPVUIAcxVbalm73sW8/RQQPwIY1Xih6xhF5c4T2stuX0hGgA
         wnyFU8WDtAWCuFPSIj4IB3YYlWzX1hKY4VIH8TzwWiY74M2YiceU7BIERc2B2rRZmuCj
         CrmugBrkuz+ygVxlrnE3zXKR8/dL95Y4p3qONJz5+7rmuC4ihPkh6MsRZJhF2JMnroKa
         I6GN8HX4xMks9DO589PwQwoCTYZf10xNsjEPfUjlD0HVayX7JJHJlKLarfqePhkZouNV
         5JwkpPRNR5s7lFqH5x+f07ujU5F3q6KPcNQg0ZtlYtk2ouImYWZ5lOTN+IWQFGKWoYMY
         pZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787129684; x=1787734484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77481jAD0+x71yyQI0+UVKtdPo0kVhQyKn2fVAxrMBY=;
        b=W9VHNcHmDAZkr7/1qyVHnGZKnBrPoiO5l6dRrl03EesRck5aQbUw1xPf1j0viq6arb
         DSZoL+1v5+7YCzx012WNSyU0hzLQnEcBHt5Ru4w7Nqe1hozlYiTEPKfEQep5rXKMCQLD
         2yfE8BidIvx2crySC00iOiizsH9VAZMSV3ZwIjQaDcz8reK4jij4FJUxaT4ef9K97IHX
         WbTE5EtUrqohSrmQpPaVyG43MJKv0sTJUYK7DUzSwY1UAyOo2OT8YHGD6+Pw0ZH4orxZ
         iKUEhXPdMvcFmToW3HP1n3+/JHiETqAEXh9Pdnrx779qzf9vUopMEhyurF0SERymbCte
         LPcA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9x3Seued4jXM2eAei6pBr5EZW7JsLgWiwQNjTimxcBVJLySsE2RORuiOavh6M/X1qdmyLHPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMyW9nP4ROfB3qyR2wV3qIYuz5hmLYFP3EpBTHV2jC8y7ICzl7
	98bhchGRNO0EDgkX4GwN4fm9wCsWM3RpHitKcc8SGa9Hs9Qq7URHJxTGSO4rlcSGnxSn3DAHWiy
	OC3grtwIdoQrXpfuV4dTNlsrOIuxiEzwANKkJcVbZpgUi6+PJYY9/FVpYyg==
X-Gm-Gg: AR+sD115Ks0wf6sHzWBxxCYf8XzFUVQ+tNLs8B+zAkVMKqjmPd0ldSTPXGJmGZNjQGZ
	eH1CVm7KGc33FzXvNzdHxBc5/jR0zmHnz9iHUdPjy3k3qvNA8RVF8hspI/S+zyfV3YWxwPRKHF/
	c4gKc7ODAj+eGJqP32Wd/P/coK0NrJ8JUJ8xnHMCZdsi9MJgLr/blG+vUxdKeTunFoVIH3ctpHV
	zq/eXpTfExLGUUyrVL2En7O7Wl9s94V8XOY6d5HFaXUYOdvVavZJ5wwKMPdADaSU+Ugczv+32xV
	hCV4KGVuxoEXyebP6effPaXYqJVG/hIRJttcts3O8hQIZyk3UOcN929GCSDISDGfVVHI+jL08OQ
	dSJswmjV5C1S926hr1j3MP8GI6EzFsSSaNyjeYNBwdIJzuybb43UM
X-Received: by 2002:a05:600c:3484:b0:499:7a5e:4c3f with SMTP id 5b1f17b1804b1-499aa14e6abmr65007915e9.1.1787129683964;
        Wed, 19 Aug 2026 01:54:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3484:b0:499:7a5e:4c3f with SMTP id 5b1f17b1804b1-499aa14e6abmr65006955e9.1.1787129683431;
        Wed, 19 Aug 2026 01:54:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fda98sm70253085e9.1.2026.08.19.01.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:54:42 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:54:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	leonardi@redhat.com, bobbyeshleman@meta.com, stefanha@redhat.com, mst@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it
 has connected
Message-ID: <aoVnp0w9jlyFDPj7@sgarzare-redhat>
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>
 <an5zJ9Uf94_L9TyB@v4bel>
 <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>

On Mon, Aug 17, 2026 at 12:29:11AM +0200, Michal Luczaj wrote:
>On 8/14/26 03:45, Hyunwoo Kim wrote:
>> On Thu, Aug 13, 2026 at 11:42:17AM +0200, Michal Luczaj wrote:
>>> On 8/12/26 22:13, Hyunwoo Kim wrote:
>>>> commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
>>>> already established") stopped connect() from resetting an established
>>>> socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
>>>> that moment, and the state can change while connect() sleeps.
>>>
>>> I guess this makes my fix incomplete. "Fixes: 002541ef650b"?
>>
>> It is incomplete, yes. But this has been triggerable since d021c344051a, so
>> I'd keep Fixes: d021c344051a.
>
>OK, I get it.
>
>>>> A peer RST moves the socket to TCP_CLOSING, and it is not removed from
>>>> vsock_connected_table on that path. connect() then wakes up, fails the
>>>> check, and resets a socket that had actually connected to TCP_CLOSE and
>>>> SS_UNCONNECTED.
>>>
>>> Thanks for the details. Do I get it right: connect() misses the fact that
>>> socket might have already transitioned TCP_ESTABLISHED -> TCP_CLOSING
>>> during schedule_timeout()?
>>
>> Yes, that's it.
>>
>>>
>>> How about:
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 622dbd046799..39c42ef016c3 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>>>  		timeout = schedule_timeout(timeout);
>>>  		lock_sock(sk);
>>>
>>> -		/* Connection established. Whatever happens to socket once we
>>> +		/* Connection (has been) established. Whatever happens to socket once we
>>>  		 * release it, that's not connect()'s concern. No need to go
>>>  		 * into signal and timeout handling. Call it a day.
>>>  		 *
>>>  		 * Note that allowing to "reset" an already established socket
>>>  		 * here is racy and insecure.
>>>  		 */
>>> -		if (sk->sk_state == TCP_ESTABLISHED)
>>> -			break;
>>> +		if (sk->sk_state == TCP_ESTABLISHED ||
>>> +		    sk->sk_state == TCP_CLOSING) {
>>> +			err = -sk->sk_err;
>>> +			goto out_wait;
>>> +		}
>>>
>>>  		/* If connection was _not_ established and a signal/timeout came
>>>  		 * to be, we want the socket's state reset. User space may want
>>>
>>> ?
>>
>> Yes, I like it better than mine. I confirmed it fixes the issue.
>
>Great, thanks.
>
>> If you don't mind, would you take the patch from here?
>
>Sure, no problem.
>
>Stefano, does this look good to you?

Yep, thanks for helping here!

My only doubt is if it makes sense to leave the `break` there, and add a 
similar check before resetting the socket, I mean something like this:

	err = sock_error(sk);
	if (err && sk->sk_state != TCP_ESTABLISHED &&
		   sk->sk_state != TCP_CLOSING)) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}

Just to be a bit more defensive, but I don't have a strong opinion, your 
version is also fine.

>And should any sk_err be consumed
>here, too? (`err = sock_error(sk)` instead of `err = -sk->sk_err`)

I'd stay with sock_error() to consume the error if it makes sense also 
for you.

Thanks,
Stefano

