Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329122541C
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308210; cv=none; b=HE9Pdty05ORRUjfn+ocuI8EL7fVoeEtqsdaERoWYDaPXPRrfJhctZGw75BbJh4v53NFflx/5RxZ1PvjJonmhVavnoRRLCeCZ6vrBTGlMkXEemxs7rmmEDSXXukByIH6/W9J2M2b+wlRC1pktQS0yHacnV//9myRP1wHG82myYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308210; c=relaxed/simple;
	bh=ZT0rPRclsikqY5yjHCyqNSgPxiZuzAlkdEPLN5nZQbo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=SIk3t86sSl+o9Nl6QBnpp2dY15HsX3nHzFXaVmQzjkrTHjW4VauT6YOmRhLEEtKMqHSkk5iBG2NR9KedFcu87pUCL8L21RoPQwaiR53lJkt2ztMYKJAgZ8X+ZbHm6lEVUCfjYUj85rti6Snl7C59c4k8tQI1vm/qL2ShG3/sQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=TguW//xI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CBKiRl/E; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="TguW//xI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CBKiRl/E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96F8914000F3;
	Tue,  1 Sep 2026 20:16:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 20:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1788308206; x=1788394606; bh=xfq1v5hNBmARbBAIRUSHQ
	NFE0A65+YSzR8w3EoJ9t44=; b=TguW//xIntwGtG/EXpvSLcfv7/u/stShHXGHD
	f3MpONs3SDQRaPKLCRGypRlPLwv4Mlds9MDh5V65eUMAtgymradoOIeJecyi/IPk
	rEbifCPQA3CxcDyHHvCBFmqJymqd8aEWSgeWhArYRgtqWqv8P5zCEKufHakCZ6ob
	z7sYLdsIxyuMl19mdTOiBzx+esuVKzA3Ngvq5sug3egNhx73/8JJwuV9NnHm0OfT
	02C7GAa6MvrbSq/KBMVIiEYA+MLJCrqsN0IvmCdD++lA6bQ3q52icWjmkG7SAcNp
	pefYOsNuwUxtEn5lvVfDEfOKljuEnSjz8ImGUczgI1CwlqNmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788308206; x=1788394606; bh=xfq1v5hNBmARbBAIRUSHQNFE0A65+YSzR8w
	3EoJ9t44=; b=CBKiRl/ExlKYrZ0hmztKBhNSZvfY2EQrFJjAohwCzB4f3lqZAAQ
	ivpBHU5qo8AKysyMpO8eYInMD+AT7PqMzur97Mnh1U8vVlnLR2XFnOnHLPVDLxaX
	nGSRcTMJ3X0445tgJWoHwaDgWuj6kTVOzsKeNioEB/A/lJAumpX0CVy9xTiIjzdd
	P1iQoL+licU09fkFuEd8YR5CuFqYFqmjz/57zlBKjoEJ44jETFucMqPP8/LDmvqE
	vTMyYFwatng8yMJ04qvgG+TKRksJGhGITrQIUZQP3r1qkbhIJQHokDC16GhZN3vn
	X4+aSxsMmH9pr89aJJn0LYxRDGGyX1EYX6g==
X-ME-Sender: <xms:7mqXauYtUL0u3a6RTlKjWE1b3BxRN3Ek1RjdTK-vlhk0x-1FweWUgg>
    <xme:7mqXajozNmeBUJogjgRddRZGd_BTSuzXfXPkRJ5Lk4Azcd26dI0elTFQ99dSPHZ0l
    uHUbUNxYQ22iiMOJFW2EypeovVHdT56TbIrukBtFzOBnPRkJtyCUUnk>
