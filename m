Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82309488216
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601297; cv=pass; b=cOKlTr9oUADQDri7RLtMQ+AYf9DotfqHPqP2gqjYSEDzBVFdlodDy3orL3bqiQp2RN4efnwOtUeYaVuD50MTU+SwVQBMleLPXMx9O3VRS6VFgZ/tONdii0vKVz5/z1dYTazzRGNuLOc+aN0Aw9gzfAN0wfMH0q2/aKdCn2jGa/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601297; c=relaxed/simple;
	bh=IMxnQufaCzkTXnRiyA3ZHoFemW5xbKd7VwJZP/04O/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjTwQjY42h+uYQ/cHmA++93qLhq3aIxf1nbyEzexxY/Yi6/UF1lqAP8HCMGEc07JWZB/yCqepvFd3RyXH3dIJzQLgga3k9gA0Vk9oLK7A0SR1gJVbgsPLdo4Ct9YSCfhXDK/sXfeDRZqO8wvjnrqzfSbo+3KjfkmfIZkl6jgWo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grV7ytMk; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grV7ytMk"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530e28a62abso47881991cf.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790601294; cv=none;
        d=google.com; s=arc-20260327;
        b=iGCtwzHf+Scn3poAh5dSAgv4wq2vKXK1IKebZ47kNn4l7NXstiHp3dqjvXFWQfJuPB
         AlyG2N8JvSvOvq93j+N/7EMvd1tsjxs3DWmmtACzF9wP7YgutsI3PYCReUVJVmBCWZI4
         X6/URUhTmA61y+tD8maPHVHgL3jiPFT/VCBeayy72PxikFDEtmFI9UOMEOZA/8ge8KqH
         pFYD+H5hKx29YJZ58WXZi+P4EuTUp8RLMvH0pOSYksMBOfi1s6ylYUpJ37u2bVJbzOnq
         LAGMao2/wKgxBLfOevvlOuO40qXqVeRsYL3ODINsdcwRaW5CLVr41Y+G9rlEDSXM3zCr
         xtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r1SMrAH1r49vvILpAa/qi1ETeV/g0f8aieo9GqOifRE=;
        fh=QIuF6Ev5ZpCsQWw9aXRWju/UpdE00PmMGgB0UzZXleA=;
        b=IpRohLWFDkWJh+dJFPiOly7cCch8A/u1/wLaNlCRGdesO/qjyRBA5ApLLZOBfM/BSJ
         KLLwDxsZZFuF/4GQms6C3oeJyrEiADSI5BN5K28hQmRjhxPLlhysoA2+1/9Emi58sOps
         BzW5vZJbOzs25zx0gkTWAj+5BDuQ5ezjhAzYkCibrmx/4NEb7KN9S9fzcglxil0w8cwh
         WxMXnUejmUsXAane6m1VEeHKn7VmNALl8bDccGM+KNKjAcwc3gmrCsDat6OKJNwsibiD
         3mCr8vjqUbyiUcV0ko3Don534yxN7hpBWpWmgdrJfvlaKSztfxIR18KexAvoGg+qOjIt
         VHGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790601294; x=1791206094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r1SMrAH1r49vvILpAa/qi1ETeV/g0f8aieo9GqOifRE=;
        b=grV7ytMkznkmsLJMgoC915w30CVc5DufTFFB1izaV5zbhkDj9o3tuJcYICxMa0xXh1
         1yjS0RUa27bib2r0wiYcjlEHuzfj6McjEIL9kolEQjKNpnZ6IXv2Qgeto4kuF2zB1yq7
         xPy+3gH0mTzAuOOOlHU56HWyIyzApaaVmyLqWTTHSeCvQ9WRfr4ZN6lFKzsnNzyN6Drf
         uPSnedrcIQsHVubCI6QaGlTExlh46KSb9voDYXHJ3yOOJp/UhX4IJqUbhEVPNOp5rbLA
         wED+X/LKTx6NX+5po5yl4aIVl5jov9iZh6MDfduTo4BJGd5yMCUYeQ+2ou78eEEGwkfY
         kliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601294; x=1791206094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1SMrAH1r49vvILpAa/qi1ETeV/g0f8aieo9GqOifRE=;
        b=VRykS40dBd58u44on0Hz2A5qCMmfrAq+IREP/bT46iYRzb9uIOF93rlzLHkhQbJFH1
         N+VFqCNUovL8XOZP7SYE9KPYUP6untm7PaW3LehC0j02O3dV3H6kPheq2TXUhWYR0Td8
         MYqjLsLJC19N9C31OfmfuTpzcdO6o86qb7g8nklu+yVtJ+wyuzYY7drOpO7ietF7t5U8
         mCyE21MMLHxivlHX6l6fg6/GOHiHU5HLhLcLkScQjAvjAIQf76KdvhfB7rBtAs33PJZ1
         k5L/Cmm9uL0yk66g6Pz9SEAU2Yd5Tr888FukdHjnEksDqEaolzxhrlHVubyKJCbMl50/
         KqQA==
