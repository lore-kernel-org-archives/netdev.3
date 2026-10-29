Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276267;
	b=Ym5jUzFqpiJ/A+MCXoNNrqBBxY2VRfztbfgPrZxsIY8ZvYKt5x6KIhCMxCLQD6QLvS8T
	 fjV7LzUwZGTy1Quu29411C/4+bmJNYCtc2IDreUBLzs7cEpZNdmg6qpbUSfBDXForO7bh
	 fGPbd7fBmaVW+EOTj8pZnn6BCJhpLbXn7YXsXuXe6owk0+sPT1FgeDGoyI473He0q5yb+
	 uP4i3NBOFFw88Kk0iE3la749RjZaIIfZWIMnsr2cZWCdJlsf2cL4YaCaY3l4owlkYSIV5
	 i8Kj0izO6pxKXu2Zq3eZkrq5wQf5+vUdJLavfq/00PWHQ/P7nRFwlFqtFyn4wl9o/6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276267;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1Ls6SQIDsEqDayI2UmQuWAtaeX6jCMjrY+XgVw+83fM=;
	b=Fq5eAAz/RVZsNlIFUJC4150eU+BE+Wa8+YshPJ0UwCzNMAJEJophF8dPmPvXRv/7jueR
	 yadO329i9B7aMWogiHEo/YmqlMksGikpBVEiKuRD2tyOo6qpEo4TOAQPqmc14qoFPzFcK
	 jnpTr7Q/3bwujkrsZ/Wt9gDIlsKoROo4WmvnsEZC9J5GrCoIrbDAfxoZmc48ZqTPruUBw
	 +faxUQn5YrxK/PZcHys6DNqsrNqnI66VDmOFz2jNcsOLdoTqM2tp3hROKXE1cyenOf48L
	 qM+r12U+32pOTPsPfnzlLxVviyZEkhHVvpJrGNCB2UNmoTjoTEYzIZrgqvkDZNL3chA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NUgE14in;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dhqIoxXR;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0D606A336
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A0D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NUgE14in;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dhqIoxXR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793276266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ls6SQIDsEqDayI2UmQuWAtaeX6jCMjrY+XgVw+83fM=;
	b=NUgE14inmzLXpY5RigzA7huJQO1Ne8x1y9WolGkorpMAFtgJhVqsKSQq+XgKYGcLUgZDB9
	eOhTytSYbqxlXwQ5uZRFK3uLT1AGM060esi4TrMeoAk3/ap0yK+Hzr9G1cU/PNbUd7K1VX
	DYFnmhSxbQHRV/CBKgoPKiDSJegN2fQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-xKGIWgycPJyncaN45KXN5Q-1; Thu, 29 Oct 2026 08:17:38 -0400
X-MC-Unique: xKGIWgycPJyncaN45KXN5Q-1
X-Mimecast-MFC-AGG-ID: xKGIWgycPJyncaN45KXN5Q_1793276257
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso19099415e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793276257; x=1793881057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Ls6SQIDsEqDayI2UmQuWAtaeX6jCMjrY+XgVw+83fM=;
        b=dhqIoxXRdXRVif0YohH1pWgq0Bgqd3SGalJfi+ff8jMofaVu46U8861Mg5kfOyFzdK
         8nWjnI4nY+rQWCo7YiGWc5QBRIj6KWiwjoItKTX7YthMeZAeLM1dyxWVaP7Aaj5YVqFp
         LHKtnDHWnNq7o13FpkEgEEbnQw1beQ4/kEPXJ/tplLPQPwUu9SmNFmuwFBBxMDXmZmer
         FKCNuzDBdQdhSDaSC33gHqIknQ5KAM6deTHPKrPxLQ588Txcg4LJrv+rY9Jd19W7pQx8
         Ih8F5B2mFwWTidBCWsYP5SFHN8vZVG+Y3Y75CF+hfJoD+dtDAPeT40USYKUFBZ9Ad11V
         bySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276257; x=1793881057;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Ls6SQIDsEqDayI2UmQuWAtaeX6jCMjrY+XgVw+83fM=;
        b=mo/pSdJHpoCWkHt/oKtHqh9cSCkjomG+PFfWPy0RrhsWnZXfhXvWcnPGbBXvYqcyMl
         hOdZYXCRHp/YLZmIaIUMp6VgVK/Cy/XNctkk/WqWmnrmitDari4kVKTXIIMBMuKe9g1E
         yIMo3M6fn6k1VYPyFtmNpqtRj3Mri8jucxyMsoswUR+p4qsg/jVQhBd1z7QfZa1xLf4B
         xNcNTyPcHWhYckelG83YynX4iKYgBYuM3RUeF4FThH/JuDcSBP92HCvcElqkOf1VBChh
         jKrBypolloD1LaUl676/ZHqp2OJMts8KBNs0fPJA+htPqU0LPGax9raMdQm29Gx+IHo+
         yLUg==
