Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AA146D53
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781397032; cv=pass; b=qbNyWebeTHIvAYc88RDXDg5ZcaLkAR7c44ZwAD7KZr2rLcHCDxY0XgNgG2DhtGMvKm07QMuTCfRvnES0SNKANL4cUYW5rnvczOv5wlgNxKW/2aTxnqANnfRwC+TXdw3fnVZlwisrfBbryzOdO8QMlAv2ZEtO/7Xg/qdMBj6Lc68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781397032; c=relaxed/simple;
	bh=FD1hYeZSVuDKmLdk4UZhd6jkbyxws/bb84NjF61sU5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkKcnDPUwo2BhagsitFVJHl2ZZq4eGkfqGmT4QvZk8mhfIM0Dm5ccvwGR3afA8U8O4WXp3eVWDm8DO6L8ztxyI0E7CL8U9ICY4S8qhcxSRpNi6/mYKgsTqBK0+LWuOTKx3Fr2vk3wYkr6bh4e5q3hKzwFmA7DfG8dlX7b/kPyI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNJONOSV; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNJONOSV"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765531803so529041cf.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 17:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781397030; cv=none;
        d=google.com; s=arc-20240605;
        b=LrPmDSlvdlr0gd3KIDABPJ2+trMvq4ZB+6Qaqj/A6jPckQRqruhlCMFACugUDZ4L+8
         EGdOp6GtanxNgBZi7J7h7+58vMaNvtY/cDhgB9tLXO90hEw/jWAqvvlwQOP4aAhnEo9k
         HkqoO3UswpjoH2o7smfdFK4WdQ9ajY4VjyQz/wRHWiyt5rywRk5/kJnXF4oD+axPbBWL
         E1jjNZei3p6+v5CiMnj2hoJfmS1hF0OoZnQLpgtqd4AYCP+10Z2r3eqgv+OAk4zkgxLb
         4+AghTe4hpIQzbTWW71dgkgpsJv+HUfYYQFsFnM+ROCcr3d5GuTYNUj3ZnFK7JLsB3LE
         ctFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FD1hYeZSVuDKmLdk4UZhd6jkbyxws/bb84NjF61sU5s=;
        fh=5QdTtu3ybmToaiuprbogLCLiU2dhWBDWoqrepRKrpP4=;
        b=Q6If1LPkJdVOvYRXzPLvnztV6jLas5VoQ4rmW+OzpfWELLnksSODtKhrVxwSLgou2R
         iqBeSZf6Fw/NJsM5MzSYsKUpDi5CL2hE4Y23CtVoa3eWIdjc5TA8aBzGH31pciXY5Vml
         wu5AIEpYyF+fuh+yYOI40Bz5ymcALaPN23lY17JGuboFAma2smMyU7bzAzQmmsyCZSMj
         PA8B+eVFtDfbiCpP87wuBJ38t8JLeilgTLWHbFBGgAjfPNsHf0E50pSOHgxLh/5voH+b
         nrjB8IqWe3dhmOMc3YmpmDocQ3rMeK7JXePzBoCHA8/hmmoQoN68yOXvPHmLL5V/u7CG
         UsfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781397030; x=1782001830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FD1hYeZSVuDKmLdk4UZhd6jkbyxws/bb84NjF61sU5s=;
        b=mNJONOSV3TjNLRhgSQ+oonDr20CCTyuW/cimauUu2goZ1ptIUTn0YNtfC9AINdWQ0p
         X1uHKC3ymsaIWBtz1RISBeI3Op4E9WsCH4i/3Ku87lI9ukq1KngmOzg0kyBM+Hf+Lsdq
         EvCnp4eyw0/cSsMECXAYUcrEMlYUNi36C/Ji35PYMaj45E+dCkq3iQb/VS/wCitRnqlh
         j+TqZ4RuMMGzhFj8OEoutIhCdFvWFvZ0STPwmMPD1qjliLtSR8CxIAVmm/4ZoaF/1WvI
         wdRUyjl7l7RwyC20PTcu7Bquq6Z3tm6/aBClbEJXkLFff2DLchTBrMr/0GQ8aMJcGwAl
         JbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781397030; x=1782001830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD1hYeZSVuDKmLdk4UZhd6jkbyxws/bb84NjF61sU5s=;
        b=Yv9ahBZSI6lxE+kd2vZXegIpimrBWBa/Y95Fu3iBSPVJH0INrOQ7DhfRnDy+qovrfL
         /JUMcFiumlE+TLyt3OHWXWL+8GfL9npTyL+fqumgLHbd3KlWZYjeqXZaO1OtVHHOPJD7
         PdORTQIN3tCJyeXJc0QTSQ15S0q+G2dVCNIDuAYyqzQn5sqtXk8qvIL+Pxa3TVz+bq0A
         jrHIOjnLAALDMibw4rITUXkNozmj+90l2BoPrFcUog3/j8MhxBjARqgKBIeZzz6VXASl
         k5Wa0ycGXqPuRNrH7SGFIoOgrSavo66ytK2UEHXF+E4qziQ9X1C4E5aP90Yu99vYCZ10
         ppSw==
