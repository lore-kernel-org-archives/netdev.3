Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31544A35
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331853; cv=pass; b=SzpyWQNfNRUFlE4gydzhQSlmBLULB7qGoTpvJNRh2lycNRNCAF4q0STpASetpDMa4IUUMrK+FeEv8Mw11Wy4Mrz+ic81tekql5Cc3Pt2mGRw+fUjNBGz1ToiWR/9g4Nw6DMp88fZJRZjSVzROS8nYv52HafQQx/ZqjOA1pyQG2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331853; c=relaxed/simple;
	bh=QRlXaDt+1eNu4QjqDmUDrBQ10IBvdIZqZrhkJw9QL2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht1raN6cZucdks43jUqPGu+t26UE5WOiu33s4JG3bX1Hny/fQ7g57acX5GST78eSvqkLU13Gc2KlTfSvrVdoU5ruvnLp2vQJISN8igym5VRMMJIPt7eD1+F2ZSpggJbmZSKN4ihmuUeExfEsHaWyHOBegYplIvCQfluuY+8Dkx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5H5xcDU; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5H5xcDU"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2946dc8dbfso361545366b.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 13:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789331850; cv=none;
        d=google.com; s=arc-20260327;
        b=MCExC9JOLrOaX5WAQz/qO2VQhbGiqg5orRUUgQ0zV4y1qgXgqA7ra+MFOv9imMKpHv
         iqDn3tWmTWWSqZBvnLnkQgMVAk+6YaN1JMYP7VsaMGgf+2tpEna+xD7tSo+ulx78eZ/W
         P1QCKMDF1jwePVYJDLu1jEehVD/XfB052p4Q3c7epFOu/mz586ad50bTVnmeofVC9pal
         wWM2sTl20UFjoaKgrSdvxRt0HgXvMuKBDEn0wenIrRLkZVGSgzOc0e2VUJDInTtDE+C/
         /evcbasSlOzEfR3wnXTOso9PBUeJ7F4UbDMFP/tOsNNR9z51+qZ60t9Vh1xMAe2yKll5
         Abww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QRlXaDt+1eNu4QjqDmUDrBQ10IBvdIZqZrhkJw9QL2A=;
        fh=jqdvWKbBF38Hm3o2gD96B0+GMwkjknNRK4EJ5SEWCY8=;
        b=Nl0IQ1ajm3rrtf/zh+xqbWRigYEXeWkU8vdvC3HreOsjQZrT2ycHY86RX7Zz4w4fpJ
         QO6WA35d82WoLcIadk6LFu6aLTK2m1z0fAJKpV8rtLvKu4iDujin0SOdoQLc/EHThkY/
         hgj2uF0VoQ8VLeXeucPvisgLmfKs4xgloyOK5UYCPvwZsYok0Pw1k0L8stqpnUDvWRLI
         YF6NAHQQEYV41PvUBoMP9ym1IOVCZjmbEpES9d1cg+nZ/nTamArIcMXgQPWgmItHUDwz
         OTZ7xHBcVqQu081EL9Zsq0naNK2Se5pQmmqH1LGZFj/CrQSp8fxDIl6AUityFt9nwrss
         EsOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331850; x=1789936650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QRlXaDt+1eNu4QjqDmUDrBQ10IBvdIZqZrhkJw9QL2A=;
        b=m5H5xcDUrwwVasUqj64QJsjFN3s1Arc/cnnAzxNf7//rS/LqvRgSAW/AAR/ntc8/yH
         cnnjRhLtnEMeBmvwd9lPjpboFw2wVTMOEIQzYX7Ed9dbcnZvCrW44ax9hoKsxgBg5DUw
         zf5o2CSJ3qJXx2qVniaXW7w1mY87bJynfMFpPzRyR1VJoKLrIHmja0NyNsEYfVeJZTjR
         uZmNBRj+u9vjjn8njjPyMwsKtFugi5jN5Gzg7tpEdgFzsDEU3Zt3qB9MU7mM3psRCiqX
         uqVPRT74pXYRY78O/SG94h6wuuQgH+PEkmdjEXufjLXANE874AuP8siuTIYjA2h0Uyyi
         89Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331850; x=1789936650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRlXaDt+1eNu4QjqDmUDrBQ10IBvdIZqZrhkJw9QL2A=;
        b=ZWibfk0HEugQXacwHG7PgODCsGHXXuzQpnvP3QCvP0vuVaPFH0XiMXLCFL9TibQOPB
         rcKQVVQix/lYBYXYprgzYDTMv85apuM/sWrzjxmJvbjFafSaDDuiCXxME4/fKBoeUwh/
         u3r+4eaON2tFTCoEJ8N2/kIRrqXWE8/KRAqz03e8Q9aAlxjHr/V3yRp7tTBqx/94nZNo
         OnUdWtUge3zhJjPoYXkRojKWZ9rTFrft65UjAdQgZxNqXfGS6gG1+nHfwo4GEjy79JAb
         JjNqMOhqWOJYl2xqt+wD7LamhkBeJAvkW0ogblH0K7XTdpdkcDpjwxDxbgsuwv9xKmZi
         9L/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzAFvyv21KWnDzY1w+vqXxzZtfkyOS1Q0QWqM+AW4Ep4v3VGep55O0dmK/NTP7CDFnHVMA6Xsc=@vger.kernel.org
