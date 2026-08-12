Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92643750BC
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518382; cv=none; b=BjtmBBJniI79XkLJFrzjlwTm50b8Fs9vgAyck7qZ52QoKRqO5sfIxVHGpUe4WxbncBvbysjXPoVlVqciYjiOg4IqJc8mSUGvv6EdO+3AQHvkuX4I/L+ARyejlfq6WEMx0k6KTK+uP4EUPnlN9Yz9dqcGKZ3XEtr00KTqqd7Ps80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518382; c=relaxed/simple;
	bh=AZ1cNDph7hXE8AO7y2Av9P7a/s4o64HvW7yjWGdutrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLd4Pd/mdvVRJS0/J1Mvfqssq/bVFWiYEP7lpBTi8EUmfRBDuLWnqKO2Oo8FEwXU807sxMyC5ZGVSy/Yo3mzOlpkkoCvavPq0I9GWH22mgoowG++JPb8SDzUBFpJYQYnzXl0zNMocYECQbFhNN0rDi4ZGrtX22WS8/FTszEkEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N9pOnPiu; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N9pOnPiu"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-936623c6dd3so107104385a.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518379; x=1787123179;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2rRrmalenSA284UzBS/P1snoOejq3yp0kzD/VNZu4U=;
        b=MCAtQ67OLkDz7yYX4dHHonlXIZOgmxAmCKL2ddIcCA/Oito7LOs/jHbOWdDcsi/ID6
         UysrOQ7kw3AduPx6ay0wyU18IGdcAWyy2kCcYV1/jFo982NYE5NcuD8Uc9ODQQoPOz5u
         tXTGwUwcxDuPUsfmM+aepdQzvcFjiA6PU02ybY0Rk0vZbObbYLHhyZoBvO+vL1dinw6N
         C+bBdWwo3ibprLQdLq4DsbVNHyxQFb1cejTFL2yuchNSOhk7QXksBL5eytLF9HBasoS3
         yzoTXs/N7RgliKM9Y9SASDOBtYfpuX8p3dPhty55gy9rCh35g2mOkXRx5fxc6vxrcYmf
         Odmg==
X-Gm-Message-State: AOJu0YzuW52a9QOcIMnOyLuGyCsnFNQe4k98OhgkjacFoSM66v60x5SE
	iA93dE+6JFi7DE+/h6N15dC867HXzJXdNzScGTplWHlzvTfwHPZvQufZB6j+AOc5n0snj+ysmjj
	Wdrx7DWoWMGKSrMdrWEHSLNsz6ujTutNBvbLIDFUDK7H8DMwssftBPB3ECpY1oLKhspluxzOap0
	cUIjujxj7ZDrR8aJTNBFF9R+EXYEXM9I7VwEnBLso47o2seLY8K67uk3rMssEErKFU6Qai0X3Cx
	tRsW72Iwgg=
X-Gm-Gg: AR+sD125T6RNoeA6u410NA7HwvaBzeKaSwq43lOdwlOvgo8hphH8gDN0M2sa91WXrNm
	sqRQtveau+xVSfjvSLr7JYUbf8l0YaZF+HC37lkaALaGUdiCWAMcDn18COfal+BKHBMLavNcIC9
	VPmWdQlV5MEo1+7Xah2drSvLHcyr+Cwqc6e3sy2sv3A0UEn3sGFIF9x3ONU2tM5Ss/gdPrKOmEe
	4n7zSWX1C2ib3DWFLamDNx79M/j3i947orlKvrIfjat25xBltmPRv5ZGbeyw0h5uwor4rV1qzcx
	Wx0XFSwu4KQAkreDlNKLn1YEcaqenPlFcc+QbIwjrmlHep5wCUkDf+AZhvPwIGBsEJlGyVcsAXQ
	GopWQKsBcEH9MW68DDThnaGCFlG0QIbVhaB7qLZliB2dpZDS8LwiUF0mitPB85DGE2IrinZ3DDl
	NuqMpnAQkcBEzRGixv8R3Se7Q5r1kF2Abc9w8=
X-Received: by 2002:a05:620a:4514:b0:933:ade:2daf with SMTP id af79cd13be357-936ade35449mr427018285a.18.1786518379487;
        Wed, 12 Aug 2026 00:06:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-936b5f30f8dsm17011985a.5.2026.08.12.00.06.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:06:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-69cd6606b19so375062a12.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786518378; x=1787123178; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2rRrmalenSA284UzBS/P1snoOejq3yp0kzD/VNZu4U=;
        b=N9pOnPiukEES8G2nELt6mmvTPVbNGW1b7DG9sBf4KKjZuEXEbE1u8l3UM5rpUihKWr
         A/GitBi+a2W5PvqeGKKccU8p/7+M4TeeyXOtXoGMX2+n8m7kEshAa/2twcDIIrJXuqXY
         sAwiBaBFuRZrvcV4lPoOvV6L3V3ElYZ26tQJM=
