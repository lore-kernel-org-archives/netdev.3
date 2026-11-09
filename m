Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248796;
	b=cCv/pMz+tWamtrOUVEOjs4AerkbqRetK0+8EJXYw3AhhRTo7Uqfi2wW5fzly+vlbfzya
	 2Pa71i/oAB9bvp3KhJfTnmbGOG58vVZR4c3bir/9g7ykDHLf7/xjDMhghVGcG0YIFS4Xd
	 dnwJ+ZrvD4h+guN7GMh0e2DqmTp9EskfJl07HoZuXCdOLT/So7B0/H16h+ul+ByekQXVh
	 XyrpHnOhS5o2VyKQ0Ty895pAysOnh4Zode8Egjwe0GyUiJIWStpYpdl89teVjafmSF3sp
	 M8+10RogzSdUwUujLdJ2EfmnqwJa0EqsL3oQScT+r2w1AZ4668Ms3lyay0XviFczcGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248796;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:X-DetectorID-Processed:
	 Content-Type;
	bh=u05FVnDBUJvpw9yQDDIfSXiEpRRah/yv8QZyjzVJXFA=;
	b=w7nSFyf3h5Z/6DK5XA/FwEsgbhv854Uq8hrYJTOzLYrkCPQMmQ6MGhVRPVMrdGKTNYPm
	 EGUvA1VrEOsAG4olbs5A97ITPnxuc7reE0n7cXHFQEIUFoKr2vEbh0Mu4TmAM60jkSCQw
	 Z3c7bCDbX6/G0EJS+bFLDPFswRVO0SHraC+E37WXHmSF+wemWALNxE0aBvg2o8eVCxPN+
	 DctiPMhUpsE6KQHCytgwgzb/j6d7J7cEJ94M25MV2V6fm52wI6O9RLJFqdPY63hsPmkLK
	 5/vUMOLHsG2LTIJAs5aEpQgSMF7Z1oKuULpf5ToBt5j1IziLQmDyxypKTKDB7gJ4cPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NEfwtfsm;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7126606AFCC
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7126606AFCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NEfwtfsm
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc758830601so743216a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248795; x=1794853595;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u05FVnDBUJvpw9yQDDIfSXiEpRRah/yv8QZyjzVJXFA=;
        b=f9iFxGP8pLaCix34Ki6wduuLgdpMg7LtzT1VQC5NcJ2l9zOIdeYFoU1xRe102mz4EC
         gh44No7h9VpEF8sdFM3Zz3LcgQ7vUrckoRL9bYoGEo3/VmWNoF54bIbMtNJVHG0flCZ0
         rN4YT1hfxD8l2aY1WLcqgt8UEfwvQ+MH1npAbuV9vsZRSrBoqk5ZXDNvpRy7QH0MCjtp
         Z+UBks8afdfFjNpSZXB/KsUEt3PHEu5eiuDZScbDTlmkFd365SiEFqpZfMDgr36jEqXk
         0AU2gMoTJIl4ysJt+KvnOhBs11guKOMpYiowNlf59hvTh13HRHFt+MJR7dD8gNeMw+U8
         qZmQ==
X-Forwarded-Encrypted: i=1; AL+hErHuD95rG3BjHBxrgEQfskCyZkOCl+NJ5mPECqNF85Rlpf1rg6nTL2/2ThN5CU1u+o7DbWooD9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2LL5/Dw09AQeXlsJa86fHoFDTx6VEjCRGaE7176IQDoyiszT4
	5KF3+U8nMb2jjoCqC/bTc/cuRAlh+jv8FK9E6tS0lLqTeREBLMaKmPk9IY0/OP0k1PPcMbfTDL3
	Q4OIlzlkqJCk2XZ7WsvV+K9nwtNQ5Lwp3pXx5neXA+ZdtagCohFktzocRNL2c6lfT8j1kTB/sjp
	XV5GJjyff7exVudEosGDOlA3L8Xbt9tUrA4/APidRyvlhsy+BPnaJVXsIUYeHCauo4TG90bcBzz
	s4tZz04jvM=
X-Gm-Gg: AYBFou2IQVMkWjOdnoSJ8L1KXmOK5uAuAT+NA3d7kup5wSCWDaREpzBukhn18cwntle
	LoUeMMPiC7mJVIdpNFkhYKUe0YcMzcD2N2CRc/PQLPDvGReJ5c+mbPT/LqYrVk3oD5PoFXRtc59
	xjWu4iWqoED/TAHX6mwt/Oa8gOMMlzM3YZnpLoHLSgRB4vUGGrrUrfVyLAdqqZ3y6Zba7Sc/wqs
	/hZjFHANfs6NXqOvny+s2wwHldzmwnnGoWXWvC6fQmKLtUP2R40dj68YMMcFIG5hVo1Zs7I1bmd
	IzgJgUG2+80lUAGzopGvRNZ5x8JKqY9RwkKpnj3s8e08aQuvx6YPSrEG/YVLFtgmgLAxXNHi+TA
	I14C9t8G4I9J0kvHtQ/ft9Z498x+FOuTILSW2jWdKIveUwdX55rbJIr4JiN3ANHyZi6AL4OJx7r
	GJcqaNK3QwaJHxiA596Kcvivxbt1vu3IRvMX8=
