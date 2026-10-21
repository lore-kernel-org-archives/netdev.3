Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583806;
	b=0w5RKUc6cVhoJeMTS51wWRVe7XXWh2zAWr7viX1EaUGNTEAP3n+9aXQbWH0BIlfukLYc
	 RnqEnU6TXc5FstN22L5c3uhyqCeY6N2MAqzEbKkcq+5xgmA28TIrwnO/L0WSBj/wEVErO
	 Xd+95ryFERSCw71WOI94lxOXsFehQnaJxVoIyqwBRlAcD4CTIJDGKrsb7FztxvfxKryWi
	 jVXBLkC5Rfnb8CilGEL85uhjJ9Rns/xmbJsStAW4XgY4xWaeTA7hzehLV+h+Vg4g/loP6
	 XCgo+AiuEadL2GTbJvJ9+Fm96kvdesed4cjkJ4SXBYCazv/yZC6PSr3AWtSHSVapXAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=25HQcasjSxqCf6dqX+3PCt7YydgfJ0RpprQQR2JRC/4=;
	b=CsUjvivPSs6zFwiccmiEK3YwAxV0H1YsCormiHXIJnq2lHBDLc71H4TZIL627peQ5NGC
	 ne4BZiW5FKocmcMa3DvcnMhEn4nGsaWMQrqewQTYYYDF/bVQACg+YGIOMD4RO7J4b8IHt
	 8p6STeu5j3D4cJQCfaosvV4/TgziJH63o59QrHTLw51t7AujA6qUtBI+owS17QDDZ3HOi
	 7SOH/rDbCaDQnRGqMd8tPEwXf916fmG6jU9MYALDqkpc9mmvt42Z7AsthMLzeksOvwU10
	 3zmNQGif1CfHFZXA/LpgSUG2seTphy2iyB1vzsGlRQV2fII2A6z6LpF+rofiS2NAXoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pXCRWMs0;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B3606A32C
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF5B3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pXCRWMs0
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-156cbe59524so318670c88.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792583805; x=1793188605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=25HQcasjSxqCf6dqX+3PCt7YydgfJ0RpprQQR2JRC/4=;
        b=pXCRWMs0l3QRpaBSy14qZql0Lx3jKYNNyZ1lfjPRWlIng2vmo024sDDXSZ+ux57lN2
         Wf+mMi+agWX7TfzNVhoXmnifhbWVxU6vQHMMbJg8FoIGVfaupMgJBAafWXrQDcz4NseG
         vQ9GKUWJ8dN5+s63g0JdWb1lZzdDEti++QAkjOPPv/wv60Ajf+llkwXRZTPq2iD+bEId
         CxlhH4h/KOi2BUdwra4TKTlejg29OQfYKA4Bi7aPcLL2CGHtlYRF7NxnMy2vmAp9y6QQ
         ivc31XiWscm1hjaCscVFQU3ksqNQHyKyZeW3EqJiAnl+bh3F9WXtohJUBbuzXZKdhaX1
         qTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792583805; x=1793188605;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25HQcasjSxqCf6dqX+3PCt7YydgfJ0RpprQQR2JRC/4=;
        b=J5xBI9MPRpQ0H/u33XRc/KQV5ra+LmFfFLoCu5wPqFtlW6qwIqX6vxR3mtDH8lLvL0
         mGq5fpU9zEKmojNH+VvO+CPkdXQ3QEpUc2MmHr3CYVCOYi0kWlKkrSfvOzGvFaiB8DP/
         XTv7F5nwxTgO+vzn1dLvNtfLm6ukkGzr7cHOMXEiRKBauwKutr/swD5FZaXNEG3fToSN
         WsntSW9epl5TSg/XznxnGaNUFZQ1zEz9YFIhxK+mAOU+9/KKIP1/t5RXlFaGx5jshijc
         NE8rzmeHRix8qUWC04GOIAPeWsUuTRtyuBWFy+JoRxj7ldAWnE9O1ZkUjG5+lMq6zL+M
         Ye4g==
