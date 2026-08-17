Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FC3DB31B
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958600; cv=none; b=p2JXu0faotGdEyXfxKyumEA9YoHiddKYsYvj4HkQK62aCGYwdu3ksBagFIGoXlRJj3jm5II4tcFDVOn9OViduccxdcbRGSlaXpsKBOdmoDfR+91Qm3o7qwtI0FIZgZd9IEioIH6tjawCJ79uHuRgPKD0fD+ho1vOoWA4KL58HGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958600; c=relaxed/simple;
	bh=i0E1ibmDg1XOvfuk1jxSBGsN1ogPXb4dKpd91jgeXNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ9l4fBZQUks0398VYc17DA4f3u+lVIc8oOJSK2oD4g53pEDwnh4qNjf7pMrwi8GWo4s69iOoYECaYjzrjlN1SWVOkvhF0mbnD83MpZ0dkVXEUtIIQNyVDA1YnGRwd6AaxTu4Ni/GT6HcUG4EOo6OZCh8WSV8RA+tVJaSoUVCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ABVvC7BI; arc=none smtp.client-ip=91.218.175.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ABVvC7BI"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i0E1ibmDg1XOvfuk1jxSBGsN1ogPXb4dKpd91jgeXNQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786958595; v=1; x=1787563395;
 b=ABVvC7BItTSLqe2zioqKjow/TlHM1tsnDFaqRLUYYnKN4BED/hIdfTKz8l6AWqqr+lpGiJne
 moJhmUA4D8CeuBgnu8q0xrEeqE4j0NWvTQ/Q3NkMd6Y8f17RigzhH1bjgURpUSkS2x1GmNN4R2g
 kmeoWBAma8sXRf26Yy0NXB+8=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (216.236.36.150)
	by smtp.migadu.com with ESMTPS id 0c8b4a16ad25c4a7;
	Mon, 17 Aug 2026 09:23:15 +0000
X-Migadu-Flow: FLOW_OUT
Date: Mon, 17 Aug 2026 17:23:03 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH 2/2] bonding: 3ad: use RCU_INIT_POINTER for rcu pointer
 initialization
Message-ID: <aoLS968kX0QQH0KT@fedora>
References: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn>
 <20260817-bond_rcu-v1-2-acf067cf45fe@kylinos.cn>
 <CANn89iLyiyRM4K4GnjuukdDhOWFiWWjuS5aVbP-u8iPqPxZtEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLyiyRM4K4GnjuukdDhOWFiWWjuS5aVbP-u8iPqPxZtEg@mail.gmail.com>

On Mon, Aug 17, 2026 at 10:37:56AM +0200, Eric Dumazet wrote:
> On Mon, Aug 17, 2026 at 10:33 AM Hangbin Liu <hangbin.liu@linux.dev> wrote:
> >
> > From: Hangbin Liu <liuhangbin@kylinos.cn>
> >
> > Use RCU_INIT_POINTER() for initializing port->aggregator to NULL.
> >
> > Fixes: c4f050ce06c5 ("bonding: 3ad: implement proper RCU rules for port->aggregator")
> > Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> > ---
> >  drivers/net/bonding/bond_3ad.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> > index 196830fca4a4..c4dfcafcff26 100644
> > --- a/drivers/net/bonding/bond_3ad.c
> > +++ b/drivers/net/bonding/bond_3ad.c
> > @@ -2075,7 +2075,7 @@ static void ad_initialize_port(struct port *port, const struct bond_params *bond
> >                 port->sm_mux_state = 0;
> >                 port->sm_mux_timer_counter = 0;
> >                 port->sm_tx_state = 0;
> > -               port->aggregator = NULL;
> > +               RCU_INIT_POINTER(port->aggregator, NULL);
> >                 port->next_port_in_aggregator = NULL;
> >                 port->transaction_id = 0;
> >
> 
> This is a NOP really, the object is not visible yet.

OH, I see. Sorry for bothering you.

Hangbin
