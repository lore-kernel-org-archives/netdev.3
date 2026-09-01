Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18305483BF2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281925; cv=none; b=GBCXLAQqzJ+gL4LCCrA6xY7BkD6QfodC9dyykW7ay1Exrm4Wa/Hy59N/TdfOYF6zdhL6fijABVgy5RpFBtV9GhB/wRlY6DzL4XpxzjNRpt89tvxgOqJkoTzcrHrCWRUct5ot+kePnfBQx2bfK/u6iPlMiOWpeeQd7oCNvK8CGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281925; c=relaxed/simple;
	bh=zHfBMTxRqkaPOBK226KbK5Bs6Zd5qsfNptK1yMeOWjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV2FwlttzZ+/wUJmbgqVfnwo0FkzK1F9Hlo8HpL81qWhx6WaOh4JCBvnZrfwstyv5DyCCnc7qSPUL4BlrOJsq4+v39q5o8TM561OPIr9Pzs6C0pQ1M9sImnUMn0v5/NDlm9zPESUzXWOVmZgw5cR0iBXynkDn05Y+ll7N0qDBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=1gZ9qniC; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="1gZ9qniC"
Received: by dvalin.narfation.org (Postfix) id C19D72043A;
	Tue, 01 Sep 2026 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788281917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKUWbeHCL4+HuZrAgf7m2Euvx5NSGOwv6Pqkpgugprw=;
	b=1gZ9qniCkWTSOAwLZmX0offKwfcEC2JcNq2HsvE4VL7w1Aeot9dVhrRawsTSoLlrh51E9A
	/RkV+OC912ZHybOdoJQjdfyTxRs8WPkvD9IAWFYPT1Gls0xp7BPf3qJ4PzQp6Rix12kiNM
	CSsdBp20Mgie/npf0v8msxjq8BakSPY=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: antonio@mandelbit.com, marek.lindner@mailbox.org, sw@simonwunderlich.de,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net-next 12/15] batman-adv: tt: use protected flag modifications
Date: Tue, 01 Sep 2026 18:58:35 +0200
Message-ID: <2369228.iZASKD2KPV@sven-desktop>
In-Reply-To: <20260901140003.62B041F000E9@smtp.kernel.org>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-13-sw@simonwunderlich.de>
 <20260901140003.62B041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2056107.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2056107.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Tue, 01 Sep 2026 18:58:35 +0200
Message-ID: <2369228.iZASKD2KPV@sven-desktop>
In-Reply-To: <20260901140003.62B041F000E9@smtp.kernel.org>
MIME-Version: 1.0

On Tuesday, 1 September 2026 16:00:02 CEST sashiko-bot@kernel.org wrote:
[...]
> > @@ -1351,10 +1391,17 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
> >  	}
> >  
> >  	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
> > -		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
> > -					    message);
> > +		tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
> > +		pending = true;
> > +	}
> > +	spin_unlock_bh(&tt_local_entry->common.flags_lock);
> > +
> > +	if (pending) {
> > +		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
> > +						  message);
> 
> [Severity: High]
> Does detaching the DEL event emission from the flag update create a
> split-brain routing state?
> 
> By setting the BATADV_TT_CLIENT_PENDING flag under the flags_lock but
> delaying the emission of the DEL event (via
> batadv_tt_local_set_pending_event) until after the lock is released,
> there is a window where concurrent operations can interleave.
> 
> If a concurrent batadv_tt_local_add() executes within this window, it
> will clear the PENDING flag and queue an ADD event:
> 
> CPU1: batadv_tt_local_remove()
>     tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
>     spin_unlock_bh(&tt_local_entry->common.flags_lock);
>     // Preempted
> 
> CPU2: batadv_tt_local_add()
>     tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
>     spin_unlock_bh(&tt_local->common.flags_lock);
>     batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS); // Queues ADD
> 
> If the OGM worker runs now, it broadcasts the ADD.
> 
> CPU1: batadv_tt_local_remove() (resumes)
>     batadv_tt_local_set_pending_event(..., BATADV_TT_CLIENT_DEL, ...);
> 
> The next OGM broadcasts the DEL event. The local node considers the MAC
> active (because PENDING was cleared), but the rest of the mesh drops it
> due to the DEL event, leading to persistent split-brain routing.

This is not how TT works. The events are a best effort in informing other 
originators. But it is not the source of all truth.

And this is not changed by this patch.

> > @@ -1394,21 +1441,37 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
[...]
> > -		batadv_tt_local_set_pending(bat_priv, tt_local_entry,
> > -					    BATADV_TT_CLIENT_DEL, "timed out");
> > +		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
> > +						  BATADV_TT_CLIENT_DEL, "timed out");
> 
> [Severity: High]
> Can this sequence similarly cause a split-brain state?
> 
> Like in batadv_tt_local_remove(), this delays the DEL event emission
> until after the lock is dropped. A concurrent batadv_tt_local_add()
> could interleave during this window, resulting in the local node
> keeping the entry active while the rest of the mesh removes it.

This is not how TT works. The events are a best effort in informing other 
originators. But it is not the source of all truth.

And this is not changed by this patch.

Regards,
	Sven
--nextPart2056107.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcEOwAKCRBND3cr0xT1
y+ypAPwNsBB8875SiRiAf9g792ominFBw/KSJHrVUEPeJ2iqcgD/Y3ZrDN5RaMQh
8YOzJMln1ALipilC8XKlI0c51l+wSQA=
=1RgT
-----END PGP SIGNATURE-----

--nextPart2056107.PYKUYFuaPT--



