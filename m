Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13124279792
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757331; cv=none; b=GFzR1qUCHNxc+wuSKsJdjR9NPm5ifcRwMLzE3aQaVTvll+CU61mu7F99TtvYmdaLFQ9+BizYKaRydaBS1cUK5sNcFR0wNSQh/FwMUeyU/en4VjQgbDzXN83gUq6VoKRG6Pao0hp/R1dY3mGpqAOdiBGvREVk1SqBlw2r2zXnAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757331; c=relaxed/simple;
	bh=pJ/bggGJiY5BaVzUGnEIeCEju9b8/IsKonn/qUy4RYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ga6uEpOKXXXqKFHz10JESzZ5mUQnFT9UDH/1aBtjBcB87VRTtofdTxrAGTobBn9kux7x+7dEqa3h9pPSp5zlSBA3XAutOcFZQqieB2mbiC+OMU1mwltCQDO6f6qxTxASBtrM00vVQ30FUzpUM7eBKf2O81ij2uuutYMj2t9Va7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vkl4aJmK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkl4aJmK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495437bb891so16233505e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 04:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785757328; x=1786362128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJ/bggGJiY5BaVzUGnEIeCEju9b8/IsKonn/qUy4RYE=;
        b=Vkl4aJmKTf3CVNmniEfP80ju3DqlTNkzeFJVFucyno34M1zpHl+1iahE2GjhXRHC21
         iTzyqrcH0lXuuNV+rpMai9rrEcSCIOJMXbEdVI9lzcQJHAu/KgcmpADPb1KvdgcpIiQ6
         Yrt64PABheKUir7MrCpt4zSws5IsvYVvfoX9fTU+rlgoQTpdWsnuXz15aOhPDH2np9HB
         Oet06Ns6pHrUNEDWDKaUN6VhdLdgna7drYeJywtBj/BipUMzN+/HfdMm0+9eZqKbY10b
         GMhah8P9RtQ1BXk72gBZVAusHTUZbA89DjGOpUvxlq978lEm7mBYijmM8ePGqNHj6ViK
         Lnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785757328; x=1786362128;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJ/bggGJiY5BaVzUGnEIeCEju9b8/IsKonn/qUy4RYE=;
        b=BSNHy0DpUHEh8npdct+iT8p5mdQIEno8do0XHg7hYccFY6s3CqsLDDlCaCEPLGlijN
         dcOJj2/l0QE2rSzeQMtDsIlotvHvFhLT6+qHE3rx1ULspkN0gz0Tu1pCuUyDHBCKtQyc
         wjOXkf+pSp9x5IB+EvVk2irgjJxQw4BNk3Sh3ANmPekc0D5mGiKrosUJadBfHQKnZP47
         fbRgWdjIKwe3BPlZWorV03w4cJJBHgwNxw8DjpFEOjhet7147hOntyZqlEDwYPrcomW3
         X45kQsntBUP82N73ayYOiqb+Tdk9aUiIzI0hxCdA+vWdQo+7KlKqBGDXZHK6M7dX+5X5
         YQVA==
X-Forwarded-Encrypted: i=1; AHgh+RoYH5dKUU4WqEp0vA8y6rvvG1Utg1RuZ5XfwuA+18zkKAkzavHjShPB3tMQKr+VMfnP4INbjrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Y1Wm/ceb7OXdByhciLUXE6129wutNvZRpt7JMb+ObjQNkwFA
	hP2bYNTiAGcx8tzobEciDvOpa3/RH+8doJ4cn9t7k4q5GyleYdcVi6I+
X-Gm-Gg: AR+sD13Wu0ej/aXs+N4X/I4PuXh7y5t1ACckqL0nt/nToC7G5tDQ7wTBjqTCoFc4taw
	pppJJT1OHFCLibKStoLfHDbFt58MG7gFkt6ka8fGk8oUtoJWH2BoLV+B+sLM6zVERuW/b7JUE+F
	zzESeQjH3p6tj4ZfNeg/pTHuBpf3PTRXjalwqt07nJxU5oftWIBNwX8JFQtclbbOoDxKHxlJhLS
	0tCUoxsVqI6Vx16EIzbs0W0+4QFZPUPvVMyFUDnMeVKOtLOnL2muTqrz3Pd10/Y4DP36mOdQ9OI
	zRgRrJXa6LdRy1Uy0cZqsZiodceQh5isQ7n4vynABxkQde9bv8iY16oNyYQfbqnTZXW/7M4jyYx
	9l/LgaEpaROgO2tvl1c2ML/DRCyH3I1nxjG+0mepLmrAniGamAeTXLp3ea3pb59QldGSmlHMaRV
	4iyR80Ol0bkvKx1cPSrR//C9gdfsvF8F4fEint14YAurRM+4ew5GZv1V/rO03HQsy0NOIJ8Vwuk
	H3Qe/move+5sj/ipVNDULipmjNtqlHLdDPhGGD7P1CM/4NEuVZD5dA7nAfrnFzQGrnqxpm1cJBc
	ZSv3f6lkZzJBnUasQSan1DwwLXgSjIRSoGAdAQ3jcmhWoMgyjRGA1KY=
X-Received: by 2002:a05:600c:46c3:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-4980eb8d081mr162373185e9.1.1785757328036;
        Mon, 03 Aug 2026 04:42:08 -0700 (PDT)
Received: from [192.168.100.51] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980819a030sm234157695e9.6.2026.08.03.04.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 04:42:07 -0700 (PDT)
Message-ID: <02660c18-ed71-42ae-ba28-f8887d2d885b@gmail.com>
Date: Mon, 3 Aug 2026 13:42:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipvlan: keep lower device alive until private destruction
To: Jakub Kicinski <kuba@kernel.org>, syzbot <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, dskr99@gmail.com,
 kees@kernel.org, linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
References: <26b3176e-d9ed-4508-bde7-388deefd970d@mail.kernel.org>
 <20260730153247.2373cf7e@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <20260730153247.2373cf7e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, I'll rebase it onto net/main and repost it as [PATCH net v2].

On 7/31/2026 12:32 AM, Jakub Kicinski wrote:
> On Tue, 28 Jul 2026 08:40:37 +0000 (UTC) syzbot wrote:
>> Subject: [PATCH] ipvlan: keep lower device alive until private destruction
> please rebase on net/main, and repost with [PATCH net v2]
