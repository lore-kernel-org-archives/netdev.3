Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188120;
	b=4q+KA0kQr/CaaFQsVGYvKWIOoP3R1JznXmIAo/bU4igVX0wVDWJjBSH+4zeXLkPBA1X4
	 1CIjTJp3IjvvEAU6H4XJq/FMcUMTzph1mPagd2EERowm/xWD7wTbmRe8zWQCqvr/MwrKw
	 xhYsgjBpTryAnAw4atuy9LIbkQRuGyAGb9s85TzeBGlZ3shX7V3tba7kCyQ47cTzEu/nX
	 K3jg/tttD9OCAW3VbPmsJuStpuKcRo7DzgSV6XKK9V2X/ru7genwqrI5kjPEz9O+EKFGI
	 VUfjwyyCfAMBnhUMvU2rSTtagp9UHJjpp+h2F+nORF9igAUa41JD+MPC2pajGZRcVcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rz4LcTuIBFgFlzGCEXc77TsZGPHM5RG2DLR5yTjpqhU=;
	b=mxuTdvQHVvOzSAJIFIT4XEOM86BAGBlQZt1/jQSnUnloMnDwpAXUnxz5lUMKfF+v9m85
	 NY2V/80imjw3WdFMLwtisOLP18H7PHRqcfpGk48pgYA3Vp/oUwN9R8g3adOuYrghyPIvG
	 zxGtV76xzrU9iFBjzpmeCrYMMwA2P6G4cNN7PLvWH1PNEaw2bMDyaCREN1PdsonZXlbfQ
	 5kE+DC+hhF1f3p4x1Qx8PTsd68tpfGjLXAJLWTTbG9VJBxzzbrRnKZxUfcaGZGoMwJ5Ax
	 vJbVrSMBtxHkE6XOL+v1tbsPFIhQsnt8jyQhunlE76kF7KWnboFssNDWajVOgPt9bVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t2gJuUjT;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F8606A323
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A1F8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t2gJuUjT
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c46d41f6af3so117800866b.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188118; x=1793792918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rz4LcTuIBFgFlzGCEXc77TsZGPHM5RG2DLR5yTjpqhU=;
        b=t2gJuUjTUxdmJHYfEwyOU8B9odZv+OBtRYQtfaOaEhdxugMehZJIRfZBR0+pT9Wrvx
         xJBKLZDCnCOzMPmLPeHeHjPe3cmNxwgHhYPUlFmG5LUkGvrF0BJf+S7zWD7s+vUwyYsO
         jVbvuwPg9mI/7ARATnaEOjZoxG3a6ET6UiocRkz6y+RGu80rQDoSDD7I3jio7s+69cWq
         GObddatvItFxd8KzhHGNeNdVQky8pl8nZlDbPkWIRtmnBO7FAUCCSiDG4M1N+sbmUQr/
         A0R/ECCrvbKz5OZwPKeIdc9/m5LezrS3Ahmg918cEPu4XQgwadVCHdsAjq0y7AcYTaKu
         QxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188118; x=1793792918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rz4LcTuIBFgFlzGCEXc77TsZGPHM5RG2DLR5yTjpqhU=;
        b=Gn7sEhz3XoNGPCC+YFS9CjwINSKC4VdH/R0IMAOO58H9X4PZKfOSq2Il5+qaN1gAOu
         NzluNF6BTPZV7MStDuI1WqzPiXrKAFVSSJHCRRoWeC0DkKtsTLN3P/l250Ts4k7Qcron
         B62ZZRTluPbfdRWq811XjhR3jBKrgo81EaelsL/TdLrqXT1J4fF4KhkmfLgHy7udj8Cj
         4HNzQDG4mDs9c1tN643rsQFNzvHQJr3tIPgBKSVdA4k/ts1cQkhsqBrFnrQRNNH4QFtj
         MHUZkYXYDMj7zCBLUJkfleR2j4YVJy6iL+pFoMgw/ZNm4epBUX1MRPcRMdFs4e1vnGUX
         c+Ow==
