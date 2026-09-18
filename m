Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748252ED33
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767748; cv=none; b=hu9ljXk+wQu4+MACUKxplwSj0AUPfd7Mca0ol/3fLNZvjED0QS9YvoeeqndispV/Uw6c+Fi3L7o22HDMaq4BC47BTgRvYKTOavavgc4gQitzVswEFhEnTsbu/vLz3RtkXvISCpCxRle6ExPO/30+WvdiBEKrQ6LPnU4kI1ITMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767748; c=relaxed/simple;
	bh=KjPU7yUV8YKznjfdFJZ/8u5qj4putFBHvzQSw0Bs9nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ey5iTZ6hJjJxz9773H+0RKewuJt+gCzAlZhy6SUBPCL+P5f4cHgH//lQ0D12C/Q7TudJYKASKNka6K6x195yVsc65FjOfa9jXcBtOUs30/u9QjzSwEIZkwvZKPiF14JeO3c2NYL8M3D4upEwPxDwAoAUhHli6gMgyaamo0L6dAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYznYefe; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYznYefe"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7c6dbc60so876645e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789767746; x=1790372546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SaY9rdrxpWgd+fB7MrfXkHL5tlhdK3VAJ96/S4AMexk=;
        b=sYznYefe5AcQc8S7mjbSusa4nAaVx41jj6vmhhmLxv/QEey5+nXuEPa0lfyoEcNRp+
         60gNP2GNimVDtOyxVozhhriebBZhl1kXVaCniOuulXdqagO4eA54IpfiInmvolcZCCFc
         uQT1JFPfLdmU785ZoJ/p6svYN/sOU0k67AK5x2YD3AL4Yk7jO6MhSGkNePMBdzxsjOTx
         tzt+RySAKLsvh+fRBZk9lj/5CLMhYR+NROBi6+gFPw73CcOfunOyvKbSJNY8UOyVWADk
         iKACShfHToWO1PszGC71TUP9yY2UiK6b9my0pjjSWFcxE7XwOFE98JWM0NWff8y6VrXz
         fsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789767746; x=1790372546;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SaY9rdrxpWgd+fB7MrfXkHL5tlhdK3VAJ96/S4AMexk=;
        b=0yCPmYV1VMTic/yTl7jY5BCYbYyERbuIQ6jxKlul2mH5WTSrcZASDKx43BKtAewgt0
         8Wnk/m0V6S19TYwJyleaUFba7f47NOnl9ZGqIqSnNQUVGoSf+6nH3/AM5R8GNFKmhe+i
         +RfJ9VdxhzM/sEOAkQrsfkXs2nzcc5fn4VFiwEiwdvyPNUNB/nP2RuUDaM1fv9meDxMP
         1fii9KmgpfdNec1c+wJN2ZVMda8bX/KrSNXAjvsHUd3eu/pn5oTKtf/GM3kmWtHerqTR
         v3bwv5nYb4ciy1+Yxzu1h5PCkO5SsFalU2sbYBBlvo1c33HNoSbdGhpUHVzhn6CVDcB1
         lvsw==
X-Forwarded-Encrypted: i=1; AKwUvByCqiBuqQ8b0qaUvSifUvyGHQcjumQnZubGcnhyGj3eG+usIINXW2QKLiIXE+tveZRUrHswXi4=@vger.kernel.org
X-Gm-Message-State: AFuF++lzz8dK/MwdUCzlAw0n+Bw4NzoJ1JA+voaDGqHQJmVYlbPojJLP
	1FZ0Wj68FNK0uWuwBdg71aE8smz1BA0YLpfSnCAcskk/nsdBkJu7QDaU
X-Gm-Gg: AYBFou2sf7oFqoEpUMc0VIuNhzCGHYorZMJ4zmyaL00g86GLBscng5Ziz7JvN4cZluu
	g0j9dYPWcSosDQvX0ScZ5vb7Vb5lSs2BMySeEUFYBFOnjycj24etj1lCNZk2ZDw8fIcurSF1ayW
	k8KArb8U9GVMfs/CSyRacQ5s2N7F64M3i18vg6ZlheePndenCVb2kuXCPQcbPRF34WDQvaX0TG0
	n1uWVLXTkc0QuvHXCR3kKlPLQuJAdkjdHP4RAqgKNg3wmF6ovf8rzGb8e7iB5/iXwN5SKJxWe/S
	JJo4IcxAFfFKA8yRFd3F/PIL/mxqXiHuz4BW+YwKkSZXDg7J1TKxmEPVMVhEMqa9mVi5DRp8sKY
	XzP2foRxAi2XKjCKZfrRwSQnMApxctUXFaXjUoXRgJZ3nOY0sYyZZdFoNAaIizXDdbxqQ8zMeex
	2XmjAolub0hT+UhJH/HXXKRqhNpZhqiylf2ItRxnSG6Li4ZiAH/biamGk49apC/eZPPMckMGKDO
	VCnXg9AjoI9xMtkazD4mzJYOosSLzBUGxr84PiT0u5lNL2kNy+TEAGwy0xFZyQv9YbT9qKqae5K
	5rNYGQ3C7VFNyHelKi5M+79+f66UcXKB3RaGMc4B1fao2+NgWrBqvd/Ha8oxtY3qAXH5FHRbcJc
	hU3AaxUjsIOWojtn6ZCaYA2NRCAWs
X-Received: by 2002:a05:600c:354e:b0:49f:c432:885 with SMTP id 5b1f17b1804b1-49fc7dff422mr38227535e9.2.1789767745571;
        Fri, 18 Sep 2026 14:42:25 -0700 (PDT)
Received: from ?IPV6:2a02:3100:59ae:19fc:400:b6b0:efdd:810c? (dynamic-2a02-3100-59ae-19fc-0400-b6b0-efdd-810c.310.pool.telefonica.de. [2a02:3100:59ae:19fc:400:b6b0:efdd:810c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0874c3sm31556305e9.14.2026.09.18.14.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 14:42:24 -0700 (PDT)
Message-ID: <a30f77cd-9a61-4cfc-aec0-eb556451674d@gmail.com>
Date: Fri, 18 Sep 2026 23:42:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: hsr: privatize interlink-bound skbs
 before address mutation
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, shuah@kernel.org, lukma@denx.de, m-karicheri2@ti.com,
 fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
 ali@iusegentoo.com, qingfang.deng@linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260808004525.1551-1-xiexinet@gmail.com>
 <20260808004525.1551-2-xiexinet@gmail.com>
 <20260813182744.4bd0002f@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260813182744.4bd0002f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2026 03:27, Jakub Kicinski wrote:
> Would skb_cow_head() be sufficient? It's much cheaper, at least for TCP.
Yes, skb_cow_head() is sufficient for these Ethernet-address writes.
I'll revise the ownership handling for v4, taking the remaining aliases
in your other replies into account.

-- 
Xin
