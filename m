Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C938550C;
	Mon, 24 Aug 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596309; cv=none; b=u8UFnHktuy6q0j9blbvfHw5sFFWNPGzL703Obkb8x3+OLBErYrz2koj8AS9GbWILrKXU2o2amf7wF5mP6WCdn3HuoH+c+TJG/Vv7TQfDxhLqjblytgeeCwqY77dHTzFrUcdVZY1xbx/Vsa+oPH/e4FnOLta8VGI5O/gl+W3jt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596309; c=relaxed/simple;
	bh=v4IsN/BJXPhkiVoZZi2xCJAcobFJjfXoum61NQT+dXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLdpYr7U/ZUqQNo9gizDwM/VArtF2zbzG0sBRAAn/gNXkjxvYnO7bNIRqA1Q2TQ4eJe136KRkoQsry1K5xD79myHUL3hVoJ8N3kCfL9YFiN2mbKTZPH6JqNtsxVlPKhFKKr3e7+buCWdhH+1a9PfZlkZQsxynMbtZKag6hgAPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWC2TdHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWC2TdHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271051F000E9;
	Mon, 24 Aug 2026 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787596308;
	bh=f/f29suQth/CE8UfOcofJmZGYPBna+j7PMRGgn2AyVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JWC2TdHM6G52+OGvc+ag52U1afO1XuQ6l21ci5jJkP2c0luB0PfwkFX50c0QV+OIa
	 6yxEwCFpCv8s5xYkIe/YFhpr0WHQbJbLWav1UhpayD5eNRWzPQAsq35EY5Ie5QDYYh
	 pg4WMLVzQWk8Rny/PdqcNVI+c8QCicVSBZiX2k1Nr07OL1v+DhxGCUvApwisba8+Wb
	 qMAPHwwVL1VNZodfMIkucQl0wWKlIIVjmf2gLqbPI5slgEXK7o6+JrTD8p/X+rlkxx
	 lDmrdP9h063l6/F1gT/+oNU+9qB1Fj+mZiKy1QluvT0/NX7tE5lVYRn27deMAJozEY
	 Hq0FcRs8k7RXw==
Date: Mon, 24 Aug 2026 11:31:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <sumang@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
 Anshumali Gaur <agaur@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: fix out-of-bounds read setting MSI-X
 irq affinity
Message-ID: <20260824113147.1c035de4@kernel.org>
In-Reply-To: <20260820055451.2642358-1-rkannoth@marvell.com>
References: <20260820055451.2642358-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 11:24:51 +0530 Ratheesh Kannoth wrote:
> rvu_register_interrupts() walks every MSI-X vector and uses strstr()
> to match "Mbox" or "FLR" in irq_name before pinning those interrupts
> to CPU 0. irq_name is a per-vector NAME_SIZE buffer, but not every
> slot is populated before this loop runs. strstr() keeps scanning until
> it finds a NUL terminator, so an uninitialized slot can trigger a KASAN
> slab-out-of-bounds read at boot when debug options are enabled.
> 
> Use strnstr() with NAME_SIZE to bound the search within each vector's
> name buffer.

String search for this sort of type tracking in C is a.. brave choice :/
But whatever..
