Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E3D4D6C57
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643807; cv=none; b=CRom/no8in2BsK3767ULUsmxVGnn79s30lHxRe0mfN2UpAB4iDYg9AoLc/sxcL1ThGpX/seFvmXOi3GLcYHdJBjYujKPiC9CdRKiXDeThXD+5LPmGsYdW7Q+hrU/1kONj3lE1itoxl7CoFji56lwbqbSW5bWFcR3om29y94i8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643807; c=relaxed/simple;
	bh=zLcvCiAPD5wWmnt5hHFi7ShfG7dr6QAZVgPTgrRf4+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5GbWVkEYi0LaGyoE54LCPTtxwkSPrzmOruAVZVgTEngQoqvGyv8LFxLYWqX4m7lhoR1Gf0VHBcZ4iGqYr/CNy5FNj32iux108+/lrkRNBPcLpQ1hSBQEK/ubxSZBcT9YLEm6HqLlQ4Ngc1tviXqwp4IaTiA81hBrMX4anxyfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjhJOd/p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAEfSBV3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjhJOd/p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAEfSBV3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789643795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eP1uMmtD3DxvMqH6cKa6vonPQmGtZJRICWnH6003KGo=;
	b=EjhJOd/pT4Nx2y9uEmIhTqJMjm6rEQ8wkh3iojt9J5CMQQcbBujrTA4ZlogwF2tlm3Hl6K
	64f8bvGj8MQ7gzQUUYM+7lBnvKpgTVudQk0rzCYmQ+vNCR44gaKU/JSY/UCZg5j15y4DjF
	B22SxhA59KDEfQpCn8jcIb31lSbfpUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-MfWSS9kpM5GxfZXSTL9dfw-1; Thu, 17 Sep 2026 07:16:34 -0400
X-MC-Unique: MfWSS9kpM5GxfZXSTL9dfw-1
X-Mimecast-MFC-AGG-ID: MfWSS9kpM5GxfZXSTL9dfw_1789643793
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd74fc1aaso5262545e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789643793; x=1790248593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eP1uMmtD3DxvMqH6cKa6vonPQmGtZJRICWnH6003KGo=;
        b=AAEfSBV3QYCL6v1ZHf3Td06Ywq3fVFWCo1QrKvB5MlMocJ/5YTnu50fZeAXNCrQrZf
         Ih2k2hkle3HeAMcPm6TAOui+9KD8MaxC2tuBb1oJFFbntv1oFOpadcaKiEuxE6n7zA/p
         pG/nBFAXSLXFN1f2BMxx8jSip1jQmOpIKA6xzAcIIy38KedFoBTssV9gC4aaZkXdp44n
         lXAMO0Ef95jGlW53TWOj6gD7fVVNbgrE4Q4ZGURl6np2OZTQ5kEShiq8P3z+nbIWYtPq
         vkr3FL6YSBSwVlIGc8t2KwFPwOzFGRjSJKbXLtzL3Qm0g+K08Qmmz6/BdcVI0+f0QVmV
         gnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643793; x=1790248593;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eP1uMmtD3DxvMqH6cKa6vonPQmGtZJRICWnH6003KGo=;
        b=FKXvHCN3AeXyofdCpUilkqESMvSkaXgJl0TK095IEJoJtcyc3g3ZTpiihEE9k/h+1r
         P6wXHRrujY6P9i+0qZhV6tjgknECpMGFrhUr6yN9298YvDqjIqqHEnlAbr30/5TXpmC8
         hneSELZuE/moWyWy1AqKxEVgeH3Zmb5tbqBfKLtMP9Absyq4cpKovMf5AhiZEbnVMolq
         x1TJhSvJ+RUzqeaKv8rpGUOGR0wtmiKZUS5rLu73IS0ENNcNa0SynYlJ14cvHTld937H
         khZSoRDXfe1FBFY3fbNmeUyvycO2uER+uI9SNWTs3qwC3RLkGfY/3E/8PHu1iIyNPTFY
         C30g==
X-Forwarded-Encrypted: i=1; AKwUvBzOTYtW8lolWiGZnpcWr6oktQUwkAsO0R5vRvG2e4TVwWQ8sF1EfsN5cAUIoytDGbQl7HpEV8I=@vger.kernel.org
X-Gm-Message-State: AFuF++kYDU4vdIBixaE0qNrIX5x+xYnz+bakdIcKusVCO63geSQRv4ln
	kboan+sqLBffugCY6BHYcXugwyPGRvy7ZzlNofr3uOzfhxT4jNoWAhf2ksl+IsP9CR6eoZWwaL5
	CS0bPHLj+7ir1RjbgyvI4UYmPTETMI4MdJONhpvhecCdAJd5ES3nDgXc7Jw==
