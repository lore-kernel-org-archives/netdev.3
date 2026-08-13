Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51118415F34
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786652733; cv=none; b=aTwHF+rYUu1NlN8InPFSiWqogwdgfhOoWPmThPNv7pBmcuPG1IsAZ1YmJhJXgE2EFTuy8N4uPq11t4DvAmALq7D7LWKtzRyLCTvUMkGF/CBwd37oGILKXAs7W59Q1JYj62cRuTuWXFjk/oJPNBhyRtqHIBpBVft/T1BDNxZBUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786652733; c=relaxed/simple;
	bh=Wo2R99YxUF+IaLWHq6ZzjiYe36L7yDpPulu7D9fbkmw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JhaFCczWsKs0xTMoOvO5YMtArwEmLuZKWenjZYcPOe3QNTKwam5YVxgBCUHRKM8S7PtD8jtQGdg8TkK+GzEs/fCL2nXMeDVDGuOzpZ93SXoKqOIE5tu8mbS57Wtot7kUTt5F6LQowa2S/YN9cFj4EVu3aNnbcUIlETLtCOtuaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adnIaiXu; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adnIaiXu"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c67a73eb7so1008347d50.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786652731; x=1787257531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0qFSsIp/BSogxEOZHNXJYT5oX0PNIdy9cvBqT8qcKoQ=;
        b=adnIaiXujKzPaZptKODs4ylm1JeGhExa8L6R+5L1eEU52J71usHBNkhhY3Wd5Or95h
         kWyxBIxgBW8BFcToyDp36okDRhgT/dX3GfwrH4DYznDaefrIzYw5/IsAzBgNXtsKUz+G
         QMX9xBJv34MBr5RVPvcrqJcCVmbLxp4SnIvnjcqYdFKhZnCS2iNP7HSl59MokRxIhWH3
         L/3qP8p7ECCGnaAHGqbNmairSEQCemlFdUSIR+j7UULOVRWnz8LRIS8zsmJrfVL0l1P2
         oCDknRNy3DKybC8zxmZLNXFeVQIpq+IMHgw2MrFwGs0jncQnPllQyAggFfWuaD/+sO2J
         n1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786652731; x=1787257531;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qFSsIp/BSogxEOZHNXJYT5oX0PNIdy9cvBqT8qcKoQ=;
        b=H+mH2aqqPdaQl09mzZgSpU8u2iyXrkbaCsMmnZm9s5cEpGQW56uYP6Q6Lo7c/e6Reu
         z9CZlo5aF/Uy7YTVz6P8cj2KyBJzctVv0LzNAb3XmXOjevL57i6xDoxkBDIjaH8k8opU
         9SSsE5LjfoOdEN5/zyD5LalhD23utTl3EWciW3V2X5T/z1G57M0Zm/WzVbm7uX2zG+f5
         t5sbDFlGM0PDkLJTh9JFM7RrRlhSFkZ0GLVV+gxpuhEpE2H6z12EgWCawVL8wlTDA9XH
         8IAC2ahJmpLKLjMGSwxd67AVjC4mP4b7ekbDyr3QMAnAoAMcAFsMtfojCpBXsKEHGKnd
         +bmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5QXlwImydqTlhuK41az/YkUQRmz8ND0AoX0DI0cyzvPxM5u/DOfeZDxTAn3HM7kruF26V9hY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu06FLk64WnKY+doCt4WF87Eoi5ruyURVdgRobCcjPMZhGVwBF
	yK6UE8+NkDmKt+npNOqAoYYT/tYra30Gf8Zj3drEBY2AA5PNgOtHSaWW
X-Gm-Gg: AR+sD13LRTOUVCgghMJmUmg6y1eXp6SPxXCKU0IzR2d9AqQVsW0l6iVv0q6ww8gOb3i
	n1yLrxEIsiCSbhp1W6JXAb1/1kvQkOdpNhXVJuTRbeN9uFXW/51Rmi5ceSyeoU3vqqORZKkxtN3
	bMP5qfTU89u/EOKS6SViSsMUcdAzrdpTBDGoFr3VvRr5yM8SCx4C8NZSbXaXpx0/ifhJXrCs4eO
	ElXbl0dP2ARFWcKjsRTk26xuy26jqfyZHUq56jrVnGr40AtspSqyJHkpSOrraIHEUytva5cOOQ3
	tYJlPkQ5ou3bhXJ6D/vSfFAuETKysl8MDbUJiimBvPd4vsBi6jjgXsev9SueNoPZMVXnHe1j+gh
	aj/zltXewzUmGI6fkV4wrHJGcq+c234xHAfwRCuI9wrHIFK6uclxynP5KRA7LkwafeXIarcw2dT
	NhmRQnE0QSox0viSdKtjJq82JJ53JFVYkwmegUfts3giuQGfJZpjRW6gk9lis8T1QwEgmg7pGJ9
	vGkG3gl1wdToBfsdGNeG63VQkseX90/okbS
X-Received: by 2002:a53:a50e:0:b0:664:d5ff:2856 with SMTP id 956f58d0204a3-66c54bb56d5mr2593566d50.14.1786652731192;
        Thu, 13 Aug 2026 13:25:31 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c573c46d3sm1373542d50.10.2026.08.13.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:25:30 -0700 (PDT)
Date: Thu, 13 Aug 2026 16:25:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>
Message-ID: <willemdebruijn.kernel.22c7d90c91d06@gmail.com>
In-Reply-To: <20260813120351.2807829-3-alice.kernel@fastmail.im>
References: <20260813120351.2807829-1-alice.kernel@fastmail.im>
 <20260813120351.2807829-3-alice.kernel@fastmail.im>
Subject: Re: [PATCH net v2 2/2] net: ipv6: Clamp to IP6_MAX_MTU in
 ip6_dst_mtu_maybe_forward
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> Commit 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
> dropped the IP6_MAX_MTU clamp that used to be present in ip6_mtu(). A
> similar IPv4 commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
> ip_dst_mtu_maybe_forward") preserves the IP_MAX_MTU clamp.
> 
> Restore the upper bound in the IPv6 flow to avoid potential 16-bit
> overflows in forwarding paths.
> 
> Fixes: 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/net/ip6_route.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index 09ffe0f13ce7..fb59a5885faa 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -382,6 +382,8 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
>  	rcu_read_unlock();
>  
>  out:
> +	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
> +
>  	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
>  }

It appears IPv4 only clamps device MTU, not route MTU:

        mtu = dst_metric_raw(dst, RTAX_MTU);
        if (!mtu)
                mtu = min(READ_ONCE(dst->dev->mtu), IP_MAX_MTU);

I don't think that was necessarily intentional. Perhaps route MTU
itself is already bounds checked on configuration. The device MTU
min() was added after a syzbot report, in commit c780a049f9b.

Current IPv6 proposal is arguably more robust, covering both. There
just remains a difference between IPv4 and IPv6 code paths.
