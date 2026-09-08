Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00033DEFE
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836229; cv=pass; b=oYYsklGr2R70pIUAM7KRPIn6vwwsVpF+U/m9fAvX8ti3OarS4XQpf2CrKePy43itCBvYoevJvHBg7Mab1DiqL4pr6BDQ64M4CCuwt/6Wzqw+dZNDYEWvU5Dsrld7o0KMxEeYzS7l2gMIHv60fMUK6nXjl/vcpoWWYC9dfAv+/2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836229; c=relaxed/simple;
	bh=7QT6BoZEqcPorRF+41Olle15p4YL12kp6yZbrGZ8iLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGTFlVYgq8zYu47AGc8OGHmGx5nveZg4cVm9RrQQ3/KQUPL57XOC+2dtrwYrir1nXMJhc2/udX9EZ6BZyefGrfXBD+L/b/o8IxYfsAZMiWtoOkrJ9inqUpDgknZowYMTn4inU6C/ukqOnJ/2lq0Y5FQTnJ7Gq3C4Zpj/tt8YAsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2+lXPuH; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2+lXPuH"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b4af4be667so3969789e87.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 19:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788836226; cv=none;
        d=google.com; s=arc-20260327;
        b=KxbKlHtyeoiwp2kY7xQU7zoUrquAQqeFya+24vd1p+k7z2JOegmt3u9m8pWvRGCQ2U
         QM/QyzVYqibtTFBXOGDfawUc+wmNPG3mX735omix05wMORXQs7CTxt/Vl1PAvwA0ZO/j
         LSRkKlMpq+H7WgqK6BxhatlM1gA0XxOyqe5CnuCoGD+Q+xlQxmJ5FnM7JYzHidOG5rPg
         3595y3VAUwxz7KVW2Bn5Du9nHH4lKjC7c5egqEjEhSmjftg3mMhp719WZC0yar0jYGKs
         wuSbWdycYQJEtMhMnyXKOSJ1locc/ezeoiz/qqwJIi157uzGvpfTIPm+C5J8LIV0Ve2a
         7HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7QT6BoZEqcPorRF+41Olle15p4YL12kp6yZbrGZ8iLo=;
        fh=PJdU92ap69QW59gDtIKb4Xt15jiITFLE5VPjzskStIM=;
        b=j05Uknu+8MMXkJggcgCvgWnsF3LKdMqeVU6WB7UujYiuXLDb868qvo5kIkgio2zTO1
         3zyrGjiUJEGKYwntZuOSKvElvrAThMnh5rslajbpRpHiCVss/05/s3SrZjsfaMt8tFry
         Bn1ue84wDk6Bfp/qUC/aYj5wTtl8vEPtbMfekkQLqznwF5HHd654WyQTALBLHimkikv7
         ipbDnUKj+lzR+Vt9QNggvsuA9k3fv92VSwZfxSV7ebbNGXa7Zqq3og90AGkY5CyzZorI
         xIvT5SVXvV5w42EopwtGuLryuI+Tl+LYQyjJZ5XcrF/g6giorB3MBsonm/dSvLFp579d
         NvEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788836226; x=1789441026; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7QT6BoZEqcPorRF+41Olle15p4YL12kp6yZbrGZ8iLo=;
        b=Y2+lXPuHDzNBPhBHm7jD2JBjY6yYMYwVQYJWnYYCNDXyEDrSHPVx062hLelr0OP7Lx
         HlnlBP9W4TBcrQZVdZZJbLlJo5D040Y0a004yCzzO5gG2SfyyBSbVdKcAfePjvO3Z49V
         VaneVhUtpbu8birBJq2hXka/T+FT6NbRRPQ9TeLMxFN45NGvH66PNFG5SKtYgfsKA83Z
         mGO/EbGfm2wW4ti/6jwZRUX3PcDX6HhbjhnmBqCS06lmbJE89QO2bIz0p69e9NKj5klX
         rwcR7apqWKvjpq0GM7e0RNxqwUqYhOk/dgIAAWcU6nJLkXn3XvjuypH9uDzkb4LG54gp
         s+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836226; x=1789441026;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7QT6BoZEqcPorRF+41Olle15p4YL12kp6yZbrGZ8iLo=;
        b=W5SKJ8jcg7/3c3PSVgPrZRCAUzvbIw9cDAEvOPucyXSwExfyn9LCWmlfL6c7aeSXhE
         YCww0iczUT1abyOSKNZsnLLeWNxMEvN1KEkYcRIM1D2Qks4aK8+xCWBZrj5B5jHyTBoy
         JBy2S5OTYz7wu4Lbn1FDk5LfP3zTf1ugPG9WzPYgmNYKQClm20Z3IKCtEYt/6uU/Cs5c
         Fhtj3VOBI7sofN7ahXlReOUy3Ep0QUDBFKXqMRaokdKR7NmdHG7Lx130mT2LHuiCi68a
         lFSwipvdE+fbTe0H42tzG7k2TNbSHFTrZIk+WX/W0SwhI7NvtiSzBna+pcwyj5zcZEjc
         F6vg==
