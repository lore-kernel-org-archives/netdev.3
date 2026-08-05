Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3C26D4C3
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909776; cv=none; b=nxzJthAaH0FrFmUMEJ2Vf9RJI5258o75Ux3+nu/cLwaangWIsR47jOjhluBxp2hON/NfAyBpY9HY6abtJS39zcHIsMiXF58r6RuGNl9iQFFZyzsXPUSIvBBYhNncpC/DRb9bavIc6iVylfQ6nLPWr39PsWaos14oxmdRVwYbIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909776; c=relaxed/simple;
	bh=uPH/VLZhlnHyHYhv0gU25CaOTAYK5reGd8d9C9D39gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUk8183T3CzDGF9xieHp6qjvcRumxiEPLr39KPJwEZWpdeflBx/izykpBbP5IoPTekbKAALxVWeICt029xj69f2cUW4Z/oI/Ot3runckjqUSvIONuauG35etyR5B+QMLJT6jQBorQVrrgdlI+SGuAfNKnPCryaXt34IYqRHlicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wzikbj68; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wzikbj68"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso717109a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 23:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785909774; x=1786514574;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qSWm8erDkMdqn2vK00vAqeQwRIm1DJv5B4tfEJjKMGg=;
        b=DGqZ5/DCmkMcHWQc6G9V3Mak43MFaThjtRcScYW4absBme5kk63GaD0eVUq4aQXMGH
         SN3hJ0jeUFY6Jzw/TjicBQIQVKcL+DAvghaLPMMdOmcvv9x0ShmhRDAE+epJMmGBVrGM
         p4+v5e+MA9xqQahmH4+W5vuNFw77UW9GAX+oFw+YYi9/9phS0KpqJ6wvZasjQbuKPc/3
         WNGENvl2FgbACZs8bcOFQBjWnWFsBCrjJf+EB0TAczSYMoo9bzylscchRxP9Fb19iP18
         dV4v1OOof7/PtUFycJi3nIYnhJVDoD9QCJQJS1WnxaRnUyUup2hpUuezTluoKnoenXh3
         b8yw==
X-Forwarded-Encrypted: i=1; AHgh+Rr31txDUAErU6W9pet5hRvo7YqmShkPwb7Lty1md4aU01454lpxDEi1wrApCOdBiqovo4v/dXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOK4ckWHSmuTfkHjZ0yu3WGhWuAe6iu6nTTl2kfqIivIlNkQ3a
	2l3UekjU1opvM5zSjICqKGMwb6JMhs/8+NKVV+v89MfyNN4MTOKPSyR0p+t0zOyuA0BlXclpc59
	SjRfmq4M3ZzULBEtdNYOehi0mhuXiT9IASMhADdyaOHc+m6biXBqre5NkZRbKEq/yOoO3ezS+fm
	49dxyE8o0M8ytEqZ7Fir0VHR9PyaJQShpdpUTogtQmjIPQtxo1TXSAHJefpopWtQluSj99B/H9o
	5X5VtBGB34=
X-Gm-Gg: AR+sD11t8NqWrk3D0OalIbl/En4IKwxcvmoxverDFJ+hN/kCmUGlCZUdOwz1KPGSxwM
	fvjzrkIYw9SgWqS5hCqWiGtd/85GxiOQf4fASUypbgDyl2vRZQT5N/ghjbRv33jPdOyz+pyDLh9
	f7s3LeLNpu6yC/c7O4sBg4iYIXW5JV3Uj1sJTcdMAfyGjFaLsQM2qw4V/GGj2ey7GgY7JaS0EpL
	KVvi2IeTCiJ2pJP2X1nNVHE/IzDI8gcwJvdZOUrh9Rs2e0SQzepToBuTqomv9Lu9sktcyATi145
	SUksLGpToXWqhpDOMjiHu5pfd9+AwMeAXjAwNUDdmZeFx6ESsmcorxBCH3PR/YDOYg6fmAm5VRA
	mEwK5WwpH544srL1k8KsJkRcuS5t4LmtF+DVVmHCatbvyqsywDF1UMOknBkZlRlLfjLnrLh2ck0
	2zMCrT3BocWKlSVlF4mknExZ+C6lDThgYVwQ0=
