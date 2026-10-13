Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147F3F9F45
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887077; cv=none; b=gdCI1QA/lO3MueKd/IHqvHrU04ryidkakBJZGDvylZHmwabJSlIZaSjb58A5u+3j6dWI3a9rz2lQikg4eSvO1ed+3WRU8DgAhsh8NTUqIPODo76oIWmFBYcpulgX6R8K1/EeA22H5fCcvWUg+APMYtOwo3YHJPuZ+gBwOs/75lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887077; c=relaxed/simple;
	bh=0b6YNXan4gCMvThoMg5KGkRUJ369yx25LoQawqrwggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU4kh5X574sBNvPBbX6FuPSik1X9ILUbSr9ZhCkwUnce6vbJFZTma5e0sjb3HWBk5NSBsjoV+rN8iPOkK98vpUdHCT/KNFb3o1H7fH5KOk1GTQb7KnbQe4I1i5O/I774EbHeSwLqnU/boi3ocTRwDuwUc9BGV1XXX1oSN6IGUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=o/n9F5TO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="o/n9F5TO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49ff680331aso22960615e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791887074; x=1792491874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wCvuGCgbSG8Y+xpTFr7MEL+ldVl+Jz9SiKtT/R39MNQ=;
        b=o/n9F5TOjtuwshfOJmj9OEnmsNOwtlq4v6NTY4Oa5f3/oj4j5FxCYrO4RT8W/owhjV
         6zPPIWDkvFe1M7AX9Voq4xr53skElJGOWSTdPe+3aMZudgmrTYD/tb2RlqB9p3nxGKJ8
         Vwrmnu1F2Mt/j3DPZP0t+OyedFOcI3bgRfNL7dKtoW/LtoHh4Yq+bHAc0DWBYmSplgde
         9zMSvKyXvKal0Fc14usjPqgoGzhuajyEeLeShxqDn3Kye5+wlr64lNS0ueHijzud2Nyh
         V/jIvRJlVEjFQ1sWf0roZYaModfEl5IN6/mFzXlRI2Dx1E0tMCXY54RfMQCbhB4gVtgG
         zN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887074; x=1792491874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCvuGCgbSG8Y+xpTFr7MEL+ldVl+Jz9SiKtT/R39MNQ=;
        b=D2UgEhTmyxYHbhZI9betV8BGHFMPIM03G6A6+OolndjRbAfagUwlgzG1XoWKTOcS9F
         /Aq0vq7FJE1N2cBnfToOMkSF52e8O1SUDnNZ6Gaf+acUR/ai4ue4dXu89+YoZ81pYMJd
         h8Ch+1he9cktREfJVw26VbEj7e8fRRRmlL21rwjeJLkhAiU5HQzU0IFE56Y5hBn3eKnZ
         6uKTR29KRH5HXjvVNwLxJ4rlpc61mFSrzft8ULv1Ox9m7eoF3WLoZTEMCEOkX7BYTJSq
         Y0zmxn3+4qj+qDw99fpxbUP0Har0ElPhVyrOKQBvmCv5eYGUaW0Ky947WwUyGvuraTGD
         STjg==
X-Forwarded-Encrypted: i=1; AKwUvBxSknFmyyfBE68aFde3Fz57x22Ma3fy4B9Sz1hdDFBNlRAnF5e0POf1OpEI9VbZ3DS0V5IMDdY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMNV1aEWLEVyL+hYDCdPtDfumUTUdypJdUwZKwQH9bzHa/FJ6A
	3sFDfPnd5kKfk+9aPiO4pXSIzJQUbeDhbSUdBTd29Q5r4Aj6dVdMqSazWdW+ttWmQaI=
X-Gm-Gg: AYBFou0K3iyboYcS25ERGCrIeelFq9pdA708r7hXSPgE97vtT9s9hfhxpFcmzb+gU26
	8ssQWT8uJ6YZyLxTzTGyi9dur8XNlYlH6CtuGg4mgSkVAok19AistKkYEfAOMYZuZ9+djdGzsdM
	FZ06yri2WP0tzGcaqEgM35s2HguLwe2/RNNPXpR/eAI/+s61CjynHgQhZAk9tmmqtv6JTgk+Jv1
	fCXXTbGQy3ZXXgWpXzNLShx/T+g6GtunJAyj6UgR+YBa4F35xEzyV2yE0UW30iZmLPplIweVG6A
	GIrOz+WcoRa5InzfhmUliOOf0RegTxcvtul6kdxroPEdgnWTyMOzCLd/vL0fqTRKjMMBt93z63N
	TLbDl3x5TPfQwdaOPa2B2odITF82tcI+GqhGYCTL0Upbh/DsQbsnhtcA3Yv5rAjNapnRs9tC7Xz
	8Wua9/Y55RRp/vo8LkwaXGXiHEeZ6o+gnfzptDyP92Vk0WJKdoIQpg28PTMZ4y1Y9PUVafTPckR
	cUPEJXBXM72CPOPzBiGx+tLpugptvxb6gw9GtJ7o7zZ370kYsKXJoFJ0h7qgDY+A1AQ3m685QTN
	oTZCSfTvZ1Cf0OO6yxiIyl5j9SWJAnsXvxVtWKUS6mxiC62pXwZMK/D1M28=
