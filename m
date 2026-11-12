Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500816;
	b=3plKT+5K2fZQYdKspTCxw9ayPWKWar5OT3k69SCEYiqdj+4YJG4u4b51ReTtniUBgPi2
	 fShGQbvaZxjBFFppZJQrs3VoYxADjPhZda/FmoKnc8DwZEAXCBDGIJSagFwNezLP6H37n
	 /8tqKqQg8ul6ilHx2AsE+kzWbrULVeDBm7++YDK8XyD64/UxbrCqL4XTL6i3c657uishT
	 8E9CHdapoMGSQknhrrQMsc/bj6Y44gkBZVsdujPgXDMxVupJW3y3OsWvfBg2LfNekIvs8
	 FsPfBzvQ/F4xHUfwaKLXRV90UkEHHAqmicGCtItb6r8ilajheXaMg1tAhI6odaNVm3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QQ/3quzm4feLEDq5prptw7Btjz+8je4ZUZGF6TJco1M=;
	b=sKJgDPF5u3usLtXesru7DOnHwXOk1n3w9n2Dy7dd2JS1u84mg1thqHVKtI95BEPAjc+a
	 PKh23GCZSQDWjPD7tEgbFNC17A8EM//AqX80JyjCrkI9BPeLd1rnLQJi2EqQDp8bCj14S
	 KMqtU+8O+iWiqEDKInZ1fEJaOffhvMApkF1nI5pvtilhY+NC2QLHQs1J0x3affqB5wl5G
	 w22wSZfKO5ZcifgpAjONiKp8j4TB6IDhaEEB6awEdMuvjDscHOkxjlPEfb0qF4aW/f13B
	 Oy9zp0q07g/Tu5qOxndGJEqVQ/cFEhp4mbGrAb0+TEpCWjEC0zJsnavXbshkQwdKOgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b="EtFg/kC9";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1072606A888
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1072606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=EtFg/kC9
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso4725875e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1794500814; x=1795105614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QQ/3quzm4feLEDq5prptw7Btjz+8je4ZUZGF6TJco1M=;
        b=EtFg/kC9y1DirVvA9yLbTRagqhSjkLk6ziYDwHAP1xD7Xmb6LsmwWC8mOetg+tDeZh
         xWqqP6oEWPZigH9h1x3dDWabH29oHWXXy8GyR9+grcWK9NGsuRdMLxx+2jW5MXAnBZ+b
         H/lsp0vaUjFdhS/GF2SD93gAx8GKeho3HqXqonlGauq2eoZZ/MrWpHCfCZ3KE4KEYOUt
         fqiTFrUhHUh8TyyYD+ozgnb4Vl8qqidvow3BWLG4cR49WWZCTr/lQPU+eMqBNf3k50R3
         sT9Nx29c5j6NPlP/T/8cZnAXmYTOw+p/EfAeODvgcT6FR3gbNvbFp0tzEYIJwXmERdqj
         v7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500814; x=1795105614;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQ/3quzm4feLEDq5prptw7Btjz+8je4ZUZGF6TJco1M=;
        b=DTXosG67CZryEc1YJm2X2Wb56futIOY6nw+D39Fk2486sO4TBRj8ENQ1ibYkuH1Qx/
         Ev8vC53qzMgG2+HwbHRpzBb6x/TBh3iq1ULlJzHqhzSeHpRP1ira86JIg9zmbaH22Xxz
         03EQmJ4+lIfOMeOs8JVvVFMDNI9WKOyHjosJGRDIEzD3ZojNrPnp38m6i9dUubXm90Ya
         4F39rHgkuROmptCa2d9c94QMTiau4na885ZKVG6XYyRk38+JlG/OoKswFj6oT+WpKOhT
         WOTucl7NS03uGbCvPCGiyA6rDc00O5t32/JF6FKIqQz3VGB0KDoak4q7kCGWeNNEzymB
         QAdw==