X-Forwarded-Encrypted: i=1; AFNElJ+JYPSVRHOzn86y7COHA36ed96iy9tC7dm9dH1gfDQW1ws+MvcovmpisWXXqZx+PbspkilbOwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxYfwc6111MypdQ8fwP2DXV6o2XYD0cHjoxMEf+6KvDi+bjvE
	xGNxQutDC4oj5huRtdMpyOEvExFcQyvbL6Q8ELgoMXpnUSRxmo5OIYcMutYQrXr43/y58nWn4+R
	f6sPe+FtTeXyJ0mwrCwDtEHD7VOysPP7ddch0IqmH
X-Gm-Gg: Acq92OFfloWUygDweTq2HRLwPaaIXA//eHm/kudEW0IUky280KtRifkF8G+1ZhGRPbd
	7cLINIgMXK4rnlxZVGLDlzdLsISVxA7gJDR4Mm6d7DphLVcOdryWafKueLgYne0aHlyQLcRikgK
	kioiP1IyRaF3jB6I9irtWj4AuKUbvwh86eK743sThwaRPkysI88+pFnqQH5xtvcJ3Yrz0eFk0e9
	uf8CjbNnWh5AcMPYg8Oxi/fJSqUEUd7euGkb+70G3BgRZ4qTyTF3278xceGVjwOa/WGmGnNmx3m
	u8xI9+i2wTuKQh9ikeoMnADDInyzZBvPediVDQ7ORZXQAS5fdSyVG6AWPfJ6tfSIkcYZO1TI
X-Received: by 2002:ac8:5a14:0:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-51955e93234mr6932301cf.9.1781397029793; Sat, 13 Jun 2026
 17:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609122646.2297540-1-yuyanghuang@google.com>
 <fdcc6f4b-6f81-4422-bfbc-7376dd5cd19f@6wind.com> <CADXeF1FaYn2sDyM3Kfic5eyP2oQO9uQE_rFbwwRZFrOqyWSJcQ@mail.gmail.com>
 <5224a3f8-16e9-4967-9fce-14e1a0fc5205@6wind.com> <CADXeF1EtcaMaA0DseoR96R7Ru0Fgu9YTrOX_y887MajN7kw57g@mail.gmail.com>
In-Reply-To: <CADXeF1EtcaMaA0DseoR96R7Ru0Fgu9YTrOX_y887MajN7kw57g@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sun, 14 Jun 2026 09:29:52 +0900
X-Gm-Features: AVVi8Ces_bvwdDhhszBH0gszlGqvi6KPOy2Sn5reaZRBOCXMv40_DZxdCPGuOAo
Message-ID: <CADXeF1E97LDTzmE-oFMdEWUEgVU_6vwSWK53MTiGY4z8LVRtkg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: igmp: remove multicast group from hash
 table on device destruction
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If there is a strong preference for adding a Fixes tag, I will include
it in the v2 patch.

Thanks,
Yuyang
