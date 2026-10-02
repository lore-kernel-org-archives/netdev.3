Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79A175A85
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957140; cv=none; b=sE1WaPByEtx7zlY6qZ3AiNjy4JNA99YIS+DPZnAKnsLFHbrTBUeJHH4tR8+wEA2FFDCdM8ecXxkTnOawbKf814neqx5iorsH2q9zjN8UMmqXn3meEXO//IIoFX+qzpD+DZjYJc/sWcIEeZ5+UuCsvB9UeKJk/CmGJ+OsoUlZD0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957140; c=relaxed/simple;
	bh=qV25G5oXBwtuCymXGBDJZpmxTijetYcrzQVOtPxE0uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTeUDRhSLiaPxIBuWFmX9LovL0nd99WEikYpESkBwhqtFzV1rr1y2XUU0V7TLUwTQU10k1RSLOOCYtaF/7x+iOVCJqI+8maVROaRSsllsV9jycbHq7WRXb5gbTPpleDFoZa6gepkV+1p70wmuhbWBXwNc1/s9iO39UXyUJQaOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Okubelef; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Okubelef"
Received: by dvalin.narfation.org (Postfix) id A0F2520030;
	Fri, 02 Oct 2026 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790957136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2M+CgAOhsYFxG3telNT9hjb3vQ0aLrOXWVPVdgAqOA=;
	b=OkubelefR/DLv6krpM13axsn+L3CgYSOCxZfjzOFnZJMGQRtTvxH9sCumg1b6eD8sS3AGK
	I7KQiLjiDZFoAofPVlklqpCJzKEyHkj9Ar1F0FNCRIpiMwW0+qF81R8wyQ4MzhLLWrvBJ/
	kMapbfuOlsu9pmu9W7gmgJV10OY7vAA=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject:
 Re: [PATCH net-next 3/9] batman-adv: tt: clarify responsibility for roam flag
 during removal
Date: Fri, 02 Oct 2026 18:05:34 +0200
Message-ID: <14106471.uLZWGnKmhe@sven-desktop>
In-Reply-To: <179084942724.434549.1630601702570339695@kernel.org>
References:
 <20260930094558.3723766-4-sw@simonwunderlich.de>
 <179084942724.434549.1630601702570339695@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3065912.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3065912.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 18:05:34 +0200
Message-ID: <14106471.uLZWGnKmhe@sven-desktop>
In-Reply-To: <179084942724.434549.1630601702570339695@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:27 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> 
> This isn't a bug, but is the "prepared by batadv_tt_local_mark_removed()"
> wording accurate at this commit?
> 
> In this commit, batadv_tt_local_mark_removed() doesn't build any event. It
> only saves *curr_flags and sets BATADV_TT_CLIENT_ROAM and
> BATADV_TT_CLIENT_PENDING on common->flags. The DEL and ROAM event flags are
> built right after this comment and then passed to
> batadv_tt_local_set_pending_event().

This is just an intermediate move

> The other two points are small wording nits. Both come from code that was
> already there before this patch.
> 
> The comment moved into batadv_tt_local_mark_removed() starts with "if this
> global entry addition is due to a roaming". The helper's kernel-doc
> describes @roaming as "true if the deletion is due to a roaming event".
> 
> The only caller passing roaming=true is batadv_tt_global_add(), so the
> wording is correct in context. Would it read more naturally in terms of
> the deletion, to match the kernel-doc?

No, it would be wrong. The global one is added and the local one is removed.

Regards,
	Sven
--nextPart3065912.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/WTgAKCRBND3cr0xT1
y9UkAQDcIxML8Hb0EASps7ASDrNCw5N4ZOBfQEP7j2owvIQRmwEA6+J7sxOe1VNy
xzxHdPyB/TIbiibjC7cFcEGbmcZeSg0=
=EC+u
-----END PGP SIGNATURE-----

--nextPart3065912.e9J7NaK4W3--



