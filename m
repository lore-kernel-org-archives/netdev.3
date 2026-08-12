Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE60394E93
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516616; cv=none; b=HX2uM+fUaAGbxnihyobeahdsfTjyfQcPNi9o5iL9oN7HwY5eqY2MCZZ7YBDLMicOKzzjtKiwOmgYMgGpBC1yiqFPv9ImnoLIrhbXMauQYgmTykzur1jaXzpSm4dIWHGWPPbXv/BZ/kx+lns9wGO13kgVJuPDax7gLc6106pke3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516616; c=relaxed/simple;
	bh=7l2n4BDxHgvI2EsUV8VMNMqqhKVbnZA5pHcLsPZ/yKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGVSwFeSBnO+06AN9uVFOreY4/A2ybysNKGCXBZW/tvKzCc16ardZpnb4VIA0vF3ih61S4cS9Q16Fbc1mfg3PTbYxiTqmIrPYwvwigwdzOuU0tDaRS+7JHtVwjX7JNBMK653DawdZLIGlwpMcRfjyR6QZlU2XcEqtC0zue3Uzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Oxc8KiUT; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Oxc8KiUT"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso570773a91.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786516615; x=1787121415;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VQzZ5d1xtYwRaefdoFGg9y4mQDxW+6Q8Vb8qHSh+zg=;
        b=OiKViw6VzmXqJbJgzDN8AN4HoaGPZZb0Pebw8eDQZ8hMRiVakvax+FSysF+2jLJ8h6
         n/eyCk7VOPeLLclK+lnXq8syy5QmDuqnjwtFzGve2JqJAI6YTMew7wqqBiYhmNlhWQ7N
         PHGsbmc7GV7uXAvMijR3+BVkDbjwlcJoBCVu12MrVjPWWJrlfteeJghlPRpYvz/FF9ZE
         yHXv6YZrocXOt3wwX+jEsJtX/+HoGIDVGWAlzfQS7JDoTtwH/aTFsIxT9kng96NgUx+g
         0Z/BfO6ZpoQJu4WAY0Dxso+AoSN93HaVyhRF5zA5HLORxJgQrUtQw57Ldq/M2LuwWtQZ
         Y2Lg==
X-Gm-Message-State: AOJu0Yy3VBPnQrrUDLFdXbJYL/uX5F97KPafKlgjNrhvfbbVBppNVaLz
	fQclFRc6/rj+Dy3tG0X88wL9hWwWu9afrCUHZ8nDLWucXoLOA683nxdIqmVo1x+Zyd7J+fp1wt3
	T3yXZK8aoF43GUQ4QIv7e24scy2WwK73jG+lH3zFVM4Hzf3Y7836hMCNoRN9yQOJveZukOfHNS0
	k+u5lSkLGdGtMfwK5esHYzGQxtuKRiIFOUxnaA4jMsjWGaiy9AaH6KiRCKrr8tMYVQ2VfPko09/
	JbgvmUTJqg=
X-Gm-Gg: AR+sD11f/PG/4NBNXb/5CWWFJZAB2XWUUxfUrtqoA1Rj2T5v+lHNtcY1wvwbWqwo29Y
	MAFwBa01jPz9cqwaZwM0xx8kBAp8qvPRq268s6in+csMyYrZ8SXtQFqWUYHzuxhQRy1bbEWj1IK
	1E6fDv3u6qVWsQyd53wF1WCu5yLGXxPrw7KXS1CASYrdLpzPRjfsbSjWdGgk2KokqZVSWygKw+K
	+5v2yGO7vYWkUzJ4VzurYPy5rcnBMq76CjvfUHDh0oBz6LtXUXBT3aLysQBXNXegUi0zPvkvLxt
	i4mIJ0er9E3ZLlpDYsqvtvESfmURXlrKQ7XqrZTNiB0LpvNjWHMXypke45dN2rDaJRaKWL82I4l
	FN+irue+p9YdW337NS7cCVg3i8ym/myMe7LtME5shp1LyGGDYYqjVCFZ5a96Re7z3A5NiX955hP
	kkY0WwXq9S5WFGaEBdko4zt7sVztbIfgQt9hM=
X-Received: by 2002:a17:90b:38d1:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-393014cac5dmr2713331a91.14.1786516614577;
        Tue, 11 Aug 2026 23:36:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-392f8e96dfbsm914803a91.12.2026.08.11.23.36.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2026 23:36:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c11f2b9f62fso43736966b.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786516612; x=1787121412; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VQzZ5d1xtYwRaefdoFGg9y4mQDxW+6Q8Vb8qHSh+zg=;
        b=Oxc8KiUTzrlcIPwCymOwhrgGlm9zsy9/WI9RUUEt9uiA8TKlb2VBHK4kj/qKe0/TnS
         EuCLHHtObgoQSrxEqgNTvqyeB9VaJm+sbAmbXxbWXAjlSoMcIEnJXJ9W/h2+SbEbeKyQ
         irwuIPUbqZHbTfrRf9IQsH8G3S9YiiscOqPBI=
