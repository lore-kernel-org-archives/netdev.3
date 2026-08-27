Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A643BDDA
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825097; cv=none; b=A0fimhFOpCvCqAwMV4uaWy09c0XwImD1zMkXOZsvPMecZfmI7q0OpTgJ1qFL1JlYzBmKotK6fypthu2LfJD4zcshxe/1n+5DOQA+DcBFeEk4/FcXa1BKRdhFS0604Yr4xzlJDvpZfXcrg1cHflMFDLrrX//CcHcjciEoNC8tBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825097; c=relaxed/simple;
	bh=MbeO5XjX846mwnMEgjp5sTq1we5JEe7E/YID0DW2wis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0CBb7XkJEJZpLkwBvQdQFxBPLpCX8OzOL6olOsZNGqWKDr4D56EGAn7rVn+ccN7VIlDhqMJ/3Dg2jiNsh2dLtjg8ynunQsbzIm4ugN5EZnqSvpGHmTvfZ2DwAAkydhu4au94+pORzvz4i9vB71UOxtZ36JB0X+JH+Vsn9REENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkiVkK+s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pPm3e275; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkiVkK+s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pPm3e275"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787825085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkFd49/5jQc7/ok1FroNUKlr4I/ksjuJjWhj9WHx17U=;
	b=EkiVkK+spyh8s4dFP1CYNkLU1gMxeU5GrZlfyLn3ZABs4nXX1/7drXWZo9inaowrkdqSNN
	55SmIw3AMVltbWVPvo3ZEUEDBYT56fAMpr1Q3gFMujV6/kQUVgkUd+ANK9XYXWfBkxJPra
	CK1Azl/tnXLcs2gWhVeo2o+eHG/rovM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-c4rSJ77ZPfO4-hA875x9dQ-1; Thu, 27 Aug 2026 06:04:43 -0400
X-MC-Unique: c4rSJ77ZPfO4-hA875x9dQ-1
X-Mimecast-MFC-AGG-ID: c4rSJ77ZPfO4-hA875x9dQ_1787825082
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49991beee7aso4868605e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787825082; x=1788429882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkFd49/5jQc7/ok1FroNUKlr4I/ksjuJjWhj9WHx17U=;
        b=pPm3e275MUGYrzxs8WFOlA/w7FCOH3a1L/E6JLHHC5MBxSwi4uyWTBUZD/KEqpRMWu
         ONSatk7hyMeVYonlz9nA6Ab5VgmAA95up/GTci9SgNWFRkrUc/LVsUUFBgjioIl/zv81
         /o550hAcqr/TOFt2IoWQS3vIW4/LVpYjxyrawI+emka6E/kfXop8j+zWwv7ZO4c/tCJk
         XOviJdTV4hIYy5btjDbdyXDZWBe3YZAL2/5lb2JjKppVLogMleD8YHTI+SVLn1P6tByQ
         P9f5SsVtT/OHgIXNdOtfxCX8JQZSnAzpjpc0yxhMJ0sCMkzo6mk6LJgKAe5LxBGpdqBG
         wAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825082; x=1788429882;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XkFd49/5jQc7/ok1FroNUKlr4I/ksjuJjWhj9WHx17U=;
        b=VRBpTKPvLKcPgpsNNvo3hQJzHR5qYdbiYO7I4WMyX6aOmpt8A9B2mPQ8LQ9WFdV4YV
         K+rNN3Lksg2gDV3HbLK9Uukv8urS92gN1vopMF0gA1udlI/fU/XvfrAoEewW8/a0wDST
         bDHwZ1HY/D1OpCr8J14eY8F8RpuRV1fWV7Ob/yAn06fwxNIwkvWNw9lf9u1SVys3CycO
         R5xoil+yCXwg/0itg7U5ih10WaEljEihur5KHCRHMSVbINSekoJC7bmlkoi86qttcdop
         c2rEvkOzYjz0nf1b98w11jF86HmdNJkWCR9qCDZigCd4crXTx6DjxnCArtBr8WJGc2Uz
         LEqA==
X-Forwarded-Encrypted: i=1; AHgh+Rruj9gQAs7TfAGqsLT/US02Gghpv4F64yJ5KaUIqyb7E0JTTeDXT9VMS1S1X4qC/8fbiJE2Cnc=@vger.kernel.org
X-Gm-Message-State: AFuF++l/jArXVBzAup4YGH6lB7aaiG7zgq9WvOfGT/gCLh74ptraqmKB
	OjWpQWe3fSyL1xofN1zNTT4uXcUvToGr1+zNss4RUsGyg9uA+jtc1UEAfR9QxUfTb3cCyh0Ppau
	iAxgC4uNG6hAhFHpCYlvmxSghbyiFulTIrrVIe/Qlw6dRJMXqHKojkU5eyg==
