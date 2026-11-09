Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794260503;
	b=OVf6IWRaVxNbpDg+b7Uc7FZRv0ktxitx5K2Ig9gk5Oq+O004GvkeyvI5pNQYuntoBaSo
	 aClBELSAg9oaB6eN8LUlK3C5BfKn+Kw5KLX67sqktcgI/yKNf/QWO5dhu10/t3Qiv43n7
	 VlRK/GJN1GA1V6JIoP0UlftDMDmjrGdfYJt0dKYxvgwQzVyH0LiMPPuDQrbhTXLRpDp12
	 /xQKv+Z91oMpKcncIc++N4lALr+fbfU3uR/CpHt8/cOAHCCmmXXvQKT6xPeBTdI+OxZ2G
	 JkhzK+RLBHnahb64CtMvGAjDwXERvcDl4CC+qmife4auACqZfzcic/aAX4/wW9KR8Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NjZcMDuMMGxyY6amaxIW0DZh6qdiMsYJoKrpahQKs0s=;
	b=4yRRMbb04HIybvV5TlmIueaywtBKN7MDcXlvIId5CeVKa0XShPzOTFrikzVU3TNdt+6B
	 +kELuBRSrak+LMPEbDIoVU2On+0qJBqSHTAPjvjEdXprkgLnkhwzGj507Pa2pwJjREsca
	 +anIJ7ouAT11W0EbnHXh90pT2tvcTx4eJS1RkFSATfeETXO563m2MLHBOVzEQhL3Rx6qg
	 jRovh5YEwtIU5EGFM+gfovYnnrIHR2mxfHU7Yd1gI6Q8xu5s3K3gZwlXk+MP1reRdRyK5
	 j1pm4Wy5lIaxEuEg9XXDUl2gYNpCpXoJRWHWpJfGLrD/GQqYqwNj7cwzoWEmsoUL/YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="H8f/kE/q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BF606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D6BF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=H8f/kE/q
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso516355a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794260502; cv=none;
        d=google.com; s=arc-20260327;
        b=jt+XC2ZbsDP9GSpNS3l1u2hdXsWPeHyDipCjQPkNT+k9O+tAxV7JmAkI+lXU3rihF4
         xQQ4rbRFYHWXWGYGjZn8c3VBGycsYNx53V6FuLeTu1PTmkaqsBZ+oGmPPzjeMJiO6sS9
         ivQ7MyuJ85k2dLqWqQc6PtHwR9rL5tqsw2aFu1pPcetSTXZP1VAuDYjGfNvV052wU2Wm
         CluZqOS5YZmuwgg6Y8Kaov9jSYdtJS7t8ibHcMZoUQ3Xf1vglisijZA5MZnzJKdHplg4
         lxreEQCLL1EOvIewxyLBNQMB0p59Dq2zEjFBHtSJW/mYUdOip6s1kfO/5JYGE+/dKVRf
         uW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjZcMDuMMGxyY6amaxIW0DZh6qdiMsYJoKrpahQKs0s=;
        fh=K/y1HIHsQsYkP6QOsWtzO+GSHr60QeTggiWJnRghcc4=;
        b=jhstlyVfPjvbIqKjpQv4t0o5Yiy0zzn8lWexH2LG6252WSS8Kr6gKWpMyiM/JHqmNA
         htbDFxcRiiDjvJjzUXyMaK4iuGknaypm6o9uH1vwa8lUtonCoh2lFI2xpMwQ74ZNdjIg
         TDhT5aPYCwAU9aJf1GadZAWzXNh0RVd+Gt9qXCt0B5zQc4SECjIqOtaz6I186gKg6VRr
         TZR26plNQnparH/SxHu82rg69iMu/zFos402eSzkNOusxcvjdVBJpCuHWegjXVE9Jtq1
         xNjSeI4ABB4GryuN+U7jHb30USbH/2cBIfZiG4MbMrB/ipVXwZjB/qTkkwWJMb1CHBvZ
         ZNog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794260502; x=1794865302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NjZcMDuMMGxyY6amaxIW0DZh6qdiMsYJoKrpahQKs0s=;
        b=H8f/kE/qE8C/KJyMn+Q7ubxqQ8IyciFvzLujWV6YO7lCdYAgm2P7ZirUUZc/2EtNyg
         Ia9gX7TaYQ1KXM5BWsScq764dSpDTkjzgs2AHT3LJNnqwJhr7zizQ0++I6qfQIYUeBdk
         8OhWeqd7GlpNforRxvSMXJbsFdkD7RLL2NndI+WOoHOtD+9Yo8G8Cy8pBGsFB43Y4C3o
         GyQPb0GY34YOWttb7qIHUfJIUS3Fms6+sDFulqr3ARoeU1zJ+v4TfBgQFc9VnoNmrc8L
         EYQa9ywpyTaWda+3mMtC6t+wirBacSk0hM2jeemvyA46/hDPZfuVjmIeQ91AW/0+KsyZ
         30ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260502; x=1794865302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjZcMDuMMGxyY6amaxIW0DZh6qdiMsYJoKrpahQKs0s=;
        b=d7cwVtmxjlH2tFwhMubd83Q0ng+a/lD80y/Lqn87zfdd44GzX1q7+mc3Zktg5ITJYp
         hJkY8gnHCTZ/H0M8+k0xKVfpvlzOQ3wfvcA6s8eAFoRiixdQTk9sIs2IRBLm1/CqhlER
         FZn76SxkZaDC8lQK+fdc8k1y2SzX/kfRFbZQTPlB1ra6S7RdTH23Q/owk+Z+K5KWCZsy
         m2bJs5QbHVVL1baTs+yEDCBba4sTzk7wZTrtpCi9fdDdXVqw939nn/sm+AOFrS/Qb5og
         Om+2fq7I9RwploX6ipXApVXlkrfa1WJvH/7awmSR9OOU5v+lRtc4J10KWVi0OIhpPBCe
         7mJQ==
