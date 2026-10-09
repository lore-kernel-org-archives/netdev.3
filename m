Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DC3932CA
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561459; cv=none; b=KX/b7wSqI7ll7H+I243RwRAWjKNzu32PCLsubMaCizMoRAls62tX8ZMXR5thjHeRvWqWDhB0Q3JbStqqQfkT/r7NrSymty/t+DqXduqtydJR/Skd2WlkFDOvJX2BKeRvWQCJORLlHY4dgmGO3k/jVrSZmH14wmlQPh9uxkQnXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561459; c=relaxed/simple;
	bh=Mpg94/pFhPBcqMak96469hcEggzTpmAD2c4XXoOujhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9JKl8Besh3DW0Pw2DBJmsB6uD3gS5ncsVSDfSe6S6MtyUOn3AfsbJG+mDS7gpSS7Ze55fnmm4cdjOt9qWH6IhFOh83IftxecAD5wrzEW/4pMBa/1M7SzOtWE9+CFm+yGhNTj5b6ICiwpB9k2bLRh5Sa5advijHBrTjfWlhHUXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6y7YjRF; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6y7YjRF"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso1266680137.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561457; x=1792166257; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4pkQpZGByfs6jaHMa7nJIVkDQrQWOU2ACAqg+X74hw=;
        b=i6y7YjRF3exiYLBNjF0eSvuSQZ+sDdxxtIe+vioYWRkh7CAl1T9O53YQwaFRgA9oFQ
         +/dqfsT+MBHc9PpIzUc7s0vJm+gBnLLV39x5J8g/eNqBPqExIghjjSQAtp8gJZ3BbH75
         PYIbi/wW9zZUaoEnyCIcOmrDj9hNq5yHr5CrOzOMVDs7Cfm8g7r3L/VRXD1qsEfLnW+U
         ahBrJjMc5w8S4NJ3E9EAwWR6rizQZEapAMEUjYFwqvSJkRdPT0PbpcpAc8FZAWdoIj+e
         J0wtNZhcQ2t82mYqvq4quNKK9BEZ0PhAZcXOWUoEmfknNUqIXJDZMUEbR9hq/v+duYBo
         ZY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561457; x=1792166257;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4pkQpZGByfs6jaHMa7nJIVkDQrQWOU2ACAqg+X74hw=;
        b=1naC3vIAa8eF+48CPmfgBydMEapJlFNX1FbvQ/F3boQ4LvWqWCiDwgVsXwk4p9Xg7A
         Zm5jUk48ZyFVT+893mjx96ycdqTugUfulTXd3XKD4AWBxEaBNrOM4MH33xl6WNzrPpGI
         ifsbKoch6pqc2y20O1/Cp58TgPk+9qhn7Og/AQ0/14/IajZ+jM1RqCWHohaIGcl1Fqfu
         jJ4W/Wz4oe2KGi6Huqt3kyS1BkJEa6VmjRp8EFJGINFNUXxtDydfLB1/UkHFL/vH1Ggz
         rL1NKHNQkULoZ/S4x/QunmvogbieixzJoZqyFAz+EaLk+YFMdSHnR9tGRB9RjWpujQRs
         WyMw==
X-Gm-Message-State: AFq9FYJAe6pDvn7H2NAvIRHPxVWnAixmDmN0AlllbvraKAbrvUaUVxA0
	u/pFkKwEZSAOZs1woWgVvUvjTx14TG2ULv2FY26kQGsgelqUgC7TnT7r
X-Gm-Gg: AYBFou1OV5gFycuZSP9b4mWjpvylanqIwUU8UVCTa5xH0czG4hq2pvIp+YNYzjTqu22
	aZN0+J6Vvmj6PFIZVjaXx2havjwI+SfOyY3ybM/2sOFuHidMqyyRJwb4p//0RbpGy8g2c6BYjcO
	nPisgwgvQJS7IscFB0VZZr00tKLJA0MJx3gowiHkApkUeJitlj5uFWIvr0wbxotFVDY+XKcvAvC
	j4t7NaW18Iyp6135DxvAgM44xuz931WaF/tuyS2JWZvFSnTC81Xl4mj3DCrzhlEeOzCY986Ffvs
	kN7V9mLEPtd418oGqlhw11mHZnwjCvZIpzm81VmmLWnYT8tkQjLC5on8QNM0DAMdL5+77lc8cGA
	Yq1/pT2y1t+oTlLkkrCgBAxU93fZfTMN2dLLYv6l8B88A0EcgkshTW/HifFAfNo5HxsNoZDCmal
	EajMxzYMCGnj/5fUk/U8PTfOLuxcxE70wDKo+QrXV+Dz62qdtkN9wjpA20gNWEgP2b1F3QVEqp9
	GYY4E4x6cs6Ql2UrQlXSt0E6W0afjOinPD65CGcBfquZTqNSgNf0ZKUuI3Tptof+DdWLKYEaMKI
	FaS47EAmPAOAR1M50/sCcUfhbR+rG/hgL7VuDIaMdU1/ZQ+bzfH3SREK+D83
X-Received: by 2002:a05:6102:5114:b0:7a7:195a:1b29 with SMTP id ada2fe7eead31-7cb375057ebmr674951137.35.1791561457026;
        Fri, 09 Oct 2026 08:57:37 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:655c:c59b:456c:2d4d:2359])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb35471536sm1860352137.11.2026.10.09.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:57:36 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-security-module@vger.kernel.org,
 Alice Mikityanska <alice.kernel@fastmail.im>
Subject:
 Re: [PATCH net] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
Date: Fri, 09 Oct 2026 12:57:30 -0300
Message-ID: <179156145081.36175.9867662260614090326@gmail.com>
In-Reply-To: <20261009084616.139462-1-wang.zhan@smartx.com>
References: <179147330473.58090.15760316487710432833@gmail.com>
 <20261009084616.139462-1-wang.zhan@smartx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 09 Oct 2026, Wang Zhan wrote:
> I think there are boundary cases around IPV6_MAXPLEN: growing past it
> can cause payload_len to overflow, while shrinking below it leaves
> payload_len at zero.
>
> Could we use ipv6_set_payload_len(ip6_hdr, skb->len - sizeof(*ip6_hdr))
> to set the length here? I haven't checked the details, though.

Hi Wang,

You are right on both.  I checked them with a test-only debugfs hook
calling netlbl_skbuff_setattr() with a level-only label:

  case                         v1 (this patch)   your suggestion   real
  65530 GSO, grows past MAXPLEN            10           0          65546
  65540 GSO, shrinks below MAXPLEN          0       65532          65532

(0 meaning ipv6_payload_len() falls back to skb->len.)  The other cases
(normal packet, BIG TCP growing, shrinking a normal packet) give the
same result either way.  skb->len - sizeof(*ip6_hdr) is the payload
length there, as the network header was just reset to skb->data.

I will send v2 with ipv6_set_payload_len() and the test table once the
24h are up.

calipso_skbuff_delattr() (the other patch, v2 already posted) only
shrinks, so it cannot overflow; it can leave 0 when a BIG TCP packet
drops below IPV6_MAXPLEN, which ipv6_payload_len() still handles.  I
can switch it to the same helper for consistency if preferred.

Thanks,
Joas
