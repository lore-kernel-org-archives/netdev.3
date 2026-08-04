Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9238340A4D;
	Tue,  4 Aug 2026 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885800; cv=none; b=fuX5ArnhsciRWgkW0ayyA3gy1eV6D9C98LpoGuSbA6c3Biw84gPXHPHMwtvwC5bJJU3wOAp/CAp+3XRZUw27yPrkX/dTQgO5K6GZquw5WXYbYh8/4LJagS9QfBnDZz9En8JgDDsPsfOb6pSLNgs+gYlIkmJnQJGh3ufhbFu5UBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885800; c=relaxed/simple;
	bh=kGyIdqoakMJBH1rkMS1oADN6XiL5I6aUNOcWni7X6RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rO+diG1VGeZkiDdFlIxoS4bmAMIknGTUE6Rs6wOhqLlL2ClSI43lDjvZjXhsC1aDx01IPCy75NVXllZzQx9KogtNpbbW/vrLB5DI5W0f4GXphPhN/xAzMFrE+89sN6O3uuZDWzOt2vSpze5uau+d7VOBAuFAwMKuo/I1wJr3AFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkZgbuXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkZgbuXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C771F000E9;
	Tue,  4 Aug 2026 23:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785885799;
	bh=91F3vOqLkxgb4YBcryRiSTb82yMih5D8zxGHmtfCFns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LkZgbuXurgxi3s/7lsrqnlNcf7uHzB3/DAtMhqmR/tDo2MnsTzHwA0I2gsvqmGzDz
	 Xfq/zRD6E3mKnSCvsPrpZLGOxi/7Vzl8g0BEQwUGl/mC1IpD6OXfmbQCTyVcus5e19
	 XQXSFSFq6mKHhj+ETefgkmu3vD/wZSPY+4OWpQIiUpIDSASEZ038HyKHuE2ZdRFbz3
	 bNo6g7fa/0UBOoMdr9IUtzL/CiOB5fs+mZGRYH2jYEHmNbBgTZ4E559Hq9zqh6SFCt
	 PL5TAdoNwGIYKC/OA9X13kIYGLtmq7Bt5d5ED15Nb++YUvUZzfWDR8Nwy/9/rsKmm4
	 JI3O3UpdFESNg==
Date: Tue, 4 Aug 2026 16:23:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "maxime.chevallier@bootlin.com"
 <maxime.chevallier@bootlin.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "mcoquelin.stm32@gmail.com"
 <mcoquelin.stm32@gmail.com>, "alexandre.torgue@foss.st.com"
 <alexandre.torgue@foss.st.com>, "joabreu@synopsys.com"
 <joabreu@synopsys.com>, "jun.ann.lai@intel.com" <jun.ann.lai@intel.com>,
 "yi.fang.gan@intel.com" <yi.fang.gan@intel.com>, "boon.khai.ng@altera.com"
 <boon.khai.ng@altera.com>, "matthew.gerlach@altera.com"
 <matthew.gerlach@altera.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Message-ID: <20260804162318.0bf48050@kernel.org>
In-Reply-To: <OSCPR01MB12769B66B3A1316E8B05AE8CAD3C92@OSCPR01MB12769.jpnprd01.prod.outlook.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
	<d39c7b4c-04b4-4bfd-8a4b-821a8a32a885@lunn.ch>
	<OSCPR01MB12769B66B3A1316E8B05AE8CAD3C92@OSCPR01MB12769.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 08:57:23 +0000 Ovidiu Panait wrote:
> > I stretch goal, if you are interested and have time. Can you turn this
> > into a test somewhere in tools/testing/selftests/net ? If one MAC
> > driver has it wrong, there are probably other MAC drivers which are
> > also wrong.
> 
> Sure, I can add a test for this in tools/testing/selftests/net. I'll include it v2.

small correction - .../selftests/drivers/net to be exact
and if you can -- please use Python
