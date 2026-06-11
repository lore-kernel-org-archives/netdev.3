Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5783A1681
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171612; cv=none; b=BxWM9OWbD6aMlWGSPIkniDskBfQTpCsY6SwT85yNW6K7yAZes6SGSXtWpLeQ0AR9VDqbUZfoqb/kCI79pOcHHnEguUffr8i79oGrCPUk6ikbW6bgF/mQr6WxXHXD+kOW26J8GX0f5yn3ypTAkG8H3CebdKFvDAWQHq1G9uKKnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171612; c=relaxed/simple;
	bh=2bnwAtJ2JBPzDaUa7HVCgHnsqqXgYo0Vr7O5jEGrYEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NP1DVA8GBvxam2VPQ/bqYchVmQVl3bYE/CI2z4We+ODZfZIWwXgBzdQOxAuhZRHuq9Tx8Zj8ZnHld/WjX8DAZft6vRrNOiragWqiTvR4xr59GyZMJV217MJN9ctOuuMb4z56OgarQRHC+/YSgnbvu6NDOrW5Q6dHcibCmJdF8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGmri1T2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vh5hTEfg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGmri1T2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vh5hTEfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781171610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpIAvaC9YlejOVcqjv2Fkrd3r+oiisU7g3ldjkjJ8jc=;
	b=TGmri1T2WgmPtjTBrsLAoVKJBOtHwr2Zb+vtrnrWq9W0K4yjkXlEnjTiaZg4xPoASgdsWQ
	jlpxaOiG7z1qo9ku1bYepm3/hvI9iwRCCfViDn4WhaaDOSQxCv/1AE8hGGeFa79ae09d+s
	7yL7QnxZ6HpWQVey2oDUb+bTOBbLUNA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-o_PZpW1jPTeZTXTxjbAZJA-1; Thu, 11 Jun 2026 05:53:29 -0400
X-MC-Unique: o_PZpW1jPTeZTXTxjbAZJA-1
X-Mimecast-MFC-AGG-ID: o_PZpW1jPTeZTXTxjbAZJA_1781171608
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efb6e60e4so6622376f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781171608; x=1781776408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpIAvaC9YlejOVcqjv2Fkrd3r+oiisU7g3ldjkjJ8jc=;
        b=Vh5hTEfgNmqLPmRqWC2fivFVDWqCvYfj6rctrhZnIKfs1IYAsrsVTOuX3q4gs0jnhR
         GzPdrMQ1ziQL6PeoYJYsf0sXhbVh6hSxvKRVqFkcwG8vOnH03JR1HcMBqyLf/vlK6uFq
         Jf4RxFnY1Od48L+iRxiH/Dgqjwe7agV2IXiKLJL8RDBK2RLAWs2WDdI1jmNTR/IFtjTy
         0J8j6AzptoNMX0Ho95JzKzyoJtN+v3imMLD3GA8di7LGgkqOaivErzBCYwERWKeHavnG
         hli5ZqCXxZRLPYQCTXVx+alkN/t4cbn9khd50iOTopfPIPGcCIWKRtpYc5/XjvHlefHM
         ArXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171608; x=1781776408;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpIAvaC9YlejOVcqjv2Fkrd3r+oiisU7g3ldjkjJ8jc=;
        b=X8j//KkDEvZidoAmbE4hBVQII9182wLGQxMmr/McBjGOX7/FsRLEdr4EMcyvfbpTx6
         +RTRiCc6UtIi4b/uhZV/Meg2gKVoiHhQumFmXtDBN2RCStEr/kLrK8tYHBWXe4/MYfC4
         cP/d4U2UTOlqYP5W4AtwBjSUfph1QlRsODXNKn+4p7QWp0LDw0h/XagNBHYXI0UvmaDt
         tp3QDzeZCLxgIHOXM94JbXdr0BHBzOhFh3Xg5UtODcpQeYza/J6gNDtTkJOTLifeDLoV
         B+kYYU149poOWs82HdZ3ZF+iyaSULdbjfUBfF0Y4vOfyoEhnSHUZamuwLTkB2CES8Pr2
         rGaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SYTafTu/tAMO4tooElXy2K8muASlUeSLbzFaOfH/akeSK+wF/LvbaAPg3mt/xD/ZYvifI0r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRSi3gXcJqjLidsaFeINqoh80klxDCdIRMGeT/CsP0A9quJ9X
	5GAsXXgA6WGHIkz9VeX6qnDU4IeJV8oAibzY7mu7AxmvBqWxwy1SczMgZ8LpQzQn9XUjqJPEQcL
	48oYQQFbt4bQREZoCb0GL2kEuRlvHeycqT4MwIEgxdaJ39bhYuCP76/XQjA==
