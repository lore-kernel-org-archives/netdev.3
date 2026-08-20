Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78A43030D;
	Thu, 20 Aug 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247592; cv=none; b=VQlfXW/ajPTT8SWeX73Yw78du2pIrreW5mkns3uLrGV84bC+3gtNqh16HgLZjZbRINpZOrizXu2o4u4omeNnFLFuvRCKr3TCmRGSdR47Kxqp6LEL7LugEyxCSKiiA8DMxOfRuQ7J/aUZjpoK/7l5sci9OxPIbkeRUmUQGOVhnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247592; c=relaxed/simple;
	bh=MX1PQaaG1CPGU4+omryRkF3pc5YS7cdsL9vK2zS5ktE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYCKfvBl8LTjVa9QQoI02BA+hCKjAz9Ps1v+KjRMSYyY8/OzagIR/TBeJa0hzL1Iq5pSn/KGvXSvY1h43Sj1Vvo8C1ke1fu3YOKUe+RFjONScGdvZCOGtdwjI5uMiCEn4YShD6UJjjQPFxW7dSwU5WD5OwIouHqqXt8wgCPq7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JadV/FIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JadV/FIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C4F1F00A3D;
	Thu, 20 Aug 2026 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787247591;
	bh=xMcbdc8K324aHfRfJ/+72VE/jtXB9paW6GSQPhOUmFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JadV/FIsdCrAd0uLTYrEPvbQxvJ43tCggrMoG+qeVtuDZrHPc2QOI9no39gIXVDDe
	 PRMGDXmTujT0kdhvDUrAYruYGUkUai0VVbM76ZZMabDH51vBjL1xCMm8QSjBm833sl
	 nOBqQpbnUdQUudaTuvVRna8a7Zo4/Z3B6WcdOP/7cL6xxAfrgXxQ4MuYWxzjB231kT
	 Fx/J2vND9fILl71avLgwsFxwkY80VhkfBN4p1kY85ca3aEoV2TWt8PnuYx4EogpDYR
	 /bjMYr6ubRhqS/fMOCCsqPQO/z4NfoXYOT4gQRE6O9nTjNBIfHehiY75KdMLvNc0xR
	 rVV51H/1rN0CQ==
Date: Thu, 20 Aug 2026 10:39:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Thomas Walsh <thwalsh@redhat.com>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH net] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
Message-ID: <20260820103950.5dfa2969@kernel.org>
In-Reply-To: <CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
References: <20260818141556.64303-1-thwalsh@redhat.com>
	<CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 15:18:49 +0530 Pavan Chebbi wrote:
> >         /* Enable TPH support as part of IRQ request */
> > -       rc = pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
> > -       if (!rc)
> > -               bp->tph_mode = PCI_TPH_ST_IV_MODE;
> > +       if (BNXT_SUPPORTS_QUEUE_API(bp)) {  
> 
> IMO we should not gate pcie_enable_tph() on BNXT_SUPPORTS_QUEUE_API,
> since TPH's initial steering-tag placement is valid on its own and
> re-steering may never be needed in some cases?
> So in these cases it simply disables the feature.

Since irqs are requested at open wouldn't this mean that users who
program affinity (all serious users?) will have the wrong TPH? Which
is presumably worse than no TPH at all?

IMHO the simplicity and consistency is good. AFAIU queue API is
supported on fairly old bnxt NICs so the combination of CPU needing
TPH and NIC design being 15(?) years old is rather unlikely in the 
first place. The real scenario where users may run into no queue API
support is FW being old, in which case FW should be updated?
