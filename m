Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D62576EA9
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961070; cv=none; b=d89DqPPO61g5dqXbyzlNoLWe1lA9IlUIWN0DQ5iezXno3PWn42kGpgJHTecopqkTO/V9IYaRwiRLpkf2bfrUcMn4yRIpryhSooUwVyRRwx2JmWqLNuz/0NKzT5e8WDEM2oZ0ni/t7/57Eq+kc5uFnYXjY6HD6nqhJsqwL6puEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961070; c=relaxed/simple;
	bh=c8s69uF6RIIg/jHSdzxsYQ7S8UDIf9cWpe1rBQgZpJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewmFMCJmjASqQRNxsXSPnlC9P0BZAQ97EdUr+BuIBJWlu6NkASscNOfORnWap4xF9asPDyonjogOMi8YSFBhvMy7Nf6+dhj/IFTJShDy7JjDCpfwryAvSkafb8kaYVYQ5QizFrO9Toasjv738e4fDV2WUp5Mqjb4zG9TsBv8RpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=TByyyd8/; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="TByyyd8/"
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 828B33F442
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788961065;
	bh=wrjcPeS70hvY/2jCIpdeC3QpRdoxkk0IP/UxQtFlPx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=TByyyd8//razJFWl7esNH1cAA7D02B9NKmfCjgxI/3zTvcG9aowo61TiDu4G8FPu9
	 lcWglk1MjK/YjKYENzTdfVo9fNrDKVtR+k/iP7xxhxUbqGBLpFtm+6ustIR8e7jdmt
	 Lwnr8wN1+Yg1gn+3nXZLNY9wDgBoWyTL2pgD2HUz8VBef+alLwV5RHChkoiAksT61j
	 TwBcvsjk7iHz+QzHwjjHJkH49KDUR9HweTyVWTq6sxhathboZH7ADblEFqoIhicGP/
	 ga7hBSB9mkNBxy6tvTXt/Usruipb38FtDhE2OORjwlhiwhi17lCIXaRygz2g3g/ooZ
	 wJH9SGgE3ad5uW4MYSDMtcwByiJbEyORt7mFTcLBbT5A35RgGvQxe853nEoXIyv851
	 VWfzuuT3PlCL9je3u5BhVRXPO79ox2WNce+kkhh1zLAL8V7V3sKsCQdpWLvErzPKR7
	 9L1gq0aYzEbVmu7EkX2aS0c5mNlBkSrjt87eV4Mn2ItyCHndg6wjL9BcCVvQ9uMDXs
	 snX6qlmJ1h3Ad1iB61jnRp/LIdg9TB8uJa++pt+GTIeTzV+tjp1r1hxlX1kAPOz4h0
	 xaRj2MYk0ZEjg/opIlj2Q0hjOsfL4nc8JbaPUn+oDMC9WeFDi7C7qM/tkXamFTvxDx
	 K9IIfN3FR/lV7zPn/srPyLc0=
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4858f06e142so3317782f8f.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 06:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788961065; x=1789565865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wrjcPeS70hvY/2jCIpdeC3QpRdoxkk0IP/UxQtFlPx4=;
        b=ju2mmnrqiu7zLmFKFGCz6JQkIcAIGLzsnhphQBNmFh3zMRxTd9j8dHJKsMya/Wtuu3
         sGmnuWZXPm6wNLsxwqGo7Noxqd2CmJbtG4alfD3vm2Zperci2Mm21IlIGKFzXRPKHpPq
         IKkBQQA4KUy0O5VhhRm0s298/Bj7E68qLSftylEaPD1A1GV8Yqz3V7MTPNRGnAXEGCSF
         B7vZFJX+Hs/3fUUfPvfTijWcObOtaWr6+Mq+KvxRIKbHJHisYso3CIduZMpxZatSR0/A
         rMGY46JTeAUsIVXAEJjlMwlBTNfLt0dPN+2NnBuz+mQK968YEKkfOw/FTAl579CgmBPI
         Ps1A==
X-Gm-Message-State: AFuF++nFIP9sZycTl52RttqlhznVrpxYKLVDdjMpkLXG7qNlRkG8fYjZ
	w2rmJhAgwpPEFIrw+A+eUQK8DoAlvLiAYSqjVUT2ClmDv9Vuf6ppN0kWn4iiDbcmdKOK765N1uJ
	rgWYzsvjpmy8YRkqtdnA74lnANOxmFXCG3EY/ExzKiff8884gJGhCGznxbrmPN+NHItDGSYEwYQ
	==
X-Gm-Gg: AYBFou18WvC/Nwp4T+A32fEhEwSYlkfeqi+IolIeFnXUKaQ0BvmXrc/O031uwer5IqE
	6U7iykVgjcPZIcbliIF2+3Vd7dIy8DFXAJaSHHxY3go9kEgUpZa6uysS3rRrHI2nFK5FRP3WgNv
	QpklB46hSUM7W4Ri7MwSDdMScehgdp9H04tfleQ5Yrgd1NiVUn7UwiIbMReg1s/bsEfUJ4z5Ctl
	x7wB8NWJsuhqx3Ua6Q20DwG+AFfAU3URPh5PHE7U1HaZyv6bICijx7X/nznsawMrjKsm9hw+hJM
	D9QGeuQfxOxgBDRwQTHuglqgIDG3I34FEtsS9Mnl87S/o+lFd7cBUVmdevrtgWIJtMts/T9R8dV
	iQXjjP0PdkmigMaKDXDTzsNhgcGDH3YTUkjSC7MjBKEUvSnPfQayITDAfFc7RR9Z7Q4zs9Q==