X-Received: by 2002:a17:907:3ea7:b0:c1c:3b06:ed19 with SMTP id a640c23a62f3a-c20f3081988mr125143666b.31.1786516612281;
        Tue, 11 Aug 2026 23:36:52 -0700 (PDT)
X-Received: by 2002:a17:907:3ea7:b0:c1c:3b06:ed19 with SMTP id
 a640c23a62f3a-c20f3081988mr125141066b.31.1786516611749; Tue, 11 Aug 2026
 23:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810051358.1244418-1-michael.chan@broadcom.com> <20260810051358.1244418-7-michael.chan@broadcom.com>
In-Reply-To: <20260810051358.1244418-7-michael.chan@broadcom.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 11 Aug 2026 23:36:38 -0700
X-Gm-Features: AUfX_mxFUipnjZjo9DYd87ujCrHH0oAvJKQIGl8JVRLTASxscrzu_dcU4ZCOZ3I
Message-ID: <CACKFLinLEGcLXV+n1hv986QR=5faOgrU7B1qSDV0u57C=Ch=6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/15] bnxt_en: Allocate and free MPC channels
 from firmware
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001582ef0658d3d032"

--0000000000001582ef0658d3d032
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Responding to 2 High Sashiko comments:
https://sashiko.dev/#/patchset/20260810051358.1244418-1-michael.chan%40broa=
dcom.com

On Sun, Aug 9, 2026 at 10:14=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
> +void bnxt_init_mpc_rings(struct bnxt *bp)
> +{
> +       struct bnxt_mpc_info *mpc =3D bp->mpc_info;
> +       int i, j;
> +
> +       if (!mpc)
> +               return;
> +
> +       for (i =3D 0; i < BNXT_MPC_TYPE_MAX; i++) {
> +               int num =3D mpc->mpc_ring_count[i];
> +
> +               for (j =3D 0; j < num; j++) {
> +                       struct bnxt_tx_ring_info *txr =3D &mpc->mpc_rings=
[i][j];
> +                       struct bnxt_ring_struct *ring =3D &txr->tx_ring_s=
truct;
> +
> +                       txr->tx_prod =3D 0;
> +                       txr->tx_cons =3D 0;
> +                       txr->tx_hw_cons =3D 0;
> +                       WRITE_ONCE(txr->dev_state, 0);
> +                       ring->fw_ring_id =3D INVALID_HW_RING_ID;
> +               }
> +       }
> +}
> +

Sashiko:
When an MPC ring processes a transmission, will the generated completion in
__bnxt_poll_work() route to the wrong ring? ...

Response:
No, MPC transmissions generate new completion types
(CMP_TYPE_MPC_CMP_SHORT and CMP_TYPE_MPC_CMP_LONG), not the existing
TX completions.

> +static int bnxt_hwrm_one_mpc_ring_alloc(struct bnxt *bp,
> +                                       struct bnxt_tx_ring_info *txr)
> +{
> +       struct bnxt_cp_ring_info *cpr =3D txr->tx_cpr;
> +       struct bnxt_ring_struct *ring;
> +       int rc;
> +
> +       ring =3D &cpr->cp_ring_struct;

Sashiko:
Will txr->tx_cpr be NULL here during driver initialization?
During driver load, bnxt_alloc_mem() allocates MPC rings via
bnxt_alloc_mpcs(), which leaves txr->bnapi as NULL.
Immediately after, bnxt_alloc_all_cp_arrays() calls bnxt_set_mpc_cp_ring(),
which expects txr->bnapi to be initialized to match and set txr->tx_cpr.
Because txr->bnapi is still NULL, the match fails and txr->tx_cpr remains
NULL. ...

Response:
No, bnxt_alloc_all_cp_arrays() does not call bnxt_set_mpc_cp_ring().
It is called by bnxt_alloc_cp_rings() much later.  By then txr->napi
is already initialized and txr->tx_cpr will be set correctly.  So
txr->tx_cpr will not be NULL when we get here.

--0000000000001582ef0658d3d032
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBENyB4
viEGoujnlt4GM+g6/UOtz29ixbkSYSYITjOtQTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA4MTIwNjM2NTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAEDeO0lfwkUeQ/tIyKbPTNEWkY1AqLYYXYUoHVQvaG
kSKvsKqYTTF9m8+YM/oW2WVDg7z+LaJTXuiHGvvppLCy1gUSUdpbTzLsOadGu3TlzHg1LBFBWDam
dmNtLwZhwNcyU85qEUfkv+FJRuCxHPJFifBuXRfne9MdlGHqneZ5i5dbpD7KFC5io64BvGaPPCyF
XlcHL3QeKF7l9d596i0CCbWQczNJbzOSXUBPoszpoFTjziBWt8N5S00RFoE8XpUFntjT2zyEtghK
U4JsEq8E3aPDVXCA0GymqrLNO68z/MMkOjci+R9EpODKj7LgsVI0c/cbG9ercMHxYmqpCJaZ
--0000000000001582ef0658d3d032--
