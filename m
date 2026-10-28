Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201777;
	b=FdHK77hPwWRk+cxKblHB3DDLYIEG8H95DsoyQdvZQcFc+65mIGUHbYiMGVDPL4J3ZqAS
	 7vrt0a6g3CLieUJTZruOQmXDhhC2mer7xUY3/yAGiUIUpYgrpox7OnvlxVaXf2HRHH1ox
	 vibyBJ5JCsllxOTFEBVEB9FHmu3jQZr3C9j/8Sgsm4yzsHV93434m1E3IodB2fQJPftfQ
	 LehNxwAfK7Kq29m29glBvXJfXjrjZnR9N+fi6o9SoQ9DhHF5hdZo2PTCdmVowidWXpY7l
	 IoFyF5A/qLu8L2+KgpAulLYbv/PeKh97NOkvBlyibIfSlREJEf0MxffJlmsrIg1L3Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201777;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID;
	bh=eY++VNuzwvLIwcN1yG+EZ5uXg8LcA0wFXof77NTrhS8=;
	b=bguJdQLMKCGK3NpdNu4mQn6u+IPNfBlR+OzLET69S6AKl13XLDfxmAByE8f3BsJUEUO9
	 kFRk/7xm2swgGgHpcwVWG6pcKMP815zZ7Bo1D8deNBPjGJKEDhdB5qFRoYlUHTeeWRsxv
	 ePqTxenAxdsg/j+xLw2zmSgwk8uxQOc4ruiXIDBqZC1ogmlNgNoF3xOQohIgs82gcZKjH
	 ndcYrQaGzye/B1DIp/yrFvd9UNTzjergPwxonHIcoZVXEGy7KBR7fPO0QG5xZp5spDqLX
	 JLwfZk7zKEenaHU7DBxmNiteLD8xnWuK7pjmbRnv4Q6mltpWFfT81BGhW2rm0kYUZJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=well-founded.dev;
	spf=pass smtp.mailfrom=well-founded.dev;
	arc=none smtp.remote-ip=185.205.69.214
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43571606A32C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43571606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 7BF8719E0ACF2
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:36:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793201773;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=eY++VNuzwvLIwcN1yG+EZ5uXg8LcA0wFXof77NTrhS8=;
	b=GYaSTld4NVtgd+fW0qzm4DMTio+0rToGTk0lLwSVkxwOsNc02DyE0/aMzwn2jVX5
	g8fG6UEZv5xQ35/xRr5tvQfwG0JFVNVbdo69SdiiaRZYgo2jQHWX+wWX2oB9+TDK46A
	VSSARbu0mMAXGP2Yq0dgio9XiqcHHTbgrxjKlZ3aKvbwJgLrCkxgMAR7dJ4syrUSnFl
	ZupcYgMKOGReKmVtacRowkqSBVb6gI1+5fngPhE2yIo+3gfy4Sjt7WQo4nSlGzwXW4J
	0uSp94pPnGmA9NU6yeP3cHmbxAjO1npPwn/Tf/RQ6vOxj2Z5/FUJbw+NexxWhv7YXyG
	8IAiHwI0SA==
Date: Wed, 28 Oct 2026 16:36:13 +0100 (CET)
From: Ramses <ramses@well-founded.dev>
To: Netdev Bot+sashiko <netdev-bot+sashiko@kernel.org>
Cc: Jv <jv@jvosburgh.net>, Andrew+netdev <andrew+netdev@lunn.ch>,
	Davem <davem@davemloft.net>, Kuba <kuba@kernel.org>,
	Pabeni <pabeni@redhat.com>, Jbohac <jbohac@suse.cz>,
	Edumazet <edumazet@kernel.org>, Netdev <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Razor <razor@blackwall.org>, Liuhangbin <liuhangbin@kylinos.cn>
Message-ID: <P528ptp--R-9@well-founded.dev>
In-Reply-To: <179319031668.3134.15966773474485635933@kernel.org>
References: <20261027-bonding-last-rx-v3-1-54907f1fb042@well-founded.dev> <179319031668.3134.15966773474485635933@kernel.org>
Subject: Re: [PATCH net v3] bonding: fix initial last_rx vs ARP-monitor
 slack window
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
Feedback-ID: 0163e381fa67fa966160938ffa017803050e57578bb1735d37cd25d20463a96a9bb3a550250bbc5eaa94bfdfd8cf3defcf1aa43859ae980630826bb8230f264e7f:TurnOnPrivacy!:tutamail

Oct 28, 2026, 13:25 by netdev-bot+sashiko@kernel.org:

>
> [Severity: Medium]
> Just after this hunk, bond_enslave() copies the same value into last_tx:
>
>  new_slave->last_tx =3D new_slave->last_rx;
>
> So last_tx now also starts two intervals old. Could that cause a spurious
> UP->DOWN transition in bond_loadbalance_arp_mon(), used by balance-rr,
> balance-xor and broadcast with arp_interval set?
>
>
This has already been fixed in v4 of this patch series which I sent this mo=
rning.

v4 only uses the older seed for a slave that starts DOWN, and patch 2 of v4=
 seeds a slave that starts UP with last_link_up, so last_tx gets a full arp=
_missed_max window too.

See:=C2=A0https://lore.kernel.org/netdev/20261028-bonding-last-rx-v4-0-4d8e=
4cd47467@well-founded.dev/

Ramses

