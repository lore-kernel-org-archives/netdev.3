Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467B281525
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782036395; cv=none; b=RYPUrjc6CPI3nklMFkRWODQ28Uum3HxM1VxWG0wB72KQ/xD+8JttN/ncq97uGDaHfp/Z41fgqEh8JfRnO+0CBgvl8aBudCpxHQPM9t7tfWN5TSTFJWnUgOMnI2JliU8NXGMPeoIMYEL5BSuvRpAWnCRk5Rj8uVgDcfhzVa1M+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782036395; c=relaxed/simple;
	bh=CUm3SfbpfNlkqEh8WWobdOtndg3TnSbH/Ikr/MnEhgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Kq1yjHtisMwKdtcsZLg7snUTdfcOfH55P/QFQFAuomRteWW9+TcwnFHhVNtZF+mCGkrykqnjuoCvVqdEX6hVWrJVG6oeIERZzbStFHP8g68J4/JTuZT84r2erMbeFB0sWO3UjJwXg5UTPSGXGb0Z4AHI/Nl+hG5jHFesl99+lpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msg25TWz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msg25TWz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49222b6e871so28865625e9.3
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782036393; x=1782641193; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ft9pji/XjdaUg56iUWbgZ4zMhyWSHIT+R3/5oq6GRM=;
        b=Msg25TWzOJeiIody7cW/bWQpJWtHJdAR7oBejdUxVKV0APiwQqAKfpqinL1acpluiO
         gbz6bN3b/RO3NnNKHxHgbag1L5+rwq1oNlsDY6siXx5Sn3FHcgoDqySa3izVvu2nHYBW
         OZuTw0d1w69xoXoTga6dwKgb8DhxUE+HwzcGfDq1yXVftHvIwHMKofXjclWX9aVSlOLy
         ujlDnaZlA3C2BDREdEZq5r4nK+WBNoA5X3AX7N2vbG3q8Oj8UlzBn+S9TrqFHvC475UV
         KdN1nRnLTojne+RfwiMAzHpNlwkb86GJ2mYI1jMYLQERk6G3Ij43tjSsYVfgGhbCI7pp
         6UTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782036393; x=1782641193;
        h=mime-version:content-transfer-encoding:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Ft9pji/XjdaUg56iUWbgZ4zMhyWSHIT+R3/5oq6GRM=;
        b=OX3zHYazLRbwb6DwM4R4axkbmrPbwB7tsx9O4lNlKAnPUOHyVXpXZ4ZAXPaDN1e2xv
         tfIPnq7u+mir6rOglMyPP+dmlkopzJLbwNc4v8v0InXZeVpnxQgb83+HCQ6VfeqtJ4fi
         B9W7UFR9J8H9UDnqNM2q799hpqg9ZYUNBQp1jEOZ8LgTwkpRHJB82S0JcZuthP6M027b
         ArxupMY5XyHbije6rg2J6zy0ukA3Nu/tKm8SWyfchKCUQzmR2eZ16M67UC0G2GEWiE5g
         edWVMs4Ke7TFmc4+2mteXRfzp/46UjrW25ytwrr3HJmno9Wlm3O4cng8kC4bKC6OTKNx
         4F5A==
X-Gm-Message-State: AOJu0Yzzmoo2D+or2ZbOhLIV5J102mA3diS3cm+wnuwnhHtI1CMRlwKO
	4vvpqDnn9lah70pPeKa64Y1GjV6k3UVm1kRuOjxG1wCdJ2GYvUaNWVNNe2z8Y7fF
X-Gm-Gg: AfdE7ckOrdvU5V6kFLOTmRLrtgSkoJXCAPJgd812SAE5IaHTyaOBkQZMNaY00ErzIsM
	Jc1/OxZuJG2h54bXE+a00n82qhRoNGHmplWmDU2LLE3VdcMnprRAbv3FpFR8cuXraQ4SeLM0FR8
	zxDr3/y87sr+Fp4TzXsfbXPVdyXrKlGV3AMR2Ld1TDM087MvTulxCJKEEbtc510u+J20wJrBf1J
	o62gM367TfHxucPc06W1ugoteprVwa0nGCwPO69TTx+VLvYVcGWYSS1y4K71ktI0VZm+CCdKuLj
	kjvTOOoeu4xi/nxH8KvP/or+R/MrQvyLjhAKzz30qhqTKWZkOhJ2SzIiIlGjyToTihwEEJYugDg
	zW+KjkPL3cmW0ZbfIr/5AXOaVL/goQ/PzQEe40wWQQbBe03DkZgsSL8wa2DuFKhIBwWynOJm4/A
	sKkMXbt7BFInbjcQHonBiig1kstdBK4mKWL2W8CaShmW8jI9P4UafPtv+2FIsbSrNfXp3zcmD/
X-Received: by 2002:a05:600c:1d29:b0:492:3fc4:bd6b with SMTP id 5b1f17b1804b1-49242314120mr149767185e9.7.1782036392791;
        Sun, 21 Jun 2026 03:06:32 -0700 (PDT)
Received: from Petrs-iMac.local (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm15848988f8f.23.2026.06.21.03.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 03:06:32 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org, sd@queasysnail.net
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuba@kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com, davem@davemloft.net
Subject:
 Re: [PATCH net v4] xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
In-Reply-To: <20260603064659.3867-1-petr.wozniak@gmail.com>
References: <20260603064659.3867-1-petr.wozniak@gmail.com>
Date: Sun, 21 Jun 2026 12:06:31 +0200
Message-ID: <178203639130.40316.5573016895988206218@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reposting on the list, as you asked.

Apologies for missing your comment about the 2nd x->type_offload->xmit()
call across several versions -- entirely my fault.

You're right: in the skb_list_walk_safe() loop, if all GSO segments
return -EINPROGRESS, skb is advanced to NULL and the function returns
NULL instead of ERR_PTR(-EINPROGRESS).  v5 1/2 fixes it:

	-	return skb;
	+	return skb ? skb : ERR_PTR(-EINPROGRESS);

At that point NULL can only mean all segments were stolen -- the error
path (err != -EINPROGRESS) returns NULL directly from inside the loop.

v5 1/2 also restores the blank line in validate_xmit_skb_list() and adds
the missing maintainers to Cc.

For the use-after-free I mentioned: I confirmed it.  validate_xmit_xfrm()
unlinks async-stolen segments but never updates the list head ->prev, so
when the last segment is stolen, validate_xmit_skb_list() chains onto it
via tail->next.  v5 2/2 fixes it by repointing skb->prev at the last
retained segment.  As you suggested, the two fixes go as a series.

I could not confirm the head-list leak on a closer look, so I left it
out; I'll send a separate patch if I find it.

The v5 series has been sent.

Thanks,
Petr
