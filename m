Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597842;
	b=ZjN1U9kr1b08KVALz/Ii9/lms3mtxsALSwI1hflxX/oIOHz7vnzIo6D3Yep5erkU1guk
	 4r84t3mqPc482cvuMVk19gVt57/+hdsQBgxUkQbChs1OJcxsK8rIPxgOPACqGCYsW/hB5
	 F1KyIBICF9W+XstSF9/B+hx/BNqtixQ/0dGKkxuJXlk6dQOpBWJvp6Dy9IGJi3pLpNQ3T
	 RFm0WpyTRxaiW/meYmWlPYU7QODmrgDy1ZuMk8ve2AP1iVrP/MTuvFOLLf0TOzri/HFVk
	 y3hSQP0diqgHt3zdLd0sa2817ycGrm4XjNEuv9livJKU/tG2soDnY0J/bFo+stJBDFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
	b=H9s0C0uTjdNzKxxnsxtBPpLfhaaWPZTuGP8CrFzUcQRoUobiMTRNepCAQ9ouoAck+ifn
	 NBSOdLPXi2RBjzVXcqt/AqMBa5wxSS4Ue0lm1x3c7j1hL4MYdM693ROOkJnH8x6QI4uaF
	 UVkCldQd7enOQmdsBrHGS/tBlYlM1F4BXI3wowSrredHBMotgh4rhU2kFaq8x7rmsklvF
	 XEi1Nyo1cs7X7fExLNxllXy7MTvaDM/PEAE+AnTmX+EyMMqRN8XpktrNNBnU4htu5fzQa
	 qCL2r1c+VwhxtOVYFNWJ/3VVqDG/8PaAftwOHkQFC8QB83arwkUUHP7THqdgbtN3whQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ChFiZoAA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BE606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D4BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ChFiZoAA
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8623790f8so76465ad.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792597841; cv=none;
        d=google.com; s=arc-20260327;
        b=GkvaLkJTYs+mPDTNVJBGNPF9MjAvgKARZ53iUVWn4/StSjEu2KlrNRPbM1YNzGnUrV
         Q/VABHUxQgmyYfWYxF99c0zWvx8ihEsGgQ0y8K8RfXbSQ1jSmGFNBobx5c7HjvI1jSD/
         V7V55lv5HjMNpafWBx8p6BjcfSlPGLchXNBdoFaUN3w9A4QT8U6vDjKQmzq9KKjf6TKl
         PLebgZmBqDT5eX65rYOPRWn5TGRdi4uJeUKtfdPeEEjxNLrzkjaPgDPzxBdVuEAcX2ki
         A4sCJRiag6QbJD8yTwvkIpxhWKmb23PSuV3RqOCIVhMkqmiUOk4YWYkv9RbF0NSsApQs
         RGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
        fh=a9GoajvukXXS0MBTXaLudknTjdLDXQ54mstiSudE3rg=;
        b=qHNv9zECG4lIU01dKKVhvU9zfKMJEdDJnFIUYBQFop4CbKQXXZ9EiXz5Unig7SQZkC
         rZ5/mCvJ44/AqewaETZOCTXLU/FYGO+p/Gdh/y5MU4QvDVr87buVnnToZScqcmLdu3J+
         dumZ0To270N0EiGXgZZE6UrG2VpHbQU0xpDzMUTd9tW0oUwg/xWqXRgj49Z9g4nhnXAf
         NJ7PHQKjtM8iOo9TI1GDoTJxKcGfrtmyKhwimxJP64daFkiI9KMAVGTdW16EbFpuDY7t
         8VSRnj110wv0uYtk8b5B81hVktBI/3FcjJkCpTFr3C+KmaGJ1k0ZhrZoJ3Uw3W2AXckT
         ajhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792597841; x=1793202641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
        b=ChFiZoAA0ry5sqQt5y5BbsFcUMcVLcT3Yp1BSlmpkN7A8BJ+aZcEPDSQcKXhdbLgDR
         HusH+jsKBWyUVIhmvZLx23sqj7cx25BskULT9q4Ahw3Flwi6MqnnorJ/oxZTDlLTcB/X
         z3765lszDkqRQ5y4vGS+LC+NURkrNpxPNxYdIByRNCOWCj9j4LlsDK7r7NF8ezFWZkva
         63ya16Mt9ADI993SclirtHU6fZceD1i2Y9ekQIcOssqLf5FrLvX5jLV6fTnvNbMTP0HK
         UlWuqg2d20WBXFuMu6N9RAx6awkxvHbj/S1oLyVh77lTm1QeIX6Uzb8p2177ThjyoQZ2
         j2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597841; x=1793202641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IaUjabYBPr4k3c9P8wC/7GmNjrvY1v03i+TToOuLuDI=;
        b=nHxonE/pBRh1Z5olsjioP6mma92/GKmkikpvH5cPTmKbHq4tpGoIu6ch/NP86jJuxG
         ZQGHkWP3sOE30Zh2KnLK9CsxsvFYWvlW1i9ljXskMPNprWpPUI/mb4AdeA7elIwHB37w
         vrskoL773oU26TJS47y2dzyvwThoaj4mIn8xmXkqOrR/oFHjEvRKJePLaQFo6Sbrsbsz
         Zhk6ygRro3xgjx0yCRQM+90TdUPDYVENiK3L4Qzczy/Pchdh1fdKkBUpvvbrpR9j2p8P
         599qNX+j6GuIg31BIfYYlxnY3zYOAZBabWtA8T3C+3GYQREOVKy16GxosIhqnItX0bjK
         AiyA==
