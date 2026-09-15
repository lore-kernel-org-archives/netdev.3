Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED333115AE
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479092; cv=pass; b=GcvC3UMg3bekotdLGubOrEgVyJ9a4bFjYit4UFH+dWWCiYLgv6JKqswGWU1YALGpUP5NSBfKO0MLAd4AxuSQAyYJnxQPPM0+RXQ/dVx+kgj8zjHo66j32jGoMnxGNdOWeo2WE+O6NdYVvulMta3LC0+JkaEQ/k/kmdDcSvCcobs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479092; c=relaxed/simple;
	bh=kIvp2p0OAqbpx5mQWK12c8m9wbgllTkoXxeHr/DjNT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KW/0J/3k4x1UhJPCzwLvSV0rKVmC1oPnZztWQQggcaooe2WB6Gv8IOQP/i+JmCEVZH+KINKJZn7Z0Jn32Hz2I5mm1upwzZI3eofJVLSKoqwCjrfAEvU9Ky/TxkNOG8v/qvJL+UQ8NR+aXHsyrix+XUPMqIInVK32mVfufuSBFmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3geLB7q; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3geLB7q"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d0so33709371cf.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 06:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789479089; cv=none;
        d=google.com; s=arc-20260327;
        b=n8G2ZB0Syk9jktKU8N7P++3GhRrfYk4apb1OilFy0TygXxCjgooL9nx+hIVcvXVhgB
         P0YPXnb1Tf2JuFYxS91ShKFHvSE64ju0NzM1tXiKl08BJznSVfnVQDNOwpugkGiSmq/g
         D53ihi0DE6P57IgznFf4F5XL0UNJRfW5nRZs8VaT7z0k5iSFGipSxx9cBo45Bb389kng
         JIhDZ2ybAQ5N+s0DTkK5jooITWnTsmeyWEzZZxDESW+YzYqhAPNsKzVR33Gq8F5lupp6
         Dw49qldjBObKJRtJN/fkhJLUcXQcR5NPwEibcSa81I9RzO9weg2ky723wp69FMJdqRtN
         nd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1V7G6G1mkfJKSZ05h524aeXEghQG5eJWhgI4WGoRZnM=;
        fh=kCBPuIz+myKfdXwbVdzzGZWArITcZ7+h3x9vOcyBxK0=;
        b=ZjmZKrapZCWCcV2L+sWal7w6tCJrh0TbHahNWFG8MHwtlMn/oRQ750Vegfvo8TVyu4
         sufwR+tIFR3o77fw/j2RaORN2rUOTnjwJjQQQ7gytWbtyTMDP4TGbxpovF4rC/cn2/0/
         1JrUPCEP5UjDudXyyjwUFU/RWppFs/PYilYRqYfYMFN0VdIvdCrp1zSxy2vYQdxEsmUO
         w3N1KmZhub9dAA97/YIw2Ec7vSvsngBuJT1n6PEe4F2oyshaMlnWhppqgA9YcqpjUSI3
         sqMpWAwvKuE6MSHlOvm+336188bpvRFNmc+nfAhoR3s1nSHFDis5Q5a/fWGDqzk+8D+9
         vQcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789479089; x=1790083889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1V7G6G1mkfJKSZ05h524aeXEghQG5eJWhgI4WGoRZnM=;
        b=L3geLB7qmR21i4MSDvdiqbUh9533fZZWSpbv/2bJla4MyWQDpFtHW5Njg5bFpyzSti
         EDmQ+IUaKRTkBe5qY0g8dCBs/XFAkSqBS3/A7PO2HyJKRmgpxdiSbCal1fTJ6kOA2wi4
         XGD5Csn1I5WEb3yJ4/jGQCsDEsjT6tSmJhKitTTrO27pfChqra+3WxOGeBMn5DCEZTZI
         mWwnbzWkR9oIkqL+V7PllfEmAWLXYWPLB4+SX8NO17y0Ew8NOdskCQxqwRh/KwLYEdq0
         z4Dqe3XpEpFMGOk0BWhzSSNr46NeHbDjWTbE/L6KgAsIdshUjCfLqLXo6rWNRuxD/SG6
         XNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789479089; x=1790083889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1V7G6G1mkfJKSZ05h524aeXEghQG5eJWhgI4WGoRZnM=;
        b=f5B0VDZf5nZOaGmnISrQW8Gc1KNI2tF1vxn/qLnEiT/th2742MOq4inE0eFaJb6MXr
         m5GjycM2GOvH7cgjpwafxlPoc7UliSQmtWIZS22tG2IFEZOLFxUsJ01fzYw7v06QqWTD
         WXT9YcmNmV72V0Qpiy0n39yRwDHUxLHEQXKIKhD76FcZm//ufhDrB9cgWa9Fgt8Sb+fq
         GIRUGPWarNxvYOYNpDeOM0j3RGfLFxGmRYvlLtIEBUujJSwwCmuPgLrWpRTJHkBlvDQM
         m3iirO2lwNwlZLD0yeJy03eHW6Y+7X/RDRpfM/hfvw6rVec/rx8haNPaE71CisUp7pvS
         8XSA==
