Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404F3D093E
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539872; cv=none; b=IKUOOZDj36F/9Y8A9sVUHxMRbOgQSqsG4CDE+YpMe9c5HErDyG0Aoc67zju/3cHKRHJIrfCpL+FVKahA7ORawfN27B1wPY8hOmKjmvI1xNi9aJ9zwRb1/+ahKQjXs6fYLuLm191etDJ/B9oE88Z8oHoCmBkWyFys6jF8e3JbxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539872; c=relaxed/simple;
	bh=BxnKu8vNtsYLiK5ravYlLTKTjAKTsC6um00fkLnSK3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0IxZSZ8zn1pV+TJU3c7u56z6lHAnSaRsgT58547Sk/Z5enFq/xzPZ9GcLBXVxZtIEptnwQHo/G2b7qqiM43uXETGxOBZtQQEFIAkScPkEeLbBJAR3Jx6H1CKuYwLrocYo2NvwaK+V6Ndys0VLY8GLsuweITQPCMzlUDbj5Fm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JPMX0ygR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JPMX0ygR"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso10952275e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784539869; x=1785144669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pW1JswRc46/DemocbXNde6KLd1ZN2Gsh0169WW0rnNE=;
        b=JPMX0ygRY3DiWr3yA4BZYkOmufX6LmcD8k3UEoiNNwj1v3hI9dKKOM/gujbTKJFqzg
         iWI11ktjas6UVFw/8abNpE3RuBtkpD6H72+KKWgZcRJtzSt2o4+3faRe9kEEDk0LQTqb
         ng5Nj+ZZGZFnvN1MPJ9IBFxdmbKVLf3YtZ36aNcwixzpUCSWJl3PcL16S018ghEoq3lR
         QhyKFE0t+fVsowp46+qpW6I1E9Ph+hGN2hEtPL//q/82ZX8W68yONgi+WJbBHUFk//tj
         lvTkafWyt6D9Aq603UcIAPMTVo7//NOs7j2XX272v5cvC9t+Fvk7iQcIMoxs9GDJFyGk
         wNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539869; x=1785144669;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pW1JswRc46/DemocbXNde6KLd1ZN2Gsh0169WW0rnNE=;
        b=ZpSmeN/pmU75cjXhnTbDin2T0jGs3CPPq6T07GFQEUtA0RwZM49zvTbKKDdvfg8Z4l
         OV9B+PPGcVdcBxG2qVGqtvX5xZjNYdv+ZRAOYT7d1x+DKL3ixivzC/wnHFhsC+xHUavW
         t7DHTflMJR4QULHyJMghZ6cdyQuZRBS8hDgxBrqWokVT1FxetJo5kp9RapwRbXg2l5am
         JSI91HEFCDpeuNWFVvK837fACZe4jxFZ2pC5ZlP/LPfoePF+n7Fx11L+LbNUo60BPxMH
         RaD0WgFIPFJiZ2X565LHog9R42ZGFBtDO5+L5Sh6p023DbyLsc1jMckwFqC/LWKTCGV2
         EOXw==
X-Forwarded-Encrypted: i=1; AHgh+RrIkXTjZYtTPX6PhqzmHsb7KyM6+Yc77qadnVcLbpyH2bFsCvYwvWb9zPSut6Sn7Df36XTUulk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ufAgc3COVUPR3Fg62q2ib2ux/f8lJo+J9acDMBjlOuFUTmJI
	bTBRmmPsSmwdPhRHv+icfMwPuH7jQ1Ysij/YlvBeAOSH+3htLf9Qw8tmPHSPiD0nXdg=
