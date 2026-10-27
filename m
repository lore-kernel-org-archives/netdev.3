Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090884;
	b=KT94UFX2aaKhyfchY+OqTLMhljjufOyUOr91q3I6fV8X8ktdb76HcUiXkru4cpv+2OJk
	 ocMpxNymnHyo02lHsRbeCBS+Q3aFmi3KiVhNSnY6UDK9mlYPBXf7pjHKikgGUvABG17ZS
	 4bIIQ9GlRZBRmDZ8ZiTBUZUSIbtfkjkj12dFfMPsc8Z3z9Ul6aRZzZ1IqOIFQtyB4DmvZ
	 h4gJwxkcVFpl8T7qAeNr5c95//OFUyOGcSytgVlrPy8OR9Yyqx1WVJ3ShgVHxW0ghyuS1
	 cyVrvfzjjXQMHQeg6AhYt8vjf5X49vjObBw8BHnLv8ddGYgemwZEn+PTIoyXVOM978A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=iYhHDjJRr+xqN1H/R/LCOfBwAItVWeWnf6KB9UCfWMw=;
	b=r2KpTxCf7Hxtuu2dDqyIdBH38gxRcbZ0vXu+0p6qE+bzD40KaBcGxHVDraC05gYrx4aF
	 JH4/DxYXer7/JDxJ8xcgtw/1HjSFDA+K/iN5NvTJr1yJ0DNnKZ6JEXcCbTFufPNKr4S5L
	 V6nPDnwyYMsP6MKPxwZatzziwuSAyquW2SYf6Jw5BSx2HsHkUFucRa50KuTDNRWd8AD2n
	 RF04nQcCyejqfk5rSwgUk26FrSQXu+uxDa6ECNLwrXTgXekTJmFCYvoWSMy5XKOdthH+1
	 1AR6R8T3/+cZfFHwzGYastaBfaJpSr0+r0Q7jOELtWH6Q/CXKOPMjSXaZVfwrkLPhSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=BeSQUFLf;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734D606A32E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B734D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=BeSQUFLf
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b127f1cc8so485491f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1793090882; x=1793695682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iYhHDjJRr+xqN1H/R/LCOfBwAItVWeWnf6KB9UCfWMw=;
        b=BeSQUFLfFpWE3/3/tLdSkrkJ49Z9pYNYkIl61PWJuJj/fRnG9z7nD8o9RY0T3bnD0y
         4+HJMHBgtudzPyAZVBfNe2ptvTzwiNVKsLsh2bvjWsC5N/AOE9Be7ImHyFJE2aIHsK4U
         WLdpFY3MtPJQEYbCD2VUB9RNOjntYoGPLP2tmZlwbPrMo7UHaehd3VSZ3u344CasmVky
         mBV9OspWzB7jTxU1Q11GKBRKi5N/8VTt5aKf6m3HO8+Rg6E4BY5rPfkaIOLZ3hJxDb1z
         oCM0ClEz+zl9KTMlLf/Cr/X7Qw5hwJjsRGRjNU0JZahu8w/HssH0NW2gyAsSsbXdDJp8
         yU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090882; x=1793695682;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iYhHDjJRr+xqN1H/R/LCOfBwAItVWeWnf6KB9UCfWMw=;
        b=xznB9gfURNTV2NKvyQ/SdeliUPHpnaBfnGw3Xetuz6lDV7PWAyXWLtNmMzB/0M+a8j
         23f52Q3T5ASiVBNwaseCRiAkbjXaeHhcU4h4tBu5pC7HOXnSa2gjf9mYEJZSrY/p/9Rr
         4sF5I8JALaJJ83qQ6z4dLzUNky3K/x7x41skwfuM16S9rMSEHc4eCABDVgt4DDSffzuJ
         87qa4PwRScxWX9WjQlXiVHXF4yxuIlPw5lc6KjdZl4AFWNhs62WwFSqvdXfU2bdGDSRp
         5oGljE4NNRR4GWIkHXZHoHSzY+O3SGRjdczCOwLblhwXmdAToFgW7v+h2xfd6x677PsT
         WqBg==
