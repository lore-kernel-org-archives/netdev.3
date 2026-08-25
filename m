Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93993FA5CA
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654711; cv=none; b=H1ENKdIGOBNezt92DcJ23NZwdC6slRnTv07kPbcShuI5YdJJY20zSqHFoYvHfmtOUgKeQzCeDVIeY96M2yITjTjehVj8LdoFMAvK1J3TiLbdlvGBkn/v5hYwZkbVfjReZCyXuhYRh2UUl8l/+he/MHx8OxU11YFnUQkIBgfJOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654711; c=relaxed/simple;
	bh=+7UsDaBxxxafnbkxKKMkg9R+c8fO/Urc0EWFqkAWnpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfFDl9Sc/SW5cFCztNP/LOC93nyXbwGfrdee97iUDXuRWcELZUnXvxveeYmOKXsOk033NXVab2H9y6PwMRuUimVcblZLTXIec4SxsqrYDC6JMGfvHZKvgNZ7C9Nqw2ojV87fT/aK0z22ApPGLftRTwYD7yUP10QzKdSZDP/HCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7EoLZ2F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fjz6bi6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7EoLZ2F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjz6bi6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787654708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHh69naUUhgZLYqy6vySMehZGmJxGjn0KXcTrxIyxOs=;
	b=g7EoLZ2FdzKxMoxVs815jbbQDAFWe9dZdiePB5H53E8fcT3gPntSMRIzAGLKz33D06eJkb
	Od5DGAoA7/1OQjfry0v4sNtxCid7XqG7Mx7cQYIky2fY3mYMlfC6VeuzIVhDVn4hxcOi+2
	d77Vb3Bdg1Bp5h458Yoi7xWN+zdyyJY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-UxEXx4AtPZWMCidIErnZuw-1; Tue, 25 Aug 2026 06:45:07 -0400
X-MC-Unique: UxEXx4AtPZWMCidIErnZuw-1
X-Mimecast-MFC-AGG-ID: UxEXx4AtPZWMCidIErnZuw_1787654706
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69c20d1d150so3821317a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787654706; x=1788259506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHh69naUUhgZLYqy6vySMehZGmJxGjn0KXcTrxIyxOs=;
        b=Fjz6bi6PKVougUERPCW5WfZtzECM5sA0fIv1lBcZ4rm1YE6eGJxBzSgqB+gxSr0DQH
         do0PXwk5GHPObwHD8p9J2jOAnjUsRi53QeWiLt7pXBOK0Um3Qk/3f51UBKF6QUZI5dcV
         eo3hNXc/0GgMkqN/DIOMjkpyA0p29zxPh2On5zEmIEylNsc+SElO7I6zNyyDsrE/028D
         TeOTYlsSnH1lvZ0D/FpmJp2DVXe9av07W6V9e6DljO2mvhOOGxQO0BYmqsz2/NvDl3Cd
         pWq+PYb889cpnFjicbFIEglJYB9r/CvTPptqWs+IphiFGFUkampqyZ6EjhgD1Lt48lgV
         xZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654706; x=1788259506;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHh69naUUhgZLYqy6vySMehZGmJxGjn0KXcTrxIyxOs=;
        b=YH9AiSzyz/SZEP72J5+tJjPUaTy0VKdRDGYHYqkNA4eCszlLKDAtCcU/rEREFNzdS4
         V0OhkqIreC+w7cu9z5zGjc9CO2N1huzVaMELWJglb8Sws/eXt7aStwkv77t0832+6O5W
         jESzliNlvzBO0fwR9Qsw8AkzEpt8Zzj7QV7HRXz9kIW4OWXKgxUwBXiNC8oyB8elf7sP
         hwa0laiY6otx/QBhOB/+JJG9uOgd1UtXbA7b0wTo+oBFj5gvW9knT9ApQ/BVx1IJLA8u
         OLFzU1URvRB/J6jPFPEnOokw/ZWv+l4JWoXg9ZPwRxBmN+4zjDTlmLUT9+Kkr0sHSy48
         54JQ==
X-Gm-Message-State: AFuF++n8Xcg/icUV2c7VbMM0DliAlJtkBEfEKgqVmvprLboXJRAKQJz+
	3bLBudPuET+vk5N3DfAdsf15jW63lhoscTqSDtVt2+6SGzgoc/xG0xKsINCiWaDY2Urd3Swo1ND
	WIx5WBRTjUaN2QnuNnBNmV9/sPcGK8q1sONQdlTDBWUU+i6NyDlSeFhd+/w==
