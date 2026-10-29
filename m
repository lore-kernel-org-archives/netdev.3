Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253595;
	b=W+ztinGz+YCUReFj//NvGf0zLyrgyhf8G0jJw99sM6Tf+ZxMzjYZeRf8zGNyY8kG2wZZ
	 B+yHmPl/TffXDm7MXBAyragn8NsMp8qw9RQMk+OXExfGoLXXFxoimGlGIbdeA/TxyS/hJ
	 FiiH8sEU4Hl3ZXVEdQl+4CvxpHc5q472GHE3pBybBcYMWtWSdC1zAxD5rmT6CvSiGu2I7
	 S5K262JdRAsNeKxE9JyBNxXhQvDMyfLb82gYEARC2Aq+r9fq8WGKmVGRsGEKohMvg0faz
	 4f6/e2uwQU062QIBH+ZyLCUyOXqmHQCon56FHwNC1SecT6kZEcbDSniRX/qRvsVqPcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253595;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=zu/YNQAtvN2GiLlgMWk6gDb09vVd5tKgNFyrsU6ybQE=;
	b=4WwTFSEV0I8grePs6JUYKtKGavcFUXj90G5c5ObWTthMyJXyjtFiJk+xHMPSstmhRHp0
	 JF2kT7jPlrEdltj2zXd4JMmdGKeSVvAFTSme3m3oaUeeM8HFT+EvvpfZFVOzewkaULxCx
	 knpjyg8ORV2zD/Hx7OC/CbNKoQwsoU4uSYopIwLlOxTqJxL7CNq8CEiCFcreikrFT3mie
	 wwAwx39hBOc4SKIRd7y4MXpCobM0oPRo7BqroVc6VTpPzPiUlkhj9uHW9/W0n68VFa86j
	 0ogy2oBsWEouZkEWqez2wWvz7c+z8+eTASCxEn+1Z58RIVyFjI97k/jDiYZL7JMetog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TYYVsz+c;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB26606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FB26606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TYYVsz+c
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1304918a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253595; x=1793858395;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zu/YNQAtvN2GiLlgMWk6gDb09vVd5tKgNFyrsU6ybQE=;
        b=eRsn4GJqYBHlWwwjkB2MIENh7G3Ji1/XTNriwBNmkUNkT60LKRkNRBuhc0165aC6Ol
         C5ArYlUeRx3oiRe1sxR6GM+Bb+51pPQpyu6TDYv0YbVBx6srDqy5GhuQe2we0teYaddd
         qNcsiCSNxY7HneZ9Z9Um/hgdSBCl1HgpUKShbG7JVQFfTJJZCQ6hke1VM6zkw/yNQbyF
         hqgxEPRd01qk8kQKmOUhCnAKuJI17YDRn53tsuogNn3U5Mk1hogu0u6xMMVziD0UUK7U
         AfEUmHiSSpACBuuJSVl15wQIkjzkjIzJ0HoMH5IciPkIyfWr/m4Gf90Ft4s2e5tLVe5j
         Z3OQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4wvV9/qniMbwVgz5K2i6TmKC02iexA3DgsZfil/BQ1MT1Ag6UVh7Bro2HKkjFlHardk2Q7B8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPS0z1bO8rislIRFddquwlmABK2lRZSsqEvm2nLquMsQmylM6/
	Nm6Ogv2i7pqRVgDvcXwjO4NmODw8FM0Ffdzrksh9qBR1/wrwxrt7s7kIFlqSA6hgD9po3CAMyMQ
	pdZZPRUZOcmh6QySnQz5Ulal8tlE3MCIPluOJZteAt+DvDCN+zLPTUSpuTqZDROJ/u1TPZyqPJo
	pubArF84qLVLWkl3C2AcZm1xkqU23go953sBtWt1hKQhSh4+i/c9GYpRhN/eaQ68KaiD1S68Mof
	UgB6Q11hMM=
X-Gm-Gg: AYBFou3ksbp1IA39EhRLkpzE977HNATneN6GL1EIhU7fdyJz4plnFVv8Hdz0K67ONiV
	BP4DEzc8v+CbR6InIomsKNnO51exsD4PGWgQyU9Ih4r9G5GY48JI05Jsj2csHX2Rq1wlqorUzG9
	cSaug2+n+Ql7usi8c9c9BWgMnC+A7KbLLIllKG0IpVnQscAdL6OWu/TKBolNwu6Zc0LUKQUOa0f
	UT8tjpiANzlYIjoKV9hO/E6dDFKp+iBnumN10WsI8rR5M9lgjQFR2ujZVS9xvt3SHwU/4zOzWWM
	uMj7Mf2AZsZW/HVSV5dryRuAfBDgtsKapfwIXb2TWojNJvzihygNVsE35f1gTTF+agpUOWNP6vz
	37OoTc5d/v2BhtxKLm12Tmpq+/PY8w9nM2KZAsaRANnHKmqk2WsH8hm0nLbGnLGYh17wdIuqfVH
	dUfseKtEgH04p6t+ZDnTDtwDeZrrxIq5I5xfk=
