Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703A384223
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426789; cv=none; b=pOOyhNA83nSTz+sUPfzraL8WPx4Ebd5wv0nycCgCj7UTOj1YjB38NsD3wLvshNsqKkhlZdYBeUmLsLnRD0up67xcAdbfsiqYhEYFivOz6ff7l7fgeN/zYFJhHpneTTWM/CrLbf2bPcCPnwVx1x8qOZutYOcyJYH6IpssgX5uU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426789; c=relaxed/simple;
	bh=VtdxPng0YYBiALhxGMo3ep9mcH+EbhIpTkEyJddDs4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsM2OGOEN8ZFxIqh2YVxKWp99NtSLoUY398/oe4dwVHikiBYo53GUBe4wRM13aiUVaYZGLKFw8nt+mElV/P9GEz7uZ2sD8knbx/0Q2XR9+u/GoBCZ8INTbEVEzGmkkjAMilWNav4mF2eeolSzYAzDYmQ/BhjNuBptWu9JOnTbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqeJc758; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqeJc758"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4955c545a94so1459525e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785426785; x=1786031585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llV+7vajoOu21zsyKEPa5kePWTMyBf+D//kaJbKHIs0=;
        b=DqeJc758S+U2hT2jjoH5rBKUwsnqrpk7UePXBpHEY7bd2e/8pi4ixfwKKNasXYjWsW
         pm95qM1nSFDECRCZWup4oNe/Kn4rb/7eT+8X/ArWfLoAgEO8VuIdhdVDwOOI8uO6XD/x
         MKAd2EHAUCNiQsJW/ma0+ea4IiTsq8Sxv5Kb5S97aBch30KtJ8GTOoBkY2FAn2bHc7Ym
         kXV6PdrOUcmZ7gFZID1vka1/1NL+1pdWRnsay0nbMgUa7ZqG7YpJSv8CYI1Hg12gh0Zx
         yndrzsYurKO3gvN1fq/nCs9Su1ygqOhYvIeJOiSllNmu/uwB+VuaOGTTuP50tGixOPdj
         xWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785426785; x=1786031585;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=llV+7vajoOu21zsyKEPa5kePWTMyBf+D//kaJbKHIs0=;
        b=chEPy67BcJ7axRAQNioPOFiCqH9HT4mF805xv57348RKtFSYWSkk9yeJianY6q2YpT
         dFl6WRd5hDUL2xYMzJGTUpj1ywM8v57Heo035naywT9vcZCK8v0tKA2N3sZUEz4+rOxn
         m7nB1l5FYlI10S4Tdj8H+CE+xc4NUiNddEWgURl8MxThCZq/Mz6bLDMTUQad/VJBjZVF
         XXt6dEdrm5t9EaSpkaEpvfuoxEwNsWpqw9i8qsglXBL/qGxuPvUrkcRznAJeMHWz0RIm
         2BwtUERRHAgixmbYCbpNYVTx6NkGfHwuXD3hQJopZk5UlznyWYimjc8/mwQLUuWqWFH7
         PXBw==
X-Gm-Message-State: AOJu0Yx5LomJRFcaxnrPYdzoXLNOQmzkMYMgc32xwz7ujix1x62ZzQEe
	wNERuSdiH6QlT5qNYuM5miZ4v8khZ4KmD7HCwXec9eb6NhoW44LwaOXv
