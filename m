Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAA28506F
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 04:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173688; cv=none; b=qGEhYbV911Fobb7J+FZkNC0bgkiCz1s9IlNTUiHgY1tIt7mS16AmymdDt+YjbwUx06/9LHWoR9Mwb5wHr/Ethd9pAFafClsU4QTXZ62tPO+ewMSyl1ZEW4oAiQjdCkx2pjCgvilJIC8ejYFQGIiQo3quiswp369J2Gq8SZ+pmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173688; c=relaxed/simple;
	bh=OwC+AAu+OYMOoQJKlpR0zBLs4ecoVrVmxrXx1cZfFbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFqpirbHavHvT1Y9jKi581xAQLKIFfUDkok3iaOJd3xRvAPwyHHK7bdm4FAg5z3DLCL4XzG3EGfrcOwsPlPXeL4bdAzhWkHsVwekXESr3v93mcHNOHAmwp+fMJvgC9K6vl1foptEePCM3Y6kSsUz/1mz6gNVAeEV/y/71rL9n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Clbhvm/V; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Clbhvm/V"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e49851734cso2778755ad.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 21:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791173686; x=1791778486;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwC+AAu+OYMOoQJKlpR0zBLs4ecoVrVmxrXx1cZfFbQ=;
        b=MzO2ZsKcHTweaM0oIWQQk9Yl4Q/5m25a9uDrvEogrLf6LFmfXZ+iR+JadSI3KL3GzU
         FLY0e5p/pu8g7GYdPhIpEKhplDbhOfggFjnBfoSNnGPoluffbe9TsRNJ+3e692N79/mF
         MAN3rxQz/uDaTMintLTwNDjcI75fbMkLNtr5JqsHWukVwZoW7d/p3umKYH/8srE/ERon
         tep+i62i4gaZsh9eJ+cJY8Jr5KMO6QVT995L35T4uQxTZO5hTYH8sdIyTiN7u15UiqRT
         P0CYpY+csIDqIMMYHoRgTbwP6Gq++0lm9+YUvvxukTAil5vjxwLrhvBcCSDsBnm0dm4H
         1iFw==
X-Forwarded-Encrypted: i=1; AKwUvBwokVxw+Hv0RUTqwDTCmEeiINI/8oHxISv/6NGaUid4p2QzE5fjlQhTWBSuy806Jzgab9ZVMZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxIiDElaD8BoczvwQCLzOgGESo0QYP67cnYbyBfTmBq6R95TF6
	1m7eF1qI1i+WrIM9/6GJ4P4UqLCdPYrCeePo1kK13tkoiJoPexXiQ61vVF87GfojX8nM4xq6x4v
	Qy28fotD3/CeFVV9GMQKsPV5CI27+mHuT88pppEZqoGfpTgkzxTTRl0WETbcwI+JiEz7zf7RF0B
	h+Dx2LWDYJbizWcrKClY2OY6I/JS4YnCjjdBal+/wbkn+gAjqtxpHlykXAPjnB0zSogiwh1zU7S
	5EpVvpLWJc=
X-Gm-Gg: AYBFou3uwNvfLapkL+x5KHDjWnHcVvGJdyfn6hzLHKsu28Cpj9oR07020WXTRM0zv+0
	blm8xddzmmqowz7FihhyBJj24LSpwfk7kw7LNUrWaFTm29JLAGTMwVaVi+exTufen92C0pwyqta
	jRnD0JbNP6cMx/yDFcKwsQFxTOoiLn7rvGx5tj1qOzpil39u9HWPfSxR1BabUyBNNy1WE7yhcBm
	OwfOHuBjr7baOoDS4I/DY3ZD2mY60cxwa9jYaPWZFVt/IArrRZXYX6kJeEZzCkI7mTs0CMDKd0X
	IF3JLGjPCoSREKdkPfbRRuaoCOJbvCbwCWxWAJ6vkd2pb3Q6le20tO5dWs9z+qYu1LPbBjdErC6
	lDPdUzLEdi5YHExL76BT1dXDPqU3UoN8UpPEZFDlBEV7QzhFd6Pp7uywp5Ka9u1Wig5FxreDqUZ
	js2OqFg+5r9xgaiKW1va+y0tBS7dY1OF87EPTRRA==
