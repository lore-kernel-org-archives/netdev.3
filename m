Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502088;
	b=C5cGn4qAjJksfJJSD4JmYyBsOj5fCOu1zjm9qHON8EVnTLni6ew6durtX7EzXIzgyjJL
	 2bckkqDfLeGVa94If65H1JB/nISp2rIfrPSQ5A+iJ9OXTgWRAsMc/5lqUr4CqxX9DxD6+
	 wrNiInbCAlv7PT4J2Yqb9uSYwz3Rjjksus/Jnlmb7fOiTH8pdv0Ia6XmNfjz3q212uIgh
	 rFQqRgHIYq6y47/xIiHwOsdXxADP1BU1kfT8kh1krqkIPwRmehcvpbcQ3m+5Eg66+oFm2
	 kK8VCjUkc2askqUVAtS3hS5vzzTdXfWsUBA5wcham+GLMms0v5HmMN/+Wu5rbNyeEVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502088;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QR7kILSyQV1HfB+rNJZZQwe28U+a3tmFcjkLHMatFZU=;
	b=pWl9Z53Sm44uS9faDbrzzBMxit2N3mykULtRCGeuFjeohWH42wSc0S9nVPFEITct2ohF
	 0ockeycPrZDkZCKfwNX/OcfUb7fXmFXtDmx8Tj8uQJj+YNNIFjYfHtAQ0pE7X4SyYtwZL
	 pVn9q7Hb/RJpHVp4Az50bkwDFg8megT/wTqKNI4w5+yULqKKU8hDZQsUcrlXHEqifPA9k
	 lrZo2mXMbspX6vQsiSD0+0F6u3rgQF7QhqADgmFmK+EGEd8+SysRpIaLLLLlGxf3HgTS/
	 iWmn0o3J5hcM8uHV+hpIOpRk+//TjzFezXk/nD3ucPee+CTadx/Erwp7qzEALB23ovw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOapYzCL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fuBZMrI6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1D606A337
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC1D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOapYzCL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fuBZMrI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792502086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QR7kILSyQV1HfB+rNJZZQwe28U+a3tmFcjkLHMatFZU=;
	b=MOapYzCLU7cOtk6SPrp1QD0B85Fj4Ntcn6jpostDE+z6voRz7OgSMePqKfJvXP5Ebv3Lp1
	EY/SO+jvln7L1AXgzvCRXS064ZKotnZP7WE+vQkmhs1YsH4LUW8M8VfLPH5zf6QKDeevxr
	vukm/a9WlbkHhNuJMSOaitiHzjEXJ2Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-YFMmWfThNSSMzva9J3_dXg-1; Tue, 20 Oct 2026 13:14:44 +0000
X-MC-Unique: YFMmWfThNSSMzva9J3_dXg-1
X-Mimecast-MFC-AGG-ID: YFMmWfThNSSMzva9J3_dXg_1792502083
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48afcecb035so371752f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792502083; x=1793106883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QR7kILSyQV1HfB+rNJZZQwe28U+a3tmFcjkLHMatFZU=;
        b=fuBZMrI6nodLMPuR3BqaMAzawaj8/LqIqNnGc3H/vQe+Znzu7A/Zi/9TsPrbPPbz57
         N+4+M1QzqSj+5P+w58nE2uVjZI3qhG8IM26+6IBogSuXahMsxweltODNDLl9kpklTWz5
         piQ0zKOh+lwBkbfkmNvn0t8luB/RV4x++ly7k9C9QtWy+VRUznSb0bI9LUk6yZYMYjcE
         0YHy9WPwidAR40chnwBZTXdJrg0JEjSSxFQ/CPX6vF4ZE4mj1u87PVoNNiNuqKy07lHS
         4rlH1lLN6tP0yQZq4WuO2M3hVo8eIkfOPyV4OocWw7ySKt1OYK/g7ZCR7obsb6tYdlUg
         OUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502083; x=1793106883;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QR7kILSyQV1HfB+rNJZZQwe28U+a3tmFcjkLHMatFZU=;
        b=yuDjSmQwos4SwX8xz5nhkfB3W7smwsUa8sR5KBD+EzgYKC5rZKmZ9E27hhtj4qx3/g
         Crv7p2dj28NhBAh6TNJttaEzvnfr6BZEJyEpAiCluGAouHCET0OGXrV7QCLT++Kr5q2m
         IPUA5kFK/GmVUI3kkUgaTxpfxFL/RQQWNJ8P2NmpJORlQTLlYhn9XJ7mfEvkvm5v2CpM
         KEvQKO7IySuktEIgNbYBXnd7DzrKL71tD+N5U+ERYlnT0I0EFDoDxfYzm9vag7QJvAxy
         IROpd+Z/DJq17HHY+pmRa4CW+ZBLj6ogYHKueCcJrl/+Ir64UcO/iIC0J3iCcSNZqLEm
         KWZA==
