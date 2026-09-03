Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3933AD8C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422159; cv=none; b=ALz8C7aHUVyh7SgUO7DKezuMy96+uz0bzlUHa55IJJP9sCxOa8hwMS7uygY8SKEdgSrWLnh0CBZjDiwginAJgTPQdqMISwyqzWuA/+a0Ryrtk8wE625jCWHeulTng9muZihHjkKMeS0VvvBDAR9lIXxGG+gGsBfrFi2qqc053g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422159; c=relaxed/simple;
	bh=eEN+V3cQexCgSmzmNCM5zv7ejVDZO+umGBGR3h1Tc3k=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=ITWQu/+QCm0YM/YD+lZImuD8VOdyhQyfnN6wAVLt+N4UiHLtZQzGWpwfODYFQyeLqhmF390qGY17PxRD8mdoMi/CHJysl27tCt8DLl7i7uINm8+JeolCWE8ft1liwqbqb8gTViZazabV27/K6EP8PdDjP8YYrlpIOwLIPXEtGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xsc/PCFh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NcY0E92g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xsc/PCFh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcY0E92g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788422157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV9sg95pTpAsxuNpPStrP1G4M4KPRJDD47PoY7gwmD4=;
	b=Xsc/PCFhDoxHP2ukinGBOdvvib3fmRKPN2/pHFRbkWwmhIlmjdftUOv7poMvOMDur3mXFq
	CZ6h/GCvxcvltUUakuF62mfeVv/2oNNCjKuE5497kUbJmfXde2BfbxI0Z1d5oYguigFbxP
	3LzReYHizHO3Z7YQIsH5nW4Kzc8lXzE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-XiU3Ula0OgWHMwZQywl9aw-1; Thu, 03 Sep 2026 03:55:55 -0400
X-MC-Unique: XiU3Ula0OgWHMwZQywl9aw-1
X-Mimecast-MFC-AGG-ID: XiU3Ula0OgWHMwZQywl9aw_1788422155
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482a5e9400eso1755167f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788422154; x=1789026954; darn=vger.kernel.org;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pV9sg95pTpAsxuNpPStrP1G4M4KPRJDD47PoY7gwmD4=;
        b=NcY0E92gf1Kgw3hdO0KWgbcvzLcr7NZbh3/HQMj0t5w0TCNlxbRv4IYx4BNM0SZkq+
         4VREMsawjeY744XiSedIypJ5ENkiGE0awBQXd1aH+mTFhz3EdLXuvDKYUTJpafLugwLN
         KqHULbO6Q77L2IGIZBOkX7HQZQEXqgogamxwlxkGELBcNsC2vi/Lv0GHd9T/TEhCbrsG
         qZ2FdfeE+hLS4M7Futz8KgNF3O1JHclNJyVHBKksNrEy9400FAn4xJResgy7mAEdEIcD
         UmJVb/tyiozIFtTq1Ps5x8sDNCRs5kzM/MXRBhYTcUNMF5q2+MDOXCZdqgwso8RSA1R6
         +KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422154; x=1789026954;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pV9sg95pTpAsxuNpPStrP1G4M4KPRJDD47PoY7gwmD4=;
        b=KAxZkdIqEguDDbUViJgi/2xWWf2AQL+JE92w6oAH/LSafnyrJsyKx2ws0YrWECFL+z
         7InVZSuh/L+1KTSVs20lNeVUGmVFK7BM5oiBb3LNYCskTxg76PI9JUMnZ1nwHGg2FsRc
         LcscuF61/Yha3HpebFf8dJLOrA8nWbEkEe7fbAf+AKAHr9r5wXMpoUMdquvLN8+AM7JM
         kQdpO2wru+Y80nDA3VoKkVmmW/rJIazNxcBi3gv8vrxezYcV4HdIFgjK5DP/zPizkUgF
         RAA+BVmF/QUu6IoEB4Hi8i5gAsSfR9id84N0B0pVn1ZfDq5Pdl04f6G2xfJpxCodrFtq
         I9kA==
X-Gm-Message-State: AFuF++kX/nHvsC3e1qAEnAR97Jl7mjVt9u59cFzxhAxdEsgIYzJnF85U
	Y5fqJ3nNt/E4A5Ogx4DYlB5YJcUgGhAXifAe7QPcyhH9v3dHj9HN9EZlaosnfigLu/oFiOtMtGH
	wCRg/BSnejX62XX+Rgw/C3Be1GmY95bIOpVPk2b2Qg/nTir1jn/1rUGbMwg==
