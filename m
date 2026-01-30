Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6F308F1A
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817224; cv=pass; b=ofY4cwxvxJueXzdFENxBT9qxEjLIhwwBueRwFUEa/zPRZRonZbCtOm1scQ8AffR0mtunDTlQBaEQ+KBK3XLMUCCnwUXw188lYUBMwiTMR31ZFvv5Wpz/rmlI6VCiufwXP6bWW0oksPdyJo//lBdD7m1hK3uR+SAw7IxhOFoB9Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817224; c=relaxed/simple;
	bh=1d9YOiG4jFqmU1NDXS2YzRpMa0FxqgStJnDc5X6hsWg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o6XxhRRQigD0zPNSBB2JhzP9FQ4qTH8jC5ZuOMI0CddyOvvJpuFhf+IYSukmckVPbMtb7EDCXN6/Qw/l3L3OZHZhN2Prkn31Ndfp6oFiT5Uqh4PMm7eMdrqu04KzWk+WL2WoIeu0erSngHPxs6XBYB9ECZ1BdlGAJdRxlX8bRfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCkAZzdS; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCkAZzdS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-649ae700ba0so852135d50.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 15:53:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769817222; cv=none;
        d=google.com; s=arc-20240605;
        b=HgouuQyZrLr/HHZRyXWa0PwXkRhdtFxiLByg9rqd2rx8oDjWD7gX75GtvioELV4sWB
         lF+aws4+31HraMRSLtNKVBIuPxMHjoCCgpg61ThN9Wc/krFaWEIj+OSzMh3h5tTNhadX
         KEmXJprWzI+4D8UZI59m4Auve0IVSrvNYbBvmHQRgKFqSoEGbU1+HEeNKGGRFC7pMl++
         oAoEodmf5sfG+vhQAOOE3WDYf8nYieo7u+/OXGPaU5/DpLb0L2HCuvBcMKljUlen9ED5
         ba0TjWoYBCAfBwhxc4De7KfNum17UYPtoCKV8mqppvAtutpDaDQnY/GsAOGcJ2YV3Al0
         DE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1d9YOiG4jFqmU1NDXS2YzRpMa0FxqgStJnDc5X6hsWg=;
        fh=9V6P1+Wa0rOQjm0S9ejPMzXfdGgrFi6cCGuhEzFBIn4=;
        b=DfG/wYhA50agAdUOzbpnibs4D8dq0XUnhmDBvB/3g6xkd5/Dd/akE1igoeB42NVv22
         bk5ZerY7zaHovuVROW8Bl1Fc8zMX//mT2Jy89IOEYsNaTniVT4E6h1XHk0HgOcN20GBU
         AtpSllSQupm5zShVv5uxz9TVi5lUeloHQbRjjxI4sPniYbbNTShE1aP4s/dHlA4/QW0T
         x0O3bZ4vTxqJDvES0wAbPj0TgAo0mh3M/H/qsh4tlzJ6t11nA+G8b0zNiMqylLWBpnDO
         XQ45xPxR+RoGqeDCYJolWr5C3bRWQN4kvUDN4v9uxmq5g6TRRM1qP82UJhT48NOFS8Qh
         XuAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769817222; x=1770422022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1d9YOiG4jFqmU1NDXS2YzRpMa0FxqgStJnDc5X6hsWg=;
        b=bCkAZzdSfgWr5MSP305rboSiB17TO7WkaPRpypjfAFUM7yhCKGdww+p7RKJRRqopWf
         RaO/8Oed+E+uJ9X6AuRonO1mB5VhsHSyWlw7SaDpnSGs/znR8yB7CF2UDgNtd7GuRet+
         1FDdi2uNDkWXnFlSSSC+nnBtLhbPBIlNbBE8UwthYFjk2tzCvRSEifgZaA8in0nVI0gA
         JHKdwNV6DBCOts0by4bXtJaJ2zYoszpwyVr6edkrE9bF/4G5C0c+xO//nXCkYNapvF9A
         3yvkKxoE2l75vCkAS2OtT5zKiSrXu54wPuLL3wO1eZsKaYu+xSstsNedA4liGfu2Gkjs
         zXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769817222; x=1770422022;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1d9YOiG4jFqmU1NDXS2YzRpMa0FxqgStJnDc5X6hsWg=;
        b=niHNe5GY2Z4W6EOwoSaAcWurgpeAT4hZRQDPUwvajg6ZmE+6eeC8j/ZLNsF4chV0kv
         tQQP/3mnYqQV4z9/Ezo/av1bNqrZVIWanZjKYtk0NiL/U3IWrjfvLOPvHhOg5HSa7w/G
         ilFlAE0EsfvlL/Opm02nBSfUuWAcM3vIThWTTDP4vkATO5rYCDKi01RFmDP9I5KynYPq
         InPCg0oEoZdgy2SgbuXSftboM2MQ4fBbTjQxrwGs7xWWrR0JjgPtTPc+xsMFRQqLBLaD
         GIBvg7G1fOF8Ixsh40UoWZiDxTyt+usv7NsU/3jA1FJnTW/0NEIwlvE8S2DEQVw8weXs
         f6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUADYTwz6rz4xOZMejznuclAzjJGrFtIDUeiOKB5PwRxxjW0kDSCB1Whl6pZYB/i/3Rfwu1Zp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya26ROvBjbkXCeUcmHDAJ+MmIV5Whq07OnGgmW0am5vDAED/KO
	8Lh2IXXB6XRAVBRGtOIX8hDG6iignOKzC+ftpdvURwiLonqhKIh6toHbe8NgQjoCD8ShWt8c6X6
	6yuEii4zxou2DITYi772M619Z5JHwslA=
