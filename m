Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653815;
	b=X5CVOSLaeNgHd+XKMHKr06zUJH3FqEFHpYRtDyOLqhY9TcQpdjQaXYk+l/s/vcoJKpzf
	 0zmiS+/HBSslfCUCvx9k/LcS0virtsyitTIhyZK0yY3g/NgY8L2IaUgtDsCLr1rk511Zh
	 bpwAeJOF14z5zlkoKjXQRYldRAeEXlaRoNIRbNDQX2qzaqrmKSdmxa5I/mj6RULEyEUfT
	 yclBe1FdklvxesP2gmTy0kRNLXj9DB6yDiXaIEGM+MjnQOwjb15YjoCBsTy0/nB4RMUmB
	 UK0pxvr51Bz6s2NR0aHhUJOOtJ1FDa7FC+kFDrI5LGzMcUcVAp24dVrXXwAVDMJq8Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653815;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=uHOsH7pt1/VWfYWB5dJiAShUMwmkj529ZnVBQbbzRXQ=;
	b=LiVkpq1R1uHJOojcBq0kEbKWRPvJHlCSdwWGbAjERGkT5N11e0XWg+6ksoeYxhm5WEAR
	 O96geDE6OTcCTTHkkw+DrENlocgcyTldHs0KTsE1LrffqP72vsUuX9KgHyag1Z9BmqoHw
	 P3RrbnaWYma3VYRBtiulAJKaQAxAr5rcGdgS5zSZA4RpKvX7AmRQJuF7CjBgFEn++TRwa
	 e/kukXWQGGnEcuHiZ8H871cyfUNF52hW80NMeMWA/2ryOeqzn+9w7h/Pu4coy7H8w6uv/
	 IL34rMEhdF38xW+UPtA67zga2xbxBV9jnTvbcWBv7D63EaRF4MWRsfYhQyagI+3g3tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fI5DHVTI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KRxLJU2Y;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2802606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2802606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fI5DHVTI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KRxLJU2Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793653813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHOsH7pt1/VWfYWB5dJiAShUMwmkj529ZnVBQbbzRXQ=;
	b=fI5DHVTIhUIv11sBWmxiVZRaM7Wx7ofIvYV7fx98mjkOSyBEnBEfxJ6/we3cYITieAES3m
	MIEC/5MMpxDfXArtJlTzeUrfTi9RwwjplLqtkvrFbRLAVo/sF0wgEaxbdwTW2GcAu4ZaXG
	wPbujMwya5ePMeyhQct/3NwuGyxODHU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ofl9bmgBOpGrLWl6xx76wg-1; Mon, 02 Nov 2026 16:10:12 -0500
X-MC-Unique: ofl9bmgBOpGrLWl6xx76wg-1
X-Mimecast-MFC-AGG-ID: ofl9bmgBOpGrLWl6xx76wg_1793653811
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c415561aaso2325888f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793653811; x=1794258611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uHOsH7pt1/VWfYWB5dJiAShUMwmkj529ZnVBQbbzRXQ=;
        b=KRxLJU2YhEXhCYgPx5Ebl2DxP27cZh/QbasJ6OrkrdsbvuhNHQji2Uen0RlwiEllfP
         ns0Rkz8nGdzjZ+IBqBgXxOkqXPLFlGbMh89Eq3XjDGfMAHTaYDe7U7s2qfQAshW4KkIw
         HBEycC0qDMI9UapfTFeARU3iDtHq4uy2k8xLPOHPm3ydXat36MonOm4Vnan0vEsRLm/+
         ZnDCtIeLOO3oQmFnLMKXLPa6ttbJsHfnedh3W6cz66SZF4T4mirvKqIuy3/7V4cBddwJ
         lsH0GAz2gOE2jq35VTvsIHcdQqFJK6IKyZxPg8Az05Yeqbo5hthZlFSrJ1pQuaQH6wzS
         ycZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653811; x=1794258611;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uHOsH7pt1/VWfYWB5dJiAShUMwmkj529ZnVBQbbzRXQ=;
        b=J+Z4rmXYe2gurm+5wEthYR9aTgOiLBJjnag0WzjaO0pz5JUXile2WRQ5GxCtzyHsXY
         X2gShprenxN37ihG5RHtc5TLS5IHIWHnVy9k7OWFp7y11dX3sA+Le8aDZ1ASrp7XBMUD
         sKM4MCFqgTOvc1cxPuU0VGHUo1hklhmDFLjH2+mGJVN56OuV+UD57WLwfONb+w5SKhMe
         ue6n52M6UAAHzoQvveQAsYD9YNWiag8RzWbYXLJeV8wKhaJured/0fQDVmcOtXpVTprc
         o5+kvgfqhHpZ1kg2EEteiOQujlJaQs/lJuevOB3eH6Xh3BKvupOHaec2pPLVHEA6Qnxl
         LD7g==
