Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174919;
	b=gwFJgFWehlbwqWD8YelzuES/TvxPHdZ5Q+RCJQCteVC1QgSGyCdnMUGYJMYcqKT2C63Q
	 OZHB0nKb8/qnFwkOxBnAHoDVifHSeMva2jt0guiKwlAEc62eIBxrmO2GnvoBPLovh3Jnx
	 j9/BCpV7VlCj9D1y9ctWNMQk9L75yX1dEWT4RmySO/giFe1iTRT3Yh8xLu2BP2tQL/F35
	 oucn4tTdk26i9tCLCIcwESHm4yGXByn7fezCl4QKOxrzVYmjToIiEFrgzCnI213IZZg2W
	 eGu6wlsG1gDff59NBuusYkTqow/wML/CDL2MqZiT+XSZm080fqP7l2kmQlbC/mpa16g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174919;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p/3wfQGZ3MYS3ucEGRSJg5ubjFtczwohZ7bLXkPBJnw=;
	b=ZnbgjaJphjDfd8ZTrpS1mCzoH/u6I9byIT8O5iczFTj2nTVbYmQLWpp9ppn2M7wk6mjv
	 plf6JoRTnQGyugGmnXgkbrA9VgV0D9kF/NojE9GYo+Tr8wGYnA+5mDbQAeG5Rtmb+4hZd
	 9+JXo5b1PSrGAHP4CqyPl8FQa0ss30j1TCbueWxQwi2D45rOh21LuU7bH/nPoL8HGmLIi
	 kgfxZhZ9Smb41aqOTod0BKqUn8ZdL1y6/DsFOLn/exZG6k5CRLZeCuNvqKXsYPE7fXaYT
	 ehHqPMSezRpjk7TewqINZ45yUFXnljvkRz+2HLMSB2PjOjmXs6XOCz/FCR7fKn+TlbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="D+mz//4P";
	arc=none smtp.remote-ip=109.224.244.116
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFDE606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCFDE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=D+mz//4P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794174916; x=1794434116;
	bh=p/3wfQGZ3MYS3ucEGRSJg5ubjFtczwohZ7bLXkPBJnw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=D+mz//4Poc2sfKlt23LsS3GoLETAQcHpK6Zh/1Rrp3xRAckR+PO/MLmnm/mFj9gFZ
	 8HmI+4Cgl/gEWKViqySvdXOUDjxE4Ozaer4fYHxsMTLUOgJss3pUBNglGCjbyI6Nin
	 YE2zDCFzXtkHgE/2iddUQ8pDdnxW1WV/a4lRiKraKqvu+dmKU03kX2qceQFfz2eB2T
	 2wu3tLsrwb6YX/Vo6OLGl/EmdkU6b45EwKzEEECvESvfvXU7TH6qVCzCvAkFLju9b6
	 J8dKqxqzlHvHKgzDgqNhVqt87g1Y3+cv3Vl7QxtVf1fwUT+sjM9xT+W17SOg6jGXVV
	 /zF/+SSP6AJOQ==
Date: Sun, 08 Nov 2026 21:55:13 +0000
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "security@kernel.org" <security@kernel.org>
Subject: [PATCH] wifi: mac80211: use frame link_id when adjusting link_sta on reorder release
Message-ID: <Sq80dyNRnQWE5H_yZYIwxaQiwgvIrIlET6kND66_K0UpnKQZruHroWDq6hlYKDM0y9e2vXW2UBlBmnjw3bCLKk1Acrp7F49_jk883tbCqxk=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: bb8ae6812a85f3b79d59340257cc7d96353ef54a
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

In ieee80211_rx_handlers(), when frames are released from the BA reorder
buffer on timeout, rx->link_sta is re-fetched using the *previous*
rx->link_id instead of the frame's own status->link_id. For a legacy
(non-MLO) client on an MLO access point,
ieee80211_release_reorder_timeout() passes link_id =3D -1 and
ieee80211_rx_data_set_sta() never updates rx->link_id, so the adjust
block evaluates rcu_dereference(rx->sta->link[-1]).

link[-1] aliases deflink.pub, the last member of the struct embedded
directly before link[] in struct sta_info, which is always non-NULL - so
the existing NULL fallback cannot fire and rx->link_sta becomes a
struct ieee80211_link_sta * that the RX handlers then treat as a
struct link_sta_info *.

ieee80211_rx_h_sta_process() subsequently writes statistics through that
type-confused pointer (a fragments counter, a u64 byte counter fed with
the attacker-controlled frame length, signal EWMAs and chain-signal
values) at fixed offsets inside struct ieee80211_sta around deflink. The
corruption is intra-object and therefore invisible to KASAN; depending
on the exact layout it can reach the link[] pointer array, nmi,
nan_sched and the driver-private area that follow deflink. At minimum
this is a remotely triggered crash on MLO APs serving legacy clients;
worse outcomes are layout-dependent.

The one-word fix below uses the frame's own status->link_id, which also
restores the intended behaviour for MLD peers interleaving frames from
two links inside one reorder window (the current code fetches the link
STA of the *previous* frame's link).

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), net/mac80211/rx.c:4243-4255 (adjust block), rx.c:43=
75-4404 (ieee80211_rx_data_set_sta), rx.c:4410-4426 (ieee80211_release_reor=
der_timeout).
Introduced in the v7.4 merge window (regression vs v7.3).

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Fixes: [fill in before sending - on a full clone run:
  git log -S 'rcu_dereference(rx->sta->link[rx->link_id])' --oneline -- net=
/mac80211/rx.c]
Reported-by: [your name and email]
---
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ecee934..836d571 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4244,7 +4244,7 @@ static void ieee80211_rx_handlers(struct ieee80211_rx=
_data *rx,
 =09=09    unlikely(rx->link_id !=3D status->link_id)) {
 =09=09=09if (rx->sta) {
 =09=09=09=09rx->link_sta =3D
-=09=09=09=09=09rcu_dereference(rx->sta->link[rx->link_id]);
+=09=09=09=09=09rcu_dereference(rx->sta->link[status->link_id]);
=20
 =09=09=09=09/* Link got disabled, just use deflink */
 =09=09=09=09if (!rx->link_sta)

