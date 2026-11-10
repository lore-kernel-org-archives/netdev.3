Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334506;
	b=w3RM3hSX0eDAhY4ZhEeL6nphkK0beXUeH6nLAPHoy2lYp0D0nNr9fFX5y2HBB2H6YsAR
	 BpkGTs/NdMPtKl4uJdRJEZCiz+Hgq7VgIdCI40t9+dYzSDHLTaY9l2UXzM8TbZcK+0AB8
	 3GVqgjdQ8peUdb7viw2XsKVRM0M5LUsQWxLQafphFVYJZoc3ZvCN83TD0aTebRGuJYBmU
	 sCYNjtrtXTm3FMvrhvgQTjB3kIh5nDbOaok8OdE4heWUnJUtfYLNRGVEmIL1I3Nx+T7pX
	 KL7BA3E0cikhhfR3/1XYjmM1jZUZ3MSILMh9qbfoYIRb6ENPtVO6hytEul3wW4s9Xjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334506;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:X-DetectorID-Processed:
	 Content-Type;
	bh=X+Q2z7SdBbYLPJp06K4I8PE0EJRPItU766MjAok609A=;
	b=SMOwVX0OYj4g9vTJqXFh7d+boN8dbp8o+MdX25E2RWbdeevw9cEHwXBv1mW83th/GUqJ
	 WCyDL6cOZLYomxwFC1HLgDGIddNo0cpv9B3cXpbDPca08/iuDN809AO4dlcF8A8GZvAoX
	 /IUDBVlMKRHZAtDPPFRMy9ijAfpKd4fleFkKk300LxDbJW8RHIsT1x2QY3DmN3tjbqCcb
	 px+Oes9v9ypc9gpgW13L2zLqltAa6edfPMR+00151JBgKgBnXOzLWJoz9GHln3zRwZzAt
	 OfdGasFuKZAKNyGJ0OzkJ0X8yiVCCwjN/QRZW+YWlcwwumIkGHtiGSNTiyQ+t5PbLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HsTYqFTu;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5D606A32A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EE5D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HsTYqFTu
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso942675a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334506; x=1794939306;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X+Q2z7SdBbYLPJp06K4I8PE0EJRPItU766MjAok609A=;
        b=fO0Z9oGcIOFuX3oNQlyJhPxKb/e0hrSnsaP3VtDwELU7Jjp4Tu/0aOoC2kZxlgg7+e
         O0itR1tGMjjfgvudYmav+HzoP0jTPPVxfB+vmOWDUT/9OPPgxGLqUgRku4553V0VCBrQ
         AGcgVDCdRF+vclMHrs5Kzy84p3SHYAseaPWCSwCl4BQ58nUJHSXcNoVU7cNDGEabwzT7
         pBGXpi3Del1i+sEbCDmNdlEHf9Z8JfslkOkZOC9fJJCQdVYhWx3tAxxO7dmJPkQwO0yt
         FoWR+8/QobFHOQrJD6p6BFMHfm0xcGsCatDPdVZ4zJEAB0P1yofrisSXluJ+FZ/j/Oaf
         LJUA==
X-Forwarded-Encrypted: i=1; AL+hErFYgMRunla7aq6Ij6Innhcr6omV7WnQ2zplKkh82475ib0cH6cdCJh7Pqoo+Gn3bbGMbcboSOU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PQ6s9IqrKzSCS1y/MoSjx+KkoSIIsfmhU6Itwf+sm3Jvz/fI7
	c4v32rRiO5luFYVzzn9IIYRqwmDBA2+odzmBei38Wmrncl4vAd9VOi66QXhFC36RDSkdilfhhbH
	j2i9n6kf4+JHcGM4XDKFP0MAkTJDX3bfi/cp4eDurjno34yNYTu2S5AUiJe534CaHE1o997/p38
	YiKRQ65LDZ+sU8L59B+YBZ2uBM4DRX9hurg9DPG1KoHIu0VLdBtZxhi6W3zj+ZvECFHKlaA99dz
	pkL23ALnzk=
X-Gm-Gg: AYBFou3oaaYxTiq25nCNlVTQGmUQXlKBSYKhuQuU50+a6MpPhPgQsAu0eslbvHIXUuM
	d8X+VmEOUxG5l3ATYhy/ArHJG8LQmQmVcBLprhXeAT6Xs7higA83keudQyT9rZ/KVX/lOnBPnpV
	WxgCEV8whzCJGiHBB+cKemKyYLAXcXTAJstP/PH4+WjI43i98QFucvv1udsRFK/oKWBZ7jEelin
	JDbq0s+h3AtvUT29b78T9rM4Jt4TeUrJuyH53kx5EHDUVU56ZofYtWPXPvgw7Fbqwu2dv8y4qN+
	MpvvY1aP9ZDz7rA8JjkTdh9WZCRhyuXa6Wh+isLd3/pdhLnzfCmtG71eGuLEpTGhgXIfkk+MOhP
	blCqyYgX13hU+lP02b7sxC1kxJ6dpuMyvqte9jeo/LHA6LOla8z/D//PuXB/57LYKQJRqb9Fhv0
	XATPacYtXpOhLDn7ZFKNhFWbi/P22+23aIx+A=
