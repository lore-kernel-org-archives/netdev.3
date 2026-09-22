Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACA53C3AE;
	Tue, 22 Sep 2026 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076541; cv=none; b=ADZYqDmsmNvApO7wML9exTIJQgT9QKgIDwZpni38diYOBtL6hcQvkxJuR7eNnvjNOWbxe2iXEWWksMWVRdf97eWR93Et+SuIyj29jiBINiYp7ALRNu6ngIL8R5xKfhuqRKkQiIaFZFG71HCZSHTU/MCkWC4Q224Jx3PW4SjXcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076541; c=relaxed/simple;
	bh=8ezXR+Lt6ZaNOwuRcrQbMLhsdGaTIjT66z9uPptkQk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CtNqQkZKsBVAErILlX57CtR3tSs7U9C3TKqWkrQmoA0a3CPOv8symJRJs70dRCKbk2zLvpJGyJuUMckMofIBodQ+CxqGPk+XNU6Kih/c/ChE+/rUx5meCts13n7SGztFkwnUVry7OyVy6uSlL5JUrap8QtnURuhR07qefyaJbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKsSSuLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKsSSuLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397C51F000FF;
	Tue, 22 Sep 2026 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790076535;
	bh=5sE+IxoSTZUzdVKx+DnOqn3GcbiLTNJfCmwEINwktAQ=;
	h=Date:From:To:Cc:Subject;
	b=GKsSSuLYy/KpyQmmJcxlG1tTw9B2746oAF3qz5OJco6Rk5wlREuqDmWhTLBz1OnVE
	 2Y6dhKvi/JzJU2AzPLasVYfnGiA1CW1DjfxqbawnAAQjvWj2xjKqYionA1EbLUtLwx
	 2Et0ui1/4koz1YZY+04kJ8J8WDmflnehPSFevrwsGjxK1HE/9u9XLS3aCySqZO8pA9
	 SCSUm7eKCN/Vq+uhou2v9Q4mhTnsTxnUOq655hniNYJ/R1rA6widK7p2wgp/U5eYcb
	 9BbvtMgbb4HjxzttDe0HRup2BPs4VLjIMNHEofQKVdHMvsWqtW5exZqbb/o+/sTFFu
	 aX4LsGZtkV5Eg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 8C3FF1AC56BF; Tue, 22 Sep 2026 12:28:50 +0100 (BST)
Date: Tue, 22 Sep 2026 13:28:50 +0200
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the iwlwifi tree
Message-ID: <arJmcuhpJ69wAvYK@sirena.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mDMwOWWrCDSRTJm4"
Content-Disposition: inline


--mDMwOWWrCDSRTJm4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got conflicts in:

  net/mac80211/ieee80211_i.h
  net/mac80211/tx.c

between commit:

  8effab902fa34 ("wifi: mac80211: prevent AP VLAN tx from other interfaces")

=66rom the iwlwifi tree and commit:

  78b843974fb83 ("wifi: mac80211: report multicast transmission from lookup=
_ra_sta()")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/mac80211/ieee80211_i.h
index 9374c2942489c,10767666c45c0..0000000000000
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
diff --cc net/mac80211/tx.c
index c8217f6d146e7,83b758724edff..0000000000000
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@@ -2530,9 -2579,16 +2579,16 @@@ static inline bool ieee80211_is_tdls_se
  	       skb->data[14] =3D=3D WLAN_TDLS_SNAP_RFTYPE;
  }
 =20
- int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
- 			    struct sk_buff *skb,
- 			    struct sta_info **sta_out, bool bss)
+ /*
+  * Returns an error if the frame should be dropped, otherwise
+  * the *sta_out pointer is filled:
+  *  - valid sta pointer: frame goes to that station
+  *  - NULL: frame will be unicast to a yet unknown station
+  *  - ERR_PTR(-ENOENT): frame will be group addressed
+  */
+ static int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
+ 				   struct sk_buff *skb,
 -				   struct sta_info **sta_out)
++				   struct sta_info **sta_out, bool bss)
  {
  	struct sta_info *sta;
 =20
@@@ -4422,10 -4426,10 +4429,11 @@@ void __ieee80211_subif_start_xmit(struc
  	    ieee80211_mesh_xmit_fast(sdata, skb, ctrl_flags))
  		goto out;
 =20
 -	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
 +	if (ieee80211_lookup_ra_sta(sdata, skb, &sta,
 +				    skb->protocol =3D=3D sdata->control_port_protocol))
  		goto out_free;
 =20
+ 	group_addressed =3D IS_ERR(sta);
  	if (IS_ERR(sta))
  		sta =3D NULL;
 =20

--mDMwOWWrCDSRTJm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqyZnEACgkQJNaLcl1U
h9D5dQf/SZty+OfWJFr41+2F/8C5/86/5rUcAGnb0e2uDzhIYDv7bTcjc9n7urcr
so8bt5V6+La5xROtzLsbixofDaSqe5Qilo/T84s9BlOFQZim6MBZXGHLOQReTHDH
gISa6du0kqxp/TOyPJPiibar4iMAO3inFBV0IO0vv7P4oBAMzbP6yZ4BdXbtjPOb
GQoEhQZmt6BJLHzlnmCJzgRqaidVYDImnwL+BN2J7si48xFU3KdkCWzyaGhNYgoC
27m08TlebW2qjgY3orHtNKjv4sxUEN/ZU7YTA848oUbkuIhtdISST2vR0lOsJscs
SIJ9MWmslmVYpeOeqLwrW3T49buRlA==
=LYnI
-----END PGP SIGNATURE-----

--mDMwOWWrCDSRTJm4--
