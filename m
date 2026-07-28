Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570A32ED54
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238507; cv=none; b=RH2Cgw3zkKNr1f0AJYRWcbt8onUNqn2xC/xBta1msmqQ11iEADPF1MptVkobYh0LSCEhiOXAdHuFdU7EaUuCWEvS6kU3TiVK0ykY7KkmAlTOwZGeTdeChVwdsOwH0M+LlAUQgcuoE1HCIAJCLxNIpsIMKSzgH0KC7sJlZ2KLxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238507; c=relaxed/simple;
	bh=jvxhuwOrYBEY4K3ZcYzwQnNCIfOk2KZlICMVXxJYMxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EohM2tB/anfG2GbcfsXderLThjvtiv7xM4VDoLC8N65v9h77rhVnGuZ788zoRobynNCc1Gtyo3sqPfY0QTdIpzau/1QqiKJCjEWQ4071NOXyANoHC0uXjxhG7YFPiebk7eN+3EwaEPDNg6BfMshY71E4BrV9e3IRiOWJ5vJqRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5iqabv9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1zi5R7e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5iqabv9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1zi5R7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785238504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKnYIFZNjnev1Dya7FU27V6HTiHGaHJ4k30+zHJNboI=;
	b=Y5iqabv9uVYIrvuMgoo6V/jF+EXDIybnAjG8vuzv2liocVnCMfaP5iYyD/DPpTa1+SEVm6
	3C3vfsETHIXzU2ClD0D9abrzLNy83b7h6+f2qx0nmeRPEQIdKLdbvrLPJRnyVfGWUnCXkU
	d4ULoBt4UgmXZXyuwGKfAyXbwqMaiWk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-_vzHPyaxO7CU5ihRp49I0Q-1; Tue, 28 Jul 2026 07:35:03 -0400
X-MC-Unique: _vzHPyaxO7CU5ihRp49I0Q-1
X-Mimecast-MFC-AGG-ID: _vzHPyaxO7CU5ihRp49I0Q_1785238502
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso15705795e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785238502; x=1785843302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XKnYIFZNjnev1Dya7FU27V6HTiHGaHJ4k30+zHJNboI=;
        b=d1zi5R7ewwpB1XXH/tGcvrfXcmkhoWF9iwUqS37YVl9E7RBTWGssTUlBVc7KHlju5o
         3xyPkb+R+rD0v27YLhEAShLjtJR1049VEhgj1UdhfVwZAd4JW+s3Hcj+K7RqLRTnACb9
         chhxNT9wu28zYSdMPL6edIIaBK09mp6vwsBvrEoLmXLexlv8XurziQof5UvizIJGt3vL
         +luI16Wkrr/A80qxhZhTmVVCA98PG01hv9gmk4YAGvSumEAYRVuNDhh/6ucv4cnaBN/J
         2X+5zy18ezjmLkVlBMUS+yemDVe5ybW1Tx8zEYU7dVyOHqZL8xwCdTN6bCaaArc6zE4V
         DJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785238502; x=1785843302;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKnYIFZNjnev1Dya7FU27V6HTiHGaHJ4k30+zHJNboI=;
        b=RsONf5xczLdYMSiQbP82zKyweTpmkX+oC1IFiiJNsebnMZ6lh4ZATgdRBXUBfv/gHY
         dIagViNK43LQfB6/zjfUNwakDry6kRQc8zAjZwvREEQDeZWLboRU8ffQTkmY0ETLOWh/
         kycZqC617zuHVWlJhnX68m2gOBXS7QSr1pDwtJ0yxwR/UpcELGR4isB8MhI+Swsw3/qt
         TnU3HJCIyzNin/RLOEtr77npP4fEfKiVwWRYSN/COlJf/HcDH6vJ/OPKT/m1SOpT6q5N
         R+jjcAJWWoMEeuxU/CWD4SS66waocgBh4CHZhqL1TNgxCYG9kRdVHnZM7hNyw2TAbWsR
         PTWg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2A26cXYTEDDYTHnOaJ4EiPaSz4bOnsATsabwdCRf44CIcQNlvPYQZsYpcvsEhwGkxvs3M3kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Psw406oCa51nRqqi69uuu6VHHerSxKFamxpyXsl/rD7+3LTm
	lLijjBqG5z7Xe870xcqMZUYFPlClNB8iJH4tiDwTx48FSj1uXVpqwj668oqB89YRR8QBjSXIDCc
	m4PX4p5c/+063rTS3LJAJQCdCYMiwklge1ArOOv5QId/uAjyXUu64tA3tog==
