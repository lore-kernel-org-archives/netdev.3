Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADD415B6A
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268258; cv=none; b=DfqKVMMj3QLT7dkSXHI77M1QOnFalGf1cPUc3fGCOk6KYz2bCVLFi5y2wZHRZxsnD+13kJeFpoTWhcf0RuvcS4jCt4g/f+9Kg7qRXn85lx/oSlzQI/d4HoOxwYpifhs9O5JaCREM8tCpptZYojsUkP/v7TfU1Eq4kHu270/htnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268258; c=relaxed/simple;
	bh=tBjGMbgH0+/QtqztfUzVvL+Zq/3AwhNosE/C7rrmmXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlmkUe58oKRiK8A7y/OEW0EtuiZWp6zdWIcsI0D74jMz5BNwBltnHoNU2GzDI/BdotUHNm81QjNopW8K75XlyDy9F/a3vIxF1ya38hYrbewO67v/R6LxpWeUav5/0DYr7VD3vQDXuDC4mHXsTHJ4g8lWtIYyeDXQvZAOTIPR7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AW+zKdVs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0rdmRTH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW+zKdVs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0rdmRTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788268256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rz6yJ8+pkez9yE6YuAvQLFRoXedM5uKIja1eqbD9dqM=;
	b=AW+zKdVsjziO2flJOOMN3mEdH4z/KqJLzgA6MzG9yQg1J57L2c68CA/OvF/7t1UqXsuXWX
	OIUaUsaXosyz6WMD70BY/l6WM9OUpX7uRjdtXtVPRRXsftNAajsy2h2XuhY/tI64XPByCc
	+k4Ho+BCilHO/xZN8ZdQZhG6MFY218M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-0c2178u2O4itA8m4gp3mRw-1; Tue, 01 Sept 2026 09:10:39 -0400
X-MC-Unique: 0c2178u2O4itA8m4gp3mRw-1
X-Mimecast-MFC-AGG-ID: 0c2178u2O4itA8m4gp3mRw_1788268239
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48439ef42d8so2269991f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788268239; x=1788873039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rz6yJ8+pkez9yE6YuAvQLFRoXedM5uKIja1eqbD9dqM=;
        b=f0rdmRTHRhI9VsWnSGmajkfdJJRDlSIZojsAJsZQZrpD05npe8qa+l3fPcw4pWmMxu
         lY7tE6soE4WsPPldmeiQ6LXjC9QuX6M/rDH+uIuk2v5vlWzrjmaZkMoeD2j2LxQ/7NM0
         HfHS+uxN9aR5/Do1332C1KwWWWOTQ/xr/YSiM+e0IMMOWg3vTHm7JDt+iUmFznBpEnFQ
         8DAmb1PIb1sayPIYvOiyh+3cQn2xuNyAjc/ejlVRBfLgu36Bb3xiSQFauikwTKVPr089
         LywzKIH9UdM+DIAq2OJg+nxo/0wIB887l8qziQbYZykCBPq9CMuxz0kSWlFGaj90+kZb
         CVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788268239; x=1788873039;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rz6yJ8+pkez9yE6YuAvQLFRoXedM5uKIja1eqbD9dqM=;
        b=Yi/C3Z9LMTsvJ4gmf8995XIFdxpRnp15xUfrQeZ4bgf8t52qm/AfUEz+yo/C1KnCbv
         6TA2xXp62sJxubQHgE9wb5KcfrIEny0pPhzioX8gJwdd6PBoQF3KnXAnJiIk8oKd+I6n
         GqxOPuYrwdk07gMqty4JelCZLJ7U4OBpc1OZ7fH4uMy94SjZHj0qeGAx+VrZHfoPsmUV
         vAPX5D4ChqFtVUgJl9LHCWAjOjx3tq8VB6zAWxFLRjiQgugNVKL5krh6BiH7cb5ekFuw
         NlXyTY0QteNOxfpNa8w/ZwLd9jsDlIne7lzxaInpKeowK7F7fPcyzSXaqh8YoYtQicVL
         NYhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFbTHeMg76udxLxwZDvmgjMnf1rZf1ZCpFLc8nWqC7ZgdMapmOxeQ91D+8BxkfyqrxAzN6Do0=@vger.kernel.org
