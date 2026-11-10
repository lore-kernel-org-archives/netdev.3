Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333998;
	b=faRAo+qYp2PS0ZogeNwR/4QFgEmNM32blD5pVq1YC9GmMvIiJ5HWZNWZ9n9vn7q7+mE9
	 c5BEcJ7dQX7T79mDwhFh18adk1AbTbwqdY/P3PYHEV12nDFu06IdnpcTQ+lxnNZKciMLd
	 3bA47V5rK883rckytr5YsBeqFQzN7yvnTlYCpUePAjN8OQ8MuXvjGGkwIynZwn3rU58hE
	 nbUD80dk6sHSKTbOjxxvWbfQ1EctBzpcIDtPHvPMGWUNsjaKFnvP+a6wbIfElxYBPEfWE
	 bzNvti7KtVzKceIvsdVA6Inrc/wXK4jhnmwGQHPwy4CSdmsTP5l49FHSFJQOoRo1LGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=GzOxYTq7EHxh8VUxt5+RHjpcCv/SzSEIP5xLxXIbEDA=;
	b=xaDE1G21aHa12fJ+W0pMt3odK1F9MD40mWv5XUaU7kfHbJDR9W439VQiTlwGl53wJq6B
	 CCr+603SMQGB9oSHiP6a+6jNyDCAugFWc3mN5pvnrfUGQcNQX0r5hSAzkkhbeGzjKoc9l
	 OIUE0rQSoSMkGCG1MMZI4dOr+YJtfeFFJjn+VGtAiAyOmwmzDAZstX44xmE6RMVCDql+u
	 mlDZk1JXKa0AlWk6fENgzNcJBduwW5a7imu3Oi8eAe67KMf9BOC7H1GFUmJwHnEdEIYJ6
	 to1kmok7ZvBfwQEylg053+7GInClWDHBkv7DTjAeomSAlyz0+JjPyO19Wc1kPaFB10Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20261015.g header.b=a0rPiWb6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD660A2607
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97BD660A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20261015.g header.b=a0rPiWb6
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d58c50743so174189966b.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794333996; cv=none;
        d=google.com; s=arc-20260327;
        b=ovXh9m4WAN43oU8u9xHngVopOV4TYUOKJPbImaGROqy6z1BayOekiP3uCu+sKjxki7
         9J9v7FFF15RzBSLTbWx6BGwsIOUHbx9QVHBPgCDI13V4pWiwlY7NmRkxjGO0KTarA0Oh
         kLRvJ2FOWaPNKoFRCyqG78SP/8tYENGnx4i795vTMGVdrMdr3V7iQA+lFPkSQOaEoo7H
         7fd+viDM6r54L8EJaGoHzJrpf1C/97M2FmMpteOBT3fYMkFlkyu81UjH3pG/hPERJl/p
         oVkxutWlRlweSi2/2CxT+G1OQI2r8KObbFVWl+53gwdxTaJ7TdPGpkWnqjVmxtZ9IQL5
         mxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GzOxYTq7EHxh8VUxt5+RHjpcCv/SzSEIP5xLxXIbEDA=;
        fh=xWHyjjuc++Wcpy/7KYTZFCZPhnyUZ+SJKdm3zmuXHuo=;
        b=ad9E7Qs2gnNzKy3Qi5UUSXiZo6Kc+I9VJnXn6v1BRV3ST0eawkbyKnoxlru+ckZ0kY
         y3Hzmn8CGKPDi1YfxFdAveyUCAViDtQJuO7N4Z2pbAIUycgRJyaxG9yNTOeJqH0JyZnu
         oMUtKcuCQDCQhOKKFYl+I3GsQ1sBj4n+zaAhJc5/tBYjzSYYYnaROzSz5qs6bRx4c9vT
         K2reChkgXrSUoOYNgRJnBZd1Pm0V+IW1TxQspp8pCylxLtyVu2SngmUo6/EwXdZF6Fjf
         WwZqo1e7pfKLKVfEiMQVe60cF73InxuK3W/i44TlSd4xNyfpo/W7BmrBAcUD9YU4PTzi
         cCag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zx2c4.com; s=20261015.g; t=1794333996; x=1794938796; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzOxYTq7EHxh8VUxt5+RHjpcCv/SzSEIP5xLxXIbEDA=;
        b=a0rPiWb66uhhooRgzJb6oHoMppMYrookK7xJNcUPFqJzEdVi2grND7+FILrWsx3Tss
         DzH9+GbDDHk/x+Xs0CZnsU7ZqKbULUo8QQktzl0lJMGks0WReik5niHTV3KMUB2O3Sfy
         D0TBp9ZRWvTT4L/KdmoJXszwet4OBZFoF6w215gtaA+OvCgSms2uFRyFsjFUC8eraVVb
         rl+FoCcvVkWgCk7kWPlg+fID0tE9x9FZYeRYue2e/R6S5y8NmHODTwia47wNVYIR9JYM
         kKlylL8qVRUwEftxMj692gnTfUkAZbmXB8EFnYbgH9UbFsILIBp4ueE0excjSF9wT7Jz
         lPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333996; x=1794938796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GzOxYTq7EHxh8VUxt5+RHjpcCv/SzSEIP5xLxXIbEDA=;
        b=rtra3iwcJAoEahX9w50h5stjZdm223A4LdCvAK6I9fyW1D0heZ4YgI1nT3f87PxmCG
         aDDXhufHqt3GixtfF6wv+T4RRE7OsAXS+wwq+pwlc2+R4N2sKtSC5qPbslM0EbMQyQG5
         JSf2UGNz0CNs5yNmj5Th0s/tR4nihqfrzxlI1SEzv0pd5LrbSv1eyO5CcgS4qWZD6q8o
         9r0xPvMNkMxnksFozV5GHHDkx70XLtuMu9BSrnJaWF0QgCODPjXTdwlCaH8gxgKU7Lap
         luCImIU1sMhp4AeSoN5kHuiykxzNkODEAdvogJjsGtkzgJN5a9GVuesSG38H8uPDzu4k
         vrKw==
