Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349FE36EA88
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935963; cv=pass; b=Ak0NNcwmKXNAu8thsOIl9n7orRf0lggr5YiNZBS2geGEddxua2iQE7FJ4ypILiav10gKaCoguD8kWoOGliUKHAKeC/oE+Z5dMXut6R6m9GtfM0RgqKR/FzgyRWtTQDOm/QhyCeDKmvE+I8bpFDN8BDlItvTcw6MTcWnIm3gZpnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935963; c=relaxed/simple;
	bh=KfWkAC7ciIkbo6PDaSl0uLznVmfVh3leTBBxkpyFSjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvb6rjVrOxkHM6FJF4eBKVvme12ApisnSwE96zjcgnj8yDWJ35En78LHAfR6yEb4CGC3GaIJgvsL0G0zWGCFEHLFs1yt4bvSxmP/F3EY1mqTAtIQEK1EmRxHVvnsW2cf6zws4Jv7oOTilRLpcdzekstcghvvqz5Rrz8o4m7RDl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCzZsjB8; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCzZsjB8"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba379d8804so3510120e87.3
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 03:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790935959; cv=none;
        d=google.com; s=arc-20260327;
        b=H6a+Ow47Bw1zHP1O5363fK4dLA3/MO+fxa3W4XQzxiGJwgLijqsAVr1cCO+HgRzOEF
         7nIbDseN4Ewsvov3+CsWpJ/tKV5SIeFWU5WZaYh8TH+ocT9zp2t6EnuToK7Br//XnfiT
         90az7PIqrGt1ewiUycEp3afZUQWDwm6cG+OtyiMtHFXd9DbeO/O7y6f5umG1Ei4COl4b
         B9tCqvMBIDB8a/GSRXZj19opaSm6t502NXaquBFSABiwygryQJErTghAmpxxPR/DnnPl
         voftAm0qfHiRv64ne6zK+D0FyRsK/3ADXW53Dljx63bjhMMRVPcX9SJbOPQJeTI0RyY6
         /U5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nul3VjPP6p4uv61w9bRbyY3s7TwhdtmKvGkMiKjUI8c=;
        fh=psvyPpVR3ByOb9Z/UBc65JBny+uansuexn5PChnDhNU=;
        b=BDQ4hjIma6bP3DbfNqZzmPBgNYVjbcIPYax6ei135d26y0xb+WAfY6hFDR6AIvbCoj
         WUj55pvOzQ2knj4Sxh41SncgAlt0tHPhiGvr3pGQ5xNdJKgB6zvcFlmrBFg127ax3QyZ
         dAYld5o37MsitqY3TJBqjMHBtK7ikH0CUwm0GayBdey30LPsIRJzR78QIdWMvGGi/phx
         wKJlftDQegRLYAHqFmLjpWlosCDlCkfq8nqNmgQbTBsHydhrrvcz9ip8B1/FQPZ2M5Kg
         anD/CzoMaYmW4DDkgK3ISVbD6VL6bq7hui7b2V/8yMuF3hC3XxrXRkxufuaTEcgyHk6Z
         y3Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790935959; x=1791540759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nul3VjPP6p4uv61w9bRbyY3s7TwhdtmKvGkMiKjUI8c=;
        b=hCzZsjB8PgyB5anSul08lit+C1jRucuP28QGt8obp7RKjLP8LTCmMQN7N8uYA6LyGP
         rHcOew3mJhljYm+OMCgcahnkIEwcg1w0QTn8UmVlLhTpYFYJFjDXkYc/s0lbmdrrZ+AH
         MEXwLHnbm2mh1+AaNIjvnuCoLRGsMC2mLt2ECGOU6PpnyjTspPYC4+PQh5IKjCrydNoV
         0jhYE57svlhfk5jVj0gipUf672VTSgB1hUeso49UWBxeaOEUX3d5yZ4Tn4RBFl45mC2l
         zTI0OzHvT5fiX3XeurrHIqGBJifGxJTRUjg34XfOJwOy3Adg3c/t+20j7euNiDNq+ads
         sQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935959; x=1791540759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nul3VjPP6p4uv61w9bRbyY3s7TwhdtmKvGkMiKjUI8c=;
        b=oWqSRacKWjSHhg3wrPJcWhXk0O4UzPUY+PrXkb6G6OXbf3R4tuOZ3BbgxQzfyXGbsX
         JRi5dm9Jg4oy/rcANTzhBwBtGqVLY8rU4bcfBWuwaPRI/RDgTkQJ7os+PjTqkBN1vTO/
         nJiQFKm0fM9Wxzm+mcc6gZpVsmfBRfUIpXtASbHkNu2apdeJs1DONrTclW++RczysMHa
         av5iUJQyH/eAX442Zo/S/90nrll+fWlVJ/6j1/QY2cSE6aHuR4SmjvVlxqvLidM2pUeh
         7sdogLmR86+NxPwXWhHnG8TLFsZZmI/4cWd7Dhd1KYvZrs2gtH8Cek0fvUpE/1i8VgdQ
         gfNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYVqk6BEfhHK9nOkl51GqU4/EZsiWcIF5W/VM5OdwxtuefLHOhd23JehxbPHt4g8oL0FnbVrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsji8MOGQQom9LbwiC7KJhjdOoTTPjfMzsLl7tB0qdImLlNB5t
	LOr4u9bhTnQs2cirnuGhbpw1LTt6HDHJy1KQN18xg/RHvF8u6aI02o6E3cQ5Kyj5wlc7AM8kPCF
	yr5mbB1Fu9ILAMVDo/I8KVgGkvDAEr/E=
