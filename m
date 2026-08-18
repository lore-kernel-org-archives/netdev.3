Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B434E764
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787015974; cv=none; b=oaxNYlHmwhiwY+hfdatE7x+/T/ap6XY30HS4Ap54QdY9tg3g9ruvbc9PwFo8xMBbdEoSFBSkt6V7PuRS4zat1xZPwI5fW5fG+F75+U2I11bbQFKd1mXfkN4dMJka5/zHpSqGoKqRPoEOjSU2Q0YxDIvXvMuGxnE+yOZA0dvJuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787015974; c=relaxed/simple;
	bh=+9DJbzpZ8tW/cGE2nLGaoIX39pZZfgkjdnpyQdZ4tGc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 In-Reply-To:References; b=rXfbbG/WLW4l13mjXErYakg4w3kPklng++ZBa24wyszNJGh8GBf9XigA7sLXaFI2TXFv2xrt9xIa5eWO428gutEB4YvSroLRmAWB/xwyrdVK3Rfu55SRRRBwxQ7A9acwXHX6CpeuskIhb5cw6uSX+a+HpFAyn05MYk6HJ0/5srI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTzqZCI0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTzqZCI0"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso515416b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787015972; x=1787620772; darn=vger.kernel.org;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfkLuSdmwN1ckqZLOyJ0ADFIrM3kNuRenkgg7slseYo=;
        b=mTzqZCI0lnS5FLE6knMU4CnAcDt6Ef40mWfNla2lhEfzskQNG7x6rTY+VgjYe/M4v1
         q+LLlTdrX0fwaPbsecTCWViGhARnC00XDq4qCe8wn2mOcx8BFqJgLmEOmaWn1eJ0jGPT
         tEwvJ7/qHt50Zjn7ZvzGDrVuckqMqgq7x7jsnUDE+HdOhvPwsZ3ph3Nq/mu4SkkZ3kMr
         CWLc9tmBvT1GwGfbEcWuUncTPjpr2XnS5LwT5sdY/KWImts5H9wIRNS0NDZCbZ13tfDU
         /93Twzq7RWnCwZq/0NorDWR9aQ+pjxwEaKxH1lT70+YIS9DPvQ2U0Prx3CbwAkB9OoH5
         f+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787015972; x=1787620772;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mfkLuSdmwN1ckqZLOyJ0ADFIrM3kNuRenkgg7slseYo=;
        b=cWByuRWY58tpirF79rDAgu3Ep2xDGI9GpLIHcgusDMV/RvrxK+BYxr4UjNBCGH5MkG
         eo0kM46TXaYyKXzMWlpb8qK3YTySQ9v3D8mbVSbg8MMSj7j2cyTwCSQnb4zK46DY4Xpl
         UuhdPKN1iphwxx6zSTCtOWatn7r765e0FTYE7S5dQNagOKlmKha2dwqzM84iZuIonqKv
         D/Hw73kk/SoRQdjao3AO0Wd1FhNwr2Dk+gUwcx3yO7HsWATteiVxlRVdWvUcb08ZJJrV
         owdJ9SEu/oqgnL8Fq50OysQJ/WoH1dwuDbv+iEQkM64ZroOedacGhVkL5/HbPd3AkSCU
         kcBw==
X-Forwarded-Encrypted: i=1; AHgh+Rps0nS3RPRJAA0VJaaUFOspmWTu7CEcoiUj93llyESodENINKoE38SGmSSOgCOMXZHcpLgcWSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xDPL1XMO7blyusVQLnDaPX2layP4/kZTx31qClobarAHtP2D
	F8qYWteZMLU51C2QwcuPXOnZEB9gNZJWbQiynWCgrtEmU9wuna2WOmOD
