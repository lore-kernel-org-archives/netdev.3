Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE594772B3
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033702; cv=pass; b=iP8WrjqtCZP7drmxtfgsC7uiyu2jWe1gayX2nVz4Plzuo0KRTzUNKUJ1FKq61eVit6qlvq7UxNwZcbnpF6DoI2X6jNmDeXAfs+PHaOBAqcSxD9W/RVWt2766s9ANKu2nON5cN2Hah2SWCePPyHJbb/g02PGIGccYstsgPxOfKjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033702; c=relaxed/simple;
	bh=sxVdzkqUKmgN4f+qWxZ2zsOjbna5V29vqf/tedxT+VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch8+e5sliRgrJ0v3DtempDVNNIQ52tpGMz+FqM/CKxtVs/TxbY5/y3bAHWy9zsZf3xXu7xQU88g3vXFyLx6nDq/r/3zurVvmJo5aJYenoaEBJ86EZ3PBb9gtARTEGopt9YLCPTaXINAGgaIn5rLlIF73lynlLpqMYEFMq7/P2UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBJR4xPt; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBJR4xPt"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so4387a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790033696; cv=none;
        d=google.com; s=arc-20260327;
        b=EdGknOCrbs+NOdBmB7V9fmG9RxzLQlPUTR1otWgwaociRgLICLuOQQd99wl2tK2SZQ
         gOYMy7AeKFegWZUol30ytCrq23z10+PKxlXcujchNS6XqQjJVWReunL2asNg3zm4GI/x
         q8POiH/E8cUdNV4Gv/n1WsMl0CllNiADcBTLE2vwRL70JreuPgbC1M51IQ38cIzrxOGt
         aQQIzc9EUz3lK4+SOEltiByP/83Wp5qatORlxfo92oid+pcctpIfL//krLaRiCT8ngdl
         40WUAXjR+DP8CyCdxLuw8kwl1FQE9lu9XeNa917RpDTyQXuapoR2grQc3ijivERC+PAZ
         vhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sxVdzkqUKmgN4f+qWxZ2zsOjbna5V29vqf/tedxT+VA=;
        fh=jvNLtrBCCzuJ8z3sPmd5VEUHlzTO9IU6T5DMEjOkDXI=;
        b=mHymWSQKGEd/iLkzRk1Md1PWz0cBa3U5wLjHTNbb8KN9yr9FGmlYCDIcPsMSJXv+WH
         EOcgTrVbKq5ueeiK1JTt4dSnRoTaiIFZvy3twsWA8xN5xsJzS4HuUiKRX4hUjg43TQ0v
         ko0OWlN79j37MR+BQjvkmX9DZBw/NmI/YBEJY1fYIQO3U8ZFvxepDS+AlXc8hewUmdLQ
         veZ+3lqSkeg+XY+k9kOdVc5N+YtO72FyqRH4fgzZcYVOWSE7UZAB1aH8Bm3NWX6wp/IF
         czbD2eXS6WFjmnfa7HPm70dfE/gK0fZu2/T3wWHyjgs48KqY/yygEdVt9CfYt51kOax3
         F81w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790033696; x=1790638496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sxVdzkqUKmgN4f+qWxZ2zsOjbna5V29vqf/tedxT+VA=;
        b=NBJR4xPt942hts7pvdHW48X3SWxgYnDMwQ4s6BqJGk0h80PC8M5jHLmvxMSkkYtXHA
         6kP6vmVoTUiKPm0eS0TZrl5VN9oc0986EYK9bhKzW5LvW7gcHE3jKS1LY0tmYr4OV8n2
         SVXMjymgBtUgikhK06pYQhVgK3d1sbt6ugQpm2kJH0puMeGP88ry3J0bZKaNJoyYc6U2
         WEkQ3IUMDrOM1bTPMuumkCE+qbSy3/kFPADTc9r8upIwUg8hVlMmwUeBnBcE8A3tbETr
         +waznWlkqY5AT8daALYFk88nosNsAjfgFfAFGC4Q6rE2wvQD7uHaiwDOB0/Oj8dF5Ntl
         x1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790033696; x=1790638496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxVdzkqUKmgN4f+qWxZ2zsOjbna5V29vqf/tedxT+VA=;
        b=g2EYinxytkccDPw9UTLNYj9Gvm/sYjZyPQ4OyxfcNZefRDdErDw8gjbaU/Yjhu1ReH
         +j6bJ81IY/sJ+VQDcYxUZAf4prym7em0LpqW5kmzN7F2cxkzk3or4twZQfq/4PSD6HsW
         HfdJ36UTH06k6M6oDptKT5IeTAVvJWrPXepjjVT7bOxaXH2j5171yldBpgC52IKVm1Hz
         XH4wvX03WFcYYkEoVS4WATKd5iehz/beJuAV0SjtInUpjaB/ErkhzxDjHCwOY/xaiFOH
         kizvVtdAGtUfO3Wmv8yQFM6rMS2jf8kROQzINetxThs/lY4TjOBDDZwgr0cZdvl2uqHK
         KZ8Q==
