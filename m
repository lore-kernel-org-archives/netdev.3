Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8D24A2E32
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105269; cv=none; b=eTbHuZzcfXEmwQqxAWie2trqEokdayxaCSTIK9Eik9pXtEXhqqOoYQMCel6oVi+UlkEnvGxMCNyuTGLSSAU8il7hwSBEr6rq1rjfRyFkg8tyKVx6vQIGUyXEXReEugHV3mtsxqLiCXBVLwia5AI69A+Au7TmFMIG+lvjcuc5NQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105269; c=relaxed/simple;
	bh=uvBnHy552IQoM71uHW58RtnJVBBlbl/lza+o7JxRrY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=E86fwbDl15yoGFpPiagu0L8/oNOR582JFG17N1p1yD3lhMkNR8o0zqOONzNr9/wug6nJQ3wKHEetL9attalGbzgB34qwAo9wBpP3o/81m0UecbNwICWpvN3Un7KdGnCtto/SmBbj7CLv+fCO1vKrwBYJhwURib+XOq2CDvQwNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UBfz0KIT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UBfz0KIT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 486934E4102F;
	Tue, 22 Sep 2026 19:27:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C5CF60580;
	Tue, 22 Sep 2026 19:27:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 830C7103293A3;
	Tue, 22 Sep 2026 21:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790105260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uvBnHy552IQoM71uHW58RtnJVBBlbl/lza+o7JxRrY0=;
	b=UBfz0KITD/1RHENlPGAkMPvqI+aoihOYMXo6zpYy6DZWXdpaN8Ste+AK9ys5R19L2Iklke
	GAy8l4CueoweUb1VuZcrdB+4ViEwdhJVE1l2+DnP11fi91eG7HBWwUtzO9rUBWSt8JF6uA
	kvhJ7HnxfGn3m67zJlV5/b72tFNRAfcnzd6xLCEwXFku5BR5MV2bikkoP9a3qvQCB/vIcZ
	IOe894tdu9rZu6IvdWJc+BnAmsF72YbLx+1h6YhYtBbqG/agq74986aZKl4+2ctnHBhR4K
	ofJEvXnfoPgSj+EcnzGnqa4dfOt86LZMkx3VQ0NU71YS+qDg6H39bUihpl0gpA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 21:27:30 +0200
Message-Id: <DLM3CNDZHKHA.1ATQW7HR63M3J@bootlin.com>
Subject: Re: [PATCH net-next 4/4] net: macb: Clear SRTSM outside PTPv2
 receive filters
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>, <linux-kernel@vger.kernel.org>
To: <5mghybrid@khu.ac.kr>, <netdev@vger.kernel.org>, "Rafal Ozieblo"
 <rafalo@cadence.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260922-codex-macb-hwtstamp-submit-v1-0-9d1abaa53296@khu.ac.kr> <20260922-codex-macb-hwtstamp-submit-v1-4-9d1abaa53296@khu.ac.kr>
In-Reply-To: <20260922-codex-macb-hwtstamp-submit-v1-4-9d1abaa53296@khu.ac.kr>
X-Last-TLS-Session-Version: TLSv1.3

Hello Kim,

On Tue Sep 22, 2026 at 11:10 AM CEST, Kim Wooseok via B4 Relay wrote:
> From: Kim Wooseok <5mghybrid@khu.ac.kr>
>
> A PTPv2 receive filter sets NCR.SRTSM, but switching to NONE, ALL or a
> PTPv1 filter leaves it set. As a result, selecting the same filter can
> produce a different register setting depending on whether PTPv2 was
> used before.
>
> Update SRTSM whenever the RX filter changes, setting it only for PTPv2.
> Switching away from PTPv2 then clears the old setting, so the bit follows
> the currently selected filter.
>
> Assisted-by: GPT-6 Astra
> Signed-off-by: Kim Wooseok <5mghybrid@khu.ac.kr>

This one sounds more relevant to keep (compared to patch 3). We have
NCFGR.DRFCS always set so the FCS is always discarded so I don't think
we fix any bug here. But we avoid a footgun that could hit later if we
add Rx FCS support.

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

