Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0EF3769EF
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784780099; cv=none; b=lFtr7xRLf2YgXGqqB9xO9sdT3tOLbHMLW2k4otvgfHnLrQCX0ZSAvObosTZkGQm3gT8s5v4Bc3+SBjjA4pgvOooV/MNLw+IgF/RDq5zQgO7t7qbF8Of5+DxTilMwGHo1KeaQEYucvtBbz84t24lRwVTV4WgOgxvMexPHoaHA+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784780099; c=relaxed/simple;
	bh=eLbfW63CJW0U5KMBsAlteJLD1uU59Z2xXAVfZF5vnbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFHOZ31gWRGgeaH/UfxTVMxM0cJJxHGU0AqPq+Z/H7eRtMBA5W1+YMqdzeQPM+dVv1Rp81XvM+fF3/nLT2bSgmnim2nFi+aAoSfqeqDKEOGtHvgsbsACmQdHSzPkNX7LqQSk1LaBSAFEEvygo5QcBx6hetsfVCwYn5mhxzlxsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4a/uQVe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4a/uQVe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so2231915ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784780071; x=1785384871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZBWgpdwomFlA7goEYUZgNUpcpQ2jgXmDN9Ar8IJzpw=;
        b=O4a/uQVe5IgPQTDIp9S1w6gGLgXIC06N7dY9wo5yKE8bqfRaQGFR7oiYB+v+EN9X9j
         qD8sVur2hGnm0JlBPLolk3JpI3HRbmI+Ip3QAOfDKC3oZu/AuEeAK40Q6cP62BOF8O1T
         5PGl8qtSK6ZntEXLV107IRv1eHaZZWhxw+BB01uT+0U8BE/IYYdCUJ6RnSRTUGYVgCx3
         LeiXU0Dt7xKBsJuc0tOzWFifqaUjsGP5e1MF8tO36xBFRjVwmtETUStN7art3Y2Qu+2j
         U2iYrjS4esNphROjhGfZOnxn9ZCi5HhYtYywU7+jGnCYuqqjjWuwVW1wsZilCjle4Ms4
         CN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784780071; x=1785384871;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZBWgpdwomFlA7goEYUZgNUpcpQ2jgXmDN9Ar8IJzpw=;
        b=sDBAAax55LjKQR9TCwhnWYoB0VhBTvq+EOERtJG07CoN5rLb9U51XzwByGJDodJ520
         hPJ+wpnbatleJerIQLOREq2CkX7EA3LvV8XGnfccrphWE7oqeDGVf+qOWg5lWAhZ3O2x
         jPT28Drob35vVP0cqEbCLdXFQC6peh93FAskzqreDQbdDfvyM9a2XeYkXTZzO5+MhmwQ
         fLKdj6hP+Kiojjn+ablNNl8AP9W8gcPPUDbkfwJjB8FEAGv9QmoRx8uATYMuFYkWAn9f
         4AwTECkvyX2MGPuGcilL1Fle41xe5UybQtn3Vpu5mchmYZ4dY5/0xG2yR4EG0x0fvmwy
         czoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJoX2InyfiX1j2glYIeE+I4z2oXfsdixuzt5c1fQafUjueuEG29cp5VGz/L5b50HFqWdfObfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNGDldR/Ja2jNqR3FXy8iXuvoQ2AFecxA6VaP0W/IFVYG9O+/
	7ui/fo/6gPTT4kClnSa2X4XW0rrjbpTv1Mxu/YEvEHkYlWl3O/kmmbC0
X-Gm-Gg: AR+sD13N7d4hdTvFY+W+4HXQNCp8TeC2BO1G/NGo2Zexyo2cIY0CoXsFrOxzpSUT5mS
	li9BugMfsileaEtg9aimhvv65H+C1Kn5dFt6w+qYhA1phiuOYPbM12VuAchldx8IKFVvc/wBvYI
	G44MBl5QAe3A1gv9yxeUabr/6voB0pChgTyi5rGUqdxTvAI/BMNDbegjBAAk9wn0mEv3qv95tSt
	QziMh7a/Bu5GjlqjgRMQPV0B2Zdc8wCepFJVoCfhh9UfuTi8lYVjd1yWun3Mq4fPE4YmXLYQwSx
	J7HwU2UjyXP1rv5JCiwgIsJ+cb7vWFpMinBFamH4t8ogwr9xiAXKhuEUdFtQ1+rFxtT2nFOPZrj
	PzezkOXNfsZ+FifdmFq97RiCkmiMnez7YY9dnDDO/UaH/f06R//4iehhB42gzQHbR7qtNtLDWUE
	RuXozsAD53GLBvIy/2t9VB
X-Received: by 2002:a17:902:e80e:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2cfa6b7d0e4mr19002335ad.9.1784780071120;
        Wed, 22 Jul 2026 21:14:31 -0700 (PDT)
