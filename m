Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734405;
	b=gLe6BE8Mx0jqWTXYNyr8b0GBtvnQicX1Ty0P2O6iUIefqZK1Z0jEXRrxfKxshGa3XaEx
	 qUtetIU7/p735+VmDx+LAExGpG0hpU2lQNFtY6vHAJEtqWCmWwUV6WWj/mIKiM8EeHnze
	 dqiMAUGWcpOaIK4epDECaNWEmK0Dic6mi83Dk+V2ZFpIwOkZQkGBRFO7fFi2WFQZtMcGD
	 jmBGtO65sKVNahNvg1UBS7++kET7u3kK5WeauWUGdg0fxmcBMnuDFk4fxB0xVaV0dsmLy
	 t9ZM7E3zsNyICMUC32ihRu5k9ft4RwiVw9mov73WzBoaZuCu1rOsfpTj/udVo6W7LBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=15RJraNkt4G9imlgns/mzHRKCrlWGmqvpmr2tllrIBY=;
	b=KasRXpAll46cRW2EKfbDjiclJIl+LOAhfbYhHJoHxEaeSPm+q5QIaa1uEyJSnKBihVaw
	 4Ati9gpoZ+ZGkgAvPo8mS0d+T+NXdZaLLdY6gCm9AX0lrH30pbnSQMtmUS+2mi/tw5PM6
	 sHnebTqWVfd0v6c7VbQQ/D7UIyLm52iJPFkLcEHhYWTnvtB1otp4iI84BLT6RbyMnojr6
	 EaH2SXLgbx3T5bVAc9+bQeigIb41NMPzMyrIvRvmb3Jn3nYb4oXFAYZLFUlqkmA01E7wE
	 gQUlOsDP6HfuMF1Z2OcUD0a7JFs6Yek5TV2jgrTQcpVINSua2BQFD/1ppqPpdwoVwdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wV02aST+;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98381606D80A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98381606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wV02aST+
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1346308eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734404; x=1794339204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15RJraNkt4G9imlgns/mzHRKCrlWGmqvpmr2tllrIBY=;
        b=wV02aST+LnFuxBvV4bpYViFOafiBAI18U+cmy1u7/O8lBLjisx42g0f7VqlS7j6qWi
         fzZdeH2AtavuBEinDao1789fn1sBOJr3JreFzWRfnqHWIS3MgMOBh+kCvVGAjlYJmkjp
         QgfY3aVLjOO27toy9Do9VDZOcgWKHeLvUXUJt9+QhVCfgJ8B4pweYXZ1VRn20ajx22In
         N4rtQdS+6e7xZeweLYsATcu/Kuk3bCtZw5GIGxJKzMd7MVsi0m5Otgs1Yi62uqzl21Oz
         tUF7KmL6ccLm27Tb19Y4GTxqG+Oyz0lqfrSYtZL/ELJWt//50dFblUY+uRpGpFRRPic4
         ZEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734404; x=1794339204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15RJraNkt4G9imlgns/mzHRKCrlWGmqvpmr2tllrIBY=;
        b=f5lwTy+WOhf5OS2pk7Zinze10/idIYUB8j/qtcea1kiAx6yhwlofU+SxY9IMGOCKcN
         v705oO6lDfVZDNMn0Mz9JxqXvm6B+QkKf6qMIqSyJD4YMmRhANLIRC2DFlA7X0kDVKhW
         8q758WkHFU7lRWCkHwL+/EHjB8N1QNmlrcLP7S+hWIzsHcmrml8rmAiapJnVqJjZ7Gaw
         8D5nodYPWHZwi3oLgTwCMhBg0TcpSWvN0LsXc4rW6za6L0Ogc55E3LDh1Y9SaNdW+pqx
         OaJgeoblpcSxRmp93ARAl51jHpcLhnRB5rJAcHv40d4ypREln25KJOj1fFBDH9gg1nKT
         UjUQ==
X-Forwarded-Encrypted: i=1; AKwUvBx84wTdUnQhkN2W+ZPYgwN1kfcksPVorxGE/1jqYEwv/8BJUNKMWAS0z3h0NvzyTXbVzhxm5CA=@vger.kernel.org
X-Gm-Message-State: APuU4Z89KH2p5wryen72vEDUIjWYpf42D5ZhIBdt3QK3qmXAAngfSjQJ
	yB3wasWBCoY+ESfJPQFLO8kEzc+O5wqnromITt/fsHfWYUZHrF6Kj/j/