X-Received: by 2002:adf:e19b:0:b0:485:a46b:bc13 with SMTP id ffacd0b85a97d-485b30e56d0mr1667221f8f.0.1788961064821;
        Wed, 09 Sep 2026 06:37:44 -0700 (PDT)
X-Received: by 2002:adf:e19b:0:b0:485:a46b:bc13 with SMTP id ffacd0b85a97d-485b30e56d0mr1667107f8f.0.1788961063813;
        Wed, 09 Sep 2026 06:37:43 -0700 (PDT)
Received: from sprawlopolis ([154.62.191.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bbb51sm46791526f8f.30.2026.09.09.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:37:43 -0700 (PDT)
Date: Wed, 9 Sep 2026 14:37:41 +0100
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net 0/2] netdevsim: fix IPsec debugfs byte order
Message-ID: <aqFhJbNp5qqlehD0@sprawlopolis>
References: <20260908140325.13367-1-andrei.gherzan@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VLgbsStmR6asIkJ2"
Content-Disposition: inline
In-Reply-To: <20260908140325.13367-1-andrei.gherzan@canonical.com>


--VLgbsStmR6asIkJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26/09/08 03:03PM, Andrei Gherzan wrote:
> The netdevsim IPsec debugfs file (used by selftests/net/rtnetlink.sh's
> ipsec_offload subtest) prints the SA salt and key in host CPU byte
> order instead of network byte order, because nsim_sa.key[]/salt are
> typed as plain u32 and printed directly with "%08x". This makes the
> reported values differ between little-endian and big-endian hosts for
> the same underlying key material, and breaks the selftest on
> big-endian (e.g. s390x), which hardcodes the little-endian output.
>=20
> A driver-side fix was proposed in 2022 but stalled in review: keeping
> the fields as plain u32 meant sparse could not validate the added
> ntohl()/be32_to_cpu() conversions.
>=20
>   https://lore.kernel.org/netdev/20220308135106.890270-1-kleber.souza@can=
onical.com/
>=20
> This series:
>=20
>   1/2 retypes nsim_sa.key[]/salt to __be32 (matching the existing
>       __be32 ipaddr[] field) and converts with be32_to_cpu() before
>       printing, so the debugfs output is now network-order on every
>       host, independent of endianness.
>=20
>   2/2 updates the selftest's expected output to match the new,
>       endianness-independent values. It depends on 1/2: applied on
>       its own it would regress little-endian hosts (though it happens
>       to have no effect on big-endian hosts, whose old host-order
>       output already matched the new expected values).
>=20

I forgot to add Cc: stable@vger.kernel.org to these patches. Should I
send a v2 for that, given patch 2/2 only makes sense together with
patch 1/2 (applying just one regresses the test on one endianness or
the other)?

> Tested on real booted kernels, both patches applied:
>   - x86_64 (little-endian): PASS: ipsec_offload
>   - s390x (big-endian):     PASS: ipsec_offload
>=20
> checkpatch.pl --strict and sparse (make C=3D2) are clean on both patches.
>=20
> Andrei Gherzan (2):
>   netdevsim: print IPsec salt/key in network byte order
>   selftests: rtnetlink: update ipsec_offload expected output
>=20
>  drivers/net/netdevsim/ipsec.c            | 10 +++++-----
>  drivers/net/netdevsim/netdevsim.h        |  4 ++--
>  tools/testing/selftests/net/rtnetlink.sh |  8 ++++----
>  3 files changed, 11 insertions(+), 11 deletions(-)

--=20
Andrei Gherzan
gpg: rsa4096/D4D94F67AD0E9640

--VLgbsStmR6asIkJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQvNqws+Dz7aX1cEEc7voa356t88FAmqhYSQACgkQc7voa356
t89CjhAAsc9ihP4BOFOtH+fWmOM5lVZIpAeuppSpPCB9czlRzrua64EwObXfFX7n
oG9uQUzx2p3UTY52038DFCCsmCVxKTMPbQvfLoevy1SUXlt3ZqGW7p/WoaPalozb
c1zLAj99KWyKE9YdFd1D5dEzsDJkilxX7CSD51JExDzwpqflugcpJyVJ6JUGe/B0
JSkg7FL6XMY6w2WBer6R53PxG+vCHqhLV4M+vObbysVFJyoEUCBV6aFcZHbdxRBj
FLw58vys31n8/6x8vC6n2jjdoYTaiQb/4Bh1JtdZfKIGDmIE7NQN1v0OU9Hgp+iv
6BebVhgAUI2SB5I8tj67VB7Dm6TndFci7R9xZFsBxwN5pZ9P/LcGSz2MviBZronM
P7QNFq3Kl1FnBMwYg/dwy5K0C+HSHBKX7sQCUW0zuokREsSmfzGJDzUP0hZ4oNY9
0KERXDISjbWkBMZGg+AAv7oz6oHgkXBHjU7u5cS98cxQhYLCipcEd48bm5tgZvh5
HfNWJ0AScmeTps6vwLMLfjj9+r/zO9nAhuUNNxsoHlqLGbxmsGMldd+e8xU/wOzg
tOjdOwiLuGwq6vTqci6sT9iuKf3yW9UTsJwG6qNCCUXgQ50vnIkY6siA2x1cfCK/
cSEomDAKcGTrB/zi3iWZyLZb9TxzJaqMfTjOJjR5/Z6uJLmJwEI=
=HvP6
-----END PGP SIGNATURE-----

--VLgbsStmR6asIkJ2--
