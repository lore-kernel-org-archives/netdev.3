Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF353EBF02
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568861; cv=none; b=kzL0NioGya1XAKRvJGDfxwf+BAAZHTVid+G0hVMnR9THWcV/pBTZS0bc3lBMkpEcjFurOCu9ovXPnp+XC2bX9eOU5xffeJm5Gs4+Y516gTJ6j+p1PXF11qgaS5xgyslF1BrUb0yMY+A3LKlycQ+8HJaCMe4MTIVaNsOXgSvftfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568861; c=relaxed/simple;
	bh=9rPa7ILsFfD4wiBH1dl7enIOztDBOtxFqZVsoJxy5aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9/2+ZbwJwqb9P+yXJP6asFZ54EGVPcnuEt7nSF6PH90RU90yly9qTffRL1IE9myyYP6cT6/MPFBNGyEwQozAuzUfavxLhLRzqGcqJbT2Q+s1fCA7Ef9wGS/juzKaMbtVJbCZPKpfsmu8lNyi055nlM+kAaGO9Wb3bsFkINX+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY7HN9yU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY7HN9yU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848882fdb18so7658397b3a.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784568849; x=1785173649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJrcjKpXVQnKLdbBW9eWHsb14u8QHsUOoad2GXTIGJA=;
        b=BY7HN9yU98t4J8JzSrcOrb0y8//8gliY45iicAmuv4ddlm3kvHVHUrEyoyH1tH129z
         YNjfE2OpIK69qQDZ2tOytSmWq163zbYhEZWnJQ5wDIVmeYxvlAtUYv7nuBa+ycSD9tB7
         KdfGRvTX0LyO30hzHGr/Cwd5LkADjNIOPZwyaeNvrOhJRq7OQ1I/zKoVvKVGyTvD7Asg
         KxDsyJ98FGv7BmaJBfekyA27M1qaYVE3Xh8AGIpfso9S7J9VWi7H4kqfOMVxof1QXMwr
         sZ/tzS1oME661tpzgkHVq1wu5f+TQZZhrLwScDOg6eqooS6MV2SSlCbap0k8WLT1qRb8
         shfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568849; x=1785173649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJrcjKpXVQnKLdbBW9eWHsb14u8QHsUOoad2GXTIGJA=;
        b=gA1cBCgmcuDZwevVYnp+rsxgWIGXdB2ELMEHJ+6SkEVdt0Xd2xPEQShQDMnrqfTY0w
         2wsANbPp5tOSuvAbivQIYqN7D/wPw6PuSFYg56q2AalifZZvztbFOCBbOKP6KLCZVl8Z
         MilBd4X8sOqKJs3lyRjAHun6YXgayZAYhFWolzFgCod8tVPOYEnqLdH85YgsEgJqcJ7P
         IOff6naGUjUeDuNZqzcv6axxF8KyJQKGvnE8VD1y8MJiL0Nvv3zCI9jf2E3SoAEqfzAM
         oACf/wUu6QZPwrVUOv/kM1A1FUyjmMVzB/ly3mfDkPnipK1XDRhwqd3JQ/igjQFDpUBM
         a01w==
X-Forwarded-Encrypted: i=1; AHgh+RrwMzG8AJseBSScVd2FCe5ZGAdoGH/ecj7qgq0XJ5U8NvdgLVxFA25gLyx+/BzQfWwtMvtG/s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hloqzp307Ht6YQQbyxA5AgdyEj77K5vAK8E349eb6TKsrXYR
	y/ZKGtC07+F64L3PvkYAGXLG7KyOcrrfDE8lqVjHI9839mHkxdBmQQOt
