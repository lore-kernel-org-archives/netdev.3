Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC031D375;
	Mon, 24 Aug 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.228.58.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573667; cv=none; b=oGQcl3rE+wU8biLVw/Jm6cubZ8kMudG4kVBdMl8wZ/ocAkC+PJ1I+JVL0LPr6xxDpW5QYwaZfR5TttxmIPiGm1wZaSvYM1mg0mW+zSH2Eo34qIwt9Z5lSmiu3PWOIUooSA1moqG2DBym8K/zLNZBp1oJWLNF8ZBePcvM8E2WpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573667; c=relaxed/simple;
	bh=C5+FTcJeQfZJ79QNwnVuBLuUcoOGbLQYmpNKCs0b0/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNARb9kLGIWxWKAUbuC4cxXsfWCbn5iy2HxPP67F1BFCeV6kPeVEbsJfYC+eKQMSiHIOeS4lg8y+nkgmi6y30UCQ2Z1asrs8CmPIFk9N0qFbzRpdvfQA2CmH1mDoibkPgf8QuYXQGCzaXGR5KYbGAg/0p6o6ZwZc3aEJqIkdMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de; spf=pass smtp.mailfrom=dspace.de; dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b=P2mocnUr; arc=none smtp.client-ip=80.228.58.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dspace.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b="P2mocnUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1;
  t=1787573663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C5+FTcJeQfZJ79QNwnVuBLuUcoOGbLQYmpNKCs0b0/A=;
  b=P2mocnUrmK/FVfF+c9SSdqPo7IeTAFdh6hLKCZmkclALeVH7FC9hXKST
   juijGaYN2lYtJviEJA6lwt/9YGR9GF425NSOZGeUgL230WELN6fUoscCl
   7T42VJUQNA62vYm20Wjm3UleGU5Q6Dm/2q3yJMshYdHbjHB5wk1rgZZUc
   Q=;
X-CSE-ConnectionGUID: ibBBQgkQSHu4RUeEFYL0Tw==
X-CSE-MsgGUID: emOEdhnyR4uvF9vS93N+DQ==
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="5057880"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
  by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2026 14:13:11 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
	by Z1-1000 (Postfix) with ESMTP id 5D89760038;
	Mon, 24 Aug 2026 14:13:11 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Z1-1000 (Postfix) with ESMTPS id 5030660037;
	Mon, 24 Aug 2026 14:13:11 +0200 (CEST)
Received: from PascalKW11-NB.dspace.de (10.71.4.31) by EX-DE-PAD-SE.dspace.de
 (10.100.196.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 14:13:10 +0200
From: Pascal Kneuper <PKneuper@dspace.de>
To: kuba@kernel.org
CC: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com, 0x1207@gmail.com,
	si.yanteng@linux.dev, larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	DBaldin@dspace.de
Subject: Re: [PATCH net] net: stmmac: restore NET_IP_ALIGN in the non-XDP RX
 path
Date: Mon, 24 Aug 2026 14:13:09 +0200 (CEST)
Message-ID: <20260824121309.45411-1-PKneuper@dspace.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818012216.3825070-2-kuba@kernel.org>
References: <20260818012216.3825070-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX-DE-PAD-SE.dspace.de (10.100.196.14) To
 EX-DE-PAD-SE.dspace.de (10.100.196.14)
X-C2ProcessedOrg: 563f5800-21cf-4d8d-8aed-fddd1469e4ee
Content-Transfer-Encoding: quoted-printable
X-TBoneOriginalFrom: Pascal Kneuper <PKneuper@dspace.de>
X-TBoneOriginalTo: kuba@kernel.org
X-TBoneOriginalCC: andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com, 0x1207@gmail.com,
	si.yanteng@linux.dev, larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	DBaldin@dspace.de
X-TBoneDomainSigned: false

On Mon, 17 Aug 2026 18:22:17 -0700, Jakub Kicinski wrote:
> [Severity: High]
> Should the XDP branch of stmmac_rx_offset() get the same treatment?

Thanks for pointing that out, you are right. I reproduced the panic with =
a
dummy XDP program: without NET_IP_ALIGN in the XDP path my box again dies
on the first incoming ping.

I will adjust the patch and retitle it accordingly in v2.

Thanks for the review!
Pascal