Received: from [10.22.76.22] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5e9bsm24915255ad.50.2026.07.22.21.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 21:14:30 -0700 (PDT)
Message-ID: <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
Date: Thu, 23 Jul 2026 12:14:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <amB15TdzPAEk9A9C@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/7/26 15:55, Stefano Garzarella wrote:
> On Tue, Jul 21, 2026 at 01:34:03AM +0800, Phi Nguyen wrote:
>> On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
>>> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>>>> After vsock_connect() exits the wait loop due to sk->sk_err being
>>>> set, the error was read but not cleared. This left sk->sk_err set
>>>> for subsequent operations.
>>>
>>> So, is this a fix? If yes, we should put a Fixes tag.
>>>
>>> Also, can you describe how to trigger the issue?
>>>
>>> Because I see this in vsock_connect(), so I thought it was in some 
>>> way already handled:
>>>
>>>         /* sk_err might have been set as a result of an earlier
>>>          * (failed) connect attempt.
>>>          */
>>>         sk->sk_err = 0;
>>>
>> This only handles the case where the function following the failed 
>> connect is another connect() call.
> 
> So, can we remove that with this patch, or better to leave as defensive
> action?
> 

I prefer to keep it here as defensive action

>>
>>>> Switch to sock_error() which atomically reads and clears sk->sk_err,
>>>> so the error is consumed when returned.
>>>>
>>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>>>
>>> Can you explain how this patch fixes that issue?
>>> (this should be the first information to be put in the commit message 
>>> IMHO)
>>>
>>> I'd like to understand better if this is a fix of real bug or just an 
>>> improvement to the code (which is fine by me).
>>>
>>> Thanks,
>>> Stefano
>>>
>> Here are the steps of the syzkaller reproducer:
>>
>>  r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>
>>  bind(r0, {VMADDR_CID_ANY, PORT})
>>
>>  connect(r0, {VMADDR_CID_LOCAL, PORT})
>>
>>  listen(r0, backlog)
>>
>>  r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>
>>  connect(r1, {VMADDR_CID_LOCAL, PORT})
>>
>>  connect(r0 -> self) -> -1, EPROTO
>>
>>  listen(r0)          -> 0
>>
>>  connect(r1 -> r0)   -> 0
>>
>>  accept(r0)          -> -1, EPROTO
>>
>> Basically, it creates a socket (r0) and triggers a self-connect after 
>> binding it. This self-connect fails with EPROTO because it loops back 
>> to r0 while the socket is still in the TCP_SYN_SENT state, causing it 
>> to be incorrectly dispatched to the connecting-client path. The 
>> unexpected packet type encountered there sets sk_err to EPROTO.
>>
>> After that, it invokes a listen() call on the same socket. This 
>> listen() call succeeds because the kernel's listening path never 
>> inspects or clears sk_err. Then, a new socket (r1) is created as a 
>> normal client and connects to r0. However, vsock_accept() rejects this 
>> incoming connection because the listener's sk_err still holds the 
>> EPROTO error from the earlier failed self-connect.
>>
>> This rejection causes the child socket created for r1's connection to 
>> never be freed on virtio or hyperv transports; only the VMCI transport 
>> implements pending_work to revisit and clean up a rejected socket
>> This patch will prevent the rejection branch to occur in this scenario.
> 
> Okay, get it now, thanks! Please include a summary of this in the commit 
> description.
> 
> I understand that this resolves syzbot's specific test case, but it 
> would be best to handle rejected sockets more effectively in af_vsock.c 
> rather than in the transport layers (if possible). In any case, this can 
> be done in another patch.
> 
>>
>> I think we might schedule the cleanup worker to run in the rejection 
>> path for these transports as well.
> 
> Yeah, we need to handle that part better, I think it's a leftover when 
> we generalized AF_VSOCK to support more transport than vmci.
> 
> Indeed this part is a bit confusing:
> 
>          /* If the listener socket has received an error, then we should
>           * reject this socket and return.  Note that we simply mark the
>           * socket rejected, drop our reference, and let the cleanup
>           * function handle the cleanup; the fact that we found it in
>           * the listener's accept queue guarantees that the cleanup
>           * function hasn't run yet.
>           */
>          if (err) {
>              vconnected->rejected = true;
>          } else {
> 
> 
> Would be nice to handle everything in af_vsock.c in some way.
> 
> In conclusion, the patch LGTM, but please expand the commit description, 
> add the Fixes tag, and target the net tree in the v2.

I'll send a v2 with an expanded commit description and the Fixes tag.

Regarding the rejected socket cleanup, I agree it would be cleaner to
handle it entirely in af_vsock.c. I'll look at that as a follow-up.

Thanks,
Phi

