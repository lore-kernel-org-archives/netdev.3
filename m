Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376FB67E;
	Wed, 19 Aug 2026 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107027; cv=none; b=t50DVufOVmMzArYp+N+nzFB24Y9OZ3X/lQZ3pX7TaSnYI6Gr9pwl4xzlgh+2DEtS3aZE8vQ5pn1hDLn8Ed0HCWJtX3g2KoOTP4GUqzFhIh8TUOksKp7mxcVnUIGMN8jNXd7IsXRVjuNC0PzYw8nNKrnkvEJw9jz7vamUmoMNw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107027; c=relaxed/simple;
	bh=ioSCGn1GCZxglUKDbJbOLvbfN0b5LKknO2fwCvzWSAQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n20TTm3uuPCNe6ZWqXlHoSHWg0GxIyfANg1Ulh9uSHND6XHBxGr0xX0lhkCcUK7ZlWVPctQ6+BTwzDJRnLEbZKAuz7PgAqeYrSa0CxMcEJndNubepnajbSPTAfyOp+1UM3MyaZLCkM88f2I9Q/G4p+3+95m5VU60qpGUdCuKJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=06EJIGyf; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="06EJIGyf"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 948F360C21;
	Tue, 18 Aug 2026 22:28:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1787106540; bh=ioSCGn1GCZxglUKDbJbOLvbfN0b5LKknO2fwCvzWSAQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=06EJIGyfm2rECpSms+xu2NOEdBeOMuRiMbtzZbFlO7QAYzx2Pd+sLV2Z63vBkb2YG
	 Mb+do4fIrtOlWLVj57ONCloxt/GceOlmvRfCWCOyyqT0ZWfNExbxPSBaGx3vjng+oe
	 nwMpDA61QokYsNRqD2fIt58aEBGaw+I94dE8x6tALHFYRFO4L4OenSnYgEeGgCpKwV
	 g7BnBn6RlRI3Fi5zip7Irr0w0TS+CqLYqSWYUwXMT3v3sApn8OujLwNcwSQt+pWQL+
	 aktynMw9TAeW8EMyqywFp6XJjKbrIy576PIHjEYiISHSWfa/n/7QVjITsIuh8Xhp79
	 aJ+MnLJEw9B4A==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH net-next v8 2/3] net: dsa: mv88e6xxx: use the hw tx queues
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260818074508.26e626b4@kernel.org>
Date: Wed, 19 Aug 2026 12:28:43 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>,
 cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8649652E-63D7-476C-946B-D5A4E1D52A60@padl.com>
References: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
 <20260811-net-next-mv88e6xxx-cbs-v8-2-10d0baab2905@luminex.be>
 <20260817105024.65be6d55@kernel.org>
 <hgrxt3hlj6i7rcg7jxgyxzrxw6knk2eqykpiq7lgpu3zshprqq@ranq77v7pxbv>
 <20260818074508.26e626b4@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)



> On 19 Aug 2026, at 12:45=E2=80=AFam, Jakub Kicinski <kuba@kernel.org> =
wrote:
>=20
> On Tue, 18 Aug 2026 10:59:35 +0200 Cedric Jehasse wrote:
>>> Pretending that a DSA device has multiple Tx queues _from the stack_
>>> makes no sense. You should be offloading PRIO as the root qdisc,
>>> like mlxsw does. Then the rate limiters should be attached as =
children
>>> of PRIO. =20
>>=20
>> This patch follows what the implementation i found in other dsa =
drivers.
>> mlxsw seems to be the only driver handling TC_SETUP_QDISC_PRIO.
>> Wouldn't that mean setting up cbs for a mv88e6xxx switch would use =
different
>> tc commands than setting it up for another dsa switch (prio vs =
mqprio)?
>> Is your comment specific to this driver, or for dsa drivers in =
general?
>=20
> Maybe Vladimir can comment why he picked mqprio. He probably explained
> it to me and I forgot.
>=20
> My mental model is that mqprio offload is for the host ("NIC", IOW =
host
> traffic egress). But if you're configuring a switch where most of the
> traffic is internally forwarded within the ASIC. We should have a way
> to report stats and offload status. There's no need to pretend we have
> multiple host queues and waste memory.

MQPRIO can be implemented for mv88e6xxx, but it=E2=80=99s not a perfect =
fit, which is why I withdrew the patch [1].

[1] =
https://github.com/PADL/linux/commit/ecf7d2fe28d7a9459551dd28e96da06681446=
604=