X-Gm-Message-State: APuU4Z+tNEgjz+eAv9oC2tmRH+iSX5kF3oZpzMYW0/I4JdSZ6O9jNOPi
	JPHlh1hE4jUCghrpcTBPm4p95xroN8eNPjTCVuQpU16cIIHZXCiEU9rnF82ZJpNEIEQ=
X-Gm-Gg: AYBFou0rN7sR612nIzSABG/u6XK8t2zTVc/kg9oZduACBWNj3tQy+wg3EJInnmCKsox
	NMA1UKNZw9z+JVLixzMNznzMQDdAW8YPhAUDIR2Iyo93KDY2LQ92W9K3UZ4VHwwPlt+eIcfovYy
	AFARJkNtu0emt/XXXcRW+7MpATOBJfV5Cgd2kfKa0w0/qzexY2GLGd3pSctzOTNKOryoostWq2d
	WsoC9Rr1PsAyMDFLuThjhbv5hcZT/LOx7qIl7v829YCAT94/zZ2As63fqiVCfbSwalU9c745cTO
	85ORZhNdy32X8Rv4A3BSw+oJNGyp2SeiZF7KKO+0f1FAEHWXCQclTF7SkL1L+v3UCG/DSyo2t1s
	fwk7qyxjLG78CmZq0ZjdMRag1Wo6ZWnn8mS86sHy2Y0xEW/m3obHttH/DpwoLz80uR4CuROd+Gi
	OVGi0Z15wbp0/NTvdTiDDfM4xlQHkVlvQlZwfVFUPy52S0Oh2urS5J9FYrUfgUvIQWZmN2avUkI
	3WWT4j48/2O6ZOS4Hwzh3hclofQ/yYpVBO3oLNTEgKWKXBmFhVwct6k2MsATFbM5ow8nYIaAGwn
	ESqVLsZ66xzF0QqF4ejPAYB1PNIWoiE+JnPoKTvg5+Bq6FDGdmNBb1fs2I6+6oscq6SPB1N6nNT
	XwV02jg==
X-Received: by 2002:a05:6000:1788:b0:490:540:f95f with SMTP id ffacd0b85a97d-499c92284d1mr12368002f8f.5.1794500814316;
        Thu, 12 Nov 2026 08:26:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c607d12c4sm84484f8f.41.2026.11.12.08.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 08:26:53 -0800 (PST)
Message-ID: <bac47e7d-2982-47db-bf97-d8c1d832704f@6wind.com>
Date: Thu, 12 Nov 2026 17:26:53 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv6: always apply all.force_forwarding to every
 interface
To: Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261112-ipv6_always_apply-v1-1-8df846631005@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261112-ipv6_always_apply-v1-1-8df846631005@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/11/2026 à 14:41, Gabriel Goller a écrit :
> Currently, writing to all.force_forwarding updates the interfaces
> only if the value stored in all.force_forwarding changes. Setting an
> interface to a different value and then writing the same value to all
> leaves that interface unchanged:
> 
>   # sysctl -wq net.ipv6.conf.all.force_forwarding=1
>   # sysctl -wq net.ipv6.conf.dummy1.force_forwarding=0
>   # sysctl -wq net.ipv6.conf.all.force_forwarding=1
>   # sysctl net.ipv6.conf.dummy1.force_forwarding
>   net.ipv6.conf.dummy1.force_forwarding = 0
> 
> Apply every write to all.force_forwarding to all interfaces, even when
> its stored value is unchanged, matching all.forwarding. In the example,
> the final write to all now sets dummy1.force_forwarding back to 1.
> 
> Also match forwarding's locking: take RTNL for every write and compare
> the old and new values under the lock, rather than returning early based
> on an unlocked comparison. Send netconf notifications only for actual
> value changes, including for default and per-interface writes.
> 
> Note that IPv4's forwarding does not behave like this, but we won't
> change that one and align force_forward to the IPv6 forwarding.
> 
> Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
> Suggested-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
