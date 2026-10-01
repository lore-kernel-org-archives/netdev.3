Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BA1F09A5
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852290; cv=none; b=EsNSOcrNTMyhy4mNeKmGgx5g3LDVpcK/Yx6pzeE7rMSD+T0+ry6s6CeWq1bnh4OxyJpBA2srBjzpTbwjygyWaZXJBnCu/ofTjvj4FvIpV4PlcvXdRo7BOpciWQ09Whh+jG+/vWncqZVR7eyzrMYMhocVf2jyYzY7vKwUpqnu2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852290; c=relaxed/simple;
	bh=0R0/gTRYYSmxRnH5ZVk7sblCpxH+EKsEaD3El+V8yes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXUmjcQam5sMmJDI1pBw01lOHTQC86aYNaX6hjKhes9bR2m2n2HmVkhguj3kUd86R1ZaLdu5CzEFbo6Gs7thnhciV2Sa6bZ9XVNoXxcHu0QVNcoJN+KmwEnXtTN1eJmnt4n9mRFz5g1slVNy3NPvdB6LpLe02qzgBEj16aCtFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNjOkIQU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ry5H9keO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNjOkIQU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry5H9keO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790852287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tt5IAt6vMqsCLYkrQdskETSZXcKhulecCkm4FRkZlO8=;
	b=KNjOkIQUUeHXGEyMPYPsMqfe15x4qfwoqcxaFj5kgkqcYWZwZY6oCbr2vediMKN/X7l8Ha
	LqQuk5Ip499xjbvuo/4hOtiCGq/6nxcULmc1zU++Ru0hCH5NfBd0BVzAttY8kh6XD4SKVP
	4guHq9uw4WOZJ6Ngpy5fUZ3moTkjung=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-lJ7IqYwmMXG7IELxzolDVA-1; Thu, 01 Oct 2026 06:58:06 -0400
X-MC-Unique: lJ7IqYwmMXG7IELxzolDVA-1
X-Mimecast-MFC-AGG-ID: lJ7IqYwmMXG7IELxzolDVA_1790852285
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a02085598fso5152075e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790852285; x=1791457085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tt5IAt6vMqsCLYkrQdskETSZXcKhulecCkm4FRkZlO8=;
        b=Ry5H9keOJaa9gb6/zQS+ujB4zAnrRddRxDcVAbUnnwoU7RovyQ6FM0M0j9V4Nx7xvQ
         2NMAea/c1ctHpUSKhQszVYU7MuGo+e9yejIxfHm1n/p/e7HC0mfots5ukoIMhNrlUj+U
         wVWh98CE3v21LbTCPemjzsaCmIKfGTw3EfUhjq3GYAAhrkWkQJQRTtmXwzdyfkFTp1nJ
         SR5X4ruxpDVScYjVXEXBNzKFpIpgQO/ySxschNCi+9HJaml3cBLVkorPzKGcOjfLoROd
         cHi870AXYw2kSUhQ99/eHp8j7HRdIfQocY75yA40OWxzCPajpnTOhFM4oU4qb7NmHtQ7
         Ibbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852285; x=1791457085;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tt5IAt6vMqsCLYkrQdskETSZXcKhulecCkm4FRkZlO8=;
        b=JfdcHsaLiWJEvzq+u6+OSJL8mtWsxdBZjoAut+oap0drwY5L95J0mxbgsPik3i2q4t
         Pj8ZoaPPo4KLiz+XGV0YopAqlHe0Dg4ZxRDT9Fgq1zBhxmrR8Vk9pW7VVkLD5WgzMD1T
         t7zhhn+BEtzpU76kR4oGrvwcsYlBmDKptmiLo2LNOtEq2OsgBQdCzQq7n7B6IlmVUpas
         /9IE8rdS5T4tm+H04+EVmRuebb4jEckzMioNz6X6SspgrvbBJYJaZuxDwxD6XLsCey26
         jJvWJ1VidGywnL/6bt89zihuFb2zgqGTw7XYyOBljwt0TJKKv0YMIcaGZsB8eQ9JC4Rt
         Kudg==