X-Gm-Gg: AYBFou0Y7hqUW/H1XbgD6okyZ2LL2EV2pnOW8QSUsdE0PtYdWhFAhxhfzkMk+Ev7Atb
	aCCc/6sCzbQGYkP+MGgMul5I38gXot2XTY1oS1RL45GL7zCZblygJAeHl0d3U2ov54APYxw9P9E
	u7+fFzPQC56iGSIQTFAoSr4SoVe1qORgTgH1PoomrdlnjB/YldR2PbyIIDf6wtyiPt/xH2MEEUj
	BJ/D8g1EX65H6pqQJRinqFKMmhz8UJ3EGsW//cUzyNUR3TLYkT5hxWAs7vIMQn+CZzWic/W1Lh5
	EIlcTnQWkFXaQJ1JvkuQIG7uSUlwKsKntQUQ3cpVRau2/U4bCz8CrK6vz9T5Trv/t2OHzEl8bpu
	rEhgSoYAm7IX4NfAHaWgN/nlt5z+0wV47nB6Np76+wHsD53Q/nWS73C0WpJnULnu2YZPSLb4jcT
	8GkqRsCx1XbznNgJVhbqOTqdbahvRIba6lXwPotbu5Kohol0t/Dv+N9KKjLQEGcjCSAVBkdFzip
	fIbtx626LBeTjWgcZdShdvWhQEDW4cHOXDeMsJsYrWzPdpvJWaldOUe8F3lMNeEat6QFvWsV8kZ
	sD66hbCwsdReY7OZO3QSFw==
X-Received: by 2002:a05:7301:103:b0:36c:9af3:22eb with SMTP id 5a478bee46e88-36c9af32cb0mr2691600eec.34.1793734403660;
        Tue, 03 Nov 2026 11:33:23 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6b::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3785430sm527244eec.3.2026.11.03.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:33:23 -0800 (PST)
Date: Tue, 3 Nov 2026 11:32:44 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 6/7] ipv6: convert do_ipv6_getsockopt() to
 sockopt_t
Message-ID: <auo21mFFkL2zH2MT@devvm16445.scu0.facebook.com>
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-6-2d36da923578@debian.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-6-2d36da923578@debian.org>

On 11/03, Breno Leitao wrote:
> Convert the SOL_IPV6 switch and its two remaining sockptr_t leaves,
> ip6_mroute_getsockopt() and ipv6_getsockopt_sticky().
> 
> ipv6_getsockopt() writes optlen back unconditionally, and
> sol_ipv6_sockopt() builds the sockopt_t with sockptr_to_sockopt() and
> stores optlen back as well.
> 
> ipv6_getsockopt() cannot use sockopt_init_user() as its IPv4 sibling
> does, since that rejects a negative optlen and this level answers it as
> 4. See "ipv6: treat a negative optlen as 4 in do_ipv6_getsockopt()".
> 
> Instead ipv6_getsockopt() applies that rule itself and builds the
> sockopt_t with the new sockopt_set_user(), which sockopt_init_user() now
> shares. MRT6_* is the exception: it has always rejected a negative
> optlen, and still does.
> 
> The write-back also happens before the netfilter fallback, so an
> unwritable optlen turns any error into -EFAULT and skips the fallback.
> Likewise optlen is now read before the MRT6_* dispatch, so an unreadable
> or negative one wins over -EOPNOTSUPP.
> 
> For the other options, a failing call that passed a negative optlen now
> leaves it as 4 instead of untouched, and the netfilter fallback sees that
> 4 too.
> 
> IPV6_2292PKTOPTIONS and the sticky options used to return the result of
> copy_to_sockptr(), the number of bytes not copied, so an unwritable
> optlen made getsockopt() return 4. They now return -EFAULT.
> 
> The extra code in sol_ipv6_sockopt() will go away when
> sol_ipv6_sockopt() receives sockopt_t, but, for now, it only moves the
> leaves.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
