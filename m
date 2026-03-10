Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F82857F1
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104180; cv=none; b=c/RJOM2nOEAdg9/XRN0lB86dayBktACAxeHRWlR7fNnBy+DGQhgreM6IqBZYZDNcjdtXXA2QkkoIzq+rbvhlsp6TE5JHmVRqHAg9K03QekJKts0Q/I+ttAOmzw3MiempZMAa+7aSuZhOgpp1jWgVNbH8/+cmSRSbQm/+F0Z2UVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104180; c=relaxed/simple;
	bh=s92oNkNafdfctXObvGE8NO7WzoqZ9IG1GiDPjJn/QNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeaIlGUTpF+lJgK7/PR5765kstiEiOeJey7xMUWI+kcdT0DMwQB+vWZXrteyCU8fZ7XWGH8GOY0tAUO8K6qEuOQLu4FbNzf6YL2Kwti5pr+zChWq5mNciwhXayTPge6hfdTPF/R0f/i34YdMci2bRHaTR9vUwgytCf52n5xKWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=niT0J8ON; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="niT0J8ON"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3598c008455so5277444a91.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773104177; x=1773708977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJEBP0vpmZGuD2IAuFkbf5IyeDyevKXoGpCUDihNGFI=;
        b=niT0J8ONWOM5X9QsHidoXN6qlgqpVY14B/BCbo4RSGfsOGflrQRKWu8Olq28x0IvdT
         vb6e6AbAcmr9Y3XjELLTlMTjJk2B7bHS2+qIyEwWeyyGX7UB0O/g1vw/e8XBw7PplaQX
         XU7Ofi+gLC0KeNs10PTDAofpxtTkGdKL+Gbg5D1eGTLJivHJcnreKfsVLTTyyBaudfUs
         4hkTghxjC95RZJQ712bRilDjqcADxLq3X3DCCdKcaipMrgRAaMZUcBPOi3pSurBNZmZR
         /Tk0nPLnnzAtM3GYkKZtXcLNI21WRVnGeXqv17t37G3TtNKtreJPXBiISWpcAXEbJvSY
         ZLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104177; x=1773708977;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJEBP0vpmZGuD2IAuFkbf5IyeDyevKXoGpCUDihNGFI=;
        b=GT3ExPE+O46PLqCQVulqGnnudI9/tYZ9HwungZcUPEgJvhF0Nbn6i7fyya42cbLdSm
         IDhWqJwgoeYhq+PimUFCq83JeTWfDuVwVhbhQUzQHpHLIPCwKopTRJnBSoZd4/E/PL8t
         Su6Fx0aPuJR7Umhj/lTk1kspYXMTZ5JcD3FvEdV3gC6Fx0RtOXgdOTDgnpyJJBzpvJhv
         mzBeah4q1T18UcPDQwgCm3IbPzlE/vg95RhUgsoq3mMBQDyC1BpLns9PjDj6IK2YcKgB
         fgZUveOwbZh74ZxmEddmSjF7Adw69eLW6zNMip8OMOHoXkpTRY6NJunKEZOwLBgxnGoL
         dh7w==
X-Forwarded-Encrypted: i=1; AJvYcCVCvezUazT2uEpeLpcC+XuqtH3dT3mLBt8+irJxejMl4WLU5cRE+je4C8vNkS0R3TnoRx4ygAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2KG/Dldt6Ba6QQK8JA25OX0Iy7wE+rqIysMXwh8DzDsno+yQ
	9pK7j9BjTvLa4icC0R080NdXGLq3Oyf2rIxJvNZREr/Jr/WOH5drmoH8NzHrbAhQ50U=
X-Gm-Gg: ATEYQzxWGPuwY2u+3mRk1Ff+tvvSlM5rlNu0sKV52N3ItjWyMYn9c4Jj8y9yCRGQ5TX
	mGUA6oEtWtSodSiyp3GQmCT7DooU6iHofs6WwfW+n7bVAwjc4yLzgCoWqoBcxIPhKQ7SExTq8Z8
	CnFr4/xn6ex3BxceI68q6VPTtF+xW+nlqaTyOmMVPAjTfmuJSmdqPBGksA3t43qUvMTHtlngKvx
	gn2r1vddVAZR0V6m630tQfiVd3zfzdUXU2Ddsy4giqblXEAkkdYBIYne6Cc/CMXG16j3j4BpQeN
	KbsFJ6KBccI/isZRRv9x7Y+2EMMT0qm65RevCNoUTvb8YusKtL13uB30oe21D7pKtt/4et6cIqU
	Dtt1RjdS/41Z13TFOSL6xxf8OQGLFcdbP+zE8M1v2PkW3ZBhI5GPXhYm/XnjOAl5eNPHkzjqVoq
	B+
X-Received: by 2002:a17:90b:2792:b0:359:7eb:d91d with SMTP id 98e67ed59e1d1-359be3861e3mr11145247a91.26.1773104177009;
        Mon, 09 Mar 2026 17:56:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbac3c0asm4844336a91.0.2026.03.09.17.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:56:16 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:56:15 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] bnxt_en: Implement XDP RSS hash metadata
 extraction
Message-ID: <aa9sL/L3J4LVbybw@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-3-carges@cloudflare.com>

On Fri, Mar 06, 2026 at 05:00:17PM -0600, Chris J Arges wrote:
> Add support for extracting RSS hash values and hash types from hardware
> completion descriptors in XDP programs for bnxt_en.
> 
> Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
> addition add ITYPE_ICMP flag for identifying ICMP completions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
>  4 files changed, 57 insertions(+)

Looks unchanged from the v2, so:

Reviewed-by: Joe Damato <joe@dama.to>
