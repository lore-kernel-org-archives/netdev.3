Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626174;
	b=eN+XouTqckePV+ieNc9DEcBKFn57suLdSXHpS6GPhWBwAWIn8zJATyFUkBIMuGnPbd0J
	 uO1Gl97+qYvQFWuB+D3a/py5DRWc8EuJScmSk8A1VxXngd6D0B/UoBQhA3Nmq+LrDQd+t
	 sM0moZPRM4oAQ7fAa8AhhJ/56/SyMYtQBC0SDJrlmiAf28WUOqrqn1QyJengsP4GyDM7g
	 +h/0PphFcjDlZkf1Vv1fDcVo71nju5DdTHPFVtGgiJnC0F2UXYGm8A8U1lhDNirh6JDPp
	 qXukdFtqoCVKNFgEYkHq4nPJPjesy7ybxlkhlXn/sXgy/qt+H1yLLc348v0pFwnDg1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626174;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IVvzOsH+NuIpRX0xCb+EAFZpqLlQeknfi/yGTtV63pM=;
	b=0f+70m4RHGa1QPZcBgKlVsiMIQWDAA1oYpkbn2bCIB5RDRpszOU1pV98rDLowRF2qALG
	 Dqi7Nmj0fPfGytttyCIBqbncqTJiSJjaogsVjeVR8VoE1p/MMYoZKf17eTDF6z6Akqa98
	 uly1IOp/5OwYHw9pzKAfXvUSovF8YKqS4imA9CquiM0jNwUXlxdmhMI9xLHQXP5/k0St+
	 Z+s9TVybQdCjKYrS5p67NL4yqyZMZl34aMY+E0qpZzJG3Wnw0QECV8BdPyP+TjR0qAoXx
	 ANcvZ3b0BsQg8krSJeQRzq3D5JbrXN32ZIiLdiEBKqmns0q9PqA45662Apl+VcPsDww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDEAtidG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C60606A8A8;
	Sat, 14 Nov 2026 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDEAtidG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6501F000C4;
	Sat, 14 Nov 2026 03:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794626174;
	bh=IVvzOsH+NuIpRX0xCb+EAFZpqLlQeknfi/yGTtV63pM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KDEAtidGANQE2bawgshd5c1etBu2f/RPRNDpOv6P3ZX7VtwYd+MP9/PhJJvFo4Pe+
	 j7rPhGzH/VqaZiK0i1kT12fS2qCgyhReVZXlfspRh8JmjMgvYuvPiDOekNPY3U55fl
	 v2SIJP6zAufcjJFlFlOyaaChOrEgYziXkcfKrQfgclIsM+GzrV+NRFST9wwHMt69Kz
	 19t8kqDtJs6vuOKbuDKBY5g76UxsMGguaAv9fBuh5Tm2alY2WxhTnps3TmIQzQg1QQ
	 3efYP/MV/6LMSewVBV/45Q9rsBWXtmPSQ7xjtFHGXCtWUGYtZSbZctrU90OQ1dwVXJ
	 w5nvbztBg7avw==
Date: Fri, 13 Nov 2026 19:16:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 <UNGLinuxDriver@microchip.com>, "Richard Cochran"
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Jens Emil Schulz
 =?UTF-8?B?w5hzdGVyZ2FhcmQ=?= <jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next v2 1/9] net: sparx5/lan969x: stop the FDMA
 channels properly
Message-ID: <20261113191613.59e240da@kernel.org>
In-Reply-To: <20261111-sparx5-mtu-change-v2-1-59c91357e8f6@microchip.com>
References: <20261111-sparx5-mtu-change-v2-0-59c91357e8f6@microchip.com>
	<20261111-sparx5-mtu-change-v2-1-59c91357e8f6@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 15:31:11 +0100 Daniel Machon wrote:
> Fixes: 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA functionality")

Please drop the Fixes tags when you repost, either it's a fix needed in
net or it doesn't deserve a Fixes tag either.
