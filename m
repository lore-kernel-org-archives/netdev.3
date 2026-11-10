Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332094;
	b=FNyEKH/YkT0bTwXc5PgPnCki3t4tA/UbqTullsNk/MEJtUR+uUjvnTpSVfoj/FQYDpws
	 acouhWcxJMEFmFbm5wZ8fyjaI/cu5OGH1bmDmKJZi1dsqrlmPJLnxun1Nqla95UZUKn2+
	 xfSwcMVpfeZPjjNhTdM6ETPNiaVpJeIsHpbfECI5EbVaACrs1KkAzQM/SMkZBMlSS5gQC
	 Aj4ibn6QWRYiyEEWOUGlwBKe2n0dZARMmEQoWMFCoGkCMtm76TYup13LAq7ffBbfinw3T
	 yFl6z5ZIJ6OCresRmfcr2AWHd7UkIydkS8O7GfaTK/LlqZAPV+RQ5mfrXZbJL3ObhkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3KFTybz8kT++YN5KVSZrQLabEco9jibefDbnF3iC0ZI=;
	b=CW2Ds3KMrtmSCsFkQUzloHetHEl43u+y68uYinR9pMie8TZu5eZJ1BLmUjuLU9U5A86L
	 UzeWEVAGFMUraM+fEP8HNQYnoRaSbtss/XtJeERS3CQUT2x6V3UN84at5yvo4FyjIXff4
	 9ll6m3xibg5q5YbC4t+1CH5MlgtMW5e9AkClVPvoYh32b7HRGo1sTTgmimNZPwAcD/tRD
	 1oSvYwURlg7r2N7Bo7aQBEY/+5WlGirLCMBM97b1w/idRM+G+UNuhjJsTPPkAwjrYoCYk
	 3DAt888uSQPSelFQw/UEfKr8KCaCcFIHcA6XNbPpfCTtFDxAo4uz4htn82i79E+lxbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=DV2mBkeH;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DF606A32E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 850DF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=DV2mBkeH
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a7a3b29c11so2556775e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1794332092; x=1794936892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3KFTybz8kT++YN5KVSZrQLabEco9jibefDbnF3iC0ZI=;
        b=DV2mBkeHi9vDwYG/ceZd/Q4iLGwWg1jnKcSAv3wVxqBhiLC2YbAFlhVaB+RzkxLNHD
         m4X9I8H1nweDa8MFCKzPHa4zOxNDbdVnE6brJ2m6GkZTRc71HjYQ/m3dUX0QiIMDQA1i
         wAqtzwYOTe793jXvR4vv8mU1HWnwu151AkGbc+49mkYpJjb5rM8KPSBmnlZFZ+G1u5eh
         F143rgAzutJ14CbssvmWElBBeEagf5O22tX0vYpoNgsf17uQD5OIhUsuiM29TwD2+e0r
         dMmcFoUbykEs3mPoNjpF8Xp4DMUNIJn6qeZnmErM7+b6+3EqmRHdKvUf4AYk8HNInqFY
         G+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332092; x=1794936892;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3KFTybz8kT++YN5KVSZrQLabEco9jibefDbnF3iC0ZI=;
        b=Ob4hHd3dx4hJYL9eLeEObOGn/gR+81xjyLuopGInevSoI43jsil9o2X6YiFWXYpFcZ
         Q3Dy4e17Tg0S51bvHTapHXsdOenFVTo1d5RWBCLhgj+UR8GrxZq+L+rJp34YIBhFIEKH
         LoCssJcHcuk3lCDBfyigoVUimXcSFnRV2a1J2ykn9O1bRrcbKVex80pNfRCAVuhNNkd7
         WrJV7fpqhLZms2+qvxVTOwOPYkWHW0N5qSN38mn7Op47OlEDpBdmzrgzZLbK9cFrdsTO
         w3tJF3+42aWI2MrHhRl5YU5cUmU9WMcucTDBzmUDmiCeSGwuTMIsyJeC4hnQSGWR0NGj
         QhoQ==
X-Gm-Message-State: APuU4Z/Kn0V4SPUEgeobMJvJb5ck3TLxGzL7zT2Wma8Z0dZbT+9Yiaz9
	lvj1z+x7QCJWW2R7bixA3FAiFKtQ1SkU9sph3wA8nR4G+ESib4X4zeqt9mD6BO0nOrc=