X-Gm-Gg: Acq92OErNG8s2yjgWK6ME18F5t4Ty3d26phnZluRO7tm3YRjSj9JMWlal88Uo6dq3Kj
	9iGBiuf5+mRFeT6tm0s0DnWMRDZK+fT/avGwhbp+PcdA57wbOK108Lq6taF6kXsGOgGO8tYbolP
	/xf22VaK+2KnylLIR/H+rJgZEoOxedp299zEYhPSldl7GW3nmtWFi5CJIVgZOW0lpTjH8zzKcUr
	HK7ga2tbPJY1rt48Ul/BD+pDchhblgPh0oizHjk5rmdnbEUPj4AmJv1M3QzLS3XH6OLXKw+dYOg
	/SZBJFR5xZVzAkNT2p3rjVzFd6uHPn64MvmV1DGVGz8EF4sMZvLOFVB7dcTatyHtdXxZiQJUh4g
	+iZK1nr41jHoTt/DKdpzTY7OD99aVlKqvnwg4eEWvCHqMxRqZFbtdEOm1kKjEJ73n5g==
X-Received: by 2002:a05:600c:4e04:b0:490:b9d3:a9ce with SMTP id 5b1f17b1804b1-490e5640aa8mr27826875e9.30.1781171608321;
        Thu, 11 Jun 2026 02:53:28 -0700 (PDT)
X-Received: by 2002:a05:600c:4e04:b0:490:b9d3:a9ce with SMTP id 5b1f17b1804b1-490e5640aa8mr27826445e9.30.1781171607871;
        Thu, 11 Jun 2026 02:53:27 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46059346676sm17802230f8f.26.2026.06.11.02.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:53:27 -0700 (PDT)
Message-ID: <27897949-2991-4963-96d4-6d011183cce9@redhat.com>
Date: Thu, 11 Jun 2026 11:53:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ip6_tunnel: do not use dst6_mtu() in ip4ip6_err() and
 ip6erspan_tunnel_xmit()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260609091337.2672441-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260609091337.2672441-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 11:13 AM, Eric Dumazet wrote:
> This is a minor performance / conceptual fix.
> 
> 1) ip6erspan_tunnel_xmit()
> 
>   ERSPAN tunnel can mirror both IPv4 and IPv6 traffic, skb
>   (the packet being mirrored) can be an IPv4 packet,
>   and thus dst can be an IPv4 destination entry
> 
>   Use dst_mtu() which contains generic logic for both families.
> 
> 2) ip4ip6_err()
> 
>   skb2 has been prepared as an IPv4 packet, and its destination
>   is an IPv4 route.
> 
>   dst6_mtu() is optimized for IPv6 destinations and uses INDIRECT_CALL_1
>   to call ip6_mtu() directly if the ops match.
> 
>   We should use dst4_mtu() instead.
> 
> Fixes: b40f0130a23b ("ipv6: use dst6_mtu() instead of dst_mtu()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Any strong opinon vs redirecting this one to the net-next tree? We are
trying (with limited success :( to keep the amount of changes in net
under control, and this looks like a minor performance optimization to me.

If there is agreement, I can apply the patch there stripping the fixes
tag without a repost.

Thanks,

Paolo