X-Gm-Gg: AR+sD10G06vR9iMPUsmOEpeIZ4fVIanUwPmAKfyxIZUtGXOvW9i1v1c60habWwSQ/Fn
	ESwZHl8vkWZs5FnhGl+5W8q2wtQOL2Y+ViRx+UIGPjR1I9hMP+hXlVoH3cMWBqYGaC/8YiQ0SfO
	qw74NgwcbAToqwH9d9Mm0NUWxx6TpKM7qEwCq6I3XV0le3/uR++INuiqgqM8Qt8jH5je5sB3usm
	tNU4P2Cgg761fhUmE+Oh+VOm13cUprchoQzxKp1emLiD3kymSFz3RgYyazanYOF+zms2h8lpz2U
	EsJh0e8xkX8zbpTqZG8NuXvTKDgi9atYSTG5/g8JI39B1rSJz4tYGxKbUFecRU0RN1f8pSdHZ23
	IU3+5P5yx9KG1UKMAkJ5aGU/k5QGUAsFYavsZzBFP99adEQYbeGnt6gcENZjLMI97bsEaIYjN
X-Received: by 2002:a05:6402:52d0:b0:6a3:fdb0:c374 with SMTP id 4fb4d7f45d1cf-6a5c414ce78mr6312914a12.13.1787654706167;
        Tue, 25 Aug 2026 03:45:06 -0700 (PDT)
X-Received: by 2002:a05:6402:52d0:b0:6a3:fdb0:c374 with SMTP id 4fb4d7f45d1cf-6a5c414ce78mr6312834a12.13.1787654705668;
        Tue, 25 Aug 2026 03:45:05 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e001305sm13901866a12.4.2026.08.25.03.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:45:04 -0700 (PDT)
Message-ID: <f3a9dd1f-43a7-4644-bf1a-45dcd422abcb@redhat.com>
Date: Tue, 25 Aug 2026 12:45:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: pktgen: keep device lookup under RCU protection
To: Chengfeng Ye <nicoyip.dev@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Qi Zhang
 <marsy12010123@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Alice Mikityanska <alice.kernel@fastmail.im>, Florian Westphal
 <fw@strlen.de>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260824152331.216494-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 5:23 PM, Chengfeng Ye wrote:
> pktgen_find_dev() releases its RCU read-side critical section before
> returning pkt_dev. __pktgen_NN_threads() then sets removal_mark through
> that unprotected pointer.
> 
> The worker can concurrently remove the device and queue it for RCU
> freeing:
> 
>   CPU 0 (netdevice unregister)     CPU 1 (kpktgend)
>   rcu_read_lock()
>   find pkt_dev
>   rcu_read_unlock()
>                                    list_del_rcu(&pkt_dev->list)
>                                    kfree_rcu(pkt_dev, rcu)
>                                    RCU grace period ends
>   pkt_dev->removal_mark = 1
> 
> The mutex held by CPU 0 does not cover the worker and does not delay an
> RCU grace period, so the final write can access freed memory. KASAN
> reported:
> 
>   BUG: KASAN: slab-use-after-free in __pktgen_NN_threads+0x241/0x280
>   Write of size 4 at addr ffff88810dab804c
>   Call Trace:
>    __pktgen_NN_threads+0x241/0x280
>    pktgen_device_event+0x24e/0x3d0
>    unregister_netdevice_many_notify+0xde8/0x1ec0
>    rtnl_dellink+0x35d/0xa90
>   Allocated by task 92:
>    __kasan_kmalloc+0x8f/0xa0
>    pktgen_thread_write+0x498/0x14e0
>   Freed by task 0:
>    __kasan_slab_free+0x43/0x70
>    rcu_core+0x50a/0x1850
> 
> Move the existing RCU read lock into the sole caller and release it only
> after setting removal_mark. The object therefore remains alive through
> the dereference, while lookup order and control handling remain
> unchanged.
> 
> Fixes: 8788370a1d4b ("pktgen: RCU-ify "if_list" to remove lock in next_to_run()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/core/pktgen.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 7f81aed46672..4fb1853589b3 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -2032,14 +2032,17 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
>  	bool exact = (remove == FIND);
>  
>  	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
> +		rcu_read_lock();
>  		pkt_dev = pktgen_find_dev(t, ifname, exact);
>  		if (pkt_dev) {
>  			if (remove) {
>  				pkt_dev->removal_mark = 1;
>  				t->control |= T_REMDEV;
>  			}
> -			break;
>  		}
> +		rcu_read_unlock();
> +		if (pkt_dev)
> +			break;
>  	}
>  	return pkt_dev;

Side note: returning the RCU protected ptr outside the RCU read lock
safe, as the caller never deference it, but quite confusing.

It would be nice to follow-up on net-next replacing the return type here
with a bool.

/P

