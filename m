Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15E931280D;
	Fri,  3 Jul 2026 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783115780; cv=none; b=di4S34C74YbZfKQ/7Pw8Jt9pGsiCjCgIP/zRZQz7uGYzeajsRwjDh/59d8ijMhZu2dwl4pWajVwGNWijDuXbJuY38040tNx9wx52mF0zIxhRQZDcT36l5w+KaYw2nqED+RtR+KAHAUeNGCKyPJplhmRdEuhozIQfa1Ee3GdVgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783115780; c=relaxed/simple;
	bh=oKYULkFKh20p+I4wjXU18tvkl4UsUklIU5NzNIAPRwA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gyDIngUWnb9QNlqe1gnFMRnNnd1+gr/70RkNQy6RuCaJynNu5ZYaW8YBaoHeJhqkbMYD9+FYZ2iiJIdVT2Sboht/uQueggjXEX9jkVYwvXRZ0vNsO47dWfWj6UaLos4Nw/+2nyS+9SFKVVgWAyP+aDs8KrxFLbBBPwSzEEypaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=r0ZGHQIx; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="r0ZGHQIx"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 2C924600A8;
	Fri,  3 Jul 2026 17:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783115776; bh=oKYULkFKh20p+I4wjXU18tvkl4UsUklIU5NzNIAPRwA=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=r0ZGHQIx8su5qZHIaS4fHnIiliPfb3WqYKUIOAKdL24+z5wCPtz7b/kLLz5MgG47j
	 Dk9qLLNPvAfgaqLnkA6pBypFtdPxoC12w/UmAfv1OXHaLIoYV3c0I53r3NlDMBAK+j
	 iGospvnILRJvIn/x2Lo8Lw3POxStbqGFooUVoohd5+hymIDhT/3zPUnyKI/lqj0i+g
	 sK6i86kW9QCm0g8P1IgY3ULUfEjfwjDVE3HIObDM7UEZmHR4UXeL3tklx8NbH9EJwD
	 YN01VQs32+rFoTlid80nki8FhTbQfwiUjc3gQrWuHNoU3Ll0BaaC6PhdbaJTbtlWnA
	 HpBsEgqGp936g==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: use direct ATU hash on
 88E6141/6341
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <8c2fd5d8-6b64-41d1-9dd4-bb1db687b844@lunn.ch>
Date: Sat, 4 Jul 2026 07:55:59 +1000
Cc: Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D67E57B3-26AC-475D-ABDD-B85AC190DB8C@padl.com>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
 <20260703-mv88e6x41-fixes-v1-2-fbd3a1bf8965@padl.com>
 <9eea72a5-b30d-4543-ac97-179743d99950@lunn.ch>
 <81F61D3E-D9EB-4646-A401-9C34BAF0903D@padl.com>
 <8c2fd5d8-6b64-41d1-9dd4-bb1db687b844@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On 4 Jul 2026, at 7:43=E2=80=AFam, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>> No documentation, just my experience, which is why I asked in the
>> cover for others to test. I can include test results with the next
>> revision.
>=20
> Not so much the test results, but the test case.
>=20
> The reason i added the devlink option was because the network
> contained only devices from one vendor. So the OUI in the MAC
> addresses was the same, the usable number of bits in the MAC address
> being cut in half, in the best case. As a result, there was a lot of
> hash collisions. For this special case network, the test mode hash was
> better.
>=20
> If you are also seeing a lot of collisions, it makes me wounder what
> your distribution of MAC addresses is.

Well, a bunch of unicast addresses along with MAAP for AVB.

But what triggered it was multiple FIDs (VLAN-aware bridge), which =
wouldn=E2=80=99t have been visible without the first patch to configure =
the ATU FID register correctly.

Luke=