X-Forwarded-Encrypted: i=1; AKwUvBwB7CqZmYFLZXwhQURIY3LRiZDavHctL+L/UX7yQeEgg8q8xJ4fiojy9SXziq/e1KReSy0/9M0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQvcjrhkkwByFEQBjHfQIlZQTwck9yFWCaFry1CwnQdYeDEzEG
	3dB9AV+gcI0ULrcW9D4H5jmFWJkR6LC0blEhFw3mVdJpjrWjiJpBLma+
X-Gm-Gg: AYBFou0voU+BhB2khmImgpIfhN5UwBSAoEaSSr0fy0sEyVZ9jLBLrpdZpPgoq2ZT0cM
	z2v8qUs4BePWo0qPDDm3Y6bw5jTw02NbWnYH9YdV1SChDO4zIExWGhlH+OXsX/H0XjMSCExLQq9
	0qfvKaUzhjT/Spqxrxs69HNvQ2rqz6WmhXkNH7cbf4BTMUQmtGlQm4k8qYQ9mDSMVHwoinmpKe/
	rFfjlprfySGSFjEp9k+Zu5g+aAzHD0ASZEEF358HEbre5FMQxQa5/2ellmrAHk/+nMDARVK78wY
	ZJdTvJgk9rVPchrDq1wOjzzUCfEGDcXTPi9nKE+aVJURtWeIUTXOGQnQNKI4YaWSzVAw/9Nj7/c
	4Tq3i3v1jx+z9wul8lPGDZqAQQmBt8uCxi2ZOIQ7q/RR3D7Qm7QB8DAMZ4Egm0C3HSNsJZ6UclJ
	ALu1EUW3P9+HwbqsomliLclc1nFLghehgqLgQ+Z13oeNPrbyq29WuHCiYZnnapvsWdZ/zN7gd7N
	Ia2rTIz2fm42tj5ZZpHluB+U/dfbIhpCqB2reTA+K+rkQ58
X-Received: by 2002:a05:7022:2507:b0:151:ece6:b16b with SMTP id a92af1059eb24-190a4c1fa2emr3350163c88.7.1792583804543;
        Wed, 21 Oct 2026 04:56:44 -0700 (PDT)
Received: from dev ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e02901fsm6055020c88.22.2026.10.21.04.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:56:43 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel Goller <g.goller@proxmox.com>
Subject: Re: [PATCH net-next v3 1/2] seg6: skip the route refcount in seg6local IPv6 lookups
Date: Wed, 21 Oct 2026 20:56:40 +0900
Message-ID: <20261020031413.seg6-lookup-noref-v3-reply-5f2735b7@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020010429.eeffd6f140ec6157609c310a@uniroma2.it>
References: <20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com> <20261015-seg6-lookup-noref-v3-1-6d51a60a67d3@gmail.com> <20261020010429.eeffd6f140ec6157609c310a@uniroma2.it>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit

On Tue, 20 Oct 2026 01:04:29 +0200
Andrea Mayer <andrea.mayer@uniroma2.it> wrote:

> After a noref lookup, the "out:" branch still takes a reference on
> ip6_blk_hole_entry and then clears RT6_LOOKUP_F_DST_NOREF.
>
> This branch can be taken at steady state.

Agreed.  With a local next segment, every End packet goes through the
"out:" branch and takes a reference on a shared entry, which is what
the series removes for ip6_null_entry.  On v3, 20000 such packets made
20000 more dst_release() calls than with your suggestion applied.

> For a blackhole rule, __fib6_rule_action() picks ip6_blk_hole_entry and
> takes no reference on it when the lookup has RT6_LOOKUP_F_DST_NOREF. The
> "out:" branch could do the same, for example:
>
> 	if (!dst) {
> 		dst = &net->ipv6.ip6_blk_hole_entry->dst;
> 		if (!(flags & RT6_LOOKUP_F_DST_NOREF))
> 			dst_hold(dst);
> 	}

v4 will do that, and will set RT6_LOOKUP_F_DST_NOREF before
fib6_get_table() in the table branch, so that a missing table takes no
reference either.  The oif branch will keep the flag clear.

> Nit: seg6_lookup_any_nexthop_noref() and seg6_lookup_nexthop_noref() can
> attach the dst without a reference. They rely on being called under RCU. A
> one line comment about this, like the one ip6_route_input() has, could help
> the next reader.

v4 will add one to both helpers.