X-Received: by 2002:a17:90b:51cb:b0:3b0:aaed:48d0 with SMTP id 98e67ed59e1d1-3b166d0530cmr3661833a91.37.1794334505616;
        Tue, 10 Nov 2026 10:15:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17e3294bfsm318329a91.8.2026.11.10.10.15.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 10:15:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c50547b4992so81493266b.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794334503; x=1794939303; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+Q2z7SdBbYLPJp06K4I8PE0EJRPItU766MjAok609A=;
        b=HsTYqFTuE7wYHLE6KfrMFQJGysrl6BX+gmTVo8gOYg843hR/fCpY79z6u2aqrk0kX1
         qyzkH13u8gQOEJBOSAsQitwjdrwlS4lExhMlr2ZGVOBf/bGI0C72p59kklkXeqV5da5b
         yOTWZOTlOTr00thpqpiTPGCK+/HTpSAn00e0E=
X-Forwarded-Encrypted: i=1; AL+hErE4EA8zlyhnEvkvbjNxevDcQ5XoZZx0m7Jgn5mzQ+kWC1cXneO9layd7kTSSMDIQEaXx/NtlpM=@vger.kernel.org
X-Received: by 2002:a17:907:9627:b0:c2a:cf73:63fe with SMTP id a640c23a62f3a-c5048f42111mr296417166b.6.1794334503707;
        Tue, 10 Nov 2026 10:15:03 -0800 (PST)
X-Received: by 2002:a17:907:9627:b0:c2a:cf73:63fe with SMTP id
 a640c23a62f3a-c5048f42111mr296414266b.6.1794334503246; Tue, 10 Nov 2026
 10:15:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106191423.4194081-1-joe@dama.to> <avIpEpoCYvLHYl3j@devvm20253.cco0.facebook.com>
 <CACKFLinPK+wR=TMA3zNJDKQR_=HfMFUHPxKS+yhvv9SegZw7Ow@mail.gmail.com> <avNWzavrxJSasfp5@devvm20253.cco0.facebook.com>
In-Reply-To: <avNWzavrxJSasfp5@devvm20253.cco0.facebook.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 10 Nov 2026 10:14:50 -0800
X-Gm-Features: AclHuK_hdaI0bABEzw4LCoXaFcB2NPYAVwdRelKCO7_Z4f2yUn_JLuTXbgEPfMM
Message-ID: <CACKFLikU8ax8-VN+EiAhrn_w+2=yex2TNHPxEYqni6g0BKHKKQ@mail.gmail.com>
Subject: Re: [PATCH net v5 0/4] bnxt_en: Make RING FREE more robust
To: Joe Damato <joe@dama.to>, Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, 
	Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b7f4cd065ff00e02"

--000000000000b7f4cd065ff00e02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:39=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Mon, Nov 09, 2026 at 04:13:57PM -0800, Michael Chan wrote:
> > On Mon, Nov 9, 2026 at 12:12=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
> >
> > >   - Notifying bnxt_re when DMA is stopped.
> >
> > I think this is probably the one item that should be added to the
> > patchset.  When DMA is disabled, RoCE will not work at all so adding
> > this will make the series more complete.  It may be as simple as
> > calling bnxt_ulp_stop(), but I haven't looked into it in detail.
>
> Hm. bnxt_stop_dma runs with rtnl and the netdev instance lock held and
> bnxt_ulp_stop -> bnxt_re_suspend takes both. So, I don't think calling
> bnxt_ulp_stop is going to work.
>
> Maybe I need to make a new patch where bnxt_stop_dma queues a work item t=
hat
> calls bnxt_ulp_stop without locks being held? Not sure.
>
> Also: would you be OK with bnxt_re treating BNXT_STATE_DMA_STOPPED as
> detached? I'm probably getting this wrong but I think with DMA off
> bnxt_re_suspend only takes the detach path when FW_FATAL_COND is set.
>

I'm copying our RoCE developers Selvin and Kalesh.  I think that if
you call bnxt_re_suspend() before you disable DMA, nothing special
needs to be done because the chip is still functioning.  It will go
through the normal removal process.

--000000000000b7f4cd065ff00e02
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBOqMEV
edkfHIRLJfWjlU6tODrwMS1kjpgv9MJ0J23fLDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMTAxODE1MDNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBpE/eIP9OXCWO1De+Ii1+DDyyXaBl0zXTlqYclnZWD
pdIaLqRGg8ZinIIJ7Mq+y/PvHzuqMru4YPVScd/LYuvf/vLHodIwtdIe40h+sfNIqxvnE+EWeNMA
tK1P9ETPaAMhH+PI5Ng+WyRlBUdeqVv5/wwfV6WLyWK87bhVhb5FCycxaUl2/PDgZ16Vc/4swp9r
50FSvxLdEjcwZrR85L5xQU9lnFz0fqFbkFQFhJzhvy3cL3LXqF5fVnI0tMRPS8osu28cEcbErV3s
M3iH2l9y7uhkoNkNLgKPST5PgyUdHYiz6DaBhqnReruaXjZUxlpee5LXQvzWg8fQccGjs9Td
--000000000000b7f4cd065ff00e02--