X-Forwarded-Encrypted: i=1; AL+hErHw/m/23Z6jTQC7tbF20Kdjhjvwjq+eGH2RMUL3azqxKXc/adYoxn1jkeb08aDmlNmsTYkbDO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LOSVil4PA+kFctJ3g59ea7sqap9iGoZ5930n1tmNX4yK34DSq
	stLM6zXPtxn1s9k30QWrhzeMGNr1mTvupN026kGal9V/Cq8yNaJ0jgbL7bbB6IJIXuSF5V9XNC3
	GVuxr7pnA6FywgRIFhi1ha9OqV0IPpScveK3Vjvk9hrc=
X-Gm-Gg: AYBFou2EP21d0QvFJbIHhq5UqXPW/+ZbMLDyVZVVSpfYqk92xTdOhykbPDOML0z8jKK
	uLpNXpM/XXF1MbwglrCGV9XBKRf4xBo1QjusWRrgWkmjmvkrLcWziyXcbv/i5dNdiIaJ8nJdzQM
	Vrw0WLqI2Uxgn1iJrg7TV5s/f/EcW3tMMHsdd3hmPclLF9+xENUo3xyuwyszO5trEGVbN4TKSJp
	FcWlLeGk1BhKvx3+dlseJ4Wp3LDy/rfREeeIwxncs3p914F5gHPFge2t6suxqsq9Z2nGTjduPKE
	sqMM+EU+s0RYKSP0gJI2yv0EQF0C91SrnNnKeiu02/hp6TKpdZ7I/4EgXAQaaBqBsAcumWsV1k/
	sct4kxGltry6JbTeoRk/iRp4dlbcG27lVo8gP6ujXHbcFY2szDPCAWVJEkMQ1ACk9SwsUeL9YSu
	MRNuawYpTPCkVrI9Uvhf4Ps5O7avPz7p9DLV6U9rxmLmnXPfg2QDnO2EClgWTQ6g+ZtBWoRSPpn
	HmB
X-Received: by 2002:a17:906:1248:b0:c50:4a70:b7f5 with SMTP id
 a640c23a62f3a-c504a70c977mr195279766b.17.1794333995965; Tue, 10 Nov 2026
 10:06:35 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105141006.95083-1-alex@badcode.im> <20261105141006.95083-2-alex@badcode.im>
 <avNM9dfdW1uULJUf@zx2c4.com> <a979d36bb97608275f9f8884764afd41@badcode.im>
In-Reply-To: <a979d36bb97608275f9f8884764afd41@badcode.im>
From: "Jason A. Donenfeld" <jason@zx2c4.com>
Date: Tue, 10 Nov 2026 19:06:25 +0100
X-Gm-Features: AclHuK-z5kRyS093UsqlUbVg9AjVDqYIwR1bFV-l3asgu02YzQT6xz0LvKo0raw
Message-ID: <CAHmME9pMKKw-1dQRG5OEYrGA4K0GGFbpvN3Go8ZuVKLuaNMA1A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] wireguard: account peer and allowedips
 allocations to memcg
To: alex@badcode.im
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Okay, I guess I was just looking for some judgement discussion, not
more output from the LLM. I'll look into this myself on the slow track
for a little bit.
