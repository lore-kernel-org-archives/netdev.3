Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687240;
	b=eYRWi/0v/Z+914L/DpGwT/SqZR+8frh/Ju+8ho91wi7Nd7ELwZUnVOZcPiLKVOSyt20K
	 auHUqxU7cJSV4Ls+06PhaqBVX1JbhsaqIqiHivbxuRMVkR63/pcXmiA6KPQEPicIxW7LX
	 5AmHgozzntt4FnZbgbBAgVPC5+8PJqa5ViEk1swII3XTRmKthbHS2IRvMZzogTHZ5KPHc
	 zS9QeG46rCf2XeT4SNdDWTFtihTRVBNFDbzrMoTeNp+zWASm7ySRd00hKV8gKpGYfYs1G
	 9zFEIZBYVkFQcnyrJF+HNSy/HXqu4CNz+uI6FLY6MOxiS12y3nGdrw1GPf9Pp3FJS9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=qm7RBlZCRUghi/5BcbUocOcltZQXhCKJ5nr6Yg83jes=;
	b=GIjKIkc1syt12hfB0cZ1S2zV8lIN91T8pUQyopia2qLKguTt4xJKwiof8fqvN5WEPOdw
	 qGjrptP3FZPL6nbBv3LaC7hWtSGszn9z5DA4/nNPBCJOykVkjQJiK4rg05Ey4+WT45ZF4
	 I3Y5GYxrqh/4F81o+r5l8ML+yMLOBoOBM+YcE9c3ACEuCTgKONGgFFemWlsGrwQ2wLpuy
	 uQWjX1nypU4WLk3M3zv5aq8UBkW96n5d3Sz7A1nfux15/ysML4bx9KGw7L2pc5aZUNtdo
	 k3rU+x2VROJgaQe3bfCOlCy/JIurVcbyGgo9tKiqrNw/0EG6bQ3kPZJrCBiNStPudFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ck0d1SsI;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88F606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 06:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A88F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ck0d1SsI
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so28111435e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 22:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793687238; x=1794292038; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qm7RBlZCRUghi/5BcbUocOcltZQXhCKJ5nr6Yg83jes=;
        b=Ck0d1SsIb9J2TScJRZb8PI7DbL1JyJBgkbBrgDb6rv8d8YBiYSF7N1km2zjNh+Sg44
         wsQqez8fYt3VSy21WkbmrXolVTEf49+H3CWj814Vm5ZIKiSBu/bxD8P664nn8QQNW+EH
         SQlVA2/cyAvm0lLTS6EHeXSQ/7m0qzgIYBF5ZrJI5dYtSAp7H+YxK75yFCVAKlwDoQfa
         jfQ0Ias3925ywO7STj9MU17dP56Skw8ZvCmKJp5qgs/FpFLxhlfE0t9hwck3UjeTvMku
         jXzLOADzjhByXXCN2QsopevjsvYpyista5q0ejnOyyXUEw8LHHQmNE5fU1b7obOntmf+
         EFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793687238; x=1794292038;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qm7RBlZCRUghi/5BcbUocOcltZQXhCKJ5nr6Yg83jes=;
        b=GbFsAUSJ7h1zMH4vqXKbsW+z2lfxsmg9zPiWAyGkMuX/YlAFirC5GxET4R4GxBX5Jw
         xmyCcclOf8Kp6eprBKHKWQUXRe0jWGL33QJcPsbnmFB1yWtxpVJVMwSHJ863Gv5eK9dk
         YrC90J5lzIc3pIC1U2801YGaknatYr/x6HfCKxnRSEImKqh9mUvnzvWW0xZ+nKNcFgxa
         3loI9JioBOXtmRL+1EcXsYUkMez9EWAej3PJeLpbPY+J2a/TFhHG3sqeCEe/y6DogkHC
         HiC+9T2R6IA7aR+Cid78yv6mLjl4WnycDzfv1jgghEOLZ1tS4opKDG6SNrW0YwGolYdj
         YEjA==
X-Forwarded-Encrypted: i=1; AKwUvBz02Ct2g3So4jQP4UKVgGEzczu3PVq18xHDb0T5NaJhinlPlhH0zqdxKw89B2/hwm5bzVUiLXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oTx4vF1LtuSuN2o96a6BcPqqzB2DyjSGPHmkfZoLAFKxhn5uP
	lSmiyJVeeO4r2z0zw0n1v7mF6G02djo695uGE/7vTOW4wMjEDXgR9BptKrpVh+sYVA4=
X-Gm-Gg: AYBFou3qxiVSQ9yzV5dOwZ0CE/963h6HGBbd1m7nqikVScsh11l7Ky5RwSX1/R+V/X3
	Mg+M550e5AgzOKyhGpMunU0iPubCXwbjH81T6V9eXgvEwVrLblpWIfTutcDGnkNga3dMooGerFH
	TdwXQp9RG/+NOFyQEaQzX0l9U4B+ptKsyZQPG8nQ7gD+W4KpDRpcSkdgLR1NU/2/EiNpYiAkYrq
	Prbj6YOb3pvc9oFSjRkZtFMRqsms4v+WPtg/KipTuHaxEi55WnHT8ePZwWBKLtNrQ631oMulzLw
	7dt+hsc9zVvqShU1WmGL7HgLUj3EtsmoxiF66gtzO5zfdZA+OLgC93K2Fd7JFDPpZkWDvYO1lhl
	dw1in4ZBcXA97jpPbX2B9UhYHwYAbuHEpXCNJVDXhm1ysPaEElvLq2p8SYZgxMhIOu9E5BVfOLI
	3TcfTcRgREJQCoR48I1AsN2p6sG0zQtafI6tPr3KhDkdlCxnOYIkBq7bT2jv5raf8acoYV3rNa+
	zwSirS1kCEWsucGc2WL1lqzN8Ie/SuKTQuJRn84jwoewqJItWQs54Rf2pgxQt0NjhIC5MMBy1vb
	Aq2BKb3xC32FLZHGeny0B1KpLQyGSK2j9mFQblV+v4quNh9Rc4uLGKlufbfjVUPO/0YCX7Qo/ia
	iJT6PQsi4EN0pV9WyroSAFhjFYtJuak93QBEx6h4WZa/rCgsjKkE+0w==
