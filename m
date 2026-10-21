Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552115;
	b=WJ7Z4vJv7tXJ//gJNJIN5lQmGkck9PoTfeo5+8nUbEJ8NXllUj8kxLzYf9sbIdFn3H2l
	 5sm2ZL9lL6OUDvlsfeicw7nKfK88qP9EcULl55voXfSiahy/K5sIJAHgc59FfHVxFzfUd
	 nrC2jAOR8PNFnyxSOuF68sAHiUG+kzkgs+gVrsCwyEvY8HedM+gWHCUw4XpNeAEG5iKYA
	 QAoamMwL4OmszFsvOth+bGJUbGk18E4cXZ+gmXaB/rv5Sh0NRGAEFm6FWx9PXgGx20MfI
	 1hz9EQ6SaDArAW4cYpQnYwu344s99FKj/4V/i84vqZ6oQD2U1nXk9aQ0IJU7GMMlPKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552115;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=epy6/F0NIRa9Le1grp5HLEJMWouwe9tDqPES5+OPtlE=;
	b=3IdecQNdhFK1rS+/wuTcKSUJKaq/RdvAAtNOM1nyhMpkB8JXk/qA+jlUFAD/37iZgErj
	 5Ld7xDhK/HmBD4KHCOnKZHqAi/MVy+wFDXBS0dqvJpNcS4L78zcIGPrr4WctWN8dgsX0Q
	 ZBPWHecAQxDMdt3GPLs7IlB0Br3Yz25ljENxlEjKdEaBd37s6iyMBGTOIyKCuDDA9R86B
	 NPG/aOeEe9Izd3aBc7+q+BUl1iuAxLiuZ7tUAv5FvP6U99dK8UmxjbC82E99kzxKy3Wgt
	 aYoe40ORBVKEDzwwCV3LNhSpcG2+VGL+GEEXkSZ8pUHm+BRrICPUCrUixgOUXcsJ5Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrJ5cOM3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119F606A319;
	Wed, 21 Oct 2026 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrJ5cOM3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424381F000C9;
	Wed, 21 Oct 2026 03:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792552114;
	bh=epy6/F0NIRa9Le1grp5HLEJMWouwe9tDqPES5+OPtlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CrJ5cOM3sBUQ3CEpaJB0S4hcFmhymytsdXPci8+Pd6EQPfJHxMZ35KOMzSbgibbUB
	 6vQsVEE/glo4/Dalv/4QOIBmCiT18qBZsy2GXtesOyI8eqCyTLZVZFkPrxNtt6ZcnO
	 eW4XbH9YubWw3VpPDWvl76vIQgciLKb98O7w435C0Ju0Er3EBFwEVHPg2zOkTV+9Tl
	 6Asypq6CqBqUyItnaxRJ63Fh30jkvgsyjlBPkCgbOvEcSmp2KpaFzmE9jH9uG4jLPY
	 hIK6i4iZLBPV1kp3ksDsgZmHxI6pj/ife1NBiU0kO58zPEQv38K7iyIVV3kYEjdEBC
	 LpYa8Tp3k409g==
Date: Tue, 20 Oct 2026 20:08:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolai Buchwitz
 <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 3/3] net: macb: distribute evenly Tx SRAM
 segments
Message-ID: <20261020200833.601ddd3e@kernel.org>
In-Reply-To: <20261016-macb-set-channels-v5-3-90ce0c0b8e75@bootlin.com>
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
	<20261016-macb-set-channels-v5-3-90ce0c0b8e75@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 18:58:17 +0200 Th=C3=A9o Lebrun wrote:
> Subject: [PATCH net-next v5 3/3] net: macb: distribute evenly Tx SRAM seg=
ments

Does this really belong in the tree ? LLM can generate such test=20
on the fly. Side problem that it doesnt  build cleanly, reportedly
