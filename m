Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7C2D0C62
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075126; cv=none; b=R58rCbgK96yoOhE2sDGZhfzg0B1TXjnL8dh+pdDx2CB0O92rVeQmKgu6Pmd+Oe2tWjl6aGVAJsdGk3cRL8ZIznrnQ0fC9zUoT0cNJOlNzNZE8/OeQUwHNMfmJhG/NXtv7syxoSKQn9OF1jPYQdKPsKqqR3CRQSSKovJ49zib7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075126; c=relaxed/simple;
	bh=xMt4CizzKgXzMObevKrlpDXfIZyZ5Y2qf3JseBuFDUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV5BnI2/CzHa677LYj5bDm2Pnsfqifm05K5kjRtT45zK7/+QYXok50khmziwc3zHe1EdqeHJ0DZPZmrQU1eP8fwBqRStjQ1TUokoSYTSYL6t95iJVKhHEq2BmNnMDJ621ERMFezQc/fohbJofdDl7CDVmnL9+JgZ9qy7k+H2Onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuOtH5LW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuOtH5LW"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89d4030cc57so1235165b3a.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075125; x=1792679925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ycblgGXLdUgSZ+lPqRwK58e5xvUphb7pOA34UYLh9Dc=;
        b=EuOtH5LWaGa8cvqxW7XhgAWLeschJ5ORB4Gk12sgW9PMFacW6jNFhwzh5q8RFKSYpP
         vqZbJXMydPP022IsQakaaTjQDWyOzg5HaSfq/ZXl/37p9ObIAATaFDg11h1LByk4gSsx
         KuzxSeLFd1w2Kv+iGQdCBJ0q3mGIonUOTDYq3FmBs2rp9U0IVv0x6R4wAVgUOUnDkqNZ
         xq2XxwAFNTEwjVhnIPECWXCJ2aHRpwDULcyk2NRk0K+5Mi3Ws2Kh1/PF3AmE9ox4GG6G
         hlvdCKNlYsxNiTprHLKILbK2k+avOdQB5eFhgbYprTjSDLga7NK9hFsJvI8t4xWKvr0Q
         JebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075125; x=1792679925;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycblgGXLdUgSZ+lPqRwK58e5xvUphb7pOA34UYLh9Dc=;
        b=JHkfW4LPzxX1x9hTgeRVrqPk3y/c6unrcB8RmO63ipGrlMAhuVrRjEKPj0rhQUWf0N
         3B2knGqnlDRl3TBVmMa2lAM/ml54LdaYj1f4g5zi0CMrHnDza7ySbeHMNzr7y2rkV54p
         l+m2Ys8FKZ/UYKviyV7WUVMKikM0MlkoIeH+6sbqvDctDKyNzgSaKRoBONcIaiazvgfX
         rgkYTBlvru+bsbl6OTlIP5TpdYmJ/YksuaVl2N963XdEFtxaiWYqdrSo+FMsBSnCPhZO
         hwV2HAm12J5cr6bjLSR3y2r+0TgUcmIWUQGdSMrU6pN291egaZgZz/5JSP5hfpPrETFu
         /tyA==
X-Forwarded-Encrypted: i=1; AKwUvBy1c+Z53lpP1s9nGi9fs/ANINi8i9XoHtJMvt1XCSqhTozQO56POVChSz/XHRmzfT/Npwcgiz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDowUH+GJJOa8qL3lo3PeYlraMgqLQoDD5gwidTpEzvt7opsq+
	EdSoIzAzJgUcDSZzcCNiJf4SicJGhsksLvYpOtZA1IKOXkroSFgzkKGB
X-Gm-Gg: AYBFou2xbfPBdn1/iwLNAFe8l1KfpKI2w9DQx83Crbq1btjLI3y0wQodtVxlv+sPvAo
	v/DHsVTnlDu4qswQKRBKcIWB0oNH5AkimhsBVr52sP9BUG4d+yo5MECpqTLYC0Vil8/oCfWwQIz
	5g/7hAMWFyDrDeyLPdWtC1aaSq4CYGhTpeof9bgAKCOXVmB5YnLnhWANRh/EChWnkYr2R43Wfkc
	PoJ9cQS+MEo0fhxDsiVhLLAcnFRzk3A58FZmP1bxv/FxMs103WRC9IEZIPESgl8Z4JScwf2+ZBr
	gFs+TLJP/pR0P33XTeSILayC3DfY4l66S3cDjQeM20VFBQY7Jzp3r09qXI3iohwNeJ3EL7DQKyt
	lblsJ+Yi2XyCmQFf+hZITdRbpqLpkR4RMqNrDK3sazkyri9As65h01ANJC8fFjagQAuUJclcsF9
	3cNZfMahMRUedVm5RuY53ezGatnLrjyTd01v4VctWng1fb74BTj+LKbLKoHOhyEMS5mpPRbeW2s
	IQ=
X-Received: by 2002:a05:6a00:3cca:b0:880:c10a:5de1 with SMTP id d2e1a72fcca58-897c79dd6d4mr16541393b3a.46.1792075124912;
        Thu, 15 Oct 2026 07:38:44 -0700 (PDT)
Received: from dev ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89e0d1a3223sm1663592b3a.44.2026.10.15.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:38:44 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] seg6: skip the route refcount in seg6local IPv6 lookups
Date: Thu, 15 Oct 2026 23:38:40 +0900
Message-ID: <20261015143833.seg6-lookup-noref-v2-reply-9e125a3e@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <atDhp1tk31K4RAKS@luna.proxmox.com>
References: <20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com> <20261010-seg6-lookup-noref-v2-1-51c09dd98197@gmail.com> <atDhp1tk31K4RAKS@luna.proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 16:30:02 +0200
Gabriel Goller <g.goller@proxmox.com> wrote:

> I think we should use ip6_null_entry instead of ip6_blk_hole_entry here.
> Previously this path (failure to acquire the dst ref) was reached through
> ip6_pol_route() and ip6_hold_safe(), which uses ip6_null_entry and returns
> -ENETUNREACH as an error.
> After this patch, the error is triggered here and we use ip6_blk_hole_entry,
> which returns -EINVAL.
>
> What do you think?

Agreed, the error changes.  v3 will drop this fallback altogether:
following Andrea's suggestion, seg6_lookup_nexthop() will keep its
refcounted lookup, so ip6_hold_safe() handles the failure as before.
