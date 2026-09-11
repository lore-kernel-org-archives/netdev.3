Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A93E559B;
	Fri, 11 Sep 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169630; cv=none; b=IT2CaIY8Dzn8kkk3okZPJ7ewO9j5RP9XgjhQsfNgVVo1AyhC4kUVYdMA7ZfNzcSJrIpj99TUucO9ff6zNpOY+p1QSuqgh10JASa11eYX5Cnk1k8KbTWQCpEind5qXOci8nYE6wBWNGgIEBhSflXuGYnQpgV/BHcarD08xiCMP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169630; c=relaxed/simple;
	bh=MSPRi5LPGRatMZE06AgWTDa/3BLYDw6nznSRgCXsDYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAfy2YlEt4KVB24dUOlBHAoOO9exCHq1qtIuJ6nYocX9zhQh4yp0RVz1FjLkbSKYq8UQ5pItd6x+6hH00koJquZi8b7qPYOuT9IJh7aCVNtVJHcg1JDZ7399dQR6eC8vg2k61si7AxArA4oo8mrGCtQUEpWki/vDc9tQmrNnIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3v/ylxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3v/ylxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930A91F000FF;
	Fri, 11 Sep 2026 23:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789169629;
	bh=Zc0yaMzBORhlcdAryqbANRe9WowMzC+qKnvwl2m5wRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M3v/ylxk47CIy9WUmEQov3pzX30z3xsZZqDPnwD9i59IQa4QXn2FQRTSOPEsFnpMZ
	 H1JL2KGb1GzOOBMb54VtqwLSCeO1Pw7qQdDTJU4+ajNWdp7A7zBYAY28ushm/5wnbs
	 Zw8tFgWd6zjTiIz6uicDRn/U+9sVYTHEBCYSofkdi/L3m0JIq6yLZDT++Im/q8AJCu
	 b4VZbPKkQWT8Clvsc0IaxSQxFphyo7owp+DVJoKoT5t4kbzpIiRAcsUXosnYULLNzB
	 vTMGF8VIAsM6Jlgm0Ymn5rhQ1kJdx6Y4ocl5mwsb7GJWNTFbFVl9NP6pX76KLxGCSn
	 Cbf3HjH85t7rA==
Date: Fri, 11 Sep 2026 16:33:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/10] net: dsa: microchip: add periodic
 output support for the KSZ8463
Message-ID: <20260911163348.5e2a6c20@kernel.org>
In-Reply-To: <e2ecdd7e-80dd-4540-a316-0718d05cb367@bootlin.com>
References: <20260908-ksz-perout-v3-10-6722a3f1ca75@bootlin.com>
	<178903621782.219967.1067616730052651942@kernel.org>
	<e2ecdd7e-80dd-4540-a316-0718d05cb367@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 09:23:06 +0200 Bastien Curutchet wrote:
> This is an already existing bug. It made me realize that I forgot to 
> send the fix ..
> 
> The fix conflicts with this series. I can either send the fix now, wait 
> for it to enter net-next and then send a new iteration of this series; 
> or send the fix once this series has been merged. I checked the other 
> Sashiko comments, and IMHO, this comment is the only one that is really 
> relevant.
> 
> What do you prefer ?

Let's get the fix in and then repost this set after the net -> net-next
merge. Conflicts require manual work for a bunch of people, they are
best avoided.
