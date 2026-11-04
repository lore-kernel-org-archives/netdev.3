Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813744;
	b=frYlsry2xUjvhZdE662wH/G8NZY8mWD/EKvVJ6wMeR1+B1t1HYWlSamrtjRpqvj8AAHp
	 IFtNTUuOrF09kWHkbNavILe6C00akIyLvYPlOUtkiJmMIl7AJXmscpcEv8z3I2i49x5o0
	 jnCVmkiLKAu83pqPPE1pln+DqR7wPE4/4o9MM46zvUXosIQZSCnSnQijG/MbBADpgdMP+
	 7OXvXXwIWscgr7bii95Q35/P1WSxQdkuX3h6TA5e8JkP9PI5RT4ubOZoV2JjmG+wTIrg8
	 pPeyO8oE+toV+iZJMMU6sNfPI3P49laYH68rkTmfmp989CvDZChufjioM+woJApY4Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813744;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 X-DetectorID-Processed:Content-Type;
	bh=zZvtpq5mcGAm5+SmAAZgBHOR40tDclRvAjLqvd5rP6o=;
	b=KN0aCcXiFA/H6rfmZwJxAQeoDHKCmWcrK5lO2GPCKfzDgtvZbNOzTHRPTg0i4f+E2rxA
	 Kk3sD0UlDhc8J+jpmy10ls1sJpAhae34VZziGNGLFiYhRs+GPPRH/psWewTkVhvp4Xar5
	 QcObdnK+lv8Z3Dqj8L+gfR1Ut5OIRiNjyxEFsV7H+DzF0wGvTOCnuFopN2KerrcuXsd3t
	 /3MAPKw9yaej+IGCEXSrj9q+63QQbXbVbskhIn7UuvIbkE+yF1nezJPpL0UbfxNxuFA/Y
	 bwP85f4A/u+CFu7QoV4LJr8ftdZwK6l3u3xCrneQSJ6iYJjK/lAJhviu8jclhULwcTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=blhNoF4Q;
	arc=none smtp.remote-ip=209.85.219.97
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715F606D807
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4715F606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=blhNoF4Q
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-91bb5795792so10784516d6.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813742; x=1794418542;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zZvtpq5mcGAm5+SmAAZgBHOR40tDclRvAjLqvd5rP6o=;
        b=CHJz0WhWThuQTfTM8dhjX7rP4ZRYMzFz6jGfuOkoqGjpAyerLNRsWBNxirzo/ENVmW
         PHPnJ45hfzo6g9i5JBjDSTdeCERuV03bAk/1hwHOeFsrYZfgoKloODAfJPz8LVTfmBlI
         ZaMsimTY1HbGg2FAaElRwu8E6wdrLpkUfjfxqiXNpXPCm1P9I5U0DxZGp4K5YgoPn+Zs
         Q4uESX20lg/ByOI+ME6B+bc9jCmJaODmCJgvS4dDPszbGZ313NBtL3Le5yII4kadgKYZ
         QDfPLbkd9jKFpHpfqQ4HGa9X8EWiSc8B+QPZp/P+zXhFiAA7s+sYunNtY1EVkbbzFWnG
         HliQ==
X-Gm-Message-State: APuU4Z+7gjDoOiCgUXBAXNriViSY8vOQ40IwyPWjDaBcYj3uIV4kYF8U
	bUsLTbOIr4bO1B2T+VI9nYo66HFp5cA2SSvJ55djzn1YiEEJ3+BLQ06+Rp0IGVNhdMh1trFJZmh
	wINe/UC+s6YumpjYDUrroaCawDJ5qKoumNPCpYRM8I+pmUeMIk5yKfuJyCNXWdzXTmfePCKpB8p
	Dk88OnTZpD5NG38LAcRtXKrVC2vjq9aPGuMYQrqfRmtGPo+SFiqqF/lcQXtaGLejKV/CYZJJfyr
	LDC9jZfCAo=
X-Gm-Gg: AYBFou1R00wRQC0MZJ+HUHSFEg0Ku9+mYXOJe6xKCC9b7pivntPll0QEr2S85nTUiRu
	I+xln/NFFIGilt8i7ENV+NJmnVdmROO43Q1bksfG3Pwk3oQwFnxw1gl7R4lyufqVeaImyfU+neS
	9y2tFXl6WUjy8TBv6GwkW0WHxlryEw76ae+5D3UjqmiF5Dh2+1HYOuswkZ21daL47OiV/R7oeQO
	RTV5LWUYqDENq+l+gcQG6K5+7vqepZxh+DEO5N9+7I1W2yLm1EPQZm5DU3S4WOVbRPwsoEmtNnK
	3BTecbH4DfpRw3y3vp6yaFNMJfEAxBzOCRZ8fjlmB8YoUj1wr2RfTCjCQ1UX38TBdc2Fdgbez4c
	1AmYvPq5Rw6huVoXMpw7cTS4api+L2N39Ueq/SkMOxRuvIpD+zwY2bca/nzcVR4ExKaF6ry9ZB8
	iRBrxnV7fCqEUBaUzAAKWzn6rm3k8ahltnV9g=