X-Gm-Gg: AR+sD13SJcvnzLnpeEEQeB/R1otqWgChVQf7A5aBMeKllSkJdkCRXj3vqJqwy3p66aj
	eDJKA8zUW8qeHBnnb7FN3ROMXc5GXGIKRoG92YYNur4HdCsiEd3/iZPJeEGEfrIbzxYU56j+1Yc
	Tf28DGm+OGe6BgWCoDC1L4BZqCkwDk8fxj2xPgl/GYNaN5cw6LQd50XZ6ARJbuRTcuIhFJ0r67u
	eZCj1en/srFuOd+rXzbDLOqWqcQuKwgrXlKjEs4NG4NVqokEKQ4qmq2o/ooIXEdRwDbDwCofeVz
	swkhaIDNA+og0x5RVKdJVV9shbcKeypywc/wdClpEChyd2gvZVV9oRAOa2EdJlIQAlQSYE+FD5s
	c1jvyKdJnAlGd1+0TdvXFxGc3AqPlb2mCjsbhofap8KWFQyn1VpEtf+3TwV9FWa9Uob6ex9s=
X-Received: by 2002:a05:600c:4f8e:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-499dc83083bmr151845885e9.13.1787825081296;
        Thu, 27 Aug 2026 03:04:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4f8e:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-499dc83083bmr151842475e9.13.1787825079284;
        Thu, 27 Aug 2026 03:04:39 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd56826bsm58323335e9.4.2026.08.27.03.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 03:04:38 -0700 (PDT)
Message-ID: <4619ea36-bd62-4d31-b3be-c5948748046a@redhat.com>
Date: Thu, 27 Aug 2026 12:04:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260825023614.1228551-1-edumazet@google.com>
 <9eeac695-ff8b-4473-b0ab-b3ad873b6915@redhat.com>
 <CANn89iLb1qJ9asoisJzPmXQ-ZD7Xp6H5kfjOdMtjxYBuL_2sKA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLb1qJ9asoisJzPmXQ-ZD7Xp6H5kfjOdMtjxYBuL_2sKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/26 11:33 AM, Eric Dumazet wrote:
> On Thu, Aug 27, 2026 at 11:09 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 8/25/26 4:36 AM, Eric Dumazet wrote:
>>> tcp_send_active_reset() can be called from contexts where gfp_any()
>>> (in tcp_disconnect()) or sk->sk_allocation (in __tcp_close() and
>>> mptcp_do_fastclose()) evaluates to GFP_KERNEL, which includes
>>> __GFP_FS and __GFP_DIRECT_RECLAIM.
>>>
>>> Allocating with GFP_KERNEL while holding the socket lock (sk_lock) creates
>>> a lockdep dependency:
>>>   sk_lock -> fs_reclaim
>>>
>>> This causes false-positive lockdep circular locking warnings with storage
>>> subsystems (such as nvme-tcp) that acquire socket locks in block I/O paths
>>> and invoke tcp_disconnect() or close sockets upon teardown:
>>>   set->srcu -> sk_lock -> fs_reclaim -> elevator_lock -> set->srcu
>>>
>>> Active resets are small RST packet headers that should never
>>> enter direct reclaim or block while holding socket locks.
>>>
>>> Hardcode GFP_ATOMIC inside tcp_send_active_reset() and remove its
>>> priority argument since all callers now use GFP_ATOMIC.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Sashiko has a bit to say:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825023614.1228551-1-edumazet%40google.com
>>
>> A couple of issues (the same lockdep chain still be present for
>> regular transmissions, and SOCK_MEMALLOC being ignored) looks
>> real to me. WDYT?
> 
> Thanks for the pointer; my local Sashiko couldn't spot this.
> 
> Regarding SOCK_MEMALLOC, that's a good point.
> Using bare GFP_ATOMICdrops __GFP_MEMALLOC and misses __GFP_NOWARN.
> We should use:
>     sk_gfp_mask(sk, GFP_ATOMIC | __GFP_NOWARN)
> 
> I will squash this into V2.

Thanks!
> All the remarks against nvme will be taken care of once this patch is merged.
So the addressed lockdep splat is against nvme, right? Given the
reclassification and memalloc_noio_save() dance performed by nvme
noted by sashiko, I'm wondering if something alike the following
(completely untested!) could be a viable alternative?
---
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d..755feda4e399 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3377,14 +3377,15 @@ int tcp_disconnect(struct sock *sk, int flags)
 	} else if (unlikely(tp->repair)) {
 		WRITE_ONCE(sk->sk_err, ECONNABORTED);
 	} else if (tcp_need_reset(old_state)) {
-		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TCP_STATE);
+		tcp_send_active_reset(sk, sk->sk_allocation,
+				      SK_RST_REASON_TCP_STATE);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (tp->snd_nxt != tp->write_seq &&
 		   (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any(),
+		tcp_send_active_reset(sk, sk->sk_alloction,
 				      SK_RST_REASON_TCP_DISCONNECT_WITH_DATA);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)

