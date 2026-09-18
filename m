Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9348E0DE
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712686; cv=pass; b=iicGiP4TqzYkGTDoqSDjf7l5xnQkEzI9aYzLUBEWACmos1uz8Q2fFDJUrjf7sKMt/WNKWwmSbPusi1CDR5bXNDr9okmKJO3yzWu81O26qSJx9iz4BYH+ta3cGULa+F+gviuaXc+SyAdGCYT+8nlWAZNzgQ/ZAPtAEUDzslvWF/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712686; c=relaxed/simple;
	bh=MgYRcqrrPR+pmr4ZfrOx8DSOTQ2aU6Q8fwh6LPUstbg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nHGNmkcAB+Hc//0TKGfQwVdChxzfNrWKQ0KbfcG+/Nq7/cnXh5KI863M9yOX+86qcF6Ki4lxbg8ttmeUYlxXB+5RyhYSX5vDxHfyC1YknU4JP+Fz3aUO0tK5xa1oDvzEgJIzyWA6LtOEOfTsOY2NYVt55wUEP69q45SBGvC3kOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=CvRPGbeE; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="CvRPGbeE"
Received: from fauth-c1-smtp.messagingengine.com (fauth-c1-smtp.messagingengine.com [204.75.18.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hmMzL4Wmzz49Q3t;
	Fri, 18 Sep 2026 09:24:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789712672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Utn4YPDnwDWDiEHtSEYn9vYIonNp3xKbLi0xHIMoSJw=;
	b=CvRPGbeE1vKd9tp3OU0jbvRRMPboP/bYqBhibfU9KtE1QM2Ic/dd12bfLWwiN6XHYTyqLt
	gGnvhvc7gszXEkD82AzGc8rA84sAAP3jXxHdkj/X/Wf0J1A7g74a7y50h0KjrR8V3FHaYx
	/29vtqRhu5qWjBXe+zJGtM4r3dVeUqNAHRbY8XS+gaF0vEWp8+hL+2Gi2zE/Dan8XdCqex
	JmvSHoqWLZqZAXk2MVIaQ2TNNrLRi9GA2N2MCYfKsWaHmJzq/omnCk3El4ye1hogzg3/9w
	zokc2zeVH7ZS+sglQ+MWx2Xi2xxtB9roXr7K5LAcBrad0A3LM49pvbOIkN/6/A==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789712672;
	b=Cyfh124r8cdgUZGqHjcFQ6BOI3gCpy9AIn1WrygNGIMvnl0wibU7R2+VsP2Lq6jWR+0E51
	xeQnUHga1I7hdXbpkkmHvXRYKDLSkoPq7jDWr/oq4bIqKafEdxse1mNw6md6DkKLLO6apy
	cvjWxFMkJN0bdJUFZvXuV644LCxT74x1x45M2a0lLR19BXklhp55FnGi+2LU7LQpKVZkCT
	khDT5LI/5ieX5CIyVi+r+0WHLPUdbAdDhQwHPSxrIEFBZiFxGWU2M5cIzCz2LrIUynHotr
	F9V39USFqTMh1hxfcefekIqd7ruV2rcwgYjsw4D4yCD3IZADPhcM8YjHQyfA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789712672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Utn4YPDnwDWDiEHtSEYn9vYIonNp3xKbLi0xHIMoSJw=;
	b=VHX7dzSqA5RKvUlSLzJIIWRikqrrQv8+FUzwSbVqdtLXXUz2Djrx/tW5DVyGSYQaZrhqFi
	BmMe9bnYwO+0PVzsV/ebGsAu0vQeWYPybIbW94iiB1T2ZKHDPvgRaqcMB/yyLhAD5o00B4
	bOsDlaSj6T4H9SMh8sUqgn5fOlwq2Vhg6NA6XpupWO5kDU2Jf4DdOsqCPOot5d+InGJ99l
	bE/wNxenQ0ROcz8dyT+UMKXgmNPNbDnFOtbYUJCRvq57XCQioKcWg51yJCFoAw8NHcaUFh
	D9mj1qnUGOGqE8lzEx8rZ0u9vZv2qwEq92+q6j2nFHTPfBJ2YLvUtbg4XxEW5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id ECEDB198003A;
	Fri, 18 Sep 2026 02:24:29 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 18 Sep 2026 02:24:29 -0400
X-ME-Sender: <xms:GtmsasZSldZjBkFz_WJVQZEs5UjywjLFU2n1E4XPlW4cAkZf2LKxNA>
    <xme:GtmsaiP2CGTsUN2CnwzkVB-KDUJM1YNv1W92IFFG9_Eq_yrSd8QJXFnh3v86Vwwni
    CNkPdtLIovqk6M6HpgOYLr_7iAZkx063K6sjfMyDmjb7QA9CTfgt_kC>
X-ME-Proxy-Cause: dmFkZTGSQzkLHL20dI75v5KezdrR4/54n/FI7hF+bC7Q1yK6wOtpVo6TuJQUEPuDh31dsb
    1ffrVC9rw69TEmxHIkji76ul0+KSPvDqPDDlixfmostS9mk/hXKpw9WgeghXAiMxb9iFEI
    6wK0BpZhd/9VrFcYBUf0tiLPFrYEk/e0Kt0Q2/or9cMoOT9ndhwCtauEfcfEdGU7BPXx8A
    Kfr/3Jcso5z7tfdqDqQ1uPpEp3muBglFn8fmUd41iqOXFr+hR6O1NU8YHpFBanA0ZwHhqf
    Qm2UlHYgwBOfDwRJNVQCiIVwgqqLvOXS/eqrKqEJzm+qFrdWJtEOCEV7D5LhNwHCyfPWYd
    LWxQTl5tJYZE0SwZ0LmJefWEgd+7eWTcnKEjrEf1alX99BTOcDzMDvLXJ0gGoQpNmfIMDi
    WIEVg8HZzPFdx8kRudDCnNQcVnR0AlipijaAty0J27ZagaJoDMjBEa8s5++ZU27p9vBWqx
    Y/HYB/moUWPwyh7rIf73gwCHoKTs5x38FEaZKJyApyd2tw0/qEJ6cw2RqPoVmATYF5zRwx
    Y6egJAysP2b4e39DA8rmIsKqikL6IKpDayj+TofjQxtohllnUZxW/dDr6PaJ3n9UmnP5zD
    4Sh8yHaCRd9BGAg+CmiUYFXmPqIN9wh4sx5k0pXkwEfwSDzlzbm0qfF4pPRg
X-ME-Proxy: <xmx:Hdmsarh1TLmd2g4qin5IG6Bb8x7s9IJ0jMQ7jCqKbry52eP7LdUr0g>
    <xmx:HdmsajeBOqx1e5YPWdeP7o-v_kc8s3FI6XiFpc-zsGabUBFxB9WcjA>
    <xmx:HdmsapyUpQUUemavGFRAsE82BNgLQPhZn4ooxQuSXPjS2QEbNPLOCA>
    <xmx:HdmsaladdsvHVav1idVfoZ2Zvfb8UA76u-hR6tvQS_Zj1pLzkVb4IQ>
    <xmx:HdmsavKNbvouncS0j1xMW34rey0AGVqSY4Uu0Oy1Ywr1MopH7FtvHpz8>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6B303F8008E; Fri, 18 Sep 2026 02:24:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0bevnK5BUW7
Date: Fri, 18 Sep 2026 09:22:40 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Manivannan Sadhasivam" <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
 "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>,
 "Jeff Johnson" <jjohnson@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, "Simon Horman" <horms@kernel.org>,
 "Mihai Moldovan" <ionic@ionic.de>, "Denis Kenzior" <denkenz@gmail.com>,
 "Marcel Holtmann" <marcel@holtmann.org>, "Andy Gross" <agross@kernel.org>,
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, netdev@vger.kernel.org
Message-Id: <9837273a-c62f-456e-9aa0-567b0d3a6f29@app.fastmail.com>
In-Reply-To: <da6003cf-515b-4d97-8059-3f4553d0251d@app.fastmail.com>
References: <20260915054207.2513877-1-juha-matti.tilli@iki.fi>
 <20260915154705.67cfb94f@kernel.org>
 <da6003cf-515b-4d97-8059-3f4553d0251d@app.fastmail.com>
Subject: Re: [PATCH v7 00/15] QRTR Multi-endpoint support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2026, at 08:53, Juha-Matti Tilli wrote:
> On Wed, Sep 16, 2026, at 01:47, Jakub Kicinski wrote:
> > On Tue, 15 Sep 2026 08:41:52 +0300 Juha-Matti Tilli wrote:
> > > Subject: [PATCH v7 00/15] QRTR Multi-endpoint support
> > 
> > qrtr usually goes via core networking tree.
> > Please make sure you base your patches on net-next/main
> 
> https://github.com/jmtilli/linux/tree/netnextmain_multi_qrtr_v8_multi_ath11k_ath12k_v5
> 
> That will be the next version. I'll wait for a while to see if other
> review comments pop up for v7, then I'll post v8. At least the
> current v8+v5 QRTR works just fine on my multi-card setup.

Hello,

Some positive news. There will be no next version, as Qualcomm is going
to provide a superior patchset that I tested. It's easier to backport,
cleaner design, fewer lines changed, has 1 author as opposed to 3, and
most importantly, it worked just fine on my 2x card setup. 

Thus, I'm going to abandon this patchset.

BR, Juha-Matti
