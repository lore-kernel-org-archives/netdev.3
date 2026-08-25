Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497347AF57
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664133; cv=none; b=qXm0+wCRADkBj0s6k3G9+OWfOISAbv5BDL9YVLah2MUvOouyqjh9c+RsI/bwBPu25adTj+u4fLXHy3rNkdmLVCpvR7x+1smlpRZQRaBu0iZi2ix0f6enMlaMqAp8w+O9j6PLOySuCLdZYvW+lMfIDJH+390RfM09j89mNRvK6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664133; c=relaxed/simple;
	bh=l2bquGZr7xVC6kTuwhk9wLmiEjDAoqczWlzAZCpRkng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFbxw9SjCGfqLyGSueEKRHdW34o2OrkGSkJPye8mE9BhhNBVdZved8hQb231IuMxF3wtafcLaCYu1VEsmzicoUwv774YTbOrofG5mWSA+ewvvw7Qgmg/MX9NFCaXUGgsJMV/bHfYxh//q6XR5sq7CqjhgtkjQLj9wdqVYjklIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfwEfBI5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FddhOQiQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfwEfBI5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FddhOQiQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787664123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3loZNgkjJdhRVsMoqc8GJfdnErwerujYkPb9VXz+wQ=;
	b=GfwEfBI5lBdwNeCz22yaMaq77101FDu+Tpsl9NjxkumGr7iTl21Sab/ZVA8B3e1kx0Aq8b
	l55ggO5B/wcdi+PMS4sRXX5SDRi28ZOuubYadt5Ec2LtJCqHGQsXi98K1I/v4My70YDTf5
	tG1+1HwYQj7YJH7MUxWQDCgNG21hg7I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-hvAXRlTzPdigc1Jr1pZ9SA-1; Tue, 25 Aug 2026 09:22:02 -0400
X-MC-Unique: hvAXRlTzPdigc1Jr1pZ9SA-1
X-Mimecast-MFC-AGG-ID: hvAXRlTzPdigc1Jr1pZ9SA_1787664121
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c213d5fb55aso214185666b.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787664121; x=1788268921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3loZNgkjJdhRVsMoqc8GJfdnErwerujYkPb9VXz+wQ=;
        b=FddhOQiQWPD1qm5uSAdSQx45yEEGW4LLHzarw/f4Bo92aX9SkjX17P0w+IxHP8V8bB
         twlB+TgY+p3+zfyZg0J/gnubI5+9vqBtsxX4RW5KxTxqt/BaqcUbFEDewEp/eN/Hk3L2
         lppJbIB2jtyZkKGAa0iyCvKaTg89l9Z2e104TP59eRvLVsPLsbeDwIHsGgc4d7AlPnPP
         v6iWrCRJuWsYyerAnifduZDr2FwsN33l3lGlbux9d3I8UAaRLduXKYWO+vi1M0U9B6tc
         fh+bJc6ALzVx/hOeOp+aQbsZwC2N8CoSLTyKcOHOLI+iO0kMG9sf0MYFDGahN1qXRW06
         LcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787664121; x=1788268921;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3loZNgkjJdhRVsMoqc8GJfdnErwerujYkPb9VXz+wQ=;
        b=qIj/EDXBW2HI1KNDPac8XAxL0/J+JYeqI+GhIGkinJicaSlShK+KA0r5LwgykfAfl6
         KpzgV93E7VDZ2KMCASemcbzZWeKgxiTzqCDhdMwUJ6VV3h8p61QCmXycHS7P2NUIWSAT
         F38Y7g65e1J2PQMCvl40U4JIzzlR5xP/Dn0/qMky4grfQ8ak99TcXmb6gpyZKhPYina1
         9Sy3E2YfuN9VWlhKQuUYSSMTvgytzWz7q+Gv03cT3Nf44IzNQpQM9TI6WBdc3ytG5kct
         WKd0ZmM7Lfl+oU8nuEbINYXIuKSEhQTfN5v06Sq0W4N+I/IrbO6JjqyXPSPy7Qqz3JQy
         UkhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqPO9iz/41lerHv980cjCdOHhgEaa9Xx2q42emWF9D2AbHIwovazLbB0xpCIpFAlZSNs+LTgM=@vger.kernel.org