X-Forwarded-Encrypted: i=1; AKwUvBx4b8FK1zKdPizAfhsXlSa5g5iKotxgRmFBdldvGogGKqyxRbUgbb7lbLDtHmzBJii+LQXP8vw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLT//6X8nXCrn5m95Zk1UOntzuKaa1Fdf2qbsKJtymy6nWZcwRp
	9+BL9HkeEQcdisbohmp/kZXOQCCoBDTW419azkzs55s/bd/oaAm+CzXA
X-Gm-Gg: AYBFou3uvYIhlDQOHOtzGQVw4uDlogz1xfhlxTugO1IVznhO7wRd7/LjPuurxoyu9GD
	qjU3nO1Y6HaoI6HV7vJdYs8kUPl36y3wbgLJjPn2bDnHtocLlRA7McENyQAwY25uihbIeAyU44+
	lKwJEoHgK80u3vigfLrPSYgY8Bbe/zSHPMM82l/WJoVGgKVc+TDhZHZsZoi1jptD5o7ktF0WJ6d
	ZHX3fs14ZgOp4knHQ39uTVFQfTN/IH9KDAfHY4m2hA4nAipYLxO1zalkGQYYzqvG4IS0YWS8i6F
	Z3wUD20AnmLePyK/BSRfVT+iV0q8aP/JgCqQI7W262psS4P+Nt305OFF3KaCL2PoBeGUCfhk4B/
	d/i/2qsL14oStRSpL80eQqtvaMbRUanQC4JQZR0tQ2TLVD4HvvF22aAri3o+sF/k5/V+85syoKa
	ZsEa/3OHYOH5j1js4OXuGx1WG/0yknnFUkVUOiy6RuqoMrluBewZZRN5M7EWIEfM5NNDlXdVehT
	LgGXIhMadUchsTF1hufhAv8NeLgAcR+EBkBoCTOA7VDrSLfvIC3QrdbhG+WZO0CcuromOZXdKiv
	8NldZ+0C5tUZDPnzfOI/uxE=
X-Received: by 2002:a17:907:94c9:b0:c3e:34fa:611d with SMTP id a640c23a62f3a-c49be00bf6fmr159888566b.35.1793188117832;
        Wed, 28 Oct 2026 04:48:37 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:43::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b496459f10sm1375962a12.36.2026.10.28.04.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:48:36 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Jinqian Yang <yangjinqian1@huawei.com>,
	Andrew Preece <apreece@meta.com>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: Don't keep MSI-X vectors added before FW reserves them
Date: Wed, 28 Oct 2026 04:48:33 -0700
Message-ID: <20261028114833.239086-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179310474137.3134.4690740150964769309@kernel.org>
References: <179310474137.3134.4690740150964769309@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 27, 2026 at 12:39:01PM +0000, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] The fix is incomplete when FW grants fewer MSI-X vectors than
>   requested.

Agreed. bnxt_reserve_rings() grows to the irqs_required it computed
before the reservation, so a partial grant would still activate
entries that FW has not reserved. In v2 the allocation is sized from
bnxt_get_num_msix() after __bnxt_reserve_rings(), i.e. from the rings
actually kept. With no RoCE driver registered, that fits within what
FW granted, and it is never more than the old pre-reservation count.
With RoCE registered, __bnxt_reserve_rings() can still keep more L2
rings than a partial grant covers, because the ULP share isn't taken
out of resv_irqs. That accounting predates this patch and belongs with
the ring accounting work on net-next, so I've left it out of this fix.

> - [Medium] New error path leaves the state inconsistent.

Agreed. This path existed before for the bnxt_reserve_rings() grow,
but the patch makes it the main one. In v2, bnxt_reserve_rings() also
grows the vectors when no reservation is needed but bp->total_irqs is
below what the reserved rings need, so the next open recovers instead
of returning early. bnxt_change_msix() also clears irq_tbl[].vector
when it trims, so a stale virq can't be requested again.

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the DCB IEEE
>   ETS path reaches bnxt_check_rings() and bnxt_change_msix() holding...

This race between the DCB path (RTNL only) and PCI error recovery
(netdev lock only) is real as far as I can tell. It predates this
patch, and the grow loop already has it. I'll leave the locking in
bnxt_dcbnl_ieee_setets() to Michael and Pavan rather than mix it into
this regression fix.

v2 follows.

pw-bot: cr
