Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301132;
	b=kolWQpHgG/5cUgxWOW12dP1VT3vFfTy2MQffIPjh/hvI6qJzL3o1t3Hkw8xZN9RsLcmk
	 1Zb3O28AxPWdFx3Cl0GBzLueEHCltU103vBxTJL82Q+cTGnf0n3Rl+louFPYl/11sJeZX
	 dFVPlBP/9GS/zqA0fOvNiz+FIDXrLrQoNu3lDSK/J6eyZWUE77cnd1S4FuGLSvYMbHFHj
	 JpLDLBOB10jwSxS6KsErfBgMpnOR8IjUBv+j8PeCLVYGecy/mdH3LTS76gSvFzGLvVZpc
	 6X6ZpKAagzW8eHcu8MySewt3MeLiCtNRdB2t5diWZf9jS6lLAfpo+rCfxg5dkz/nK5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301132;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6txRH2qHbbPGebhNFcQ8Da4pFl0PqCZEwpU1XDLkhYg=;
	b=r1KaS8JJnuEucpjLyxHvyVSBNuY7WQ4Vh7YbcvgkIrb4omUBVlAzt6fKtekmNH3sQmxq
	 4h63uEJFdTgBW7YO8d4lEPLPnv4m4KtMxUUWFaEp/HakQE5JS+PjdfcdGsyIuayYOkEbF
	 W7W/ZQIwcgHDW4ukhioy8/X9KqC3+Db9bEM1L51wgLVR8pgdeuwKwS1vFwzMkcNFkWbus
	 DUvBo8l5Mwq606ump5JcisQW6HfrDZJJSdaKOOVrBfniBr+IHjfiTfWIlEwpKdVA4pMJB
	 ynUoMBD1kQlzDiKsKbEcI6l+qd4TxK2lMvfV3+l4ygDYmkh0759FFAyEGOz2pq0dS/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRp7oyHf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mkMT+K5k;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0B60A2637
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA0B60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRp7oyHf;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mkMT+K5k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794301131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6txRH2qHbbPGebhNFcQ8Da4pFl0PqCZEwpU1XDLkhYg=;
	b=PRp7oyHfsfXsNMrnHEynkrgKVZm1c2/DNOGeOD2h3paDOXDgo0gFRuglGfgeBU2unJvzQ0
	YC7yOfGuLC29vvEWUBcxf0BdrlrNebDNN9FqMBTsBLDyAlpvT4wAJkXbSXKGQb4Qoct+Zg
	d7TWkIvKfIwmZfhE4YHecvjhJUoJxyw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-iUJ5XkwIN9mmFpIZZfh-7g-1; Tue, 10 Nov 2026 03:58:49 -0500
X-MC-Unique: iUJ5XkwIN9mmFpIZZfh-7g-1
X-Mimecast-MFC-AGG-ID: iUJ5XkwIN9mmFpIZZfh-7g_1794301128
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-492425d771bso1196383f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 00:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794301128; x=1794905928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6txRH2qHbbPGebhNFcQ8Da4pFl0PqCZEwpU1XDLkhYg=;
        b=mkMT+K5kt0KSe+02VYzhm8wjNAMCk2PVF4ICvJW2e6q9ikR2F4a8NNorblCwGwC618
         fmpAmYMB4NyfMXbhg/9VP6nkljjUpf4a0VIkWmKjfkL1z7FqmMyBiEbti5EVZFYBs/7d
         18rWJDOYlq3rGXQJjqNRe86X5dlMlLnwq1aFj+4rUeF8LRs8ZuCE9qKcRfCdPfLyuKb3
         UJWFe7YuAe6Rk4DWd5n0LhMsvrhBmpAtP1Sq1uwlV/VC9hqm1kEZs/SnlOodAUYvxUdK
         hr3EkMcGE4eGBy+lTs0EewmagOibuwzRATUhnJyJ+FPo9NRoofQMKt7ccF0tpg8QZ4AC
         YXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794301128; x=1794905928;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6txRH2qHbbPGebhNFcQ8Da4pFl0PqCZEwpU1XDLkhYg=;
        b=BrS5gu3re7XLaVX2WW0ylBkkRjNm5B6FNWu9G+7Qb1aVB6ehk2ygz4IsPIaFfAqvgG
         AoOS8PIC5enGSJU4UEiukDpDX76q9qry6eKMujox5GQPoJslP2jMY69LqUGl0Ydu4uvE
         +EKHkkbs/ui7Eam5HB7/XHysp/jlOBnpESTR0Bsdzg0fekyYLNwkLzLEE5/zVjffyl1k
         w2J94Ud88wg/0v3029BlzLix3FDKXaBUbqxK9K39kRxEWpOF/Qm6iAmShDNhAxZzjec8
         0X3fVzt7C4HusS20IurwZva8FoNYADIa5dTBJJxflUBQSQCQByLj4HoGHBzJMmjTtWX8
         Ho2g==
