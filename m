Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684977;
	b=POhoGpuGXQu7i6WfknFQ4OcYgqj7ZZrhvMd4eejpMXppLu5n1gfoY5bvko0dbBda2dnN
	 Ke5xHucYP5rt+K3X4IRdpV5jY77+sb309fUO6nzgQzydXDFRJbFo54o+A/zndeI64RQQC
	 GpikoevIg2BT2AsvDwg0xKzK1Pc45IeSSjmiXWknMzOTifvZEIL2apgCxMdSSfpHd8RGA
	 tSD3wHrVEef3gfSpt0PYjCfzjyxjlvjY2zWBDCOHKA8CCBdgHqHkwn5UCi6E1yByYX0VB
	 F0UqCr48/cgs8DALXuS43GYuPThYKYxZ2ojhNATLjCHsstQ6qA+UvOt/VCeB7jXzs3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684977;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=Dt+UnGbsTawzgDyQBSVG0VcANAf9W+aVRIb3wUkBkdc=;
	b=evCP74EyhZf6TxqbL57X2jhJyWGm/Koj6IutfMCEz0qUId3Mq+ZzLQs4K43qQ9cjDCNN
	 BpGgIJaTKg7hvbljKY9YjJcsI9DaGnwbYOwAOmY6QmIb6XtZpPYOi8eTI5bhO28YVR6kK
	 J7E0hDhx6r6L2hvfQ3d2z+7HYo3rHkEL45y+ywwGSK4tFqCHaiIQSDxiZWMf+6HPcVxGl
	 AkofSpCdc0+bjAc3WaL6PzOMeksdW6Uxr194vZr1tuS3HCMOoK0jpkbpC9Iu59x/HFUDZ
	 bFYEu6lfQ8sEp6DPREvW3Y+7OadAHzwMFw3/My48leAOP6l83st7iXXNCp/F0/KILUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=i6AzlcAq;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4A606A31B;
	Thu, 22 Oct 2026 16:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=i6AzlcAq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Dt+UnGbsTawzgDyQBSVG0VcANAf9W+aVRIb3wUkBkdc=; b=i6AzlcAqFe/KxPcAScMEYp9/7s
	mlWbQLOIQsc0R3qCnzFmGvAM3mHe+uH2AaTHUX532gWJqRf28g6y61rM/ux9L0uyBpKJKfOfx67f2
	feH8kK/9bh67LckUqyUT/yvlR+MtRbTSUMfHgXr7gWfrlGmb0MyBDmDQmPBZZQFQf3Jbjb3QYYxlx
	LLYDX727dz8xm4V72USYhlDg/+YcNYykfvokvHyCaXhTri6kCVj5vKwWTjqOUnCp9kELLn2dailc+
	Mb5qmJ69eFoCLXmYMMtcRFE/GMW2U8hfvJeih9ky3DmDrRx6RN5ZIgfNvWZKDHpAZYhexfkZfVaQd
	vplsyGxA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJvFk-00000002NKm-1olF;
	Thu, 22 Oct 2026 16:02:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7AD7300F1D; Thu, 22 Oct 2026 18:02:51 +0200 (CEST)
Date: Thu, 22 Oct 2026 18:02:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	"zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
	"security@kernel.org" <security@kernel.org>,
	"maintainer:NETWORKING [GENERAL" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETWORKING [GENERAL" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: ZDI-CAN-33367: New Vulnerability Report
Message-ID: <20261022160251.GW2009045@noisy.programming.kicks-ass.net>
References: <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
 <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
 <willemdebruijn.kernel.178cac71d218b@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <willemdebruijn.kernel.178cac71d218b@gmail.com>

On Thu, Oct 22, 2026 at 11:28:49AM -0400, Willem de Bruijn wrote:
> Eric Dumazet wrote:
> > Le mer. 21 oct. 2026 à 23:47, zdi-disclosures@trendmicro.com
> > <zdi-disclosures@trendmicro.com> a écrit :
> > >
> > > ZDI-CAN-33367: Linux Kernel skbuff skb_zerocopy Improper Ownership Management Local Privilege Escalation Vulnerability
> > >
> > > -- CVSS -----------------------------------------
> > >
> > > 7.8: AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H
> > >
> > > -- ABSTRACT -------------------------------------
> > >
> > > Trend Micro's Zero Day Initiative has identified a vulnerability affecting the following products:
> > > Linux - Kernel
> > >
> > > -- VULNERABILITY DETAILS ------------------------
> > > * Version Tested:7.3-rc1
> > > * Platform Tested:debian trixie
> > >
> > 
> > I had to cut this report. Way too long, I could not see a patch in it.
> 
> Right. For future reports: please review the documentation on how to
> share such findings:
> 
> https://docs.kernel.org/process/security-bugs.html

These ZDI monkeys are clue resistent. We've pointed them at this file a
gazillion of times; they do whatever they want and ignore all feedback.
