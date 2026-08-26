Received: from sender-op-o18.zoho.eu (sender-op-o18.zoho.eu [136.143.169.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357030C146
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758443; cv=pass; b=Uef2bNYopB6ur32f9mZDDqIHh7ICg76qcZNYNp4fy25hPLkGFlzlmwoKuyFC49NlXJZkVP9BFhbEeeHMbpi0Z/S5yffh5ga6SVOuUhmT8VAwbRfEPwUJW8X7eLDjZYGElATqB9qwGUF4Z5Ny0e0sVQtwrrAtBIrC/4J1nVF7Y2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758443; c=relaxed/simple;
	bh=Ibhw6671lus/3uUGJQdaxZuzi3Gwryr6ruKVK2ZUt6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDrQMFjQUgdQFp6yM8r/MvoJttxZpnGtzpzlRsi3tJBwKLdmJ9p+3GoxW322B6ouolrpkEeC+MON3VTQa5E9cKtrizhyHYhHmwUFdb4nh39T3CMCOmv/IGIK73B3/AbOHao/SezW6t9a+Z34FhtfXUEvlWfMGR0ffpEbaNjB42w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl; spf=pass smtp.mailfrom=kempniu.pl; dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b=DBsJTfYm; arc=pass smtp.client-ip=136.143.169.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kempniu.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kempniu.pl header.i=kernel@kempniu.pl header.b="DBsJTfYm"
ARC-Seal: i=1; a=rsa-sha256; t=1787757482; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WeqOtexwCOjxzpqm5u5TL4MUFoffrA65FkKIBT/9UKCNYkiaZ0mWaJMHLcd4OPQpaDbYs5yBWmEteHRwHUAYijZ6sLFC0ca181fMr9Cp/Evh8WP64LkbMdrksr+R8T1lZoA2RSOHyyohh4wDliT1JsfB0mcf+k7YsOj1BpvOsvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787757482; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r5GKdwopX+iDG66Z+g9cC2ObUXNcJjvNT1PQjIgQXbA=; 
	b=U62E0MZPZXKcd6I2vGDSSfk9hCP2/jOufi1Qt2MkeJPod46avHHt0iDDdE3JC6kCiRJoVHtvbh/uFgjOL9tlyawqxYlKU8yguP1ZYgrSfSyDic/+1RZNWpQJ6YoNdhlGLZznmnB+ogbY32ycW+u/LPdpWG80LAnFCwcScqTRHIA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=kempniu.pl;
	spf=pass  smtp.mailfrom=kernel@kempniu.pl;
	dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787757482;
	s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=r5GKdwopX+iDG66Z+g9cC2ObUXNcJjvNT1PQjIgQXbA=;
	b=DBsJTfYmx/YUE2yTPKbQQ7i1WD6bjl9RFd4C0cUbqQkZJ4f+d/pcMkFhGEhoT+qk
	f5pllgyeeN2eZOQLIwgW2a6eEX9KmQT513RBAvIikUrQyqI/Y2XIEz+mcEMDgve3LII
	8rOkJ70StzQ9TWfxkXCbpVlDuBz+wvJSDuNbB/TQ=
Received: by mx.zoho.eu with SMTPS id 1787757481610908.9381020255304;
	Wed, 26 Aug 2026 17:18:01 +0200 (CEST)
Date: Wed, 26 Aug 2026 17:18:00 +0200
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
Message-ID: <ao8DqOFZJkln4pvh@larwa.hq.kempniu.pl>
References: <20260810061612.23745-1-kernel@kempniu.pl>
 <6a79d7fa.ebbd881c.2cd61f.2e0d@mx.google.com>
 <anw5dJ0EqBJtAqRU@larwa.hq.kempniu.pl>
 <6a7c3b3e.e9cff95d.4a93a.554d@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a7c3b3e.e9cff95d.4a93a.554d@mx.google.com>
X-ZM-MESSAGEID: 1787750107721015900
X-ZM-MESSAGEID: 1787750157005007600
X-ZM-MESSAGEID: 1787750417884007600
X-ZohoMail-Sender: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
X-ZM-MESSAGEID: 1787756654266007500
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.11.1.5.2/287.740.18
X-ZohoMailClient: External

Christian, Andrew,

Here is what I managed to determine for the QCA8327 switch on the board
I have access to.

> One bug that was there was that when PBUS was used to access single port
> PHY register (instead of direct MDIO) the link up/down was broken. My
> theory was that the Switch chip had some latch logic that was only
> triggered with MDIO. Using PBUS didn't trigger such thing.
> 
> Could be that the QCA 8327 switch also have some kind of HW bug where specific
> register needs to go with MDIO or some refresh/latch logic are not
> correctly triggered.

My problem sounds similar.  The exact symptom I am observing is that at
a random point in time after switch setup, PHY register reads performed
via mgmt Ethernet frames start returning all zeros.  The mgmt Ethernet
transactions themselves are completed correctly, they just return all
zeros in the data part.  When the issue is triggered, _all_ subsequent
PHY register reads performed via mgmt Ethernet frames for the affected
PHY return all zeros, i.e. it never recovers.

The problem is triggered on distinct PHYs one by one, in a seemingly
random order; I did not identify any patterns.  Given enough time, all
PHYs eventually start returning all zeros for all of their register
reads.

At one point, I tweaked qca8k_internal_mdio_read() so that when a PHY
register read fails in this specific way, it is immediately retried over
MDIO.  Those fallback reads over MDIO also returned all zeros.

No timeouts are occurring for mgmt Ethernet frames.  I instrumented all
wait_for_completion_timeout() call sites in qca8k-8xxx.c and have yet to
see any of them log a timeout (or any other error, for that matter).  In
other words, all requests sent via mgmt Ethernet frames are responded to
by the switch in a timely manner, so I have no reason to believe that
the retry logic is involved here in any way.

All of this reproducibly happens on a device that does not even have any
Ethernet cables connected to it.

Manually probing registers 2 and 3 on the external MDIO bus reveals no
other devices except the expected five switch PHYs.

I used tcpdump to capture the traffic going through the DSA conduit
device, from the moment the switch is configured until the failure
occurs.  I found nothing suspicious: the last PHY register read before
the failed one happens about a second earlier and the sequence of mgmt
Ethernet frames sent and received for the last _successful_ read is a
1:1 match against the first _failing_ read, sans the sequence numbers.
No other traffic is interleaved, which is expected given that both the
external MDIO bus mutex and the mgmt Ethernet mutex are held throughout
each distinct PHY management transaction.

Given the above, I am out of ideas for something to latch on to for
further investigations.  It seems that over time, using mgmt Ethernet
for PHY access on this board makes the hardware transition into some
broken state that it cannot recover from.  As I am able to reliably
trigger this problem, I am open to ideas for further experiments that
could possibly shed some light on this.

> An idea might be to limit the mgmt to vlan and fdb and see if the problem
> is still there. (after all those are the path where mgmt would benefit due
> to the multiple register access required)

Indeed, it seems that the simplest workaround for this glitch is to move
the PHY nodes in the DTS file from the ethernet-switch node to its
parent, the mdio node, and use phy-handle for ethernet-ports to
configure qca8k in "external MDIO" mode.  That way, the external MDIO
bus is used for PHY management while mgmt Ethernet is still used for MIB
access and switch configuration, which seems to be stable; with PHY
management moved to MDIO, I ran "ethtool -S <iface>" in a loop for a few
hours and everything still seemingly worked fine.  This seems to be a
cleaner workaround than tweaking the driver code, so I don't plan to
submit any further patches in this spirit.

Thank you for your guidance.  If you have any ideas for further
experiments in this area, I am all ears.

-- 
Best regards,
Michał Kępień
