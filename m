Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6A357D0C
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402755; cv=none; b=OxvYnsC8rUM+aFddkaVYwjiIfvgnvGvTQQC6Pz/YvfNdGoKeXH6oYcDAsl9Vgo7AcK+khhcm4VUhror+kSM5fyi7lO9/8NZv9pMFEoXk3XZk7nPe+R2wwcipR1H/pZ3ouOY1/DoAXd4Bkbi56/dFh0ABkGWtWE6PRR+bQivBRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402755; c=relaxed/simple;
	bh=CYyCugj7UJuCGWM+5VaagQgPdwhTxxh8qGLX7cMsOps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLaxYGqQUh9D0Gq7pSr4oqDl2sy3MF/wEmj3zjkO0+CohR4r7/xiDJ5oE/OEYfteuSXpfKv6SBHcywN+C8JhZjp6CanbNv7o2oxvye4SpDy0Zp6nbORROEhq6jV+DQ+ubABU5exdTZi5rzg2QmVml5SwwxVP3Cn8sWy0u2XMexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia2c2cio; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia2c2cio"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-39ded0d7f52so599892a91.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789402754; x=1790007554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SeJCWkMK8xHsiSZXR1cWQEth7bGh7tFwjmeGMzJQYvY=;
        b=Ia2c2cio4hoLNZnZofkB1ZYve9ozFQMcAQuWFPOnJAE2lFqGPABDSYgqiifzihScTq
         BX5vK3vrO64Vz1hmzEuopkBWUun44g9kkEdtcB5fw69pM5djHyKwMq4TnvNKGNEFDCk8
         gGSV6grxiE1xsQ/EzoVIdEqoK77NrjwyVaz8GbFGtDobDiW5YlRzRAtafds+Pz7jvRCC
         46ERk4ruIeW3Zwew1Rfp54HWBHF0F8H+Qcqy16kCQXE2WqKVWGp3YPt1U3S39mw91/Ap
         NlNGoD72g69cI1hk4xGDAK3XJIvVl+0i+pQkGjli+dS0WPqLPMiEwuQltLH4dL15AcHy
         tveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789402754; x=1790007554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeJCWkMK8xHsiSZXR1cWQEth7bGh7tFwjmeGMzJQYvY=;
        b=O3IcgEmfOUaHBaM8RZYCbQDmkvAlPgzs3SY8oeHVFTnQS/Rey4HHJ0I26cwzNrP+S1
         ChSmIyB2Tb6vmwkzXJPbRQhBZEFaDuJooQ78/lPlJAg6aJvxwsOuJINqtj79tMMKMab0
         PLJBpvEvLM3XJUy/NIqn1W/OirQBdcTYpSYAR2ZmUXPbNj2z0bKP8Mrz1whZgkeqFS5r
         Azg99CzOXPR/nxGmUT9NkqmgkF/PDLLacGl9ZOyYo7Wlb0l9e3eYFpDzBoU7NLL8WaZ9
         GPuU3HLVxM0FkP1AhlY826oIZFtTeDgpk8AvMkKXH0+HUK+uwOriI3RvRNJByLktW0Kb
         C5SA==
X-Forwarded-Encrypted: i=1; AKwUvBz2IO1V2xnqLs+jDt6LMmtk2SbCRvChjpjmKXTzOwCJYpa7b/Xw5/eLBQvmRWBjGXET5eL57xg=@vger.kernel.org
X-Gm-Message-State: AFuF++mycsde+fJQLsHt57gq6OFJE6+CYFXeNVC7whOISK1G2n15KEj0
	Pr4o9AAnJacKvmLN3Qwu5NMjag5luH/B1/9ZmoGgjEt7fMiWERwoxdIrkMH0ZRBj