X-Forwarded-Encrypted: i=1; AKwUvBxzVeNzRy1X1623b4ys/ITdD9S74RQsVguOHE0seNxPdIGJghvQM2dRGGEpwHDBR1whXc/yO+E=@vger.kernel.org
X-Gm-Message-State: AFuF++mFpHA5CkbaPM/iM+uxtRH3mhVruanWQam0teU1QuocnUAyl2QZ
	RDDaNyjc3SLfR9fmu1CV7bMeXW1vWeKR1tV1Pm2gYS5Qf5mIPyYqeBNJ7HX4ZL51b3KK1FV23Q7
	znr3Drpi/KFWLdCBP+i+aQTZ4JRcUujKllVdPSSAG
X-Gm-Gg: AYBFou2geLxjP7nGR+ZFdV4CuR6ImJ67dWkzUkpr6UiC9XHJXxT0ylbHyNmuLTsB+kb
	tRP7UcJ6aQcB8v8TKeO/vHx8XSBCSvxoh8Xj3Ybk1R72OxzqeF0ctaaHm52KYtwSQ4BnDCmMmgt
	gO+5P2LnsHt4Xxj7esd7eQezCVqOGsDVClNU4c32kQvjpHmQWTNprdzQBuLCJkqBuFM3qV70KTn
	aShoUJYN6K9Ghsyn0535JuTbvakgffUMAxA6K+8mr3JGvzd4R9BGcCcvicc4TM3VIaY4HbqTUYY
	11Wm2GjG7CE4IcN15ZkSRid3+JlokEXsPpVjhVKK1kXqAwVLE6A13vCrpKFbyxu8CgAWj+YpUmg
	ujI4fZsAY03Mx0OsGCm2ZphVavGCmaForB5raoVVuI6nAMtLTl7JncpuZuwc7rjNM/oXcvuZ7P2
	3N9g==
X-Received: by 2002:a05:622a:991:b0:530:b2e2:903c with SMTP id
 d75a77b69052e-5310d0c3ee1mr115228281cf.60.1789479088495; Tue, 15 Sep 2026
 06:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com>
In-Reply-To: <20260912150944.3470971-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 06:31:16 -0700
X-Gm-Features: AcwNN1V6MwBnHD4oUR1oY5-AvAJsE3mNQu1UyYcuotYsvlr9sijYynMMDbOY3QU
Message-ID: <CANn89iJwwSMPXTjNYpXUskr1E+T8-EnkvO4LFSZAknqVL5+1gw@mail.gmail.com>
Subject: Re: [PATCH net 0/3] ip_gre: fix header lengths and validation on changelink
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 8:09=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Three fixes in the IPv4 GRE/ERSPAN changelink path, found while preparing
> an RCU conversion of the IPv4 tunnel configuration. They all come from
> the same place: ipgre_changelink() and erspan_changelink() mutate the
> live device as they go, without keeping tunnel->hlen,
> dev->needed_headroom and dev->mtu in sync.
>
> Patch 1 makes the netlink parsers all-or-nothing. They write into the
> live tunnel before all attributes have been validated, so a rejected
> request leaves it half updated; in the worst case dev->type is left at
> ARPHRD_NONE and the interface is broken for good.
>
> Patch 2 stops maintaining the device lengths as a difference.
> ipgre_link_update() adjusts them by a delta computed from tun_hlen only,
> while ip_tunnel_bind_dev() assigns the same fields from tunnel->hlen.
> Two writers, two models, and a delta that ignores the encapsulation, is
> applied on top of the absolute assignment when the link changes too, and
> is computed from a length ip_tunnel_encap_setup() may have published for
> a request that then failed. tunnel->hlen is now recomputed from tun_hlen
> and encap_hlen, and ip_tunnel_bind_dev() becomes the only writer of the
> device lengths. Not a memory safety issue: ip_tunnel_xmit() computes its
> own headroom for the encapsulation, only the advertised MTU is wrong.
>
> Patch 3 gives ERSPAN the same treatment, where it does crash:
> erspan_xmit() reserves dev->needed_headroom with skb_cow_head() and then
> pushes a header sized from the current version, so going from version 0
> to version 2 adds 20 bytes and can reach skb_under_panic().
>
> Notes for reviewers, because not all bugs are fixed.
>
> When the header length really changes, dev->mtu
> is now recomputed by ip_tunnel_bind_dev() instead of being shifted by
> the difference, as ip_tunnel_update() already does for a link or fwmark
> change; a MTU configured by the user still survives a request that does
> not change the header length.
>
> And the changelink paths still commit into the live tunnel step by step.
> A rejected request is therefore not a no-op, and since the xmit path is
> lockless, a concurrent erspan_xmit() can briefly see a new erspan_ver
> while dev->needed_headroom still describes the old one. Both are
> pre-existing. These patches shrink the second one from permanent to the
> duration of a single changelink, since erspan_changelink() does not
> refresh the lengths at all today, but closing it means publishing a whole
> new configuration atomically. That needs a larger rework and will come
> with the ip_tunnel RCU conversion in net-next.
>
> Eric Dumazet (3):
>   ip_gre: validate netlink attributes before changing the tunnel
>   ip_gre: compute tunnel lengths absolutely instead of by delta
>   ip_gre: recompute erspan header lengths after a change

I will send a V2, integrating AI review feedback

pw-bot: cr
