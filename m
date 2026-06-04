Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F53264E9;
	Thu,  4 Jun 2026 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612537; cv=none; b=Slh2+V39zzD6dXIaVj8dHfjxDb6LwqOEZJWnZpo056WqqQmNkw7GSuQH9JMwS4p7Im2guPwaEKbyZdfU3ezUSCX1TzJezqk7BqJ0j5bp9GTNdMnlQpK343XdXudVRjy3xI/SnOaPE7X2Hrnv8+9J7SY7bLe1Ku5I6suglCXbrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612537; c=relaxed/simple;
	bh=ciZzg09MAAvt+vyghwNT92rYo/+tPywPbXDM8F4zh5U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E06f95InlAGiPFU2czKi+oBFqchfRIxE82QayooH9V4oVwEjADNziml4ZDsgVx/k79mzrvl3XhKK3RqGMQc8jKz7zNmQPBcSbGSB4hVnGzDdcmEdbDNJb+19rf0kykGw7hpVtfcvf1qtlfcBphXGJewNRh2X/U3cd7Mci+dXe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=glT+AJxW; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="glT+AJxW"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 2035D60C6D;
	Thu,  4 Jun 2026 18:35:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780612535; bh=sH+qURpHn4C/SMC8gzzMSu1/+Xp+M0GnEEang0MI7Xs=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=glT+AJxWwpTy5Pb05ULm22g738tIgNUNEDcflmpD0NGTfLJFYmxogXhN7g7WqfWdM
	 77PYRiqKaJ35POEAnPXhAse7uuw9yCweoSUi0+eYDe6kh+UQHeo5uStIpsEd60FGxF
	 wUthPRhGhB1CN7cgVFB8RLScsHEJ97yK5N0h0FR7+5hDBPTHAw8SoN+Obf5rIIqIPG
	 qHiWp/kgINlpkoU3nAHi9D1SoBDyqTMjbdViWHpn1LeosEzX3VqKBtivgE2t+DvTQt
	 V3tLUev9Hg05LfsPzM69GRxq4McG5iGMqQKlJM55sRoFreroxtVoxNZUUf0cRANC9I
	 2pqPDY/QFTL0A==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v6 1/2] net: dsa: mv88e6xxx: use the hw tx queues
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260604-net-next-mv88e6xxx-cbs-v6-1-b68c01142d1e@luminex.be>
Date: Fri, 5 Jun 2026 08:35:21 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D247F38C-8606-4648-8EB9-EFB42772B0EA@padl.com>
References: <20260604-net-next-mv88e6xxx-cbs-v6-0-b68c01142d1e@luminex.be>
 <20260604-net-next-mv88e6xxx-cbs-v6-1-b68c01142d1e@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)



> On 4 Jun 2026, at 11:44=E2=80=AFpm, Cedric Jehasse via B4 Relay =
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
> ---
> drivers/net/dsa/mv88e6xxx/chip.c | 35 =
+++++++++++++++++++++++++++++++++++
> drivers/net/dsa/mv88e6xxx/chip.h |  1 +
> net/dsa/tag_dsa.c                | 11 ++++++++++-
> 3 files changed, 46 insertions(+), 1 deletion(-)

Reviewed-by: Luke Howard <lukeh@padl.com>

