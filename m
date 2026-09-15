Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9CA3A4F26
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464024; cv=none; b=uzXcCakoiLgdObvmGAnmYT5gXW5Ih+Bp6y9dW44fKhc274Slgn/aq1KgS2D9rT9gkqwFNXPsK5xo/jj7wfuKBNXYgjmljlaKVaQjnjFZmK/k99MJx1Z6qEnBTjvAJxUPWy9XChpWVcXe9T8pTIw4QrCM6MF/4fM3MdqPQKgu7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464024; c=relaxed/simple;
	bh=7QF5VzOx5N9b8wDB4YNh9yMDLXWGmmT1JbLK/pr2UaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqM5CW5c2JHiUNf1EdJXX08F93zCbzpwvZT9fbCtTo2M9L/Z9WFBOJSNBVajLQFDG2sPw3SQKJHpidcEgRyPjWw8ZFw7VHkI4l7QEsUI46pgklLHnvEjrkkM7bFO7h9K6rrdMYlvIrrSGOBT3Aq6lmKakN0SomF4fY02asFj2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzaJbXLI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=crOWcqkZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzaJbXLI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="crOWcqkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789464020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/Wjt4DMosTFbbLzMnMEQrvyNXktyVjA9pU4yE2rIzc=;
	b=NzaJbXLIy1GZRYr+26kb262vYc3e+vMYZm6UuifA9Y5Y+SZGav3Yv0nNnFKCLjLUNfe3DQ
	2CXjzn2q5RvZIC2Sm+DVrmZx31xTRLCTrVQu7GkGRGr7ODMUM9lOcu0VT9DdE8tdxc7hZL
	mVvQLztoov1nLI1KVJvOkMHxMYFv/CA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-fh2pyrcEPt-b28nTqfbvig-1; Tue, 15 Sep 2026 05:20:19 -0400
X-MC-Unique: fh2pyrcEPt-b28nTqfbvig-1
X-Mimecast-MFC-AGG-ID: fh2pyrcEPt-b28nTqfbvig_1789464018
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29476212f1so335743766b.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789464018; x=1790068818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/Wjt4DMosTFbbLzMnMEQrvyNXktyVjA9pU4yE2rIzc=;
        b=crOWcqkZeVklwp+mGSj4XXeT+13ZbJ4U/0zqJi+CEnQiiSYnbMw3mbbOCjNo4qoziA
         PGiqNzlRtPMsmNM1mJhpUSUpKIlp53YZ/329x5l+459Z1524HqMJUX0EjKpzi/CeT6Tn
         czFBi45C9eeEAcSj6q2/hn5GvT19j+ztpOJgE7UM4HehUe+8FlT65zKUP1+gPyjnLhsX
         5YtELEGcNsCNOEwaYPw0Q1rzQObp+kLe4l3Ut6Xu6rTNP6SXqapeVOqpgEZIvBgyctMJ
         I6BskW6jlTBIS1VudhdDRgoa3GMlSOYuuBxrEk5amjKzbI/RTGgDPI6qHHm7xTMilt0L
         s4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789464018; x=1790068818;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h/Wjt4DMosTFbbLzMnMEQrvyNXktyVjA9pU4yE2rIzc=;
        b=DN16EX7FtIt9JI1XajZSdU+wUMT6Z4OkQk3giyU98y0cFWfnf19CHbHSlnevUhGxV5
         HmDpVSVlR9BZPlNOfdtPn4LTDufpogIAZSkCZRRHZNeTDjEIaFWwR6evsLx7bVV8DOQf
         gciLw1yJ0ttZVQxkfPS3qByLC6zz0t2p9DQns94/LVaUVn/qvEMyVMyLoaan5Ej0O4Lr
         irksTT/3FSvKpeHrAR/Bf5S097JaBqWC3zz14aHDmO7Ok3USU/C+1ATcyCNxncAeE2VS
         MeD/LRNrtvo+EDcz84ntjw1EjnadqfQBRDd4EmtqLysazAVof65BuiOvfYUt9mNaFpRz
         3amA==
