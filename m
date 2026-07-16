Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E23BD241
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195424; cv=none; b=fYr6DH0eb/TLNhWeaOtKqa+04WPiPNTR4IOB4g3PoT0WTDUX2RnW4DsXzzP5UJ+GmFCeL7K0erGWkIdyRCoblgZXGQGC9FmDVCvAxjt/lee9bsWE9Q+B82cd/yMuWXuBoSNDMK+vc1VB5Ad2ZGX9/YtoWFBlOA9CExW4ieFlq+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195424; c=relaxed/simple;
	bh=IzGzR/B96zXUnP9cL57RRWHsGIwMJ5kA2saL/V+YkVk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=U8nCE7GeWuAxZLN7dVOVDmg3NIvtQ65OuO8CDF9d/UIapTB1M3+1r9DB33VtRb50LcVcmkAOxDrWPG84OSwjwnJ+nEjrm1uiC/OnVLV98QQ8MBOSYF2Looh6j0a+ANQ6P1/MCV2Nd8VcyR4Ac3TbqPyHNpkZwJSs+kvavK0xpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk3zhNIL; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk3zhNIL"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80cebd41372so62047577b3.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784195422; x=1784800222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X0WBqVpTS1/SYj2ne64/eCxZslQII8DxYl3xDAKI+5c=;
        b=mk3zhNILfOmL8UcQ4HNCMKJxVZgtVvgMjSZ55s1RhCqQw/sfdhMVZNNRD1XYDOI7gX
         kJALn9QaVDtF4+KYbrfWKP06GgEFjlL87J9O0qTkl+82oA6odJlpx81nUtydWquyQk9J
         hmEN9X0FKDr8i6J3po5C5Yuu9EdTuhoXxZWZF4ipjyjv3RoEkc8EjhqMgAEJDkdEp7kj
         MX/JWy2Tdz/OLm+jVD07avjjEHxxvYBjlG4mTrWLfGhhlD87f5Q8s+g52Hfnm+/nK8q9
         euMAHE7XFczOUFRF0B6zWBMksKloNs14YckIIRuZurwfRPjqjG6/EXAPJ5fp6i2KgpQu
         JYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784195422; x=1784800222;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0WBqVpTS1/SYj2ne64/eCxZslQII8DxYl3xDAKI+5c=;
        b=bgZfKFyUiw85wNk9JeL+3Yzpb7meAL2bUoAWu4X/gqyNX78eR63VNAPxu5yq9Pa9s6
         LLG09ti+eI3sG9nSryUHweJ6BAWfl6XVzMxs3uhzJlzMIE/1ItB7qkP2qYwLp7L8gRZx
         4UDFepRaowBIK6kOE0ErsXLW8BvvJmB9DZeE2ajGnCGMAjrvZg4GTPfzXiEJ5CIEq9FL
         Mv81daZQyf9VV1NPDxGNz1nCYKxMFIcZzVr/s5vKCqpwfHml086OMW84fb5/aNeJU+yF
         hmOGynA3fbChDszMquA3J0/agtmjippblSi0plvxNl3qMxjvtSoAuxNPEPYicKJtxjFi
         HeXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaNa/gcKvrMpN3PT+m4/0rPDPfjtTRoqiprd+Y3XX1WF0bqzKuEee8SZuIWMM3OgSVwrBBLbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiu1VQVqxERC2zDk8twd2Zt3+/UGMlv8qd1oaaoa+63iXTses
	jMkaaThstvtUeCn7Gj6vsbqb3Sjg0byZY332XFbXe2FIED6du+8CTWvm
