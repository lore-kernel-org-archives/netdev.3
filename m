Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381910;
	b=sMcv1tDSJljI8wptG+yzRcSTNV1n6tEELGBGRUle4VR1oouvXDnBcAMLLsOxg1EY+5io
	 dpC+4uITfhiutswd/j5GfbWD4YIlROe67DcwUKp3BUmI7qRf68IzXMRECEhx7Q4Smz5HI
	 C3dsS0qYQXhOmmxtZ97Tq5iwj02srq48Sfe4F43KEk4Mil1kOJUYTqp9NcW653su0sQ7d
	 F5TIc0Vbi9zgQ/L/J6gCPBN2+/ytrvfwxVl4dI4HCOINiQuktefwfJb5+ulmbQLdHw28L
	 2mXIziAJhMAT3Pof93RipibKKGJVCGX9B+6oxStWSpTp8x+aNDPSnVn+vovrJSOOyuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EoW6Fc+Q4vJcb/scjylrIakaVWrk6eQ7R0akCKO3swU=;
	b=Kz/+qLk3fU2XM7AiNNAbZrzqagee7JrRQTCePfKLJ+VC4WD5LNZ7dC0nAOAhV6yS6CLN
	 AWznHwJruGrEiH4YRtTHXz3Uk/K+AN50GG4GU2HKViFL0nzWoD5IwBRaus5uVZyTlpHfz
	 iTPVLREd8LFoCqml3FRinjFr9Xa0FEI++DI+H/VhsTUw15oVDNfQWW4dyZzVGIFolmhXF
	 It6ev7g8lafkVbtdYNRZWmSgtfEGCXxBvAVl0uBv/PZ7PNCnxgnTXlo8F07OoZzUzdlc0
	 b4zADWlqe3VknnMVr0csZtsTagOG15r33zBC+HSsFdrectRg7T4zfFUriCTmCgbMzvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XQouLIkm;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF171606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF171606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XQouLIkm
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ae93a86008so506163a91.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793381909; x=1793986709; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EoW6Fc+Q4vJcb/scjylrIakaVWrk6eQ7R0akCKO3swU=;
        b=XQouLIkmjjIbQtl2AB5ZG9lylmU8nhd4x06gA5H3Dg2o8TGbD91XfJ8zmdKyg6WEQj
         VTNTE856maSNVLT4CiKfaa57Zz+4e/N4R97C4tNY2DtRLOk1rk2MuWOP8+U3aNgXOCjb
         KafuoeCTOUxvtpA8MWYS6qVuAftb+CkbJxUdu1/PamLvCNItdLQicYAfMAlKRTUUCRIg
         Ei7f8+u7lwtZbfXplmb1RS4Hj9pKU1NHpL9N7q+Tg0O+34P7ISWtTFYIu5rWgWhzd8Br
         8oulUFTKjxpAOWH4rKy45/MJHuihRSaaxDx6wfleMHOsocP6+xrjw4enObQ3iNxNq6wI
         +TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381909; x=1793986709;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EoW6Fc+Q4vJcb/scjylrIakaVWrk6eQ7R0akCKO3swU=;
        b=iXZZuhPKVYi5a4Q0G05cidZ3TSJV9Jnvnw4WoCA4LbjO+Z3tQsZ1oPA5N+DCN98ASV
         zZ/rDFNKpIjh3As7FZJEEC2xF80KmfIrDoez3J7+AiZUYvUV+cM3nNtbER7izbs3uD+M
         M9xTO0NpNkDrZVM3eyzjJlVO5pOle3lOG7s3Lw5ycK+ZQrsalWm3Jp7VOFojm650vtuI
         yquQRRYybwgtfjm0LcGM149STJaTgenaggZssLqFsULbVUXbcEfSh58pLaMFc8YDALyK
         dqlKCqAe5kPMQrRYMUAiwIzA5dPQ7oR0wsxXVMBGgzm3JUdpN7N7OKUlEvhEN1Rvrdo0
         RyBA==
X-Gm-Message-State: AFq9FYJ0oK1wHtQenmLUDZGqbfp477NT7BOoXTvzjEwdoy+uvOmUiSRT
	c3mvTpqNnzfTnCI3PSUn/cEdflDhfMOal141NpitvmxaI83xkoZKz0C1
X-Gm-Gg: AYBFou1r6i6TWVqiyTQbpVIz8e1pcfyuVqJRHVPn+kvtAJX+OcHy0TSO2qP2luUU4HA
	jO5VplVOgN4mt0BU+Im5cku6nwrKbaRsnpc7WTyV0K0J8V3h3+2yjlY/eTi9Bdl0vMqCqd3krB8
	pU//ZGsnwSqgvmTEizasX1LuJmjQ+zB7ahU6FVlaiZGCN8GNC62CX0FKYUWiK7LyMy0c6Oetmz6
	xZ7UVb4xz9aKwHESyNQdqvUYgKRAZhZQdO7HaARFcvnCrnX7/kIrogXOgscgIu7DSRjvPONmF70
	KcTChJEbhXiqb3tu9lP7QLVhjOzHEkcHSwL+w9/Y/+dgnH0McYRFalGdpvnrAlGVPf9ALSuscOg
	VpUEvhHSblumMP3m1mAN8oFTGY5q9QpRVXii/uu4Yjo/4R260zhieh1jjTpxFMHjgfBr6bHFptS
	iWghvtLQUXeRtR8kBwg7HPRPvl0XG1nTgOZo5kO0GVqcR7CeVBCF/f13Kq7k6/XMh/KZkN4gbZ1
	xCmNV5Y+ztnY3XyLgAEGtYPf0Sn5jpsaQlLd5G4BYpLPHyQYEmI5uWZO+s7k7XQJZNav+mvCJfR
	UqMxyBxqmgx7oy4cslRBarnlmGDFfJaW/zASoolnNALIYg==
X-Received: by 2002:a17:90b:5868:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3ae8980a25bmr2636860a91.66.1793381909231;
        Fri, 30 Oct 2026 10:38:29 -0700 (PDT)
Received: from [192.168.43.2] ([119.234.99.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm4964258a91.9.2026.10.30.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:38:28 -0700 (PDT)
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Hangbin Liu <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH net v2] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Date: Sat, 31 Oct 2026 01:38:22 +0800
Message-ID: <179338190237.9376.13820542101227461550@gmail.com>
In-Reply-To: <20261030160532.4832d994@pumpkin>
References:
 <20261026044808.613-1-n0ps1edzz@gmail.com> <20261030160532.4832d994@pumpkin>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thanks, David.

Yes, in the redirect case it passes the old rt->dst.dev, while skb->dst
has already been replaced. That changes the NF_HOOK outdev, so it
probably belongs in a separate fix.

A bare rt6i_idev or dst.dev pointer looks unsafe, since dropping the old
route drops the refs they rely on. An explicit hold/put could replace the
RCU lock, but adds per-packet refs, and doesn't avoid the deferred route
free. As far as I can tell, that uses the embedded dst rcu_head; the
temporary rt6 in this path comes from the existing HDRINCL lookup, and v2
doesn't add a new alloc/free there.

I'll test moving the RCU read lock before l3mdev_ip6_out().