X-Gm-Gg: AYBFou16zXb6TU7HKeP9ajUIbBv1asBWZZbGJO6Z4kh9NqqK0x+9NH2foPQ6BrkfDdv
	dR7j3kyKYWp+xPpVf3B/TTogvRLku+ioJ1rkMUu8k88JKtRy8ykRABuf95qirdCXvFwm6kAsWRd
	SNti6n+3ziu+NgypiXYMv3yNzUdJ98xL6voxDDbUCDUpcx/nFB6O0VBCt4sqkhkv0Xzcpy6zfAl
	pf0UC6t/xyrUVHo45mDjrdLjtnl7AW1K36WNiWpD9TevY46lJzAX3KoUd7S8ibqSdujhp7ymiyH
	q913CrmPsHKvlk2WQIU8t6LiAwoVLnTCl8W75XYnPp7jPBy1zB4Ei7ZSJzzUYByaYRI/e/KqgJC
	zKs8u1MpDJ5A=
X-Received: by 2002:a05:6000:1449:b0:482:ea9b:962c with SMTP id ffacd0b85a97d-48488f23cb6mr19279144f8f.22.1788422154549;
        Thu, 03 Sep 2026 00:55:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1449:b0:482:ea9b:962c with SMTP id ffacd0b85a97d-48488f23cb6mr19279015f8f.22.1788422153950;
        Thu, 03 Sep 2026 00:55:53 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea96csm9953344f8f.29.2026.09.03.00.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:55:53 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 horms@kernel.org, aconole@redhat.com, gnault@redhat.com,
 laikabcprice@gmail.com, aroslavdudkov622@gmail.com,
 rough.rock3059@datachamp.fr, stable@vger.kernel.org
Subject: Re: [PATCH net] tunnels: Drop stale dst when building an ICMP error
 for PMTUD
Message-ID: <20260903095552.273dc06f@elisabeth>
In-Reply-To: <20260902190112.4126199-1-idosch@nvidia.com>
References: <20260902190112.4126199-1-idosch@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Sep 2026 09:55:52 +0200 (CEST)

On Wed,  2 Sep 2026 22:01:12 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> Bridged UDP tunnels such as VXLAN and GENEVE build an ICMP error packet
> around an overlay packet if the packet is going to exceed the underlay
> path MTU. The ICMP error packet is then injected back into the Rx path
> with the source and destination addresses swapped, so that it will be
> delivered to the overlay source.
> 
> If the overlay packet was routed to the UDP tunnel or locally generated,
> then it is already carrying a valid dst entry and this entry is not
> dropped when transforming the packet to an ICMP error packet. This
> causes the IP layer to reuse the dst entry, leading to the ICMP error
> packet being dropped or routed out of the UDP tunnel interface in case
> of forwarding.
> 
> Prior to the blamed commit this could not happen, as
> skb_tunnel_check_pmtu() did not build ICMP errors for PACKET_HOST
> packets. Such packets were instead encapsulated and, unless the DF bit
> was set in the outer header, fragmented by the underlay.
> 
> Fix this by making sure that the ICMP error packet does not have a valid
> dst entry, thereby forcing the IP layer to perform a route lookup.
> 
> Adjust the bridged PMTU exception selftests accordingly. When the
> local sender in ns_a pings the overlay destination with a deadline
> (-w), ping exits on the first socket error before any reply is
> received and returns a non-zero exit code. The test therefore only
> passed because the ICMP error was never delivered. Use a packet count
> (-c) like the ns_c line above it, so that the ICMP error counts
> against the packet budget and the exit code depends on whether echo
> replies were received. This passes with and without the fix.
> 
> Fixes: 8930424777e4 ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().")
> Cc: stable@vger.kernel.org
> Reported-by: Laika Price <laikabcprice@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260614-master-v3-1-9f5060ba1ed1@gmail.com/
> Reported-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260901081825.287173-1-aroslavdudkov622@gmail.com/
> Reported-by: Charles Bordet <rough.rock3059@datachamp.fr>
> Closes: https://lore.kernel.org/netdev/aHVhQLPJIhq-SYPM@eldamar.lan/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Thanks for fixing this and for the clear explanation! It was a rather
subtle and obscure issue.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