X-Forwarded-Encrypted: i=1; AL+hErFpbcMvZYf2sX60Gzsef/6vPEnW75axLzYtciUEhyR5Ms9ziyCoB9aKuvtWh70e00QuB7L3cTI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TCALGxG+QmH3MGiJqo/tY8ualbICXSDbv+unvvEvn4HrRci66
	PcsiKs1ruEY2eBrxHzzUdFJehklqeA0gSpHDHwBydYFG626vDRfgBqhiNvmC/o9qYUrnqa66ZLU
	HMEX19JF98EcwQX0jKZp6ZX5+xiwrno6LMBvZzTe/
X-Gm-Gg: AYBFou0zUKlPyMwfIpTzqO+8lhfyndlmMjZGu0iS+EPZzpxamKZkHE82uG4j8ZGSvDR
	lmkmmXx60Tyjgs5xSaNuxpS8GKRMzKMp82fH/yoPo/PmEG9A/VPSOKEMjAfkSIrRqpDxr2xi5uO
	Qis44yvPOswlPIJHdTEz4jWprFH68O8HiUECGMxrRjpV00T7sszOyGAkIviftVs+IdGGhQlc/y7
	j6OCkhNMMxdZSWTewbinS3nAuJxNur6/yTekF0vlKL+UtCIj22pCOQ0n/ypJECl0vCw2LLdoJCg
	ZCaOWaVDRrl6lS+Ux6zdyC67VpSUhyE2tcH8Z0fTkM9zhx15kTE4KwCw1Sv4Tg/I2p89TrYsKQ3
	TopqGpJI8MXV3LtcncAVn5DKT+soimC8rZRiJDWpBZs/frcZfgEgrejxSGUIofQ7HT0qb
X-Received: by 2002:a17:90b:1a87:b0:3aa:f2c4:12e9 with SMTP id
 98e67ed59e1d1-3b166ac9bd4mr960282a91.3.1794260502561; Mon, 09 Nov 2026
 13:41:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106234313.2537882-1-edumazet@kernel.org> <20261106234313.2537882-3-edumazet@kernel.org>
In-Reply-To: <20261106234313.2537882-3-edumazet@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 16:41:29 -0500
X-Gm-Features: AclHuK9JqJdznovs8kNDyDZv0L0agpYL-mePGxz4TwZJOA8lOTTp3veMhIhfUYs
Message-ID: <CAHC9VhT1oFLhRd42SVuyS1NX=t9Tn6GWLddEX1iF6sycfkdtRg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] cipso: unshare headers before recompiling IP
 options in cipso_v4_error()
To: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, linux-security-module@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:43=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> cipso_v4_error() recompiles the IP options of the offending packet with
> __ip_options_compile() before echoing them in an ICMP error.
> __ip_options_compile() updates Record Route and Timestamp options in
> place.
>
> cipso_v4_error() is called from the LSM socket receive hooks through
> netlbl_skbuff_err(). ip_rcv_options() unshared the IPv4 header earlier,
> but at socket delivery time the skb can again be a clone sharing its
> data with other skbs, such as the per-socket clones made for raw sockets
> or multicast/broadcast delivery. Writing to the options then modifies
> packet data seen by the other users of the buffer, and a concurrent
> recompilation would hit the same check-then-write race as the one fixed
> in ipv4_send_dest_unreach().
>
> Make the header private before recompiling options, as ip_rcv_options()
> already does. If the copy fails, do not send the ICMP error.
>
> Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> The issue was found by an AI code review agent. It was not reproduced,
> and the fix was only build-tested.
>
>  net/ipv4/cipso_ipv4.c | 3 +++
>  1 file changed, 3 insertions(+)

This seems okay to me, thanks Eric.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