X-Forwarded-Encrypted: i=1; AKwUvBzMT4REX2QX44DpCFAPu7EYFKuoWe8QQjtpVjJ1y7ZwLuvo83StQd1MtpDMdSHp/1TfdQjJCyk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTCidnP2LOvi9erm0qFwMBn2mjMlYWTaGr6lOehQ+83+ckNYlm
	0gJ9uSpRNXR9N6grbxyakVvFFlkBOYcD6S60sVbFI4Oo7qZIQRlMQeifn3CQwPEgzJ6k/6Xk3hr
	YOV/EpaEhCsMXtIfvRmcXlyz+mECjF4SnPwE0Mi5I16kopgN3pt8eFBNahA==
X-Gm-Gg: AYBFou1SpL2ZMPFWocCiDTpMdlm6DZdasY6379cEPUWJDJCcZnFFMHInwW+DIQUFP8c
	XmpBVCyup5ZfSK4FB6UyNjaf3Xeu6MJVHqmztramynqekpTn4MvwL67QEuodYxxrmTqnjFtSAIE
	iRbN7pY3kKtMlCrFdytzLGxxWQa7+nDHAo6Wg7WJ/eUvO7TUONJhlF9jY5Efqfkya3nQJYFCPzx
	hZX3FSy6lP2m8RFRtdO8ItHtv0JhDZR9N8UKP8wmqz2j4pzgKp22DdexP/N7kjtBslW0NG1dbpm
	bv771PkcknOmLW9GQK3QqfSpwi3s+EnU1kzUmp5fP42vNtn6dB7i7IX0wSDL1grzm27yGEG5NfI
	4eadzFL43xT/z6QsE0jzB34HVhG7EfIfH6TK8chMfc6EYnAav/09mf7hDggwRJzraIRa8CLzkug
	==
X-Received: by 2002:adf:e541:0:b0:48a:fad8:52a2 with SMTP id ffacd0b85a97d-48e1e77fb45mr4078433f8f.23.1792502083211;
        Tue, 20 Oct 2026 06:14:43 -0700 (PDT)
X-Received: by 2002:adf:e541:0:b0:48a:fad8:52a2 with SMTP id ffacd0b85a97d-48e1e77fb45mr4078359f8f.23.1792502082599;
        Tue, 20 Oct 2026 06:14:42 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dbbb0sm6269587f8f.5.2026.10.20.06.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:14:42 -0700 (PDT)
Message-ID: <3e357388-9d7e-4ec1-b2cb-2d4d32bf4742@redhat.com>
Date: Tue, 20 Oct 2026 15:14:40 +0200
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
Subject: Re: [PATCH net-next v8 3/3] net: stmmac: dwxgmac2: add XGMAC
 timestamp interrupt support
To: zhu xin <zxyan0222@gmail.com>, netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 muhammad.nazim.amirul.nazle.asmade@altera.com, rohan.g.thomas@altera.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261013033207.1684328-4-zxyan0222@gmail.com>
 <179195062971.434549.3907170504821168391@kernel.org>
 <CAP7veTK6NQtrweDVXsYyiMuru_Svtir5XvY_ATM8a6GWO=cqKw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAP7veTK6NQtrweDVXsYyiMuru_Svtir5XvY_ATM8a6GWO=cqKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/26 14:49, zhu xin wrote:
> Hi,
> 
> Thanks for the review.
> 
> On Wed, Oct 14, 2026 at 12:03 PM <netdev-bot+sashiko@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 5 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 5 · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Medium] The commit message says dwxgmac2_timestamp_interrupt() cannot
>>    race a FIFO flush because "PTP_ACR_ATSFC is only ever set while…
> 
> Valid and will be fixed in the respin.
> 
>> - [Medium] In stmmac_enable(PTP_CLK_REQ_EXTTS), the 'already enabled'
>>    -EBUSY check is dead.
> 
> Valid and will be fixed in the respin.

Please note that:
- patch 1/3 has more comments, and likely more relevant.
- net-next is currently closed, you will have to wait for the end of
   the merge window for the next iteration.

/P

