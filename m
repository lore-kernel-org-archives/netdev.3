Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937233937F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653029; cv=none; b=uEQYvOQbe8w4xel/d180cJRetYHIWPJP/hgdXIprK6n9RcJWvju2tAnVLv/gftJGj3igxf8AHd+U7Bk2CZj7TwHMS/gp4rqnhGTRyn2IMslSF0QockjW/Owcp0dcKloMWgEzaoB5+m7Of7IJcFTz/rlNaIalgqR3jyFxrRSQL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653029; c=relaxed/simple;
	bh=nN9w5tFs3ZbZmu7QiVne325kbAECks0+a7kHRadxptk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5Jmx9N25iGc0Vdp5yF4kgcIuyoCAGKHop4I3r1qspCAq3Qnylm7GDrm/L36lokMupr/UZLStmZnsY0DMPFUAVFYiGD0RZVOzkiVV22le0XWxT9Z7XT8+dOqdNZWzZB/EjrvfkMfcBmHI6pHZN2LobkusahFmv+15+aTelqlTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fqBbXrTo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fqBbXrTo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49954b88fffso4391655e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786653026; x=1787257826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDb0rZDgd9FHSsVBn+9muRzbKR+wt3BKMUBeCokI3W4=;
        b=fqBbXrToujPOiuRCTOMPTLHEl28LY17f0uJdjrqubhriXGweOCmtp0szBOVJibqXaK
         Sh0EXv92UGoLMdkmm2ZD6ERdjTbiGLYh3p3UiMSYUUGXRW0flTy9vzxwGGDrsLwo7LHK
         5Kp/RptT2hjKeUop6xPeb+6mSw33lfRTxncL772FjTZn4pwl3QUEKVBdavntKnax6Dyn
         b3xv+UcqaEeunk1LosVWBeB9Wh6VYZdPnqPH9hfvhpJ+kezywjqKXG/80FdS30dWjHVJ
         9PGXdG2IRd5+7xyd8eCkanLHDUCznK0o0h9tmVOesvSkCL8toKfz3m+P5q2Qyn5XtuA0
         XbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786653026; x=1787257826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDb0rZDgd9FHSsVBn+9muRzbKR+wt3BKMUBeCokI3W4=;
        b=oRRj0yUPya44W3FmihcnobrlTUK4x7gie577K43T+IzAXojibPR57pQaVy3JyevwQ7
         6H6soKWqabpLHVrPz0xVuPN673FIfSPMFD2WEMgueOcUslv83Pt5us7JwNo0TjHdaIPN
         9SgakoCIKL90mlS8zqv/d5u/MWP8uZhMiB0vDm3urjLxj2T7ZpogXUyfreJyjWIbMhnn
         qEs8sW01FC2yilP94jwY0O/ncZ9jKkYTD8MFBbHxBI4ZFh/uZh330qMbI548mLETTs39
         Puxjyt7NlxmWNhOpwA8fWQQfqCO0K+fRlFqvJejYEKuHtuGx9UoxYzYdXjX6oBlWKqDH
         B0Ug==
X-Forwarded-Encrypted: i=1; AHgh+RqG4NCGGJty/yBV2bdVYQNH5zYrJ+tfHMvfY6uZ3/MhLGJr3ULp9fMzKrXhXaTOz1ClrnrXDiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnH08e8W02PcVxnFIgmIqSurS1dgXQu4WBMmTzIz77hEdsojd
	QP51/GkcIng+Nlb/CUUzfqzrMl2sSc0gka7ldSSXnaFCP+nS6ob8TMvub9qSbdghM18=
X-Gm-Gg: AR+sD12UIRlDwg1i1kiU5FbwfAI5uFW2yKXDcG1rtu2P7AxIUjEniB+05Hv/XN4APc5
	EjXDy2THAMLKEbKUyfarkmZSJe8D4iHYKhCmkoIng/fbKsDKzTkHBpSRHFpAPMaAlqDtGPGt4hH
	JmoXmgGhEW3ovs+wtWmDJz13hxfaFUeizupSC4h0yasVktBuonYbxDUo00nQbCUFmZB3euOy3OP
	h9k4ZSoKEMhQqHfYfbQhad7/oEadlkS26FJ/WaKs7vRNOYxawW5CQbg+bnXFTl4VX6b0Ew3f6Mw
	IyljeG3gfIw6gc6cclmDEiMJajVruS0LW2Kfi1nV5US9ij3/+5ddosrc5GIv10gdh5njIg32C24
	eFG4YYHDqv9+JEBJwHMb5bzkrZOgO7b+gmbOdSoc156OyfJJNQUp43RkKSMDVhW8+U/WRZxtV9r
	6WtnurQKXUei0K9d32mBftC8UaN9g+yrBv+ophMum+nel6EmwMPAGGogdF0OIPdmJmQ67ttZgit
	t465bPXZtyGmE8TezeeUA==
X-Received: by 2002:a05:600c:8714:b0:499:49f3:77b1 with SMTP id 5b1f17b1804b1-49987938551mr15509585e9.3.1786653025459;
        Thu, 13 Aug 2026 13:30:25 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219d3dsm2190383f8f.14.2026.08.13.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:30:24 -0700 (PDT)
Date: Thu, 13 Aug 2026 23:30:24 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ruoyu Wang <ruoyuw560@gmail.com>, netdev@vger.kernel.org,
	jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: initialize err for empty target lists
Message-ID: <an4pYO_Co20iITY4@penguin>
References: <20260813153126.3952893-1-ruoyuw560@gmail.com>
 <4b095542-6656-467a-93ce-4a39c6c80c46@blackwall.org>
 <9ee8e417-e626-45c3-8c4d-cd605123ff37@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee8e417-e626-45c3-8c4d-cd605123ff37@lunn.ch>

On Thu, Aug 13, 2026 at 10:25:13PM +0200, Andrew Lunn wrote:
> > By the way you haven't CCed the Fixes commit author (me).
> 
> Hi Nikolay
> 
> ./scripts/get_maintainer.pl drivers/net/bonding/bond_netlink.c
> Jay Vosburgh <jv@jvosburgh.net> (maintainer:BONDING DRIVER)
> Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> netdev@vger.kernel.org (open list:BONDING DRIVER)
> linux-kernel@vger.kernel.org (open list)
> 
> You are not listed. Maybe you can submit a patch to MAINTAINERS?
> 
>     Andrew

I didn't mean it as a maintainer, it is customary and good practice
to email the author of the commit that introduced the regression,
that is all I was trying to say.

Cheers,
 Nik