X-ME-Received: <xmr:7mqXarPH1RQPBa4Ri3kgrQgY369H4Bet3QZR7OnLwae1V_NS5Tl-edkm96dFgIKzB8VD_w>
X-ME-Proxy-Cause: dmFkZTFDLptEHYIXtJJ3e+B75sdjCbe8lZ7KRYn9dAqYzQML31gcZjzgMGeSnqp53s8mVx
    BWjXsR1KcKgA2SLg0wL8VW4rlT72nch2f7yg2K3do/QenGjcjhP8cQCQrZLQ5XBXoPb9FB
    eRPXwQfnUd1t+W3hACv6E7cPMnYdrvBXwUYeqwwhf3ztpDCmXjuCiO9lfHXSHgsprUQZVN
    fcwCjZ7ODoWFcspXx95JbQGmXlbO0XTYWGCRnknsmh9+s3DcbGE0XSUpSOePyrWp1K67DC
    by/ousA23kFV2nU0CVxWP0o3kkEBko9oJOca07hFI0Vjer2BPpg/q/atn20F6elto9oxcA
    WNIZohPUle64dUetNDKNiD0bakSuIEtWElQEUV34GDkJqJm0SZpLprtv7ikxmqbtWo5HlJ
    u6R91oWHx0DXnEYo4DOvwxqhonKwkRFTvVRjRHy7fOZ9EgE0ejOH9qdmV0b5Nnm2T1qCPw
    t3b4lHRqnLY0/dFkLHbWG7NetqpyD5Ym3zbcg6nt5V0TS8eVmMiutfPSdeMiTq0wpUn/sz
    hMgiPoYuqRVkmQiz4aV/Z1HcWr4aAMNwOe0FJeRNtNBQEYaBp6dtULVC37mId36NzIA6+F
    6Gs+KgBTs5OqDyvYG7AbqwUs4UxvptMMK3kXI9lpyE48XntmjtMlwnm7Fkbw
X-ME-Proxy: <xmx:7mqXampHJNLzv8XgYjn0GADeff9jumXT03u3n_da0RU_mVPwFn5Ikw>
    <xmx:7mqXaod4CBvDQUGS6sxFNMq1UPX8BkDZB4lSg7q-pcg1L_IW9Fu6cg>
    <xmx:7mqXakT7pZ-Dne8v8X0HQ7wOtnwBU1GejLcazOdFAEcKknWx8lhrrA>
    <xmx:7mqXapZv9SeA3kf7dQHG7RS9l4p1L5GJfNJFYKYxFnmKB0PI-5CrpA>
    <xmx:7mqXak3Jhb4fgLPxVROlG13lOr99m0xRsJwyksJ9xB99SKCIcs1wI5Qw>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 20:16:46 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 5643F9FC75; Tue,  1 Sep 2026 17:16:45 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 528519FC41;
	Tue,  1 Sep 2026 17:16:45 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com
Subject: Re: [PATCH net] bonding: do not clear curr_active_slave prematurely
 when releasing all slaves
In-reply-to: <20260831203042.164466-1-edumazet@google.com>
References: <20260831203042.164466-1-edumazet@google.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Mon, 31 Aug 2026 20:30:42 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <588601.1788308205.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:16:45 -0700
Message-ID: <588602.1788308205@famine>

Eric Dumazet <edumazet@google.com> wrote:

>When releasing all slaves during bond destruction (all =3D=3D true),
>__bond_release_one() unconditionally clears bond->curr_active_slave to
>NULL in every iteration.
>
>If a backup slave is released before the active slave,
>bond_alb_deinit_slave() triggers rlb_teach_disabled_mac_on_primary(),
>which increments the active slave dev promiscuity counter and sets
>bond_info->primary_is_promisc =3D 1.
>
>Because bond->curr_active_slave was prematurely cleared to NULL when
>releasing the backup slave, the subsequent iteration releasing the active
>slave evaluates oldcurrent as NULL, so bond_change_active_slave(bond, NUL=
L)
>is skipped. Consequently, bond_alb_handle_active_change() is never called
>to decrement the promiscuity counter, permanently leaking promiscuous
>mode on the physical device after bond teardown.
>
>When oldcurrent =3D=3D slave, bond_change_active_slave(bond, NULL) alread=
y sets
>bond->curr_active_slave to NULL. We only need to avoid selecting a new
>active slave when all =3D=3D true. Replace the if (all) branch with
>if (!all && oldcurrent =3D=3D slave).
>
>Fixes: 0896341a44bf ("bonding: fix bond_release_all inconsistencies")
>Signed-off-by: Eric Dumazet <edumazet@google.com>

	Complicated failure path, but looks correct.

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J


>---
>Cc: Jay Vosburgh <jv@jvosburgh.net>
>---
> drivers/net/bonding/bond_main.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index c23cf18a996a..1e5ab3454872 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2517,9 +2517,7 @@ static int __bond_release_one(struct net_device *bo=
nd_dev,
> 		bond_alb_deinit_slave(bond, slave);
> 	}
> =

>-	if (all) {
>-		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
>-	} else if (oldcurrent =3D=3D slave) {
>+	if (!all && oldcurrent =3D=3D slave) {
> 		/* Note that we hold RTNL over this sequence, so there
> 		 * is no concern that another slave add/remove event
> 		 * will interfere.
>-- =

>2.55.0.970.g62bdec98f9-goog
>

---
	-Jay Vosburgh, jv@jvosburgh.net