X-Gm-Gg: AYBFou0HpPwm3zowyYW8WpeOR7goW5qqOLNM4p7rR8mhYRIeZ6MNkuHdANxpSkcHegw
	pSXi4HwSsdEoxB8lg//s+Zn6Rfo8gz98NfmTQ/qZiAJEd3ZFc5wmvtKSoVGSBLoRX7XSZZnmnXl
	ZzA9VtTdqmzO+sfqp5ldrLJqha+g3chqSSIeFjJ6hVN2TqFFS6ltxOmax1j39PGgTfmvhNggQjM
	xcl+Zb7KJGwEXa3A6qGmVqLBrZflluSxiB0OkvzdsfFlYXVnG6ZkFNG4/Mx/HefLXTYnKOh2Wgn
	yF17uZgQS7RwjaNteOPtirIsy4PZqCywi9RLasUOQVRslLQwdpBohbEZ+o2FlfHshX6BxiXH83Z
	MSkG+y7ildQxWL+vRWKa+e0O/iMqLpwMXm8T671Nvo5V6s3Yt14yAxmcGLD3iYywBKLqhb8l3b+
	EXdeGUULy7liV+ML5NZJWZqhBQJ98i7GVca3mQ2dkLNbkHxh0Gy4cCVFzAcd9LjOYEpGXXy1e+i
	KAohm4044gvDWX77RyfezwAG0czpn+N4Yzf11/x5mTIJxsk+zcx/hUQTjqHwLzouMkUjAgS5roe
	C4/tT7absCU4UIAdxBhawfpS90YQMijTza+YojSTRx7w5o2JmbmDi1plNMjYX1oeqCMShyyWUBr
	HoHTADQ==
X-Received: by 2002:a05:600c:1d14:b0:4a1:b027:99ef with SMTP id 5b1f17b1804b1-4ba02337685mr57336495e9.2.1794332091742;
        Tue, 10 Nov 2026 09:34:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm78705945e9.2.2026.11.10.09.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:34:51 -0800 (PST)
Message-ID: <1eb85d22-7d2b-460c-82f6-2af15a4875dc@6wind.com>
Date: Tue, 10 Nov 2026 18:34:50 +0100
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
Subject: Re: [PATCH net-next] ipv6: reset all.force_forwarding when disabling
 all.forwarding
To: Gabriel Goller <g.goller@proxmox.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/11/2026 à 16:53, Gabriel Goller a écrit :
> Disabling all.forwarding resets force_forwarding on every interface, but
> leaves all.force_forwarding set:
> 
>   # sysctl -wq net.ipv6.conf.all.forwarding=1
>   # sysctl -wq net.ipv6.conf.all.force_forwarding=1
>   # sysctl -wq net.ipv6.conf.all.forwarding=0
>   # sysctl net.ipv6.conf.dummy1.force_forwarding
>   net.ipv6.conf.dummy1.force_forwarding = 0
>   # sysctl net.ipv6.conf.all.force_forwarding
>   net.ipv6.conf.all.force_forwarding = 1
> 
> Writing 1 to all.force_forwarding afterwards is ignored because the
> value did not change, so the interfaces are not re-enabled.
> 
> Reset all.force_forwarding too and notify netconf listeners.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

There is the same effect if an interface entry is reset:

$ sysctl -wq net.ipv6.conf.all.force_forwarding=1
$ sysctl net.ipv6.conf.ntfp1.force_forwarding net.ipv6.conf.all.force_forwarding
net.ipv6.conf.ntfp1.force_forwarding = 1
net.ipv6.conf.all.force_forwarding = 1
$ sysctl -wq net.ipv6.conf.ntfp1.force_forwarding=0
$ sysctl net.ipv6.conf.ntfp1.force_forwarding net.ipv6.conf.all.force_forwarding
net.ipv6.conf.ntfp1.force_forwarding = 0
net.ipv6.conf.all.force_forwarding = 1
$ sysctl -wq net.ipv6.conf.all.force_forwarding=1
$ sysctl net.ipv6.conf.ntfp1.force_forwarding net.ipv6.conf.all.force_forwarding
net.ipv6.conf.ntfp1.force_forwarding = 0
net.ipv6.conf.all.force_forwarding = 1

Maybe the new value should be applied whatever the old value was for the 'all'
entry (like for net.ipv6.conf.all.forwarding).

Note that, it is the same for ipv4 forwarding:

$ sysctl -wq net.ipv4.conf.all.forwarding=1
$ sysctl net.ipv4.conf.all.forwarding net.ipv4.conf.ntfp1.forwarding
net.ipv4.conf.all.forwarding = 1
net.ipv4.conf.ntfp1.forwarding = 1
$ sysctl -wq net.ipv4.conf.ntfp1.forwarding=0
$ sysctl net.ipv4.conf.all.forwarding net.ipv4.conf.ntfp1.forwarding
net.ipv4.conf.all.forwarding = 1
net.ipv4.conf.ntfp1.forwarding = 0
$ sysctl -wq net.ipv4.conf.all.forwarding=1
$ sysctl net.ipv4.conf.all.forwarding net.ipv4.conf.ntfp1.forwarding
net.ipv4.conf.all.forwarding = 1
net.ipv4.conf.ntfp1.forwarding = 0

but not for ipv6 forwarding:
$ sysctl -wq net.ipv6.conf.all.forwarding=1
$ sysctl net.ipv6.conf.all.forwarding net.ipv6.conf.ntfp1.forwarding
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.ntfp1.forwarding = 1
$ sysctl -wq net.ipv6.conf.ntfp1.forwarding=0
$ sysctl net.ipv6.conf.all.forwarding net.ipv6.conf.ntfp1.forwarding
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.ntfp1.forwarding = 0
$ sysctl -wq net.ipv6.conf.all.forwarding=1
$ sysctl net.ipv6.conf.all.forwarding net.ipv6.conf.ntfp1.forwarding
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.ntfp1.forwarding = 1
