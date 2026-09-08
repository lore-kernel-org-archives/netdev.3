Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6694EBAE8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859426; cv=none; b=hTCdr7NJcXWGFO9C9FOSl9hILz7VecvTgiYyey6Fb2Dfgm9kCkrhSVpkFcJc1Vv1SAEnYwsFHxJPqQvknNulwpvb3l/MPPP3+Z6pfoycjYuZ8QS/qFj0z4iWG+ljODC9Ghy4rgb7ZTTozzBQWyFWbHuhViCgorT7cM9j0KxCvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859426; c=relaxed/simple;
	bh=mLkOSCuGi1F7ikEomA0pBOdZqUpW2PLmvmHz8wQqwLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SW3QciBLpMqDPWTXPRbCimlxGWF5dGlEApi8YTNIO3cK5gDwVLIlzwT2/u3m74979kDhfoLFMSlhgs9/cv9UqNjwOtmmnTfEHtF1oKSwyPZ+aVQu35gjON+HW99+qQgiRCbIdSeTYYOqboF/uV70wrdPCTh5mP1uSvs/s2WrNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=OBb9CaMf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="OBb9CaMf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1ddd5d0aso110245e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1788859422; x=1789464222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+mhExZfZ6TbLaX0jntmyh/vvWLxB3x3d1zAJxZ9rmVU=;
        b=OBb9CaMfL4221ZFbRH/HbdxIWW6DIoNgMV94ARqwmLVnCrc/3mdwQwIJ66SOSQZX2G
         fdErsdXQ3kknseEQ9RZHAGDNpZvGtlI0kN1nNu3P6wOppFqgAICgPTcsB17R8HgZTj+c
         cigPGCvCRrN6qyVimn51tK8Sxv8yU3wTamN8FzWMQnPP2bpG+SU4qi4lDIuvR2VOuPAA
         NMzAhNe+cSxb2cBiD2SPw5SNUoxFmpG1r3s/kCs4KMSFkuLVxyCRPZ4xAvSasPZewcFP
         Z+U3/4pIKit9Q39gSrkMt6UfO1u2S4nLnd8mLZm0vP7zVJ/jqGPVddjeiei1DEVctDqs
         HRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859422; x=1789464222;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+mhExZfZ6TbLaX0jntmyh/vvWLxB3x3d1zAJxZ9rmVU=;
        b=ChU8XDg4JrMt8jfd0uBbWI715OZR1XchdOzjmmjXuwk2rHyAjryQI/75YV+OutRXcn
         +2dsmh1FIv6nWx/Etjx3qfUOzk1kFpA8GLNGgunzLOF9QHd5K40gJpyWE5Vdr5pFIYw5
         1rikmqG9YB+vRb+qL/p9p4Q0J0ZJMDqRItFgUcS7ddQw3SoDSFPGbHsAEEHoQa4gNXo7
         8sl8NHJbSmSwbaNypeXcLHbySX6XCC+i3otWt3p803sT/CMVwKCCOOI1x+DNGc3+CDvu
         AvJy5DiyDQhtkTQXVInXhu9Z2rYbGibzIzJIBNmjvgiw+FpDcLaXMG2RFC11dAiVjS+n
         CTOA==
X-Forwarded-Encrypted: i=1; AKwUvBwyVPTcID5M5MUwQuvIq4heG9dpY78/aIfTHV+MIOqOPutIbYO+0eqzJiVyjQqkiTFuQyI6ti8=@vger.kernel.org
X-Gm-Message-State: AFuF++mwPj8n1nBdpgsjLfaCVmhe2FfRRtQkkL/wiEq6/cYKPPxJoBbH
	pOugfxWtEP8srNKUtoaOdKlg8S9XsD3/HQBIAaGTs1ZeKqNOT26I8nT1uxS7UFWN9bY=
X-Gm-Gg: AYBFou2pJjE/WqPbqEWe8t8PHHYD0nSS7379eWPod6IHEJMp9D5IIAnNwxpbPkF7fBz
	9YsV2BtFVI3b4UoZqdBoPw350ALX5GBgboUeyNnUGgYfm4lVSYEWsAtdUEQaASej3k+i1zXrbrD
	dlYhoSDbT8pgWlfLqj0cn+snpNRRip1SKlJaT7+BrlbuXfEW/Hj88iorDE1bt/QFLbo65p8ik8F
	mVlxAZuCC4SKLg6J96cxV+2MeW0ucR73hwZpCj8jR1tKSBy/V2dd5l5+Cp6+wI6C1Sgt/Ni0VsV
	/MPoeXOIGEy5GnGRHKvY9BDAfqMq7DH4REIYy5p+ISeVeYwJIvq+q2/MS/HlYAwt2DbNoTwc2bL
	k5NnNOX7/yZcL321M33cvzsasxFQvebfJ7tx6bBsl0WmqA3616PBRw4A9EKzR+x+AU37e6QK9+c
	m7Br0ow1ZJ8Ab4lbomDTUiQ1H9z8ZOjsA6CD774nYO8jTHAvS50RS8kt1GNxUprwtfU6u0pRZyz
	de2d3seiZAVww/ft+0m6w7TK5QgE+izXXG1IvJCUg==