X-Gm-Message-State: AFq9FYIcknMnKRCyjSJPamawBL868JlkYf8Aqn54jTHjnJKa6E1uWaU9
	2srcVryybswIovc29qCqSf7tV/dKOFQ+HoFbjk+aIHy9TLWn2pmt6PV/4cXbN5Z0IgvMDG0cuoU
	CFpu14Wjaq8eKG+TSPYiSRkg/eRcUJJjEU/IGeIlVmgf3euzqGxm/Vb57gyutO6Pcvg==
X-Gm-Gg: AYBFou0ndwTe+5wA7jIcfFC2ZT/J7FU+Maqr5fvTBl/4vKQD7TsNBGbSMiMNfxwiofs
	RXoRUvYjUFVtFcFV8H0PKGiwL/caC51m2ql5GLUXs5Iq8BtvtFqtuBW4fZ/ixJEC/zskblgE7A0
	hinnTtGuDgiTeDh/hyUkzlOypH4dW2kHEWq2rU/4+yB1oGXiQ39Gs4JGiV6VUw19VYa4u+IVubb
	q88Q1V1OPRJBgvDSnbFL5VcCUT29X9FlmV/zj4/9IY6RpUI90+bNDWuWlZJVZE9kBJaS5AR9LQC
	FyGtoN5wCUOpg/eYIcAHmgMftBbighYabUQSEH55Cq3ziYTA6BrtF6PYG8eFAiqqnTQFAcToDJI
	rVY/H1ozqWhIG5vz/eqv7UAXU0jcWqRcCEAeB6bhyln05SPvd5cW8f6L1OlnQkeaUp4KdIUaX/9
	qdkc0cfdS7G0QbAwxUcCMN8BsaICO1W9LAvh5gOv+y+7yADys=
X-Received: by 2002:a05:600c:4e93:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4a963ffc210mr123001085e9.4.1793276257346;
        Thu, 29 Oct 2026 05:17:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4e93:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4a963ffc210mr123000495e9.4.1793276256962;
        Thu, 29 Oct 2026 05:17:36 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm70764985e9.11.2026.10.29.05.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 05:17:36 -0700 (PDT)
Message-ID: <2172a7b5-a2ae-47b0-a28c-4df2eafca319@redhat.com>
Date: Thu, 29 Oct 2026 13:17:35 +0100
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
Subject: Re: [PATCH net v2] sfc: fix use-after-free of filter_work in
 efx_realloc_channels()
To: congei42@163.com, ecree.xilinx@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, kees@kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
References: <20261023134214.322796-1-congei42@163.com>
 <179310908138.3134.11515982039281965575@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179310908138.3134.11515982039281965575@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/26 14:51, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] After a ring resize, the replacement channel's aRFS expiry
>    work is never started, so periodic expiry stops on that channel.
Looks legit.

@Edward: AFAICS sfc and siena use two different channel structs with
the same name and incompatible binary layout. That is quite evil...

/P

