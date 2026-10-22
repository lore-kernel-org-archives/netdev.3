Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661894;
	b=3TSXNzqtXa7kV8V6931sX79Cbssrw/qiAZChDLekC1RwkvfJCqDH9+b9NL4E2X7EPYUL
	 BRyP4eLhyDHh/2L00vMXPBECVrTk3SRQnbv7s3q8OKbAiUGAXX8yjVLjME7H9T4+427Fv
	 o6SJVPTTJ8ASPvQG7uRgtbojFqqx+HiYCdqGkpugIFNpFR84Q5kmbpMLAbbjPh1Ad6oKB
	 9g7GRdxDUuFfatq6il1XEdzt6ZPnbw8Rob0p5PSDZStQQWhjK4M7kpXNCr3Cfdg1ONjGh
	 69CrYog211z6K9alG9CT9V1UqYEtF251IKtRNks96lHEgdpdlg7Z/+gIVjEzyTfm6zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Yzwu7Mo7blUPO2g2psRpJeiXJWtUOEqjjPI2Ak0wJ68=;
	b=TlqPy/L76GG1E/sHqtS+gR3/zFhZ3Sh7kSzn7lsRQIIH2+sk4BUODAmY9K57z9V5pfZI
	 KIyI09YKFAx6AWn8nhm7YLZjLbC+klmZIzSO57Bp8VriGCw2gwI/tlOCdruz5EL1pyGtQ
	 S6wv0DxSJm+m1VCc4IF+Ndi/I0HajJbfUoVjvUNnPIzgqXeo4xmGAwlhDKg77Owaf69+J
	 0glX4EUMU3V/HqxXn9FSKt/ioNJx86qXnhP3lWb4SCut030YYWn691czHyKG4kZSSCBzq
	 ejSJwI12aoFNEOtZNLHJrISx5uq/3xERo1nJrAjel6ZnL5EENU29843CPcP9A+KkoMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="dKU/AE2X";
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBC606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFBC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dKU/AE2X
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso1279157a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792661893; x=1793266693; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yzwu7Mo7blUPO2g2psRpJeiXJWtUOEqjjPI2Ak0wJ68=;
        b=dKU/AE2XlsC7GcWUGeGpQLt0ZDOploOIt9TkwpjyXXpNkXM66tiQQU3PdJQ6YC4eqC
         7hu3ePU433r6xt92ffRnYkgKDbvLPW7yu6du2EQp6Wjv/TwNni+cuHZCwDBi/nVtnaNy
         OTRLqzaVMETwbad+9Xmd1SPzaCyJpTnX8pbq0Rea/YPDrSA2YuojfiPoPqmwzh+lzLxG
         TNllcY2VYwQBqP6vP/Cxuky9Ab2VmodQpf29JEJNNkpTOqasJ6MzHFIjxne4Wd0/YO5U
         liYC4YzUiTebLacLHzw/aKKl0vJ9JhrpSQSV6JysLowoxESrymrjH7h0JXj5c4uJQFZB
         99kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661893; x=1793266693;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yzwu7Mo7blUPO2g2psRpJeiXJWtUOEqjjPI2Ak0wJ68=;
        b=RtKNXGicADA29Xf1KGZAK0YfQgkyr8aSYD3MgDxKL89u8v89SPKKrYHaFk4VTtA93V
         V/n9lt8kegxOgrgfDhvGgIR6iEIZNyDe50MeUUz1UX5C0uzhI9mnDFiHmraXxF4j8+wl
         Ix6JLmA/e/uBYtCa4D2ItS2Fx7+Q6fgP0URSemecuCqe6UAiRzdKxMGIaS0Rg3yLzYbY
         iKdz5vZWhLpEwPzK1ygyX9gMCdAecj8NohUPahivLVXReZOFwjQYhj65ODV7lzvlTT1q
         jYsdbga7S8SdIZvaKoqIgSyQaIXlNCjMGndVPU5vbMNJiu4qqjtO90+kUPM6F4LxOFlo
         1G2w==
X-Forwarded-Encrypted: i=1; AKwUvBwQo5L5FcdwUH0bqPPau4juXOawqjo1zy2LthISrUMwEnJJQU2OOPPGoab5zN0G6Mk5CWCZrCE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7dWvUinP6bQeoGrurccFk2zevyHyI12DFqh56eEv+APbg4pnb
	aIxEw40m/FxP/dqbg5D//8Wffvng5YHJTXRgsY1Q7Yc4fxk2b+AKUDms
X-Gm-Gg: AYBFou3XBL2DmlSur/cdPymhzGeI/N3YWhFRY3aCueoKVMZ8iXkFuhsnNh9NhJy2+VX
	E8dFvNkdBiZ+DGcJZJEQrVA6jU4dd0mLKKBq5KHsKJldgkLzWSJ7B7L9JvZGIQD1A8ji1ub/2+3
	nqUn04wxD2IC5FMvP2UCWjVNaqps2/cIUAo2Rxodw4+w4DnCXeR3/dDNrdiKq3d4mgBcs6SAYlv
	cqd5vMA8bJDGzUNTJdbLM5fjGnm9zFvZOi/I/Ed+zUr9zVjRMjZN8KM66c5x7H9tEyXw5Q0LWXk
	R6svR2THQtZzdOtdNvBnCkNbJQe6MzCiZxsdv/KvN1xdrNJyD3vqeKDAqVIrk/zL8s7c4IIKfga
	MhvVJ5o1xTkv6P3egRdeGTdol20SpKaoVfb4TQp1/GAHVYZTpX1WXSocQT7ouGvnr+cm8G9Fc0Q
	Pb8Hvn/r5aNM24SOXEZA4EkHEE3fpNjckN3j88uytTciAXBAUCrIBJl9FifUwJY6qR6KlDpaq4/
	9ABXTvmKH1EywYuri97yiJZSaxKP9u8BcQ4yHGMI/oHr7xPXAAcY8QpIulyB1kNELA=
X-Received: by 2002:a17:907:d18:b0:c2e:616b:6763 with SMTP id a640c23a62f3a-c468d5d92b9mr198921066b.3.1792661892804;
        Thu, 22 Oct 2026 02:38:12 -0700 (PDT)
Received: from hp-omen-16.localnet ([193.107.16.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a55c1c3sm87755766b.32.2026.10.22.02.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:38:12 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Dmitry Yashin <dmt.yashin@gmail.com>
Subject:
 Re: [PATCH v2 1/5] dt-bindings: net: rfkill-gpio: document reset-gpios
 property
Date: Thu, 22 Oct 2026 14:38:07 +0500
Message-ID: <W90ai6epRoWrikRmhqTrfA@gmail.com>
In-Reply-To: <20261019-aggressive-frigatebird-of-courage-9cc7d6@quoll>
References:
 <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
 <20261016-ok3568-c-v2-1-068d68430e6d@gmail.com>
 <20261019-aggressive-frigatebird-of-courage-9cc7d6@quoll>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 19 October 2026 11:49:17 +05 Krzysztof Kozlowski wrote:
> That's the same pin. This was sent multiple times, why is this time
> different?

Indeed I overlooked previous discussion on the same change. Thank you.
I did a few more tests with the wwan modem. And since this approach to
handle modem reset more like a workaround, I'll just drop this patch
with rfkill node from V3.

-- 
Dmt-Y