X-Gm-Gg: AYBFou0/M+k07KLcojwsCshWdmWyQdjo5RQ9KTp0/TFSiJrELZ/Tdu3Xh3dtBr4W/oF
	x5c3QdiDPETdUS/Ae70T4AxiToCgGMlXWw2aKhA1kN7tr41KLlQPpdEU8LR8RdNhDnm+l0EL3h1
	94sa5IWdXRNSJvfpFdpD1JZL47oRTz2Pxs0CsY2YkfFjZAQy+ChZ7vvVAaSKT++rwQNN9FgVjGQ
	ECK3YrmrkymKZf/TLV4JiKu/6k3Vq+W/bYVhcw0SDoWv8yw3PE6Jr69s4KWtJ3OPsBou9/vH1HX
	L4mo+7y77mwgAYk85H1s797R3m09FJUstHzS8rt5YN5oLWRNdIaBmqglBw71DazD8p/Q72W+HDj
	Fw5YK9toVg/FwMdHPxmKfSGo5aWXSQRJgY3WbFsWLZF0VrLYsYIiUeKnVAgzsRfWNkqfLcSodf9
	xrs6adTzuwP7f421vTcE+oRavAlZX1i2XrUUaGiO8A3Xmty3UGWqbsLQodIGj5D78n
X-Received: by 2002:a17:90b:2885:b0:398:9be5:b419 with SMTP id 98e67ed59e1d1-39dec0bf165mr7016294a91.20.1789402753588;
        Mon, 14 Sep 2026 09:19:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd7545asm177494a91.14.2026.09.14.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:19:13 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:19:01 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/2] net: a sockopt_t quirk for the options
 that write past optlen
Message-ID: <aqgebMiCaU3i3YJ6@devvm7509.cco0.facebook.com>
References: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>

On 09/14, Breno Leitao wrote:
> This series continues the migration of our protocols to sockopt_t, as
> described in [1].
> 
> There are some protocols that use optlen as the header size, and the real
> buffer size comes from a field inside the header. This means a bug, given
> that optlen should be the full buffer size, but there are indications [2]
> that we have programs that use the bad behaviour above, and we want to
> avoid breaking them (or, honestly, avoid being cursed by Linus).
> 
> That said, create a quirk helper that preserves the same behaviour, even
> using sockopt_t. The way to do it is simple:
> 
> 1) Only do it for userspace callers (ubuf), otherwise a bug here will
>    corrupt the kernel instead of a simple SIGSEGV.
> 2) Expand optval mid-air based on the header field.
> 
> IP_MSFILTER is the first user, and the smallest one: a single caller, no
> compat variant, and a reply written front to back. MCAST_MSFILTER on ipv4
> and ipv6 comes next, and TCP_AO_GET_KEYS has the same shape. Do this
> quirk on IP_MSFILTER to make sure the dynamic is ok, so, we can expand
> it later.
> 
> None of this is meant to change what userspace sees.
> 
> Link: https://lore.kernel.org/all/20260401-getsockopt-v2-0-611df6771aff@debian.org/ [1]
> Link: https://lore.kernel.org/all/20260806-mcast_fix-v1-0-bed0a5518e57@debian.org/ [2]
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - sockopt_expand_out() measures the request against opt->optlen instead
>   of the iterator's remaining count, and asserts that nothing has been
>   written through iter_out yet. Comparing against the remaining count
>   made the verdict depend on how far a callback had already got, and a
>   late call would rewind the write cursor to the head of optval.
> - Cap the requested size at INT_MAX, since optlen and the getsockopt ABI
>   are int.
> - do_ip_getsockopt() writes optlen back only when ip_mc_msfget()
>   succeeded. Without the guard, a read-only optlen turned -EINVAL,
>   -ENODEV and -EADDRNOTAVAIL into -EFAULT.
> - Name IP_MSFILTER in patch 1, document the WARN_ON_ONCE() and that no
>   in-tree path reaches it, and mention sockptr_to_sockopt() losing its
>   static.
> - Link to v1: https://patch.msgid.link/20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
