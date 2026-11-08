Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175064;
	b=IvN93whdmBWS4b5uy/ppH7MFFyefEMCh66Ij/ZgQQbCVlmCJC0UjNIyEZyFmJ1uYKRFb
	 dP5dBW09kwnqfjEfbT6yEOcD+5wxmDbRQShgLEdxSVIsYv3hArwjmq+kvM/+X4fm7xLYl
	 NnppzWQdaiF0mE/pnVDq6mcLWObtXDBXrPAX4N8IX6sG0Fj6pjxDHcjQIAyMgucg7Ma43
	 /vB3uEynX0woxFJBmmHj8CG5I8/G3v8QDkbd4L7xNiS1P6NMP4WQAdhqUW/SDhQ01VUN8
	 A35g461Mmn0LDFnJozFVwS2UFo2d92TQEvq0JEWbSiXAVd09ar0Pm7MI10ThOrYnBcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175064;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ia18UYtnWBdapIgN7aPkviiAshzghaVd7+6TEQ0f1ss=;
	b=BXlkaHS0il22IcHuuguP9EuTQ5Mpulo1Rz1lOuA7pKaoyLHd0MBd44eYBMClDDb1ZCl8
	 8tjDRA3hBPvVHht5UWxYsHDBYrQm1Ch2GB1M0vhXowscraMcs9NGbF3fJfCbAli51xTj6
	 QLaqUjiJinnQroHmY7FooE6HoNRptP81n+OL3w9eHT3NanWcSDix0/+wA8bSLp8NJ4ZP2
	 rO8hOYSenGAHI1+a5e/1xUzgkxoSLqBgtN5kqmJ4IOf2YA0dAZEjcSfnOjxGoo3idMh70
	 p64Q/3zdI2UZNYsj0ijXOCCeJ6sOlZSwdrNChMuwpckXYdX84hGZm14lMQpWD/Rd0gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=WONgqkHE;
	arc=none smtp.remote-ip=185.70.43.103
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A98606A31C;
	Sun,  8 Nov 2026 21:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33A98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=WONgqkHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794175062; x=1794434262;
	bh=Ia18UYtnWBdapIgN7aPkviiAshzghaVd7+6TEQ0f1ss=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WONgqkHEaAhNoq9cphyKabziO3OlCTKgRiWHiCoDyJ87lbze/DjrvE129akVtX//Z
	 CQdtRRFR8+z7fjkZet3C1xHZf8jOPPMGUQD4MAayIiGTUTJhyDz282E/RX/A+n6kYY
	 tAbZ8Pa2F9oHnH+IrYgeOsw1e50CjjmhiwYTOjm+hcziYJYsgPNRUHJjw4UvlLoXRK
	 hu8JLR0CffTkes6TIWko+qUn0Df+bjPrL1zY8iUyQs0ADbhF0hCyo+cy4JIIPdb9rg
	 vT2dDtf6JEhFeUoMm07GQk5w/+ndef8HM+I1l2TWhtiq7u27Uo2mSR8eL74hPxrHYJ
	 DgOT7oyU3MLaQ==
Date: Sun, 08 Nov 2026 21:57:39 +0000
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "security@kernel.org" <security@kernel.org>
Subject: [PATCH] wifi: nl80211: clear wdev before erroring out of station dump
Message-ID: <ltwfLZuSH-PEFdqMECEU8rHwZCjSL5--7RG-qrW8a-Fwezdgpb1QYiDm-8aCRNIgwY-laqSmHJWAqV4uI092NLEudhWEABdd3B5iGsV4jJ8=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 5eb0af483ff3e980d0fda2c37c59a9658e0c80cb
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

In nl80211_dump_station(), the new -EAGAIN retry path calls
__nl80211_lock_held_wdev(), which drops the reference we hold and then
re-looks up the wdev under the wiphy mutex. If the wdev is being
removed, that lookup returns ERR_PTR(-ENODEV).

The IS_ERR branch jumps to out_err with 'wdev' still set to the error
pointer, and out_err then does:

    else if (wdev)
            wdev_put(wdev);

i.e. wdev_put() is called on ERR_PTR(-ENODEV), dereferencing an
unmapped kernel address (~0xd). The station dump requires no
capabilities, so any local user can reach the trigger while a
concurrent interface removal (admin action or unplug) closes the race.
The result is a kernel oops in the dumping task, or a full panic with
panic_on_oops.

The sibling handlers nl80211_get_station() and nl80211_tx_mgmt() never
put the error pointer; the dump path is the only one that does. Clear
wdev before jumping to the error label.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), net/wireless/nl80211.c:9023-9035 (EAGAIN path), nl8=
0211.c:296-306 (__nl80211_lock_held_wdev), nl80211.c:9133-9137 (out_err).
Introduced in the v7.4 merge window (unlocked station-dump rework).

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Fixes: [fill in before sending - on a full clone run:
  git log -S '__nl80211_lock_held_wdev' --oneline -- net/wireless/nl80211.c=
]
Reported-by: [your name and email]
---
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d790e20..7392834 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9031,6 +9031,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 =09=09=09=09=09=09=09=09wdev);
 =09=09=09=09if (IS_ERR(wdev)) {
 =09=09=09=09=09err =3D PTR_ERR(wdev);
+=09=09=09=09=09wdev =3D NULL;
 =09=09=09=09=09goto out_err;
 =09=09=09=09}

