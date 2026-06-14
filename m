Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EA34DCF3
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781436641; cv=none; b=orATDbGEdtskzHaN+N2q6DR3XGr2agv9TIRGE3wol4Yf6wUI4sls77/6yEV8h054rOI9/PlJH2JBGBBYYgSHW73p5R9d0+hcIFL4FcbkX24sC/0UzCKvudiED3m81DpmdFqRf4ZnU2JLPLUr9gF99VJ29AfiDlazLfqJ71C6qXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781436641; c=relaxed/simple;
	bh=BSMMNkk80Y2j2iA4qmCq+Z5bMBUGyNo2i3G//sXc1hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqOpVM+kXK1h444wWKRHM9qHQfxbGR42w17b4I8xjTRJOHsgX3FnBXMTkigMnPeyHZfJ5KW/bEkwIPkD9yhtui3DmEdK/jsF4ZoHSkd/fBEffSglyrN9+RhCp7llcyDzF36WYNYWq5bEfBnbZ8LQzhRXZdVTHPQT15Ky45S5mn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRDQI4RS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBIMQCbj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRDQI4RS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBIMQCbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781436638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mn9qXtPUeoWgSilSCUuR0/l8m+OiZ6LyUPY900AFYjk=;
	b=LRDQI4RSwQpCACYxSxt8olJLCYK4e9HY3FyBg+MzSAFM4kUH9HDt3ZFRO9N6iQzNyqJNBF
	/HlvljaUtDnIiHxqlQ2YE72tptFJASXkCzPeZn0w6JstDduzuNHNtvjI1yz3mIqNwiZhWa
	XDHJy0juYD446BMK0XPZAEb1GkyZGcE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-yYBSUxIYNii967GGU2Nl5Q-1; Sun, 14 Jun 2026 07:30:37 -0400
X-MC-Unique: yYBSUxIYNii967GGU2Nl5Q-1
X-Mimecast-MFC-AGG-ID: yYBSUxIYNii967GGU2Nl5Q_1781436636
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b79e6b94so20739735e9.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781436636; x=1782041436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mn9qXtPUeoWgSilSCUuR0/l8m+OiZ6LyUPY900AFYjk=;
        b=TBIMQCbj6RCVhExTYCjxGmRhM0JVM+4jyp4Pmd9lM01NlRqNq/eKYbsIyF+PbT91/0
         hDPjtDgMfQ+IBrNINmQljpjAB9u7xJ3y4o2vlLis37t3J3q+f9OCDwkY9HcIMpp+zYh0
         gkCW7Ls/CuU8UQ+mtzoS+Ka4nROJCt7otuaMh8s7Pcu05ukj0KCkoyARoNAnZattohG9
         +c7mX52ooUPgzafo3xtNv9q3C9BpSN+BnSQ/UsO2bq9PqNHUIrec80NW3Kpi6ljTCZg8
         ixLJ9LnlPhRrWHstGVmK0E217946BRCj8Zo215R3C9lFkV5UwiMwT54ntTvCdoBz0K0/
         ts5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781436636; x=1782041436;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mn9qXtPUeoWgSilSCUuR0/l8m+OiZ6LyUPY900AFYjk=;
        b=sgKiym0nsFDA7kdR5KY930ZNfKcI+6n1jlFrUcSvVryFYj6XvTNeuDIC7AXlAaE/cu
         6klCfECs5DsALW5osR1fpO6CHcCpNchBhOs3TkdosrFYIg7xgDXx0UqiRZkIy1ef8h9R
         ur2d7eCB0WvGPa/I5BuKp0x/QQB3j4tdD8nqfgJY5paHRpJV6nKJLLrCDiNfp183UvAf
         2xFTtCqsayN8I1vFSNDbOTmGHo+JqPaea0tf2JTK+qd9OMyiYzQTnGBVR0udVlvpx5h5
         4ZoS14AjIiN9ICzVCICWjZzGeoRWVEk6wallfNn0LEer24oKK3G1WmKLnRJdTdGScx/r
         WXaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+s3kBJONpMttelhitU49WQ7Jw/Vrx5tvevhWwCVNrMGiXBU1U4IkcQ4njaUGqTMe0GW0Ow/aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcME7PYKD61cEoawDEUOEyaAsQDnht0T8vHPa7oBj++xorllo
	DH/vCYaMRfiLIu5ZP6zdFDQtSpb8wULFTwKqyTuEkS6o4sFHpmxhMwz1dZ8fo+KQ+PIyIOwNyj6
	/M47zV5PrQqwCGa8nM844gWP/LgF2JJmzNZG3qvyra2NS/EXzJAOGUNQZig==
X-Gm-Gg: Acq92OE5Px1njXjQW50oKeixLCOwNq4ltf4FLCwmMEk+3uLPHR6wlXILe7lwxhC4gyB
	aMHWpj5cWyFZgEqTGFZ7beDP6wSi0kF0sXC61dp22gKwgmd+us3+tFeY2ajtlHIk4fTyG06QbQ9
	rCbMxqv7f9FB7qVAlrF+qHEB1n70dkC5N2deJWyqMc7nepOaPbrRNEGvJWRuCdUBzXKmBMVO/ao
	18IDqw4W56o/tDSWWRdOgcBxvb6e405p9F/LK0G5oOB2j2GPDnR1pXSzcsmFVTUKpYfTOMiT9Kg
	gCFoEr817aeYxHtOer6ldwSU8UnL3gPwEi88PnPPouNiTUCZu8neF2Gn+Q+DI/ZDF2vL4OXWv2K
	f63HIoUlw1zlzwK95G1mqtkX5ybFQMCmA27sqqfFdt1dTa+dwdGAbj8k=
X-Received: by 2002:a05:600c:c3cf:10b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490ec51f5femr88606375e9.32.1781436635813;
        Sun, 14 Jun 2026 04:30:35 -0700 (PDT)
X-Received: by 2002:a05:600c:c3cf:10b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490ec51f5femr88606095e9.32.1781436635391;
        Sun, 14 Jun 2026 04:30:35 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492201fad25sm163739065e9.0.2026.06.14.04.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 04:30:34 -0700 (PDT)
Message-ID: <45aa7689-9168-4825-9040-0ef68f4b8fcb@redhat.com>
Date: Sun, 14 Jun 2026 13:30:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 06/11] udp: Support gro_ipv4_max_size > 65536
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
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-7-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260611192955.604661-7-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/26 9:29 PM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Currently, gro_max_size and gro_ipv4_max_size can be set to values
> bigger than 65536, and GRO will happily aggregate UDP to the configured
> size (for example, with TCP traffic in VXLAN tunnels). 

Sashiko gemini says IPv4 will not be happy, suspecting iph_totlen() will
not work properly, but that is wrong, because skb_is_gso_tcp() will
still be true for the relevant GSO packets.

It would be nice to explicitly mentioning such fact here.

/P

