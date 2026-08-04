Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49446C83E
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852527; cv=none; b=qEO2/bjO8I+8ylJ6KE9XZn2hMzyRHE228P9GT90Qr4UieUzQO+om5IGFULNo+MlVx5Zio4uPhdDSu1BzqDfRvqKdXGQ5ugfLA9R4I9KaIHL74sWgKhO6lDVRYZiutmxVqTfzTPnrV0g4qWZD/42lH8Y7JRTvYX4hfTwJNVV7se4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852527; c=relaxed/simple;
	bh=cgYDEwDnXNfrwdk9tVNIwmHDQi12TweMs/BHwBg9tBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vDOXQTrY+LOkA1sAS7ly0tuCxgZs5OeMg414tBOH9It5xs50dzlTP2vH97DD34F3meuCcibiG6LcsquIdrf5kTkOQl2y6naQyDlSnwae41vRoFC9OXCjMIqCeoWTjUwymb/iRc200wboXgNXU3yZEyD6heTdtsR2Gf7Ng4kvCSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5hk76jO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1ZCJj+9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5hk76jO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1ZCJj+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785852525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LsPDhvpVxFRqbtHPix39kF9hXTlQ+yjqttW+ufqj24=;
	b=g5hk76jO/RENa5AD+csY4zmkySPIshvAWW5oRFhZPPyNwO10rBKFAmb+nHjP5GXTGKvrPy
	pyKEDdI8/OmdwnzWjoluQ2fENrqskugHvtJblD6UDbxhNoFj/fB1PoKahweMCXgc+fVitj
	gpUhUkhcdZfhs6fCnQqxG41Ir8o/Fog=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-ulAvaNSBM4mfVkkx0mw2cQ-1; Tue, 04 Aug 2026 10:08:43 -0400
X-MC-Unique: ulAvaNSBM4mfVkkx0mw2cQ-1
X-Mimecast-MFC-AGG-ID: ulAvaNSBM4mfVkkx0mw2cQ_1785852522
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4729d2a64efso520952f8f.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785852522; x=1786457322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+LsPDhvpVxFRqbtHPix39kF9hXTlQ+yjqttW+ufqj24=;
        b=H1ZCJj+9eEdt4Ke3XwFvc43boHUk+mwdavvplDRItJLJSkv2u3oQFKCobwQ+9fkyWF
         5pTv/f6gCiUmihyLcvoh9EaHzA8aC4TjiftB6dcQAs9P4XhmjPUCOZKvzDxjHr6TJDWZ
         BHItE3OtP7Uq2n4TIeSSpqRCmSL4UM8dKb0v4T0YIjJxZ4rq+/ECG815U1OjUOwc2id6
         pmCPIlTb5xfI93+fVtBr9YGRhyQRQ063ANk2aHZMNX8WziTbATF3M6NMbDY8MDNm78Q5
         jk/jzPwS9VowkwLqqH1uvEhd02px/SkdISVwarj6T/c4p3Zflm9NVgTp7E0GdLWD6ThJ
         l9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852522; x=1786457322;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+LsPDhvpVxFRqbtHPix39kF9hXTlQ+yjqttW+ufqj24=;
        b=Lc+/nqX94anMy44OQaIevcm2OlANh/nY9C7BjgGvnilGqtwnYjO1FU1FjnuZ1jqkeU
         lNsn3uRw6NmOWCGP0+mYH/oajCZi7J/Y2updYoT3TOeTLUfaFKnbG7Cla6FxPdffK20s
         EWzVmorNcW1y/PBslBPlBtmqGW1eSBQOKTz5zqRAfUCm29ztNCSLbb9OmfoHc+LlrA4a
         lhLciNv1ANNtCbhzw1qZ/VOlTGWnycG59I28Z0zAx/loBf/NIsHgfos/OBCyy2D9Wuc4
         U3Fz8znWem+7Ba4p0GZ9cfZ/l2qMJDK/a2cQNSxlgxIZC65GunSIgoK5P3vWz+Xrmm/A
         wSNg==
X-Forwarded-Encrypted: i=1; AHgh+RqWmMK2eOnxJLmaYn0OxSZ+H4QR+GTdpNksW/TKlz76fkcOjFmF8AKVH3DZaCZyq8QbaW9rPXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sQJ3W5HLFUZzYxUj29lk/K1ftzxv8XmySC0L7/I3o8ddNBzE
	aODeGQBHybSsWsEMUq8TA2Tms0rm0dBU/YcJvUbFxx3Zerqi8c/tg3vQbnOVbWc+YVn12J5Qhut
	NweXnXM/YF4HcYVaWovz4LojD6ba0ZCYyu89OJmIATTSCrJRD36i+h12uvQ==
X-Gm-Gg: AR+sD11QPJLDTAHZ+8/1UONI+6Hco8Gg29S9RGTJUEp4NZG9RThO44BkAaRBE570TZZ
	Pphsb9gDxDhcTnQCVoh4uTIELUuMFkFndfAbP94tYw37CbF25NdXvg3JoCZpfy7KJo2OKJjN/uz
	jRNX1LRYRT3JqWlJCeujXc/3dfHCqcGv4jkbblWVs6/uBVftclY0F8a9ibWh4BVBYVjKBwNG50m
	QFb/lakpZ7WO70rMwiAEoBE/FQQEbDw9d1lKyZoQvca1VALObeF6MSxqJQDUc4/4n8nuNGXEmCT
	8pGkHt3fPERV3ugMZCuagugBQF7yJ2E1yTASKkzIzD6pM5mnz2jvl7Zhwq4QDd9o4nwdR6y/I/i
	UrAn0/uK90X68MECx1lGQlJB2vDZNuAuhh8GOt1uwzfY0f3v3x6qrJtjfsWgyYXmHtWQPUVsdBJ
	w=
X-Received: by 2002:a05:6000:1842:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fe81c299dmr11454168f8f.14.1785852522275;
        Tue, 04 Aug 2026 07:08:42 -0700 (PDT)
X-Received: by 2002:a05:6000:1842:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fe81c299dmr11454036f8f.14.1785852521894;
        Tue, 04 Aug 2026 07:08:41 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6d7sm45228918f8f.19.2026.08.04.07.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 07:08:41 -0700 (PDT)
Message-ID: <3ad893be-c46a-44ba-bcb4-8665eeb41fc2@redhat.com>
Date: Tue, 4 Aug 2026 16:08:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
To: chia-yu.chang@nokia-bell-labs.com, emil@etsalapatis.com,
 jolsa@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 linux-kselftest@vger.kernel.org, memxor@gmail.com, shuah@kernel.org,
 martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, horms@kernel.org, dsahern@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 kuniyu@google.com, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20260730114919.658373-1-chia-yu.chang@nokia-bell-labs.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260730114919.658373-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/30/26 1:49 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> This patch replaces existing min_tso_segs() with tso_segs() CC callback
> for CC algorithm to provide explicit tso segment number of each data
> burst and overrides tcp_tso_autosize().
> 
> This change provides below impacts on BPF struct_ops users:
> - The callback is renamed from min_tso_segs() to tso_segs()
> - The signature gains an extra u32 mss_now argument
> - The return value semantics is changed from "floor value passed into
>   tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing
> 
> As a result, BPF programs shall be updated, because returning a small
> constant will now directly limit the final tso_segs value instead of
> specifying the minimum value passed to tcp_tso_autosize().
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Sashiko nipa has more feedback, that looks relevant to me even if it's
tagged not hi prio:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730114919.658373-1-chia-yu.chang%40nokia-bell-labs.com

/P