X-Received: by 2002:a05:6214:ca2:b0:91b:d948:c415 with SMTP id 6a1803df08f44-91ca4b78b78mr272349656d6.44.1793813742160;
        Wed, 04 Nov 2026 09:35:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91e7e8567f0sm482886d6.55.2026.11.04.09.35.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 09:35:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c40bbd26f74so107992366b.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793813740; x=1794418540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZvtpq5mcGAm5+SmAAZgBHOR40tDclRvAjLqvd5rP6o=;
        b=blhNoF4QrN1sgvXdTLxgX49xmNHfFDTBM4UEz3ct+eHwoADoGoWIWSlYhJNBw/luEV
         zwXEiiRpc1YZfh2xERWi/ywmplvH96aUnlXjJAP89YqwoRauu534RWTdsITmiCoKUgUu
         GnxILAs5dr1HdErrrA6Whmqg2VkT6JgYyGoFA=
X-Received: by 2002:a17:907:3e0c:b0:c37:c0dd:6642 with SMTP id a640c23a62f3a-c4ca7ad13ebmr1479229166b.37.1793813740476;
        Wed, 04 Nov 2026 09:35:40 -0800 (PST)
X-Received: by 2002:a17:907:3e0c:b0:c37:c0dd:6642 with SMTP id
 a640c23a62f3a-c4ca7ad13ebmr1479225466b.37.1793813740067; Wed, 04 Nov 2026
 09:35:40 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103235152.1904727-1-sdf@fomichev.me> <20261103235152.1904727-6-sdf@fomichev.me>
In-Reply-To: <20261103235152.1904727-6-sdf@fomichev.me>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 4 Nov 2026 09:35:28 -0800
X-Gm-Features: AclHuK-5gwQRp3wqELBgFybgo9lxeig5kDQOXEU0srFmarVSvMwRTIK85AyHwAI
Message-ID: <CACKFLikS9XtnJMiB_W4arpvaigCOb-ia6SzmS72ujTLpEyj+eQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] bnxt_en: limit netmem TX frags to 32KB
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, pavan.chebbi@broadcom.com, 
	sdf@fomichev.me, almasrymina@google.com, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, razor@blackwall.org, daniel@iogearbox.net, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d17360065f76ce86"

--000000000000d17360065f76ce86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:52=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> The TX BD length field is 16 bits wide. Limit netmem TX frags to the
> largest power of 2 which fits, which keeps 4K aligned frags 4K aligned.
>
> With 64K pages this already applies to PAGE_SIZE net_iovs, whose 64KB
> frags would otherwise wrap the BD length to 0 with BIG TCP.
>
> Tested on a 50Gb/s NIC: devmem TX from a 2MB hugepage-backed udmabuf
> runs at line rate with 2-3 frags per 64KB skb, none above 32KB.
>
> kperf output (sender side, 1 flow):
>
>   client: =3D=3D Source <sender>
>   client:   Tx 46.358 Gbps (174483046400 bytes in 30110590 usec)
>   client:   Rx  0.000 Gbps (0 bytes in 30110590 usec)
>   client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
>   client:           729   153 599     48    0 13893632 3147
>   client:   net CPU 71: usr: 0.03% sys: 0.06% idle:67.62% iow: 0.00% irq:=
 1.12% sirq:31.14%
>   client:   app CPU 72: usr: 0.16% sys: 6.01% idle:90.66% iow: 0.00% irq:=
 0.83% sirq: 2.32%
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000d17360065f76ce86
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBQjRSu
bFs4ptqlBxBuDXcye/0I1PEC2T/onXYvuT78IzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMDQxNzM1NDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB03RxFnziyi7jIX9O3sQLhULERMlGRLTi3PgdRInOC
DeNPHYjRovuEBZUeksysdaWC9f1h3csxQuZl1fPcWQ6vpcts2E+1N/bogsiscAE3o2LbMT6G111d
efzGWKBYCz8j12KPoQT33rPAHz2doc237Kx3s0cO+AHcnx1jR+SnJh1WKkqSMSB8muvhb+cjjgjS
Vk9mYY4/W10AWUds3PpEcPxNY4LE7yniylQi1PndHxp377Om45JZspdqsJTuIb7bPmxFm4nfAXbW
nTRVr1pvL9C7GpBS5SSQg4FwftoSheGxpUlqTIxdnTmJOIhdEQR5PoRV7MLZUBH6yP1zPKy0
--000000000000d17360065f76ce86--
