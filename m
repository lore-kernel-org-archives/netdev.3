Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0A48822B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281941; cv=none; b=XopPNNOcpGvs9En+X/eyAfiDwgk+srkdPvUmZ8VLq1LaZgzYWGozCimM1eTWi35pgJN3qSgaCmRuY/6WLD9Iae4ySJ0pgNRt+jhIFQAeSn/ivjRLmLNBRAgkhebhJq5x8m+keC3cgYe/dXEzgb51VzOnVcoeDAPzkOncfktCHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281941; c=relaxed/simple;
	bh=fTM7sB3B4s8fEdGcca8QSRNTq5ns81uXK5ijxAjdpV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLNmaUv+e11d6iEU9L3gLICIJcwFvEJak1BYnBt8dQ9tEptEQVHEScC4azfGVNLw3j6LtNNTIsPSB3MsfAomVrQYPZV3EA1M3CuKO+aF5uMVyHrHXUrPbCN1dxECAbtlt0CTKbjNYNtHZrw8FJneSTvJbrvS2FAIB7AoAQZjrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=b0zHMb1o; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="b0zHMb1o"
Received: by dvalin.narfation.org (Postfix) id A43042043A;
	Tue, 01 Sep 2026 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788281933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sY/y8nM7j151HpK8EUmBA/gZyx+/2/tqvAXM0+8cxAU=;
	b=b0zHMb1o5egeeUSIa8NxHsvntx0ir0BugKT0DMtsKdPX6MIfDbWhGmdhaUDqRocy96hxAJ
	pZfZeuIXlAmdeRMWyv4rCxraDEov6Ah4emqoxdyfG6vEbE/c6+tRbDam/N7Vzas8yzWiEO
	TiVYJC7Ulyd9+t37wlRQsXRO4Rd0iW8=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net-next 09/15] batman-adv: tt: extract code handling a roam on
 add
Date: Tue, 01 Sep 2026 18:58:51 +0200
Message-ID: <9676406.CDJkKcVGEf@sven-desktop>
In-Reply-To: <20260901140002.533041F000E9@smtp.kernel.org>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-10-sw@simonwunderlich.de>
 <20260901140002.533041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3365143.5fSG56mABF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3365143.5fSG56mABF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Tue, 01 Sep 2026 18:58:51 +0200
Message-ID: <9676406.CDJkKcVGEf@sven-desktop>
In-Reply-To: <20260901140002.533041F000E9@smtp.kernel.org>
MIME-Version: 1.0

On Tuesday, 1 September 2026 16:00:01 CEST sashiko-bot@kernel.org wrote:
[...]
> [Severity: High]
> This is a pre-existing issue, but I'm wondering if the handling of pending
> and roamed clients in batadv_tt_local_add() might have a logical flaw that
> persists here.
> 
> When batadv_tt_local_remove() is called with roaming=true for a fully
> synced client, it sets both BATADV_TT_CLIENT_ROAM and
> BATADV_TT_CLIENT_PENDING.
> 
> If the client roams back before the entry is purged, calling
> batadv_tt_local_add(), it hits this earlier code path:
> 
>     if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
>         ...
>         tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
>         spin_unlock_bh(&tt_local->common.flags_lock);
> 
>         goto add_event;
>     }
> 
>     if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
>         ...
>         tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
>         roamed_back = true;
>     }
> 
> Because of the goto add_event, it bypasses the BATADV_TT_CLIENT_ROAM
> check entirely, skipping roamed_back = true. It then proceeds from
> add_event into check_roaming, where batadv_tt_local_add_roam() is
> called with roamed_back == false.
> 
> Can this result in the local TT entry remaining incorrectly marked with
> BATADV_TT_CLIENT_ROAM, causing packets destined for the returned client to
> be misrouted or dropped?
> 
> Does this also cause the global roaming state to be incorrectly preserved
> instead of being properly canceled?
> 
> 

Out of scope for this patch. Documented it for interested contributors in 
https://www.open-mesh.org/issues/472

Regards,
	Sven
--nextPart3365143.5fSG56mABF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcESwAKCRBND3cr0xT1
y5RDAP46PJJsq0uX5X0t5kDEMC1lEq1V1+n6PnAXCN2LzdNDOAD8DpptTRnn0xWY
FFLkHDvF5qZSHXE9xHw7DOiAhxJrZgI=
=nhc2
-----END PGP SIGNATURE-----

--nextPart3365143.5fSG56mABF--



