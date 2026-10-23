Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790190;
	b=obDgK/0mAen5rQLOYXJGqJ5GMPYnGGYcZgin5Eyu5U5rVWkikN6bjfXzBnewD21h6y5S
	 fPaUeLe6bIVUOhL19PTcfijFLR9BrXWs3M0SlcBESXNpRY8pK+4ccUmvgaFZGU69zL/l+
	 Czdt+A/6LKgErxK93vvsdZxchSsRbuy/mYFLrkx2GuhedasFtgiZuJ4aP2a7561ewM7d4
	 RayWQXtLGiU0eAgjsUadeFTLk45XZ9WiaJLE7Lxiv2MY9f6I+eT5faRPBW4YExII2s6UX
	 vMmsYkpX0mXYlxr0go+ZpkJ2Ujde8JNLW8yHqfeHjGdpKpXL/+awTrnL8XlPuXkI7cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2hVrmr+tVN2+9s8NA71E64tKNtJD7F9d8423pbx0gSs=;
	b=N+3VTdOSh5oFRSPrb3yhXr4fPQ4eCglC0k6aQoCyTPr/uCn3ryHWBcrm4rYwlpniE7HW
	 SyRyU8gvbZo7A2xV9bC23Rlsp85FfX3+LkjNH9Y4LDi5dofV9Ni1oZK1BI+xIOr6fO7J+
	 i+nulUBQxtt3/ZYkRim0D5duU68k1DcMhCmWaoUNhnnTh9JjH0TgMsxRLuIycqDf4+NCN
	 Vi/iX8orthgL5OLIsGkiE8bP7EFRhL3i9Nyjy317oeGQvftlKlrfuMGZyynK+QCdCOVSO
	 OOpMhl+gb4b7AlHjMi5hJsHzij3XhDAB7A3UPEMpW5xRZylenEbnjJ08plRp/Kblzew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="O/tcXLHY";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9119606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 21:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9119606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O/tcXLHY
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c40e30c26a4so347291766b.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790188; x=1793394988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hVrmr+tVN2+9s8NA71E64tKNtJD7F9d8423pbx0gSs=;
        b=O/tcXLHY7JnkcVy5r8FnkWRrc+hQP5Pier90GnvG22td4gmldPnp71zwLr/QujeH57
         mYRaw/W15VJzisFNjsaJl6crIRgMKPMbdUZDBF3zLjb38Vc3KVs2hbGLL2Dky45SS+uI
         8Qu0WriHKlmLtbt0zS2NpGXjOd/4ZWj0SXGGGoBMLW9193a7Ij+q1HedgRVcjjKhRYsD
         rtbKR5P38ZrmTgTgQTEjX0AuRQIa/5EKgPVDn2OocmF+9v+dwjLkYmlgicaE4nR09Izi
         YuVNTuHwiLbIOMHfluZqm3toalU9Yox33BqLLAtwFHuyw0WhXtcSG4f4DFkQh3eV/DOR
         n5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790188; x=1793394988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hVrmr+tVN2+9s8NA71E64tKNtJD7F9d8423pbx0gSs=;
        b=UscmlPMnXN7hJ7cp0XRcN5Uqy64e67HIBQ603bnXuMcQUFNs/9CL4MfrFSoGukhEez
         ky9e0sfF2PjDQAmEegB2KJ7EDpjlVuRSD6C+H5JuVmcehsaur3GOE+b3HOoFG9jjby5W
         vskikSS8M0Jkv57BqnARbpALrf1V1OZJOMIitz4B2zPx4EES7QdlnFKyphXDL06OWW3U
         uIJxZuqgGgIMAeRaN73NuF+mO9unxEEoxbYYBE38qkNN7t1TaclFymkoj96sZjH+boXD
         r/1yBE7bDJ6K4VXI/zCeCEJO6wsQytN4yS1treeE/7otmkzM/Ooc5TjFsLuEkaPnN2wk
         PaCg==
X-Forwarded-Encrypted: i=1; AKwUvBw+8QUABlImC846DZ5PrHk3p7QBxZ3FaoZLw/HN5jVjeY4OEHyps72yoh/VowGMIUXVEGgPsxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhgLLg7MermdEcjMxfOW393edB1Q84eipOBeqYcqzZax2r2Aos
	V/bZV8MvcHKl9XVEyFRSkUiGR0a9dTIKNXbP2IP5KomH8/aGoAPOfnKt
X-Gm-Gg: AYBFou3+H7y31ShXmkHcM7I6DlkKqox3CiCS+h1Oo4qF7cPnBO8c17RZAfP3O6m/P3d
	ONa5CXtR2SR6jPNjJdlq9N/YUcTYm5xfeTP/VcZhmKCAvOZaE+4aZIesWTzmLTcmhOWH8qFU94b
	nKhJc10k4K/VUZZTHgtRuvOAx7vT0vlkf+J/JwIcYBq/NZmXhRNe7yUK00URklLk7j5FVORXuxN
	pPXWQQbzsiQnSiuthVkf9PcGPh1/HxDbfRpi/Zcj4Wv37kt8Jzx8+Mddv5pxS7hFzvFX6Fqzj1q
	kPCvocixik4eg4N2pptqBpLKtCD2uWETPodQ0cYzC7FJd+W3pPta2KZ+16GP4U/ULG0G2z8n6Hj
	9kCtJTljRpuR0yeXT8QzTLSgoGs1TLUCBrbPw0nbo5zWp7uGiaHBHngDLJeXc8BoFgsqomqMx/0
	GZEeAbHC44HeYz9PT/hBZsMX5MNEvBfxqh5uFb7N6SNxVUiDiF6v1F7B/oYkhoJkTh/8o2hLt2R
	ZapjqSoLIJEg3WwttnETaDQQGXqTDzqB1QMUOrViJAknBWRQMhVD3nbT24c
X-Received: by 2002:a17:907:6088:b0:c41:4512:a3b4 with SMTP id a640c23a62f3a-c46bdc5a48fmr13765666b.20.1792790188063;
        Fri, 23 Oct 2026 14:16:28 -0700 (PDT)
Received: from Mac ([188.163.8.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd529b3csm7920066b.37.2026.10.23.14.16.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 14:16:27 -0700 (PDT)
From: pasichdev <apasichnik9@gmail.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] wireguard: peer: free packets left on the per-peer queues on removal
Date: Sat, 24 Oct 2026 00:16:26 +0300
Message-ID: <20261023211626.99784-1-apasichnik9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003201625.4572-1-apasichnik9@gmail.com>
References: <20261003201625.4572-1-apasichnik9@gmail.com>
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

From: Andrii Pasichnyk <apasichnik9@gmail.com>

Hi Jason,

Gentle ping on this one. Patchwork shows it as awaiting upstream, so I
assume it should go through your tree. It still applies to net and
net-next unchanged; if you would rather have it taken through net
directly, or want anything changed, please let me know.

Thanks,
Andrii
