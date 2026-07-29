Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CC45D5E0
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330247; cv=none; b=oY5p0wCzfpKA2Ci+BTq52c7VizsGQIM1D+RVbyu9M3cddUYs4Ioeg8vj+lUWp5nqDLIpZv/G77u4E+MXp5hiCCaFO+KTBac1MADSrSTEuYF860oLJujTPUShnUftQ8llTDPvracv19KGYV2VLmPOOn3ammIA8rmrcY5wB0ecBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330247; c=relaxed/simple;
	bh=rHONvYkRly4JHQc3sEmXa0oaad+YJFPHRPuElq78FDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj/fSpaSevVwDxXERrM1IH1uqwaqDayui/+ejhgNEFZvDuSx+Mvx4bNCzq9j9w5Ykk/nOttdMFCuaObuxpEmIIV11/ymhiIZSEJJXucjWqNe/X6aglYcnmiO5BpRaZFVhhhpiJ2TptQfeOQy7KK55OTqYTf57Qo1KCisHV1SqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1Nnk1J+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdMCNJ/9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1Nnk1J+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdMCNJ/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785330244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgeX7pS1oE7oOwVax6SP48v1RjAPFIqZjlMXeyQpwoA=;
	b=R1Nnk1J+u7A8eBnelBxWXZCYiR8D5VCpXwEe3U8jnDzUXvYx+GGIqlFBRLqjHeu0k7EqJV
	UeZc1aQPkR3k6dzowOZfTqKEVIADXxnfW1GWi9X5hCm4OLJJ7Z3OJIaBhTatSZrmBXr8Tb
	+zldX7NNtwgY0l6EadGBhSBYql4MBs8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-XRl8yPCAML-2W-ZnhZIdIg-1; Wed, 29 Jul 2026 09:04:03 -0400
X-MC-Unique: XRl8yPCAML-2W-ZnhZIdIg-1
X-Mimecast-MFC-AGG-ID: XRl8yPCAML-2W-ZnhZIdIg_1785330242
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-472a798fc7cso728503f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785330242; x=1785935042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OgeX7pS1oE7oOwVax6SP48v1RjAPFIqZjlMXeyQpwoA=;
        b=IdMCNJ/9VDa36uhbAh5LndJ7LxIYI7+v8PqcAmXFWp6CWBi0+M37dnt7NCdyHdbQCW
         5odY1Z9vQtyBJ90kiS84lfElaBjgqftbRIGQxo06Af5LBXmbhBre/1VGG65Ljaro5iyN
         z6YP23XT3L7mAHH23Ni+YlmjfXPdKMMsXiXCDVc87XM+7GButmJQJOLLkdgMT61EUtAi
         tI4vuaD3cg6ekVU8V6s9DFU1sBQTAvcaBMNkbvkvQ5QqmHMXM30WnOTX/VFnWc9mQiXl
         pDRhhVeJ6dhFZKs06CJe/2aCkorBHuhY/Q7rbF1wp22HChmACl+dzCZxE4LhphaPgcRU
         l41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330242; x=1785935042;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OgeX7pS1oE7oOwVax6SP48v1RjAPFIqZjlMXeyQpwoA=;
        b=QHDpyXtcRzc9NkmWh+LYcAMlCRVuvR0GuCtEVhkvaq0STzxwCwnQWH3sdMFvniTYoi
         LfnszHskxRqwy+oUE5+j25SvESA+G3v0tXGs4yCrITRa5acvomLB7TRZnoghi+2rQ3Ow
         VIEQtkeW251j12s3K/5IJVdpNz0FoQbLgTo4MbAVu8M9bYyZLMM5bdoc90dRWOivjCz6
         FwBEY3GzXzZn1WzrGlJWDPK9gd/4Vbh7YehDa7dP5JrX6qBwCJVSF5rosQKpO8Ny6F6W
         M5BtvWgfVVV6QxGovKQpJJLUHF1TL+GM4PJS1VYyavP0HBWzxOahRUNe37aAdhVsAGhG
         TVeA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8x6W+7m9ygqrBeksZDENb5oCxPNtitJY+TczX0bit1QUgwlXfV8DP22TTx/jPOaz2smhntkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/GRNlHfvrrAfMaQraWqpMGykkk9yti6ICxFqEQ3TlSRT9QLB
	Gv5PtTNwv2P52z6C0WdLZji1wjq09wQJZsciTX6NUGyuGiA41Bi68XDYqsS9Zh1iua61PZpJg6k
	Wa/Kdw27QTa3JVxxwg59irdXAaEIYqqZaZXa/I5/i04+77KPxifOI0xt6qA==
