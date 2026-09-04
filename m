Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF43F660F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513038; cv=none; b=h4gNZ/sXEZAsMRbQpQfkHDxsbsGpk0rW1/orT/Ovmn4Oijp7ey2R9adNgQ2zMuQr6huuZYabMincC/Xkt11+xB+Ney30kMlogjV4V01GPkHx47x5QjaU4Fvozd6n/BiOcPrY5pSBkfeeUqHUmTULeIuizaHhHBC/xMHQmUy1CpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513038; c=relaxed/simple;
	bh=hMJnU327dFEX6opK/KQDKX48iTu/x/A0Ul7gIsQxjis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wbli/bEXLq8pHPjJTQehM6KjPhySAxwD1FhUyPKj+MS5z0x9BaqtpaJcfW9qy5KHqINhYdOSshQmEA2Mzz6++J6IvZJZ61YIQIdeWBWKVkZk+ggAqjdMZ9y9RP/tgJIhB4FCkheSnv/1VD5cEviTUrAlaUiNoflvU5EfHa8SO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPv3QNId; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mndY7mUX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPv3QNId";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mndY7mUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788513035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vt81cwcsCfPywy+zBr+7O4ImxWrnQ6O2o5d5GOC5dKs=;
	b=WPv3QNIdhxM/4tSKF7YiCBgNiPYppeJpWDVA7HNhKihPJFJ+W2occ2LHSsKvYTu2CZUjKw
	A+vWD+00FqZD2cr/dKuVmrKyDAfkn93vuClDf6xRDaUs4wL25yd00X5h7MYGwJ9BoKRK9y
	J0anFVAfUPyNcr/6D+gB6jGHTsYIBx4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-6cTiF4yCMtiuGd8-dMWBzg-1; Fri, 04 Sep 2026 05:10:32 -0400
X-MC-Unique: 6cTiF4yCMtiuGd8-dMWBzg-1
X-Mimecast-MFC-AGG-ID: 6cTiF4yCMtiuGd8-dMWBzg_1788513031
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-485835753caso644726f8f.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788513031; x=1789117831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vt81cwcsCfPywy+zBr+7O4ImxWrnQ6O2o5d5GOC5dKs=;
        b=mndY7mUX8RqvUZf55hguKs9ehzP4ixit5qIRcAFIEW0kx+fiLYEJkAEPgAJN1gFIea
         sNRNH7Ya3pd/BOYB08RkMbfwtjHhIIoH/qrwrg6m776dYmL18WPHHP0KTDvurpBWoCdQ
         gboVlv97EL5KcelXwWh/rcDhEi+uZK/4eJW+IdtWGre5Az+3j2giPyqZ6hC9fICO3TWb
         9Nm64h+k1qwG2Qp6l/WKBHHj22GaYDbg0mzRwtUwdLPdwMmy9oWlt6fSS0TTjhjEQDy4
         ZIiXaooF4T4NpCL6C0x01D4S76aPXU5JYGTuSDYxlwkwP4Du9SQBMJ/UhmXPAKTVSpQx
         IwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513031; x=1789117831;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vt81cwcsCfPywy+zBr+7O4ImxWrnQ6O2o5d5GOC5dKs=;
        b=FJB5uYzeBfWvAUE/pCTbMsl69hl7g1zh87M7kzeZ1i4X7ml2c6zsE2CXKK/1Cxqm40
         mwrCyhBfsV3sFuS5SnGgDWxaptNa35cR7vxeo3REUJx//jbfZlpaaLke8gA9cVWIS1UU
         ihQl1pJdOW7Z9dyePbMQ5VjokZPKaFJB4pLrKsIgYWEe4cUGvMIuZw0oyVmcXvbMINFD
         vuEjpMw46RMMa8o9VbDoCJQo5FGhL4p6lrSS+RGREQO2HSNUoAFLTvWlaugxEU8RqDUg
         qtYaCCzfZsayyNtYMRHCbRMg6LqzSrNLWsM473L3yCpKb/BA12Tav1temPLo9vhX74gn
         qhiQ==
