Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D473769E4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628126; cv=none; b=qj/d2bWjJf5r/bJADTuwauLnbC2NIxR0tq7PMhPUSJ50i+ESYrpgvmyt9E6f32o/8IAKsuXcYHqNeJWSs/3B9Wwz2afle2aDK944ejKHaMXPUKZI55uYHPJXmKhm0xiTohUc11jDukRQEWSNP36cXJBC/EMmYrIXPMGRls7xagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628126; c=relaxed/simple;
	bh=J7emkB9A/GBF554pJGWYB0X8xAbrySJveNGfoOUE0tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 In-Reply-To:References; b=hv+0ei0XYP8c+t+ZfAgHOVdzn9dARnB8HA46r0cGSxkOv+79Y2s7lAl5OpbRdhVRFXkSP22oH7wqbOBXqXY/xK5uP1Ydj7Jk/TN4/U249+lIdOyUR7vBBEOjWiQ6y6SoIW4dx0jWo8QwuPGfprqt44SKD19WXjOq0I60zspGgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYZN1wiy; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYZN1wiy"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so343019a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789628123; x=1790232923; darn=vger.kernel.org;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUm8IylK3V7lcVuZn2ulYwmszlPFrNkvTKkjAabL9nQ=;
        b=VYZN1wiyohjDlcQ25L1rn159eGo7efw2phuqsRnsVuJvahr1E2mHo+JIQoR2g3NDdW
         YPST6Z82S4IybDmJTUZEDawHg2tcaCqUTSZfAlaVQToXDZvzH+pUGlac3bcCgvHilGrw
         thv6nP0m0QUz4wClCxjC+T03vEg+wzKo7vGXnHe0UFUWo1BpbulXb6VZGWPaGlOm/Y7S
         aBdFjQkOlmPHMT0KxEBxXIg3Ec3Z8AbCiRWWslWlRFdh7ft0aGHkMN0BuOo8bgp89XTH
         0GMk8RcEVh895/T4DgzXDvEctJWj3h1Yr8B49Gd8II7NUHHXzVMUS2NSGoy8uJlm1mnk
         sxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628123; x=1790232923;
        h=references:in-reply-to:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUm8IylK3V7lcVuZn2ulYwmszlPFrNkvTKkjAabL9nQ=;
        b=FeMuTmlj8SuQxMUq/m3ONKwZNrQONWWxmtJP4btzMLR4Gms9pkrTlGNHsFceHEgG2g
         cLNqIwvkAkshGLmjTMnYDGZlOEE7J78xfxKA8ds/SSyPnh7KzNsAyRHKVQ9eSx0c4a8M
         SYp+CmdF1+OrhtFisvp8Js/lEaKaETgHg/R3fNIozIKDwJaQtuniXyN1yIHpMTJ9dlNd
         HFQUrPC1UmbbTj1JLYe34ipNcidALFxA0mBR9+wjaji8zpReNtqmheM6PJM+XnPa6fQL
         QNHmXjsqwBVvHOdFCADAA3+yZlIF/5BG74kJqsNJ55jjt1MoIj8jZc2Zx+3Ccz4BT8KA
         6mAA==
X-Forwarded-Encrypted: i=1; AKwUvBx5SAPe5Vs+y6fLyD5eeMCDBMyyM1GtNAFiPT32SaSYMR9og3O9v9NJ3KHO3K/t4GHoctwNOxs=@vger.kernel.org
X-Gm-Message-State: AFuF++lC2zRO85FK/tFHwZ5Y9ppZUGI4lVOXeX56gbQ0tsrLGtkROAXt
	D9wDxHfEAnlkumaNGlWsM1iLJsHK4Uc5rGNlZtzGQi9JXxrNbzovAms0
X-Gm-Gg: AYBFou2+AX4oYLrR3a6mfjLLSyA+k+6hE7JkFbCjRWlZ2DiqwNLvQrKuJ+rrX/CsgCm
	X03ORlDI/ufHKbkn+I//tfRZLINPTmVs5NwA371Q9d9ujSAEmPtcmQcyR1kWz66t1BavSQy6u/N
	WLkC6ELiZy5l3vxabf/CUVzgVEFUxV5rZIWHJ9SE/aCdWYpSJbXIyMlLntQ5PoOLu4MP1fwIfmO
	OmouklZFtdIrF+1lBK77tWAJZcYCEJ7Orc7VmciicMV3aDn/SPJGN6t7A+URP6aNcEcYnr+Qfmc
	cTsB44QN9N72hlQ3x2yadyBQZLj3rPnw2FsCkKoATZ3dMuse5w6VfEUE9hB95KrccbZktiT5hpc
	+/wSfEOaRH0/6iHlb9/BU4qTqzTJ+qrqL4tY/LElNpvsZYPoygNw7QLeYp+z0DWiDPfTXW83U1K
	PqM58ZGktV2PLOe5gJ7/bZSFdPnM8efI0+mYwf7lEEDibz6scv9j02gcvmKyeUSlMJUTXDZd88t
	+Y=
X-Received: by 2002:a17:90b:4ece:b0:39d:ba21:fd90 with SMTP id 98e67ed59e1d1-39e1e491176mr18804302a91.16.1789628123381;
        Wed, 16 Sep 2026 23:55:23 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35def1f2sm3334653a91.5.2026.09.16.23.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:55:23 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: mediatek: fix PPE resource leak on remove
Date: Thu, 17 Sep 2026 14:55:11 +0800
Message-ID: <178962811102.1264013.13698060411191875408@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260916051618.2904439-1-lgs201920130244@gmail.com>
References: <20260916051618.2904439-1-lgs201920130244@gmail.com>

Hi Guangshuo,

Thanks for the patch. Calling mtk_ppe_deinit() from the remove path is
the right direction, since the probe error path already tears PPE down
but the successful remove path currently does not.

However, I think the cleanup is still incomplete.

mtk_ppe_deinit() currently only destroys the per-PPE l2_flows
rhashtable:

    rhashtable_destroy(&eth->ppe[i]->l2_flows);

This only destroys the hash table itself. It does not free any entries
that may still be stored in it. In this driver, L2 offload entries are
struct mtk_flow_entry objects allocated by mtk_flow_offload_replace()
and inserted into eth->flow_table, and bridge/L2 entries are also
indexed from ppe->l2_flows via mtk_foe_entry_commit_l2().

There is also a lifetime mismatch for eth->flow_table:
mtk_eth_offload_init() initializes it, but I do not see a matching
destroy/free on the remove path.

So I think remove should first drain the offload flow entries, using the
same per-entry teardown as mtk_flow_offload_destroy():

    mtk_foe_entry_clear(...)
    mtk_wed_flow_remove(...) when needed
    kfree(entry)

and then destroy eth->flow_table and the per-PPE l2_flows tables.
rhashtable_free_and_destroy() with a small callback would probably fit
this better than plain rhashtable_destroy().

While touching mtk_ppe_deinit(), it would also be better to use continue
instead of return for missing PPE instances, so later PPE instances are
not skipped.

One more minor cleanup issue: mtk_ppe_debugfs_init() creates the ppe%d
debugfs directory, but the PPE teardown path does not remove it.

So I agree with the fix direction, but I think this should be respun as
a complete PPE/offload cleanup rather than only adding mtk_ppe_deinit()
to mtk_remove().

Thanks,
Wayen