X-Forwarded-Encrypted: i=1; AKwUvBxlKmcGsdIeg19tpXYEAsDVKQ+8j6fyliW8YMkWUSeJFkJ6HgvHwC/KA+mWbqYkNhq+3e0QrRw=@vger.kernel.org
X-Gm-Message-State: AFuF++lX6j8j6z0kyhcOxeAKEZvL/GyljPJXDWtl8m5VE+DzV1R9GiAf
	6g3LWnIYK+MGSLEcv+SbruqHTg130LoQenEFBxcS8T43evJjJpyv+cm5wCqLadtVj6/qPzV/sM7
	s3rpO8tEFso5RiPYMDTaSA8NZpDAnsA0=
X-Gm-Gg: AYBFou1LvFTj0KYPJIekQKDa3IZwjkWj4WLdGfpZfqn+7jvVcUa9tHpfi51gFJj6N8e
	hRNvD5XvKpfJKmlDqKg7VbJ/b+XTHGSrJsIPllAeIBIlbEHfEEZqZUjHcjAa19vWEnJjL4E2T9j
	8XJ9TOVgdUHhlOVN4H7n5eXL6Gns73suz/uO/ctSg2DBvJBxMcYyPm7LksnuTjZyad+ymzlqRKo
	p7CGuGqt8z14L7QRuLVaCuntcPGrHigtZfjje8v6YVr8iITjNLowxz08VgwfE1EecedrhJWHsz3
	WTfCQkecphGgFshw7Ps/5VXTqYSH3QtYSa+KWy7ZeiA6mz+NSfmFe2P0vDLsg11FXFrRGbjnLZO
	pPTVfzVzUhZemqnz6OGUNZdtO+hjLX9yX8w==
X-Received: by 2002:a05:6512:10d1:b0:5b6:4ae:8c01 with SMTP id
 2adb3069b0e04-5b616f59cf5mr4175296e87.28.1788836225895; Mon, 07 Sep 2026
 19:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905093932.43726-1-sigefriedhyy@gmail.com> <f1e70062-943d-4521-976a-ae7c9fbc756b@6wind.com>
In-Reply-To: <f1e70062-943d-4521-976a-ae7c9fbc756b@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 8 Sep 2026 11:56:54 +0900
X-Gm-Features: AcwNN1U9p2sFJsv_7_Qjw2glgbmq-K3CoxGpp4O9ALykWZMch5RDUDwBJuNCCmI
Message-ID: <CA+7S2vL7Xm3nPw96R1+aN-sHLaprPxFUNw4qi6kbTAUu5OUyNg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] rtnetlink: dump link-layer multicast addresses
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> These addresses could be listed with 'bridge fdb' (RTM_GETNEIGH on AF_BRIDGE).
> Instead of having a new message to get the missing info (users), maybe it would
> be better to update the current API.

I looked at the FDB dump based on the suggestion and I don't think
that path works well. The missing users count is not the only problem:

It doesn't list dev->mc for every device. Only ndo_dflt_fdb_dump()
walks dev->mc, and rtnl_fdb_dump() calls it only for Ethernet devices
that have no ndo_fdb_dump of their own. So bridge, vxlan, macvlan and
IPoIB devices never show their multicast filter in "bridge fdb show",
while /proc/net/dev_mcast lists them. Fixing that means calling the
default dump for those devices too, which adds new entries to
"bridge fdb show" output on every one of them.

User space can't reliably tell the entries apart either. "ip maddr"
would keep NTF_SELF entries with a multicast lladdr, but it seems vxlan's own
FDB entries seems also carry NTF_SELF, so a multicast MAC added there as a
forwarding rule (bridge fdb add ... dev vxlan0 dst ...) would show up
as a device multicast address, while the real dev->mc of that vxlan
device is missing. And since a dump can't be limited to self entries,
on a host with bridges "ip maddr show" would receive the whole learned
FDB of every port and drop it.

It would still need a new uAPI. All self entries are NUD_PERMANENT, so
the users count and the SIOCADDMULTI (static) bit would be new NDA_*
attributes. On the other hand, this series adds no new attributes;
IFA_MULTICAST, IFA_MC_USERS and IFA_F_PERMANENT already exist for the
IPv4 and IPv6 dumps.

Covering this with RTM_GETNEIGH would need the default dump for
devices with their own ndo_fdb_dump, a way to tell filter entries from
a device's own
NTF_SELF FDB entries, a self-only request filter, and new NDA_*
attributes for users and the static bit. That is more new uAPI than
this series for the same result.

Therefore, I feel that my original proposal seems cleaner and causes
less chrun. But feel free to let me know if I have any
misunderstanding on the suggestion.

> FWIW, AF_PACKET seems strange to me. Isn't AF_UNSPEC (like for interface, cf
> rtnl_fill_ifinfo) more appropriate?

For address dumps AF_UNSPEC already means "all families" (RTM_GETADDR
goes through rtnl_dump_all()), so I'd rather keep it available for
RTM_GETMULTICAST. AF_PACKET is what iproute2 already uses for the link
family: "ip -0" sets preferred_family = AF_PACKET and sends it in
RTM_GETLINK, and ipmaddr.c has always tagged the /proc/net/dev_mcast
entries as AF_PACKET.

Thanks,

Yuyang
