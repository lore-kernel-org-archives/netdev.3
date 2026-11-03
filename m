Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716214;
	b=I/vB7ujeuw0WJnrJAd/Xb0mb877P12HLK2uLHqrCHEMIrHk7n3lIja4H906Qiv5yBgbX
	 l1gDj4josQnV5xgOSgSjRvefPVm1cKFQLSXQJufV0YXw2D1pZHUyboBcJaXAJ0VgAFTEO
	 GV5/M4BcZ+rgHwQdwyatSTiHDCkMSd4rCewiY7Ao5xsM3rsX207ONdWNWGAmVyNqvnAmb
	 jqbgzryVrSgNKy9tvmEHRQ2LBbcQ6sHQfSwIw2GmQq+KQVgK6b0uKiXPyF6m4NO6buGD3
	 HB/0SjT34ZzoNAm5Tt0YqPS2ho+Nsww28SvwEE2bzIgGUNAR4meSjxwZbnUOuBC5OgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716214;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QZoRZXNiQ8NMox8dMfPzA0JIR2VNAclAv16pLDyluUM=;
	b=LQbZo3YDg3SKlYNuDtpynlvGHnrMwAtee12S6DbhHAIl3TsQeJmtYOq5erl51ut0aYiP
	 14FxiDVrhLFcy59Irx+xzasOd0Q0fuwW0m9pISZDwpJlFtqEEW56Bw5Yda58/bE4FCvRm
	 mmmUbCTC1NZ08Qd9hXwlL2X1EBONlzXHo3ceEiX9aXmRXRyDnSDY8MULZbgGhIImHle+5
	 mV+ohla7XjWQtJwp07Ky6oADeJ9ls03Y7w+hL9gx4MWrcBcwZdzsUDJQ/CnhPAvFpV9la
	 c/v5mCCOO/ZYIvHP3dCjsXM/k8GooVUtI3XS9Zw35yWtc1tvd5kgle+z5XJJNKzgPRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P69IL9dh;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ptAAWoMM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7661606A328
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7661606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P69IL9dh;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ptAAWoMM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793716212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZoRZXNiQ8NMox8dMfPzA0JIR2VNAclAv16pLDyluUM=;
	b=P69IL9dhGjrKHb4JOwvPPgjEi5mu/lKo2St8gCqynaMXj7x6ixB9+mynW7VdQYM11sv9Vm
	95JNh4lZLDWBYRnNkR5AVo+1TYHA1ZgUVMTMvWF3/OZEHVlCy9c/zhJ/5zu/KGNEF7/5te
	Zh2cSarwjSwf3WER4Hp29vj5qGrv94E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-_T4BagUBNuGW2iCIsex-kA-1; Tue, 03 Nov 2026 09:30:09 -0500
X-MC-Unique: _T4BagUBNuGW2iCIsex-kA-1
X-Mimecast-MFC-AGG-ID: _T4BagUBNuGW2iCIsex-kA_1793716208
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so41520825e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793716207; x=1794321007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZoRZXNiQ8NMox8dMfPzA0JIR2VNAclAv16pLDyluUM=;
        b=ptAAWoMMQ4jIlTGhPaevFnJSkfw7nk91LJPzGw5zhqeA2RJDKanDeRSH2D5LGckZML
         nG0/jUmdbOHjXfb5Lc3eJGzAj5w0TjIj7ilnd2aGtksLRt4m0OmBSx4jtkXBkkUJzhUt
         WQtqRkR5WIORTaKbkwyKbVJ2+D9l0c7VsxzYsoyRpgMLDoHuyonf5OSUNSoOWV69X9zP
         cGpk0wu3HiCr+BsrjCS70HqcWY1KPvsbFL4/nJVtS3Z8Q4/yM3r/3Z9OavLjz4uoT4kA
         UvhzfqC4koWH+aKRkkFPf0WcEYD7djZH1Z2Snns3RsYdAEBIl7RfNRJXQSZRv1VUC3le
         BRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716207; x=1794321007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZoRZXNiQ8NMox8dMfPzA0JIR2VNAclAv16pLDyluUM=;
        b=DI38LKDIb5RBkzpbzKfwjS/nPQitSznv9P2kz0QgtOXcpoh1PYQf+ZvELKaqpXqX3U
         jTJVRxNt8kxLJJHaHZ9+aztWllWdsDQO8E/V/3QVMGWVdmYqpHbm5K/WA0f+jmvVO02d
         lbg92iTqTcmBBBtoeeWE2sQ18yaN38wpWdrvlFxlkDT7dYhWj1CKriMCb/nw6Pisy3sG
         h7tOoa0rg8LB4rQ6mZVts3R1/z73ZeNDZiGxjEnFGz/mjhFQSM9HPvLglXwFEqOljbuF
         ihHlYTQTihw/5koInkvY0+NuxIhKwFNXR3qjH4NIluqa27OSsFqPhL+VJJVVL7n1EIMJ
         c+Ug==