X-Received: by 2002:a17:902:e5c7:b0:2df:a0f0:6621 with SMTP id d9443c01a7336-2e49b4e2a20mr82978105ad.12.1791173686018;
        Sun, 04 Oct 2026 21:14:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a78d1ff791sm992158a91.0.2026.10.04.21.14.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 21:14:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2e6df274e4so61331466b.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 21:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791173684; x=1791778484; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OwC+AAu+OYMOoQJKlpR0zBLs4ecoVrVmxrXx1cZfFbQ=;
        b=Clbhvm/VGU0vo8tQ384f5h1g+dbaBDFTGi3VRolnxSnqoq6w0A4U+/re2ySCk1uc/8
         zG8PVzCmRu3IzeFxqA4D5qifgIotbfaTYN0m+Q2kCy4vhpa0RkjvShF/d+bQKMwHiLxO
         YwkVniJ6N0ZL3cwZ1bDFpaoyNOjI/pvtlf270=
X-Forwarded-Encrypted: i=1; AKwUvBwPRouSZ+RfpX1ZdHtOFMj55X7lTUYc88wjLEBXpoYZ5t0XO0AuyKfpzRmVSiXNWroIcAm/Tm8=@vger.kernel.org
X-Received: by 2002:a17:907:96a3:b0:c26:19de:9ac5 with SMTP id a640c23a62f3a-c2e4ad70876mr677508566b.29.1791173684255;
        Sun, 04 Oct 2026 21:14:44 -0700 (PDT)
X-Received: by 2002:a17:907:96a3:b0:c26:19de:9ac5 with SMTP id
 a640c23a62f3a-c2e4ad70876mr677508066b.29.1791173683910; Sun, 04 Oct 2026
 21:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005023812.130639-1-edumazet@kernel.org>
In-Reply-To: <20261005023812.130639-1-edumazet@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 4 Oct 2026 21:14:31 -0700
X-Gm-Features: AclHuK-r_5H5WdKFm0FpSvcrb4xa3lUXIEXREoYSeR7JJsKtWF1OzQBlLkJZ08E
Message-ID: <CACKFLi=ja544ms39JMwaAdiyKzzDAUFxSFUWETh6kfzQmcj4dg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small packets
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Stefan Fleischmann <sfle@kth.se>, Eric Dumazet <edumazet@google.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003140ca065d101f98"

--0000000000003140ca065d101f98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 7:38=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:

> This issue was exposed after commit 447cbe95ebb9 ("vlan: fix skb_under_pa=
nic
> and races when toggling HW VLAN offload") because reserving extra VLAN
> headroom rounded LL_RESERVED_SPACE from 48 up to 64 bytes, shifting skb->=
data
> offsets and potentially causing small frames to land right against page
> boundaries.
>
> Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in the normal_tx
> path. This ensures skb->len and skb_headlen(skb) reflect the padded size =
so
> that dma_map_single() maps the full buffer and the descriptor length is
> consistent. This also removes the temporary 'pad' variable and masking lo=
gic.
>
> Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Fleischmann <sfle@kth.se>
> Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothron=
d/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000003140ca065d101f98
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDAMqps
LCoQjjFIh3vVpmlJ1Vr2ZGYu3ztnODfZnFovNzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDUwNDE0NDRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCPMGJpFKcEocyiYynS+Cot4O/ySmR1PC6zKQ3Ft4XI
02w0e4qd91T9RvEcwLUS1TPiO6uq+WM2UMxXJFxDEF8V5Q82IbpB+TklItysbvtQFzttJuUqKtXY
csnaMIZAjngBfupyyGgFyskSaIzaI1htXy/pvSB/pCvGRnWYaGRjHqAcjZWEmM1hk37FYzBRhTFA
F3A7Ux+mQE1gNGDJ+OmnhpOW1FUAcX6p/YtMHHuQK+fv1S8PFcY8Esi9+Rlsqg/6Z36e6th7nphe
LYKbd53bMKdvdRXzrcOaBBLACRkjl28RixDazS+h/+Q1SK6UYHPN2cWD6vFblSbWICE2shqp
--0000000000003140ca065d101f98--
