Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE336604B
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452951; cv=none; b=iJnHHJSvx5ymL0TCbNO58woQP0wKycnYeIe3/hwS6o8qNjfAegIM6TqbQoiiCyYczbYGy2aVr7KaFuVipHQhyiqFIkFT6lpEKX94mXpblQxRtnqW3XFnHO62iIH5uGjqDeY17jlQhhO0du0SpkRiTQyV49P+7n3gVdJMsCMef04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452951; c=relaxed/simple;
	bh=6jPgiSRUf5T6hQBG2tDr0gOSmgHP5/l9XHs7Uw9gxtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUe3RZvYGRrJkLypHlbkpEFgXcFKBCc6wK1XZygTs07AIPcu6/Di7KGiwNN/Igq8a+8wKx96BCjFkedanZDcVxVcl6qmsyn1ZCnqdYoopWotCPPduvqD1bKD9+OA4YL/kgrMtUFo7DRvojzZgqgK00udcTbiXiKVZic3aXys1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQooFrqp; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQooFrqp"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398beb616f5so970103a91.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790452949; x=1791057749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o5nGqbOD5YuuDgh3hqWH/jfIt3JTY1EA1m2kdqTIaSU=;
        b=AQooFrqpvPBEUKvYY9WUhhL9/tEv2mF0hrLERzSF0KlPwcHJQrroX/H+bolEOxdxYN
         P0kQsApdMIURvdzNRYWVUPrxG4rDcTmo/blLuR0VvsuzRv+DY336x4TKVZeXE8k9cFOf
         7al3XAo+7j3G0sHErA/8p+OhiFzNd5JvfCuBsrtkh9HNJjE3uVjk+Q9AlQLay1Zao6zp
         6hfI7viQp7BtLqMKsz2NsH6epUZ/LkuYnnnVX51mbKE0Ks5FM9W1okU3zcLRECgRG367
         GzE8OLpv/MG95VVKqq1BxNUN38MjnAY2jL0kubRg4PIv8zxuO0uZv6aLrdM5nTQpovhs
         3FBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790452949; x=1791057749;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5nGqbOD5YuuDgh3hqWH/jfIt3JTY1EA1m2kdqTIaSU=;
        b=fnRiEIhbS14FqJ+Tr65Xbhf3yWEtO1PukQxaHSBN8Q2S/ljFkG6vDrQ/R7/8SoDr8d
         uQYCQtBYzkcWMe44pUOAJdKdQQ8bdmoZaN4nP+OoZCLTXnz7AM/PijEMuDpqSrJ3FjXW
         CFaLv8yaVPMWeTpTuYBYx4UqTWXiGns0i2/u7sLFMY4SZeKvQSbUvLnBqYqPBI77sqX6
         XiAc3in8B+u9xM9EYdowksZyVTv3KLrqRNGDAPQpfY248Ln0thg6UWtCNs/GORlfQMDZ
         YIbqbhuY1+VJz36S+ky3bm1t8cEd9l8uTVrD2Qx1Ck+pQP2MblxBJhwRuhaC/RR25rMK
         Jccw==
X-Gm-Message-State: AFq9FYJ+VwD9+WqaULM5kecAv990nlWKwcxGqPprUgkn9cHb8hl1Sg69
	ja9lj/bnwOSdsLnrky4qfAbnSXF3KpUPahffxTboi0mb1gopBK3KGeYJ
X-Gm-Gg: AYBFou1xdj2R/BX9WuBsDA/r3vCz7wotFTCQNgoJFtKt6OgWNKo5izHmMUT9y2qCTd/
	ic8y4S4+dqxScC0Sob3Gvq5Ysuw00CBO/P3tmrAROih+MeSemuapgB7deIR/smpJWOHLNOGaTDF
	7OP2KI4pSUhEoedACH+PdsyQV09H+fnhzkVoNWUzQ7fCT/SkFgBXIsbvpZL/8Yq7ksPsh+Jvu9X
	WS35OQdtEg7psE3h8ZKcTPuSyoTZm51wpt6mNSnnXezNYITblp2K+WiYrMEeBVp6KyjLbIbYtwZ
	eD4fz0IZQjWlqcAK/3DFYaMkq+s5VUhUg66GEEFuc3VSIPPxVPzMBMigtm/WLHkrJf8onhsFbe0
	n7eSuIluVpsvlUQlWnX4wiuvZeSHYwaLYwqwyIyk1jbbwIJ76GyOuJyFDoDujdJhM9K1s2o4wEX
	vdseqSma1tSinIfK3nj4wilZpA0ZuWVcf+ehkiN2ckoqOU//w57vfrYG70vJqhij2xaXChuyk=
X-Received: by 2002:a17:90b:2704:b0:3a0:ce02:6dda with SMTP id 98e67ed59e1d1-3a0ce026f76mr1980554a91.19.1790452948987;
        Sat, 26 Sep 2026 13:02:28 -0700 (PDT)
Received: from gmail.com ([2a03:2880:7ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm12124169a91.1.2026.09.26.13.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 13:02:28 -0700 (PDT)
Date: Sat, 26 Sep 2026 13:02:14 -0700
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] selftests/net/openvswitch: add SCTP flow
 key test across conntrack NAT
Message-ID: <argkxqdmcxa605b/@gmail.com>
References: <20260918144647.2024095-1-houminxi@gmail.com>
 <20260918144647.2024095-3-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918144647.2024095-3-houminxi@gmail.com>

On Fri, Sep 18, 2026 at 10:46:47AM -0400, Minxi Hou wrote:
> After conntrack NAT rewrites a packet, OVS refreshes the cached flow
> key in ovs_nat_update_key(), which has a per-protocol branch for the
> L4 ports (UDP/TCP/SCTP, conntrack.c). Address-only NAT cannot tell a
> working SCTP branch from a missing one: the ports survive unchanged
> either way, so a post-recirc match on the original port stays green
> even with the branch deleted. The suite's NAT coverage drives TCP
> over nc, and the merged SCTP test has no conntrack in the path, so
> the SCTP branch goes unexercised.
> 
> Add test_sctp_nat_connect_v4: untracked client traffic to
> 192.168.0.20:4443 hits ct(commit,nat(dst=172.31.110.20:5555)),recirc,
> and the post-recirc flows match the translated tuple,
> ipv4(dst=172.31.110.20),sctp(dst=5555). Reply traffic is matched on
> the restored original tuple, sctp(src=4443). With the SCTP branch
> broken the translated port never reaches the key, no post-recirc
> flow matches, and the association fails. The probe flow uses the
> same ct+nat action as the real flows, so a kernel without
> CONFIG_NF_NAT rejects it at flow-add time and the test skips instead
> of failing. The config fragment sets CONFIG_NETFILTER_ADVANCED=y so
> CONFIG_NF_CT_PROTO_SCTP is visible, CONFIG_NF_CT_PROTO_SCTP=y, and
> CONFIG_NF_NAT=m so the reference build actually has those pieces.
> After the association succeeds the test pushes a known payload
> across and waits for the listener to log it.
> 
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---
>  .../testing/selftests/net/openvswitch/config  |  3 +
>  .../selftests/net/openvswitch/openvswitch.sh  | 93 +++++++++++++++++++
>  2 files changed, 96 insertions(+)
> 
Reviewed-by: Narcisa Vasile <narcisav.kernel@gmail.com>

