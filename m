Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444247ECD3
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246043; cv=none; b=BXKm0nkEu/6z3MkNJT6WztV32lfGVCIOAl2DItrJIdBRGd69uli3ldbYLrvT5Bb1/Yx5bMgTzVKQ4q+uB+bzhQ6MqNFTZ7lZIMRS5cqmaEGrUmvfBgOUDvDuAEZysYVsYLdOyP9tLNCeUOh+CdbW4G5lxe3DHVjadIT9s4PYmw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246043; c=relaxed/simple;
	bh=t6s9zBdQp2Ag68AY5f4i8jrR4ZT7mcoSebMHfLG5Llk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kLU4XgIuOVyn14pO2Sb6o+jU3xal5t5glMA/fPBbHMTFnUaKvd5nvra5RIM5wBZCXdoF/x/rTTZCmojp2dZfWN/FFnwdQJuwmfX9LsnU6Ys4srbZmcb2N4083BhALxq6YMyKm3QONgQk/GrS5ayZkufO4Meyr/U0HZMrN5CNVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OvxVax1H; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OvxVax1H"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 33B8D4E41303;
	Thu, 20 Aug 2026 17:13:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E0E4C5FF59;
	Thu, 20 Aug 2026 17:13:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC5E911C76583;
	Thu, 20 Aug 2026 19:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787246034; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t6s9zBdQp2Ag68AY5f4i8jrR4ZT7mcoSebMHfLG5Llk=;
	b=OvxVax1HY4ZTrQHtZ7tKeJGwWgSmSD349pnvHrqU42kMqT+Ry1pigqAAmZMZKWUpVk5pvl
	de4VcwL5kWL/11yxcRGVXmWwZgPb+TOiErXNT/2Ycx5zpDZvOSW7coXFckKeqTIbhBSum6
	EVetODlgigNCcfma5+sJgFl7V17F/wUxBXEOiB/UlhzCXIQh7accXv9UAKxSvi16Q5p+Zk
	W8nAWbaPA+H7Klj+xmMg6YVfzKEB/UiBe2K6E74THDiUzS0uTi1Iu/9ZxBJue8kpylQ5xb
	07MZyyGkTvvWAibgKZXEjgoTMcJtm3vUH6zy/QGQT04OeUO088VpxWfRsjGMNg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 19:13:51 +0200
Message-Id: <DKTXUC0GECDD.23NVLEICC8OXB@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: fix CONFIG_OF=n build
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
To: "Zhixing Chen" <running910@gmail.com>, "Nicolai Buchwitz"
 <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260819040913.109367-1-running910@gmail.com>
 <e84bc7b95374bbe76234bd56e819ba5b@tipi-net.de>
 <CAMyuFdX_qGq5E8TfuAuXtgy9AwLTwegmvMNXYSmjLXgOd5rhRg@mail.gmail.com>
In-Reply-To: <CAMyuFdX_qGq5E8TfuAuXtgy9AwLTwegmvMNXYSmjLXgOd5rhRg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Zhixing,

On Wed Aug 19, 2026 at 9:44 AM CEST, Zhixing Chen wrote:
>> On 19.8.2026 06:09, Zhixing Chen wrote:
>> > macb_alloc_tieoff() and macb_free_tieoff() are called from macb_probe(=
)
>>
>> Nathan sent the same patch a few hours earlier [1]. I will follow up
>> there.
>
> Thanks for the pointer.
>
> I missed Nathan's earlier patch before sending mine. Please disregard my
> patch.

I sent a patch which I prefer over the move-functions-around proposal.
Goal being to avoid reproducing the same issue a second time. I forgot
CCing, sorry.

https://lore.kernel.org/netdev/20260820-macb-fix-x86-v1-1-b2e7c902104e@boot=
lin.com/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