X-Gm-Gg: AfdE7cklDfE6F314UMkCnCxTXF/5AJLRkrXIN6VhCpkktdesdevcPVsVHhBZSehh2Kl
	gyb7q6TJ0wUh61X8SIdU2Imsy5g12OS1periE+kXdsWZh3/cDtLUHHyfNO9BjY+sPjlQNoWgxXQ
	C8FByS79UhPJJ0WW1eSKRGwIZ5qc6Nce+EpeHudjxqBo2bJv+B1T160d0D4qhrMtHLccYo5JHyf
	dULzK4BnaILsTUVHwOciYFwvjdERd0/U7kK4uUXD5UZLz0PAfrgQDadDsTnBxKmivuPL1Z2oWl1
	XNPg/8mdp3W3QIJO7rKIxsP1pQ5J8OQbcVzRzwr9dx6mQ44nTEQSlOqpAOb6gt98AgedhgmMkJy
	p/34RH2BtBLXbkFU+aSbC/gA3ihYlf39M+SUspZ1wVuJj62/4wJoJec3lU/ssOSyExF6/ls67o1
	06v6YiQcAMebbAEyDFke4qI90dYe9n2ebYAqhu2lOvzjG7mbx8OpiRAHBT
X-Received: by 2002:a05:6a21:6803:b0:3c3:4ab3:608f with SMTP id adf61e73a8af0-3c3ad81f240mr16989952637.29.1784568849345;
        Mon, 20 Jul 2026 10:34:09 -0700 (PDT)
Received: from ?IPV6:2406:3003:2007:2131:a42d:c0cf:43eb:f0ff? ([2406:3003:2007:2131:a42d:c0cf:43eb:f0ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcd9sm39542802eec.3.2026.07.20.10.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 10:34:08 -0700 (PDT)
Message-ID: <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
Date: Tue, 21 Jul 2026 01:34:03 +0800
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
Content-Language: en-US
From: Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <al3UuvBhfxp82krV@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>> After vsock_connect() exits the wait loop due to sk->sk_err being
>> set, the error was read but not cleared. This left sk->sk_err set
>> for subsequent operations.
> 
> So, is this a fix? If yes, we should put a Fixes tag.
> 
> Also, can you describe how to trigger the issue?
> 
> Because I see this in vsock_connect(), so I thought it was in some way 
> already handled:
> 
>          /* sk_err might have been set as a result of an earlier
>           * (failed) connect attempt.
>           */
>          sk->sk_err = 0;
> 
This only handles the case where the function following the failed 
connect is another connect() call.

>> Switch to sock_error() which atomically reads and clears sk->sk_err,
>> so the error is consumed when returned.
>>
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> 
> Can you explain how this patch fixes that issue?
> (this should be the first information to be put in the commit message IMHO)
> 
> I'd like to understand better if this is a fix of real bug or just an 
> improvement to the code (which is fine by me).
> 
> Thanks,
> Stefano
> 
Here are the steps of the syzkaller reproducer:

   r0 = socket(AF_VSOCK, SOCK_STREAM, 0) 

   bind(r0, {VMADDR_CID_ANY, PORT}) 

   connect(r0, {VMADDR_CID_LOCAL, PORT}) 

   listen(r0, backlog)
  

   r1 = socket(AF_VSOCK, SOCK_STREAM, 0) 

   connect(r1, {VMADDR_CID_LOCAL, PORT})

   connect(r0 -> self) -> -1, EPROTO 

   listen(r0)          -> 0 

   connect(r1 -> r0)   -> 0 

   accept(r0)          -> -1, EPROTO

Basically, it creates a socket (r0) and triggers a self-connect after 
binding it. This self-connect fails with EPROTO because it loops back to 
r0 while the socket is still in the TCP_SYN_SENT state, causing it to be 
incorrectly dispatched to the connecting-client path. The unexpected 
packet type encountered there sets sk_err to EPROTO.

After that, it invokes a listen() call on the same socket. This listen() 
call succeeds because the kernel's listening path never inspects or 
clears sk_err. Then, a new socket (r1) is created as a normal client and 
connects to r0. However, vsock_accept() rejects this incoming connection 
because the listener's sk_err still holds the EPROTO error from the 
earlier failed self-connect.

This rejection causes the child socket created for r1's connection to 
never be freed on virtio or hyperv transports; only the VMCI transport 
implements pending_work to revisit and clean up a rejected socket
This patch will prevent the rejection branch to occur in this scenario.

I think we might schedule the cleanup worker to run in the rejection 
path for these transports as well.

Thanks,
Phi
