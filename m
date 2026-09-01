Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2F36B919
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238198; cv=none; b=dqHk7Froobzqi7DrEpDRr1OcFT5hC5C5JO5y1m0ioY+0lE/hk2dlDemdC+CZSQmnc3SM7oFyg9FZRVgcUW9lJVE8/nlN7AvOfGxYfRjCdw4JvADdN3568ex8fz60bj89HNYrOo0hp2lPjRG35LgJx7/csKCbrAJ7dQaXXrXomAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238198; c=relaxed/simple;
	bh=QVRmVYUFV9HWiO4rq6ml5uOEih4tm9PBWdIh9tNbXfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvvhFMFdQKUXhvKKj0D3T7WajrqvQz/L+SuIqAiBOe5rTQR5a3l6JJXu7M9kaRFJDdn7fJwT/cTWb9ziJcnh1lnQ/d3zF4pD3686QqL9FE/b31uvhQryZ7wciMkP55m5t6uNDtdoB6e0SnojDaybjHXYNWjBiXRCG6YPTKBGkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=CM3XXywD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="CM3XXywD"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39927410578so64228a91.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788238196; x=1788842996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PR3/rYrkp4EpY/Prk9nYvuCIu3zjFr3wHfXG7wHAmL8=;
        b=CM3XXywDKt9ckMrdi6G+AVVXvgzodaUaD/isCrJIwfIVkcIUM1W8O+zF2l3vt2Z1oW
         oso1UjAEgIMQppxSb5vEtltOhW+FBBBHOR8bNSAyLLl5D+aXW5W47fzRA18ovWnOyTCj
         krgpmW3zzqaoqlakYJpXpj8PN5kBn03j9558kuczhrqLe1/Wue9IFItJMOPWT/E0knRa
         tlsqtDiko4oIHRetPsfEvRN3SrQfez2thLK7XY5ZE1KwvYawCnoPnrv2KvuMJ51PpqIe
         uaAZvkhXktoLOBUmSIc/7kR115gBRQCOzM6jVaE5uFLrnDtBHnGlB4/3GmAEj1Yqo5kN
         w3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788238196; x=1788842996;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PR3/rYrkp4EpY/Prk9nYvuCIu3zjFr3wHfXG7wHAmL8=;
        b=nTnM0qjUREMLpgk0sxKBmkR3KNfHztW6GjdHxM50K9a4YS/44pWbQsBJJS39wFiq4u
         WXs0f31obOppBzZCMHxHOZyiDNTrRKxlF/d2qyxmg6VNvNeJBGcrQAeODmeXl75Ph25v
         /ALl+AOXeLA+9ZQppm11qdJ5+7z5inK3VEfP94bhjqNvqcIQQ9eRhYhQvGr4Hiw2n26K
         7jKzQn7vskcwLB+Wc7wvcU0p0bOuh3v5RYsYbD0qrEMMhnR12MvnKPCqYfuv2AuKBmkI
         49YL0b80TVDnajuk30wOB1vTlyMohnjWRy9q2AIt8gSCQfPheUAL7WZu1cwfHZVDoH17
         5xCQ==
X-Gm-Message-State: AFuF++mMPV2wS7FXcAj2A35aTTY3gV+ScnG2+hpmal9Nzol51olF32Fr
	lQWIkd+s/+TVxChiS9TYVJDx/2Juxpc9w9z6PqKk2pX5Hj3DC2t2cH97BHzAn5rMwnGhdiJz+sX
	qTzmX