X-Forwarded-Encrypted: i=1; AKwUvByyuiHsHIndFOLlESz743YEYR3tgvf+8nRDkdOV4LhfkWCvyOVYlE8ZU0Ms7F32MigNflv0foo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nufkdZTc5bwATSzQCFa99eETf77NQKOe9vrWyL+YtNQQjPYif
	nwyoAcND7m13SEPNNJdK3im/cTMsX+b951IeIsGVb+OwlHtK4fAZY4Vcpr8bQJ+8tJDdXFAqLIY
	P9sUKM4byW8hbLPigMqqsv211W8hrHSU3YM7Reb57vC64XsbA/EjilvEovA==
X-Gm-Gg: AYBFou3axKn1KZfZnIMDD0+ziJOcmHEnTq8AY8m/Jh0w6cR8slFU2jtl0eVlmuRfSO0
	YjGlD20rpLeVLmenuYBSmHWO5MgvqhxMQEhmnzJ3HRD/0qe0auXzz7lmGRSvM1+TuBYrd78XWxo
	BV4eDeGWogmZyZBxVtod/FrPGEqy1wjsyC90wkuXgtbbABuynnHSWSNQnmFvaUAt7IhoxC5z7K5
	SXkPcfHBDXlpX7PmCjhgrt5GRrCnYFXnTm5fTAtG2vmnJwJPoywxlN16a4QIsd5rzkOWla4feYI
	k7G+/V1GjEoMZTvrmVbt8/DxKuG9MD8ZBGxNfMrCCYx5g4IZyC4XN/EqRXHoRdw3SQGF1IOti4F
	RweJUVo1wXQ3jOsjMB2AVY8/2bMADguk9wL72xfq8EOpOhBKBmqi3Lfdgdme+yXGqWA0XlUeXWZ
	b17zK/XKAds9Ar2mGjBfynk0qbt5NkyvCurXB2EiDE/QM=
X-Received: by 2002:a05:600c:3ba5:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4ac16fa356cmr365438705e9.11.1793716207503;
        Tue, 03 Nov 2026 06:30:07 -0800 (PST)
X-Received: by 2002:a05:600c:3ba5:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4ac16fa356cmr365437535e9.11.1793716206907;
        Tue, 03 Nov 2026 06:30:06 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09bcc967sm258052195e9.3.2026.11.03.06.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 06:30:06 -0800 (PST)
Message-ID: <0ce94ca2-e742-4b97-b704-1ae24da7b41f@redhat.com>
Date: Tue, 3 Nov 2026 15:30:05 +0100
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
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
To: netdev-bot+sashiko@kernel.org, imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20261029214219.1035176-3-imv4bel@gmail.com>
 <179365718192.3131.3817815695107204474@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179365718192.3131.3817815695107204474@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 23:06, netdev-bot+sashiko@kernel.org wrote:
>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>> index b0239d203f045..860145d810ed4 100644
>> --- a/net/ipv4/inet_hashtables.c
>> +++ b/net/ipv4/inet_hashtables.c
>> @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
>>   		if (sk->sk_hash != hash)
>>   			continue;
>>   		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
>> -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>> +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>>   				goto out;
>>   			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
>>   				     !inet_match(net, sk, acookie, ports, dif,
> 
> [Severity: High]
> The commit message says the change targets lookups "where the socket is
> validated again after taking a reference". Should the MPTCP token lookups
> be converted too? They follow the same pattern but still use plain
> refcount_inc_not_zero():
> 
> net/mptcp/token.c:mptcp_token_get_sock() {
>      ...
> 		if (!refcount_inc_not_zero(&sk->sk_refcnt))
> 			goto not_found;
> 
> 		if (READ_ONCE(msk->token) != token ||
> 		    !net_eq(sock_net(sk), net)) {
> 			sock_put(sk);
> 			goto again;
> 		}
>      ...
> }
> 
> mptcp_token_iter_next() does the same thing: it increments and then checks
> net_eq() again.
> 
> mptcp_prot uses SLAB_TYPESAFE_BY_RCU, and mptcp_sk_clone_init() clears
> SOCK_RCU_FREE on established msks:
> 
>      sock_reset_flag(nsk, SOCK_RCU_FREE);
> 
> So an msk can be freed and its slot reused while an RCU reader still holds
> the address.
> 
> On weakly ordered CPUs, can the token and sk_net loads in the re-check run
> before the increment? If so, they could see the old object's values, and
> the lookup would return a referenced msk for a different connection or
> netns.
> 
> Callers include the userspace PM netlink operations that look up by
> token, MP_JOIN handling in subflow.c and syncookies.c, and the diag and PM
> iterators. HMAC validation would probably reject most of the MP_JOIN
> cases.
> 
> mptcp_subflow_reqsk_clone() already uses refcount_inc_not_zero_acquire()
> on the same msk objects.
Even this part is better handled with a separate patch.

/P

