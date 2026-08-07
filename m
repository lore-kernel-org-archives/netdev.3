Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406911CA9
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065521; cv=none; b=deXJ+8rnxpubplc2J1MnDEd6DIldrT07JuymMSWEfHtgpjlP39WCTILZP1fH8V3OXH9ONg83J4M+C/qqXIfMprNTxsX62EPzVy9i2OF3G+C331CsO9dkr86ub7Pzwn6KmcnYZS/KN1rQjA8QOVfzDkxawUZQUehie47iT5uJEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065521; c=relaxed/simple;
	bh=ky9OYXhOW8zxX/NXbWdZJYd58LsAgBtp3GIk2ouJjoc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fFi8I913vs1dUDjB4uvt5eI+ItzdDOvOUTQz1pRgbMDwEoJA0++u2DxPVh/t6Sr9LqumN4YUBIOjbEasUW/bReaZUilJLT3/ieIEtPOnDZ8PLDsZ5h6ki7fdHY9cYmhYSp/qJ7b9PJ7ucU9vRBv3KDTA8Y3Hsp1oILLYth6sDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFkK9tV+; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFkK9tV+"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e9d8f3289so43549447b3.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 18:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786065519; x=1786670319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hOxpWXKVFJ3URm3uZriLzHf088tykABB1pdbe8MixXM=;
        b=lFkK9tV+dqR6n+QOfXc0b6HdfcsnS/a67B5R2mDqGhh5VFLdseW+lBltRXql3eRVLt
         xSYSo2r3V9jLhaHVzW//wXrnBP0JRMzDbmOHEaoQwmbxlt2JDjZQ4tvUf6Q9KHe5j/R9
         2GCNsj4cJLUHeNsUq777/o+KSh8PZKm+bYJY52DnHv6Oyg2nMeJHYogerdEqggzkJu0d
         1ngYRFoMw5higCa4gymjdbqTTsI3U3Alo99bQHFqdf3tDC1N3AR3qxA/WjwzwL1PuDoe
         cuDUrnfGnqn0DVWc3aL9agASnhgV2w6MIzmqSh+/vN9Sfr55lpa4aVkVv300tBvnhYcO
         SdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786065519; x=1786670319;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOxpWXKVFJ3URm3uZriLzHf088tykABB1pdbe8MixXM=;
        b=OJNFswGPoF9VV0J9T6bN79muZjfGkqrrilpoVVHrMF4EBF0B2J16XRUDU4GtrzYS9n
         1O9gz6Mu7sGn1SdItxF0clGWkU0LmJKoXPUpgGem6sAYuMe4vCAbz5KZqq1DV/Gfqyei
         GJl48rpnDj6UU9YKxYCiwwK0drQ39AB4xeh0nJWauz84HTqj00aogeo7J6sfHOE/dKX+
         Yu+pikKLQB+o1iCrHxrTF+3z2SbxTnkwD+seJjLd40CqsbGOqX2xtPSux6kX1l3+MgBb
         09/PjdL09cpgbTxQUJd3CE/r+cb5nPdVCSEHJ52dJM+ybklHl7SotY/gwKz+2qxa6uF8
         +Exw==
X-Forwarded-Encrypted: i=1; AHgh+RpzmX08CUa8jTGVB5esqXWPRg9Ez4xFNLJMuA4J8t4bU30z7zwMPFJJFE4kYaB8/75KphZtotA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVmNmYuam2cjWbYxF10MRacK3B6wQNZaQ4XYubfJY/nXMq68f
	gK3EY7+GWged4mSo+H95dczOScl6u9yFdBL8HsBRfe9junNkPRaTMhtM