X-Forwarded-Encrypted: i=1; AKwUvBwGZT7NhYzDLPPxgfTHUJpUvQELolAdAS5F6Yt11yUGc9TLnCyfiDycE/ku2HZzYqww+09SLOo=@vger.kernel.org
X-Gm-Message-State: AFuF++nWI227QeZbIeqWKMZLOlkQCF2jZ9WLUCod4n0rM56AdFmVVFLT
	edbhqUPyhdqcYeXGR7Xcjpx543m4MBxTd6V90js70Fflrbdo/uockypA4GP2bH4vapf+v08rZMT
	G/+5sPSSy6npvrop7CYUAO1EYncKgoTvyb2CFhC6VAHkjsOF2XFXg3OIpnA==
X-Gm-Gg: AYBFou2Zl29i+sniDo1sMx6RnaDFBEPQkSzjx1XSwRj+KIgbgUDTw6xDK5DkNFZXJxb
	ikXX/GP0CR1kvJZUm0jvUbDfWMD2rXr+5461bcEaadHgTub17XaYM8h54IIRfwB+wIGqCOyidrI
	U4h2sIKSINj6XDV3qO2z2OZjWTfi6wj0qko8urTGJ5tDLJMDprfX8QS3y5bWM7AyKadTVCSECM+
	SdPzOE/HaIHD3n6tCOr6VYfrHF0saj3HSVm4oGFZO4z9viHkmo5etzNh/Qi9j3Ox7SXAtNLHk6/
	+QVlUkNxHR2HhsyTegog7LxXla4TBk59qhp96jxzzRBoszIfQZ45hCh7N5nIgxXRGNXdZzH+u+N
	MSL2B/Wj1aDzwyoskoADZreZfxg2K5xg9gKTuSue47bdd3Ib0p9WyMGIYILUMUe4WCut15NoiNQ
	==
X-Received: by 2002:a17:906:6a04:b0:c29:4b79:e41a with SMTP id a640c23a62f3a-c29d77cb76fmr25087666b.20.1789464018175;
        Tue, 15 Sep 2026 02:20:18 -0700 (PDT)
X-Received: by 2002:a17:906:6a04:b0:c29:4b79:e41a with SMTP id a640c23a62f3a-c29d77cb76fmr25084566b.20.1789464017704;
        Tue, 15 Sep 2026 02:20:17 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660d49b5sm562688066b.46.2026.09.15.02.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 02:20:16 -0700 (PDT)
Message-ID: <e651fe9e-2d84-4320-99a1-6fddcfc00889@redhat.com>
Date: Tue, 15 Sep 2026 11:20:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/1] ip6_tunnel: snapshot encap in xmit
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, tom@herbertland.com,
 vega@nebusec.ai, petalzu987@gmail.com
References: <cover.1788778433.git.petalzu987@gmail.com>
 <ca20d8addc2d6b01cac83ed9661e465c47e9b94c.1788778433.git.petalzu987@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ca20d8addc2d6b01cac83ed9661e465c47e9b94c.1788778433.git.petalzu987@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 9:01 PM, Ren Wei wrote:
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7c9aadfe8fe3..ab217ddbeb20 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -522,6 +522,16 @@ skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
>  	return SKB_NOT_DROPPED_YET;
>  }
>  
> +static inline void
> +ip_tunnel_encap_snapshot(struct ip_tunnel_encap *dst,
> +			 const struct ip_tunnel_encap *src)
> +{
> +	dst->type = READ_ONCE(src->type);
> +	dst->flags = READ_ONCE(src->flags);
> +	dst->sport = READ_ONCE(src->sport);
> +	dst->dport = READ_ONCE(src->dport);

The above can still race with ip6_tnl_encap_setup() giving inconsistent
results. As noted by Eric in v4 the solution would be convering the encap
to RCU. I think that the additional dereference would be actually faster
than the extra memory copy.

/P