X-Gm-Gg: AR+sD10d33tJmyePjYGN8EXtU0/WuqdpNY32yiDrqkxfIwSgUj8az21oDgEPPmzI7uY
	EJ1Y2/LyJ+/GKX4KEbvIyE3Q6Quh13Z6WxLkwcbQvKbaMnIprBA+szNAdcIimynhcN7PVDxj7RK
	hBKVc+LLhxVBt9+Nmgl3PDtEqM+Y96FUYJpybhNYE8b4UiMvQfaqkRN7fY+Ou93VKGmFHCBc0PZ
	tPlsMl/5iOnLTqhRVkvw/c2QB1SLe8mgl17SUGBKJO+HlGum+jKUCSvXc1XjVWBj6MUx9Fyw+nY
	jnbB2Kf9kIcKGcuNSUfpq3MtAkCN67gdkY0si4QK07Bip/iLr/TSCEK9zaoPFXV53+iyxZEn6zj
	qdD0JDoyuFb0yZbt6VmeLe/ADtFE7ptCUQEw8JUpeL2e3DROTAUB1+sVNBMK9E2NlqUGM86scnq
	k6mSxEGHK4w/u5W7g6tLK3s5kXlh3Ct5GnDqqGekD3G2xOm8NLqG45hA==
X-Received: by 2002:a05:6a00:ba8e:b0:848:52bf:4296 with SMTP id d2e1a72fcca58-851bc3ccf5fmr2527196b3a.15.1787015972070;
        Mon, 17 Aug 2026 18:19:32 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b3d1099esm1196713b3a.0.2026.08.17.18.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 18:19:31 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v20 04/10] mfd: an8855: Add support for Airoha AN8855 Switch
Date: Tue, 18 Aug 2026 09:19:25 +0800
Message-ID: <178701596581.1096543.14003915779643840966@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260817082034.20326-6-ansuelsmth@gmail.com>
References: <20260817082034.20326-1-ansuelsmth@gmail.com> <20260817082034.20326-6-ansuelsmth@gmail.com>

Hi Christian,

I noticed a possible MDIO bus locking issue in
an8855_core_probe().

The helper an8855_mii_set_page() is declared as:

static int an8855_mii_set_page(struct an8855_core_priv *priv,
                               u8 addr, u8 page)
        __must_hold(&priv->bus->mdio_lock)

and uses __mdiobus_write(). The latter requires the caller to hold
bus->mdio_lock and checks this with lockdep_assert_held_once().

The other callers of an8855_mii_set_page() correctly hold the MDIO bus
lock, for example:

        mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
        ret = an8855_mii_set_page(priv, addr, page);
        ...
        mutex_unlock(&bus->mdio_lock);

However, an8855_core_probe() calls the same helper directly:

        ret = an8855_mii_set_page(priv, priv->switch_addr,
                                  AN8855_PHY_PAGE_STANDARD);

The MDIO device probe path does not hold bus->mdio_lock around the
driver's probe callback. Therefore this call can trigger the lockdep
assertion, and the MDIO page-select write is not protected by the MDIO
bus lock against concurrent accesses to the same bus.

Could this be changed to take the bus lock around the call, for example:

        mutex_lock(&priv->bus->mdio_lock);
        ret = an8855_mii_set_page(priv, priv->switch_addr,
                                  AN8855_PHY_PAGE_STANDARD);
        mutex_unlock(&priv->bus->mdio_lock);
        if (ret)
                return ret;

Alternatively, if there is a reason why the probe path is serialized by
another mechanism, it would be useful to document that assumption and
annotate the call accordingly.

I don't think changing an8855_mii_set_page() to use mdiobus_write() would
be appropriate, since the helper is also called by paths that already
hold mdio_lock; that could result in recursive locking. Keeping the
helper as an unlocked MDIO primitive with an explicit locking contract
seems reasonable, but the probe caller appears to need the missing lock.

This is a discussion and fix suggestion rather than a request to redesign
the series. Please let me know if I am missing an existing serialization
guarantee in the MDIO device probe path.

Thanks,
Wayen

