Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384004;
	b=v7FDlumEEWYcpib7dWnFX8cReoGjhtW5FVsD5Vxi5+thTExpSFi3uIuxvfNkDmUPCNEN
	 V5MtnByAzwcL+ZwFmAhuX83YSLw28w3g+d/Qaela7vYkUUN+s3m32g82PewmImsIjLknL
	 TeUKnc23ewnGbuouram4gi4rcDvjx5slbtq3V4P/5+BcSA+MYQn8f1rXEWcLPmL6v1UDb
	 bvDpL/ixUAYmL4blj7qIli+K4oCGz9P82Yll0gBJtxjP+wQOXKaSB+qiaxIRcK1ez6+pM
	 VSNTCM7IKfPX7JMvBRBw4En0b8qgCjWZ+qZ7cj6k1DViuVGjY4kTwkEjCl2XZ4YTFXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fMT+So78QSqhuFKeOQlwYV6UaMLr+CNOGb0u2W5xmj4=;
	b=3cLqx5ypgcgV/TEobeKEQoFzYPe53QMYSwYR2FXS7iWpRg4gNWArxXXMq5Ksh+Vw3XEd
	 Xj7/WphOwEBVS3DmkfOEVdqzxc1lF1bFeREna+fXkm+NrwEdEsQM5VRa3chFNzzGpYxyO
	 wZLNgMKKnDc4pT7n2Ys1UMvdMdRuRT0DvRkA4zcPT5KbAAI5ztYdv73htKpqy9+PYjt65
	 CyAYS4Fudoz5h/ykFl7N3KnyHd8UMZ7lufLdhM5PDtc9kA7fPOIhS+c76h2wtBQDKV+Fg
	 e0HW/N4wNRU/DBmA0SST2pv74TXcfD9fHsXBgPTJonjLW21JVQGC/1CK3urnXIYwSmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OaE3o8Rj;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB23606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 18:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB23606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OaE3o8Rj
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c5358fc28so814632f8f.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793384002; x=1793988802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMT+So78QSqhuFKeOQlwYV6UaMLr+CNOGb0u2W5xmj4=;
        b=OaE3o8RjEVR2zR75eyJC/w/NzOyHFo4/aqxLVy1sTOOTix0v/XRAORx0DvEXQvizgM
         GxTHgDQzNXs28wuRg2tAdlgO4YFbkHs6wSwH1KlAI1xNAwZo7o36zCP4KnM/j5WijmTP
         6Z15Z66ioDDzwi2MWRBKgTvweh+T2EYu4iDu55xkzRjld6HL856ZF+LbbQ9JjGnc7D0K
         JZTexRxXbc+zHP469suaQUi5EcUd9aKst1j3ayVsyPLEsWdcsXAA52P3SDchoTerpujp
         tppw+c0l0zQtKg9qiNVqXGoa3LIBe7VYE1HtlFeUKh5x4PNnZtS9WWdSHSvahFqtzjhJ
         zRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793384002; x=1793988802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMT+So78QSqhuFKeOQlwYV6UaMLr+CNOGb0u2W5xmj4=;
        b=Lcfyl+q+jkFEYpQOvgucNnpW16rmsj/ihJZ3MVOKqtPY2cbi6ffauLUcGbS0tWgP6S
         jYSNoUXDlzROXL2eJQ363qNbBglY40hNzv/EF//1LLjofnS55jDA+0BRQ3cfetGeQcn1
         mumUAsl08hVmeAf/ZMmYj83VrfduEoM3ZXRTXZ0N2IKuXzej5HCa3vERPKfY6g/5zQvK
         Sv3BeyHnoVYvtP/Hs9hj5R8NvvzXXNqwJgvyLBrfunkKra24j7RgxTIAoLw10bEaVcHp
         38xmfDV4HF1J8kJuccIW9VUhqRnvutBiBkSu0tuKq7lpHfpxe5pVB+vx2Z25a2KA2bMN
         I4oA==
