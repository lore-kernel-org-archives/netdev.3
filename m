Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21033122D
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105270; cv=none; b=uQfJjCP2tHU595nePmkt40TGCNNRSaoWlRtfGrR97s5oy1SKk95h8HUOIKB/4plBifmsEO3EYx5TiCRcEAzHnoGl7dSkKJK42C8RWmatCjUc/WD1hWNrxQzzCdsW4IOoQrJ6CQt2bOdX0z7qAydB94Uj87vQHiwgRro9SGB89Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105270; c=relaxed/simple;
	bh=2wBI18RKi3tgHsjZdoHPQfO8F4AFN52wOJmPd2Jn1/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPiJ/rv2Dk7ZQv9ZNh+KGov70OybTH/AkkauxFaRkbAsn3f5wZaT2r2xVrhieyYSn22YEnQnsOdm44enadKgOa5KO4cHHKqs7Pb+cnKzCEQO4uTtsGuu/Mzc9yvxRCD+vupMsFttZOvrxYME7S5bOtATSjYfS6xGv9tzcS6cQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBWpsopu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBWpsopu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973DE1F00893;
	Wed, 10 Jun 2026 15:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105268;
	bh=0YzqKqBQZ6GdTYQ2FA2Itp612d/HKEe3kIR9LcefOHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RBWpsopu/1aiO+SWVVukY9WlYkHZJHybuCqJFKnjm7q6WaScXq4dE2/Mik+h5v/ps
	 Q5PO1zeEdJ8ciquQqpnf28Srtfs6jN6FbN250CDfQk4A5AYjR1r/dhEnlM/AvATgyx
	 C7NOQ413hhzplrMBUSPiZlP+rUqPadxDC3qJxomyaI1tBdXZQbLEUrsxo3EmTsM3yT
	 Fo4wrfQ93A1yz3IaOgTVf1B1RYqqME7CdsTsh5/VijR71cmA4lpMurDSjjlKUpUxy5
	 XRzZ+Qye7RLvs5V6GoeS+gOzGBQrpKtcB4uSsWD/49BFNZUmAWIZ1zffumpr+CrMZI
	 hufMKLSckKEWA==
Date: Wed, 10 Jun 2026 08:27:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marco Baffo <marco@mandelbit.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org, Sabrina
 Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive
 timeouts
Message-ID: <20260610082747.462dbf62@kernel.org>
In-Reply-To: <1932179615.53655.1781104032870@app.mailbox.org>
References: <20260608150741.3320919-1-antonio@openvpn.net>
	<20260608150741.3320919-7-antonio@openvpn.net>
	<20260609194246.23c66818@kernel.org>
	<1290464191.15539.1781081055969@app.mailbox.org>
	<20260610073111.6273e17a@kernel.org>
	<1932179615.53655.1781104032870@app.mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 17:07:12 +0200 (CEST) Marco Baffo wrote:
> > On Wed, 10 Jun 2026 10:44:15 +0200 (CEST) Marco Baffo wrote:  
> > > ktime_get_boottime() is like ktime_get() but it does not stop when suspended.  
> > 
> > Worrying about keepalive timeout when system is suspended seems
> > quite silly, did some AI tool suggest this? Anyway, if you want
> > to keep this code please improve the commit message.  
> 
> Yes, it was suggested by Sashiko but it does not seems like a bad
> idea to me anyway, but please tell me if i'm missing something.
> Regarding the commit message i would be happy to improve it but it
> looks good to me, do you have any suggestion?

You can do it, I believe in you.