X-Gm-Message-State: AFuF++mkIdhQH9J1z0TRxNBZVeTeHjxcxTHcMLJhdXjAq+WZ6cnRkM8V
	4yDM9e0IgWg+SBO9TUlyum8VrJYHKd4/hQQ7GvgCblA4kWTLlMYp1q4ZJ4haoB6smwF9xixo5tu
	SunJYOPn3Sdc7XpuLQae4DQvGl80hWUcwAGeGiJXHuKZXI7cGZ4XSW1VN1aPfqSS+8A==
X-Gm-Gg: AYBFou1NtZv/Hk67FkLK53P6ASnFyiXfMOxDLNK0woMr3nvRH/2KYu3v8YskVLG7xYY
	Hjs6mz2VnIs7DHgoJYS2XBX55X+g0d78xuF4IBQ3R1PvEtoNdPiz8b9iyFqmk4OYKnB1YIBAifj
	+GMPILDQLN2SfJ2LMHY2GzRW5Kwx8PMK7kepaYhlcLkH3QFy1JJDRiihEsXXvrszHYN5PTlAHjT
	iN0xWeYQ69/K6RH7uf/Za7oRWFHveaPs74mmWMBWh1Oj8Bi8D3mg8sKy2BB8sKyxoTYOvR0fUw7
	Eyrn9RHnr/dYeQ1qma2uE295rtQVYPI/AGuvIZuMju4Q069iwbtNXgHhV6gmXAZ0RMYgc3YrB6z
	rSQUSaSy2SYSiowgn4r0DGrv8WTNglYm8vTIohvZuqydmCFkFZovyuRfT3OLvQ3wNtWDAnIZiyw
	==
X-Received: by 2002:a05:6000:2208:b0:481:512b:f0e7 with SMTP id ffacd0b85a97d-482f79f36d8mr30391038f8f.17.1788268238675;
        Tue, 01 Sep 2026 06:10:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2208:b0:481:512b:f0e7 with SMTP id ffacd0b85a97d-482f79f36d8mr30390847f8f.17.1788268238057;
        Tue, 01 Sep 2026 06:10:38 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d3c4absm4931885f8f.10.2026.09.01.06.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 06:10:37 -0700 (PDT)
Message-ID: <9a067a8a-6730-448c-98ca-db10fc2c64d5@redhat.com>
Date: Tue, 1 Sep 2026 15:10:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: psp: do not inherit the Rx association on clone
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
 <924455c8-9f62-491f-ae3c-ea2127f46769@redhat.com>
 <DL3ZAJ3NEDKQ.2ZUNLEUPN0JIF@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <DL3ZAJ3NEDKQ.2ZUNLEUPN0JIF@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 2:28 PM, Daniel Zahka wrote:
> On Tue Sep 1, 2026 at 6:01 AM EDT, Paolo Abeni wrote:
>> On 8/29/26 6:56 PM, Norbert Szetei wrote:
>>> sk->psp_assoc sits past sk_dontcopy_end, so sock_copy() copies it into
>>> every socket accepted from a listener without taking a reference, while
>>> inet_sock_destruct() puts for every inet socket. psp_twsk_init() does
>>> refcount_inc() for the timewait socket, so a child closing through
>>> TIME_WAIT cancels its own put and leaves the association with one
>>> reference and N timewait sockets holding the same pointer. Closing the
>>> listener frees it, and the timewait timers then put freed memory.
>>>
>>> Rejecting the association on a listening socket is not sufficient: a socket
>>> can acquire one while established and then be turned back into a listener,
>>> because tcp_disconnect() leaves sk->psp_assoc in place.
>>
>> So rejecting the association on listener, and clearing on disconnect
>> would be enough, right?
> 
> I think that would solve this problem with sk_clone(), but clearing out
> the psp_assoc from the sk anywhere other than the socket destructor
> makes me nervous because of the risk of leaking cleartext to the
> network, or admitting cleartext the receive queue.
> 
> Specifically about tcp_disconnect(), the write queue purge won't save us
> from skbs already queued to the device. 

Ah, right, I did not take in account this path. Makes sense.

/P

