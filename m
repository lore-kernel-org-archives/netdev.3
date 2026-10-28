Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203069;
	b=Edm0qntEmKMcKUWCfzV3SEKmqZj+tbL0LDkX0qDdQwA39s8W71FixtajHVPuB0TDO7A+
	 FVYOuA/Qxo+foYrzsh84VThq6h0yJSXuVpn0+K3xVlSB1w+xuN0jfmo5Zkhnmk08VzQ90
	 gR538AQktOIKl/WxYc7ef7+tviHTbZA8K3B6gEBhENcbQgjersIaNdC2em8rAE4poeaeE
	 76B0lXMiJAgJCHb0vWaNEsY5UXBpQkSGSGVRHKEnn4oB3tadxLT2Mx15KnovZgrKB4DNo
	 l/3bGI22zrDvt1KKMtiZ1MsLgG4QG87nEGgbVjyN3PenPYjjLS1TtMbzJI495KP84Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
	b=rKvsApGiMcZiCIcPyDjgAPoW8SljJltBMZNGeiXC4DVI+j5q73N2h47DrPJzYIaW6I6B
	 GsbaQNBYg5Wgfa34g7DMSXFBJY9DI1UiHpbW0kMSz5OOsQJXtdG22ACrS1/Rj37sD8Oh4
	 QrQLb8V2K//B1xPH9HSThXCvUPQzkXeVL+zOYV2h65K01WL3GWsevPwN/J0gBDBodnm5D
	 eTAlFiYiMc4NuvKomLrM6LhVAPv9dwYTc+CP0Y3wzQnyew1XQBEsQlJ1KCyp7+4q2GUWR
	 B+oNPGBFCTrHtKxB9l4lEg/17ZI4rvy0wopDtAT7udYDhCSF2sal27ckP1+8e8fHZaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljK0kzZc;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F7606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA4F7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljK0kzZc
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd65a511e43so613727a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793203068; x=1793807868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
        b=ljK0kzZc7OIyosJ7wtQFMgv9t4jBsM6ffPauulC3pXY1M7Uo3sQTlPAIuHZE7gbyFf
         bun0E+OttUZck8IKPE01oLJeHGP3SE8CLliMRa6yeodozKQT7iCBpdvryQnmRj02EJg3
         fd3PT3KSgpTCNaQLcTHP0p1S5CaUrDkmepEOB0R5PgcoebLDwOibI/e+A4t3fgi+7BBX
         I67SoJI+UC4wqpLQUVgGqiTHXvwUbDA8yckRpISy54uZHbl//QLdfgtU4HDqnK8Po73b
         ylXpIfIj5ezA1aObz8m3IFxxn7n5AJ6pJd8UgGKsizsN7jApUGTCiGNqk18t0eUD8GkP
         LnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203068; x=1793807868;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
        b=djqdUwVTc5IU1Jt4xZ9uPrVI4ciFAa2LUCC302hTAnozo/jyhp+DNv1xVIEGyny/pU
         8kTkWLQNdAAr8WTG1gHE0eOGz2rT21d/XlCjqpKJYCSmeVRsb4MjHoS+fgjzRY9xxTpJ
         gxgWCxy6PHC2YRtjslEGgFx3UeHwLFSj/72cMY8Q7X6CyP6k21wO59fS1q4Gur2Xyesq
         ilFEbNve/BfxxTFdh0EyX370SvASzrzVTVd/KNGWk5tFN44J6wFeX5FAsbInHlCHwdyP
         V640IskmjPPA2SYoOm/T90Khw7sbT1O19XjKwodtpJsXefQSbMZ773Yzw/Uf9dnDFLMh
         2gfQ==
X-Gm-Message-State: AFq9FYIb8oO1LtLH7oe4J8y2DwEiJQC3N/fDvvggN89hEVrM6pVycp5l
	MeL329MLkU+kUPXjcMjQfBjXUj176Dd0G5fyKAZtrFGe58UGFVZH40EsFQ5tchxCfDE=
X-Gm-Gg: AYBFou2aaj/4v5iiBRcTwgb/NWLh41mcsVNzJF5YHwhVKW2UUTcj7CeZ+SaEavxzcIl
	BdJmeZi2RQU9ExgJWdGIIK4Ak3I1thN0V6bEFWs9R4Cl/gGWlAVix4DqDYdZJKzfIcCee4AB/Ie
	rwqrLyF0uDR8sZgxw9lE3mPvV7kFt4TNZsi4HmakGkOD94VQzKVgrIgbRWgOp5Iv9alyftMv6GY
	SkhBFZIfLPm1BXzN8IwjKc0zOk5i1hnKboZSAzE/BCW1kWzED6nd1uBRaIS5VftbmpFLzUjeqHa
	OdR8xc0DLMkj22wufn6c9s2fyKy4GYe0orMes6nSRtf+r+DxMSvyq0GztN9sAkz1cy8jnJMQIEa
	UxJ5LqxdFps7yhsIxNHDXt7Lg96ub4sSyQM9gO26KxMcty9SKf62Fxxqw6aTvKcq0mBNf60+SBV
	xKOKdA2Hn9uFIe/kJU4RQkC5N7BL+rkmzKvlB2/QRJsE8vnUM7zE+pE/TDVO/hgFRKDwx/dMQ3a
	Jt+qW7S6TJoiC9FgGBc2jlqUqS9TPVZrETPMM/sYziWX/oyFKi/TyFg25rzw35MSFsxby8Vty5E
	4MN/jIV4YW7es/uI3+N6B1I=
X-Received: by 2002:a05:6a00:181e:b0:89d:e6e2:b2a6 with SMTP id d2e1a72fcca58-8a6e7bc7a49mr2518493b3a.45.1793203068030;
        Wed, 28 Oct 2026 08:57:48 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:69::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a5f66bcesm1390538b3a.15.2026.10.28.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:57:47 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:57:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] xsk: defer software checksum until the skb is
 complete
Message-ID: <auIbb0qeWoJ_eKw0@devvm16445.scu0.facebook.com>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
 <20261028025026.11401-2-testwrzwrz@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028025026.11401-2-testwrzwrz@gmail.com>

On 10/28, Rongzheng Wang wrote:
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
> 
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
> 
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
> 
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