X-Received: by 2002:a17:90b:288a:b0:3ac:9706:7739 with SMTP id 98e67ed59e1d1-3ae5819e5afmr3682100a91.17.1793253594602;
        Wed, 28 Oct 2026 22:59:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57ae6cb1sm1107219a91.4.2026.10.28.22.59.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 22:59:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c37b2763f1bso187812266b.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793253592; x=1793858392; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zu/YNQAtvN2GiLlgMWk6gDb09vVd5tKgNFyrsU6ybQE=;
        b=TYYVsz+ck8WufWf4UAT428xCGIcB5ja4CpZQ96sEn/iFk5X+wGliQ7OBWv50oTIQ9a
         UQgnmCafSY2TmIO1GC37bTvbJdBj6Pxwz/AeKK58kFMkYMe+8qRr4zOeWCKFjKCBRqUp
         DHb0yIz0e3dlqW2DR9wHjJ+5nkLSg5YkqkdGo=
X-Forwarded-Encrypted: i=1; AKwUvBzLi+vb3mBK+/uGQSRvv1ZVj/xLaCypcDwWQeSC7F64DJkeJa9YRz70UaC6rTNGZx1AIdmzvg8=@vger.kernel.org
X-Received: by 2002:a17:907:868c:b0:c26:1648:a06b with SMTP id a640c23a62f3a-c49bdf5c1e6mr384888966b.38.1793253592395;
        Wed, 28 Oct 2026 22:59:52 -0700 (PDT)
X-Received: by 2002:a17:907:868c:b0:c26:1648:a06b with SMTP id
 a640c23a62f3a-c49bdf5c1e6mr384885366b.38.1793253591464; Wed, 28 Oct 2026
 22:59:51 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027234940.1267225-1-kuba@kernel.org>
In-Reply-To: <20261027234940.1267225-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 28 Oct 2026 22:59:39 -0700
X-Gm-Features: AclHuK_hvvVBJhxASauqZDPqt6KyvybdTMP8YQrJyBql3D88As866gH-hUPoeeU
Message-ID: <CACKFLimhAH+1JT_ommiBoXfn7UDQ_bvO+jexrRRQNKxaAo1UMw@mail.gmail.com>
Subject: Re: [PATCH net 0/5] eth: bnxt: fix Rx buffer leaks under OOM
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, eddie.wai@broadcom.com, brett.creeley@amd.com, 
	ap420073@gmail.com, joe@dama.to, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000611a9c065ef4638b"

--000000000000611a9c065ef4638b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Commit bd3beb5c8691 ("eth: bnxt: disable rx-copybreak by default")
> changed the defaults putting users on buggy(ier) driver paths.
>
> Fix various ways bnxt may leak buffers under OOM. The first patch
> fixes the real bug that was hit in production. Second patch fixes
> an issue I hit while testing the first one. The next 3 patches
> fix other Rx buffer leaks pointed out by an LLM during review.

For the whole series:
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

I've also asked Andy to review these patches since a number of them
are related to XDP multi-buffer and XDP_REDIRECT.  Thanks.

--000000000000611a9c065ef4638b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD6qc4n
A0Ddsyg5SL7BYX+u+oZycUOj0trKaj7llIHMGDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjkwNTU5NTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA7foNsjbWZHCNqtPVBhR3kQkRM+CnufSa4H5ZXwJ5R
zITqALls22tSmyAt+/GaImsgQyJUU71AMbsN7Oo4ubf4mVvADoHyt0VnkrjY4QSwi7tnrrwpZBe4
t9Z1f1wvNsKZUijh4ls6oZ+OVILADguLEw0dQjjzRps59EGV+738Mes67kQmrMYRqBMmnG+meNxp
mw9byMqvVXlD8UtqJvFZPfAyiWPQCH+BfQFUETXc0d1wcybJcVeBdztp+gWDWIntnEAUjAf/Cg/u
DUmQndKEQ1f9W0sTZKQvGThOePSejo98fI1AillPAcYQykD+rpjJa4ZWcb4OE0Hp3WqnlvAD
--000000000000611a9c065ef4638b--
