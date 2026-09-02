Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C532D1907
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332434; cv=none; b=DS7EL6wEE9BiATvgWEoZem0tVsWSYnJVX7iYeeenrsIFKH886jfhxZsQ5UXtCodudai3MaxBTK4nwrseR7zn/dxFbPUZIGTCuVS8Cl6ObluIIYX9tUd50ZJnpgMEzcRw2Gd2u3pHyyO4MXwRCF+xW9QVI2U/dZ8Kb95vJ/B4GbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332434; c=relaxed/simple;
	bh=fER+gMxgMdx84eTSstOteI3BKITvhY58vYW6TD5RMpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTISmmo5dL5ZcbdrctVyt+0anj3lbHXHuMCt1ZlZvEvIH7DorhhJam0Y3J74/Zrw15vYhxh6Nhfatitku6BCYT6YoCPpPZVC4wyH7mZv7xvwyAHgZYvqUWyUUDJeRpQgZPcVkmjpvcg7grXiUMTDoMyz0L8UBqlB0UtEbnB+rko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjAPJRyD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjAPJRyD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6e954afbdso4173655ad.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 00:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788332433; x=1788937233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fER+gMxgMdx84eTSstOteI3BKITvhY58vYW6TD5RMpI=;
        b=AjAPJRyDgHRjtTBNA9l65GsYfuKflDaGRNAYGFaHES0XOxIayMh9OoZuf8X0pvHwjA
         o4mfiqTt527jh9Y0FFQVAEVubDPBQGPAxdju2wNvNQr57NrZtNU+wXVirXFtOeG0JcLR
         OfGAcnI21l+yTgzxGfacScURNlXyzq4cIOyTZGb4BrL4hbGUj05OgICnAGxMIbPvVVJN
         EM60EVVxXNJeWm+tMycj8YIo0m6K1WPTgv30R6BAAt68HzZWSlojUhZqCKMuvH2ZSyZ+
         vkrTvDEQ5ANiB27OZ8gvW49v3fzxdk28t+slNBoPTkphtzUloKZZ2mzzzGLSO5xsxmhR
         dsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332433; x=1788937233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fER+gMxgMdx84eTSstOteI3BKITvhY58vYW6TD5RMpI=;
        b=ZWhQXzlAjZ3E2uLClUfS56NlLidUIZEodlEYgr/3B8EjPdpqtrpgFRW5d3EXDxvIxC
         yRWLeYz34mjCJ0MHQK+3KFoXRzCWBS6kG5LpvR2ATAYVmVbbO/tVbFQXcJMU4R/tOmF8
         wB3r1hyxIzNF/0uoltQ6C1Xb3uiCexYySXpsmJvXNaRLVm60mMD/jbKw15fq8ZC4EEwO
         ZvkA+RIc8gFfQGY2je0DvDgb8nimzu0E+xDRxPXJsmBmbwCajMSEW7LosVE5xNwwAOhE
         w2l/lwZoPxgpXVMhaAK3ofkNx8k/cI8FFTbiLzt2d5uy4/4NkgjzqhTizJjbvD2y8WRy
         Ywjw==
X-Forwarded-Encrypted: i=1; AKwUvBwUGbdhodTfZxWgK9JTHdMLxSho9n+Z5kPKhZ1oF3FLC2n9lFcl6FVp3LOwSCpegHEX9wyMXrg=@vger.kernel.org
X-Gm-Message-State: AFuF++muMl+9PF6LD8YARLwfWELLVMFybi2Cj9I3RXQMkQB2+EQBC+CI
	k8eTBI7EmS1tGcboQeaV2aBAeA90QJuPoutqMFQ49GyItY6CBXEFs4zq
X-Gm-Gg: AR+sD12/ZHsTiu3eUYDoZRZHj9zk6TpQ6xMBa9VcirtFQJElQaETtYh+MlHp+ZJlRuG
	FIQG45aa/0kGFBg/sWjyJzSzOKnrhgdNgA7nfp1710oJwhIIPoztYbvWJsAVnJvlKgY8nZE0deT
	/LUgLdg+sqKsGwWof7lRisMuG8RVV09P6uSycbOjFhTkq95umvsSrDgnvsWetilHNbTRFyuxb6i
	vYs5KZVCwf4ckxI64ZGLCBpsx1bU+QPZS0KFrtwT4r3ZOswjMUOMpVuRrtpqKV8cn45Sb1wHEc/
	b24jCezgsopsQS/tKIH6SyfZqK/4a6GHglCkC40YixgPQcNSZhMEM9Pxj8CNPN6cdl4H/ZAfhmO
	mFLWZxdqFFi7IiUIazcPwej6lxqtEaBuNwgb3kJP0xjSF63ADhv27AhAka5PuBqSBEiMJc5brYv
	u0OgD2jq2nAl4SoCaUSieHTDvQraLXF3aYrTrFjjBOePcjzCFjg2KG1TQcEo+mAzjRrifcLdBkj
	YGuTFZ/qeBt+vZwwkUKtitytM2+Gt8U7tXTnXLWZ7lekX2mv+ug
X-Received: by 2002:a17:903:324c:b0:2da:e553:c70f with SMTP id d9443c01a7336-2daec7bc931mr42090935ad.22.1788332432973;
        Wed, 02 Sep 2026 00:00:32 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd4a7f1fsm8113065ad.63.2026.09.02.00.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:00:32 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Stevens <dlstevens@us.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vxlan: use one headroom snapshot for neighbour replies
Date: Wed,  2 Sep 2026 15:59:12 +0900
Message-ID: <20260902065911.1177698-3-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <53a67f9a-b8a0-4967-b2c6-be4ee3a09735@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review, Paolo.

> if you can observe a splat on the unpatched kernel, please include it,
> otherwise please explain why the issue is not just a theoretical one.

I thought it would make the changelog verbose by putting the evidences of the
bugs (some people like concise changelogs).

If you prefer splats in there, let me add some in v2.

It would be like:

```
/* vxlan_na_create() samples ... */

The race is reproducible on the unpatched kernel. It occurred when
vxlan_na_create() generated a neighbour reply while vxlan_changelink() changed
the link headroom. KASAN caught a four-byte write two bytes beyond a 704-byte
skbuff_small_head allocation.

/* Snapshot the headroom once ... */
```

JFYI, every patch I make is done only after I get real evidence :)

> Also please specify if some LLM has been used.

I used LLM assistance during bug discovery, analysis, etc, but try to review
with my eyes as much as I can.


Plz check the new paragraph of the changelog whether it is ok for v2.

Thanks,
Sanghyun