X-Forwarded-Encrypted: i=1; AKwUvBxeIChB9PCbtCQC1qSuW1jeGxyGRcAUwpc2VxXb5L+2VABVX6rSO5m3XcffWq0HARcRzxNGROE=@vger.kernel.org
X-Gm-Message-State: AFuF++kNDIbVDEFSiIp+wyJ8y0OvLP+Ecd91IvPyDYN8CR4o6SXI6Sjd
	7DLoH1lteQCWTzJ7twQg0FsboVTkrA6hSsqjec2WbP32Wd3TmsgGfZz+qwD0AOaK7ym42tprVrZ
	SSxn6SwHEKOxlrlzERuxrHae5k9L3jNUJSvWhqPeB
X-Gm-Gg: AYBFou3p7tU9ouFzbKT/1jZcJGKQ9JGjmo4JOr09sHkIOefkfaOUmLu00gAhAZWuem3
	t/omJePi0n3SX9L3y6s9NAk2QgLs1tqCcOXFzJWipJpEhAOg2ZfIJy9wPlOgfBFyIlCq4tgnV8/
	QT1lSmSmNi8wdhwN0RMHl888ojg9T23zBFehfeKBkwIWM9kWDwx65rexfMQmnt/qovkizMG1T1w
	LzKhso1F82ncUKAqcQeCV/Qhjoqc/MVLU5+TqEXPhE9V60YJcGoCL5iNA0bhPkvKpWdJwhmR0p4
	QWbNnlpcQ0wwVD17vMPxCUKfboS2u5QYjIqBghiGuRx3Fn6PHhy0p4uflD9sFjk7VnB3yYfszC5
	4qDrPlmW1hlcFrVvzHJJyT497sdTOUDMzvPKb5URJg1+PHG+R9FL18eZiTQN+AUUmrha3zdUscW
	xFhDk=
X-Received: by 2002:a05:622a:2b08:b0:532:9f90:3f71 with SMTP id
 d75a77b69052e-5330d89f6cdmr193121291cf.0.1790601293475; Mon, 28 Sep 2026
 06:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928121454.901306-1-nb@tipi-net.de>
In-Reply-To: <20260928121454.901306-1-nb@tipi-net.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Sep 2026 15:14:41 +0200
X-Gm-Features: AclHuK_YIHb9fudcU1XrJHxEBilDeQsn4mW7Xal9HnNTD_7lep8Nf8pWHwC6TD0
Message-ID: <CANn89iK5RTtZLPAY+rJKCeUpLkCge+PFqfN-g_M184S9fyzSsg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bcmgenet: complete Tx NAPI after one
 reclaim pass
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:15=E2=80=AFPM Nicolai Buchwitz <nb@tipi-net.de> w=
rote:
>
> After reclaiming, the Tx poll asks to be polled again. That extra poll
> finds nothing to do and does not reduce the interrupt rate.
>
> Complete the NAPI and unmask the ring interrupt right after the reclaim.
>
> On a CM4 this raises 60 byte pktgen Tx from about 187k to 224k pps and
> saves about 5% of one core at TCP line rate.

Reviewed-by: Eric Dumazet <edumazet@google.com>

As a follow-up, you can get rid of ring->lock in the TX
fastpath altogether (it looks like a leftover from before TX reclaim
was moved to NAPI in commit 4092e6acf5cb ("net: bcmgenet: use NAPI for
Tx completion")).

bcmgenet_xmit() is already serialized by the netdev queue lock, and
bcmgenet_tx_poll() by NAPI. To make them lockless with respect to each
other:

1. Drop ring->free_bds and compute available space from
   (READ_ONCE(ring->prod_index) - READ_ONCE(ring->c_index)) & DMA_C_INDEX_M=
ASK.
2. Use the lockless queue stop/wake helpers from <net/pkt_sched.h>
   (netif_txq_maybe_stop() and __netif_txq_completed_wake()).
3. Ensure proper memory barriers between populating tx_cb_ptr /
   writing TDMA_PROD_INDEX in bcmgenet_xmit() and reading
   TDMA_CONS_INDEX / freeing tx_cbs in __bcmgenet_tx_reclaim() (since
   bcmgenet uses readl_relaxed/writel_relaxed).
4. Avoid sharing ring->stats64.syncp between bcmgenet_add_tsb()
   (tx_dropped) and __bcmgenet_tx_reclaim(), and serialize
   bcmgenet_timeout() with napi_disable() + __netif_tx_lock_bh().

Thanks.
