Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489BB50AC16
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852840; cv=none; b=ieZ6CutBOombBn67k9E0g64V0ltXt5UOC2RTk74DXtr2DxEhTsSvNnwX7qO1MNLXa4dg1VpMgndkaA3ql87Wr7+PP7uXRdMwen70qAOWi1B7c2YFByK1fuEKrResvQvguLqQQs9swpB4XpjKm6D2vTcg+WDcjYn9caAfKcxFPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852840; c=relaxed/simple;
	bh=eMsFAw52GsaIwv3mYwo6NM8p3v/Lw/GqgKOt6RvjOys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4hM2GS6e6zDjMUc5fJTGFOE85m1WCEblCE1AVDih7nQ4DiNC789PACYHhBEL7btHe6i5Qhl9ezo2zLiu6bY4AeW5HruMjsmJ+NAtoilcuQl99sWbrNDMBJpQsHsgj2PNNdwv1IiZ0J5hjJTXL4cktAubGz3UY8LPXZ1f4MO+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EavdcSNs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzUvgG1F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EavdcSNs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzUvgG1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790852837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SytabqJa4hnrYd8Ld5SFCWh0bYNMUzuXf4Di1RMQPxs=;
	b=EavdcSNsX+ItPWOS7GogZhIR+jafeTjKr4ZQQRrQDeHPBsbKBTKDOITYWnp2nTRWOC5bSb
	zkekXpxziHtmKqAe705wij8KOHtnRO0ee9YxUWw5sni9R1Mq4soOtmvc4hSBaXeMVDwZde
	B8oP7Iy+vuB2fE14uNwv+2MDMWkFd2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-CKW7xiXNMiWOMhBc0m7gsA-1; Thu, 01 Oct 2026 07:07:11 -0400
X-MC-Unique: CKW7xiXNMiWOMhBc0m7gsA-1
X-Mimecast-MFC-AGG-ID: CKW7xiXNMiWOMhBc0m7gsA_1790852830
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e635a6002so72260495e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790852830; x=1791457630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SytabqJa4hnrYd8Ld5SFCWh0bYNMUzuXf4Di1RMQPxs=;
        b=TzUvgG1F6rulM9oNBMIl1JYH/iLAmzxvqpQnUznZbexaU7ikKUGN7CgRKBgowAYbkn
         46tMjcSw4jZu+I+wQUAwgL3fuSMcqzdJlZr5SOMuHXoDEOY7d05Oettcqw3j3meQusVw
         y/wQaTgeIKqLqW3gzGWHHeuHXSHZHRt9iHS/k2kNsom/RmTNSWYOuXExobP1m6zH51/x
         KaLOcONh8qPlLtmpLDr3Iqk+0Wx9G4WM6Qg2Ezlwd+hYk3vNaL7zbgN3HWz65uEgDxc5
         EHEGiSlSurXLaEw8zDKMvtsLPNw229UXMGBCjUkCBnTN+oCBXHlyx5pzN3VN5woTKyJw
         ctEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852830; x=1791457630;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SytabqJa4hnrYd8Ld5SFCWh0bYNMUzuXf4Di1RMQPxs=;
        b=Qzir4RO+tcEPCxp8M1XbzW+CsqR1keNvP7ifFGUXZUo6Hljp+USUOWGStjhKWEYkCQ
         3GRxSi+cKLSzIAOUNAcghDKJEdJe07kbldOA94jTjnOZa5jsTATJsQ443Qu5pE1WqgrE
         IWevQ+LTQsLRVuUQ+FrNU8SiJ5yXINoPXWzKveWRh9CxZSy4vBIlIPFrNSWWkf17BBk0
         SSinFsdo02GdCkf5yL3byc2VXten03MThvdK95NCgwCAECkS59KURrz4oIAoZvLnHESM
         dkS5hd/5veVbBCGd9zgDXjUwYTEXWXcZqiQg2NtUxT7r521558aMEdHwZwxuJcTM9z3c
         pxkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMztfL9smbc770yFGFXecVfbdRSYDRK2YaDMiRNyuchZy0dUWw+dVJ2P7PmrkKhymHKZ75nDM=@vger.kernel.org
X-Gm-Message-State: AFuF++kysoLzm1lGynz8yIh5f3v9Vub3O619jaN1E+fxc3alQ4/nS3e5
	BMZp/BeTW1vpQlFSWSIp+iDCpAC0wrpNdLKzkdUShJFUvydxMXibsqkHcesz3jRm7aL2wUvsi3A
	igKIlDVbVYGMhMZG0fh1xRnw31ZGesO7qqvLd/bI7ttNHjJdWQAfT6Hgx9w==
X-Gm-Gg: AYBFou0Vu9khoVuVAbtEZ5haJHOEREWrje13JloCyD7rOJaxuJrMDifWBBy00neKuOj
	gf0m8B/ajbO3cet+yxB2cOw9kIYRE70v2Nf/DE46CTsFgAt8z4xtZ0guIuHbyY+1BdRgRLglaa/
	lRffD5PitiBtFhcEvC94MOmd06MKEE0sOhQZnfP4AKnBgUKHfmIP2EfuaX031dVMoWnaQLqQ0NY
	TNrcO4hKJqbvkiveADL1rpU5ggVsFItknY81uiCjp4fbmeg9TEH8CwkCY5OY1f4hTq3R1M4aAAs
	lWzg5VbAmq/mT8RWSXx2GivZyx85521Ylu24i1Dmh90Khp4n+yFQM7yNWvbiF/I7KUpQFKihYPD
	Hs6nxiBSSaVs5skrFIQy/SvTQPqb/2yOySm1veQq0IDsQFYyA2jvLAjh8dQsiqRZIJo640bHU7A
	==
X-Received: by 2002:a05:600c:1d0d:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-4a01b112cbemr68461475e9.23.1790852830009;
        Thu, 01 Oct 2026 04:07:10 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-4a01b112cbemr68461035e9.23.1790852829579;
        Thu, 01 Oct 2026 04:07:09 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99a332sm112071055e9.12.2026.10.01.04.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 04:07:09 -0700 (PDT)
Message-ID: <21ba1323-7619-4721-bd1f-9ccbae42761e@redhat.com>
Date: Thu, 1 Oct 2026 13:07:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amt: pull the AMT header behind the transport header
 in amt_parse_type()
To: Omar Ramadan <omar@blockcast.net>, netdev-bot+sinfo@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928181557.85796-1-omar@blockcast.net>
 <179061960357.31693.937915571809434718@kernel.org>
 <20260930222733.47563-1-omar@blockcast.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260930222733.47563-1-omar@blockcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 00:27, Omar Ramadan wrote:
> Found by code inspection: an LLM-assisted review of drivers/net/amt.c
> while I was working on an IPv6 outer transport for amt, whose ICMPv6
> errors would go through amt_err_lookup() the same way.
> 
> It has not been triggered. I have no reproducer; it comes from reading
> the code. It needs an ICMP error reaching a gateway's encapsulation
> socket that quotes only the IP and UDP headers of a Request, so that
> amt_parse_type() reads the AMT header past the data it pulled.
> 
> Testing: W=1 build with CONFIG_IPV6=y and =n, and
> tools/testing/selftests/net/amt.sh passes with the patch applied, but
> no test injects such an ICMP error, so nothing exercises the changed
> path.

Due to all the above, plus 'broken since the beginning' and Linus
asking only for critical fixes at this point of the cycle, I'm diverting
this one to net-next.

/P

