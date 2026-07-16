Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F09262FF8;
	Thu, 16 Jul 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784230827; cv=none; b=Ra2Q9TNvEE/DFDwAxxSPseRz2/ATfzV+gyUsqTPi3KWVCV2lLK/FMuNfsqJK27kIgaC5Qmz1KWNpF8uFHObM3uyvmYD/JOZ3l5CGxLBDR7KFmFvj2pqJIKIqRIPtozPajRtFoaTj4Z172u8IVq69Euq6JuSoMHq5P/ksBm5S9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784230827; c=relaxed/simple;
	bh=h8tCisL37SbTGl/agHqI8C4Vl1ypbicpc2HoKbCpdL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3Q35m5exzdfqQ8o98hVywl54cO/fInxsBRWukxvLHTbLNOAeVqE52o4zS6NVIuu8R7YpWvJxT5iWF/1VQdzjvapum39WR167F3/DCdbwLRujWnGNKS4MaHmlFSko38ylBn3X73o4+szs1iAXIaBNTbzoJG8OJPfXdIGdyD2cTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tvpM8x8o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tvpM8x8o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5aKj+8ztHJIyDHGV4TNdDd1WtqpYH3yao4ZfLkyC0Hc=; b=tv
	pM8x8owbETQ4dy6YLxAk2Ye9TRfiEI69n2xysFHqsnwDzCqws5e9pouYZdguUuZZzckX8r5stMHQA
	VeNZxXiC4fJQ8lql8CAPc4YSp5a6vZ+egE9Ya1Ciqniz8C6xscKe3KuaDQg1ZLYcwG80c6rHcXfA0
	s2d9F8pfsOwzvOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkRwH-00CcsQ-Pb; Thu, 16 Jul 2026 21:40:09 +0200
Date: Thu, 16 Jul 2026 21:40:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 net-next] net: rnpgbe: Delete a null pointer check in
 rnpgbe_rm_adapter()
Message-ID: <2d60fe2b-06cf-4c35-98a0-fc0f8034180b@lunn.ch>
References: <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aleFN4Z2XT3NP3od@monoceros>
 <85ad473e-b2f5-4458-8973-a643f90eda5e@web.de>
 <alikx3W3NX7r9o99@stanley.mountain>
 <95abcefe-2211-4abb-9af2-7e8d7f4a9b76@web.de>
 <062f9181-e494-4576-bedb-36de488c11ca@lunn.ch>
 <aljdzTZ_f5v6ckVg@stanley.mountain>
 <d70814de-30b3-4315-9455-db58477ab085@lunn.ch>
 <a4fe0527-6302-45dc-b4be-40282c2673b6@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4fe0527-6302-45dc-b4be-40282c2673b6@web.de>

On Thu, Jul 16, 2026 at 07:26:21PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 16 Jul 2026 19:15:06 +0200
> 
> The check for the pointer “mucse” was finally identified as undesirable.

I'm not sure finally is appropriate. It was one of the first questions
i asked. Also, i expect anybody looking at a Coccinelle report to take
the time to understand the code and decide what the correct fix is. We
have too many developers doing the minimum to make the tool happy,
without actually thinking.

Please also include the reasoning behind this. The commit message is
all about "Why?" Why is it undesirable?

And lastly, please always start a new thread for a new version of the
patch.

    Andrew

---
pw-bot: cr
