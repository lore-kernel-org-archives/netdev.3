Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA248989F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860479; cv=none; b=kNdHb3/7z5VTgPkpNPKhgjbOxic/F9bBBiTQKKtcK53GvfKoe5MNOWSxYAoLPXsha0MCjIqeZRju+rPdG1OYFY/goX29u51mAmL7eQ42ntpl+BE4AY0u2JLrXrB3Iu0DAlcjAyJfsvOucYtxDV+5BBsySZteQWflbGBT3Y7C0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860479; c=relaxed/simple;
	bh=WbXsDTClhqfMLu8a1Lzh7c7V3XCanQCwYxo8J+xQhmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+4oJBdZUhZEHSL2d6Y91RRXXXXT6mm9bHHN16ZmERgTmRwouRRcd3QkRtcMyF+kEaN1ZzlF2vRCl8iNSz8KC2Nevojpm4WJYxpSZBbDUCKHmHb7VoVQSpM//DiSiCMG2+K9LUvY4ZAYc15Xsr9dZqZz0bRfAkTdHzZox+75YiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQtSwz8u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQtSwz8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790860477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETKozF7/+6XKKZfR7RUzUGQF2Hqo8nKZn7YFyCbamv4=;
	b=EQtSwz8uZUqFCyREJMNJ2ga9o6Wh+NevUyaz7GTQJsl9kEn16J1m1gBYtgAdI92j96HbhI
	QcvehQr3a6UMYii6qZDlgWB99Zgk8YdVOOTdIDT4MWB9r+oKGeF47GmWaV91IGtAJ30E9T
	X/rf+VVRLtSXpkg2jp5UBjWXpBbuY6E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-OsCdCX79OHiZKRpoMUejUQ-1; Thu,
 01 Oct 2026 09:14:30 -0400
X-MC-Unique: OsCdCX79OHiZKRpoMUejUQ-1
X-Mimecast-MFC-AGG-ID: OsCdCX79OHiZKRpoMUejUQ_1790860468
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB0F5195422C;
	Thu,  1 Oct 2026 13:14:27 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8A351956086;
	Thu,  1 Oct 2026 13:14:22 +0000 (UTC)
Date: Thu, 1 Oct 2026 15:14:19 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v4 3/4] pps: Always use ktime_get_snapshot_id() for
 pps_get_ts()
Message-ID: <ar5cq0vslvQ00Pek@localhost>
References: <20260829210041.40649-1-dwmw2@infradead.org>
 <20260829210041.40649-4-dwmw2@infradead.org>
 <920a2d70-c1ec-452b-8fc4-aebf1f6af412@enneenne.com>
 <d1af17dff1d6f181d74edd3b6358398469d61917.camel@infradead.org>
 <4afec82e-9e3d-4615-9657-7d467d8dc3e7@enneenne.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4afec82e-9e3d-4615-9657-7d467d8dc3e7@enneenne.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Sep 28, 2026 at 09:58:02AM +0200, Rodolfo Giometti wrote:
> On Sat, 2026-09-26 at 21:38 +0100, David Woodhouse wrote:
> > So yes, the specific code path you're looking at *does* get slightly
> > longer (50ns to the counter read instead of 30ns).
> [...]
> > However, they are *entirely* in the noise, as there's about 600 ns of
> > hardware and 2-4 *microseconds* of software latency before we even get
> > there.
> 
> Thanks for measuring it, and on real hardware with a real edge. That
> answers my concern: ~20 ns of constant cost against microseconds of
> latency upstream of the handler is not something PPS can see, and
> trading it for the removal of a non-constant error is the right
> trade.

FWIW, there are some polling versions of the pps-gpio driver (out of
tree), which provide much more stable measurements by trading
interrupts for higher CPU use and where this additional delay might be
visible.

-- 
Miroslav Lichvar

