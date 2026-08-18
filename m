Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2439BFED
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787021815; cv=none; b=FOfJhDqzOWQNBzS+8X8SAW6KVaRZSbyliuFJpWVIasjQRyBeMIrf7/FUY2w/kU4gvVRU/U2hoD2fAXPMlJQkbmZqWjniq3MjD5tZLPD64oASgVGeCzMRNEEvW42/KeizKy2V7O8X0CfOnMjjaIDF7/CrcUg1p/kvS+8HE7Xwejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787021815; c=relaxed/simple;
	bh=xn8I5437HVlUNED8Vn83WdHG4cuxInPU17DIb8Fv5ds=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oDvQH2fnNSPT3G+t77RWOmVFdt4bPWcSgDK3yjloe3eN7cl+T0EiKH5qXP0u8I5sVZMZHk12DmeDM925jXcGqScCid3vfcd0yLABYWz3VgxqJmuNm8sITIP5E8vAEBt9N5ynNK8BGnzZw8taxlRcFG+aIWC53CSTTRWsM2BQw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9xxAO3v; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9xxAO3v"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c7264d87dso991107d50.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787021813; x=1787626613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=meizaf4wwL1UKgIATopcY1BI8kyPxXyoEzfgjc7eSiE=;
        b=f9xxAO3vwWTD8QT2Qa3q4nnuGDk9pRFLmVMFMp2RCL8AbHFoDQYbdGbbl6ujB38j9B
         6Kui3Q//YfDQV0ZQJKrD0SRX037m3dk6VDwmkkcZwQ3TE9pPe+Rqx4yfrXZ8EiTgvudT
         AefdslJR4GMXSru6WbwNC3fojaKuTNChB/mJqfM520cWeVN9QXZSk4Y3t1Eb/w14+wsu
         4mixz1AMuwjXIKSwpyTrMc/xwKCpR1oNiL6LxdEkqxYdmL1A6oBnfT7p78qLmtT+Sgzs
         Tfp8i9jDT+f0yQXA+qFXX8beHyVo5s+NXDzsxASa6sn+lrHU18WMOxbw1wZBXATfRliy
         xhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787021813; x=1787626613;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=meizaf4wwL1UKgIATopcY1BI8kyPxXyoEzfgjc7eSiE=;
        b=baJz9/ZG8QzntSjE6aKzeVkNHEnc3UHIQ0RcZzRuHeebEjsSGbsKLQZ5509XLPE6le
         iZWBvIG32j4bCL+ETxc9Pu7GFPAfE+XGByTcVAPY8j4t1l34/nn0aGSeubP1A/Ys7pqm
         fK+FGeaE23pSvv9BpAYY7bSsTQU+Yq4Xpa7EPjZNhIoxIgSVE/y3SK5UD00pJFNpnU5u
         fmPVAqOppPAaQcDtNgeKf/k2kwmBKYFaIiIDzGqfd9B9wPaQFU0ZBaoFFdwLgKPyY/sn
         kqZpWfdOt/wPKDqyZePnkyZ5xmRXOIstDpWA1n2vF+gfPyw7EAc4bsxLUXNDGm5kN1Is
         0Lhg==
X-Forwarded-Encrypted: i=1; AHgh+RpiWtgxShnUUyTbTDbyskhDgG2r0VVXw6xhlINLbJ19OAcSo23dbJnR5120BHgzGfEG+TRb3Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOsQeU3Mn7akKjJXso2qULv4YSx3M8BLbSvCGG5fygbb3X9aY
	8E5crlgf668nUGYj/XUbc4kyHQnl2kaigrYH3O2+iGFQBXRbjaH+GEBt
