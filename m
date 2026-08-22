Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A822931FB
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787424098; cv=none; b=EwXDNj1QTOU4s2KBBbWsx9/gm0wGt2/9oqrYKr6IDcX/XI1WP0KEVup9wu9IBiLYhhBpKSeJl4EjqtP0c40g3R4u5vrGm1HPfLdswcwLf3VPMr0X6CMJ7tZ93PgERMxmgr7aXe8wrFkf83e7jL/fgwbIeAsbX2YHHSLbeeD61Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787424098; c=relaxed/simple;
	bh=iRiDS5/jrxEd5xw31AJdfUGuWr17uHAWSnZjldo72B8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iO6Rg263+LfObAW9OOrM+Jai1fp0QH0CwKYdmfI5YipnVFMTnraEANf7hZVu8aYjkYp6EZ8c4TfhRrvURtjb1fUyTaUlQ96BEKN8ps/41TqRMUIoofgXOmt7QtNAPMwQbU93qyOZZIGMisM0pbJt0SwwgofMVo3wI+KEW5aHMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV2THt9/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV2THt9/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8200ca16f26so31450747b3.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787424096; x=1788028896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pIGukARc6FHAKLoVYPaAGIp8bI73xdZO1uyFXBaoVME=;
        b=KV2THt9/CADnC1m+1b62ZZQzrlUgpPJNRX28Ljb4EEQhQIsnQuAQNJ6LALf3tvWnwp
         ZRHSWHXKJeMCijCHbLPPy85rkZ3KPRk7fMsQBr281tO+NP5i0JO8sEG7wok42Z/XyFts
         3esIohSp4yWBnTNTWEU5rc0b1ANOgZxtdewfvYC/LaQ9crFbLqw/gDMgcWecNkdvyrmr
         g6HkjCDEFKfoia4oxDdjox9jHHmGzYbpUTzH2UxLSeA9ZVIArOWKgqWGLDooMps0y+XZ
         GbHxv8SCaQySR8BekvMFtRoKXFHe5fwthxpYc8jNI1jJoac9lZyQxXeqm3UofCTf0IKy
         4I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787424096; x=1788028896;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIGukARc6FHAKLoVYPaAGIp8bI73xdZO1uyFXBaoVME=;
        b=VThLoMOORHzgPQmQRlK6qn+rx1WXDADyFvmMjnUg8yPtDofBfGcVSYTVl+IWvWyptJ
         jBa1An+ZH/W6sxXaqK8rPJVW9Jxp+nBaGyqTb4C6YhO8F0Kp0YR32t2g9QLcAeK/HilV
         ruXBYs5HRGuI0EBwgKs+Ugc1s9p25kGe6azRmRRslnzzTDcu2Vg1/yUa4Q/qGJPjjCbT
         2opcxvpTlsl13rtaZIigucE44Eedk2tWqdC4dVNFcytTQ5HVU+Vjdh11A6KSJOGrCszF
         cnm+x1IeZHxgD2iLL4I9q2CtcS4OamhIQCy0OARfS+OuTcGgnnEx1xdJFe0nG3EqaDdA
         zu2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpfXQKHkx4MUi7rKtOjY2Gxm40FG5TF3UQU2NChJMZc11nco0KyX1uUg199ZLKtwaBG1vPRjX8=@vger.kernel.org
X-Gm-Message-State: AFuF++mxb9MCEEDkuzKcW08xr/Np5W32ffatjgROf4scVO3xHnLvSnSs
	rYH53uxuDQ/t5LU9U9acfQjMqFFsovzddDJgrL0jlxhssBt1DGBrk3Gh
X-Gm-Gg: AR+sD13bK3lWf6vO8Ig1LFwsmNoyyVWwJHScVQqlfCFjNMEjDDll5uDdTkZY5ydvlZ2
	UTqb3LSw3orLpSCdkwHCqu0P7GplpqdeDzP6HZ/M/f6MoSVOxHqK5q9MFF7jKTprqi76DuD0lSQ
	SDNF0Xy+QgCAIWwWpf+T5JEju+YuBqX4qaBMhNzQOOnrmcFUkcoyWcp4M971FX5W0CaP/0WZoR2
	ZePPVA0WmDhH+XtI4cv+KbGpMawjUDtWX0MHZeHQjOJXNywYsU+6QvtoYHQelvpEitrnQxFlDu3
	KuJH0FOD3hEuT0tfaCUUagdJ7HvSckHZcqgg0KQp7L2PX3fNDDXhFZGMbYZX8YwUciSSTLF3J1U
	/vjEDdNsu/1XfBPgZVAqp3WaoE7WhaqHY63NaEN6DUl+3EKLM4zRKTn4mIAqSAB8+pEKpQz7Ha4
	MneHYOjkvFoZc3GwqsOIxwwTCUtXjhjRE1i00b3Ae24OAfiHXY0NpzRAvQPeEaYOPO4UdjD98rf
	08Iucg3HhYqsw8sg/OsL8waE/S2hkvx9N0KT9uy/A==
X-Received: by 2002:a05:690c:e1dc:20b0:7db:ccda:a40d with SMTP id 00721157ae682-849f01479c1mr47272297b3.5.1787424095754;
        Sat, 22 Aug 2026 11:41:35 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca68c1b14sm13427547b3.21.2026.08.22.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 11:41:35 -0700 (PDT)
Date: Sat, 22 Aug 2026 14:41:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 netdev@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>
Message-ID: <willemdebruijn.kernel.28e276abec867@gmail.com>
In-Reply-To: <20260822115717.1161782-5-alice.kernel@fastmail.im>
References: <20260822115717.1161782-1-alice.kernel@fastmail.im>
 <20260822115717.1161782-5-alice.kernel@fastmail.im>
Subject: Re: [PATCH net v3 4/4] net: ipv6: Clamp to IP6_MAX_MTU in
 ip6_dst_mtu_maybe_forward
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Commit 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
> dropped the IP6_MAX_MTU clamp that used to be present in ip6_mtu(). A
> similar IPv4 commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
> ip_dst_mtu_maybe_forward") preserves the IP_MAX_MTU clamp.
> 
> Restore the upper bound in the IPv6 flow to avoid potential 16-bit
> overflows in forwarding paths.
> 
> Fixes: 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
