Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060E34C134;
	Fri,  3 Jul 2026 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783114111; cv=none; b=d5PmoRyRD7KR9LM0T4pS4b3NsJVhj5OM8YHybUvTuHkprfIy5iJkX8G1wJIFyAaHZD3kVo4CVH10xD4VVzi/MVKpPeDaKlkTaApkWnbTpl9FlF/P72xd0iCWfzit7BuTeLHQPwuSwS6FsBsb4vXnOl4M5MVgIDWNidvD4Ttv9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783114111; c=relaxed/simple;
	bh=T5TK7U2rYahxhqyZRO/CkT8pjn/d7Carz9u08al5Tn0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lMuVM8tosT7CnBxjIeYdYmshtr8uISrW5MzrC4QjE2dMq32lHe9Aamrm9qqxBlhlaIvwQTMZzlFVacQSifA6ZOXQqmH5hcr6RRmg4BpujDWP0tBXgnNY7oHYNjTj6qPu38Kk8jgS6fQaV5v2jev0AX+U1GHJKFWgar24MQtO0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=y5VlQNAN; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="y5VlQNAN"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 2CBDA60C04;
	Fri,  3 Jul 2026 17:28:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783114108; bh=T5TK7U2rYahxhqyZRO/CkT8pjn/d7Carz9u08al5Tn0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=y5VlQNANHBaMoN55QkyW6Y0vDP2v0TQUkQczEhc5ljjNBhkwcfWMDT/jY0bYilVdL
	 /8TkIiggbLzDKaVFIW2BADia7dvoB1jQmIHhwZzA73Su759Oq0hm5sAFQDzPXS8Z83
	 HFXzIReaspBJ8STrRZfNfCPxpVQgzDABGKwPbK3GE3AKBGbOE9rke9qnPv4NFVOj6G
	 mvGTMbrN9wE1khyqTR25tbhcPTcwdpqxydK62xxL0XmTEWTKSXDezj+pBHQIGaIbSN
	 Z3iHE1VRDTJGnUNDjUV8kBuDFz2DohuO3WMH2ZoLqmVyeiOMlRUfWadUMiZpmRYRUY
	 3sOCoJ9QQbkCA==
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
In-Reply-To: <9eea72a5-b30d-4543-ac97-179743d99950@lunn.ch>
Date: Sat, 4 Jul 2026 07:28:12 +1000
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
Message-Id: <81F61D3E-D9EB-4646-A401-9C34BAF0903D@padl.com>
References: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
 <20260703-mv88e6x41-fixes-v1-2-fbd3a1bf8965@padl.com>
 <9eea72a5-b30d-4543-ac97-179743d99950@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On 4 Jul 2026, at 1:40=E2=80=AFam, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> On Fri, Jul 03, 2026 at 04:42:56PM +1000, Luke Howard wrote:
>> The default 88E6341/88E6141 ATU hash algorithm appears to result
>> in frequent collisions, evicting permanent registrations (including
>> the broadcast address) out of the ATU.
>=20
> Is there any documentation about how the 88E6341/88E6141 hashing
> algorithm is different to all the other chips? How is it special?

No documentation, just my experience, which is why I asked in the cover =
for others to test. I can include test results with the next revision.

>> have a performance impact (the data sheet notes this is for testing
>> only), but it also enables correctness, at least in local testing.
>=20
> How do you define correctness? Are you using a well defined test?
>=20
> Why is the devlink parameter not sufficient.

Devlink would indeed be better, but changing hash mode with a non-empty =
ATU causes it to be corrupt on read back. Perhaps the right solution is =
to flus the ATU when changing hash mode via devlink.

Luke=