X-Gm-Gg: AZuq6aLYMx1LRXVomlLekr7YFbXlsVMQpCQzEhhKfRcd+3nWf7WrPf+hSZckonu9DG3
	enFSmOby+YXI/wt72hI6Ph4AzxMz+JfJALjEgtc280LHCxB8ILg15D1AyBpqrkVGAzC/t/EeVZ/
	xvtxlRz15mCh0uyFpJRSkRhe2OGRcGnpUPJF1TwlToCF5/OJL5DOHR/bvBzZU9F9uYXEuqVs1b7
	l/aEZdgHZxmmfDnTB8j1UWvijZRN8LB+r+mMg8+1OA9Uj18mb1q2S43ZIBUyWWQN2vLRAKQ/kEE
	s3aW4KPiGhBtWLL81/xCW/8StxBsUuhTSB+8HHz3
X-Received: by 2002:a05:690c:c4f1:b0:793:99bb:62d with SMTP id
 00721157ae682-7949e075b0fmr90826507b3.55.1769817222369; Fri, 30 Jan 2026
 15:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hirokazu MORIKAWA <morikw2@gmail.com>
Date: Sat, 31 Jan 2026 08:53:31 +0900
X-Gm-Features: AZwV_QiA_mdEdnimCxhHdFtlbD6FulKfZC6Up31PRQnuWagDgHC8X5T8-9Ky3c8
Message-ID: <CAA2RiuQr=OaaSk=1AVKQFjWzrHO-8+qU1TN3_C05U5FyE13k6Q@mail.gmail.com>
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
To: edumazet@google.com
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, Hirokazu MORIKAWA <morikw2@gmail.com>, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

> Can you provide detailed instructions ?

It is configured as a router.
OpenWrt isssue link: https://github.com/openwrt/openwrt/issues/21737

> I have no idea what MAP-E or DS-Lite are.
MAP-E (RFC 7597) and DS-Lite (RFC 6333) are IPv6 transition
technologies used to tunnel IPv4 traffic over IPv6-only networks. They
are widely deployed by ISPs, particularly in Japan, to handle the
shortage of IPv4 addresses.

I have packet captures from 6.12.67 (Broken) and 6.12.66 (Working).
The ICMP request-reply appears normal.
However, the ping command does not return a reply.
