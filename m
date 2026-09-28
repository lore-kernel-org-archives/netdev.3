Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E2495AF4;
	Mon, 28 Sep 2026 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593435; cv=none; b=QsL6KDRG1nsg225siygbgqEOlsLUXLBuM8wDpZsJnDoM9kqN2mit1NstM454H1pVD0Ct8uL4iyLTgWfj+ezBm1q0fjND3ENS/xOJkcxlwNDjZ4jNotpLLLbu3iYAV9YJeJw9DnNlujEPeQ3clj8XJ8QsB9Nh+vQsuftj4P2yzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593435; c=relaxed/simple;
	bh=dZRSeZGAsRnNcfAuWqwTs0cWz6f0hmafT4JlC9kKg1Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qLY2+MxmcYMR5gDr74CF2z9SWaEKYcprDhqA0mmwCOfOCQH54Ip43vEb5bAAFD3OCTwpQOjT+nTeznvRBbFuig/pK+dKh47iu6h12RaJ+jILDeMXeU5Hr2YKzNWTeKeDlzHAvWnBhLoPgyxsBHEeoyOGyHFm/Z07uPSMx6sewvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ST0dURxR; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ST0dURxR"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78412A4AC6;
	Mon, 28 Sep 2026 13:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790593430; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eiEg+Nmgr3Lqt5U3+L4ENw62xINmaUQYmdOmsd64KRw=;
	b=ST0dURxRJxwpLfEmNkZud9JRki2XQqw+alxS1C+Bqn6R4x2bLAC3A06tCQmdlXTSa1hoiT
	4nQoTqwiFOOI6FIS3N3O7yGXGwnbWMEBRf5t0NIplPjkr40eKWTj6O+lWYxJlEF9uGne3q
	PvQicZdXDUGOPSbvQPUwPD7+t1bsiGP+xmjKIIgL2eu3x5q0OF0MM2IcTGTuPpSRvngCgF
	mG5hcyrpAmYubV31M2V0s7d9VCZwUw1IdQiwxlG93i/Qb0GeSHGZOfku5cFpf61tWOCi4I
	3/ssFonD2iZ3M/KrGHXHsfXf5JQ3Ei6lvJ2SMeq7u/X971JAVRE5LBH/NQnK5Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 13:03:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sinfo@kernel.org
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Justin Chen <justin.chen@broadcom.com>, Florian
 Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: fix NULL dereference in set_coalesce
 before first open
In-Reply-To: <179059317562.31693.7518349114735075126@kernel.org>
References: <20260928105642.856210-1-nb@tipi-net.de>
 <179059317562.31693.7518349114735075126@kernel.org>
Message-ID: <88bd8a24fc0f3b44cf87a35fcb82620c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 28.9.2026 12:59, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

It was observed on a Raspberry Pi CM4, but should apply to all other
genet devices ...

> [...]
