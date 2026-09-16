Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DA4E4311;
	Wed, 16 Sep 2026 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593027; cv=none; b=PFp7q7jkPpB4ZESuuToZsi6/Z7cB9p98fEbCZqM2OWRof5H6HTpT3SjMdDu/DPfyaROaSqiHGdebeJxFqE+30k7iMBwe7s30SYraZyyz7O9u1oRgORyVSTaRHm+6TsGkvPBwikmEYQvPbl1iWtmp+EqBoMbR70F6MXOuh42UVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593027; c=relaxed/simple;
	bh=kYpVtdkg8cAtKLdV1NbmNN71YBsyBjjGaUWFTNIEnsU=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=WnFQUDwr0LbZJloP8GxCrB6MLRjYMpIQEv8PAoRIoDZopBDPNmFhUlapGA5amVFDlrtH9UWME3IX+JbK5hwZUzCVqOvWmzbK0MOsiISzsGAoThVX1jdJ1kLofscHhYMd0Eb5BsGPbI1fyym/jlJG/07xQrFCSaWTlFK7rUWKXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=PWg3eJ8p; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="PWg3eJ8p"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id E43A91202B5;
	Wed, 16 Sep 2026 18:10:00 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789593001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYpVtdkg8cAtKLdV1NbmNN71YBsyBjjGaUWFTNIEnsU=;
	b=PWg3eJ8p4ZhY/KkYJeUyO+cZjc5OXkP+kxmovCFGixQh0zI3eaCEeVjZ4DKGVJXAUrP0hG
	YkpViqArcELpyA1nJ59JndKUELqtS5ZV/Om/7aXvlNXc5WZoBN7fabgBxemBnN2DpLi150
	dOGYwTOJLCVySn8wLA/nMgEzWJ+WpJRnJh+6j9XbXJaEwWey6qLV6WIc3c8vJ6gpRU37TO
	RoLs9WMKCj87qsf43zhkELmgkmFz417OFkn7x9t6Ymopr+o2DXGCRb3TK+vMkSXfFJYgtO
	GDZ8X6TQZtnVamVE7F+XnOgVfrvbWD551+U7Td9SviO0j5odVGq7brH8FK4gXw==
Received: from 186-210-028-117.xd-dynamic.algarnetsuper.com.br
 ([186.210.28.117])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Wed, 16 Sep 2026 18:10:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 16 Sep 2026 18:10:00 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] r8169: propagate errors from PHY write
 operations
In-Reply-To: <f4e563a9-5c25-4026-853f-5d5d30f5a0d9@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-2-matheus.aalmeida@inf.ufrgs.br>
 <f4e563a9-5c25-4026-853f-5d5d30f5a0d9@lunn.ch>
Message-ID: <02943cee3bbe56fafe76a98eeb78c682@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

> Maybe rewrite rtl_loop_wait_low(), _high() and rtl_loop_wait() to use
> iopoll.h?

While I don’t think this fits the scope of this series, I’d be willing
to look into it as a follow-up.

Matheus Alves de Almeida
