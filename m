Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48A3B3BFE
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821799; cv=none; b=YABQfvEfcvimuq2YbYpmtS9ePbReNXTxzpVuhajchcM2OUAr/Ugp0SsxAsLfXLQUA40BDVt/etsy9WKwlYXZmPCecDeLtdm2Tqd9mr0YDJlPXL13SfUK8z42ZTK5oopaJgprUFMSCCacopIU1P7wEd3rbE5lh3MpZdiKc470fS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821799; c=relaxed/simple;
	bh=aswDqIhxn9zDbIYCw7uhogF3N11JxfjDaIzh5muurGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ie2qfuQjNEfqyRocUKdPyr7DM3bJD3vm7IFkULd4zA/agcozCB5GdUmUDp8AcDleW8IFbbdN6653wBefhjU6OlAL9ldX3737ys8cghvGSFGHjIb6Eh0shJp0nJburt7uIdbxSbRSdAd8nBV9e6SZMg1YnwpoMRsiuHtrakH3yxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7fStErk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkEXX7zG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7fStErk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkEXX7zG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787821797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kExiMJWjGxifaBnSkovuP5HHG9otva8PNINfdnTGN5c=;
	b=Y7fStErkqaU+4s7FX7hMgzleLV73FbOHvxLkz+75r5V1DT0r9XAPHmdrkY6T+dQJIMz/wa
	q420+wbWVsQooAhjiCDs7ww1s3LlZ7Rq5509PeRrNyPWwXV4zm6WToICs5Tptq5A2G6Gdf
	IGo75q/wtwvxnm0G0EgL1iPAdDmE+g0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274--cqWOwRlMnqdQN0nduFxBg-1; Thu, 27 Aug 2026 05:09:55 -0400
X-MC-Unique: -cqWOwRlMnqdQN0nduFxBg-1
X-Mimecast-MFC-AGG-ID: -cqWOwRlMnqdQN0nduFxBg_1787821795
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482e95788d3so463080f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787821794; x=1788426594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kExiMJWjGxifaBnSkovuP5HHG9otva8PNINfdnTGN5c=;
        b=OkEXX7zG6v9/CRrK2xFSFrXr5up21txlcT93DQPXGxkkT5h91FiqMpQnZMdH11jtvI
         2cTagCnfUjqnlisy6yyFAtBAxi+jHKSkm5TRWrXXdWe2xB465DHwNoLPdQEzKRvAyDT6
         W6nQkO1OHVP6cz/Ma3robdxyOD5qBL1TZYDCJCethRtpJYd7NgvuZv9PuUV2GODWmq74
         cZApaDG9V+JQqxDOyVmbKCGcjJvs6HIvOqq39QB31Dm6Ed010unb3OIgRNVC9o1l03rM
         UXOmDv2ZJw+8lUiaFF+1xiad6MLRD/nVxiLw5cpL6bYomgugjUPywO7kkeFY2turZkJ9
         3mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821794; x=1788426594;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kExiMJWjGxifaBnSkovuP5HHG9otva8PNINfdnTGN5c=;
        b=MAQW1Q3OtDxW2I9CeaE/wrR7vjvebLXWv1Ol9F/dTrrYkrak9/4DRqUBgD1GfSgM9p
         i+esvQ5gCm1JfTOYmQRbYvk0M4pDWqVEUzCLLnixwwXxUSjscqRNJgKuzZ4u6PC07Gjc
         yibFH0OFslTmyoFWgH/c978iElvDE7xU+IYSg9RMW5O+JJdlSMmBijVqarjPCdhtifFV
         ZGEQzwEBOgshmFYFjK4bQ7OWnBeh849kGEBfIkXI4P0fxRJ6HvEFaGMof4kHDW//lOTW
         phrpgU74+7+l5pTRjPP3vFvml47W60AGgiBvHXUW6DZMHGbRxbPRwKKxRm+MqwNhPMq8
         DT0A==