X-Forwarded-Encrypted: i=1; AKwUvByCp9S7mIOCuAqsLa56ifOl+4U+wazfR67zxn35JLXbrKTcrinGG7CTca9/WQQ6v74HOnOdaZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z98c5Ko5lk7Wx7WkE0dL9r1KvB0K8mDTeCQSb376u2sNNIGCN3O
	0n+bTodjIdFCfjC3UPA16FCU/Hgreji7gyj4CcpXUQIEr0+gDlu6QyOStbDCw/Rdu4CifCyiZg5
	cnBoTK2IroVjm9+1GGeY+belEwjOgO6pOjsOzQ5Bo2zLWhuWh7WOmcbC1bA==
X-Gm-Gg: AYBFou3nIWqmQBL4wsxoqw7RDVNIJplDBP778REWyn4sEvagrQjaBouFcownp7DEoT1
	Aswfn/vFS0hLhGluhvje0otoD0t+vJRzessSn2jzTjqxDElYYkVEDKG5b2UKfHuf/xPSCiUR4vN
	a80W2wehpUE5hBJhXD6KToOxQF+sgYZrL0aGkmFCj8FZGxYyx5vtjd2MLVyic7rcmfNY9JzQRfY
	IS9FDoYV2gUhuDFtCrBfj1wjri++21G40KteYJwaqoLQf+LhY5BB/csRkPMpnS+AYhgztTM51Jn
	aFN8BbcLpOtpUIhqarc4OQ61cy+73pqvFyV/2cwCFout1QcVnTqRB20umZkP5oZSV0bP8UYxIGt
	FxpmfxeFBS3iYQscYQWVmMTanWZSqXLaIj3M9zAD13nbDTBzc7fXdUgvbUo57dsC2TVzs+W6n2S
	jvgJqspNJ2KrwYANsCtL1LuUcMvtUJQ7mx909zKuCmYsk=
X-Received: by 2002:a5d:5d06:0:b0:48e:2a04:4ea3 with SMTP id ffacd0b85a97d-48e6e2c05e3mr25834981f8f.8.1793653811406;
        Mon, 02 Nov 2026 13:10:11 -0800 (PST)
X-Received: by 2002:a5d:5d06:0:b0:48e:2a04:4ea3 with SMTP id ffacd0b85a97d-48e6e2c05e3mr25834938f8f.8.1793653810974;
        Mon, 02 Nov 2026 13:10:10 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3f9sm24118593f8f.4.2026.11.02.13.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 13:10:10 -0800 (PST)
Message-ID: <acde743a-bf6b-41b1-b9eb-67cbe56fa0be@redhat.com>
Date: Mon, 2 Nov 2026 22:10:09 +0100
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
Subject: Re: [PATCH net] soreuseport: annotate data-races around
 reuse->socks[] and num_socks
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
References: <20261030120956.3026324-1-edumazet@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030120956.3026324-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 13:09, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>

Is this patch a bit old, or something unfathomable just happened ?!? :-P

Should I reset the author to edumazet@kernel.org while applying?

/P

