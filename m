Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2214E3259
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958258; cv=none; b=sDs/BzZuyhhjkVXK/7WLNzAOoaX+0yQd/eWi3UoQ8XmoDXt7+B0ubx3aFkcoKdwZA408jJcODSz5kjizqX0t/NBa5G7WUgogQj4FBd5q6ddH2+hCDbG1yA3oQYmd40x2kZ7y+eIOXm5ibQXTbI87ZU/Lk/P72Po9BVyG0cutXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958258; c=relaxed/simple;
	bh=cm5PX1beY4qX8ixEnV+ENlB09JEXS4mPCPRaUkVwQ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OywGuUBmpCdjbJOlPUAbxecozH7XXgWF2fRfLXiQ3jM9enVQxb+9MdT88Y4x6Kqu5MqdVNk1b1aU4uC1U9pfaQFr67YhEpQ0TXY2FgSH5oqT0e0TYJnuaUUoBKxyW144weqdwXZauYzHqH9hlvc7Dmq52NwyVx++tS0ddw0fLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=PZEnd7FE; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="PZEnd7FE"
Received: by dvalin.narfation.org (Postfix) id 7C6D71FDE9;
	Fri, 02 Oct 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790958254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APM/551+P5mypr8t09C2B5tk+wmPo/conR5u2OXvgQo=;
	b=PZEnd7FEQ8Eoh1QSrZVH4s7bKJMZHcvKo4VhVAeOVxYkC3PrQ9k8wFl167fEEHiAo2rkEz
	CnU29AE81i8hh1PNAWojOu6YNjjuXKRJm3/oaS7IFE9caqqx6hJ3Wb11T398FFONbppi0f
	egH5Bwlc28OLFHmkjdWUQapEP4vhSXc=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: antonio@mandelbit.com, sw@simonwunderlich.de, marek.lindner@mailbox.org,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
Subject:
 Re: [PATCH net-next 5/9] batman-adv: tt: only queue local del event after
 successful unlink
Date: Fri, 02 Oct 2026 18:24:11 +0200
Message-ID: <23263645.EfDdHjke4D@sven-desktop>
In-Reply-To: <20261001095518.932241F000FF@smtp.kernel.org>
References:
 <20260930094558.3723766-1-sw@simonwunderlich.de>
 <20260930094558.3723766-6-sw@simonwunderlich.de>
 <20261001095518.932241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7999796.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart7999796.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Fri, 02 Oct 2026 18:24:11 +0200
Message-ID: <23263645.EfDdHjke4D@sven-desktop>
In-Reply-To: <20261001095518.932241F000FF@smtp.kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 11:55:18 CEST sashiko-bot@kernel.org wrote:
[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 354d9416c1b75..c904d67791f8f 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> [ ... ]
> > @@ -1496,8 +1496,6 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
> >  	struct batadv_tt_common_entry *common = &tt_local_entry->common;
> >  	struct hlist_node *tt_removed_node;
> >  
> > -	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
> > -
> >  	/* remove exactly this object when still present in hash */
> >  	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
> >  					     batadv_compare_tt_entry,
> > @@ -1505,6 +1503,8 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
> >  	if (!tt_removed_node)
> >  		return;
> >  
> > +	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
> > +
> 
> [Severity: High]
> Does moving this event queueing after the hash removal create a lockless
> window where a concurrent ADD can be incorrectly cancelled by the delayed DEL
> event?

Previously, you're partner instance complained about the opposite order:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8

Will postpone further changes (and not modify this PR) until a better way for 
consistency guarantee between announcements and hash states is implemented:
https://www.open-mesh.org/issues/475

Regards,
	Sven
--nextPart7999796.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/aqwAKCRBND3cr0xT1
y8XCAP9JVLQ8bmYR99VUuRhDTYj0Sr5vTirIQhqJPYELcMyFNgEAsH+kR6VwB/Ma
79/5wvr2hdkSi/JL4CBf2GHQOyY+CgY=
=ondY
-----END PGP SIGNATURE-----

--nextPart7999796.EvYhyI6sBW--