X-Gm-Message-State: AFuF++lF1dRhx/DVELFdWoxTKnJYkpIiWTx1PtxjQUbBYfpXv9dJbWVX
	E+g3N0frlZEDSErWsT2CtMWaExH1oU3hPx/qU1G607B3CPit+3jq0UVHZENyBGaJSQNs5UBsT0p
	mlf2y3E32hEIeqi2IWo+tQMfxdHrWiGWL1sMxxrn3jYq/Hp87JVGlVZH7
X-Gm-Gg: AYBFou08B0U1/3eRAl1EucnWWz4opkAVE2CQwDFgS1TVoYBEdfcsz8LrqBIZoQRFj4l
	47AQ4OaIs7ySUP0LdDXlYn6IvUQaOoDgI3aFJ6Yldmlq0TUiVISlvjJM2BlVtPYQKpVIcE9ST5n
	4APsZ5OulRpCk2LWzhIzIYwa/DC24sps/pOqNoi3EtATXd5CKYdjBtufqSwM/Y3um61Lq592+Cc
	WqV4JKAQEhZme0/zOTsSX+i8bcX2zYkmZ1ZCjDPRX6s5GDKqxT9UwLtPnVg+Web1GLGNpreeqbx
	V+923rpBXRsnk7x43pKOBRlLDTYVVvyMw5RIlefAAXducyfuJ80/HANPFw==
X-Received: by 2002:a05:6402:b03:b0:6a9:f353:ef65 with SMTP id
 4fb4d7f45d1cf-6aaa3285086mr5729a12.5.1790033695802; Mon, 21 Sep 2026 16:34:55
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917181116.3319017-1-sdf@fomichev.me> <20260917181116.3319017-2-sdf@fomichev.me>
In-Reply-To: <20260917181116.3319017-2-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 21 Sep 2026 16:34:44 -0700
X-Gm-Features: AcwNN1WmRZwcqYEGOUzFgTIvMnbXviLLn9H3D7LnKrfzfpDlcqUx_C5C9_7JhxM
Message-ID: <CAHS8izNfDamSJEgn5D=VGDf0bZG+D_YMrMRmuK51kzV2ZyZC+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: devmem: replace gen_pool with freelist
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	bobbyeshleman@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:11=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> devmem only needs fixed-size net_iov allocations for each dma-buf binding=
.
> The gen_pool tracks the same free set indirectly through DMA addresses,
> which makes devmem depend on the generic allocator even though the users
> are fixed-size net_iov chunks.
>
> Mirror the io_uring zcrx model more closely by keeping a binding-level
> freelist protected by spin_lock_bh(). Use a single net_iov_area owner for
> the binding, populate each net_iov's DMA address while walking the SG
> table, and check at teardown that all net_iovs have returned to the
> freelist.
>
> Validate the DMA-BUF size against the net_iov size up front and derive th=
e
> RX and TX entry count from it, avoiding a separate SG-table pass.
>
> Drop the NET_DEVMEM select of GENERIC_ALLOCATOR now that devmem no longer
> calls gen_pool APIs.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>