X-Gm-Gg: AYBFou2NEscclq583JbZCb10R/xW1oZChcz5YCGDNmH+VZLilTrX7LN2e6ewR26mx5f
	9r8OJwB/E30aUaJkhoM9ggrrMsg88RXd70KgKAXmBfrtmo5pQLHbJvLuKCuJMzMelSWIS+99Hdb
	QgjGwvBw2N20188YsJmd8j/DMv4f9xCftMgd6DLkiSV+iTk5P3DtV4bXT2WdZLW/Nj669/9cB7H
	NZMDlDOU8BODjE2L034TGKPj7Ppmhq+flfwrSvhL7cK9gNXKLSvbBDS28ZV5ytAblkOC3iwPNMK
	7z/k9b1xG18rKPD89y6hDaVW1BvxtK7WuyPipgpnRVosE98anJIgwUjnbTqcK8j0Guf/wCErze3
	dv8meAK98EAH3ZI2aKAYC6VsY2EnEEcPcPhoVbpPmHIk9BpjKCfNx/DIvnpQ3xMIXJAOsP95ov2
	3ASpS9w1YTg393OSk+f5v+4arLEgZpEObI1gsaRb53oMAmZWlnMtMIBpAKAs9K9n/Fksyb9PjWw
	bampkE8scY8LEDZk4+Pgp/VrGohIg==
X-Received: by 2002:a17:90a:d407:b0:398:e73e:5a13 with SMTP id 98e67ed59e1d1-39907bbe00cmr8301088a91.9.1788238196034;
        Mon, 31 Aug 2026 21:49:56 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d5111d4sm3472898a91.15.2026.08.31.21.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 21:49:55 -0700 (PDT)
Date: Mon, 31 Aug 2026 21:49:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alexander Zubkov <green@qrator.net>
Cc: netdev@vger.kernel.org, Petr Machata <me@pmachata.org>, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH iproute2 0/2] ip: ipstats: Fix statistics split across
 netlink messages
Message-ID: <20260831214942.71c92d44@phoenix.local>
In-Reply-To: <20260830181949.1096-1-green@qrator.net>
References: <20260830181949.1096-1-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 20:19:47 +0200
Alexander Zubkov <green@qrator.net> wrote:

> When dumping statistics, the kernel may split the statistics of a single
> interface across several netlink messages: if an attribute does not fit
> into the current skb, rtnl_fill_statsinfo() keeps the partial message and
> the dump is resumed at the same ifindex. "ip stats" formats every message
> on its own, so such an interface is reported twice and part of its
> statistics is lost. With "group offload subgroup l3_stats", which requests
> two attributes that the kernel emits one by one, this is easy to hit on a
> box with many netdevices:
> 
>     109: vlan859: group offload subgroup l3_stats on used on
> 
>     109: vlan859: group offload subgroup l3_stats
> 
> The first record holds IFLA_OFFLOAD_XSTATS_HW_S_INFO, the second one
> holds IFLA_OFFLOAD_XSTATS_L3_STATS, and the counters are never shown.
> 
> Patch 1 reassembles such messages before formatting them. Patch 2 is an
> unrelated hardening cleanup and can be dropped.
> 
> The merge itself was also exercised out of tree against the two message
> shapes the kernel can split, offload xstats cut between HW_S_INFO and
> L3_STATS, and bridge per-VLAN xstats cut between two BRIDGE_XSTATS_VLAN
> entries, plus a layout that must be refused rather than merged.
> 
> I faced the issue on kernel 7.1.5 / iproute2-7.0.0, mlxsw switch, with
> ~120 netdevices. The split was visible in an strace as two RTM_NEWSTATS
> messages with the same ifindex, carrying IFLA_OFFLOAD_XSTATS_HW_S_INFO
> and IFLA_OFFLOAD_XSTATS_L3_STATS respectively. The further research,
> patches and supporting texts was prepared with the help of an AI
> assistant. I reviewed and tested the patches against iproute2-7.1.0, with
> the proposed patches the interface is correctly reported once, with its
> counters. Although the patches makes sense to me, I have little
> experience with netlink handling.
> 
> 
> Alexander Zubkov (2):
>   ip: ipstats: Merge statistics split across several netlink messages
>   ip: ipstats: Do not hide HW statistics when hw_stats_info is missing
> 
>  ip/ipstats.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 280 insertions(+), 5 deletions(-)
> 


Please write patches for humans not AI.
Tell Claude to be concise and terse and follow patterns of other code
in the same project.
