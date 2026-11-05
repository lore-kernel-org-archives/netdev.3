Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881953;
	b=TejoV5EaOSbLx1KM2wG7nigebrJkRoAh6apV0+G1GRbtzeF9u3rKWGlG0H66huRej+Ao
	 6IN13WPm8JJWWuCFUW4EUHw4H+f498sufjE6RBXx0RckZIHm+wZKy15qaCFWrqQVZ1/Wf
	 +f6xaBJv692R8q5Jz/ps3qT2mwLYfWRYAD4gPsXdmbyz2VY+dctagkio/TvZqEHhzMYnL
	 eFOKBaxMPmvVOjr9Df5gPckNxWJ373C69enp25xsVorIawhTL351pIkpP//xpBo9eGveL
	 h/MiO5iJl/d3Yq1dadAz+NUT0Zf7CDtLSWpY8MSHOw2qOb5ecqRG5yTf4nNj6mpLjkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881953;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bhW8bgTEwMPwLTiCb1KEBA42lBnDT9eGZiSGg8XBodg=;
	b=DiXGPaXzjMDYP1KTaG3/YIScF9xpDJWK4HYI1yuKwiYNFMPHzE5S4Ss31+DpvXIzGSTG
	 rcTHCdSzhi0Ux/dFIK/AP4A4jbx5LMi/UaSUb44W8RV8n8bVTMNdMDziXSDhjBna1mgbC
	 LYFa7wKaqaZQGtWWuuKBvpPC4RZr37NRgLVSk1/euEmaeQ2CLXBjKzCydJ/ic75AXnEKX
	 U8fZYRS/iN2kSOf2Fi3yb+W+/9FR1b9LoThDD/c6PUV1p4h/R1+noDEwwg3ga+jQItVQ6
	 Tpp5AaOed3zY0PwhsdbYLLGqn6wW+eDq1CPNUjUCI4j3pAXrpKxcFFLJ3G3kcTte+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XtYGf1W9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KTr4haOe;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB108606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB108606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XtYGf1W9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KTr4haOe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793881950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhW8bgTEwMPwLTiCb1KEBA42lBnDT9eGZiSGg8XBodg=;
	b=XtYGf1W9bBNUiNdVGmgGcmGQd/CTx7I8my0rflxtHeV7EGFnucp4eF0bEgyeh//ywQ3nso
	rIoXEtrOADru9g6pwvyamQXkUKdLjFfFInIsKjgjF0taWEz8mDoD0FxN/QDO8cdG/obUOx
	E0akaBWUNiS4uxuYmqT7joMpOi7RvlE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-x9bUjXzzO66iwMM9F9Vc4A-1; Thu, 05 Nov 2026 07:32:29 -0500
X-MC-Unique: x9bUjXzzO66iwMM9F9Vc4A-1
X-Mimecast-MFC-AGG-ID: x9bUjXzzO66iwMM9F9Vc4A_1793881948
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so26015595e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793881948; x=1794486748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bhW8bgTEwMPwLTiCb1KEBA42lBnDT9eGZiSGg8XBodg=;
        b=KTr4haOegaA3Jpyzhjf04TmHcXImXFzzrfo1/QXl3+rSGpcMj9LXnWc7qzQxL2wk56
         KDb/jWbyRyRQpeGb0T5Z6e7Wjd9R2RztyJDxexRdL+JS7W7bz/R6uHNn3YEQYNXAvC/t
         B4VNYfKb4EkNJj5FOA3Mh9cCveZOpvpUfecOwYudFRYg0x8YX2Nv6S7eCFLJVUbvSKuw
         RxLL5pyERNblWFAq4ptYqEZaDpdv7xyVYYNkFn8Cgi6auLyinBUaX1MN/1kzW16gI/Ar
         iGA2Kqek0dRvXbJ6brTsBW2k9HeNFmeBkNZII8ST/RwxCFoIK2fxDP71bxO6CibSliOL
         kuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881948; x=1794486748;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhW8bgTEwMPwLTiCb1KEBA42lBnDT9eGZiSGg8XBodg=;
        b=IuXtDKhBGh0AGCdstEbW+csEmgnSWWc6MFMhd33GuvufNzNy0qtddn1D1J4lkneBH1
         m7+pOU4N31/0EpDU9ZiMRaHj7tJaB5lAOF37pC8Zbqk0iEvWZSGKFrVxKVR25y/BC9I7
         BeAsu9Whv/aqSviaJr+J9s4mSuMeGEW1EhlQ9OaPsVYS3ffV2cYFJGaMREzn9/tUGoop
         5AyM2ynnqb2AAw/Mo/TzOEU7fzZPU3MaMC1BCGfbd7UP4pAQnp24kl7YW4ob80ZXxzPZ
         M4cADpv6TPE3Hidtm+3ETGZNeH5ywwnGdEZm1RabO9Npard1Q6lqJ2feGQhsejfskNhz
         BVeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR8CrWLCONgh42MU5PUlARfGFZdLXetrw9GjIOhTgyjtT1tCgE46YJUqPMCQceua3SHZcNe34=@vger.kernel.org
