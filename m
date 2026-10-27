Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793143939;
	b=1Y6kjLJY38xaBw0/Hyow70RWXMZ9AYZT88x/s8oQLtgmPQCitFtJl2KZ/S+/2GgrbL5q
	 84lBa8ReF1cvWnHiFBPllBfU2s5gjH58jxYMvha15AupZaqfF7mpTHm8jixDIs+wn0yto
	 D0czfictKzFTEca/G8pWIfdIjNkJ0Y+5suKcEK/X00qF/vfitqmidgP6kQs0b5MTpGffu
	 rVcWi6Pcs5c1wOFd4M5lbpppeW2kmkD1RjCNxOni/cL1PCMyQtV78EAzxSYvcV9tdke1E
	 82+Kiqi7KjawWdpKj0+UgVBz7n4cO8R77nhridGsPBtp0MOall/dYTUORe04oXEDEEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143939;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vng1jyeX/+O1QStYq0gfRd+yDONrZIxIhrnMlMTzf4o=;
	b=Iv8Q6x3+VCz54AJqmdcH7zoUXHgUyT/T1IM7puKo+u5Swzni70Ky2nXvLoXKUSiQBmO2
	 g65wKEMkjgMsifddHcPwy+4kHzCuzStYP2Xu19v1fSG3Yeg1ZedSt86XeWMnPZv4U5Fn0
	 K5Vn7uTaB9q4YG16AIRwh9iyO9STsXKFXi/IP3kDwxcTEjJpludZupcuzZ9XSrn2zr8H/
	 c4/EXDjNp5V6rsBslUM3kCkHNPUWx6FhHwx4qNwcjRE0VICnYCSKaHPTPtZfmhBLQfiNI
	 ca2uoiEP/6LBpzFae1qWY2EoVjA+87E1bUXjGdmF/AQiIDXjWZXLlgYlRqiMLgVP2JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oE7DS4B4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED87B606A31A;
	Tue, 27 Oct 2026 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oE7DS4B4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7D91F01825;
	Tue, 27 Oct 2026 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793143938;
	bh=Vng1jyeX/+O1QStYq0gfRd+yDONrZIxIhrnMlMTzf4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oE7DS4B4RXaYz0hynz5II3fuaphZrhWTJsyxy062ksdqtMZqjbLR1hQBRk5fkrQE0
	 uBQU9wAj/sYOynU1HDMBFjTAhmfV5sotsgQr05L+S9eeO577OtPqGrfJ/ORkyGUoL7
	 XX6J9hAIJyQNQUdBvDXk9gIl8KSHYDUt3vr8TonB7XcpQf8HaS9SliIk30GW0N+j5J
	 /wCTxUJCD4r+Qe0qLXVuGG2rUFc0S73stW709EEoI5Z/XFBfxpMLiGPqZr7yR3QnRh
	 EHRiD/kyGADgTg0cjrny7qQB4oSyOfJkdWwTVmRiDsMACfEl2a/mR22hDrsqIwFLNw
	 O4etcCqtybjfQ==
Date: Tue, 27 Oct 2026 16:32:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix
 Fietkau <nbd@openwrt.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bgmac: fix oversized RX frame check
Message-ID: <20261027163217.00729bc6@kernel.org>
In-Reply-To: <CAKxU2N-aNWtZUc0bkkc5H9mFWUn7RDti_ZzX4UHXhNyPPq3s8g@mail.gmail.com>
References: <20261023005313.3946390-1-rosenp@gmail.com>
	<179271707120.3327.4775409276963055481@kernel.org>
	<CAKxU2N-_Th-ksPst_1KR3W1nYWoZpWR2Sjfo=RWroot5A1RR8w@mail.gmail.com>
	<20261023123637.1aba3995@kernel.org>
	<bbc66ce1-8d8d-4d35-9314-98fe14082690@broadcom.com>
	<CAKxU2N-aNWtZUc0bkkc5H9mFWUn7RDti_ZzX4UHXhNyPPq3s8g@mail.gmail.com>
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

On Fri, 23 Oct 2026 13:46:54 -0700 Rosen Penev wrote:
> > > Suggested by is for suggestion of how to write the code,
> > > if Florian reported it appropriate tag is Reported-by  
> >
> > This was a suggestion, so I think it is appropriately being used here.  
> 
> So do I apply both tags?

No need for a tag, just start the commit message with "While reviewing
commit XYZ Florian spotted that..."

I think most people would assume Reported-by implies user report.
Again, the series info bot wants to basically know if this problem
has been hit in production or it's a random code inspection thing.