X-Gm-Gg: AYBFou2/1Y74TGsLgy/9Xp1zfdSG1/4pt7s2Rz9t9q52LmcApJSeabMn1fD3avnoaJt
	My7GHHnWrUIY3qb6zOyJrKrAyCPF5U07xdSBOI5Vm7or89HJpNbTjSmMjR7SSzurZafEq5IbBjh
	wrbZ7iW3BfiIvw7aZ7cPdGcT2eJXByFDSUU2HQEZQsvKQyn3go4oT/3Hyjwo9ZTRgFSBWWMgEe1
	T2UDdVzMAEKupPjeennmUYBuWJ6WK5IxkIiQ9ALLfcznNynFmrFfDEzRZgb79e4YX7EOMDkkpw5
	g7FkR03lj4VwDqLBcqr+OGVcZ1xf26SlVPIj13Vozicrup0KXKnztFdfd8TdW6WLb+ZutjB8fnW
	9mire2XZ8gT92l73nDx4D8YvD233aS9GYYhnWLbJuJgRC6xvFwJeZmBO2A8RbVtyQugSR+MG54w
	==
X-Received: by 2002:a05:600c:3492:b0:49e:7d25:f397 with SMTP id 5b1f17b1804b1-49eb7301fd4mr64756565e9.15.1789643793384;
        Thu, 17 Sep 2026 04:16:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3492:b0:49e:7d25:f397 with SMTP id 5b1f17b1804b1-49eb7301fd4mr64756235e9.15.1789643792937;
        Thu, 17 Sep 2026 04:16:32 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbf415058sm42188045e9.0.2026.09.17.04.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:16:31 -0700 (PDT)
Message-ID: <b32628f0-834d-4906-8479-7687887e371b@redhat.com>
Date: Thu, 17 Sep 2026 13:16:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] mptcp: close race between scheduler and state
 change
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, netdev-bot+sashiko@kernel.org,
 mptcp@lists.linux.dev, stable@vger.kernel.org, shardul.b@mpiricsoftware.com,
 xinyang@anthropic.com
References: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-2-a257797dd5d0@kernel.org>
 <178959153630.22033.1222004531183755077@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178959153630.22033.1222004531183755077@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/26 22:45, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> - [High] Incomplete fix: the identical `mss_now == 0` divide-by-zero that
>    the patch guards in `mptcp_push_release()` (net/mptcp/protocol.c:1667)…
> 
> --
> 
> mptcp: close race between scheduler and state change
> 
> The patch guards the tcp_push() call in mptcp_push_release() with a check
> for info->mss_now being non-zero, so that a subflow which failed
> transmission (leaving mss_now at 0) is not used for a divide operation.
> 
> Closes: https://lore.kernel.org/20260525194828.1137119-1-shardul.b@mpiricsoftware.com
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 0098e28309318..709610db3ce9d 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1664,7 +1664,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>>   
>>   static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
>>   {
>> -	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
>> +	if (info->mss_now)
>> +		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
>> +			 info->size_goal);
>>   	release_sock(ssk);
>>   }
> 
> [Severity: High]
> Should the same guard also be added to the second tcp_push() call site, in
> __mptcp_subflow_push_pending()?
> 
> That function starts with a zeroed info:
> 
> net/mptcp/protocol.c:__mptcp_subflow_push_pending() {
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> 	...
> 	int copied = 0;
> 
> and info.mss_now is only ever assigned inside mptcp_sendmsg_frag(), after
> the early return the commit message refers to:
> 
> 	if (unlikely(!__tcp_can_send(ssk)))
> 		return -EAGAIN;
> 
> 	/* compute send limit */
> 	...
> 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
> 
> In the non-first iteration, the return value is accumulated into copied
> without filtering negatives:
> 
> net/mptcp/protocol.c:__mptcp_subflow_push_pending() {
> 		if (READ_ONCE(subflow->scheduled)) {
> 			mptcp_subflow_set_scheduled(subflow, false);
> 			ret = __subflow_push_pending(sk, ssk, &info);
> 			if (ret <= 0)
> 				keep_pushing = false;
> 			copied += ret;
> 		}
> 
> __subflow_push_pending() passes mptcp_sendmsg_frag()'s -EAGAIN through
> verbatim when the first frag fails, so copied becomes -EAGAIN, which is
> non-zero, while info.mss_now is still 0:
This is a pre-existing issue but it could deserve to be fixed in the 
same series.

/P

