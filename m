Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCD4E4C26
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613364; cv=none; b=Prq+C007OMfiDxneD0xc5KL/5r+mIL/+Atf6sLnRx0h22YTD7tqdfFtG92kRv4uRELLKX54beJwzNLcYlfKqLc5nvFOBnpgm6FDa2XXl82Qvhu8fv0MN4kcCo2fOqNZHQzdid3Cpee1DhIVHBMWji/4PdmvKecYEHAznkoPtYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613364; c=relaxed/simple;
	bh=cqC8QQ4+hapdcPlPD0pPI6tGKYX7lHKy/EcITDSm1Io=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=aEIFXtekv5F91AbUCeYAhPHVCQNV4fPS6NAPDlLbVQR+nTyVF2iOthm/mznPV57qnWz0mrpKez2MPaWi9gS8k0WuxjpKfbq+WH7ELK4iYElODZcOmzBBfnmA1i3qDyMDOiW+mbgIJx3rUKL8xiVd71DO2yE6CanP1hnx3iArJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pb/moV7X; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb/moV7X"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-67559a09ec2so515733d50.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790613361; x=1791218161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqC8QQ4+hapdcPlPD0pPI6tGKYX7lHKy/EcITDSm1Io=;
        b=pb/moV7XbQv+XgZRVok24xJ5n9exqcVzLppNFrCnp7bEWjVjDz8zoE2KOJ8Vg+bppN
         PDavfAAObaM2EMAr2ESLKbknkWKe6Y9MpfkI+DNI4fhRFFO6Hg4SYvP0sm54S/Q6aXhW
         0W6ofr/6XOye9SQiYlwCoDINZ4A5A0DUwuJ9/CL58XYzhqFIf+ySKeYkiP8FsVUupgjJ
         G1/zyrjDfPgOJDscEyT3909LTQ5iPQ85kjfduW6l+gd0wsuhXyXHTws42DFaXGejRkx+
         7jeZtvyVENbbrpHS3Hv/ZfYX+5LB0GmfCCiyP65Yo8FqwOvI7uxgeAgmK5OGUX2Llxv+
         zDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613361; x=1791218161;
        h=content-transfer-encoding:content-type:mime-version:message-id:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqC8QQ4+hapdcPlPD0pPI6tGKYX7lHKy/EcITDSm1Io=;
        b=f2kY2/yYTb9ni7dfUU5R5etWL4PGkrykIipPpn27umKCpJbNsGmo5sesGrK3LCoo+r
         rMR49fmsjV0hmQTFueNSaoycaitbqQ+i40iorw8qCVXi8BRCppGwFjmuTvgqFHmn6YKs
         YsHj5xUDKdjzNinEpNe2+9jMAQ9bA2G2wjnscugSxDCF8gE5DjSPB5KMPLsXQ3gYo/kM
         BYvdci54HkhZw/IQdaBRmVUcC12gQ5PLCmQYFDqXRw9t5M/dKTk5r/LCOWEKpIhOrbzu
         KRpjUdr+SeCljyRnVvkK1fBz80jK+sHmdY2WEX/qAlHRmDXZeCMo3mLwBccOqcIMlbm1
         VD0g==
X-Forwarded-Encrypted: i=1; AKwUvByvxVPw4+fib0/65SVjxK1PTTRxXPWM8P7CeKNLNqLDLcLLOegPCNnOEKO5r68QUobVJmfHSdA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDbg0OGPrRa3P4VdDQGfsP23Y+w3ekTtuommzdH+KZkEgHr82I
	V/4hfqkcNJBenPnzZED819zNOkY1MPUl0CCTO20DLVDGNWA6eAYtQH/G
X-Gm-Gg: AYBFou0SNkaXFvwYltT8FIn0KuKpFgJkj9617DshTXI8y0ude8KOsFeqZ2hl4nIl7wT
	/EOgwzVslGfrMyjIWvZSqMcZrWHVVA4MtBYvR3A8QQ2fhpD9z4Ql4kPNU6Z9c8LPxAX8Oyj5IZC
	LiXdNc/giSNYiuDp3TMMz1yi+b62SVIgOemYmsxDYfHFmclDSKy71A84COIE7eYY4nCXWMdMihN
	HYJ6WwRzMqIXgWnppYMslbEy31+UuJXSz/JY4QMfoEdsZbPfrof5+IJv04AfO9XsRk1Tek1rgW5
	qdbd12/AyHCze5ZBEOCgi0o/74c2wPEhyqKz8nTEU/JT/ByixLqoax8hs3iv2Ko8k2L/FNdzRrM
	pPShbBY7vDDx9KxFrs+4zmfwXUUklngxNBuOBWpKGBiQTr1y4xg1wV/WRzfOsT48iDzTVK/7vfT
	cnQA3cPc3fflgftPJ5E+ZI9E+O4XVL8lnnhp8zYH3hYy8hhb9zIA77P/8bXETJED/E/4Bo4y3gR
	QJwHGOz7xkVFnTLEO6GRTLzJp2fBgvUfctynlU2aLp2mATSNp1j
X-Received: by 2002:a05:690e:4141:b0:66f:d272:86b2 with SMTP id 956f58d0204a3-672ed2d19fbmr4650111d50.43.1790613361194;
        Mon, 28 Sep 2026 09:36:01 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ebe7a62sm5007306d50.1.2026.09.28.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:36:00 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:36:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 edumazet@kernel.org, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <willemdebruijn.kernel.a081110eee3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

In-Reply-To: <20260928144254.3361044-3-edumazet@kernel.org>
References: <20260928144254.3361044-1-edumazet@kernel.org> <20260928144254.3361044-3-edumazet@kernel.org>
Subject: Re: [PATCH v2 net 2/2] selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM

Eric Dumazet wrote:
> Add a selftest in tun.c verifying that a VLAN-tagged (802.1Q) TCPv4 GSO
> packet without VIRTIO_NET_HDR_F_NEEDS_CSUM (both flags = 0 and
> flags = VIRTIO_NET_HDR_F_DATA_VALID) is accepted when written to a TAP
> device (/dev/net/tun with IFF_TAP | IFF_NO_PI | IFF_VNET_HDR).

Thanks. We must not regress users.

Even those that do dubious things..

What is the use case for TSO without checksum offload? Do we know of real
users?

It would not work whenever segmentation is actually needed. So maybe for
on-host VM-to-VM communication? But that won't segment with properly
configured checksum offload either.