X-Received: by 2002:a17:90a:c107:b0:38e:6f90:eabd with SMTP id 98e67ed59e1d1-3903c53783cmr5138898a91.5.1785909774222;
        Tue, 04 Aug 2026 23:02:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3903925a998sm534661a91.3.2026.08.04.23.02.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 23:02:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a178080182so309175a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 23:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785909771; x=1786514571; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSWm8erDkMdqn2vK00vAqeQwRIm1DJv5B4tfEJjKMGg=;
        b=Wzikbj68W5Q+U+Uwr1EvAOTXj2BSOmFCWfpTX/Xd8P1YolXdlMXdK1G9ECYs7r1Snl
         HNfoIVAndrtTbKOkd4zfD/uLTD9cyy2zTVJa+GD4V2MTNs409p+g8CVmv2oqBD/GthBu
         rfabIfsz+oNfu2PVaQ2FjZZwCg+AKbwDFXGb8=
X-Forwarded-Encrypted: i=1; AHgh+RpiZNsawaF/BTwmZQC+d+Hhl3ZxObzLXc7h6lI6yF6DfiYSHqwrcQTk3RYnxg9oGVvSet4UNXs=@vger.kernel.org
X-Received: by 2002:a17:907:3d46:b0:c15:ce72:935e with SMTP id a640c23a62f3a-c2039c26fbcmr172304866b.17.1785909770861;
        Tue, 04 Aug 2026 23:02:50 -0700 (PDT)
X-Received: by 2002:a17:907:3d46:b0:c15:ce72:935e with SMTP id
 a640c23a62f3a-c2039c26fbcmr172295466b.17.1785909769302; Tue, 04 Aug 2026
 23:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803193135.2030368-1-kuba@kernel.org> <20260803193135.2030368-5-kuba@kernel.org>
In-Reply-To: <20260803193135.2030368-5-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 4 Aug 2026 23:02:36 -0700
X-Gm-Features: AUfX_mzVebmpqn9O4mU1TZMG3CS50KRAQNAyWQYj8KBLXKglZTE6LLBfSq7oUiI
Message-ID: <CACKFLin+Gi8t=5spT6dPrByN2NqS8XFUp+kU_+YZ89t0Qu3Qtg@mail.gmail.com>
Subject: Re: [PATCH net 4/4] eth: bnxt: avoid deadlock when canceling IRQ
 affinity notifier
To: Jakub Kicinski <kuba@kernel.org>, Vishvambar Panth S <vishvambar.panth-s@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, manoj.panicker2@amd.com, 
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com, 
	wei.huang2@amd.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000082abe006584685a6"

--00000000000082abe006584685a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Unregistering IRQ affinity notifiers waits for the callback synchronously=
.
> bnxt takes the netdev instance lock in the notifier (to restart the queue=
)
> and cancels the work under the same lock. This may obviously deadlock.
>
> Move the restart to the async service task. The queue restart isn't
> super time sensitive. Store the new TPH tag, schedule the task.
> Safely canceling the service task is already ironed out.
>
> In bnxt_request_irq() the order of registering notifier, affinity and
> initial TPH programming has to be inverted. I think it was racy
> previously since user may trigger an update as soon as notifier
> is installed.
>
> There's a small known gap - if pcie_tph_get_cpu_st() fails at init
> and the target tag is 0 we may miss programming the entry.
> This does not seem worth fixing, the code has skip-on-failure
> all over the place, anyway.
>
> Fixes: c214410c47d6 ("bnxt_en: Add TPH support in BNXT driver")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for the patches.  We'll get the patches tested in our lab.

--00000000000082abe006584685a6
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBGcpTf
1cRSzahworHKC2CVNAHcJmFJK2pTVYAMpZQE2TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MDUwNjAyNTFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA1ZMA+Bo1tZoVu1N7F5pO9WqL2N+TTZCduk03rYawt
kughOeFnwePYd5FexXtCHX7twAf5Ab74Wgqu3iHYBOJ8PRCBVTtLlhxnHuzduxB/EO4O3kIfffnh
UgIb3RCie5OPr5mD0ly7T5MbwQipaMDwhAhgPuDpfaKKFCMHSxQh7/wvUrZiiI9E1gIWg8R8Iizt
9p03jUEzvJH/dLDMpFXGMzrHdHriWpOWasE9XQfA+3rGDm+dGt1z5Z8FsrQKznBfTClVqqVG8cF2
1QUAcBW2pY1Pmdo+EhYq9J1Oa6Mpq8+bG/a9se4F5NJ8DSNdMEEJVvXP8yV9iYh7Y5gWmLhV
--00000000000082abe006584685a6--
