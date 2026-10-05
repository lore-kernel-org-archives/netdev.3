Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7215432E80
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191783; cv=none; b=fQxpQmED1H1oA0jWP21QSi5Sd/tHWGVM9hiCrqgV9bHu9bF58s26JcCj2494ZGpApsGBNf6jsAS1x+Zn7/lZ90l1Nez5j5/MAfc6cC25YIzT587QNUzRzZwfn8m7jfG8p+PQVTzLgoJ0WUYv/2lw5q1QtBoEU7HggzokldQrq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191783; c=relaxed/simple;
	bh=FUq2avO84bfZ8GLcZBSlMUyLjO/Hl+O/IAjRjhroQVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlSYJ6m+ZIwnLpaC6BjgzulLc49Fb3VQwwdr+mv6TBCJJCjw1+tLyYgP4bTnKnVSJ9PgHawKBsp+rs7zAU4YrB5qQgiZGDN02agD3E7kmvW9ll1oldalqnFB3k99U2xVJ4cWLu/UTV0/ObL8hTrRgitnalnLm0S7Bppi2VZ+e0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hl05/ip2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hl05/ip2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791191780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6HHcmnZcnfCWuCdH1gD5szgvgpTuYMt7kmo657pMZ8=;
	b=Hl05/ip23PD3Eyd0WiPHz5QAlA9bFcI6RYJirAurJZMe4/n34E4S/ZMgByV6kwiMvhV4lD
	ESmlrH/IhwNRKA5GYKXDVeUac6yuLo7ju8y7NTxS84KF6wh6Htmky5wOWQsluLzbP594U1
	F9q72O66zsl/8m0LXCT3qZiGC0B74qY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-34jTgZb_NjiYcFOEievRZg-1; Mon,
 05 Oct 2026 05:16:15 -0400
X-MC-Unique: 34jTgZb_NjiYcFOEievRZg-1
X-Mimecast-MFC-AGG-ID: 34jTgZb_NjiYcFOEievRZg_1791191773
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34D53192D0EE;
	Mon,  5 Oct 2026 09:16:13 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9F2730000E4;
	Mon,  5 Oct 2026 09:16:08 +0000 (UTC)
Date: Mon, 5 Oct 2026 11:16:06 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
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
Message-ID: <asNq1o8TmdNdG45T@localhost>
References: <20260829210041.40649-1-dwmw2@infradead.org>
 <20260829210041.40649-4-dwmw2@infradead.org>
 <920a2d70-c1ec-452b-8fc4-aebf1f6af412@enneenne.com>
 <d1af17dff1d6f181d74edd3b6358398469d61917.camel@infradead.org>
 <4afec82e-9e3d-4615-9657-7d467d8dc3e7@enneenne.com>
 <ar5cq0vslvQ00Pek@localhost>
 <b567acf8-c3e3-4b51-99a8-058ab42f3026@enneenne.com>
 <24e8134b35cc8be26606d7472295cdb43ea6b38a.camel@infradead.org>
 <777d19602ed1868abbd3d3ef3a4e78a8688d4a17.camel@infradead.org>
 <dd7a873caecab6c912e2c0f910d1e46818ea455d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd7a873caecab6c912e2c0f910d1e46818ea455d.camel@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Oct 02, 2026 at 02:44:41PM +0100, David Woodhouse wrote:
>   ┌──────────────────────────────┬─────┬──────┬──────┬──────┬─────┐
>   │ capture method               │ p50 │  p95 │  p99 │  max │   σ │
>   ├──────────────────────────────┼─────┼──────┼──────┼──────┼─────┤
>   │ pps-gpio (IRQ)               │  84 │ 1206 │ 4013 │ 4889 │ 688 │
>   │ polling, stamp after edge    │ 206 │  536 │  665 │ 1106 │ 286 │
>   │ polling, bracketed counter   │ 206 │  545 │  647 │  811 │ 286 │
>   │ polling, bracketed, raw MMIO │ 135 │  359 │  434 │  564 │ 188 │
>   │ entry.S counter capture      │  46 │  109 │  135 │  206 │  58 │
>   └──────────────────────────────┴─────┴──────┴──────┴──────┴─────┘

The time to read the GPIO heavily depends on the HW. On the MIPS
ar71xx where I was using the polling driver, it was 85 nanoseconds
(the precision logged by the driver when loaded).

> (NB: We should be careful not to forget the common-mode hardware
> latency which could be different for the IRQ paths vs. the polling
> paths. On my list is a test where one CPU polls while the other takes
> the interrupt, so we can compare on the *same* pulse.)

Yes, that is the main advantage of the polling driver that it avoids
all those delays before the actual read of the clock.

Both pps-gpio and pps-gpio-poll can echo the input PPS signal back to
a different GPIO pin, so you could measure how the delays differ with
the two drivers on a scope.

-- 
Miroslav Lichvar

