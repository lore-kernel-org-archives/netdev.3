Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA73FADE9
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511003; cv=none; b=BoGXYf/06fhMoTlJREkR5E40Jmiag+DU9DDIDi4GU4EuBH/c8rVuQ/vFBL/gPXohdv2S7zQscaE+xFE4/PrS6JyYvuRoaNwxKaUqxMgj1Ef1pra6jj5Kw0npMqHXeCtt9CUVsfJbkQfvdjay1vGxMSQPIVg8VMiLkoDYp4W81CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511003; c=relaxed/simple;
	bh=suoZL76nt2ElPZlpcTw5iNlihmCB/QTIZAIkZE01Xs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dmk2dNXTi9Lar+zl+KsLYyFjTSLOEsUf3fMVQJrfDw+WwDRwB0sLpVAm8qC9OHrHtM6ZScqi38D5XIavr5z4pbNAgabTMZ3gqdfbaspoUtfnv3umsJJnCgh8GykGfT6kgDZSJqxMBpivqwqPDVhoKXOkP3r90299S3NFKjJv67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMJLA5Jl; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMJLA5Jl"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c19d23b19so7295358c88.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511001; x=1779115801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suoZL76nt2ElPZlpcTw5iNlihmCB/QTIZAIkZE01Xs4=;
        b=cMJLA5JlH0bz9xg7JsJZ7ZGfu6XKhOVxjc3olxOgC23s8aN+QzrhSyNjq85q9Z/5GB
         gja0h2LwUKLNAP4dDXyiTEnD1P/ug5TexMZHIdpCBZnmiEqxW2hGzWf4mTpTO/7lLT4N
         YiSvi+x3kQdS/jc+T0o+R5tkhKrVvo2eXkB8PSn4/LCBBDgDivjWjsEb0C716tuiwUDu
         qPyOam2QJjRvNt9TRZ2JxeYcFSaJ2wNw7cT3SWBVh4hE4Kl/mZlirBPS8aGkTrwkBEnu
         hFM+gFHc1ECpq8pS4zSJJrACEDHBqtoJkxD8Xa81Iv6SmDzI1L7VWuWnb4ZRpp17fYxw
         iLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511001; x=1779115801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=suoZL76nt2ElPZlpcTw5iNlihmCB/QTIZAIkZE01Xs4=;
        b=KzBHlZayoD0Y4Yw9fWOiJ1lLH1AWT0SDNyVcPky//nz4PM00tb/IVLuoLnaMh1nDBU
         X3yRd4VEdda7BRM/q6/8RIUp0AyERHATdNc7s7dK1FlMi1v+nfjHX4EE1FaGXkfrPMIx
         StzMb1vnh4hseDZjAiVwHISeTmRQbPqtRjQtWp6AaEB9ukMJikdwpHXxSib8Q2ybjZYt
         DzCMX0x8prfmMOPvfFobLwwa46RdY4Pt++KxCFPehrw6A0jtSFahjsP7Z2QioNvIRGYg
         ky7lJrJsrAXGkM+Zsn9hsfSoASzoWDzT98xxTQrxQDcinGhMjsYh0+ej4IvQXrLHf9I+
         EDDA==
X-Forwarded-Encrypted: i=1; AFNElJ/VIgkED9CxN9IFCYZ3/QbsSE0N7Z8gMMBCsP0cG1fkF/5ao6OgkCmBBLyHy4wDS9+bKxLpVbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQTY5Qz8bv26hOGia8NjEFsaP5dpV75DjYkZoVQpu/m4aFN/p
	E67JW/GSF+WgkR5U6jj9MaXq+wsJ+bR/wQKxYIAHIgxP/LDHqNKmgbiu
X-Gm-Gg: Acq92OGNfqA55gytqTmjb7AbiDS1+zMSVCGQYf9ZFhbJ1hQQ/R/HUzdXy2wFtsyQEZ6
	D2Vt4inIA9e8fD+GMSz28CtGWUlF+pcNc2fEQK4S5vABlNXOJTrTAwUJd9PWszmRlNNCAxlnxZZ
	JKs45nKDuDSjALACMvuI1+2HVNJojfpUjGfodUTsrOzzCh7TNE4qtCU6un9EUETvehGBs+/K1j0
	hHvYuOazfJv51pngAU6DL7pgg/CG+g6MMleK25AO8mC6BbeaYSFnCY0H8EfpqSmd3T9UCDmewq0
	H1NrDw1IIEFvUfyW8QQpJWqphY1TL9OZ5c9DXDxadpX++R/n4rdF/kOuGNwSaYHt2U1KUdyEbRM
	s8+IjkRPTLuYVzXpyCzS3nXvffX1kv6OkX4t+4UyOVI59YbarGf86wG6blcb1+Vj65luf1owuNK
	yCsX7NfAnJkz5P4g4FmWWa920itQ7TaOXa9n0=
X-Received: by 2002:a05:701b:2302:b0:132:f27:5302 with SMTP id a92af1059eb24-1320f27548bmr5896809c88.3.1778511001184;
        Mon, 11 May 2026 07:50:01 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm20487727c88.2.2026.05.11.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:50:00 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: sd@queasysnail.net
Cc: albinwyang@tencent.com,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hannes@stressinduktion.org,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shenyangyang4@huawei.com
Subject: Re: [PATCH net v3 1/3] macsec: introduce dedicated workqueue for SA crypto cleanup
Date: Mon, 11 May 2026 22:49:58 +0800
Message-ID: <20260511144958.2630644-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <agHpk_g6rC194Q2I@krikkit>
References: <agHpk_g6rC194Q2I@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 11 May 2026, Sabrina Dubroca wrote:
> > In hindsight, there is no actual ordering dependency between SA
> > cleanups, so a normal workqueue is sufficient here. Should I send
> > a v4 with that switched to alloc_workqueue()?
>
> It probably doesn't matter a lot, but since your cover letter
> mentions "unnecessary latency", switching to a regular workqueue
> would help avoid giving the wrong impression that the ordered
> variant is needed.
>
> Either way, the patch looks ok to me
>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Great, I'll switch to alloc_workqueue() in v4. Thanks a lot for
the review and the Reviewed-by!

Thanks,
Jinliang
