Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131E39A06D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820856; cv=none; b=D1100FfJg/z4aeSTV8JdNTmYt9Ktcgu9WEmnA5/O88yYSlUcqCAv9zwu47kmuNu+qX6UdT4NNQwjh3L4T8AcKjitMYUgf3jV8VTNbR1wtBWoISy0/zKaklBP8n3vr+o97y6PyB9xMe3Pj2dAZOE3O5wpW/AC3kxKkwzQoQYz0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820856; c=relaxed/simple;
	bh=tJlAXsc3IVj6GA3rLMrum3xw3F9gMLkW1xaND5zuJDk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GjndcQnXdkR9CAhpJTEJ13w4kC2Iasj3TJkOA+dmdHmA1EBZSzktIA9904Nd4wN+aBm6MeXwk6tAx+mPnEte/E82WCOWp7Tof2LjfHAn+eODhR3/pjXywkrL/egpkH3+YpkrIvnAG//1emcwqh8FPqD7UVFuvnTIm/jO9kVJ3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMbWBiDM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNyvESSh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMbWBiDM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNyvESSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791820853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJlAXsc3IVj6GA3rLMrum3xw3F9gMLkW1xaND5zuJDk=;
	b=MMbWBiDMTRGT+rA1pe9SztvDmm1bYPGhOPJx4BAVblRWeDyIZakm+1lcw/zjX2Gu8uD9sp
	V02rd3CTEZmZ5zgZu3NIL08M+5NQ3yfBqi4Zf0Fy8cgy7WjzXw9kk9UM9sg2x33R7qgNLf
	5v6GO+0/co12ol8oXQJOAS0oNpGf70c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-bE6WExyhMFqZ_LqH2zDlXg-1; Mon, 12 Oct 2026 16:00:44 +0000
X-MC-Unique: bE6WExyhMFqZ_LqH2zDlXg-1
X-Mimecast-MFC-AGG-ID: bE6WExyhMFqZ_LqH2zDlXg_1791820844
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1813fea7dso32364495e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791820844; x=1792425644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJlAXsc3IVj6GA3rLMrum3xw3F9gMLkW1xaND5zuJDk=;
        b=ZNyvESShiLWMsKO/FUJr4i+u53QJabSKUd1SN34haZD7QZJ3QzM5Z0n/m8IdFK/BsV
         8iNAcHwACUV7w+l8hQr95afRDE1R/MJp6kpOSL2yXda94EGXPhzBrBd/Dne/Ne4hAifa
         eA4Pa6PDvWbAcQ4nnXMnQZEx5t7/kkR3151Ghxf/tgKv4WXvBvfxx+PheqWfxXyEnc7D
         c82LXrlNakD5Q6W9wKfFymMTOJJnXpMx1BRx5EaH8KugsfRd0IRevy4Qzx7qXc/ShdXl
         gCTzxBE/k6KhXvZgNpiOdt7+GpUl9P2rrcD3/hUaL9/fMoXYNrHz22ltcXQtrISrVeij
         0XGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820844; x=1792425644;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJlAXsc3IVj6GA3rLMrum3xw3F9gMLkW1xaND5zuJDk=;
        b=SSYBfbIiu1DDNoQNwg7906c8DWUqMgwo/i7vT5u/CLzA7HrAw0LjJ4znnvjN8TMmQG
         nnc+InJlTTo4IJvAW7KhaislhPfVTuG5XqDaYMdGJzFu7kzHMydH2zBD4bl8iQWS5Tc+
         p0ETDY1a0R+0xIEv0/MCYXrTXCaWVL9RmYd7tJz9VCHybZMQAYq5kQvEjXzeCvkOA71W
         EvHnu9PeXaBlGG/ng46Wih9XLiHkpuoUX5VpQG/8owPmqmpf3YpmYUEblR9rGZoFP4hT
         mTk2tmY4dqBgvZXemmgowzn/xCYfJ/roLk7B0IdwknB0j9XzpGSl1gud76+sPQtUUfED
         rGdA==
X-Gm-Message-State: AFq9FYKTcG81oE9QW2axmoazIAWHFrfNmvsiM2ffEWOdOSsCgYsbB7VJ
	cgg6u2u63D1nnQyxqUR1tFK2o0DPhlel+9o5tCZgOLhHznLQt8/hkYvMGPoittxf5D10mJej59u
	njyxb4Wp93LJEQzhHUeWvGlZgfGwPoMoQKg6VA1W0hQ4qMEHC9XrytVnkzg==
X-Gm-Gg: AYBFou2Gk3U+w2ymXriseGlQrTuS6anTn+z9YrmQP84L+2TFj7YaLiDPTnguZolBo3n
	hTAuGqqHIHW+2W7owowh5l4aR5Ppb6wlpnYhxsq0jTXiZPVYr1vJfEIhudz+n+JRNSoKTbNf1F2
	FB7NFsKt/M6/H5r/h8bxa9Qq+8xpjhEdKP3+PoNyduNx2dzQR52OePkKV2Ngelgm6OpwTujQ/Nw
	c/WDvOY4rjPc7vO+TZb26Gc3UzlUm+YV1IMpAy3pfjtgSxLzhTlF5yHOlnMXUVUwI4IZoNAYoRa
	0iuKkTXIR74mFQ1jOrQ6jUE2ocwrbl6ku/KbkHI4+NH2xj6WMD8Cb41Uy04E9CItfPDrx/gnqHR
	Ozt+M7ua/tJldGaffcT2UXN3MYH1Ah3PKKJywVyN9/ZceyoxtPwGyoLSb0yoJGq+Mq9Ohti5qhA
	==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr205364775e9.27.1791820842219;
        Mon, 12 Oct 2026 09:00:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr205363955e9.27.1791820841800;
        Mon, 12 Oct 2026 09:00:41 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967beasm240424f8f.7.2026.10.12.09.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:00:41 -0700 (PDT)
Message-ID: <11889de6-54af-4dd7-8902-01e4a5bf97f2@redhat.com>
Date: Mon, 12 Oct 2026 18:00:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: devmem: check uid and netns in
 net_devmem_get_binding()
From: Paolo Abeni <pabeni@redhat.com>
To: Kaifeng Wang <kaifengw@google.com>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com,
 linux-kernel@vger.kernel.org
References: <20261005210403.3206872-1-kaifengw@google.com>
 <179141784973.434549.3492874220530662715@kernel.org>
 <CAKkY-qOKHkuPfMk+1vhQjRymPKcG5P69CWFLYv46Xp6BiTXO5g@mail.gmail.com>
 <833b5ef9-eda9-4c15-85cd-29202e0f87ca@redhat.com>
Content-Language: en-US
In-Reply-To: <833b5ef9-eda9-4c15-85cd-29202e0f87ca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 15:48, Paolo Abeni wrote:
> On 10/8/26 23:40, Kaifeng Wang wrote:
>>> Could this break existing devmem TX users whose TCP socket and netlink
>>> socket have different owners?
>>
>> This restriction is intentional. NETDEV_CMD_BIND_TX was made
>> unprivileged specifically so that an application can bind its own
>> dmabuf directly and transmit on its own sockets without needing a
>> separate privileged helper process. As noted in the comment above
>> netdev_nl_bind_tx_doit(), bind-tx is meant for the caller to transmit
>> "on their own sockets". We are not aware of any userspace workloads
>> that split bind-tx and TCP socket creation across different UIDs or
>> network namespaces.
> Still there is slight possibility of breaking some weird setup, so
> I'm going to apply this one to net-next.
Applied to net-next, thanks!

/P

