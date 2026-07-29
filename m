Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34248A2A7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331288; cv=none; b=sYjl7z6CfLWkTs3fUoGFChS75jT/MpquIpKEycf01/YZKa35xzg3lZR5QtzDH6qepOSh6ypsxpOb3doCgSTUzPJw+IxEBgVXeo9zWoEIVgk2rNJPmjEwrz48H4gB7eeGeKshHLXS29J+vUsIJ+hz3XEGzUJ1PyVy/hj1ZL08ly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331288; c=relaxed/simple;
	bh=ka58tVVi6SsAum83Mc6DSFOiJ7ycJ9uJth8uHFgmOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCG4r4jvOsNBCXErU+Qr4oRfqqtztB64GkyS7R7/AWGJRF/TD1z5LDDa1+Lu2anGAwvDZlGCOjogL0vP1IjiyoSc3I6m23WC2vz+MFr3gILPAAxKQO7JJPNvfGrwoDMoExWxlcfFghdBeBxqFMWTQmLnFiIhvdA8eClHjMRK6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVpUsVhB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mbcx8slx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVpUsVhB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mbcx8slx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785331285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0xXJHq60WPbuKjp5vgLyMqWjsr1ek6nh2vuXCicWE8=;
	b=ZVpUsVhBzALriJrjtq4yvMQx77yVUwy/Pkkb8VpUPOndBbw02LO4Eb3FNx1DlFqKOEWpdx
	fi7Vs85gqiDZAFhVxnkZ3r4xAlBLD7olWv1OjrIa5UCNm9DcxrcY5TuJ5awV75lUiqwz2n
	faamjeeGcjqhbwWC7X9r9V8xqFMuLC4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-gN8iqIfxN9eYgj7fY6N-Qg-1; Wed, 29 Jul 2026 09:21:23 -0400
X-MC-Unique: gN8iqIfxN9eYgj7fY6N-Qg-1
X-Mimecast-MFC-AGG-ID: gN8iqIfxN9eYgj7fY6N-Qg_1785331283
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b408a5c0so5436265e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785331282; x=1785936082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u0xXJHq60WPbuKjp5vgLyMqWjsr1ek6nh2vuXCicWE8=;
        b=mbcx8slxFFK6DsriQnwKqa9uRWl1kG0LA01Yp7uysCe0AMgl1IuYq2WZ50JVb39Uq+
         y3p2nuzCFw5jB3JaNQLbOKsOiEYOOiTBesp8JO2DIF4vm/DgUkaPNrOcWmNraTx7Q+w8
         5P2qKpIHcXpScunmWoPWpkWesKW5f91o4bfz10oZC42kHV++H557SVx67+Cul7UjGinR
         nJwmlHceJa+hKAmzvivmEYOk7RtJyxI1/SMk0lOSSdeWMv+d3Nv5S/Nb0UJKIUWn03Lk
         4PSY0RkdYnPAFHkkd2A4BQWGOlAOOUHyycifvYfKuK5+IfHZF2FgRkO5SkHGqVJ/O+ay
         TXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331282; x=1785936082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u0xXJHq60WPbuKjp5vgLyMqWjsr1ek6nh2vuXCicWE8=;
        b=ZpKckWHEYOhiz8bLE4X8v3LtWW48dc9ZZjvcv+Rm2Zut7WMORmasv2DzQ24WjVbG2j
         V3er+i4pRcEgOVWEGqySiVBejMHK0RhCjrkguGr8iqmxlJ0Hf7ZIYOgIWBxmdVuflzJH
         Vj1bmvL++/oTCPNOKW0+tDqQjmL5AnQoubzLINH2IGJbTEcq85if8aToSPlcFciss4hC
         IhNGQKlAxgChXuvYdaOI+fARP3GhXVkhcgLjn1evzZsSP0Bw9c2CEz4PIDSJK+lu4GnW
         Jja8pn92VSaNcJCogXYZXtg1IOQUQ+T+d5DJuLPpRereTvgINnXCG2RbbmsWXayMFpRe
         NtaA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1crTzgfDgeVjhVYmCR8qlHg6ajWYF+CEPACL/3g3SD2uYweMrgjc9uigWtgN5bJfviQZDNmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0C9rloQP09vHOU1oPUlyMCk9KoBHduQ0F5ed5EpzPfzcKI7A
	DEBpSY4vVV7H8i1akpDiV3gwM+DwK6w5s0ypD3zakeO7Ru7Rq+DeI20/cT4IDo1KZkZPOBVF7OX
	cIjqyMkBikcVZORLsWKpm33HKzQpKFvms3H4nLQ8oJYkSN400LF8l38+WEQ==
