Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0F475357
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932622; cv=none; b=ueckCnvLoZk9Nx2VYlptxaatKf2PX0qCYQ9dWoXUovG4wZyeTHxuL19uJGa13vFvgR58ZUU+RqIa1xLA3mi3+enFpSrIRDpkVzrflZkasBMx1IsmwhVNZpHhIUatOswTSsbI/Bz2iZIagHR6UPpUQbAMsFZCPfY9KkkJc48J8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932622; c=relaxed/simple;
	bh=O9N+9R8uU7QsHt0Onbh4nEptde/Q8bHqysBonV1VsXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UISD3yhTZ7u+8e2y0YVR7qVTnAP3MKDOyWhdyY8x9SPrRidLdmDaqATWQc8VCcGuS43ugkJix7+WT5r/fdpJAuWYJVeWHRP5f0LZVMVEiXMcSQ1ouF44jeRDEgpNpgy+8LpA3gDS9FJ3R9yhSAP1bE1jF2qyRE7NBKhvXFSfZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dZ9HcI85; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dZ9HcI85"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so50053165e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790932618; x=1791537418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/vrBD0CT1MR07gxIR6j67mOmP/4T+zAG5j0e2ov3zjU=;
        b=dZ9HcI85Qr8kB1UCbVqqMZ2nJIiu+ZeuzpKZkTNz0G5XpNIAxvNeVbrRLw1/6OwL1n
         lkFwkEwm85Y0Pc1vyvQ5s3TXHG43Tn2m48YtENu9SPk20Ntixg7fhRdflDTluWNwJeAT
         r3z19ottC3skEk/Z2aAtlUVa5IQXzG+CR6SPgPBTEySVcG/gWRN/kDT9XMFZOsRQGEE6
         fpiAvEYD4UY3CkxdJpXPRbWPu/3ABPqEQpAa24L96fokxigJeJxCg7dyojr0Z5dNIBVc
         McOn1VRq7usDSzukKl9LGgCp9l1LnzrONDB8g/S2BBWxzFn99o9K0brrQx9E7OfA8Rzg
         PuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932618; x=1791537418;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vrBD0CT1MR07gxIR6j67mOmP/4T+zAG5j0e2ov3zjU=;
        b=gzOrotPzhQMPKonFsrRR5u8V6GwJb5dX3iCtEF1wh3A1nbG5L7Ra9WjVA2g9SS9NA9
         JunJfbk18VDjxk3zlXZV84OU/CBTA6kuelm3BUWkjg/N2PUEKdPg+A/kz/M9d9cwI8+L
         jGVvGoGwQ276PVhJd7DWhtDIskWgXYkVOExKuKfTv23Sv8ZgH65GQKpsYNLs8mTmu/Dm
         AGtNoOMO3EBoTK+qZyfqKfvugrURmIcJPaJzgqxzj8A4dp6miYm+mHyF3Xh53b8wuCGC
         DVJRhg9nxrY6g8+RiMEOIgeJaeZxClqlViln0a7IZmj5FzSImMxBmXKl76adkmAl9lKN
         FPUg==
X-Gm-Message-State: AFuF++nNuDwHjyRh/XmoMXuQxooNKELYgzsePnxG7axe7GVvryQ1+jym
	SCgyct8TAdisAI3eOFCn28HYcdW1lhTQyG4bWEvEeHfoPT52Ln86wFhXoW9S7RyCFvsk+te+R5h
	bMoKuNVwNxWzYsEOzA76+SEFZprAxKdU05/dbLwFlawuQ7rW7PW8=
X-Gm-Gg: AYBFou1GEOds17bi7xN3OvKVfzkzV47KCJITW3UekyFNdHpLxKbkVTO8Mk2e7i83mVi
	j2N3+ymI479eRzTlquo/ngZmXWadEKgSAb5pCZpZcoZ5JjFocV+UcHAIvVKMycBu40pBRtddtsZ
	eD0FxYa2lWuUNlBCKaUROTCuk5QrXSK6O+NccqZ9YuOxsnfHBMnMwJgWFOV2OM33u1PFiqUgox4
	Gzok0x2QpvGhigZCc0A5ijbxU4dy4FESC/PvDCYi7UH5svWwe2v8JcPx717+BsI8qWzT6m9Kg42
	VnE+EAORtdUghEpLZP+uJ4kCdcFRjQwDaYl6k9RFxwDF1tx2/WCbMVdMaM/z0z6bVLsF3XX2OcW
	zufFmH0LGHjXUvXKFxHlksSJKK6lrzoaf7OuZpnLyAAfN097Fc9Bx4BojkEqha36HQ8UMmnsfrV
	SqSKyImhUxIlVImx0c7Rhb7JbszA7IMeuosnJmZNCnF+EPUHlCPZ0adckaDRl3eVuC+KsQshI8E
	KWl2Q==
X-Received: by 2002:a05:600c:34cc:b0:49f:bd3c:bc28 with SMTP id 5b1f17b1804b1-4a0276afdb4mr42129595e9.35.1790932618211;
        Fri, 02 Oct 2026 02:16:58 -0700 (PDT)
Received: from [192.168.182.19] ([185.242.181.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38307190sm4028330f8f.45.2026.10.02.02.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 02:16:57 -0700 (PDT)
Message-ID: <db73f9dc-ea84-48ef-98c4-d5220402d741@openvpn.net>
Date: Fri, 2 Oct 2026 11:16:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] selftests: ovpn: wait for the TCP server key
 setup before traffic
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
References: <20260930222542.3839327-6-antonio@openvpn.net>
 <179089367106.434549.3098615866508622379@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <179089367106.434549.3098615866508622379@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 02/10/2026 00:27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] ovpn_wait_tcp_keys() (common.sh) runs a bare `wait
>    "${OVPN_TCP_KEYS_PID}"` with no timeout.

It makes sense to fix this.

pw-bot: cr

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