X-Gm-Message-State: APuU4Z+pjQC5Df/1yv/U0RQvnaAk028yQznf1IJ7Imew4PkNjNm/Tq3E
	3xDnJkVLhyTG57FFnmZQLpAEnf4VbteBMLYdi5CRNONBctl8bJpx1dawH8Y2tgavEGR27bcMwhy
	t05YtVprK0XtyPl5dwMtXv/xkAEbTiwaU7eZ06Elh91f0A0WTYoCarLMIrw==
X-Gm-Gg: AYBFou2YPT5g1kUBsDAfI0qeqn0Vx++G8Cby3WGBzSa6Wy2cZ0RuMC7WNWHvOIQ40vO
	enjw2K6AojXU1Kp8f9EQy7g440DNw5MRIlkp3Mc1m6e3CVBRHvOggVSdAX2QjA+F2HNtpXhbVaa
	w0Fj3yfNLPDrJ6MNDKSB3Ay7bG1zcVfxnOcmUKK5meuWoS2zGHypXm0bPE1K75lK6A40YmGHeOt
	VJzUIKXJeVzRIhhY/CY9GoqljFXRdyrVPFrkRe8/dPTuaSD/g5Q2Yhn20LtwAts3Yol2lftMxvw
	5AShmr/a4yLq00QckcA9jrJMV+T4YEXWEKCfjdWBiC/Nbaxnm7iDQI234jfq/2eWaWZHAvydkR/
	VU8POGWRYuozqYN8Q6Fik+MXgq1Gsp3bMo4T6hy7/UdAh8rcAbIhq79Swr5pM0gFC+bWhyYl1Iw
	Z8KDOygFrxzAdxVOvy+m4kT+oPIq0aRF6JL8qo6uH1VU5+
X-Received: by 2002:a05:6000:2912:b0:493:1477:cdd7 with SMTP id ffacd0b85a97d-49830b982a9mr3450641f8f.45.1794301128036;
        Tue, 10 Nov 2026 00:58:48 -0800 (PST)
X-Received: by 2002:a05:6000:2912:b0:493:1477:cdd7 with SMTP id ffacd0b85a97d-49830b982a9mr3450606f8f.45.1794301127641;
        Tue, 10 Nov 2026 00:58:47 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4984e26f8e3sm3231765f8f.1.2026.11.10.00.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 00:58:47 -0800 (PST)
Message-ID: <09ea6a06-d4c1-4803-8bad-f2f092542bc2@redhat.com>
Date: Tue, 10 Nov 2026 09:58:46 +0100
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
Subject: Re: [PATCH net v2] net: parse the eighth nested VLAN tag
To: Avi <thnkslprpt@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, horms@kernel.org, toke@toke.dk
References: <20261101145841.687905-2-thnkslprpt@gmail.com>
 <eb689b84-eab8-4289-a48d-64f13853028e@lunn.ch>
 <CA+jvY9EydBEkSjveXc1O4o=VjaqSzWFoNCknHr7HgQrH_=EJ+A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CA+jvY9EydBEkSjveXc1O4o=VjaqSzWFoNCknHr7HgQrH_=EJ+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 13:57, Avi wrote:
> OK no worries Andrew.
> 
> The motivation was just a correctness fix to align the parser with the
> intention of the original commit, which set VLAN_MAX_DEPTH to 8.
> 
> I'll re-submit to net-next when the window reopens.
The behavior 'fixed' here is 6y old. I think we need some real report
to actually introduce the additional logic of this patch. I'm sorry,
I'm not applying this.

Thanks,

Paolo

