Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9371EB5CE
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788393682; cv=none; b=J/qGC3VR9JxecS/vADnEmRrK7HGcTEYO3jsBcszMqRis1h24Jlns19wIjgzxXyV+iJ72RRhFdfwASqazOC5e/k8iJhj2jat75Ibzdk72ePrx/RYtN5Y16xkpMjaS6p5E2jvqBi6ktY8UKsDedlSsB2L91P8mf5JyfcjVPwbL7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788393682; c=relaxed/simple;
	bh=/ug1Z2+I/7/9KkF0qxyodAnWWFqdK3oh857MdPbdGF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/tB25Gm38Uwo1g28r4T6c2wYyTmEJHvtfuC7MqG6+bennLWva4++D56F02LQThRG01/sWi4YpLTvMhjnS4lW7G+UTbxMZt9SfEJGYFaInc81fJfDHVdi8PneZB+0E4gvg5MIGoRqRPVam8UWd7GD6Ua/BzghZDTOthu0E+0KAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExG1IEvw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExG1IEvw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso4554855e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788393679; x=1788998479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a+rMgzxIZCYE3X97ZXCU5Wap0gn6wnGpiJQ6Mt5cqyg=;
        b=ExG1IEvwz1/NfGx0A1DKm3xiibNAncJBxjV/szzEurRpLpl0MQeMmFhIevRU7snQL+
         qU3r/R+rxHv1oBa1YH2vYoCA+LnJPI8S1cqy83uxLkDeb9ui1gWeUOE776A3KxuvGO3a
         UWeq2CjgXISye9Ock6U0DBHbRjVlliBFWGgzXAt11MxhCu3jCIDdok2Qe4I6md31LqSi
         qPgAYhWZ+pbZ+G2k6macTL2PIxpYHx135ljzgerT00yspZK4r+PZ+2f8+1gRKz+CSKK+
         qGX/9tpkoSWCwCeRmMQl9YTKywJyBTRZ8ovm/klnQ7qEtW6Mh+LKN2UCBFEQUI8vKoSd
         hiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788393679; x=1788998479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+rMgzxIZCYE3X97ZXCU5Wap0gn6wnGpiJQ6Mt5cqyg=;
        b=Fgs8y1PTEnU13SYG2V01gG1VbA/guurTuHyYAu5f2Q3+NofQeafEAfp/Wg1ehFtt2G
         +tcbxrx1/hfgbvvSJjtIF5s0Bo8QaY5BOGGKdWGzBwLTSYeVb+7M1MnLIcp9+bEVa57m
         Vq+hyvchEQN+NaM6G3OdvAlUE1GJNc/Z3n6/hnCnbLqb90g85MOkJ0M37UrmQ66pnh4d
         WDPwFupQSRZMcfuBSE1Wity4g1KfLmLzfabKIb6XpILN2mlG90MsEY24eNTZ2LcpiOxu
         Fx0AaWGXEBSu8s0v0BFw3e6sZZO/2l6cIFLlRBmTy35RU2zcdfkhzX7Wwz/v6lQoiJcu
         9DKQ==
X-Forwarded-Encrypted: i=1; AKwUvByosXgDV0vZpOW2fTNCUSjg1HovYMW4GJnksfz4RfVgXlLDtFqd9tDU0GgeQt5Q8DoX0uJzAxc=@vger.kernel.org
X-Gm-Message-State: AFuF++naOaSF9eB571c+8j+CV+O3g3y7t1a8RXC+ixePoXa8xjd0Grfs
	4GFEybxPxyZbrYGlFNaTNsMEfstGxJIsR9QY20gWE8TnvBprNkITCkde
X-Gm-Gg: AYBFou2pMzFh4tbXLbElq7wAuUXbFRykINdi/07znZl63jNY92VaJzzk7zGA1FBFxyY
	TqKdlHyJ9+UBWdSTUEXiFNJA9T2yOTkE9F+9wE1RtaGWsOluUG+o9VJM7w1L8wi/xV/pxBZqghu
	xmDWI/9asOu5TlXyjL4h1NFZl9FGkzXGfGUBMaiopzpuIfcRj0t60KP1CzNeoOX7XJW9SW72p7t
	wOp3KTmEthDFN/01gPOh8SK4wEIBE8+eh+NgNh9bYlggZXNY5mMZ0rj9pHUPYMeP9YyN2XzqByZ
	wAloxlnwYp6PF07CzViEbNDSUHrt51rVuWKHy3ZnXW2cm+pWtoGVxk0J1f5NdE2C/C9i00IK+4k
	xbUozpqb5RiEQLXWspNkSLKz7CgN7FLTrDfEvqCKuLT1LAQrqPkXhz+ocfzm4DHTG8V5HrCXger
	g4GLYXyz3Y3rAkJSZAfYy8u1ksn9eFDkwsD+4X7R6BIB0OdROWyNS4TKEwBoq3+ppfKmo2sOCsZ
	JjjFaFFlONI+1Qd6MfwujtbsE9msL5koNWv6n49XeusbL8Ii0+r8qjeMBbp6Om7UHnC1GlML9p2
	HdqulLN+oCsGGi9ijofHjqrSH32JicRHtEXlve107tS5Nc38tWM/KizcnNVZuY4hkKe4gYNWndH
	Zf8/F
X-Received: by 2002:a05:600c:ac8:b0:49c:f13d:ffef with SMTP id 5b1f17b1804b1-49cf13e05ffmr2151795e9.19.1788393679115;
        Wed, 02 Sep 2026 17:01:19 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a1c2-c401-11b2-c123-0d12-6c0f.310.pool.telefonica.de. [2a02:3100:a1c2:c401:11b2:c123:d12:6c0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce5e5sm9115290f8f.36.2026.09.02.17.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 17:01:18 -0700 (PDT)
Date: Thu, 3 Sep 2026 02:01:16 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mukul Sikka <mukul.sikka@broadcom.com>, Keerthana K <keerthana.kalyanasundaram@broadcom.com>, 
	Stefano Brivio <sbrivio@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, Bin Lan <lanbincn@139.com>, XiaoHua Wang <561399680@139.com>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 6.6.y] netfilter: nft_set_pipapo: restore cloned
 mapping table memcg accounting
Message-ID: <api29LfuC8U_RRUw@gmail.com>
References: <20260831194905.45045-1-kmehltretter@gmail.com>
 <20260902-daily-reply-0014-pipapo-fixes-tag-ack@kernel.org>
 <apitu8BYUvG-WJt2@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apitu8BYUvG-WJt2@chamomile>

On Thu, Sep 03, 2026 at 01:14:03AM +0100, Pablo Neira Ayuso wrote:
> On Wed, Sep 02, 2026 at 06:14:13PM -0400, Sasha Levin wrote:
> > 
> > Whatever Pablo prefers :)
> 
> I am fine either way. I just got confused with the double Fixes: tag
> that point to the -stable tree commit hash (if I understood correctly
> after Karl's explaination).

Thanks, I'll leave this submission as is.

If there's a similar fix in the future, I will probably split it to make it
more clear.

Karl
