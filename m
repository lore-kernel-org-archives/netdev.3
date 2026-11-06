Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008877;
	b=ExvrWerlK712wxLEJRoHiScQ01H518qatjCguvalKasNuiewg5KlA7bVWg0RDO+hLdeq
	 q2VE/Jrth0KcLBs1MWkI24XZOvnedL7XMNWNDzOK0aLA0NlaVNsBHPRIauuRzvNuglwIf
	 /iHT1yLA7q6h96M4u6kS+W2O4uQgis0QLbQwywgZm4M1nnPiqe24PfsVLkrs9U2I6cnTb
	 +ZV0rruA6gvhD1cmMljCOamoMJmbsBKiZ1IjnDnP8qSkYONOj+5DA3ndFHdr8ScfwxpD4
	 Y3KnasffDBkQgP7gmOfKdsPjdaXZ7qzeKux5VEK4JuOZy7VDY+h3JibVvMwDGpTF1jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9PEBKf2/jcyA/DUFIiQ2NEHydLhTL/AGWCVcR+QKvC4=;
	b=HXrPzS0QSXlA+3h2r4AgxZr0sdXDaOqZehZ1+vA2D9bDfY+wbCskdXypzwwnR4MdDBsV
	 cq5A0bqwdXIQxtwX74qxiVTzTrmjCE1nw26XjnXSQzaOgTkdp8MimncLvvpXqDJoSoEDE
	 D4kwwLRlVRRtfzH8xWgQ7/fDl6JBclAUoEoFOIFNnUDqdsh8MMuXNEMAFn9x1+Srp90Qq
	 NBR69dC1LH5Gs/FHwh1NDypZYIgyq1MUjtuIVxRIp5P054kybXDJxq8Lq8GleAutlNfTS
	 DgkFa+2Khi5mb93bWtvLuRLE5gtLiosAjWISaXOoMDWVTEekj3LEUWSyQwJxs12hsgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TV5gJVy6;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5AC606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TV5gJVy6
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36f8cdd30beso1848625eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 15:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794008875; x=1794613675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PEBKf2/jcyA/DUFIiQ2NEHydLhTL/AGWCVcR+QKvC4=;
        b=TV5gJVy6puZ6BC8Zk4J1m2BEbcpxTcPAAb4T9FwiuoUDWU76SCrC7begEbjqtResbK
         Q37ewTtQtZiBAX0weE16K+wk5ZgJ1LwZl0PjYsFYXfqHqTzCZaYIdLUbos6t3HYB9Lun
         Hcyqeylu8qPXvzmMNcXEKyIuBOxcE7wDxDf4emP7sjc2h5Ipdy47EGMuSO5cLf+7KjBt
         EUabKhnWYrPq0KxaiPRFmQA8tgqWk7K09H/VfbPXQos3EVZnn/0MOw4JR+AmdebcHilj
         U+zBoixol/yrKvFtEGzwYoHN8iSM4ktElV2NaLrRDFGGc09LaBAB7NgypObDU2q8N7nH
         7V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794008875; x=1794613675;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PEBKf2/jcyA/DUFIiQ2NEHydLhTL/AGWCVcR+QKvC4=;
        b=s3ao+ymkCNRJkICLcSdKA6nTjyM/9i0zjSc71d/jBiECneHdu2ZwnYUs704R4A5x6f
         /mCUfJWJgtKaXPn2bEi5pg5WoyQIbdtFKM1urb7iCXzKoFMmR01cloA0MvOyj+EATUfr
         oILF/71lSbx4qNIzHCRuTjyhRAEjpKAfoa740sSO6wL8uMV6v0XuUm/TXX9X/2t9Y+UT
         XazzLGMD9yYfaJhaI8e5TVCwqfbaovrd26EDdqvOwTW6b1ROLZcpSXSU8D2C4gcuKmVh
         ZMnDao5PZzrLFFxU79PCCzoe93gcPBn7BmoU1OIYNxDGIi/n5RiOSMIBibnr0tOV456S
         1QhQ==
X-Gm-Message-State: APuU4Z/h83BGJkOxvxWfnCZ0J5B3o7H/CuCllEejjF3E916fC0kW+qW4
	8UQsum/4/CzOkS3aHimr2+lS4Mrh42OX4CG1XEHh1dJsaPZ9VD1d0dL8mnnVwpPtdW4=
