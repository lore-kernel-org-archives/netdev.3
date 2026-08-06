Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F1432D7F1
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785985648; cv=none; b=BvTynWyLVX1AICzGOu6WfEzb58vz0kYLnGOrc2cd6balyEu3V25mFwaQusUTlNzQqH7yOvB+Mln3g/s1q+bXiCdJtsTWh+EOosvq3ccdO/U/9v0wUVBG0wmsZVIqJ1hpFx524w+UCluCFA4VwYBKmzMwCLJyh4q2JYUdrRYoUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785985648; c=relaxed/simple;
	bh=jQ6UuDW3zdfjblRiMKM4NFMGx1Urp/cvyxzY1qFKYq4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uU2yMlhhCV3THS1rRhnAY1DAr/H+C6/xPQf62IG8r56IbJ7qwB477JGaFDkDXqDO9/X/R2ZelWsi99JGV3jM+olTONWNaiosJCN+LbDQmzgtaaRW+Xe1K8NRZT/uMoZZ8iMFhW+OSQYZts+dQRBx7twsPviD0XRKiwv6QY3u7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcdy3gBB; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcdy3gBB"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81eaf3709b4so25676837b3.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 20:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785985645; x=1786590445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T2GVAE2mW6LqPKME0VIKnwNjy75x7t54slf/z118zbI=;
        b=pcdy3gBBtBZcLujDutEYR6YlF71/ugU5HC/RLjx0W4jsZ2nBVLYCzKrh6gW/FwAYJU
         fSs2hssRQ1CKGJpaiX0UU5rOl0Eija9xna2UNIkbds7G9+pfTP8s5o6yNIPxlvQ/WSf/
         WRjUDuGFXFiG/6N35QN8A+96lFQJrTiT06vvGGdE/mArAzqExLu7lXx45t8ZXeRT3hGc
         khCk/X78GxeljYHxhyqp484BQZ2UqpkBx3ixbXIw1RStABmWBxyW6nDU04WAIFtJ6/j2
         IxJKTGqFqotdXiGe+A/fO3qIjYjMkfqJkCPYcdvM92GV0kz+92Wxlg7JA40IfjP4D0IH
         cvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785985645; x=1786590445;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2GVAE2mW6LqPKME0VIKnwNjy75x7t54slf/z118zbI=;
        b=FlQuRzmHoqqAS+W05vaerf8AcaW0KqkogJzvZXnS2t/dlY+8mFu8cjp5zhFN4SlfJC
         pkdepUeEcpfImoLNSGyTqjXHvTBGI6oUWpW9rT8A+k9lpF5a+Ph5hNURH5YozZXRahQv
         M3K7wmqoAHffq0/HnBDlMTbg94J6Jzy5qL6Rmg/Aolxtgu2VAQFb7If345gcYT+ArT8Z
         RfPc4MH37kVFFBVHLH3lwXszrOkKoyP/NxyAdIZWi0JrxhLuTff1B6b2rpOSReBccM3r
         qMUJFYlHnK9eZQGd/l6L5gyC7wsUoJpa9TsBMnqHW8OvjBuXDMlmzKdzXrtuurTghxqJ
         lRQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOjK9JF5pLhmFrkBAEslZP2wbMj5XnvGB8om9D7rQfxR35mAJlLLzb20u0aTMV2LkySsuvVJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiRrJa//Cj/uL8f0MM5RSj/7fnJgJ6Ptqh0prBIJ0tNyjsjP2Q
	mG2pAG+tCBoIjHF/rZJc1w69FTqPlWyG1BVkv0CCCOws6I7cL7zhrzxh
X-Gm-Gg: AR+sD12zkPrUGV8XJdVoCd7dP9xAZD2zyyMZxDieJ75VHuzStp5609Jr2ldsMnTIQnb
	dDIk59HQYd745TnWFAx9WhJ2Au87AGDJ0GYUgcyK8OeXsM4reWSt1OjqY0UCcaVGR56acnVn2d4
	E76z+oST+AsHh3jgonsWn488zYp2bSyBPfPuKGMeckk+3ZFqG9dz1Co7QvbEfhvZq/g9ly1u4H6
	HrQ7mXYqwcNBf5yItLB9yewH88hajYQPU//xddtdoLKHejGjPOaeYre3b8Mz5UP5//xGUjFLx/v
	CxYBilmxlfoBjJrmJopGRsVoqx/FA4bSUkMiTe05OYKcm+0H15Yx/hmCu3i3goRyDmZasoCWj/9
	B7EAzFqV3eaHyDP7BOuxAn1s97GZjh7ZDv/Y06dQz2zMljzn7FmfQ5wY+Lz7apAPDYyEDhCD8bf
	wX2FC8sGtfPStLRAKRlGUS5fm59KrxK1lnTYi5Ho1uREgUYxS5mj4m+6nFSiN7InKYkRULOQFcR
	f9OT9Xzesp2JKI7FzWnVcSQxzMe7rT8u460
X-Received: by 2002:a05:690c:3a0:b0:81e:5f38:b20e with SMTP id 00721157ae682-8201f0bd386mr75511517b3.6.1785985645185;
        Wed, 05 Aug 2026 20:07:25 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134ccc5csm32130237b3.43.2026.08.05.20.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 20:07:23 -0700 (PDT)
Date: Wed, 05 Aug 2026 23:07:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 Qihang Tang <q.h.hack.winter@gmail.com>
Message-ID: <willemdebruijn.kernel.3923b42779f45@gmail.com>
In-Reply-To: <20260805125729.19220-2-q.h.hack.winter@gmail.com>
References: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
 <20260805125729.19220-2-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net v6 1/3] net: remove CAP_SYS_RAWIO zero-padding in
 dev_validate_header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> From: Qihang Tang <q.h.hack.winter@gmail.com>
> 
> dev_validate_header() reads dev->hard_header_len directly when
> zero-padding short link layer headers for CAP_SYS_RAWIO holders:
> 
>     if (capable(CAP_SYS_RAWIO)) {
>         memset(ll_header + len, 0, dev->hard_header_len - len);
>         return true;
>     }
> 
> Packet send paths call dev_validate_header() on skbs whose headroom was
> allocated from an earlier hard_header_len read. If the device is
> reconfigured so that dev->hard_header_len increases before validation,
> the memset writes past the reserved buffer, an out-of-bounds write.
> 
> This out-of-bounds write is masked in some SOCK_RAW paths today because
> the same concurrent increase can first make skb_push() exceed the
> reserved headroom and trigger skb_under_panic(). Remove the zero-padding
> branch before making those hard_header_len reads consistent, so the
> snapshot fixes do not turn a loud panic into a silent overwrite.
> 
> This path is only reached for variable length L2 protocols, where
> len < hard_header_len but len >= min_header_len. No remaining in-tree
> variable length L2 protocol implements header_ops->validate, and the
> CAP_SYS_RAWIO bypass that zero-pads and accepts short headers has no
> real value beyond allowing testing of intentionally malformed input.
> 
> Drop the CAP_SYS_RAWIO branch. The remaining reads of
> dev->hard_header_len in dev_validate_header() are comparisons only and
> have no memory safety impact.
> 
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Fixes: 2793a23aacbd ("net: validate variable length ll headers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
