Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCA3C09EC
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231822; cv=none; b=D7Wog8WKzRFvIUiZCc/nLZRD7/kht0d+6UOUzu3QafrVM+T1LkWFP8B65uFkfaWuq+EXv7Jx+UF96NqLcY4gwITO34K6FO3f+riSRE9o63MOKeuAiVuarOjOexzthEjILfuadSs/7e6jKZ6tLN5+gh48SaEZVbKmDweC4NQDz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231822; c=relaxed/simple;
	bh=QMjMCPTpdsCRoTAyCq7iY2dZzfbVHms6j3EXWfMOAPI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S3CQHFBAqvfpeWD/XY/KHNLbEfaiJB6EIcWJmwaiOyU/0OnJ8KGIq+sj72lHn17lyFG7ibzjkzhzBNruT32kQCcT9EEOpEkiodN1YB/a/lITSnEHGFW38hfIQB2EUrY9s8QKTQeEE6fr+gpuwmKBFqOMIOJmAhTU/09K1eIVIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRAGazp5; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRAGazp5"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8630c1503f2so20393687b3.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788231819; x=1788836619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5+eVI0mQz7KwBX8ylebIXjGIn2MepFoVALYcchUmiwY=;
        b=LRAGazp5sKuwz8l6nbuobcsOMZqemShEOa0Fpnkil2odIOYfXvkqosUxYYgPg6kBnl
         1Ec4YKms2cLL0D+eGsXgGIDHJLvqSM0C/d1bPBfhILwZR3HpMBxT89ao97cXkaC09+Ev
         yW/ktaJp9hLVwh3TwZ/zyk+UCSzEJnjCy5HVbQAeTvngi7aAQ/6aHu26V2fK0SkvvRhz
         kLBZU81T79BCweIpLr4rWJM02rsmxewuoON4mNDJpFLWH5km36sfPsGOLjzQ4EtU5cSg
         cto2zS49FJyKIXdJA6saE0Q3sps0Edh3DIwRYJ0BiHca/8kpTNC1tTFkF319BMmdZQR+
         cm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788231819; x=1788836619;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+eVI0mQz7KwBX8ylebIXjGIn2MepFoVALYcchUmiwY=;
        b=c5lxyeCM0neERrpIS4PAsXMjsRUAmb+IKJiNphfP1rDAlu7QhGgSJZay6dKHYVaFbr
         MqHW/f7YocXizycQahIPjP/tGUVz1NfgzQmxP13bamAgipq8CB6clFn/NG9f8GjYeK3z
         YjE/Tfl9AqE/MF+3yBe1fmVvh3oMvXgthHXgk8If2GBEc7svhZCAzRIgi4VJBFtvX+60
         XZcb6huqnjRZQY9EAmPK/WIaGHxTHOTzw0XbYohsMY76WDhG/8+z5jhZGGeiOel5zVEu
         +p5wXpBDoMiBZrXNBWKp3w/X1f5jbXB6hKy9YW7ngXFCEZz2mHdtM/xGOQl5PVA6Axui
         /r1A==
X-Forwarded-Encrypted: i=1; AKwUvBwpweFwVYwhoc+aSyuvfdzMWuselfgGj1QTVPisLeiX4VvVnIAz5RFmCawxDfdC3eBhZiR25+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kVndZZ62QweddY9r9NvUwW+CxM48dE1HT/bzrLBE++bUD2ACut
	D0/SoMy8CLxTn+S6VWeWH158rm/fH3FRAeA6OI1LlXmANy0Y97TG2hO3
X-Gm-Gg: AYBFou2/FRhSAVG7vr+6mKCCyUaePlEY620jrgZ4ANL7YR9ae2AkMj+e7QTLRigcqdZ
	jRZdS8uFqAAiKrOpa1Z8VB9SgDKGsh9Drs4pEhJOVdT4lCYRpdB8yAPUzQDAV3cQ8Wa7HSUghpN
	DJXB0F2GcQJTs1ogBwfUV/Ru61cnRfiuym+1H4oG8VVLmCP8H7htZZtz6PSq9P/6v/l7poL1Oea
	tyQIu9o+P1ABm6DJrFBHRbmEvk6zg1e7EVRCE5wRkZ9NoU87Nr2QQK5hp+jMjkFew5/sBgn1p2L
	NrnVKBK085ulBhc6JVmAHIMhXWXu5xTFl2hpwmyOMoEtfu7U7gxslmqnrNAmBFhE2lRDSB1Bq6A
	m1EPTe3Xtnn0cBXC1qxxk7inzaMmMdF73Hg8MAFswUbByoKAIQ/nzTrI4KCva4MJknEQJX86dF0
	xQfgIKBgcezbt8TMEf5uO0XTnq5tTbXSVt8L2MjOX72u0OGUctKOIO4iUHApHSOPdXHNv2f2FPV
	00W3xg5EDns/YbwlNYAdBC7GcTkzuneefg2JcNBLA==
X-Received: by 2002:a05:690c:4017:b0:859:9c98:b8b4 with SMTP id 00721157ae682-86875b7b5a6mr25036897b3.31.1788231818693;
        Mon, 31 Aug 2026 20:03:38 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-862e2335134sm43186607b3.28.2026.08.31.20.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:03:38 -0700 (PDT)
Date: Mon, 31 Aug 2026 23:03:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.2d4ddab147812@gmail.com>
In-Reply-To: <20260831213221.1370774-7-willemdebruijn.kernel@gmail.com>
References: <20260831213221.1370774-1-willemdebruijn.kernel@gmail.com>
 <20260831213221.1370774-7-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v7 6/6] selftests: drv-net: extend so_txtime with
 hw offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Add two pacing hardware offload variants
> 
> 1. one that uses FQ to safely offload when within bounds.
> 2. one that uses pfifo_fast and thus forwards all packets.
> 
> Verify that the packets are paced in hardware with new flag '-H'.
> 
> Also increase rcvtimeout significantly to reduce flakiness. Especially
> for the new beyond_hw_horizon test, which is close to the 100ms limit.
> But update recv_verify_empty to take MSG_DONTWAIT. That last empty
> check must not delay each testcase by the receive timeout.
> 
> Hardware pacing offload can complete packets out of order. So the
> reverse_order test is expected to pass with pfifo_fast too.
> 
> Do not test ETF, which does not change its dequeue behavior based on
> pacing_offload_horizon.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

> +@ksft_variants(_test_variants_fq())
> +def test_so_txtime_pfifofast_mono_hw(cfg, ipver, args_tx, args_rx):
> +    """Run all variants of monotonic tests, without fq pacing sw backup."""
> +    cfg.require_ipver(ipver)
> +    cfg.require_nsim(nsim_test=False)
> +
> +    _dev_setup_pacing_offload(cfg)
> +    _qdisc_setup(cfg.ifname, "pfifo_fast")
> +
> +    # Expect all tests to pass, except beyond_hw_horizon without sw fallback.
> +    # It will send immediately, failing the receiver arrival bounds check.
> +    expect_pass = not args_tx == "a,70"

Will fix a style warning

> +    test_so_txtime(cfg, "mono", ipver, f"-H {args_tx}", args_rx, expect_pass)