X-Forwarded-Encrypted: i=1; AKwUvBw+++ZKZqvDHguwlKIZsl6cJA8Cyk6CqLTKSnqmoOLTEQ2IzSP9ljlfqr31PJjv/P18IidQG8Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdxTBu4bqh5emyURSadR+WAgABjfaBYcKnavqHZTxXg3VQTihj
	GarcjaPbqAvySx3N5Cm/tcANIN6gRTJbifwBu1Un6QpuGNqfcB8+efG1
X-Gm-Gg: AYBFou3Ob+OhDGjhLCgeVkPlxv3navAqW2UzZGg4X62Y6qEQoaKNTfOl38JmjdrHRDC
	Xowz6a61BnnCt59cVnIndot2SfwbTT4bZJRDt+h55UuAmeiVfS6kYjZ27cM+wWO7jutO/1/E0AD
	gXX1zkAayfd9E968xF1r7YYOIh4Qae+ZMheH4vB09K2QDmycpxTVRcJ5T2CxNPBMP63zKm+BjQ8
	0oSR3saT3i557xojNIWWhDTAykt8WKZS5Kze08OK9zxPFJt8zs57Oy/Kut3zFhZKGwSQkRbtFDf
	KS8DolbJ4QpL+ezQQ6/wg7oUM+mYYj7fAdlsPX+0yOnx7ArUCukchTPcpAyPcQALJbiH15Uz/kB
	88YegYXY41iW4YVTpBC7tgpZOp70kbOVVGnxSWa0dVefl5t01zvZNUfJhiM8tfuO1DkrSD1uYgQ
	oARMr4WmHXSFIh0UhF8cVIwXToQ0334YLR76is3Rou/RQrGbD4bijj83OvGheDr3jNohaPqrsYC
	i6m3AIgAqR26Ss6La2bIy9ECED0nwUdfgXRJ+YIMznRvOujk91F/DQ0HeAi6H4CJtPbyYc1Abix
	Npk9IAdjUeJcoxRWnn4MojjM2eBc2pWBXGsEOma3xmSHE3yWUtJlViNzNYtM67N6Jw0/Kpl7omW
	zDg/xXO48yAENNpBsWo9GX2GA/eBq56yrUdYggehzEck4/VojgjW8KUXH1nKK
X-Received: by 2002:a05:6000:1449:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-48e6e2ef786mr7095121f8f.23.1793384002277;
        Fri, 30 Oct 2026 11:13:22 -0700 (PDT)
Received: from SD.cable.virginm.net (cpc117822-heme13-2-0-cust760.9-1.cable.virginm.net. [81.111.210.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c0b6sm4198221f8f.41.2026.10.30.11.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:13:21 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: dtatulea@nvidia.com
Cc: andrew+netdev@lunn.ch,
	cjubran@nvidia.com,
	cratiu@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	erezsh@mellanox.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	prathameshdeshpande7@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	valex@mellanox.com
Subject: Re: [PATCH net] net/mlx5: IPOIB, Fix QPN lookup race
Date: Fri, 30 Oct 2026 18:12:52 +0000
Message-ID: <20261030181309.9266-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ade46454-e575-43e4-85aa-eeb5ad79408a@nvidia.com>
References: <ade46454-e575-43e4-85aa-eeb5ad79408a@nvidia.com>
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

On Fri, 30 Oct 2026 12:18:59 +0100, Dragos Tatulea wrote:
> I don't think that all these cases can happen. But I can see how a
> CQE completion on the parent can read a pointer from the hash
> bucket that just got deleted.
>
> Please improve the commit message.

Thanks for reviewing. I will narrow the commit message to the parent CQE
lookup racing with hash-entry removal.

> Holding the spinlock in the datapath is not a good idea. AFAIU
> using hlist RCU variants will be enough.

I will switch to RCU hlist operations with deferred freeing and send v2
after validation.