X-Gm-Gg: AR+sD11B/BDtAgAzAHU8ghodHthnguWwnv/FwGKprYXqNfMAdNWYq1zC9z/L96Jp4h3
	8VEhutl+zdyd30sits5Y8T9a9wmPEDKW7NuRl0gQeNdypGrtvJKzYgwaVzfoNIzFJAUF+uIZ4Qw
	9mMukTducoTqKeDyqjsjZu0X4cE53G4z5Ru4FrCw7MeCN5jahjlbsxzBXyc5Lchp+qVU6kpbAem
	bci4toYaKMVjGbzOuHX3E46eEtQYG1aWbKFw9IHEXre3VfbGyw7u6XyPQvhVibM1jswDPmZWGhr
	rcfECub00+XtK6l5+IlDWiT49cOMVOCv+aAPHRug8LaW9BsZ2noBFfr86cMvnuqASnrjn7yXPdJ
	oHVbzxMMV7uL72h37EuFPFmFzEF71Fvxnyx7tZ+ElMQ+rWjtfbQ+OPzjl1PmzqMJBulYwz5s723
	rk0k5O285mHj+EclfNmc3oGJzHBEQqamEFjKMqjzgmaPhI+Ddi7PFGdcoOvFo8mLUkGimxZNBno
	C/wEAzLRoyX0kQm2ScTRf9ghUVEp3enAAHKuZhGyG/4gjaqZdsNsYeMHP/zRXS5gdm2FfKboKRo
	Xj2XGRzk+3o=
X-Received: by 2002:a05:600c:3105:b0:495:4505:dad0 with SMTP id 5b1f17b1804b1-49804c442fbmr16212615e9.2.1785426785328;
        Thu, 30 Jul 2026 08:53:05 -0700 (PDT)
Received: from [192.168.2.69] (dynamic-078-051-177-165.78.51.pool.telefonica.de. [78.51.177.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011fec37sm67692795e9.9.2026.07.30.08.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:53:04 -0700 (PDT)
Message-ID: <67cf57e7-37d8-4995-9a8b-b4a48c750c9d@gmail.com>
Date: Thu, 30 Jul 2026 17:53:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/4] net: hsr: fix packet drops caused by GRO
 superpackets
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
 fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, stable@vger.kernel.org
References: <20260724161253.79-2-xiexinet@gmail.com>
 <20260730144653.147367-1-horms@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
In-Reply-To: <20260730144653.147367-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2026 16:46, Simon Horman wrote:
> [Severity: High]
> Does this one-time modification of wanted_features prevent userspace from
> subsequently re-enabling GRO?
> 
> Since NETIF_F_GRO and NETIF_F_GRO_HW are not included in the
> NETIF_F_UPPER_DISABLES macro definition in include/linux/netdev_features.h,
> would netdev_sync_upper_features() and netdev_sync_lower_features() fail
> to enforce the disabled state on lower devices during features recalculation?
> 
> Could an administrator run ethtool -K eth0 gro on (or add a new physical
> device to an intermediate upper device already enslaved to HSR) to bypass
> this restriction and cause the HSR packet drops to resurface?
The review is correct that dev_disable_gro() is setup-time enforcement, not an immutable policy. Clearing wanted_features prevents an ordinary feature recalculation from restoring GRO, but a privileged administrator can explicitly request it again with ethtool. Adding a new lower device below an already enslaved stacked device can similarly escape the recursive setup-time walk.

I did not add GRO to NETIF_F_UPPER_DISABLES because that is a generic upper/lower feature rule. It would make an upper device which does not advertise GRO disable GRO on all of its lowers, well beyond HSR/PRP. That seems too broad for this fix.

Patch 3 is the second line of defense. Even if GRO is explicitly re-enabled, no GSO super-packet is forwarded as one HSR/PRP frame. Plain Ethernet GSO packets from the master or interlink are unfolded and each segment receives its own tag and sequence number. GSO packets from an HSR/PRP LAN slave are rejected because software cannot reconstruct their individual HSR tags or PRP RCTs. Patch 2 makes the segmentation path practical by moving the expensive work outside seqnr_lock; it is not itself an additional GRO guard.

The two layers therefore have different roles: patch 1 establishes the safe default when a port is enslaved, while patch 3 guarantees fail-safe handling if a super-packet nevertheless reaches the forward path. An administrator override can still cause packet loss on LAN ingress, but it cannot make an aggregate bypass the per-frame forwarding invariant.

 
--
Xin
