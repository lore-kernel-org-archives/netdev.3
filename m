Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275B39E9CB
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859376; cv=none; b=l3MX73Wb7Zjwp5xdzaHOdiPGKO3jyYcijjSyZFn2yax4loA25FUVQxx9j0O0ObzDFyTYhfePuSt+04QQSA/hzxwIba3FGpwW2av8F3dUgXpG10pX+QXAa8JmAq1VoB5ElU5ji2o/g9zaH3NQX6vALsknFxSsxbo0hTKn9+wHs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859376; c=relaxed/simple;
	bh=1apIKh8Ks9mrzDwtPNNRfhQUZwp3S8I3WC3jqSS1hnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFSr6aQoYBHQ732suY7is6SooIdkwYu3hj2wKS7+gvlKh3Q54+peupbJQCCr8n22XwngPLm3y6I1z3EBaQiGdvvYOHzMX7y/haFq+en6ezO6ss3U36ERUNetvJAWpZvrr2AzyHwxPxX7vF65AjUrPgDArRLgKDwwR8l6HqmRl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=fybd3Zbt; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="fybd3Zbt"
Received: by dvalin.narfation.org (Postfix) id 9A1AF1FDF9;
	Tue, 08 Sep 2026 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788859361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJfe2botLpNXpBQV/iLJ4svwvnbdximPHO4ZhVfimo4=;
	b=fybd3ZbtboEUCgmUh9isseRK1wFdyz7fTox7Vx2ItzdxeKqI8lcbYHDDrGo6RGKexlEWLN
	7lLUB4eciscLJFxGfg7fQrNOI5m/5WiFuRNOhZmQLtcEN3DMwPhJqKMubNW/zb6et7LA3Q
	iAGrkYyOJVJuH+P66RbSgqnbpo9NmT8=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: sw@simonwunderlich.de, antonio@mandelbit.com, marek.lindner@mailbox.org,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net-next 08/15] batman-adv: tt: replace add_orig_entry goto in
 batadv_tt_global_add()
Date: Tue, 08 Sep 2026 11:22:33 +0200
Message-ID: <2363912.iZASKD2KPV@ripper>
In-Reply-To: <20260908082701.B6CCD1F00A3A@smtp.kernel.org>
References:
 <20260907081824.2474040-1-sw@simonwunderlich.de>
 <20260907081824.2474040-9-sw@simonwunderlich.de>
 <20260908082701.B6CCD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2050689.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2050689.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Tue, 08 Sep 2026 11:22:33 +0200
Message-ID: <2363912.iZASKD2KPV@ripper>
In-Reply-To: <20260908082701.B6CCD1F00A3A@smtp.kernel.org>
MIME-Version: 1.0

On Tuesday, 8 September 2026 10:27:01 CEST sashiko-bot@kernel.org wrote:
[...]
> This commit refactors batadv_tt_global_add() by removing the add_orig_entry
> label and turning the flag merging and list purging logic into a more
> direct if/else structure.
> 
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 67e4ade5ae997..760acc7be973e 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -2021,15 +2021,16 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
> >  			if (batadv_tt_global_entry_has_orig(tt_global_entry,
> >  							    orig_node, NULL))
> >  				goto out_remove;
> > -			batadv_tt_global_del_orig_list(tt_global_entry);
> > -			goto add_orig_entry;
> > +
> > +			delete = true;
> > +		} else {
> > +			delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
> >  		}
> >  
> > -		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
> >  		if (delete)
> >  			batadv_tt_global_del_orig_list(tt_global_entry);
> 
> [Severity: High]
> This is a pre-existing issue, but this patch preserves and refactors the
> vulnerable code structure without resolving an underlying race condition.
> 
> Could this lead to a Time-of-Check to Time-of-Use race that permanently
> drops a valid originator from the global translation table? 
> 
> For example, if two CPUs concurrently execute batadv_tt_global_add() for the
> same translation table entry:
> 
> CPU 0 (adding a temporary client):
> Evaluates global_flags without locking and sets delete = true.
> 
> CPU 1 (adding a non-temporary client):
> Merges its non-temporary flags, clears the TEMP flag, purges the list, and
> adds its non-temporary originator.
> 
> CPU 0 (resuming based on its stale delete snapshot):
> Incorrectly purges CPU 1's newly added non-temporary originator and adds
> its own temporary one.
> 
> Because the TEMP flag was cleared by CPU 1, the entry might never timeout or
> update correctly, potentially causing a permanent routing blackhole for the
> affected client.
> 
> A similar race appears to exist between two non-temporary additions. If CPU 1
> is preempted after batadv_tt_global_merge_flags() returns true, CPU 2 might
> return false from the merge and add its originator. When CPU 1 resumes, it
> would purge CPU 2's originator based on the stale delete boolean.
> 
> Is additional synchronization needed around the delete decision and the list
> purging to prevent these concurrent additions from stepping on each other?

Same as last time: https://www.open-mesh.org/issues/474

Regards,
	Sven

--nextPart2050689.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCap/T2QAKCRBND3cr0xT1
y6MKAQCWzFsvFCpWrH4kYzOiaVsSkxqGmALtWAjME+/t7TWbOAD9FVZT0nWLfOfi
6ntXynFlwQgz2Xj+UZgdLgWaTNdrPgg=
=wakH
-----END PGP SIGNATURE-----

--nextPart2050689.PYKUYFuaPT--