X-Forwarded-Encrypted: i=1; AKwUvByOgTr+WOGJUR9wBMuZHWFoU453m1I0iwdorC5dOfm5EDY0cSmH1oZ4l6n7tVZNiIk+JXev9nk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8cexMR9swZavHrNseiyfs5FV2rgYdqaOt9y7oz4fdovZS7TCb
	EOXHrEocuB/QbYlHSgMgQkp7Kor+BkAWODVrfMXNnYpcfXdMnCYAFCQ0pDyRgIE4H8Y=
X-Gm-Gg: AYBFou1y0e0nKhkrWMOSEQNTBAVPP++cthgTTPZWmYgv/qC2bywIM51n/uVhgdFqVQ2
	MYoolkHRNM3siZt6m3jYZeXqK7KRzgi1t/anCM9jEABOcwfbkXbcU31M7aNVx/qvDanPEK9lIzK
	eashNkV33aLv/zk1Wq1Xb5wsCiGjFKOLNrGdktXKqIswrvnrQafXReQeqd8g2CTyOGUDwQQr/ds
	9ito7i0vbCQ2ZOSGbIIPBzgxymIVpZ8VY3yvSIGWF4NLTEpoj23WA3iLQG72xSUl3S9NY8LQSGR
	SXOTRl9Z/BR6wO5wq5PVDOktl52xlK4aTt2uRuP5mECmx8hFA6/C+SDR/VDnzEQFwr9ehvgJlx3
	cLfghey0GA0WtfT/gG1bUdd4I4Qw5zEVmVyMUj2p23LmM65gCBIc5rw4tF+7PMoMVfi/ltVM+Rh
	t6HwOxP7ge2CfOlzvs5Dh+QdEKeNL4c71w2WZW2yjtZ0tDGfGQMaQnZyrj7aQ/q64/74hMCYwRV
	ui/LelxQEsn+GrFfVviEJJKP++mHxUKq94ZX3axXUmIqNe2kxQ1zqP8fhaZeZIQdYVVSK7Xkiw/
	3yLxDmfuNSCBu4jlU3HXlF3cqIKFeNAJBTJ9iaXjtQCNXxIB6nGCdQ==
X-Received: by 2002:a05:6000:40c7:b0:48a:f5c5:d067 with SMTP id ffacd0b85a97d-48e3eb36376mr20214446f8f.2.1793090881972;
        Tue, 27 Oct 2026 01:48:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3a1csm21700112f8f.16.2026.10.27.01.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 01:48:01 -0700 (PDT)
Message-ID: <89f607a9-c353-4a32-9362-1a5017b580ab@6wind.com>
Date: Tue, 27 Oct 2026 09:48:00 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
To: Anil Kaushik <anilkaushikwireless@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261023073738.2436362-1-anilkaushikwireless@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261023073738.2436362-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 23/10/2026 à 09:37, Anil Kaushik a écrit :
> The gtp generic netlink family sends notifications on its "gtp"
> multicast group when a PDP context is added or deleted, and for GTP-U
> echo responses. They carry the same attributes as a GETPDP reply: the
> MS and peer addresses, and the TEIDs, or the TID and the flow label.
> 
> GETPDP requires CAP_NET_ADMIN, but generic netlink lets any user join a
> multicast group by default, so an unprivileged user in the network
> namespace of the gtp device can read all of this. Found by code
> inspection.
> 
> Fix by marking the group with GENL_MCAST_CAP_NET_ADMIN, like the psample
> "packets" group. Only users with CAP_NET_ADMIN in the user namespace
> owning the network namespace can then join it.
> 
> This is still weaker than the check on GETPDP, which needs
> CAP_NET_ADMIN in the initial user namespace: in a network namespace
> owned by another user namespace, its root can join the group, but not
> use GETPDP. Genetlink has no multicast group flag for the initial user
> namespace, and ioam6 pairs its ops and its group the same way. This fix
> blocks the unprivileged users.
> 
> Tested by joining the group as root, as root without CAP_NET_ADMIN, and
> as an unprivileged user:
> 
> Before:
>   root: joined
>   root without CAP_NET_ADMIN: joined
>   nobody: joined
> 
> After:
>   root: joined
>   root without CAP_NET_ADMIN: EPERM
>   nobody: EPERM
> 
> Fixes: 50aba46c234e ("gtp: add notification mechanism")
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