X-Gm-Gg: AYBFou1oQiHv7XJteMsvEInxCUmdWBhWIxi+ovkprT6hJJFhH8Gmo0OLbUKZu3ZMnkU
	OmRdX7Z3lYk0UTfEm0LND4vaHwqSpBTL4Jc7llr4pMk2bcIYSBtmk1NJCNV54ddLw+L3F/zuFP4
	Th0H7TvgsO6avxLa6TlBJRlab6dlNNbc1MK/E3c4XzqjmnkdLNwftdrI7tXoIck0gvnsnpVvKgI
	k7yWIay8bj5C/eRZaA3Jhvwnro+9hkIti8tk/QJDzb2IkZRAq8YrK7C6L1/WOf8pM34mgnuAx9S
	D3hfw6G7LWadn9Q6wNGbkr888pVMDeP/rQdFHaKSC5ydWJwGe53/DU4z0gCVZw/KFzkf42GLBW1
	zteZwKUri8QWZI92vTBwnQA==
X-Received: by 2002:a05:6512:a93:b0:5b6:1a7c:aa12 with SMTP id
 2adb3069b0e04-5bb9bb1da91mr722330e87.42.1790935958794; Fri, 02 Oct 2026
 03:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930112842.21323-5-sigefriedhyy@gmail.com> <179089748154.434549.15968186317991628500@kernel.org>
In-Reply-To: <179089748154.434549.15968186317991628500@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Fri, 2 Oct 2026 19:12:28 +0900
X-Gm-Features: AclHuK85FbqNwq-ELq8SKnyUcRuKjUZjdyqLDZaraiuSRJzWpMMsnKZCTynBQIc
Message-ID: <CA+7S2vKEVD5HUnotmTZ764iJXEWbPXY6bDp9i6p3uzm7ZFJkCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/6] net: add AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> - [Medium] Concurrent device removal can end an unfiltered AF_PACKET
>   RTM_GETMULTICAST dump early without setting NLM_F_DUMP_INTR.

This window is in unlist_netdevice(), the device leaves the index
before dev_base_seq is bumped. Moreover, it seems it affects the IPv4
and IPv6 address
dumps the same way. If it should be fixed, it seems it needs to be
fixed seapartely, not a new issue introduced in this patchset.

> - [Low] The commit message gives a false reason for not extending the FDB
>   dump.
> - [Low] dev_mc_genid is only bumped through the __hw_addr_count_*
>   helpers, i.e. when a dev->mc entry is added or removed.

Agreed on both, but they are nits, will adjust if there is a v10.

> - [Low] At this commit, Documentation/netlink/specs/rt-addr.yaml does not
>   describe the new AF_PACKET multicast dump: - The ifa-flags enum stops=
=E2=80=A6

The spec update is the next patch.