X-Forwarded-Encrypted: i=1; AKwUvBzEMb1prjjxZ45h8AJRO1dAybGi/bKquIf+OmBhKYWuPbD6dKlK5+bYI6Sy8YU4dPUR7u01XBg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVKnQ9Ijm7ayqfoNwuvSO4ZjEuM8AAPaoY4o0vAzCecd8wQI9e
	j+ChBocYhkm3fYNOaEOsLuRyctijgHjnAjhiqBZt6n3+O9EPETjHbMZUCUXUhW5ML4ReymjXbFl
	e/bLvP3BbaP34n6iZR3yzV8jBdDt9QcApi/8h/K++
X-Gm-Gg: AYBFou3af5hg6xP+rHtLFcSABxSClD3AkrGfwijcF8JOAhgquprLnxCpGiktkKSdknv
	VS+qEZg/t0RZUKkCEFU+zbYAOlC9rsJI2trLUPCbOcVjXLMSpZ5MmBpOLhpfqOnLYdiZJ2h16ZE
	X2aVkte9/52EucKF/wWXaSXhtgtSgzXwR/eLt3fMwViK3RcpaLBhbG9jRDRpvcqWYVFr/kkry2N
	iFFsWldXqccgwFLiGjTYhzYS/SCznMCoYxWGVbJHGkKdz8txCxoz3THYyUn0YwYp+ajk+mvW8sk
	q75MZK/JiTBWRaWRYVydiSMZE+ydTFpUsU3P+8pK/kr+Slf61aOk2bqJO8YQHB3FmmeC8LbevNy
	pXZ5sJ7EaYBxly3oUIV20RwVpRVf9x0VFN0aiZg==
X-Received: by 2002:a17:902:dacb:b0:2ca:4bb4:4bd with SMTP id
 d9443c01a7336-2ea1ad8e5b6mr11446815ad.5.1792597840207; Wed, 21 Oct 2026
 08:50:40 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210604.2433620-1-lrizzo@google.com> <c599f939-0308-428f-aeaa-fc990446cea1@intel.com>
In-Reply-To: <c599f939-0308-428f-aeaa-fc990446cea1@intel.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 21 Oct 2026 17:50:04 +0200
X-Gm-Features: AclHuK9FmBdcnW_p7t6lt2QnH0JAdG8PU46GyBiVJSlHu7N5H8oC8Cumb4S0jYI
Message-ID: <CAMOZA0LrxfP3zDCutahGqRLuS7ueCppbCT7Oi-h9=xwAAit4sw@mail.gmail.com>
Subject: Re: [PATCH iwl-next v2 0/2] libeth, idpf: use GFP_KERNEL for the
 initial Rx ring fill
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Brian Vazquez <brianvv@google.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 4:57=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Luigi Rizzo <lrizzo@google.com>
> Date: Mon, 19 Oct 2026 21:06:02 +0000
>
> > libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
> > driver fills its Rx rings at open or on queue reconfiguration. That
> > fill runs in process context, right after page_pool_create() and before
> > the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
> > needlessly restrictive there: it can neither reclaim nor compact, while
> > the initial fill can allocate tens of thousands of buffers across all
> > queues.
> >
> > Patch 1 adds libeth_rx_alloc_gfp() taking a gfp_t parameter and turns
> > libeth_rx_alloc() into its GFP_ATOMIC wrapper.
> > Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
> > to GFP_KERNEL.
>
> This is done for simplicity and performance reasons (although I've just
> realized that this helper is fully inline, so it will inline your new
> GFP argument as well).
>
> But could anyone explain me why the initial fill is bad to do with
> GFP_ATOMIC?

It might not be so bad now, but consider something like DMA-PMD
https://lore.kernel.org/all/20261003212241.3432303-1-lrizzo@google.com/
that allocates buffers from larger chunks to reduce IOTLB pressure
and iommu-related costs.

An innocent request for one buffer could cause the pagepool provider
to request a higher order page, which in turn may require some
compaction work and sleeping.

Using GFP_ATOMIC could cause unnecessary allocation failures
if pages are not readily available (and in O(100K) allocations
something could easily go wrong).

FWIW other drivers are not very consistent in their use of flags for
initial allocations, but I think this is more to simplify code reuse
(as you pointed out) than for a real requirement.

cheers
luigi
