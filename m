Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE53ED3BB
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994156; cv=none; b=vARFuL9VFGA6xYvwJcGThPQLrNI1qV0w2YrYZ7clmANe65rEQEYdBQPTVgZQVv7A3EAmrHWXCnoLeutReYXkNzL1PGKo79Bu4EW+n7+MwQ1hXoMCRG2Vht4XMDJyFdASkBf8F/C553zketFA1KFlv7KgYIyqapwulsHPNDZEFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994156; c=relaxed/simple;
	bh=PQhXqbThYaCcvgyVAYWtxuT4iHZQ0fjUJg+4XO9ZPqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJf5PlMDOUyib3Q5a9poPEVxNMruxhOon2TX8blIc/oCotmvxQzbuL3CH4zMFhtXbWOEdiKrP0fI9gyX/BX8S6yH690PVD9/lJaRP3kBRc3VyWqjaxHQChIqL517PmJQyDNb/ZXGQliKLHTHidnJZNVKeszRLPGFf4SBwV8ShfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ehv3hbTe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsFOiYpT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ehv3hbTe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsFOiYpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780994154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNsjYumJ2mhHeLOkMhHR78BUZYJvPELNbDsn2J4vT5s=;
	b=Ehv3hbTe7/TaufRoNAdTZhEdcLoLLw2lTcTTELGhwtLJVVEX/1+x6AQy8xtmgAKJtzF8yK
	u1ng3X8rmURTq1I+BDyjjpPg2dGpUmZBGx2m7yuO90uW3tEFS8y+5VOGLjFawpGzh5V5Qz
	AMaBExeGgclE7VnOEeFICeYDB3VEJ8E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-Qkh9SspRMhOupiJ8s_5VLg-1; Tue, 09 Jun 2026 04:35:53 -0400
X-MC-Unique: Qkh9SspRMhOupiJ8s_5VLg-1
X-Mimecast-MFC-AGG-ID: Qkh9SspRMhOupiJ8s_5VLg_1780994152
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so43737245e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780994152; x=1781598952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNsjYumJ2mhHeLOkMhHR78BUZYJvPELNbDsn2J4vT5s=;
        b=GsFOiYpTBMkaeIw/phfDqHb18qjXcRMOWmfW0PmeM3DHt/qrtZQHQnZ2u8YkAJilQS
         +xaypaFtjJ1YDmr0f8SRiGbCxKDbJP42tk6FEobKUczwCyCsSg+X3tlSnkpGKoc3SZoC
         y49iBO7JAkAcPg/DS9TSGn93rf1Z0RSbUyHS8v7O64TvHVv1oGpAFpd3CHVYexNFKgdm
         TpLwhETCnJi6IQqWev/PgRqj/n1IaNdsi1gR2IfB0/joQeCwuRYU5po6idlpA1WoFhI4
         hIausgKoMVzAwUfE3Wfr6RxNbC7UVII3S8wtlG0iBVHJm4DCxLqbrInWfyuVp2/RwDPZ
         /zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994152; x=1781598952;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNsjYumJ2mhHeLOkMhHR78BUZYJvPELNbDsn2J4vT5s=;
        b=NiTGVVD+qf7E/PHy/MnWD0LFKcdAqWaL3XTzeIu8J4pHU9iYmolX0HCU28k7Cle1Wl
         BS3Ac4ZHEHRan7VLsYKTqyOW9T7cdzyGcvULBVNSuJ884Z8A0RQ4a42A+8xQ3QUzHx+D
         Os1bHkGrwWTEKoUYUVK+pc403Jm2X4f9XIdC1egG9f9+6o93kjeyLQEu9PsX77mbAlCe
         DVFyh6iIco1RIZHzadGNuI3tTNLs8zEAAJbNYj373pqMqM5HaEQVmBQ/anuQ3JWfWdRk
         HcB3+Dj6ABf0n7y0txgEyyeN1P9MplLZC2U0zCaojAbsJym6ua9V9sja1Icd+7BEQxgF
         eOAQ==
X-Forwarded-Encrypted: i=1; AFNElJ80g8JvI/TISpNsmHtUoz66KuautuHINzSAxY3ThFVv468eYF24sizRBlic2ebFinlh0xKcb0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4yOVgM/anuwaMaqGGiC4mitjCFjCejMmTDNocVGARr0Q0KF1
	BeP2NRQRteHvmrzZbIFpqKsio1hnFHyxNHSK+eg1/cmkLm0Ve8s5bBgAM1hbpYhCHB/BMGrYcQ4
	qqgbQxvGJGw0E4WlNvigkFSisB+vkAo/olW3ORZuTxe4Mw1ySUI6nybUWTw==
X-Gm-Gg: Acq92OEi7dluAIwO4PiLO0yu1UWn/LAyCMdL+tKazRcEDlF9VHqfzA3YKN0tsAueuDW
	InVKt9ROHwFxTjEs8Y6a2IrSNf6aMPJn67eDz4ZUu7PKs/PoJ+Oc5DXcts6mpooh20XPzx3vo7U
	8f5Qu/6MRFQngEpMLakqPaJuRWtEUJQG0oWxmHPhwcPQdWIWNWhQF5chxoKJc2JTB0laxKMWDVE
	4gmBcBCNs8TWHZkl4KXzUkIpgFadnOd2gnEUdS+rDlENwiCe2i2yvCKnKvB14EtMUv9qQys9UIP
	6jrK24ot9C/Z3KtQHQLdTjAGTUTRKfXvvYVBqLSLhDfCkBDTjwuVnhy0tdubcsX8/mSvI+sxYpt
	APJRZPwpPAW77IT0SzPve23xLJ4yqa9KfFrXFLJh4PI7nHwRzT7Lvhf/8oQSKP2Mqvg==
X-Received: by 2002:a05:600c:821a:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490d71fa976mr18013605e9.10.1780994152076;
        Tue, 09 Jun 2026 01:35:52 -0700 (PDT)
X-Received: by 2002:a05:600c:821a:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490d71fa976mr18012945e9.10.1780994151578;
        Tue, 09 Jun 2026 01:35:51 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm64449443f8f.36.2026.06.09.01.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 01:35:50 -0700 (PDT)
Message-ID: <f0275464-0120-4ce5-9a57-dc81dacc494e@redhat.com>
Date: Tue, 9 Jun 2026 10:35:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/11] net: Use helpers to get/set UDP len
 tree-wide
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
 <20260602093931.516281-4-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260602093931.516281-4-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 11:39 AM, Alice Mikityanska wrote:
> @@ -915,12 +914,12 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
>  int udp_gro_complete(struct sk_buff *skb, int nhoff,
>  		     udp_lookup_t lookup)
>  {
> -	__be16 newlen = htons(skb->len - nhoff);
> +	unsigned int newlen = skb->len - nhoff;
>  	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);

Very minor nit, only in case a new revision is needed, please fix the
ovariable declaration order above.

/P