X-Gm-Gg: AfdE7ckpp18S9I2w3dAD4p/dYxKbo7uwKix+mc4LtTvhRIIkbA2Hd0nFAtjrpXeQD0A
	ubbg9BbzJe6/feWAbQreI7xLXo26I/wcxC2nri32ET09YyD8vmZdvXJRSKnXK227GnUXetZGQtA
	TeH5Im1c/kS3vGXCXmUI32VspFiDRtvk6w5zd9ImZr+5ew0PGWjFGleJeqfpDtvzfn5qzeMoSw+
	wbRvEivtAc5ghDBFzIySnNEE7K0C/uz7kYb3pX2DBJdDAn757pDJJhanUax1fMJUh3B1u+pB78e
	ootKEHEyxljucvVOaMIkj1MGvEdTRSJoYbESHcrOuTX7hrkGMHqPL0J9+y7vY19oQ+KILpRDCim
	sVnUgUHa26SOj0coizhRp1dg5VpZcJhFLkpMLKQuJZAxAQrL3vp80mqcvxNgZDOh2SKt0DoWAr3
	BkJq+yErzx7Bn906yWhtSCfB3QmoKzNToG
X-Received: by 2002:a05:600c:45d5:b0:495:4056:9473 with SMTP id 5b1f17b1804b1-4954a40d0c3mr144465725e9.28.1784539868617;
        Mon, 20 Jul 2026 02:31:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm252362295e9.13.2026.07.20.02.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:31:08 -0700 (PDT)
Message-ID: <ad48b1da-50bd-4b79-943a-0a3331191b7c@blackwall.org>
Date: Mon, 20 Jul 2026 12:31:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] bridge: Validate and clean up IPv6 neighbour
 suppression
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> The bridge implements IPv6 neighbour suppression by snooping Neighbour
> Solicitation and Neighbour Advertisement messages, but it previously only
> checked the ICMPv6 type and code before acting on them. This leaves it
> open to acting on malformed or spoofed packets that any RFC 4861 compliant
> node should reject, and the option parsing in br_nd_send() open-codes a
> loop that has historically been a source of bugs.
> 
> This series hardens and cleans up that path:
> 
> Add ndisc_check_ns_na(), a standalone NS/NA validator modeled after
> ipv6_mc_check_mld(), implementing the RFC 4861 section 7.1.1 / 7.1.2
> mandatory receive checks (hop limit, checksum, code, length, target and
> option validation). Wire the bridge into it so NS/NA messages are
> validated to the same standard MLD already enjoys.
> 
> Replace the manual ND option parsing loop in br_nd_send() with
> ndisc_parse_options() and ndisc_opt_addr_data(), and linearize the skb
> once it has been validated as an NS/NA message so that this and any future
> ND message handling operate on a linear buffer. The first patch is a small
> preparatory cleanup that drops the now-unnecessary skb_header_pointer()
> fallback from br_is_nd_neigh_msg().
> 
> No functional change is intended for well-formed packets.
> 
> Patchset overview:
> Patch #1: drop the skb_header_pointer() fallback.
> Patches #2-#3: add ndisc_check_ns_na() and validate NS/NA with it.
> Patch #4: linearize once the ND message type is validated.
> Patch #5: parse options via ndisc_parse_options().
> 
> Danielle Ratson (5):
>    bridge: Use direct pointer in br_is_nd_neigh_msg()
>    ipv6: ndisc: Add ndisc_check_ns_na() validation helper
>    bridge: Validate NS/NA messages using ndisc_check_ns_na()
>    bridge: Linearize skb once the ND message type is validated
>    bridge: Use ndisc_parse_options() to parse ND options in br_nd_send()
> 
>   include/net/ndisc.h          |   2 +
>   net/bridge/br_arp_nd_proxy.c |  54 +++++-----
>   net/bridge/br_device.c       |   4 +-
>   net/bridge/br_input.c        |   4 +-
>   net/bridge/br_private.h      |   2 +-
>   net/ipv6/Makefile            |   2 +-
>   net/ipv6/ndisc.c             |   1 +
>   net/ipv6/ndisc_snoop.c       | 190 +++++++++++++++++++++++++++++++++++
>   8 files changed, 224 insertions(+), 35 deletions(-)
>   create mode 100644 net/ipv6/ndisc_snoop.c
> 

Nice set, but I'm curious - any reason not to use EXPORT_SYMBOL_GPL() instead?

Cheers,
  Nik

