Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CC4E1C81
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009902; cv=none; b=hk6dpN6UICr/aLlVGVt/BObJm4OI9hFZSmx1tbN/RiXtt84JAui6KXienPT1AEqLNZKuzEhdVLgIDK6kI+olVO1Rl4nZIaP+LfVA1Lc0eyn8xi5ea/MJAChJhKy1v2MmFnqj1fkF+l9x0MeImKrZxFRh/mnxOH1slaBborUzkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009902; c=relaxed/simple;
	bh=vvkPoQ8nVYlyhj6hvOOpVTL1JFB04fmY2gsydGw9bHo=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=p0kvGeBYuj0T3DDjOfvHLi3USN6ukQqQiNBKFO5hbYU6e6BAzWHOsn3G8pDFAJ/h3Hicn3hB3UNVz4Orwzuo8mZDslWReV14EsEuCPKJThTxKQGoDT/63BzmKlzPlxlSr139XIWxxPsonJz/wQ1KGsBER0JKwlyZb7IfHKGQLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfuBz/dR; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfuBz/dR"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d561173f9fso28309165ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790009901; x=1790614701; darn=vger.kernel.org;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vvkPoQ8nVYlyhj6hvOOpVTL1JFB04fmY2gsydGw9bHo=;
        b=MfuBz/dRtHgU4a7Mxns7H6Ve4rY16FJb7QYp7JMHg50yyJPidb/AHCRP1lc9QJKMDY
         CDllWeHukuCWEEFKG7CxfahzPzFuwnKo2gUVHcaVpuS4XNo5RPSaqLY+9CuCdrllAYAf
         UG6pBURtp1kY0TyM5WqtibgbLag2jFE9S/JrqtDfqPU6yRbpqpy9ibhnN9qHFairDHlt
         82M5/pIkhxP7WhWkAl776+BJQWJynyxM6xAr89dZBTNL2egzSvCu6eW+VodGPVaDBFdU
         gTLvtLJOqzpzcKhzXBz1104iqjEzOks6Ky22zamlKLLe4j+69B7QxviccG4VxqXSO5RE
         2tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790009901; x=1790614701;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vvkPoQ8nVYlyhj6hvOOpVTL1JFB04fmY2gsydGw9bHo=;
        b=raY4bfWLeVF6nSXMSxYar9YM5uxxUSGhvl2WWlS/v3Xl2JEiGHXVjnJO7YZAMisanL
         Ps9VZBRSPZKgH+SWEpEqil/xoIrSqXfy1whAQ5y7gCXZgKW5XQJBELe4VMpUQEnMogeW
         /njz+oCbnBnbywZnxghRd8QH5RbB9BI/qLWt2JSqyL4u+H8Qe+JNZNWs52dFOKZsR5aH
         4VjDnvUHAhyC+xPuEKk+A5XUkyc+Gx0XnoFTjdJ+k+M0HzUNHyOqCQyK26/8pCoVG8fD
         XKs2TXam4ptM/XNgQVqaje2tl+yfsUNO1CczPY8GoeTRDaOsLFbJNvK77Ef3o8aseLyE
         ydNw==
X-Gm-Message-State: AFuF++m5YE3+vrFhYdv0PGsWxW4BDgokANn7P7ceIh6a/oAPEM3WeohE
	XuizpYrn1GgzN68CoHV1rhTFqxxzyZxtaNN0/YGczEkFydW+JaqrNhSF
X-Gm-Gg: AYBFou0KITnnSWSNcLY/gV53/Y5shvLdj7z7Cv4cxzXwbEwlqXyoQ6NEAnGr2TFwpFo
	MGSKj3VHR9ZGIo+QG6YDG4SBfRqk9mtqfJX21s6kEKkqDPYgcfTxi2ESdnnpnTm8dCn/gFWddJw
	MPrlDuIg3R7feyOoXcWQy63dAEvQzSv0jVx0wPXRaTbxgwb7fXmyR6eYgroSODqCwLYFuAdbyVf
	iMPQF3Tnp1UqbzIWRgG/Na2buJNIYUAhHRDlsRj2VauLvpgsYGB6kPbNQ+R2yanThdYlSv2Wvj5
	PxL/WG5JOKTXu251I5jXjkwmOISwdS5EqKUZUM/1Jf54j7AHyAoTzewRJgCXEhieMP8Yk1pv3t2
	0fVR707Y2Zm9kqAKscfrHW6yL/u2NhTcTHRlmi4c3pA5y653TVQettj3rQsh9q/cFrAKOxJuGw+
	Kr1FJILdj9Q0kQTc7uydIG0ZfPIJBXb+K2eAehYqX0iVFwMf2ocXel/jMK7f052fJjSCqlP99/l
	B8=
X-Received: by 2002:a17:903:2b05:b0:2dd:c100:a5d9 with SMTP id d9443c01a7336-2ddc100a66bmr116546145ad.45.1790009900775;
        Mon, 21 Sep 2026 09:58:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc178701csm37221245ad.13.2026.09.21.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:58:20 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:58:19 -0700
Message-ID: <76355a60e1b7e5d664d956e7a06c5900@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, almasrymina@google.com, linux-kernel@vger.kernel.org
In-Reply-To: <178993807923.2160803.4802601925465816308@kernel.org>
Subject:
 Re:  Re: [PATCH net-next v3 2/3] net: devmem: embed net_iov_area in binding
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> [Severity: Medium]
> Can this loop in net_devmem_bind_dmabuf() write past
> binding->area.niovs[], binding->freelist[] and binding->tx_vec[]?

I do not think this is real. io_uring checks this because I think
area_reg->len is from userspace. For dmabufs, len should be sum(sg->len).

You yourself claim: The in-tree exporters I looked at (udmabuf, dma-heaps,
drm_prime) do build SG tables totalling dmabuf->size...