X-Received: by 2002:a05:600c:3d96:b0:4a1:746e:5898 with SMTP id 5b1f17b1804b1-4a18e4835e7mr204484115e9.13.1791887073091;
        Tue, 13 Oct 2026 03:24:33 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19c8244edsm185108485e9.2.2026.10.13.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:24:32 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:24:30 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: add tc mqprio hw queue
 priority offload
Message-ID: <as4G3gXpyam7oGeK@aspen.lan>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
 <20261006-stmmac-mqprio-prio-offload-v5-3-d7da93419784@oss.qualcomm.com>
 <ase3UrUehtLY6b_5@aspen.lan>
 <97bc33f6-1566-4449-9343-9e3463d5b8bf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97bc33f6-1566-4449-9343-9e3463d5b8bf@redhat.com>

On Mon, Oct 12, 2026 at 07:02:39PM +0200, Paolo Abeni wrote:
> On 10/8/26 17:31, Daniel Thompson wrote:
> > On Tue, Oct 06, 2026 at 12:46:27PM +0200, Lorenzo Bianconi wrote:
> > > Implement the offload of the tc mqprio hw queue priority in the stmmac
> > > driver. When the mqprio qdisc is configured in channel mode, the MTL TX
> > > scheduler is switched to strict priority, and the PSTQX/PSTC priority
> > > bitmask of each TX queue is programmed from the set of frame priorities
> > > mapped to the owning traffic class (qopt->prio_tc_map).
> > >
> > > The channel mode offload requires the DCB hw feature and a 1:1 TC to TX
> > > queue mapping, with a single queue per TC. Configurations with AVB queues
> > > are rejected, since forcing strict priority conflicts with the CBS
> > > algorithm. The CBS offload is refused while the strict-priority scheduler
> > > is active, and so is a channel count change that would enable an AVB
> > > queue.
> >
> > I don't think these CBS offload checks are necessary. It's quite reasonable
> > to mix strict priority on low priority queues with CBS on higher
> > priority queues.
> >
> > In fact on the hardware I have (TC956x) the lower priority queues don't
> > implement CBS so mixing AVB and DCB queuing (whether SP or ETS) isn't
> > just reasonable, it's pretty much unavoidable when using CBS!
> >
> > As a concrete example of combining mqprio and CBS, the following works well on
> > TC956x (when I tested an older version of your patch):
> >
> > --- cut here ---
> > tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
> >      map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
> >      queues 1@0 1@1 1@2 1@3 mode channel hw 1
> >
> > # No CBS for TxQ1 means we can't offload this (h/ware stays in SP mode)
> > tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
> >      idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 \
> >      offload 0
> >
> > tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
> >      idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 \
> >      offload 1
> >
> > tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
> >      idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 \
> >      offload 1
> > --- cut here ---
> Given your later tested-by, I assume you are looking for future possible
> improvement?

Not sure how it appeared in the thread order but the Tested-by was not
later chronologically (at that point I had only checked mqprio
*without* CBS applied to some queues).

Direct answer:

I'm pretty sure it's *possible* that the new CBS checks could trigger
spuriously on an existing platform where the queues are statically
configured via DT. However do we *care* about these cases? I think
than can only be reached when are attempt to dynamically reconfigure
the statically configured queues. That would be unusual... and made
even less likely to happen because some parts of dynamic configuration
were broken before Lorenzo's patches anyway.

Indirect answer:

I don't know if the new checks can cause a meaningful regression but
Lorenzo has shared a patch[1] to remove the checks. Taking that patch
is probably better then debating! The new patch is late in the dev cycle
but should be low risk since AFAICT that patch only removes checks
added by this one.

[1] https://lore.kernel.org/all/20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com/


> Also it's not clear which revision you are referring to: AFAICS this
> patch is (attempting to) refusing CBS + SP since v1?!?

Oops. I guess I might have pulled a pre-LKML version from a git repo
and forgotten that!


Daniel.