X-Gm-Gg: AR+sD11Gvn8as5jihgU8RUSYh7beyNrGgnXrEOUoghBLV7xjsCqbEGn+zi4qLvenRIF
	2lztpLPExJe68EC8joJnttO9kR73SfWYID6QIXUW3dL8p395sz1nhN7V36cYbPpU2+D/aRMBJqc
	BHFMaDVKbcq8m4GGAsqXqtfWdT/wdqRYf1oSf7ajWwr9ez/sw8FqhnvbLrIj/MY5GeCmOGw964g
	3bRcNVeq7UCucVZYvj5WGhH7LjHQNuppt62F59XTcSs7AWOSRa/J1lAIng4cL3SlepQgmVLZUOG
	W2+FbwUlbWPV/NL+ekd7XsBiugNxzaaThR/egllMB27ZXJhB2DT6d21c2Ita1Hc0WJuL5mBqlFc
	qh4uAk1Sq6UzjHekDlejxDADkz/c4IMKO6bf11a/Jy+ezLWemp1s0ikx6Q4zWU2yF11+Z05eEXm
	9DZugA5a8Vzx0BLLjPiwCHjlaWgTWQyP5tDkpblFwUUcWOessXb2zPCQMftxUi/ggOwE7bx8Hhh
	T+jtObwaDPkEq+GSsSe0i7BZ15URqW8o0NtfqXvJw==
X-Received: by 2002:a05:690e:e8c:b0:66b:32bb:740f with SMTP id 956f58d0204a3-66cbbc4d0edmr1507033d50.0.1787021813383;
        Mon, 17 Aug 2026 19:56:53 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb47a6f08sm1695866d50.17.2026.08.17.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:56:52 -0700 (PDT)
Date: Mon, 17 Aug 2026 22:56:52 -0400
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
Message-ID: <willemdebruijn.kernel.13f661653b580@gmail.com>
In-Reply-To: <6f5e403b-dc29-41e0-8cdc-ac17dba30bde@app.fastmail.com>
References: <20260813120351.2807829-1-alice.kernel@fastmail.im>
 <20260813120351.2807829-3-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.22c7d90c91d06@gmail.com>
 <6f5e403b-dc29-41e0-8cdc-ac17dba30bde@app.fastmail.com>
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
> On Thu, Aug 13, 2026, at 23:25, Willem de Bruijn wrote:
> > Alice Mikityanska wrote:
> >> From: Alice Mikityanska <alice@isovalent.com>
> >> 
> >> Commit 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
> >> dropped the IP6_MAX_MTU clamp that used to be present in ip6_mtu(). A
> >> similar IPv4 commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
> >> ip_dst_mtu_maybe_forward") preserves the IP_MAX_MTU clamp.
> >> 
> >> Restore the upper bound in the IPv6 flow to avoid potential 16-bit
> >> overflows in forwarding paths.
> >> 
> >> Fixes: 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
> >> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> >> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
> >> ---
> >>  include/net/ip6_route.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> >> index 09ffe0f13ce7..fb59a5885faa 100644
> >> --- a/include/net/ip6_route.h
> >> +++ b/include/net/ip6_route.h
> >> @@ -382,6 +382,8 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
> >>  	rcu_read_unlock();
> >>  
> >>  out:
> >> +	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
> >> +
> >>  	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
> >>  }
> >
> > It appears IPv4 only clamps device MTU, not route MTU:
> >
> >         mtu = dst_metric_raw(dst, RTAX_MTU);
> >         if (!mtu)
> >                 mtu = min(READ_ONCE(dst->dev->mtu), IP_MAX_MTU);
> 
> This is some old code from v5.14, it changed in commit ac6627a28dbf
> ("net: ipv4: Consolidate ipv4_mtu and ip_dst_mtu_maybe_forward"), and
> IPv4 clamps MTU in both cases since then.

Oh indeed.

> > I don't think that was necessarily intentional. Perhaps route MTU
> > itself is already bounds checked on configuration. The device MTU
> > min() was added after a syzbot report, in commit c780a049f9b.
> 
> This commit merely adds READ_ONCE to the existing min.
> 
> > Current IPv6 proposal is arguably more robust, covering both. There
> > just remains a difference between IPv4 and IPv6 code paths.
> 
> So, looking at the fresh checkout, it seems that my patch covers the
> difference, right?

Yes, agreed.