X-Gm-Gg: AR+sD13H/iXpR/Tr4fw96jcAqeinF3j3RfyD/0lX0nvHEC5QN9yV9XWnGud1lF2Nclx
	bkCms+acl5hbtWULxVHaPWPkzNWAm9cYVs1v3wOSJkwjaS85yweQiiWUTndMlWkkoVxqmw+QT6B
	TVRZIESCtTN4t3Qx8Qz7hTSK9zPc1VEbie4jNlIdM3P9z7BwWn4gZSxNdxbSVTbcmVVdQEinWxN
	rF8PvcG+kWzc64481DHv+IRr3YbWSln+QkCfstbMtYyNNviotyVJ+mSONw7dyeTzn8mGDpk4WBU
	J8ynEPeJDjWUG2ovO4n3C+8UUiHhprg2Rdo8ZEPl3ExIiUem7JcBz+Xk+zOVMvxW6gEC6zEKZsz
	qFWNwYToUZWQtiFVALXB1Cgi0hYLcqmwqt+jIaS+crJs=
X-Received: by 2002:a05:600c:3b86:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-496c658eed1mr81575995e9.25.1785331282482;
        Wed, 29 Jul 2026 06:21:22 -0700 (PDT)
X-Received: by 2002:a05:600c:3b86:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-496c658eed1mr81575535e9.25.1785331281888;
        Wed, 29 Jul 2026 06:21:21 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b18a9fsm7167683f8f.32.2026.07.29.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:21:21 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:21:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: mawupeng <mawupeng1@huawei.com>
Cc: phind.uet@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, acking@vmware.com, 
	dtor@vmware.com, georgezhang@vmware.com, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsock: use sock_error() to consume sk_err after a
Message-ID: <amn9-HWi5L8DlXy5@sgarzare-redhat>
References: <20260727071305.45826-1-phind.uet@gmail.com>
 <33c73960-a44c-44e4-bfba-c4ebe85b336c@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33c73960-a44c-44e4-bfba-c4ebe85b336c@huawei.com>

On Tue, Jul 28, 2026 at 11:14:31AM +0800, mawupeng wrote:
>
>
>On 周一 2026-7-27 15:13, phind.uet@gmail.com wrote:
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> Syzbot report an issue which can be reproduced with these steps:
>>    r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>    bind(r0, {VMADDR_CID_ANY, PORT})
>>    connect(r0, {VMADDR_CID_LOCAL, PORT})
>>    listen(r0, backlog)
>>
>>    r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>    connect(r1, {VMADDR_CID_LOCAL, PORT})
>>    connect(r0 -> self) -> -1, EPROTO
>>
>>    listen(r0)          -> 0
>>    connect(r1 -> r0)   -> 0
>>    accept(r0)          -> -1, EPROTO
>>
>> Basically, it creates a socket (r0) and triggers a self-connect after
>> binding it. This self-connect fails with EPROTO because it loops back to
>> r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
>> incorrectly dispatched to the connecting-client path. The unexpected
>> packet type encountered there sets sk_err to EPROTO.
>>
>> After that, it invokes a listen() call on the same socket. This listen()
>> call succeeds because the kernel's listening path never inspects or
>> clears sk_err. Then, a new socket (r1) is created as a normal client and
>> connects to r0. However, vsock_accept() rejects this incoming connection
>> because the listener's sk_err still holds the EPROTO error from the
>> earlier failed self-connect.
>>
>> This rejection causes the child socket created for r1's connection to
>> never be freed on virtio or hyperv transports; only the VMCI transport
>> implements pending_work to revisit and clean up a rejected socket
>>
>> Fix the issue by using sock_error() to read the sk_err to prevent the
>> rejection branch from occurring  in this scenario.
>>
>> sock_error() atomically reads and clears sk_err, ensuring the error is
>> consumed when vsock_connect() returns and cannot affect subsequent
>> operations on the same socket. This matches the established pattern
>> used by other protocol connect() implementations in the network
>> stack like __inet_stream_connect(), tipc_wait_for_connect()...
>>
>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>> Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>
>Thanks for your patch.
>
>Test-by: Wupeng Ma <mawupeng1@huawei.com>

Thanks for testing, just a note, the right tag should be Tested-by:

Anyway, @Phi can you bring this with the right tag to the v3 if the code 
will not change?

Thanks,
Stefano

