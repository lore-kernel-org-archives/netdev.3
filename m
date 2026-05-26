Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86E3FF1A3
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805095; cv=none; b=fEVCMNyRrJ2xBHXH1VphX2m4fr3bGlos/H6aWAH5zZ69TEBapB155vCcdBbS89MX+c6xwpr2lBiPMT2Zb7sJprBbFOMndRrMl8ZVb2Q4e4f1PiVlGqkTGgtghz+v5VLDv9KQODppTCDbu706e97Ic6lPiDCboreJktoKORe3OaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805095; c=relaxed/simple;
	bh=O6ZANkPDWESLVOJUSi+kCcqTY2nIOJdrdaCt6w5MrsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQELFFYu/NdgPs0D4IW8Wcak1NE41ZZ9G6NEV5ju70BXmejYWNyE4RGlEyJC5M/2gVPwzhQJ2HspNmTJd8t5F00rGn79G6Xx9xxXCwvIx5TInRWDNQQ05WIY9++FWVsT6I7Dvt9DNptXZd3nkWeMnCdKBd/NrY2NXMo3b8vigng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=nMSqzbZz; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="nMSqzbZz"
Received: by dvalin.narfation.org (Postfix) id D0A4E1FE5D;
	Tue, 26 May 2026 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779805091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcA7XtyXGltk5H+OKUZ/7bSf2zntXwWFan/bkQ0o9cE=;
	b=nMSqzbZzX9/xIcSgQFQ9WikWFppvKIDoWUqk3COdeXGjLQ8fkttap/NtBHoqRsUj+0E+eK
	NL382xGfq/VqQZSBQQ70EdIyr0mDSk4d+LNaBfSIPc7DPCGQAKyH5PhlVpbcCZNT9hf1fA
	VIn5LdxB6oh+1qSCv0T79Ln04eqZrBY=
From: Sven Eckelmann <sven@narfation.org>
To:
 =?UTF-8?B?wq3rsJXsiJjsmYQgLyDtlZnsg50gLyDsu7Ttk6jthLDqs7XtlZnrtoA=?=
 <swan2718@snu.ac.kr>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] batman-adv: fix DAT purge use-after-free on teardown
Date: Tue, 26 May 2026 16:18:05 +0200
Message-ID: <10856691.nUPlyArG6x@ripper>
In-Reply-To:
 <CAL3z5EbfEeMn-2_JrvcXRtuKTtruEf+8MX9tCmn-N9edvvrjwA@mail.gmail.com>
References:
 <20260526064835.2233822-1-swan2718@snu.ac.kr> <14018241.uLZWGnKmhe@ripper>
 <CAL3z5EbfEeMn-2_JrvcXRtuKTtruEf+8MX9tCmn-N9edvvrjwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2352248.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2352248.iZASKD2KPV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 May 2026 16:18:05 +0200
Message-ID: <10856691.nUPlyArG6x@ripper>
MIME-Version: 1.0

On Tuesday, 26 May 2026 15:56:58 CEST =C2=AD=EB=B0=95=EC=88=98=EC=99=84 / =
=ED=95=99=EC=83=9D / =EC=BB=B4=ED=93=A8=ED=84=B0=EA=B3=B5=ED=95=99=EB=B6=80=
 wrote:
> Hi Sven,
>=20
> You're right. I re-examined __cancel_work_sync() and confirmed that it
> internally disables the work before flushing, so the re-queue race I
> described does not exist. I'll withdraw this patch.
>=20
> Thanks for the review.

But you said that this was reported by syzkaller. I can't find the report i=
n=20
the official list [1]. I am guessing you have a reproducer in a private=20
instance and tested with it. And if you tested your patch with it, you have=
=20
found that your patch fixes it, right?

Can you give us more information about this to let us figure out what is=20
actually going on?

Regards,
	Sven

[1] https://syzkaller.appspot.com/upstream/s/batman

--nextPart2352248.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahWrnQAKCRBND3cr0xT1
y+YjAP4mjdybqYAhYNFHxwB50gsr7/IZmrwAhlyRjOI5weUo7AD9Hw8JGIxkIEgT
zzKWPbt/x5y3Y44n01Itxw4BVjCYtA8=
=zlnD
-----END PGP SIGNATURE-----

--nextPart2352248.iZASKD2KPV--



