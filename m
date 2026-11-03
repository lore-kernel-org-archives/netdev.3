Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701327;
	b=roDLT3NliuV0rH6sjXW3RlxY3FoUEkGxHCdmzDDKLZsVqUhRTWFC8Y5VFo5x1cO28MXz
	 FxUwJwLosT2y4SnA6AbmiD27IUtTnK+ny+43pPy09G8ULEbpXn6B48bscSgv5wNN1kFbi
	 /1qseJXT0RQxeNF1/i6Giwkl3NI4G5wVWeX6zYBofCqoVdmoIZ/TQcPyjiHP3akqYvd70
	 r9JdTCOEqLiyR51WoPIbeZQOF0CYIjum46ndFRRXQaK7UGJmm//PrTdGJl10o+NdwaX8/
	 OOTfKM4T5S6OCuAvT8K590tkpWyZFQGvpMxjaFdYpC5HBKUDkj8u71RPuaLnkItwdQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701327;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UFZrl8Gqjh0zbtPSbe7UBmuFSffWEbXhNMJ/JvbVAN8=;
	b=T88o33gFWmbmfltEVtnKRwzkvIHEgt8v2p8B/RDcpS8Mq7hwROzOYSRmoXistnUFxoIL
	 o/7xEDUouhlzYir4Mcpukfr+6A/JwERXeHxuh6UwuYcXHcgZR7Wug9PoLTs+11kS1ZYss
	 sCfMycG2sysXakxaEsojMfQ1Vvhx/7c9LO4v51ZXX8HSVIKsdflz4uquQWQSjWuwnC5jL
	 V+44icN+EalfWKaPQ3euXzQWDMVY23gAn/dbbxvBLyMdx0ODOBjJWXlw+dlfaFPX4Scbk
	 lLxaGpi3Ja1ouPA0HDz8RBuiNHkroOEGp79spzn2ImcQMvFKUR2j/u0yuGvyydVf/qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UM1TOyql;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jYIQepxw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A0606EE92
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E9A0606EE92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UM1TOyql;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jYIQepxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793701325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFZrl8Gqjh0zbtPSbe7UBmuFSffWEbXhNMJ/JvbVAN8=;
	b=UM1TOyqlocBaUTmEXF41uKr1iZWdgdewvuH7z3ARWlnjM6T6yaOjzqeK5tMA3Ib3NDzVzx
	eR6T7nuyxBqr1Oo9rNtfd9uoWoci4CHQq85MUmrrsDLhEk6oIHQL2C3i0ZeBUELJ5/5Xkl
	b9vbwgOP+W/JYZoqFD/6tvTQdD/FQps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-BtRfxYQWMeGQH0Rq4HTglg-1; Tue, 03 Nov 2026 05:22:04 -0500
X-MC-Unique: BtRfxYQWMeGQH0Rq4HTglg-1
X-Mimecast-MFC-AGG-ID: BtRfxYQWMeGQH0Rq4HTglg_1793701323
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49953abe51fso18598955e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 02:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793701323; x=1794306123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFZrl8Gqjh0zbtPSbe7UBmuFSffWEbXhNMJ/JvbVAN8=;
        b=jYIQepxw5jpnE/O/Q+sT96141cHnoCYT7ktbI905uuCcQiuHZvhQz9xQI5Q6XLYLWk
         ydgMp9p2bhDlP1OyE5F6q1FBjIakzIsFJOI5KLWlE4205bkD1SnjkgYWdj/e4zT5bWUK
         y57Zl+kTN8DsWMdfW54S4i/s1ix6OJCYsoEqezWZvoaKpdTcIwVNAKZwz7yYUhnbD7oX
         YvbrYFXulXIrz1+oD9xV15ZQ3Txp4/0g7HAetCE4y17op4DxJbTtXkRp1c0wpTADOwfH
         LLvfbxM35+I85+l6sUeZbr2GiJUs4PcYip0u2feXEbBCQUZSdBI9fSeCEHBlwfZi7CVn
         7UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701323; x=1794306123;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFZrl8Gqjh0zbtPSbe7UBmuFSffWEbXhNMJ/JvbVAN8=;
        b=JFMOhwoVZBkgAE637Eah1bnm5+rGckP2zV7mP5ExW62lT2U5zA9z1Hb/r5lTAMXU4c
         zhRzdOoboFiMVJFZ/BYhlEvs/2X/GB386lwNgpijqcgg3yiUSNZxqpKo6JMtT8oPv0q6
         VlD2Vc76dFxTsj9x4KXzBWWMrhEGmBjGdhke+aTofCh+o2befyZBT2+nsa8wOd5L+uOq
         7twy0aVNHQU93x+LSAaCwcAXOrFTvXrKcB7pec4piXeORREA7obEbn9/5CtPhDifjqxK
         iOhiI29b4viBfnyAiL6OS4jkIzlKdRhM1tyu6uXVspZoxUlSLMdUseFWa4t4tMs+2b8o
         Mo3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzZM8rRrJvxW0tEK3/u/hOl1A+N+i9tPwv82spqGiaDo5aX714wKGF73S0WsvaUcQmaIxfTS3w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8O3nb5mxEjBph+CfvSUptbjeh0Nwa7TUi9HBxi5ZwjK5xi3/Da
	2GiV41XX+rxEfLJy75p5yOwcXRB3LnUZSEsf8KqqO5WffCUE1M9LKSUHJzqCtrgaM3eziAUoTLj
	j1jWUZgiX4Br/QPeLffiH1Xd0QfNuGSkynfb0QWArplw0pGf1+IRa8T6hxw==