X-Gm-Gg: AR+sD12tnhAsqHBWPgmgExS0MLp5FXszLTvVd4Iq5Gy/FG/k0PkCYnuI4jsJf+nBe/E
	9aXcjl2g9nz979LjLS0QJ0y2aG+EvPYwuAqQvzw9YOCBOapUG7Pawv9sJQrLwjVKO4z2Mj2sHj5
	tx88pXCH8p7gT4lpmnW9CN9o2Ooev8PSNDUPZ7+Ak2sLu5vo35gCa0ivW1LSKEkBi9M2gachu9m
	snC2gzDj/ZJz0G7FqZXK5fiRS4UQ4NC4pLHFk6OyXA0e8ZQiJ9qHiQJa9rBp+9n+9qArUIaJUly
	37QnSL8hFrKPyZJn06l4u4pWRPBDyLR+czBZ8KpGyV6ec6OIEI1BA0g5jaQ+DVzbyLxdP3wgCCB
	zzDgn+k15oBM1VUs3ZXBPjuE000jiWSPGf+7QDMG/SU46RWIpZbZU8LAVmf6CRGMA0xIIJYGXOF
	93yAWgCbuWuT/nzBhVXk1ouHHHByL54s87SDfju6zn3n9aL8FLoMuKC/2d8vj03VpM1suk7UZiz
	T1jNI8y2jaLzq462/KXqMXs2++hr81+HZ1c
X-Received: by 2002:a05:690c:601:b0:81d:5155:213b with SMTP id 00721157ae682-820223296bfmr123197047b3.14.1786065519098;
        Thu, 06 Aug 2026 18:18:39 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f577c580sm1465037b3.27.2026.08.06.18.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:18:37 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:18:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, 
 joshua.a.hay@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.c36ea46d8e97@gmail.com>
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v4 0/6] hardware pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Enable safe hardware pacing offload on a first device (idpf), plus support.
> 
> - Add rtnetlink support for admin control over the device feature
> - Add device support to the idpf driver
> 
> Besides the main feature, also
> 
> - Small optimization to FQ offload: avoid unnecessary ktime_.._get().
> - Expand so_txtime drv-net test with hw offload testcases.
> - Expand pktgen with txtime feature.
> 
> Details and detailed changelog in the individual patches.
> 
> High level changes:
>   v3 -> v4
>     - Replace ethtool API with rtnetlink
>     - Drop/defer pktgen patch: not essential
> 
> NOTE: the idpf patch will have a minor merge conflict with commit
> "idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc"
> (https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/).
> I expect that this series will need another revision, at which point
> that fix will have made its way to net-next. There is also a fix to
> so_txtime.py outstanding, but that is structured so that these do not
> conflict.
> 
> v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
> v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
> v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/
> 
> Willem de Bruijn (6):
>   net: rtnetlink: add pacing_offload_horizon attribute to net_device
>   net_sched: sch_fq: clear past skb->tstamp if offloading pacing
>   idpf: support pacing offload
>   selftests: drv-net: refactor so_txtime errqueue handling
>   selftests: drv-net: in so_txtime tell apart sw from hw pacing
>   selftests: drv-net: extend so_txtime with hw offload
> 
>  Documentation/netlink/specs/rt-link.yaml      |   6 +
>  .../networking/net_cachelines/net_device.rst  |   3 +-
>  drivers/net/ethernet/intel/idpf/idpf.h        |   1 +
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   3 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  70 +++++++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  56 ++++++-
>  drivers/net/ethernet/intel/idpf/virtchnl2.h   |  10 ++
>  include/linux/netdevice.h                     |   4 +-
>  include/linux/skbuff.h                        |  17 +-
>  include/uapi/linux/if_link.h                  |   1 +
>  net/core/rtnetlink.c                          |  21 +++
>  net/sched/sch_fq.c                            |  19 ++-
>  .../testing/selftests/drivers/net/so_txtime.c | 157 +++++++++++++-----
>  .../selftests/drivers/net/so_txtime.py        |  75 ++++++++-
>  15 files changed, 385 insertions(+), 60 deletions(-)

This was intended to have a wider audience list. Will address in v5.