X-Received: by 2002:a05:600c:8116:b0:4a1:ddaa:571e with SMTP id 5b1f17b1804b1-4ac182dc29cmr262901645e9.15.1793687238545;
        Mon, 02 Nov 2026 22:27:18 -0800 (PST)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aaa4b91esm31435585e9.11.2026.11.02.22.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 22:27:18 -0800 (PST)
Message-ID: <f1e18482-775d-4e1e-a0ac-434117ccdbe5@suse.com>
Date: Tue, 3 Nov 2026 07:27:17 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/15] xen-netfront: don't BUG() when
 skb_copy_bits() fails in bounce_skb()
To: Josef Bacik <josef@toxicpanda.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Mina Almasry <almasrymina@google.com>,
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
 <20261103-b4-skbuff-bug-on-followups-v3-13-54ad0ab57614@toxicpanda.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-13-54ad0ab57614@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UeMRSVPXLO3rcUL0x2eyyOgz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UeMRSVPXLO3rcUL0x2eyyOgz
Content-Type: multipart/mixed; boundary="------------Z9TguYYJlyfG8Pe4RfnPxIJQ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Josef Bacik <josef@toxicpanda.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Mina Almasry <almasrymina@google.com>,
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Message-ID: <f1e18482-775d-4e1e-a0ac-434117ccdbe5@suse.com>
Subject: Re: [PATCH net-next v3 13/15] xen-netfront: don't BUG() when
 skb_copy_bits() fails in bounce_skb()
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
 <20261103-b4-skbuff-bug-on-followups-v3-13-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-13-54ad0ab57614@toxicpanda.com>

--------------Z9TguYYJlyfG8Pe4RfnPxIJQ
Content-Type: multipart/mixed; boundary="------------JK0D029qSPZ1FSajkanwEGAL"

--------------JK0D029qSPZ1FSajkanwEGAL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMTEuMjYgMDM6MjgsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBib3VuY2Vfc2tiKCkg
aXMgYW4gb3Blbi1jb2RlZCBza2JfY29weSgpIGludG8gYSBwYWdlLWFsaWduZWQgYnVmZmVy
LCBhbmQNCj4gaXQgaGFzIHRoZSBzYW1lIEJVR19PTihza2JfY29weV9iaXRzKCkpLiAgc2ti
X2NvcHlfYml0cygpIGZhaWxzIHdoZW4gdGhlDQo+IHNrYidzIGxlbmd0aHMgZG9uJ3QgYWRk
IHVwIG9yIGl0cyBmcmFncyBhcmUgdW5yZWFkYWJsZS4NCj4gDQo+IGJvdW5jZV9za2IoKSBh
bHJlYWR5IGZyZWVzIHRoZSBuZXcgc2tiIGFuZCByZXR1cm5zIE5VTEwgd2hlbiB0aGUNCj4g
YWxsb2NhdGlvbiBjb21lcyBiYWNrIG1pc2FsaWduZWQsIGFuZCB4ZW5uZXRfc3RhcnRfeG1p
dCgpIGRyb3BzIHRoZQ0KPiBwYWNrZXQgaW4gdGhhdCBjYXNlLiAgVGFrZSB0aGUgc2FtZSBw
YXRoLCB3aXRoIGENCj4gREVCVUdfTkVUX1dBUk5fT05fT05DRSgpIGZvciBkZWJ1ZyBrZXJu
ZWxzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFu
ZGEuY29tPg0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29t
Pg0KDQoNCkp1ZXJnZW4NCg==
--------------JK0D029qSPZ1FSajkanwEGAL
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------JK0D029qSPZ1FSajkanwEGAL--

--------------Z9TguYYJlyfG8Pe4RfnPxIJQ--

--------------UeMRSVPXLO3rcUL0x2eyyOgz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrpfsUFAwAAAAAACgkQsN6d1ii/Ey9G
Hwf9FJEDlIAKlrN0LReV4G5SBlmTdNQmOcImldWQvj7jxPTvL2bSDelDyahNVKGQ9VEQrYH/eCuR
LPbz/2R1sNpgzLTWs6glst3C0lUEAgHkPYa0PkZ4PKKhsHaB2WJ0CmqCl8XNcoWtnJA7TQo7JZbG
gnKud05ZQ3jGVjaiMtmhlUqkVsAspm/pEexy03JqEnYoKYKMw4JW99Oxdd3efl3VoCp4O3GKIJoS
jMdKiK4VnGtgnYp2i/JwtNUhB6MuDhssXb7+JUcrtvmK+pnWtqrxFb0ole11CSuYLoG9OsUi4X/S
iDzPWulUKXJWD6zpkxiHoXEI2voR3tagcqqd7EcJ7w==
=kqT7
-----END PGP SIGNATURE-----

--------------UeMRSVPXLO3rcUL0x2eyyOgz--