X-Forwarded-Encrypted: i=1; AHgh+RpXWke/L2l3ivQBYkn1BUnlYvwR9TRbNyhr0PPgqMKEkP5/185x13llduXcWO4X19EIuUJhqmI=@vger.kernel.org
X-Gm-Message-State: AFuF++mcFlNJMuG9+nSrFsPm5QWHRr5XKG7wmMRK8kcPpXImadHsTGG3
	hrlRQBsU8tfXTSvkI6a6Uxq8Wd6arLLP53E23BvMGAPlC7lsvg+2d9RCRhWu0gB2dVwHFcd5dws
	Zp9oRhezQxAfVOZQs5SVfamI33J2gZuV5RMOFWojez/mGzkYegUfnk262MQ==
X-Gm-Gg: AR+sD13L4ynkmLhy5S/u3P9kamlU9cf947Ku8OT2+XkSzEfZoWNMY4qyc3jVvz4pDev
	Vwv4/xliReitiPWUp6BtR08LJ3VHVhCXCQQ4dLGLJyvv3vsfcZPZJyUXe1oNa0zMxfCiVz+8DzD
	W6GyWK+EbVWr2mM6FOSidqzoJZap/T5bvn6WeE22BzjwXGvE2f2aQVpfQfAeb+lhPSmPYUjFhaV
	vR04oXm7hzJVrxxLGAFxxSXD4f8QBbeYky9OunFL/pYRtbRyHGxqLvLSEoTL6U+Brvn021hFrYx
	bgfKXWLlA54kYmO9h0K8bZ9QXz+/IiuaImpK2s7D8Q6ruvO4O0+faCki6FayrJeaIQwD3VdKH6f
	OYofxVKwfAULx2kwtyBZFwB63/uktI/8+59s2CLM4ICr8kAol/HxXqfqzBCUNAFN+x2Dfgdg=
X-Received: by 2002:a05:6000:46c8:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-482e26add2amr13838211f8f.11.1787821794521;
        Thu, 27 Aug 2026 02:09:54 -0700 (PDT)
X-Received: by 2002:a05:6000:46c8:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-482e26add2amr13838111f8f.11.1787821793965;
        Thu, 27 Aug 2026 02:09:53 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc0d6sm8192606f8f.18.2026.08.27.02.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 02:09:53 -0700 (PDT)
Message-ID: <9eeac695-ff8b-4473-b0ab-b3ad873b6915@redhat.com>
Date: Thu, 27 Aug 2026 11:09:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260825023614.1228551-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260825023614.1228551-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 4:36 AM, Eric Dumazet wrote:
> tcp_send_active_reset() can be called from contexts where gfp_any()
> (in tcp_disconnect()) or sk->sk_allocation (in __tcp_close() and
> mptcp_do_fastclose()) evaluates to GFP_KERNEL, which includes
> __GFP_FS and __GFP_DIRECT_RECLAIM.
> 
> Allocating with GFP_KERNEL while holding the socket lock (sk_lock) creates
> a lockdep dependency:
>   sk_lock -> fs_reclaim
> 
> This causes false-positive lockdep circular locking warnings with storage
> subsystems (such as nvme-tcp) that acquire socket locks in block I/O paths
> and invoke tcp_disconnect() or close sockets upon teardown:
>   set->srcu -> sk_lock -> fs_reclaim -> elevator_lock -> set->srcu
> 
> Active resets are small RST packet headers that should never
> enter direct reclaim or block while holding socket locks.
> 
> Hardcode GFP_ATOMIC inside tcp_send_active_reset() and remove its
> priority argument since all callers now use GFP_ATOMIC.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
Sashiko has a bit to say:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825023614.1228551-1-edumazet%40google.com

A couple of issues (the same lockdep chain still be present for
regular transmissions, and SOCK_MEMALLOC being ignored) looks
real to me. WDYT?

Thanks,

Paolo