X-Gm-Message-State: AFuF++ldwpOEo9Q3B8O9qDrGftOfoG5lMdRKImhk68HggLpfK5WtVyLc
	SvBEoMd8mdmxV2TL7j805xbzBZOOsgCtjqHNNHe6hWdaEafPYKsL6kxdt1Z5lrpg2OFj/ClQKpQ
	3DUMvc0PpXciH4SO9o7h9/wnha2NyY4gyDB0FfTFaSj3XHR3xBCOmY3dOMw==
X-Gm-Gg: AR+sD13rUvC6qALs8/e955x/qlGZljXrciQBDITEdTB9LDCWyPi7HWyYSfORiJzf9aZ
	KwugYIxOXdWrzF3oHaTj0BMN/rJRvBmX0xhLECKH2m2HrLMt9rVBdSteDWCe0e5wvVR71grGA6t
	xpFVk+Jmk1c2PZ0GmkXqsbmscbBT1AaBDW7AWkKcjDKVBYNI82tZk1MD3rosgz/k0uhkXexUPmC
	Q+hayg28g8wsHQ06mjsoiSTCbMWphHuI+pEvnmJRXWKeiI9nRja9JJgeVHlLxqBfzLKF8s4HVIL
	5ht6udmd3V17ek3zw9JfAEiuBulj1qguG3UNnrn9qR3l99455YLoECHXklWVDWBoRS8dwFZBu0h
	eoH3pQkopyUlKMfe+/A0SNh121Ljnk3PvssRb7YmEbg4k84fSjou5MhTMA+2mWZY021H4BYgD
X-Received: by 2002:a17:907:d0c:b0:c20:d90b:2cb1 with SMTP id a640c23a62f3a-c249188eadbmr3012057466b.0.1787664120708;
        Tue, 25 Aug 2026 06:22:00 -0700 (PDT)
X-Received: by 2002:a17:907:d0c:b0:c20:d90b:2cb1 with SMTP id a640c23a62f3a-c249188eadbmr3012049466b.0.1787664120319;
        Tue, 25 Aug 2026 06:22:00 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685c573sm2279307666b.51.2026.08.25.06.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:21:59 -0700 (PDT)
Message-ID: <2fe7208a-7bc9-4004-907b-75f283360ec9@redhat.com>
Date: Tue, 25 Aug 2026 15:21:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/4] Improve stability of big_tcp_tunnels.sh
 selftest
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260822120308.1165200-1-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260822120308.1165200-1-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 2:03 PM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This series addresses flakiness of big_tcp_tunnels.sh discussed at:
> 
> https://lore.kernel.org/netdev/349c582c-73e3-468c-91cd-ad6cc3562700@app.fastmail.com/
> 
> Lower the thresholds to avoid failures like this (number of packets
> below the threshold):
> 
> https://netdev-ctrl.bots.linux.dev/logview.html?f=/logs/vmksft/net-dbg/results/754376/28-big-tcp-tunnels-sh/stdout
> 
> Tweak tcp_min_tso_segs and initcwnd to avoid failures like this (BIG TCP
> doesn't kick in in slow configurations):
> 
> https://netdev-ctrl.bots.linux.dev/logview.html?f=/logs/vmksft/net-dbg/results/751124/21-big-tcp-tunnels-sh/stdout
> 
> v2 changes: Use $KSFT_MACHINE_SLOW instead of probing kernel config.
> 
> v1: https://lore.kernel.org/netdev/20260814194124.3102581-1-alice.kernel@fastmail.im/
Any special reason for moving the target tree to 'net'? Selftests
stability improvements should go via the net-next tree (without the
fixes tag).

/P

