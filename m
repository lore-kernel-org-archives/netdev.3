Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484027;
	b=Y+PWfcAAVNr5/zsPVn2V+ZBA/wcaYeXwYPc2J8Nh5z4LDjaDHYhdQfSu+KT0/UeVCv0O
	 ygltsDjMKi7dM+I8+LY8yLH/4Oiu8cWqFgw2eIvUgB+LMk++Kls/O1ryZ+4CzxxJcIopP
	 tkDXIXbqceFdyOghao+4/0eLb16Xd+WQjn8WTIp7LySDHCaTzVn3LBAu2XqQyL3P2Lzeg
	 cplOMqWTNfH6aB9vm6pmCz1jiN2iJ1Bjm65lDcZ5oCdrUBMI7Wou8pV6lNRbcYi+wNBsi
	 CG17mbmOIxC3i3htWrt2QxSo89905QztEFV3QSLvBy6Dm5ATpTtd0q3NwuyqNXzBEzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484027;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=MN63htuYUqrgFOXv/xwBT/iNnGMFTc69oLMOIWBDMN8=;
	b=tJLi0Y5NU7gPc8skMbwLcyVvk3kr6QcbKA/3BsDRtfwcAz/jq83I2fDNKnG/sUXfrXCG
	 xZeKZTiQ6aecg4+a5mna7aBb6YIwkDTu5DIxXYXNQxLsh9ep0/a3l8fdS8LMvLSHRu25b
	 gbKWorezYJN6+S4O3syd+QFmsyv+NkyccpqAxqZBa9+JIsboLFg3jH4Ov3+W8nEZHzr2i
	 M1anNWOXWhfkd4q52H0uneK1//zUsc7pS4PddEnUeNMjVYnNzEWzMyY04ltsEzDixRAUE
	 YUg4SFXJCgnZ24rwdD4ZmMTYXk5hZmERl1PXwtdbayV3Mh3Kh3Ulplh4eR6r/AKGGZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=03OZ40IQ;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D278606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D278606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=03OZ40IQ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 71F9B4E4128D;
	Tue, 20 Oct 2026 08:13:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C3A060393;
	Tue, 20 Oct 2026 08:13:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1925D10328A45;
	Tue, 20 Oct 2026 10:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792484024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MN63htuYUqrgFOXv/xwBT/iNnGMFTc69oLMOIWBDMN8=;
	b=03OZ40IQu92p+6zcM7lPsTtHDySziOlL6p2l7mREPKNcIKAdggk/zBqFUYfhtfeAL07r3t
	j0n7+Dj4Rim8EAwgcKN53lOYIl9/Yff5WfFqMUb9aiKsBSfvbDGgqxJiOnLcn6+PgQkVqL
	6wrdIiWr+5A1I3m7I67WEy034pwF4AGD9osfqoRzr73PpJXMl/jL0ll4aAKo7z5ZPQ24El
	bw92Xh7KhRxXuz8sJe15OugBJ1GJJk58MokHZdzZImRbTlLhq5zoju5d5adGEbNXgSzaVY
	+RxZJOfedAiiLWNpcMA0IZI7AajeBFBOdtmGTyZtvWHAmwRXKlG+rvBnwPB4mQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  Marcel Holtmann <marcel@holtmann.org>,  Chandru Gopi
 <chandru.gopi.dev@gmail.com>,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH wpan] ieee802154: look up the wpan_phy dump ifindex in
 the caller's netns
In-Reply-To: <20261020065125.896530-1-maoyixie.tju@gmail.com> (Maoyi Xie's
	message of "Tue, 20 Oct 2026 14:51:25 +0800")
References: <20261020065125.896530-1-maoyixie.tju@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 20 Oct 2026 10:13:40 +0200
Message-ID: <8733u0vlfv.fsf@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 20/10/2026 at 14:51:25 +08, Maoyi Xie <maoyixie.tju@gmail.com> wrote:

> nl802154_dump_wpan_phy_parse() looks up NL802154_ATTR_IFINDEX in
> init_net, while the dump only returns phys in the caller's netns. For a
> caller outside init_net, the result depends on what the ifindex is in
> init_net. If no device there has it, the dump returns -ENODEV, even
> when the ifindex is one of the caller's own 802.15.4 interfaces. If an
> 802.15.4 interface there has it, the dump is empty. If any other device
> there has it, the filter is ignored and the dump returns every phy in
> the caller's netns.
>
> GET_WPAN_PHY needs no privilege, so an unprivileged process outside
> init_net can use this to tell which ifindexes exist in init_net.
>
> Look the ifindex up in sock_net(skb->sk), as nl80211_dump_wiphy_parse()
> does. Commit 66e5c2672cd1 ("ieee802154: add netns support") added the
> netns check to the dump loop. It also removed the "TODO netns" comment
> above this lookup but kept init_net.
>
> Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
> Cc: stable@vger.kernel.org # v4.8+
> Assisted-by: LLM codeql
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---

Seems sensible:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
