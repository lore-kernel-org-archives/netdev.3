Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DE49B210
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142205; cv=none; b=nW57KQPQQoxSS9fAPzJTMPiELAYHvhPvgZB3QbV30Rd5A6vmXI4+ZANubBeQPkYHg9dmjD1W7Jpc/R5yJrLygNhft/9944by26P42JDI+ZJ4JbYE1kYVRGCktmAr8LR1KBQc8IrPbq3diZQAF/Ka/TZibmGPVckbnl8SUkCMsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142205; c=relaxed/simple;
	bh=z7V/g1g0y9+9R0BptqO0kSLqVcR+bETnnnZCPJ7Ec7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNPKzg46Vcvo42fzRFzRSM8o7Q61Iu0qN2jdd3lg8F/DUZ/oWMVPXrSbA8mQAUxSBvxAqxExHul9cRVCB4EvDBcSpkcc4wwEm6+MODMkvFk5gP5MGb6RSNqAHD1+7djlxLUEu7qqoSgRudhgouj6x6S/Ixi/6u3lEF4qBtKAD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnSLvA8g; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnSLvA8g"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so667332a91.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789142202; x=1789747002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xdPDE+ElPkzxctjwVXaTUQqhszvTbAvyW6hsARO8f1Q=;
        b=OnSLvA8gceT1AsuvnrJZKK6/1KyAt5PdsA6M0wrmaHMdC9vHTXCDYjO8bl0+fkNwEB
         M0p9InB+UWCB8CCqMByS13bOokXX5CN0NdcwTKSB/fLDiy5T/WGu9yZSeJQzy59m66AN
         Gulgx6XqyFcCoaynfO7ZTU2az6TYJ8C+fXGTbF4vtqt5wuK6y0H1L6AsL87ULiwGMEP/
         QWk/jierG+Sz7KDJ/lvVUXMUuByx/p81RN1XLbuLe94NvfS222G6BYV4/HeyB0g6caRy
         z6ngg9eDKwF/+KetMtnF3uo8IeCm1px6YT5Uq35Y7e21vpkRMQ5t5ObGdP+cRXHtiofI
         wanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142202; x=1789747002;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdPDE+ElPkzxctjwVXaTUQqhszvTbAvyW6hsARO8f1Q=;
        b=h4nAyRfR3nikvCQPepViMQBhEK4wIVbnwZSdGB51WtPndeMh11CYB8yBZHnoR7LrsD
         nrUq0mOjqX7A4OoVUmNq1KvbjUlyDefkJUIx1+0vKQgAt0I8yu8HjQ3fvMtJzpoMhsP/
         Nh7ppzZsfgcaHsm9bwMJsRYeckoz8PyMfPPRFTvwB/aOp8Kk/bBpxpn5mKIagJuzz09T
         eEJ3PegijYBcThtghrbgZGQDeFrkhoO+np21igPAvl1el7+G+Nyvl0y6KDns+Krpm83m
         1lx8qUcDsE+Y6bUgaBVPgZ7imy8EnzCQWxb48lJFLlR7stWG4JW6Jh165N8WbSiIr/jX
         AbMg==
X-Forwarded-Encrypted: i=1; AKwUvBweUufO8Khi4yC/AXxFivdfrmqua998sXYjrYpVQlFdVqoTecwsbd4WQnj1rmOT/g7O7M7Z5lM=@vger.kernel.org
X-Gm-Message-State: AFuF++lKpj/2Fz2qCN2l4OAucgr2Plel0J3xC0ft3gvK/34LPYnu7eL9
	qS2PhS7ZC01cBPyw8R3jndYxzHWccrlZW69idys0+mF5u19sYR0qIZzM
X-Gm-Gg: AYBFou0UnQSyoOTMT5oQs1IrP7nzKW4XYfBYT2T6Fc6fopndKffovnisF8u+XnH2pRA
	tL6wu0WKbpFuR1APoiz+PS018iKOPXvmQCzUZZjCOp67IaNVb4xGcefHmJUfBg+OixNVgJiGoFE
	SyK0aKK846BXoij3vyVs8qPaDC9sFVIF9tsTc3auSjbTSGt2xb/nf7/xJP9E2+fiUCPRSa9Wp2I
	j0K//fjeEl1+LGvZaMDbshMFZ0vf2KkxZoBsVXnTpi+RzZymjG07BVO0G/taZpz+tTKR0bXwXQD
	c3w/Adq7o9SHCfiEmaTZo3MMkSJddP4ewRH4wi17sej2Fn3TdlL3ngLpSQcHX/v++hxsMybobnF
	BjdbQkPSPLm19Wa2vc0RkpPkKqyhlkCtZW/8VFmmdOSBlDJ3bokchrtwTMU5peExyzlfqO/wes7
	BV+yWReHjr7rxqy9s3WIlnt146Q9c+OiMPU7NO76xZN/hDxVbQ9l8Y0ehTYniiD7eS
X-Received: by 2002:a17:90b:2d03:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39d9bc3f8c8mr7928696a91.6.1789142202047;
        Fri, 11 Sep 2026 08:56:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39da6016718sm3225865a91.15.2026.09.11.08.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:56:41 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:56:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] ipv4: igmp: convert ip_mc_msfget() to
 sockopt_t
Message-ID: <aqQkqzkIuHTNS-gW@devvm7509.cco0.facebook.com>
References: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
 <20260910-getsockopt_phase6-v1-2-e681e102d5b8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910-getsockopt_phase6-v1-2-e681e102d5b8@debian.org>

On 09/10, Breno Leitao wrote:
> IP_MSFILTER reads its reply through ip_mc_msfget(), reached from
> do_ip_getsockopt() and from nowhere else. Convert it, and build the
> sockopt_t at the call site for as long as the caller still carries a
> sockptr_t pair.
> 
> This is a special case, where optlen might only point
> to the header, and the real structure size is inside the header.
> 
> This is nasty, but, in order to avoid breaking userspace, we need to
> preserve the same mechanism, by:
> 
> 1) Only applying it for userspace address, otherwise it is too risky
> 2) Assume there is room to support the new size (in userspace)
> 
> The source list also moves from copy_to_sockptr_offset() to a sequential
> copy_to_iter(). IP_MSFILTER_SIZE(0) and offsetof(struct ip_msfilter,
> imsf_slist_flex) are both 16, so the bytes land where they did.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
