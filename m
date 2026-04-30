Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91D26ED46;
	Thu, 30 Apr 2026 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512559; cv=none; b=h2KuEg39B7omS2QksCFWHlT9FxdGiYKEqhxMkk395+l8koABEGcmL+Nh37R//SYt6n4b0zcgb90CsZfXO52n6r2Qpb2utM40gabDu+u3B0gIkKOzRzhXFQP1RTnVqXNJiwomjtLsx6LayjUTkZJu9/vbMRThqJo4ISzNtzVgJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512559; c=relaxed/simple;
	bh=7AMc2xtDJZHbbx6E8fFOl3b0dTV0r3JCWZmEz2YDezw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hExookHPk2VucWIdCtyaRlV/rIggmqIXK2HDCdamEC2hztWBf5zNmyyU0KOxUc2YKsGvi7m732U9xolq6YOHD/66F2vuK+CjULSMHMUfv02GPAUx6P3vZzWhSooczE5gQnmQexfKFGBswyF0jXvrf5442vsOSWiyk6nzwiGhD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+thYEcL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+thYEcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C96C19425;
	Thu, 30 Apr 2026 01:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777512559;
	bh=7AMc2xtDJZHbbx6E8fFOl3b0dTV0r3JCWZmEz2YDezw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+thYEcL7OQllfsHv+cY0yB8u4ltpP5XuVjLsny8ZVjwN8/Irz//7rBQvixZSDRiQ
	 C13Ap4OyGAT9ar7euxeciGUxZf1hUWfBdakhQpTChm6f6cm3RIHv0FxKoIY+u/wIsI
	 yaRFD92HSOjHkHGs+PVfKMQTrQLrOGOu/nXg6buZOfhqwDzhvWLaSIav7EAZUZx1jF
	 95dpfFFf6HrYx2kw+vtofa71zP+so3E2AuWEfeZXCFVppogPeBW6wHTJ/RVR1qTj4M
	 d5d+h9FMf+9OKsV7JKhAknvI1uqPrJ43OqMm0GOD+uu1vJKG+XnhHr7LZ2V87Rq0aq
	 A4nH1ZFISwR/g==
Date: Wed, 29 Apr 2026 18:29:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, chester.a.unal@arinc9.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 ansuelsmth@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <20260429182917.20f96df5@kernel.org>
In-Reply-To: <52d69a5d-a951-4a65-a947-7aaf41bc3daf@lunn.ch>
References: <16efd278e4f17776ccfbf8491e5be71a4689c137.1777385305.git.daniel@makrotopia.org>
	<20260429234612.2240476-2-kuba@kernel.org>
	<afKaVQ27GUQiWZTb@makrotopia.org>
	<52d69a5d-a951-4a65-a947-7aaf41bc3daf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 02:12:47 +0200 Andrew Lunn wrote:
> > > The priv->bus pointer is initialized during probe. However,
> > > INIT_DELAYED_WORK() is only called in mt753x_setup(), which might never
> > > execute if the DSA tree remains incomplete.  
> 
> The opposite of .setup() is .teardown(). So if the delayed work is
> setup is setup() it should be cancelled in .teardown, to keeps things
> symmetric.

The code does that, but also cancels again in remove.
IDK if that's just "for good measure", or motivated by a previous AI
complaint :(

But I think your point stands, as is the driver is not symmetric,
if we want to cancel in .remove it has to init in .probe.