X-Gm-Message-State: AFuF++lZFQB5KwThiOqRBfdkx6Sc87h9C4Z9xpd7vvuC+FOt40GmgXZW
	hdcs4ZjCSPCR3X/gmgZlo13Eihtkzyb/Cv2Usvd3u1CuYmf7egEKFu5BWEOXYNbLk4R5cT5GmJs
	/LaQoh03vvpOfhl9nIDBQapPAwjHrELqDn6Dq7UpzvlBsJPcenJSwWWL3Bg==
X-Gm-Gg: AYBFou3U8Qf7kkAJ5q6i0W6d5KlFiSQp1ODLEEoPwHhuIJ0k+aDvp2u7sFqMMpNcbjQ
	lwYvPWH1tADRRlbLSM6sUmcS8KgiljvlMXQRfiVtKEuZdYJ1IxeWCArDQy7KtnTFXAG4rq0vqXt
	XW7YckZXmGRrUEGYY79UgTdSm7j+oUNPZp/izB0E6Ngr+naJjoOoFF4xhAo5+hmYZIWBe4pAtCX
	l0swKdBJ4UJXzBrILyVuyHHZ9C9Pw3k5NPP/UanxVOreaorxoN9DpIuecDcpjQk3/mIuMa5GuxX
	6/AF0FKBTz4D9RQqSt0f2OkpB4/IcI+8wTi0CjeHnOS1TSHIUCbF1veO8E9yPTTC76tAQEBqEFw
	mpUdVt7aSqG5ap7idjMoGOwbdoFPHsps1dIXsRIlpdg8MNmXwnFc3DK/wpTvrQ4oiLWm/8ZvUQA
	==
X-Received: by 2002:a05:600c:4e56:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-4a01b00ef27mr80088155e9.33.1790852285144;
        Thu, 01 Oct 2026 03:58:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4e56:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-4a01b00ef27mr80087715e9.33.1790852284618;
        Thu, 01 Oct 2026 03:58:04 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a023ebe694sm33186845e9.10.2026.10.01.03.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 03:58:04 -0700 (PDT)
Message-ID: <83bba48e-7f0f-44b6-a7ff-b64c3ba96f70@redhat.com>
Date: Thu, 1 Oct 2026 12:58:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] seg6: fix HMAC validation when an extension header
 precedes the SRH
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 David Lebrun <david.lebrun@uclouvain.be>,
 Ahmed Abdelsalam <amsalam20@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260926-b4-seg6-hmac-transport-header-v2-1-8087b76f6375@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260926-b4-seg6-hmac-transport-header-v2-1-8087b76f6375@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/26 13:19, Yuya Kusakabe wrote:
> seg6_hmac_validate_skb() derived the SRH from skb_transport_header().
> That only holds while the two coincide, which is not true on the
> seg6_local input path.
> 
> ip6_rcv_core() leaves the transport header just past the IPv6 header.
> A Hop-by-Hop options header is consumed before the route lookup and
> advances it, but a Destination Options header is not: the seg6_local
> lwtunnel is entered through an input redirect from the route lookup,
> which bypasses the extension header handlers. The transport header
> then still points at the Destination Options header while
> seg6_get_srh() has located the real SRH further down the chain.
> 
> The HMAC is therefore computed over the Destination Options header,
> and a packet carrying a valid HMAC TLV is dropped when
> seg6_require_hmac is set. Such a packet is legitimate: RFC 8200 allows
> Destination Options before a routing header, and get_srh() has walked
> the header chain since commit 5829d70b0b6c ("ipv6: sr: fix get_srh() to
> comply with IPv6 standard "RFC 8200"").
> 
> With a Fragment or an Authentication header in front of the SRH, the
> same mistake also reads past the data pulled by seg6_get_srh(). This
> happens before seg6_require_hmac is read, so the default configuration
> is affected.
> 
> Reproduce by giving a node a seg6local End SID with
> net.ipv6.conf.<dev>.seg6_require_hmac=1 and a key installed with
> "ip sr hmac set <keyid> sha1", then sending
> 
>    IPv6 -> Destination Options -> SRH (carrying a valid HMAC TLV) -> payload
> 
> to that SID: it is dropped, while the same packet without the
> Destination Options header passes.
> 
> Fixes: 5829d70b0b6c ("ipv6: sr: fix get_srh() to comply with IPv6 standard "RFC 8200"")
> Assisted-by: LLM
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
FTR applying this to net-next, as it looks really an always broken
corner-case, and Linus is asking for really critical fixes only at
this point of the cycle.

/P