X-Gm-Gg: AfdE7clp26nw9H7g53KL6D93yGt96IBZSTQHG+o/BulwMVPpUPA3xr2gnBRybQdCX5c
	i+3qIiFmbbvYWpkTwLkLLLISFOXGLouQNvwB3P5ja7aFiX1tSoPGRK17NpPlJmciL6vUJ/phTya
	D+SH+o/n/lNY1WBdbU+eW/nvz1hpTnDFdEi985KoRaLEkdT4g8NzgpjJaDZADd3f9ZzDT7Qs5hs
	bpsNIecDZlel8zWjK0o5Una102LOH7k/13bHeE6PRr9yMSeNXfIuo2vDhnCCOSNjIwlYOaoZmkC
	5OuzDYBR1wyZ1teBEZ0Z6KdOIvwyHCMlnNaKH57wTr959oVDxzrDhKHiyN/XXZMUeePcaaM1bGu
	u94LVEuVMTXnltsWgI/AiA/+LB52gj0Cynqv8spEJ/WKmNypu3/68e2oP+o4Nffs86Uw/6nk8LV
	O8HN26M9A4FEMwJ1ETYlMgPItAKjvNTpaanPiPYFkpLy3N23uLWLebkzo=
X-Received: by 2002:a05:690c:9519:b0:81e:d8ec:d86d with SMTP id 00721157ae682-81ed8ecdb1emr28639267b3.2.1784195422483;
        Thu, 16 Jul 2026 02:50:22 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1a44d6sm192511277b3.31.2026.07.16.02.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:50:21 -0700 (PDT)
Date: Thu, 16 Jul 2026 05:50:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Dave Seddon <dave.seddon.ca@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Tom Herbert <tom@herbertland.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org, 
 Dave Seddon <dave.seddon.ca@gmail.com>
Message-ID: <willemdebruijn.kernel.c1b4383fb19c@gmail.com>
In-Reply-To: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
References: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
Subject: Re: [PATCH net-next v1 00/11] net: flow_dissector: opt-in
 byte-identical fast paths for common shapes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dave Seddon wrote:
> G'day,
> 
> __skb_flow_dissect() parses packet headers with a generic protocol-graph
> parser. The graph walk is what makes the dissector so flexible, but most
> machines spend that flexibility on the same traffic all day long: plain
> eth + IPv4/IPv6 + TCP/UDP, perhaps with a VLAN tag or a tunnel header in
> front. The intuition behind this series is that the common shapes can be
> dissected by straight-line code instead, without giving up the graph
> walk for everything else.
> 
> Concretely: the series adds an opt-in, static-branch-gated fast path per
> packet shape, covering the common cases and the IP-in-IP/GRE
> encapsulations. Each shape has its own gate under
> /proc/sys/net/flow_dissector/, every gate is disabled by default, and
> when a gate is off its added cost is one not-taken branch per dissect.
> The gates are manual in this series; a follow-up RFC will propose an
> optional auto mode that flips them from the measured traffic mix (via
> the patch-8 counters), so nobody has to hand-tune seven knobs
> (eth_ip, vlan, qinq, pppoe, mpls, ipip, gre). Nothing
> here depends on it -- it is where this is heading, not a prerequisite.

> Relationship to the BPF flow dissector
> ======================================
> The fast path is invoked strictly after the netns BPF flow dissector
> hook in __skb_flow_dissect(): if a program is attached and returns any
> verdict other than BPF_FLOW_DISSECTOR_CONTINUE, the function returns
> before flow_dissect_fast() is reached. Attached BPF dissectors therefore
> always take precedence, and a system running one sees bit-for-bit
> unchanged behaviour from this series (patch 1 additionally makes its
> program lookup cheaper for everyone else). Dissects fully handled by a
> BPF program are deliberately not counted in
> /proc/net/flow_dissector_stats (patch 8).
> 
> The gates are global (a static key patches code shared by every netns);
> per-netns dissector policy already has a mechanism -- the netns BPF
> flow dissector -- and it keeps full precedence here.

This series adds a lot of code: +2500 LoC.

If you want a linear fast path, the BPF dissector offers that.

I don't think the purported benefit justifies the significant new
code, I'm afraid.

The code is duplicative of existing paths, so there may be additional
maintenance cost keeping the two consistent.

And which paths justify a fast paths and which do not is highly
subjective. Why is GRE included, for instance?