X-Gm-Message-State: APuU4Z9O2M+Qsn+qobY9cS8cxFYOGAqzWngmNJgC3V+HCtGY4X/7PWxd
	WIheZIIcxNaOuPwxodhe+95gr0HBbM+RAMG+KXIr/0zDrygMr4pwKOkskK8EjLP9gmllS3e7kgk
	pdOzGEc0cByonCV034srx4jigWXlU3Q78dFMXvzIyYe0QjhQnuSCgNaz6fA==
X-Gm-Gg: AYBFou2A2zw7XBwpJmVBhxqbTu0eOQ9NcRUzIJ8Hj6H+kVdA2nRW005W89lJYnTIP7z
	cELdSt0zcm45EbowDLXYrosI7OahPEfGRHqm2EIn8AHOSgEB90ee2IGKtDYU2d7DOpfab7Vt0mb
	VWz1Y0eVBjGPYrQORFDtoDT71ucyNA9tYWH3PbaH4pGuPLIdKmohMkWC9dgJJssqF8/7mq/kSLP
	dYgIbWRS30hTOUDnC+O7ursVVECFJmBxwrN/lNSp5CNaW1tLfOq4pFYoggd9Qxh4cMNyRR3D5uS
	z9cX2HBpdOSc0aaYV2tQLwbnjsRT9oHx1rQeKZyEmKptHf7pyWKPv3tFGYX+4060CjY1PZYKJ0u
	Kpm69GmnbpCJYgNbvixOXwx7OQJARmv06QU4z3jjWDdcSGEw28vTU+L/D0Qj0M8yjgJG5pcUd4U
	CHuIYM8Lq1PC5/WTyxMDjdpfR5Yb29Pp/PtAk4eAMQU8w=
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr427334025e9.32.1793881948074;
        Thu, 05 Nov 2026 04:32:28 -0800 (PST)
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr427333405e9.32.1793881947627;
        Thu, 05 Nov 2026 04:32:27 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e59d3sm69153765e9.10.2026.11.05.04.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 04:32:27 -0800 (PST)
Message-ID: <8e63cfcc-6120-4db5-ac2f-8214db2c1fe0@redhat.com>
Date: Thu, 5 Nov 2026 13:32:26 +0100
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
Subject: Re: [PATCH net v2] ppp: remove SC_MUST_COMP
To: Qingfang Deng <qingfang.deng@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Tristan Madani <tristan@talencesecurity.com>,
 Norbert Szetei <norbert@doyensec.com>, Andrew Morton <akpm@osdl.org>,
 Paul Mackerras <paulus@ozlabs.org>, Matt Domsch <Matt_Domsch@dell.com>,
 Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103015615.2704-1-qingfang.deng@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261103015615.2704-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 02:56, Qingfang Deng wrote:
> SC_MUST_COMP accidentally shares the same value with SC_DC_ERROR.
> PPPIOCGFLAGS combines configuration flags with transmit and receive
> state, so userspace cannot distinguish them, and a read-modify-write
> sequence can promote a decompression error into SC_MUST_COMP.
> 
> With SC_MUST_COMP set, intentional or not, a fatal decompression error
> (SC_DC_FERROR) causes the receive path to silently drop the failed
> packet before delivering it to userspace. pppd therefore cannot detect
> the error and reset the compressor's state. Subsequent incoming IP and
> CCP packets hit the same check and are also dropped, preventing normal
> recovery.
> 
> The flag entered Linux in 2005 with commit b3f9b92a6ec1 ("[PPP]: add PPP
> MPPE encryption module"). The original patch submission [1] said pppd
> would set it when CCP came up with MPPE enabled. That intended
> integration [2] appears never to have landed upstream.
> 
> Remove the broken and unused SC_MUST_COMP from SC_MASK and SC_FLAG_BITS,
> and remove its transmit and receive drop checks. Keep the uAPI macro and
> mark it as obsolete. PPPIOCSFLAGS will discard this bit while
> PPPIOCGFLAGS can still report it as SC_DC_ERROR.
> 
> [1] https://lore.kernel.org/netdev/20050814141046.GB20944@lists.us.dell.com/
> [2] https://lore.kernel.org/netdev/20050814190529.GA26802@lists.us.dell.com/
> Fixes: b3f9b92a6ec1 ("[PPP]: add PPP MPPE encryption module")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
Given the 'broken from beginning' status and the hopefully low impact, I'm
applying this to net-next.

/P