X-Received: by 2002:a17:907:1c1e:b0:c05:b9db:68cc with SMTP id a640c23a62f3a-c20f2cc8094mr167161466b.0.1786518008673;
        Wed, 12 Aug 2026 00:00:08 -0700 (PDT)
X-Received: by 2002:a17:907:1c1e:b0:c05:b9db:68cc with SMTP id
 a640c23a62f3a-c20f2cc8094mr167157266b.0.1786518008069; Wed, 12 Aug 2026
 00:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810051358.1244418-1-michael.chan@broadcom.com> <20260810051358.1244418-11-michael.chan@broadcom.com>
In-Reply-To: <20260810051358.1244418-11-michael.chan@broadcom.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 11 Aug 2026 23:59:56 -0700
X-Gm-Features: AUfX_mzk8iz3qv52CZhzOvWgXjj7rEOOxOhnxrHpcK1jNB9UBkNu3FfB36htE44
Message-ID: <CACKFLin4ciJf5G5tkCfoauEb6wMMU90hOFu=9H6dxgWMx8ykWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 10/15] bnxt_en: Add MPC transmit and
 completion functions
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005160e10658d43995"

--0000000000005160e10658d43995
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Responding to some Sashiko comments:
https://sashiko.dev/#/patchset/20260810051358.1244418-1-michael.chan%40broa=
dcom.com

On Sun, Aug 9, 2026 at 10:15=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
> +int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> +                       void *data, unsigned int len, unsigned long handl=
e)
> +{
(prod);
> +       if (bd_space < bds) {
> +               unsigned int len0 =3D bd_space * sizeof(*txbd);
> +
> +               memcpy(txbd, data, len0);
> +               prod +=3D bd_space;
> +               txbd =3D &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(pro=
d)];
> +               bds -=3D bd_space;
> +               len -=3D len0;
> +               data +=3D len0;
> +       }
> +       memcpy(txbd, data, len);
Sashiko:
Does this code adequately bounds-check the remaining length when it exceeds
the size of a single descriptor page?
If the provided length is large enough to span more than two pages...

Response:
Yes, the largest MPC command is the ce_add_cmd and the size is about
72 bytes.  It will not span more than 2 pages.

> +int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *ra=
w_cons)
> +{

> +               tx_cons =3D txr->tx_cons;
> +               if (TX_OPAQUE_RING(opaque) !=3D txr->tx_napi_idx) {
> +                       netdev_warn(bp->dev, "Wrong opaque %x, expected r=
ing %x, cons idx %x\n",
> +                                   opaque, txr->tx_napi_idx, txr->tx_con=
s);
> +                       goto cmp_done;
> +               }
> +               mpc_buf =3D &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
> +               mpc_buf->handle =3D 0;
> +               tx_cons +=3D mpc_buf->inline_bds;
Sashiko:
The docstring for bnxt_start_xmit_mpc() states that bnxt_crypto_mpc_cmp()
will be called with the handle passed back upon successful hardware
completion.
However, mpc_buf->handle is cleared here,...

Response:
The changes are staged. The next patch #11 will hook this up and call
bnxt_crypto_mpc_cmp() with the handle passed back.

--0000000000005160e10658d43995
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBemyJy
t7K3Xl/Cnr8gslgqQRJpz3Cx61cA5bLFLHELKTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MTIwNzA2MThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQATlgWrvSkw0dJxg6zyQp4iCu8+1wlNqAOsyQRGEVgE
aJlu8Trzj1+K7Ivc8daYRsakTAKlfDfOjlh/0pFhTxSEGyRfEAq56DCEpriNDXFU+Ax/+YeaXW/w
bVo1esxS8iSRMeJXoMo5boCT79hPqjEhPFe+U18R121cGM+KCfuEiK9MAwrtK6ux5odbhIC4L/c5
oemt13rpCxisx8NnQ5/vhixlgbvN+GfE/g3tdcuYvLzEaJ09qxd8nvWWj6s2axBlFYQr1EVQ/Rkw
MyiPztRxZDtV8aFmJHXVKeM1hCVF8dxYtJYEl62l/VukxxwJrtZYZ2PVgU4AMcSmrpc5ZrRF
--0000000000005160e10658d43995--