X-Gm-Gg: AR+sD10DlQk4ob0KAx/o0PK2LEjiskJzi3Fe5LK3REqOBKpqVIvRwwntMaC+0FSMFPK
	VCUdDWYR6PoKCPUoFZUM5K2ws1StytTA5FlLyOWxIouXP2P8Vl+YoYSCjG2rsLkwH/ypB6nj6Re
	u4XJV6S09/VS78rG15punh0t0s8kSb1HqLugsUBDGHydLkPqOkh5vwH7vSVWhWq9NSPwFpsNDrq
	TBrOhMmtQRpxs/m0cgzoIPbDdI+EkSGeUarnmhi2fz/97HwY/ubF865jx7/sO6yuborQjniL59X
	xGqVhFQnfwPDNp+BEtUTr4fDSn8+ONK8lzRzciPaK6QPCxeSGOfKjFgi7vWSgG+nX/lFE8NIlHg
	mu4Eg1mDHyki5Td+/QAKe4rxwZp6Vk3H6Ki2mbg0YoBfTzymTTnSZTchEKzH3EuFkejsXqZl9fp
	Lewg==
X-Received: by 2002:a05:600c:c493:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-496c6545a58mr20821685e9.10.1785238501797;
        Tue, 28 Jul 2026 04:35:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-496c6545a58mr20821275e9.10.1785238501303;
        Tue, 28 Jul 2026 04:35:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45b0535sm69241275e9.4.2026.07.28.04.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 04:35:00 -0700 (PDT)
Message-ID: <cf80c0ea-b33e-4533-b9fa-12f00d62bedc@redhat.com>
Date: Tue, 28 Jul 2026 13:34:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: udp_tunnel: fix memory leak in
 udp_tunnel_nic_unregister()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+eca845fb8c18dd6b44c1@syzkaller.appspotmail.com
References: <20260724091137.1792543-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260724091137.1792543-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 11:11 AM, Eric Dumazet wrote:
> syzbot reported a memory leak [1] in the UDP tunnel NIC offload code.
> 
> When device registration fails (e.g. in register_netdevice()), netdev core
> unwinds by sending a single NETDEV_UNREGISTER notification. If work was queued
> during NETDEV_REGISTER (utn->work_pending is set), udp_tunnel_nic_unregister()
> returns early:
> 
> 	if (utn->work_pending)
> 		return;
> 
> Because failed registrations do not enter netdev_wait_allrefs_any(), no
> subsequent NETDEV_UNREGISTER rebroadcast will ever occur. As a result, the
> struct udp_tunnel_nic allocated in udp_tunnel_nic_alloc() is leaked
> permanently.
> 
> Fix this by removing the early return. Instead, synchronously cancel any
> pending work with cancel_delayed_work_sync() before freeing @utn.
> 
> To be able to call cancel_delayed_work_sync() while holding RTNL (the work also
> needs RTNL), switch udp_tunnel_nic_device_sync_work() to rtnl_trylock(). If RTNL
> is contended, requeue the work with a 1 jiffy delay (via queue_delayed_work())
> to prevent high CPU contention while waiting for RTNL lock.

Side note: I'm wondering if long term we could remove RTNL here (and
relay on udp_tunnel_nic->lock and possibly dev->lock).

/P

