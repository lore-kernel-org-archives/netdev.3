Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A23B894B;
	Tue,  2 Jun 2026 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442471; cv=none; b=FYI5FFBUjljsLk9NbWr6VijDmS4hXkz899zjuLzQ9rX3M9frfQh2b6ZEsCA+vaFc4cpR7SPoibDdOcc2p/Vrl8oMHNOsNe2wqCF7fERJRb0jmdPvnk9zmzl24j1K1a9kxHxCXzoP9LyaFYNmYFn+cHuDIa1kScN1nzsRgvovp5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442471; c=relaxed/simple;
	bh=/4wkig+i37D4I6hBlvhPPcOyoK0ca+a8S5VAN8B+d/k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kb3gsyTd/H2lRTxJS7kWxNfYczloB96E2wQMs6GeQLiNDS3QRlDEDojLxbKCSkIT25zv6zpCr/VFPvAZEyK5bDSDYmHVQuQtFZHlTJQHrtstbUg5Tt0TJYSdz8EJVUbLdfA5t9Gxb/I3kjgC23sm8bv8yMFeSG//VFuFFEj767Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=q2ki37i2; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="q2ki37i2"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 652NKpdQ005672
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 00:20:53 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 652NKpdQ005672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780442457; bh=/4wkig+i37D4I6hBlvhPPcOyoK0ca+a8S5VAN8B+d/k=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=q2ki37i22tHRAdUQooFU1AV7mrlPs5De0+FuiqPeg5oTI/uhNoAsOZoZlsUbtAeFR
	 nULEy/DX3OTsJbr6Y755B8E60kceNcchXzbQZbt3i6/TPpb68s44B1OsoqGA1rVKpa
	 scAuBZ1qSrgyFvLaCeWZ0EAw31ElnsL6OQcP1C69vB2ASN713Ms8xqWJp/sxIb/pdY
	 8aa2f8SFhjZt+pGrzFhulL03M6qPplGVKfnbG+bbP42EioIYZj/vzodloZX2zhQkCU
	 3VVwJ7H9V3vXTsTACfDmM1Q1AIxmFBDntOszLXaLuEMhGFHCIjnja6TXCnfeoT5Gg4
	 hIdJxkv6O3ekg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v5 1/2] net: dsa: mv88e6xxx: use the hw tx queues
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260602-net-next-mv88e6xxx-cbs-v5-1-1969758d1fa3@luminex.be>
Date: Wed, 3 Jun 2026 09:20:40 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD706AF2-256A-44C2-BA96-30BAB98E76C2@padl.com>
References: <20260602-net-next-mv88e6xxx-cbs-v5-0-1969758d1fa3@luminex.be>
 <20260602-net-next-mv88e6xxx-cbs-v5-1-1969758d1fa3@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)



> On 2 Jun 2026, at 7:10=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>=20
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
>=20
> When transmitting fill in the PRI field in the dsa tag to select the
> egress queue is sent to.
> =46rom the datasheets i've looked at these switches have 4 or 8 =
transmit
> queues per port.
> Note: skbs with skb->fw_offload_fwd_mark set use the DSA_CMD_FORWARD
> tag. These are processed as normal ingress frames, meaning the queue
> they end up in can still be altered by other switch config. eg. =
priority
> overrides, tcam policies.
> This isn't done for vlan tagged frames because this would overwrite =
the
> PCP value in the vlan tag (The PRI field in the dsa
> tag is used as the PCP value in the vlan tag).
>=20
> Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>

Reviewed-by: Luke Howard <lukeh@padl.com>

