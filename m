Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6537F30D;
	Fri, 24 Jul 2026 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937130; cv=none; b=YONSjgoTYL0xdlRrewsl+NUBo1aix9jlV5hOC69LMDE7x+zfTju+kogBJqEp1n4wasORt6ht84tvz2zDOSlnlTPnWjtvVQrhabxRY5lL5TJUImC3D2/aK22CZEfwLfIrspO781ZAJ8PdpWvxqUYmR/TYaLr6+Bvm6gG+wvWvCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937130; c=relaxed/simple;
	bh=SvGhOeCkqnjvQfFibL59BeVPITh92fj34Y2UIHkWGNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omO+E5qMP7Po7X7W4JCGiEVlS8rtHw1Pt0/JkUq0Ri+dS+BfGYVqGfXCKYRnfYQg9ycbkL+Q6zuLfA3ySCaIlJgn/Fi8Y0YUNtkzYysQKjlhfKe/+BtXMXp7aHD5EVdr3aKOWPISfyV4+nrn1/gYDtheHeeHpYq5jcWXYZVBmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9hJL3l9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9hJL3l9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6C01F000E9;
	Fri, 24 Jul 2026 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784937128;
	bh=SvGhOeCkqnjvQfFibL59BeVPITh92fj34Y2UIHkWGNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D9hJL3l9lCsjKbFaQSvqQFZHgQfsn8qh4dQH0UCtFy2chfpWCRz0xH8AEaOlBJryV
	 XXO1pw5FQi74y8mh/AwoCcuIFnn2cpt8KCG3QeBGRY1LL6VsDXxGCkIg4Ubta5qOBw
	 rRQqs4odUafBuyubnh0YZnf0O2P15GrPjLKVW4SWHNnHnyuz+L1Ghenm5LelzhC/G3
	 7osIVshM8JWGGHweWShwySWFxY/3OgY5niNtNDr7dvG5bJXkdky/iseOGHlIVXJI1z
	 K9J4nuKidzOascGTbQnoWopKatS1iPnL0fGo5CZbgHnlvahMvLc8RqpKo8V8wL74XD
	 pPcq26Dtmv//Q==
Date: Fri, 24 Jul 2026 16:52:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>, Richard
 Cochran <richardcochran@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Gregory
 CLEMENT <gregory.clement@bootlin.com>, Cedric Jehasse
 <cedric.jehasse@gmail.com>, Kieran Tyrrell <kieran@sienda.com>, Max
 Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, Christoph
 Mellauner <christoph.mellauner@joyned.at>, Simon Gapp
 <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] net: dsa: mv88e6xxx: various hwstamp
 fixes
Message-ID: <20260724165207.6a03c9db@kernel.org>
In-Reply-To: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
References: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2026 15:30:52 +1000 Luke Howard wrote:
> Three fixes for improving the reliably of hardware timestamp acquisition
> on Marvell switches. In our tests this eliminated missed timestamps in
> ptp4l, whilst also preserving PTP event and general message ordering on
> switches that support embedded timestamps.

Do you know if there's any precedent in the existing upstream drivers
for overriding the reserved bytes? It's not normal for devices to modify
the ingress frames. Perhaps there's some precedent, but if not I think
we should gate this (eg with a devlink param?)

Andrew, do you have any opinion? Or perhaps Richard?

> Note: squashing the two embedded timestamp patches into a single commit
> may be desirable.

I think it would be great to invert the order. Revamp the locking as
patch 2 then add the new feature as patch 3.