X-Gm-Gg: AYBFou2EDGLXq0eH2z+HsCpvBGDVXgPq0ZmenXOx2xhNfFamQnoHSUAFjSwgmCD+IiC
	WSwIi8WWaOoy/00gHMCW/84cJlwTAKPX1bkng47IlClauQt81WSBCPpS/b1lqIUhIkbyUysSFun
	TFi8UFRYktJYwZHpGniiQHrTQOBtqj94qCgX+B47aZ7bJ2WPuWnohNaDl0f2SiDcUESaTuQL8Hi
	H0Q04as6ULJB3BGoweInSkDfr2GB8gicCkDCL7Oj7IP1n6GzdqLx++loeFFfnZNYuc4PWsWj8cE
	QItIo63izkuBgTnLnRJBH4y6vqq0T4aF7673ZL+WyfG2jiaRf93+MHcQg4RmVTBWNZdOW2RbXUp
	3usw054gF5F4+/xbG0s9dZ3y5XXh1VF6FKtOpVyd6/fQJL6HsE5beopbGLtTQCp4beOP6799PyH
	QPfPTmVxf63aeCO8wxApLefN/94mk/sK3uirpwjBLBWzY=
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr59717735e9.23.1793701323120;
        Tue, 03 Nov 2026 02:22:03 -0800 (PST)
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr59717075e9.23.1793701322587;
        Tue, 03 Nov 2026 02:22:02 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm293753565e9.0.2026.11.03.02.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 02:22:01 -0800 (PST)
Message-ID: <fc454b46-b66c-4a16-aa1c-3ea0c2e91d15@redhat.com>
Date: Tue, 3 Nov 2026 11:22:00 +0100
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
Subject: Re: [PATCH net v8 4/4] net/smc: bound the link failover cursor
 advance to the send buffer
To: netdev-bot+sashiko@kernel.org, hexlabsecurity@proton.me
Cc: sidraya@linux.ibm.com, kuba@kernel.org, mjambigi@linux.ibm.com,
 alibuda@linux.alibaba.com, davem@davemloft.net, edumazet@kernel.org,
 guangguan.wang@linux.alibaba.com, ubraun@linux.ibm.com, raspl@linux.ibm.com,
 linux-s390@vger.kernel.org, guwen@linux.alibaba.com,
 linux-kernel@vger.kernel.org, hidayath@linux.ibm.com, horms@kernel.org,
 wenjia@linux.ibm.com, tonylu@linux.alibaba.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, dust.li@linux.alibaba.com
References: <20261029-b4-disp-33001ace-v8-4-f9bb96e17827@proton.me>
 <179364387382.3131.13471253186660322977@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179364387382.3131.13471253186660322977@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/26 19:24, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (2) · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch adds a cons.count < peer_rmbe_size gate to
>    smc_switch_cursor().
> - [Medium] The new bound in smc_switch_cursor(), diff <=
>    smc_curs_diff(len, &tx_curs_sent, &prep), is computed from a snapshot…
I think the above are the last 2 comments standing that need to be addressed,
(the high one in patch 1 is addressed by patch 2, the high one in patch 2 is
addressed by a separate patch).

Also patch 2 and 4 still lack review from the smc crew.

/P

