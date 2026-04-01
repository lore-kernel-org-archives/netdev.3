Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455362517AF;
	Wed,  1 Apr 2026 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046360; cv=none; b=ri/bSBw1TXUOUiCVsLBHpYWmIulCgp5va/pX/1qEj68mc5yGN4RR2XAFQ8ScjD1vnM2tuIvcy378wnvAki1xGgu8uX8y3ghfeYpo3XljJB7kJb74bt6kJie4hefBxc+llQlu2gKNAezus4Yj1oz19c15QV3evW5bTYihyItcxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046360; c=relaxed/simple;
	bh=VpLmSktzfVQzCiZWt8KgkGlxHf+eDe5ACmT2XVWIfpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aufQQr0ZJDtStmtZ/CnWACQwhqqKMwTBMU2Yh9zuNiBzcMse55j/8rKAX2afaiLxvjy+ZkO+wev/rWFGfdT87+eORkSV7o0+jTfTEal7NpdfkbXkk3sLldTy0DoHZEVxTpvnYkeNYXf9vtX08eLwkMKGqX/2pSCH4s1uaUT2bxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=GK0pB+np; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="GK0pB+np"
Received: from localhost (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id C46E140737A8;
	Wed,  1 Apr 2026 12:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C46E140737A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775046349;
	bh=kjbmHOYNPdjWQqtIIqSCC0ouY/w5LYFYyqsodL/XAZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GK0pB+npyko2kR2HRFnphk8B25MDH8xxhKmy61PV8LAO7xZyOvHpsbGuUwcumqlKK
	 AgOGMWFDUcuXQH1oJCWU+z7KLa351pJWdFP35A+y4CvnVQh7eycfNWUqSaHSe2kuyY
	 0699eQqa4dPw9WKnZSK2r2Z5xza7DEx7GMskEta4=
Date: Wed, 1 Apr 2026 15:25:49 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Agalakov Daniil <ade@amicon.ru>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, lvc-project@linuxtesting.org, 
	Roman Razov <rrv@amicon.ru>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniil Iskhakov <dish@amicon.ru>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 0/2] e1000/e1000e: limit endianness
 conversion to boundary words
Message-ID: <20260401152405-43e821d5458d9b8b8ea8cd5b-pchelkin@ispras>
References: <20260325151615.1407182-1-ade@amicon.ru>
 <20260401120919.282668-1-ade@amicon.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401120919.282668-1-ade@amicon.ru>

On Wed, 01. Apr 15:08, Agalakov Daniil wrote:
> This series refactors the EEPROM write logic in e1000 and e1000e drivers
> to avoid processing uninitialized memory. Instead of looping over the
> entire buffer, we now only perform endianness conversion on the boundary
> words that were actually read from the hardware.
> 
> Patch 1: e1000: limit endianness conversion to boundary words
> Patch 2: e1000e: limit endianness conversion to boundary words
> ---

Daniil, for future submissions, please post new versions of the patches
in a separate email-thread, not In-Reply-To.

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review
https://docs.kernel.org/process/maintainer-netdev.html#changes-requested