X-Received: by 2002:a17:90b:5866:b0:3ad:adfe:5854 with SMTP id 98e67ed59e1d1-3b166cbbf52mr480504a91.40.1794248795018;
        Mon, 09 Nov 2026 10:26:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b16797a69dsm174968a91.8.2026.11.09.10.26.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:26:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c4d4d132bbeso123863166b.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794248792; x=1794853592; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u05FVnDBUJvpw9yQDDIfSXiEpRRah/yv8QZyjzVJXFA=;
        b=NEfwtfsmmK6XLjixatgpY7W8vYLoxzJHoM+lyIOA+POQl4CXJm/mBVTntpPh80zbck
         TCLxVfDi3rlk+3Md2JHnGSJ3QrGpTV5iXMHNCssnFdzFJCP/t0mH52Xu/DOTGN9HOD4A
         h6CPHCooTHBu9MYA/pZ+pabRfHroJK42UypWg=
X-Forwarded-Encrypted: i=1; AL+hErFs6xyXwkhhWs3hl1VvacRecWmcKvXtJg/4LQriDBV10S52IdTOvGV+tMImVF2yqdO1GbpT4l4=@vger.kernel.org
X-Received: by 2002:a17:906:4fd3:b0:c2a:4847:231b with SMTP id a640c23a62f3a-c504971a8e6mr13366866b.24.1794248792012;
        Mon, 09 Nov 2026 10:26:32 -0800 (PST)
X-Received: by 2002:a17:906:4fd3:b0:c2a:4847:231b with SMTP id
 a640c23a62f3a-c504971a8e6mr13364466b.24.1794248791591; Mon, 09 Nov 2026
 10:26:31 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106191423.4194081-2-joe@dama.to> <179408152976.994134.11735257663578231009@kernel.org>
 <avIGzUc6WaGgYBKG@devvm20253.cco0.facebook.com>
In-Reply-To: <avIGzUc6WaGgYBKG@devvm20253.cco0.facebook.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 9 Nov 2026 10:26:17 -0800
X-Gm-Features: AclHuK_S-1r3HvHQhTzNX5vnvw08UgphMWKN8-YDiqeLjNoKJmrz8XXzentSisE
Message-ID: <CACKFLimsTFE_-1uL5LH9bcoCze=hofB+OukqS4jj5DzY_7eW9g@mail.gmail.com>
Subject: Re: [PATCH net v5 1/4] bnxt_en: return the RING_FREE status to callers
To: Joe Damato <joe@dama.to>, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	prashant@broadcom.com, edumazet@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e78242065fdc1917"

--000000000000e78242065fdc1917
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 9:45=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Sat, Nov 07, 2026 at 07:58:49PM +0000, netdev-bot+sashiko@kernel.org w=
rote:
> > By the end of the series, bnxt_hwrm_ring_free() counts stuck rings only
> > for TX, RX and AGG failures. If a CP or NQ RING_FREE fails, would
> > bnxt_stop_dma() be skipped, with __bnxt_close_nic() going on to free
> > that ring's memory in bnxt_free_mem()?
>
> This also seems possible, but this is not what I observed in the field. O=
n
> three hosts, the NQ rings failed alongside the RX/TX ring free failures a=
nd so
> if this series were applied DMA would be stopped.
>
> I suppose it is possible that only the NQ or completion rings fail and th=
is
> series do not handle that case.
>

The NQ and CQ free operations differ slightly from the TX/RX rings.
The TX/RX ring free operation requires a feedback loop from the CQ
using interrupts, and it may fail after an IOMMU fault.  Your patches
target this mode of ring free.  Perhaps you can elaborate on this in
the commit message?  Thanks.

--000000000000e78242065fdc1917
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBJbQJp
RDtgWh7AMzQpx8NZ2Lnq/D5Cvv/VK+nVFvaBITAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMDkxODI2MzJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBLeX+FEZUxtunCVJerPmQKDvbbWviVNFz1Uuv7PizF
6vHc8sxVUvzd8uW+EU75bDxlIv6PZVS7yeF66DwVgDQyPcjz4eZJpa1/nQ7nbytEqMI4XwYvf1rh
ZFRyVyNokTEaAlA1uc3dvnGMjp2O1DhPjdHKLjGT4SFjfcWLMjFugA0R8FwLCS+pZ7if0xz3XLRc
nNEWeeVvmxAiZP47KQfRONmjrxYILQM07pGIofUUHQ0leJjZlPea5SBN9xi9Gj/a86wF25g8x5/d
SpVpOu32CYwrEJoS2yBXkoRmDVTZTreioenB2Fh4NCRoPWXeuoEHexIexGP/Xc8kyg7E2PCD
--000000000000e78242065fdc1917--
