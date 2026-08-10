Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992963B2D06
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355645; cv=none; b=a7Z1PELcuZJm7IGPTWZa8zEvv7wEKQPuMr+bF4rnPmF43PoT2iGBhJyWfYgUWyVUtuG16XTligU3Gdeh9cNdJKsRJcjpC6M0TopYM3l7k+ViggbHxt93yBRK1l9ehzdWLQVNrQgwi5H3kcSgyPSedllTPdzRjNTsLneUA7fEJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355645; c=relaxed/simple;
	bh=Mb4lvJxt8iKQt1y/jBs2g60GBPvMmVnC/pCTUP5gl4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rupAa6KCgEMmoXV6i1RsFhsnM8kqvhDUK1EfklKuYr53baqq0p+6LnXLOabRozl4RP18MsNDO5yJY3j30mRfzBHtyWtlbZjuxs0Qtnys8HmY3VynbPxczPbaD5mvTsTxySyJFBM1Irm+RBgvBS4IsmYEvWp3PKaf77ihT9aqY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6DpxqXe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jnr68vu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6DpxqXe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jnr68vu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786355642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJJrhudqMOZrjDcA0TeIkS5YE0ogalmKFNSGe7iwfdE=;
	b=P6DpxqXevK+SOqijSFJEGg+xXFPR6E+HQ6aHXmF+5VnGvvQJFN9C8WDERbGLXDuCc+AEGW
	sn7NrMFV72ttjwhZf1PPQ9IA0VqPKQ1KNRlluEbPLjMmwu7TZ8MPr8inFCd3oVZ6EMwXcA
	dDFttYkHWoNE0j/pCeMuAusDE5500CM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-UTd4k9RrNFGinY75Cy3E2g-1; Mon, 10 Aug 2026 05:54:01 -0400
X-MC-Unique: UTd4k9RrNFGinY75Cy3E2g-1
X-Mimecast-MFC-AGG-ID: UTd4k9RrNFGinY75Cy3E2g_1786355640
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954b1c6310so12965195e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786355640; x=1786960440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJJrhudqMOZrjDcA0TeIkS5YE0ogalmKFNSGe7iwfdE=;
        b=jnr68vu6JRqs0uxnCohdHg8azgbOokTzG7c9GSOA/2p2BEtjtPYS2AVc0jrWraMNDB
         dJaC57rp8cO2vcq5Gnha1Hsu+SR3nyMEP5tkRqxl694Lm4D2HLnGTuH0Q2iEZZEPTrB4
         RClba+cM9ABpjNXy5/M/WHKmUf2undfc/tStfE1aU/M952UQCS4HWPtXZJO+riqG+b9b
         2CGy+PfiLX/zqk2G5CIuOtYi21h9Jt6uyZlyIZwBsPO8a68ibYQnYUUhjK3Yh17ejdSN
         Ghh8EUUIvaVQH8D6yezsat20Jk0T4GzpEZxrS2jCSRuWcOAvqFf5zFWiD4NtWJFj0FBk
         qELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786355640; x=1786960440;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJJrhudqMOZrjDcA0TeIkS5YE0ogalmKFNSGe7iwfdE=;
        b=i3ZKqDc7RZ92ZAzCB3vtg+guMjHAuRun+PQ4CqQ4SNLtiNrVnp1nxGEI/F5J4gFGLD
         iGFNEZxIfzvUnvhHttBx1mvejxlI1r20XZpY8alM2/XUQ84CBmc3W9vpGB4Xs2XrFuJ8
         Bza/yQchPCLvWjUKkL1wF2CtaBWlWIgYXCCJZCkiXP/+ihBGFH6b/ivCMHwsfSaPDpzu
         iUdY1+I1liUcRNq07b9tzOuOVWLdytkNvKsS+zpCA+gsdEkPv/WoDM5TwgH5TEoOMgHc
         aMFijGIHVxeAm37kn5FSeD/kkO8AK8gHHJIRIlWBjpPLHJ0fT1MC64HGMHCgN1AHOXTi
         +e5w==
X-Gm-Message-State: AOJu0Yz9MNk5Lt02GNzfLvj6SrL8N7hofqys+zYzCLnpOE1mKP221VeI
	3RyWE9XA4q23ZjsiIvcVnkHdh4le2bMr/r3Iw/bjmQLB+4vUKKBHKkW1sS7KOlRKttRQOLCipoQ
	CiZef2BiBJm12SaJBIIkq3TqI29mxAbB3IabdG+Jz/YMwLb5JguvqNnigqg==
X-Gm-Gg: AR+sD10xQ3ZhrS3aM9QIWOzyu57q7j4P78ox8PIEVaQ0fBVxvMzIdIU/QGOjvMERxQD
	Fga73NCCtdCjv/0LECkGUDGRsp9bYqvr3y3Wa+VXBV1ggO1By7bGMy2cCpdZNSkPJZbJBGUSRcY
	631mnYyKZuAqlQcXONc3FzxaMENmZjjCZmj71zGlGjyF4zIqPtA9bQMy35YQXLYi/LAJuLc4SYd
	ytrkE08pxmrCh50WoUAMAfEJX1ZeMiV3c8Ur4Lc2iOJ2+kucxW+c76djne1sZ2mTKw+tkElkzJt
	T1LqzLVjVRcu6JoOdyfxvjnG9a4+pswBKdm7/I6+3eYm+R4wquTRUc2tD8gnG2/afQ8sIzVfQTO
	DkgYCk5nvSXG9eTCgZFj5yk+ZlwL07r6BjYpEeTz6yi2u3HwlIEYXpr4frb16TVzkJ/W9Ve85sE
	c=
X-Received: by 2002:a05:600c:530d:b0:495:52db:7e8 with SMTP id 5b1f17b1804b1-499727fd550mr7974365e9.19.1786355640066;
        Mon, 10 Aug 2026 02:54:00 -0700 (PDT)
X-Received: by 2002:a05:600c:530d:b0:495:52db:7e8 with SMTP id 5b1f17b1804b1-499727fd550mr7973505e9.19.1786355639597;
        Mon, 10 Aug 2026 02:53:59 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c777sm295239355e9.2.2026.08.10.02.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 02:53:58 -0700 (PDT)
Message-ID: <9f7f0fa7-52e9-4640-9264-13c98ed4d602@redhat.com>
Date: Mon, 10 Aug 2026 11:53:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/7] mptcp: out-of-order queue pruning
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 3:49 PM, Matthieu Baerts (NGI0) wrote:
> Under memory pressure, a pruning of the MPTCP-level OoO queue might be
> required as last resort, to avoid too long recoveries, or even stalls.
> Geliang and Gang managed to reproduce this behaviour, and Paolo
> improved the situation thanks to the following patches:
> 
> - Patches 1-3: improve the MPTCP-level retransmission schema to make
>   recoveries from memory pressure/after MPTCP-level drop significantly
>   faster.
> 
> - Patches 4-5: make the admission check way stricter for incoming
>   packets exceeding the memory limits, with some exceptions for fallback
>   sockets.
> 
> - Patches 6-7: implement OoO queue pruning for MPTCP.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Sashiko has a few comments on this series, but IMHO only patches 2 and 7
really need some adjustment, and changes there (fix the stale/retrans
race, wrong unlikely, and too early OoO prune) should be handled as
follow-ups.

/P