X-Gm-Gg: AYBFou1G8dc+Zehlpw9x+Ce1QWAgfw6M1WeFoffvRMgolvhZscZLwkCiSk7Vu1bOOu8
	aig17OvUhHBbi3VVL6ejjtICLGdmyY9LLvkLUAlUUspuxni1esQ+14AXqbRCGyeBGt8NZ8y4R4U
	JKrvvGKTUXayJxc5C0bQhQlkw22mL8MoFmwWCSvbGhtLf4yB1eAin7Wr1DWTYQnDOLIioos9xSy
	atYoLXo4Q3rfYCvnVJysLWuVgBOJ9BQHOcN39ySWDhUe+zHs17/KzRIs5S3jEo1BkBvjAD62yLV
	2OSCwuS+yclxcbAKl4yShS2xwRxbs4gP236ZdzxQPhnTlr4YFM1wsuQ/H39q8iCgpEr74xZWpzT
	IPfO9wxj2XdLWuLgGR+o8wq/7hYiZtP4uQtYMyKG9NVn6ssdbWFDbAkm0P92q+SZ5FQK3/d1Fmt
	tRzHsUPdTajP64pj7hyHlF9lUvAmP7+pPPemU1ckGyhCuo6qf6lZJt2zcCN3jp3xRItSNGzsd77
	DU9WUrockjv9q1FxZiJ+MZo7oUUsR5qpPBYsfx6QKiJ8FX888L02aDGLSc23JdNXVl6yETWTkfJ
	+zoYLZrw0eMi5h07R3WxH4y9pf1lHX6ik5hJi5bv8O1DnzyuAnuim4UgzFu2fmdTbDGd2pAJ9Kp
	7ZMnTcl0SBCk=
X-Received: by 2002:a05:693c:6096:b0:36a:1d6a:596b with SMTP id 5a478bee46e88-36f77200d2dmr6527344eec.29.1794008875034;
        Fri, 06 Nov 2026 15:47:55 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm12242774eec.10.2026.11.06.15.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 15:47:54 -0800 (PST)
Message-ID: <236f4ed4-7ee4-47fd-9f3e-f6920035b2e6@kernel.dk>
Date: Fri, 6 Nov 2026 16:47:53 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: leave O_NONBLOCK to the sendmsg and recvmsg syscalls
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <f084de67-85b0-4759-845f-513879ebee5f@kernel.dk>
 <CAL4Wiips_uVD45bC2DpG5BqywmueUBB_wiNCnd64hNUe8YsH2w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAL4Wiips_uVD45bC2DpG5BqywmueUBB_wiNCnd64hNUe8YsH2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 4:36 PM, Eric Dumazet wrote:
> Le sam. 7 nov. 2026 ? 00:19, Jens Axboe <axboe@kernel.dk> a ?crit :
>>
>> ____sys_sendmsg() and ____sys_recvmsg() turn O_NONBLOCK on the socket
>> into MSG_DONTWAIT. That is right for the system calls, but io_uring uses
>> __sys_sendmsg_sock() and __sys_recvmsg_sock() for a blocking attempt
>> from io-wq as well, after the non-blocking attempts with MSG_DONTWAIT
>> have failed. On an O_NONBLOCK socket that attempt can't block either and
>> the request completes with -EAGAIN, unlike IORING_OP_SEND and RECV,
>> which call sock_sendmsg() and sock_recvmsg() directly and don't look at
>> O_NONBLOCK at all.
> 
> Makes sense. The socket.c side looks fine to me: all syscall paths
> (sendmsg, sendmmsg, recvmsg, recvmmsg, compat) go through ___sys_sendmsg()
> or ___sys_recvmsg(), and the copy_msghdr helpers only care about
> MSG_CMSG_COMPAT, so setting MSG_DONTWAIT earlier is harmless.

Thanks for checking!

> Fixes: tags? And please tag the subject [PATCH net] if this is
> meant as a fix.
> 
> Fixes: 0fa03c624d8f ("io_uring: add support for sendmsg()")
> Fixes: aa1fa28fc73e ("io_uring: add support for recvmsg()")

Good point, I'll add the fixes tags and the subject.

>> Move the O_NONBLOCK handling to ___sys_sendmsg() and ___sys_recvmsg(),
>> which the sendmsg, sendmmsg, recvmsg and recvmmsg system calls go
>> through. The io_uring helpers then pass the flags the caller asked for.
>>
>> Reported-by: Luk?? Lalinsk? <lukas@lalinsky.com>
> 
> The name lost its accents (Luk?? Lalinsk?). A Closes: or Link: to the
> report would be nice too.

Man, not a lot went right in this posting... But yes, it lost it. I'll
add a link too.

>> diff --git a/net/socket.c b/net/socket.c
>> index 2e3b5737c481..08658a9b8065 100644
>> --- a/net/socket.c
>> +++ b/n
> 
> This header got truncated, so the patch does not apply as posted.

I'll send a v2 :)

-- 
Jens Axboe