X-Gm-Message-State: AFuF++lFVeZkZvOHcIwTwPVoRaJ132JS3Kf9Pbm/Mzayf+4DTybjhRXN
	gPfxPoQbR1shcK0KBVQxz0Q6X8jOp+pu43LDgehlPkNhtL3WjMphKr26PzzCk75M6mqqgmBLKOA
	c1KfWf+ZjzAsrZi1fP1dSRAGN7GG7Pw==
X-Gm-Gg: AYBFou2Yvh3qd8NCmbw01ZTRtjRHOqCVF0Xn+t95CRtT7Xhl0sO8wJaJmlrzb8Sicds
	sIwFOZZF3swxnJp32p03YLuraXO4WXUjZ2ySiZjqtCIJD0saJ0e3xCEf22fP5USu62umlnnPC1N
	C9DT0/uwgawbGZl/BuTT6iYZ+O6RMJLB0fZOS9VPqtLAyhqAdhTLyBeldtMD4xf/LqqawwxW+Fz
	M7g0igUzahDpspwIl/FlSLak3nu5FsBbFu5MEghhVN53VFanP0D99ZKdJUZLKSSJwuIVk5f+6Zf
	vDh/VmaQJcv/7ChlLvUABQQEeIlrTADPJ18yYoUhlNazM/7LWhHkyS66yd1tTIiL1iXxbjhsb0v
	a9t5XLx2DfXYffajEAdHf7kYnLPt4VQDSUzWDBLUSir/btVG8VXb5G9gxMD+JBSxl7A==
X-Received: by 2002:a17:907:9288:b0:c29:583a:c291 with SMTP id
 a640c23a62f3a-c29665dc5e1mr700951366b.21.1789331849719; Sun, 13 Sep 2026
 13:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731161740.44955-1-mhun512@gmail.com> <20260910231400.31919-1-mhun512@gmail.com>
 <20260913143218.GJ48209@horms.kernel.org>
In-Reply-To: <20260913143218.GJ48209@horms.kernel.org>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 13 Sep 2026 16:37:17 -0400
X-Gm-Features: AcwNN1WyHHF9rKOVVRVH7Q63v4FKYTOEzfxobu1blNdd3woeEdHWTYWSY1gACZQ
Message-ID: <CAGEsz8EWyKiZAiEK+D1O2HA6Y_K3AAmebmG+O0UStvwXf0SQ_A@mail.gmail.com>
Subject: Re: [PATCH v2] net: 8390: pcnet_cs: release PCMCIA window on
 setup_shmem_window() error
To: Simon Horman <horms@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. I'll drop the Fixes and stable Cc tags in v3.

2026=EB=85=84 9=EC=9B=94 13=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 10:32, =
Simon Horman <horms@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Sep 10, 2026 at 07:14:00PM -0400, Myeonghun Pak wrote:
> > setup_shmem_window() acquires a PCMCIA memory window using
> > pcmcia_request_window(). If pcmcia_map_mem_page() or the subsequent
> > ioremap() fails, the function returns without releasing the requested
> > window.
> >
> > pcnet_config() treats shared-memory setup failure as non-fatal and fall=
s
> > back to setup_dma_config(). Probe can therefore continue while socket
> > window 3 and its reserved iomem range remain unnecessarily held for the
> > rest of the bound lifetime of the device. pcmcia_disable_device()
> > eventually releases the window during teardown.
> >
> > Route error paths after a successful request through a new release labe=
l
> > that calls pcmcia_release_window(). Fold the existing buffer-verificati=
on
> > cleanup into the same path, keeping iounmap() before the window release
> > when a mapping exists. Leave the request failure path unchanged.
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
>
> As pointed out by the AI-Generated review of this patch at
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910231400.31919-=
1-mhun512%40gmail.com
> This patch seems to be more of a cleanup than a bug fix - as noted above =
in
> the patch description, the resources are eventually released anyway.
>
> So I wonder if the Fixes and CC to stable should be dropped.
>
> > Assisted-by: OpenAI:GPT-5.6
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Clarify that the window remains reserved only until device teardown.
> > - Make the DMA fallback and continued probe description conditional.
> > - Avoid claiming that every request failure leaves no resource held.
> > - Restore the surrounding indentation for the new goto statements.
> >
> > Link: https://lore.kernel.org/netdev/20260731161740.44955-1-mhun512@gma=
il.com/
>
> The process nit above notwithstanding, this patch looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