X-Gm-Gg: AR+sD11PnXE7OXfSIL4shd3PtW3wfFkLzsU7uHN2l1toyakg8ArdJiT4j4W+52OfdyN
	snZR2drqumMH/v/utyEfFHJCBbKrsAmgZEqvKCFQzAPRDR6eT00mGzvI1BZn5pa5f8IgkxjaZlF
	wMGpLXmjdDvCwi3UqDsmyXeNt+3vIjobWcsxbJrWyb8coq74Tiav24k05AwVXX5S6HFA9K57dnW
	PuQz4jJVt9RBnOlR4QuxQjfWSnMdFlHBMK0j6S63IC/NvN2CXCipVF/YBWd5iX0UDGj8zK3mVIL
	ennJYwITWvp3tDKc3OZFkImVCSpcpKP1KhH0jCO0HWpPE+ZPGZsH9gQPExSvT+0Wbeshusms12/
	p/JwuLGOOtzBpOPAZYRM8uJ1UTSxtKyl4QSesngtSvVo=
X-Received: by 2002:a5d:5d06:0:b0:47f:947a:9dba with SMTP id ffacd0b85a97d-47fb1e5ce09mr9025386f8f.6.1785330241691;
        Wed, 29 Jul 2026 06:04:01 -0700 (PDT)
X-Received: by 2002:a5d:5d06:0:b0:47f:947a:9dba with SMTP id ffacd0b85a97d-47fb1e5ce09mr9025298f8f.6.1785330240970;
        Wed, 29 Jul 2026 06:04:00 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0f295sm7727863f8f.22.2026.07.29.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:04:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:03:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <amn5vWcyY0f5ErEM@sgarzare-redhat>
References: <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
 <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>

On Wed, Jul 29, 2026 at 05:46:29PM +0800, Nguyen Dinh Phi [SG] wrote:
>On 28/7/26 16:21, Stefano Garzarella wrote:
>>On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>>>On 24/7/26 05:43, Michal Luczaj wrote:
>>>>On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>>>...
>>>>>>>>>Yeah, we need to handle that part better, I think it's 
>>>>>>>>>a leftover when
>>>>>>>>>we generalized AF_VSOCK to support more transport than vmci.
>>>>>>>
>>>>>>>Speaking of leftovers, I have trouble understanding where 
>>>>>>>does vsock set
>>>>>>>sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>>>checks for it?
>>>>>>
>>>>>>I can't also see where it can be set TBH. Should we remove it ?
>>>>>
>>>>>I couldn't find it for listener side too.
>>>>
>>>>Removing sk_err handling from vsock_accept() solves the problem, right?
>>>>
>>>>thanks,
>>>>Michal
>>>
>>>Yes, confirmed, removing sk_err checks from vsock_accept() does 
>>>solve the problem.
>>
>>Okay, so maybe better on going on this direction. WDYT?
>>
>>Stefano
>>
>
>I'm still a bit concerned about how connect() and poll() interact 
>here, even with the sk_err checks removed from vsock_accept().
>
>For example:
>vsock_accept() now lets us reuse a socket whose connect() failed (call 
>it r0) as syzbot reproducer does. After listen(), r0 becomes a 
>listener (sk_state == TCP_LISTEN) and works correctly -- it accepts 
>connections.
>
>But poll() on r0 still marks POLLERR, even though there is no error on 
>that socket at that point.
>
>As I understand it, sk_err holds an error that has not yet been 
>reported to userspace. In the blocking vsock_connect() case we have 
>already read that error and returned it to the caller, so it is no 
>longer pending
>Shouldn't sk_err be consumed/cleared when vsock_connect() returns it 
>to userspace?

Yeah, makes sense to me, I'll ack the v2.
@Michal WDYT?

As cleanup (separate patch), should we remove the `sk_err` check in 
vsock_accept() ?

Thanks,
Stefano

