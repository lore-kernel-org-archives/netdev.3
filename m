Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA446EF89
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797259; cv=none; b=PxWV8QCZYpO/WYUFuq1v7eSm+92goUZNSvLsAhTV6WZQ2kxMITZzP1WKmh/FUo0hBI51t2jsO/D3ixSZ0ROSe0vAlR9aSD4h7qjCNd0NqzGvZS1XiKL8g3XhPJqpjJdl36OtwjGJexuO6JrMGixO2Xb7/QzCma/a3iX9su33Ru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797259; c=relaxed/simple;
	bh=O53avsybSqLCUVS3wR7ALQAXf0BsK0Ds6tWuecZwmPQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=I066IU+neI5UvC9QxxiT7uFpQvn1kiCN1mU6lGlGOxVakdQTSCtYsgo75y5tjIh4jKysJWs80D5EW5pluRq56wX9RhyJnOaT+Ix6NjuVohfErHJccTzXcbDTEqiVTo9myDWm9MVPiJhl5JMAZ/+dGVdPUlzmmBGLPKdIe/gLOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDeO1vb+; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDeO1vb+"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672ce86b21aso6493061d50.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797257; x=1791402057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zysOGux/W9k28xJOl+6oo5Y9jPZ0WOdxDwCyuGbfiRo=;
        b=lDeO1vb+ryIILDiwc1PPbR8H9LdV7RosHZmSqW6GA6MsT79SRyt0mVBj6tZOqM1sHQ
         F8+OJu/1Zj1DaUlNNHeSpYsB8CYICmj9PmvpFzEZeiIm29p9Z2I/y1CxmC0z7X6f3Gh9
         kZpKzNS3h22pxO1CMqi/jirrco4YA0L4VHEixPqC2Zqphe9a1U4R3DegEzaiZzhVhEWd
         mu74QPuF13eD3bVqUnuG35SJlNd9c5tS5RFENWSY9CfF2r9eb7rNHJUpZo1kDC/PlOVp
         C1K7RtHlWey9qtwou4RrpglKYN3DDpBN/mjTGKha252S5VC0MWN7AoNXIne2RaF5/rmK
         95xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797257; x=1791402057;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zysOGux/W9k28xJOl+6oo5Y9jPZ0WOdxDwCyuGbfiRo=;
        b=pypARWodcbe039SxWmJVDzJSHjOF8vM3GG64RpLU0CdnfyREubNMLIXWdc7uYIJEiJ
         g0vjMuIEjfTW+0s1tXLp4zSmB7babPRz5uwOpBe6Ll95wescm2L8ekvZ3lFMgY4Ul44g
         JKfqzUQgIZRROx50TD1A5B3DzumkcY2oPlntlPyUKK9Kr96OI7a4AKK3O9PkMCF7MNG7
         bABGchtpBGi2zR7LXvFmFOOaunXnI+P/OKCEscYtWnz6cFh/EjiV0D6yteezFXxR7iKD
         Ny1g99t49U/B7ho31ea28YoLjc2grdf70A4m/rVnF2X7vFVQUZDXs+vjlMwALNgg8cqD
         8M/Q==
X-Forwarded-Encrypted: i=1; AKwUvBy/YKziB60B2PTBafU1MTbankXVg+Pn/HonRRRycBsUYPIHmVbvtqKlD32IikyI8JoSOL5+llw=@vger.kernel.org
X-Gm-Message-State: AFuF++m7wrBSakP39v542r9oLEYvf/uT22lI73r2OVKy9USq08i1lLM5
	EWoSfeL4VIwSismuAjvBQsxrq3yuaGa4I44NkiKm65HMyuU2Dmy8Kvrp
X-Gm-Gg: AYBFou0oAxnA+rwdyNnDw8IDFKT5p1ttjkGw6iviMpf/GT2wxc/GcZtuYXI6u4wrZb0
	HBGhENJRKN3TVNd6XgYKe3k0BnIR/8RL80oshvFsE3gUFfJtqmJkuDfoWAhHHxaWPyJIBfVjIhp
	w2jFzyZaDepgabZ23aLxd97V+QiBmMR881WQr/kQrrrRAyK8IJJKkUQwqObCLgZhXveXpF94IAh
	GR/UN9gptk3Fl9k/s7Mtm5l/feIwlLYuLpr+Wxzu0ve5fGtxpZa87kP6PWMOM2U1GXSrP0u79I2
	VXk0Fj7J6shU8Z1glBQ1aqHAt8MbX3895LqQjyWZMQdy/scVk/OfR7o4pAmjAkzHyyXSl398MgV
	8MqhdBcwYx3JNfH8AXJ7Wk7th/YuPRuVQuhiHSBO/3fKSnP3X8yVBPu4u6w+1MTK9qodOa9Oogy
	tMe8wdV3TvcmzQdL2kHr29cvDVudbIJPSswEgyENiogLoUxFBmbFbi5SHZ5OCMeJDFzNsHAk9QK
	edeNiZEpjYJkN3DLEZ6WYiwoYGQomgGTxNH3PHq+ADliH4lMcmM
X-Received: by 2002:a05:690e:13cf:b0:675:49cf:9b4 with SMTP id 956f58d0204a3-676834ddcbcmr1156400d50.124.1790797257124;
        Wed, 30 Sep 2026 12:40:57 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6769191d488sm192778d50.16.2026.09.30.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:40:56 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:40:55 -0400
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
Message-ID: <willemdebruijn.kernel.36a2d78c80f64@gmail.com>
In-Reply-To: <20260930111526.2183107-3-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
 <20260930111526.2183107-3-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v4 2/5] net: core: factor out the GSO device
 limit check
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
> gso_features_check() decides whether an egress device can offload a GSO
> skb as a single TSO frame by comparing the segment count and the frame
> length against the device limits.  The resegmentation path added by a
> later patch caps the MSS segments per output skb and needs the same
> features computed without those limits, so put the two tests in a helper
> and gate them with one flag.
> 
> __netif_skb_features() takes that flag and takes the place of
> netif_skb_features(), which becomes an inline wrapper in netdevice.h and
> passes the flag set.  Existing callers keep their call, and the
> resegmentation path asks for the features without the limit checks.
> 
> No functional changes.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v4:
> - keep the two limit tests as separate returns
> - move the wrapper into netdevice.h, export __netif_skb_features()
> v3: https://lore.kernel.org/20260928044102.1004310-3-wang.zhan@smartx.com/
> v2: https://lore.kernel.org/20260918084651.3022878-2-wang.zhan@smartx.com/
> v1: https://lore.kernel.org/20260917063854.2011613-2-wang.zhan@smartx.com/

Reviewed-by: Willem de Bruijn <willemb@google.com>