X-Forwarded-Encrypted: i=1; AKwUvByBZtHTvs3yphG1I8jFKDLXn43/Ir2pmfro/YDnPOdM/bhG9xfz6FNotMFdcgvH4FIVJrPRgJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++nmkwvNYECg577hgLudr/tE+ZTqIPuPK/ZvdlPkRKIu0nHAvSEv
	GrrgEqJFZpN1cBRiME0rHnUnpiW9hTvUSkboFbk1rVRt7MwikXKU6jVwB6n7OHBj8MQkfB2UVPI
	5mAVg4msNIcvEBL4GGOUgNNNRmtLq68CQUgepap86trPPf6JdoVa+05moug==
X-Gm-Gg: AYBFou28hDHWsUoK8ovNrwwT55imw6bpb23ISrN1kotGurpxwToQRrBXR4OBgJI0DwD
	7Q4xvAD3Ma68BLNUAQQCRxJysgQtunvxYz7TbxazDn0371JeES46tJw8g4TiOeQ9T0R07rqlUuv
	9Rb10xHB00/U8Ndiq3I2enBS13nvZg63PsNiuDvRCsTk2RfsMTSmVkrLyWiM3RrV/EaR5gFu8q/
	Yds0YyotEGruQmdkCDrYkA2AA/9fHROVLoLY4uzveoyaMPsqiL0cYPVDjUaU1VgpPn4hwya0PpT
	B302h8fdVNpaP7bfboot8tK/IH6wOcgtq5mcUJj+2bnMNQckUITt639sznZ5VOfJxeefs1tMvNN
	b3gY+uKCONQe+eAMjLWgb38hiHWMIZB3RnbyNmIiHcRYGOCFsQtn2pDd/4rtPZ18drz2V+UFEfw
	==
X-Received: by 2002:a05:600c:3511:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49cfa211cd7mr27409525e9.27.1788513030010;
        Fri, 04 Sep 2026 02:10:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3511:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49cfa211cd7mr27408995e9.27.1788513029603;
        Fri, 04 Sep 2026 02:10:29 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm143075225e9.6.2026.09.04.02.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:10:28 -0700 (PDT)
Message-ID: <a1c9d9ae-68cd-4153-9bf3-38be1cd8970d@redhat.com>
Date: Fri, 4 Sep 2026 11:10:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 2/2] ipv6: Remove IPV6_ADDRFORM.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>,
 Hyunwoo Kim <imv4bel@gmail.com>
References: <20260904033543.2635540-1-kuniyu@google.com>
 <20260904033543.2635540-3-kuniyu@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260904033543.2635540-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 5:35 AM, Kuniyuki Iwashima wrote:
> Recently, IPV6_ADDRFORM has received many AI-driven bug reports.
> Fixing them properly would needlessly churn the fast paths in TCP
> and UDP.
> 
> IPV6_ADDRFORM was initially introduced in RFC 2133 in 1997,
> but only two years later, it was removed from RFC 2553 in 1999.
> 
> In 2026, modern applications natively support dual-stack sockets;
> notably, systemd's socket activation does not use IPV6_ADDRFORM.
> 
> Also, getsockopt(IPV6_ADDRFORM) can be replaced with SO_DOMAIN.
> 
> Let's remove IPV6_ADDRFORM.

Yes please!

Acked-by: Paolo Abeni <pabeni@redhat.com>

> Later, we can remove sk->sk_prot_creator and revert commit
> c26c192c3d48 ("udp: properly deal with xfrm encap and ADDRFORM").

I'm not 110% sure syzkaller or others will find a way to still trigger
the race addressed there, but I guess we will see.

Also I guess we can get rid of several READ_ONCE(sk->sk_family).

/P

