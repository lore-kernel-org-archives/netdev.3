Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1A36F905
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797249; cv=none; b=rri9/JtdmkXIdYSxzoQtByJ62RDePJVfAhScmgSW5wPBEP2NsAcnPd4Jk3KFdw5lOwfhBxf+SKBdb0tSnLjbyXsajFggkXVQgh56DBXLkbiTpjwX/ibzoTJ6hJG0xC6v9IXKvn1KZsHgAMGVlb5f1Tud5dL1ete5zHwBWeU6Kt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797249; c=relaxed/simple;
	bh=c9+cdIbmguF1QKIhrvWAWxypHMPuMHkHJU+LHWEfcnM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Pdm4K0YeZA8UbPDF3xO63/harjbA5rs5Ok29Vqo4L19hW5tm0w5xBqGS3vozGl8HLfVwEBV8SlwexJWAL4IYcMMkFUVkKkysZqsccQQRrGnYPdMZwKchsJWsLWs/YcOOOj+bZ2taWEiIl9I6+2hKxuwlgPs79lRUbKkkgLerHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMQA5V54; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMQA5V54"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa75b338d6so34895237b3.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797247; x=1791402047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YGsPoFxXUhrYc8fuScloKU7y4IoA5xz/2/p0mwC9UHA=;
        b=TMQA5V54bWoWERDnZZFh+jf3+UbVCKLGN9VLkWxcK/fmTDMxZ0lZhyUEEjroBiszUM
         nE3Dl9132CAjbT6dTscTeX7u5kmu6+xvePitLa4jokbl3xLpZ4mfWFDI+Ia6IAzYok7z
         UutHXasIeWXQ6LJbcxy5DgHkN15TWRNeRTZN/npb0+HoLlRHjIlAapmw66MWImGpDxsb
         wPoLZ+rBCb9eyPCVyfOqXdYKXht2uU8yAPYkY6orFbnwmnPd4lJhz/ol+DLmAFjn44vc
         eXQwP/AjVqQV9wm6l+bD87ljeaJ8QUucVFst82a04lhE4YrOkZusLicu7RAdJ6GGYBSo
         P8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797247; x=1791402047;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGsPoFxXUhrYc8fuScloKU7y4IoA5xz/2/p0mwC9UHA=;
        b=fBmQfgvcpefPlnfr+P8hdQBpMKg0RG2I2oKPswS/mZsjgysU2ceJFwcx0VoPcL23Xq
         /z8MLv2/UpDEaymsr2VIRp9aDILdcpRS5WiluAgeuWFM/22eZGwZxPGZ3SYYyYObZ7g5
         mHCIxUJKOWkTe/H+LEtLFmTPoEx5q6cMF1vYHTAiA46FQLOBFkZI9TzD9bOdUT4r505a
         Pm1aiLUms8EQRW8bESqDtnPGlOrBEvc4u7/BfzG08BxxDi9wPe2BbaHai3bAsmBYHah7
         mY0btaoyZ99zNi32vlTEk+qjkxHSBcENth6BJzbmoo5unydHDVXHvgjqq6LHDP81MdO9
         ivhA==
X-Forwarded-Encrypted: i=1; AKwUvBwa4swXustXbW7zmpmWOA89RaNYUe2QufdY3RVuuulPP3Xyp70nze2j8kKlm3dWMSkt4BHtuEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJWSwapMlgBRvl+6sZZwjiuy+SPGblhCRHrsHgqb0IFq0GCkjY
	385o5cJylVoVSERAFz42YM7C9+qj/eR4AmeUgnd9aY6jX1p2ANjbhTQd
X-Gm-Gg: AYBFou2DQb/YPcwdJiOcuHQtOF3XEpPbZiGMV49BXR04i3SawseGMGNtbb1QgxkfmFY
	kMRA9phT6634lt+9QND2N/NI+BBRYhcQ0KXMxFPhKLrh5CzD8oh85GPBYvqxaMtsLbpegmfMpbC
	eEcvo/yFJnaqqmOlcJVMB3eoYmv8zd94V+6WQnDga0SXCl+2xdaw44ht9ND0r+RlKl8MM2BqAO+
	mxbRBVmRWgKiLy/W+euoKijqv60+UCCQbO6wwKtZk2CfVwkjry+Prj2NZEP7FPfnJvEDVXXoHJZ
	OyetKRuzFlnEsdJnr8JM/oU4VUbVJazo7uqKh2p65oHOOJMiyN4cd0IG1Jf4qgxUovKCZMUYsrc
	3YW9CHtwJMAmTB98YAb/3nCZMRH43AgOvZbInf9iF+sr9dV32Dqx64lEECb0xE/UnGMbSUy/TLt
	+jeBR+ZmBG+GH8v8v7SdU//AIP2AS37l60pdUI0Qpg8wa7iWzCWhHsuD7k9s+dZ0JIIY6LkstzS
	Zq8VBIIE3yYag9n+MMlO4fK2R8szJNYDL8utfCH7yrGRZ5SNISd
X-Received: by 2002:a05:690c:6d84:b0:8ab:3fe4:2e64 with SMTP id 00721157ae682-8ac90eb1f33mr13769627b3.8.1790797246692;
        Wed, 30 Sep 2026 12:40:46 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdab52bb7sm3438327b3.4.2026.09.30.12.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:40:45 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:40:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.3ae8d9ca86a49@gmail.com>
In-Reply-To: <20260930111526.2183107-2-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
 <20260930111526.2183107-2-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v4 1/5] net: core: use the packet's L3 protocol
 for the GSO size limit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> gso_features_check() compares the frame length against
> netif_get_gso_max_size(), which picks the IPv4 or the IPv6 limit from
> skb->protocol.  A tag which is already inside the frame replaces that field
> with the VLAN ethertype, as skb_vlan_push() does, and an IPv6 packet is
> then measured against the IPv4 limit and segmented although the device
> could send it as one TSO frame.
> 
> The lookup moves from netdevice.h into dev.c: vlan_get_protocol() reads the
> L3 protocol from behind an in-frame tag, while if_vlan.h includes
> netdevice.h, so an inline in that header cannot call it.  dev.c is the only
> file which calls the lookup, so it becomes a static helper there.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v4:
> - drop the Fixes tag: not stable material
> - move the limit lookup into dev.c, so it can use vlan_get_protocol()
> v3: https://lore.kernel.org/20260928044102.1004310-2-wang.zhan@smartx.com/
> v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
> v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/

Reviewed-by: Willem de Bruijn <willemb@google.com>
