Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5D48122E;
	Thu,  4 Jun 2026 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582677; cv=none; b=QpRHvcVJbFfRLM4Jh/pE4fSZRjSyRI+cm1LwibHdZUZvQBu5G1FSkO/nmE/8gG4Qo+ww2o6TBTlOu2CSwqujF9C4QqXZb4WxBuCxxrDYHbEcdkXYn1cfGkoSfR131lxm3sFvlxkJ90r1ZCIGTc3KXyqAjGH5d2w4sFEsJMZiEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582677; c=relaxed/simple;
	bh=1ZIBXk0QwvSdsrBxY/yOnyCLFuh+iBLRRboFqJhgAxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W+6voI6gstAAYzcPvRXgml56hMReF68Kys7P81bMamnhZJvfzu/T3hzypaAYsK3hMvjS2n73WmK5BncH+csYWwm0jM/I19OiEqYQ35aAFS8NUTRxOtBWuUQ31/Sro3Pha1MD3/+VPKcOb/sCrMO5gFzgJ9mcJrrMQ07eqJJ7qb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoMXnkGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoMXnkGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1238D1F00893;
	Thu,  4 Jun 2026 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780582673;
	bh=J5oWhSp/KWXi7GonDG3VomZu+XFRSpMw5X/ehswEmn0=;
	h=Date:From:To:Cc:Subject;
	b=VoMXnkGjtWJ1r9UDumSv16UN7o0OXdvrgdBnhjsExdMK9FkhyKdNNePoL0bVHnY7S
	 DhE4neSiAiVPQB9/JZKanhivu2DPuTallJmWGPfgWMJJFrUlnILxqwq9+bGxw1nQeD
	 QQKfpXHsYeZrTluZ5Nrx2muC0euFmL0OnqS4nlnUid8Fr/Oa/3FXkpSEJcZp7TTmIB
	 OW5KsYlEysH9nw50L5nzTtg2SVoGCCX+mk0rGYh7pK5t36CWQ3xD/aXVcfbyYGJ7le
	 XtoGRLITqzs4G+2gTDv/+JzYmeVXiIZF3acfsMKTmuTc9nPeOALWvRM7KQ/efubrTe
	 MhDP0S+veucjQ==
Date: Thu, 4 Jun 2026 15:17:49 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <aiGJDaHV4UlCexIQ@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="171w6khBFz0qhSsU"
Content-Disposition: inline


--171w6khBFz0qhSsU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (arm64
defconfig) failed like this:

/tmp/next/build/net/wireless/nl80211.c: In function 'nl80211_calculate_ap_c=
apabilities':
/tmp/next/build/net/wireless/nl80211.c:6999:41: error: 'struct cfg80211_ap_=
settings' has no member named 'he_oper'
 6999 |         if (!!params->he_cap !=3D !!params->he_oper)
      |                                         ^~
/tmp/next/build/net/wireless/nl80211.c:7002:42: error: 'struct cfg80211_ap_=
settings' has no member named 'eht_oper'
 7002 |         if (!!params->eht_cap !=3D !!params->eht_oper)
      |                                          ^~

Caused by commit

   cb9959ab5f996 (wifi: cfg80211: enforce HE/EHT cap/oper consistency)

interacting with changes in the net-next tree.  I have applied the fixup
below:

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c0f8d0bf1bea2..d947a9f6045a9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6996,10 +6996,10 @@ static int nl80211_calculate_ap_capabilities(struct=
 genl_info *info,
 		}
 	}
=20
-	if (!!params->he_cap !=3D !!params->he_oper)
+	if (!!params->he_cap !=3D !!params->beacon.he_oper)
 		return -EINVAL;
=20
-	if (!!params->eht_cap !=3D !!params->eht_oper)
+	if (!!params->eht_cap !=3D !!params->beacon.eht_oper)
 		return -EINVAL;
=20
 	return 0;

--171w6khBFz0qhSsU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmohiQwACgkQJNaLcl1U
h9BozQf+OFaDct+40vVEOon96y6DJg1x0Us0fKz/rOlPvdmlHldbpsF6C3TNJ2C5
xj2fzGxfpW71tay6sdLdoxOHOZDU+PD6jQ2gZ62U4IgAgDI2l3+ImBW+D3Xt3AI3
VU8shY+IKGrBMltggkuCmpPC/HrhKw8V/JfdF2rpd1i/nld43GizYkW6bsLnsUrI
AQh/oJyhU5d1ZXlhK1Zi71mBGNIDX9h788LmX5O+OsgGHb3wMnV+mFw3A+5Vlr6l
uzYfHA6W1rbiBQCrXviC6rUUrp/WzvfRmNK3NUSSE3Cxx1ADID4x7HyHYZ94W4Ak
g7XgpuM+BEq/IKbZ2TiLn3PmD6IXJw==
=IUdB
-----END PGP SIGNATURE-----

--171w6khBFz0qhSsU--