X-Received: by 2002:a05:600c:8485:b0:499:5b0f:72b with SMTP id 5b1f17b1804b1-49d01dcc32cmr174560475e9.1.1788859422430;
        Tue, 08 Sep 2026 02:23:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm340468655e9.3.2026.09.08.02.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:23:42 -0700 (PDT)
Message-ID: <53f0e11b-f464-48f1-8df3-f56d113d7c01@6wind.com>
Date: Tue, 8 Sep 2026 11:23:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 0/3] rtnetlink: dump link-layer multicast
 addresses
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260905093932.43726-1-sigefriedhyy@gmail.com>
 <f1e70062-943d-4521-976a-ae7c9fbc756b@6wind.com>
 <CA+7S2vL7Xm3nPw96R1+aN-sHLaprPxFUNw4qi6kbTAUu5OUyNg@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CA+7S2vL7Xm3nPw96R1+aN-sHLaprPxFUNw4qi6kbTAUu5OUyNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 08/09/2026 à 04:56, Yuyang Huang a écrit :
>> These addresses could be listed with 'bridge fdb' (RTM_GETNEIGH on AF_BRIDGE).
>> Instead of having a new message to get the missing info (users), maybe it would
>> be better to update the current API.
> 
> I looked at the FDB dump based on the suggestion and I don't think
> that path works well. The missing users count is not the only problem:
> 
> It doesn't list dev->mc for every device. Only ndo_dflt_fdb_dump()
> walks dev->mc, and rtnl_fdb_dump() calls it only for Ethernet devices
> that have no ndo_fdb_dump of their own. So bridge, vxlan, macvlan and
> IPoIB devices never show their multicast filter in "bridge fdb show",
> while /proc/net/dev_mcast lists them. Fixing that means calling the
> default dump for those devices too, which adds new entries to
> "bridge fdb show" output on every one of them.
> 
> User space can't reliably tell the entries apart either. "ip maddr"
> would keep NTF_SELF entries with a multicast lladdr, but it seems vxlan's own
> FDB entries seems also carry NTF_SELF, so a multicast MAC added there as a
> forwarding rule (bridge fdb add ... dev vxlan0 dst ...) would show up
> as a device multicast address, while the real dev->mc of that vxlan
> device is missing. And since a dump can't be limited to self entries,
> on a host with bridges "ip maddr show" would receive the whole learned
> FDB of every port and drop it.
> 
> It would still need a new uAPI. All self entries are NUD_PERMANENT, so
> the users count and the SIOCADDMULTI (static) bit would be new NDA_*
> attributes. On the other hand, this series adds no new attributes;
> IFA_MULTICAST, IFA_MC_USERS and IFA_F_PERMANENT already exist for the
> IPv4 and IPv6 dumps.
> 
> Covering this with RTM_GETNEIGH would need the default dump for
> devices with their own ndo_fdb_dump, a way to tell filter entries from
> a device's own
> NTF_SELF FDB entries, a self-only request filter, and new NDA_*
> attributes for users and the static bit. That is more new uAPI than
> this series for the same result.
> 
> Therefore, I feel that my original proposal seems cleaner and causes
> less chrun. But feel free to let me know if I have any
> misunderstanding on the suggestion.
Ok, I agree, it seems easier to have another entry point.

> 
>> FWIW, AF_PACKET seems strange to me. Isn't AF_UNSPEC (like for interface, cf
>> rtnl_fill_ifinfo) more appropriate?
> 
> For address dumps AF_UNSPEC already means "all families" (RTM_GETADDR
> goes through rtnl_dump_all()), so I'd rather keep it available for
> RTM_GETMULTICAST. AF_PACKET is what iproute2 already uses for the link
> family: "ip -0" sets preferred_family = AF_PACKET and sends it in
> RTM_GETLINK, and ipmaddr.c has always tagged the /proc/net/dev_mcast
> entries as AF_PACKET.
I hadn't looked at iproute2. It uses AF_PACKET for link-layer addresses, so that
seems OK too.

Nicolas
