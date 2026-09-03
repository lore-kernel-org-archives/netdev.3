Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A84CC289
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448798; cv=none; b=gnE8NEfVoM4Np4J3pERj2PTXAwM3HcLZ4uCYlHk43bEn+q7jGg/vhXew1+eNmgR2ga9WjZBnkQbb8r0Bbcw8MAvO4rTrD4etdKRELmrBFm08P5aOnMXePsd8IkdDQKSg2FALY/ko9ri+X3xY7/y+S8BAVB8AhpPwDb59XLcG2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448798; c=relaxed/simple;
	bh=2J4kYJhWzcn/tlR3JRnNUxnbyfb/k3jvDTo55cncdW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVHlxR0rxk22UhpO5MprCDHLQYGU6ElWLBKLqwKRZBGn2xG7+Yvbybsw3A7/rAeN3oRxRIkpdE288WqIkX+yg359Oj1NG1gSQn1N95SwmJ5FRMwHZc/JouMMEIid77hwZP2xqs9ZZRi4YUFR5CkPsXm3chkpkWGhj+GRf4/rsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=O9jxrwfa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="O9jxrwfa"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-853c07a76adso2907628b3a.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788448795; x=1789053595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4k71jgXR0pxejFwDgrDgrQ6R4Jk1k1enZ3AJ1qLF40=;
        b=O9jxrwfazSf6pIO7nr9/nF5Hx75D37G4jf3k1T6Cc6Gj1riRhaa5r4byMn1H14T3cU
         xA91cmQlZdG0JvONb9X617VCEamDDPQP7BKnLGiH1/dQu5zf/LhshCLxLRwd4RKla1u8
         +cJ9oxXKhjG4D8s1kuCe0Daef5xu0mIRRlzQgL3blBcEq+SN2YyGIf4Q1YeROVuJCSH5
         TB5bSoUirLe8jedvVH/3pCNYnehqZOE/IjvnnX4ZyQ3jUv1cGTkxPtSo1hSGqf1spAEJ
         tD5XN0F7Uxx7PMqEB1iyaLyMLXL2sdt1aiCvALdpzW3fV/n1mMIDF8mWtTP2yvrTCptF
         VH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448795; x=1789053595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t4k71jgXR0pxejFwDgrDgrQ6R4Jk1k1enZ3AJ1qLF40=;
        b=Ohs8tDT7T/UX/7pMW0BdhjgkmpDZUYm7gXG7X9BFcwuwaE8YmVtWFw7T7SKwACioiW
         Xs2/p9EOF6JnxMpdxq/BaT+9QyxGDJPot1JQSQca8SQqsInFdBYvTCNtroqx5kHT1dbA
         VrOgMI/YnR8wXz73wO46gDdUd2Em7/Yi7OT2MKLnXcYKZVbk6mSUK5np35traoNherd3
         /UhE1XKmwumSkuaoYLVZwOZatwbVo9ZSVhJ+HyyqNXFmLuQsUW50W3KnGYyzblkbopae
         lQXaCaNOkZDm2+VVkB4WpueKx2Buy83wV5kIw2TDU0NaUrNcnd7ycBu0r1BtJSAePeI3
         zswQ==
X-Gm-Message-State: AFuF++naiaf7psa+vfa4n3oHMEGVa+PVqZxLYk05LTZpBEeAJFf8EJgt
	A1FTdMTCWEI5k3nxGXcnP12iVUh9/Rh6F5yr5/kC2IUafKif5ejtHlx4hyeTf9LvVNI=
X-Gm-Gg: AYBFou1YzdntF9r5lTMZH86FoXn8GFlFRkFE+6tjVTfLDlA77C0O+l5VkVX+vnrjMOn
	NtKJXulKxHhTi5QPcDwzbqsvq/m9T7QVrMASWExv/lgXZTuA7wouCC8JUyjtumUxWbMd7Ca67s3
	hLEK0SwjhB5pmQ39nhZMow7+kbxArQF+STThhLFTVY030TxkpNBCV8bBs5xJmgO/bdlphif+pgx
	3XOqlNBqx2GJp45H2JHDnVJFk5iUYO9QcYkFqvcQxcGPeJ2xzZEjo85oJqi5HM7+X/DZIyq7Y36
	pFKwyFps9/R07od7YSR0UUY4YoeEJB/ZZw01VeU4pzFlU+GkpLnKCFMRNHZuKooAq9V+POd/UIe
	6T7172f9+gY0eIkEFHuA0p3b5ZqREfuRD0pHF/5p5DJKZjhvOuO6SOD/HZaJVj5/4i+9ral75pK
	ctWYDEfTwJc86V70fiw3XsGd/obFiY6eRW2/77innIgw==
X-Received: by 2002:a05:6a21:7a86:b0:3d3:ae40:51df with SMTP id adf61e73a8af0-3d9aeef1aa1mr20459239637.19.1788448795373;
        Thu, 03 Sep 2026 08:19:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc43d47d32fsm1093623a12.32.2026.09.03.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:19:54 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:19:54 -0700
From: Joe Damato <joe@dama.to>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com, colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com
Subject: Re: [PATCH net v5 0/6] Fix a variety of TPA bugs
Message-ID: <apmQGp1mEhQ1EiEb@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com, colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com
References: <20260902015652.2421609-1-joe@dama.to>
 <bb4ae7c9-e705-4eff-9813-065ea4bd9514@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4ae7c9-e705-4eff-9813-065ea4bd9514@redhat.com>

On Thu, Sep 03, 2026 at 11:37:34AM +0200, Paolo Abeni wrote:
> On 9/2/26 3:56 AM, Joe Damato wrote:

[...]

> > I boot tested this on a Thor1 and a Thor2 machine and there were no crashes at
> > boot.
> Waiting for Michael's ack here. Note that I think that the AI report on
> patch 5 is not a blocker.

Aright. If there's no reply within 24hr of posting do you want me to spin a v6
that:
  - fixes the commit message sashiko doesnt like for patch 4
  - fixes the resets stat it mentions in patch 4
  - add the return value check for bnxt_init_ring_grps in patch 5

or just leave the series as is ?
