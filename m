Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793170701;
	b=Bncstt71UGf1NDjkgEZDKPjMFjP6Nu9U9XvbdsY+wdjRHMWMHdZ7PujIR+r/0HRWf6PJ
	 WkVy+ihdFDF8rUuKeWgSshcB0OPmExU25CLMkawU3OLcQfi34dKI4Zdn2SEPKq5nAQ3pK
	 pVC/2xF5JbdjU6mD3SVlZ+3MTS2pqJxBA9vt9OM/81tmctofHg8ukgYl/t3SVrAXh4wTH
	 /lK2zJwTXC001aFQnwfYJCDBfZYdP+FiX6TZpcZLOhroM5WqLS/L8zRytgpONZviehbmz
	 5JHoy1ctSxmyWdtkPwlk+Vi1TTmexnVsYctLhNZx34YwrrnluxnX+OSR0tRBW5qU6MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170701;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=ziLbhss20krjxcMCbxNMM+8VpHUcyEGItU0nRi2Qyvw=;
	b=5khmAXaC4rbpCIYsgseEfbkyKrC+SSG6rxIMA3eHQtPml4CPfZJJq2bNznFWdrvbkO92
	 9qjow7VJepDVfRV23ROgEvbuKl8o/cZpiVPu/Biw2i6PS6PgbujsBKC6l6iIFRz7m1ESd
	 UEcsxAticfrpxHlvZ0jn1yKvXsdVQsJieo8FAzl8bvyQmpe9XEdIXoL7Kp9qEupULHb1x
	 D/OwGzxNL3xYB5aDIAU5IJX9TY8WZezk+zqlup41b8uTpAYOIDjUr53sZGjdmO1W8tj+G
	 +8J1jZ1pKPGttSx5PApYDvVSPiftJtPOWgRxUsYCckjAuIdAPh5EF9ROS6HX3bnbiHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=P8qZ1PKP;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E67606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 06:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=P8qZ1PKP
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so282780a91.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793170701; x=1793775501;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ziLbhss20krjxcMCbxNMM+8VpHUcyEGItU0nRi2Qyvw=;
        b=kh1LiXqlhG/h7nEPDPp8EK5GeHB53E/+t0kPfSUuRGZd6q7tCyIoGNl2EgUN9znSin
         lKHlPKdAn2QXIxiCpcTbGUScwum5q9d6Z52+WuNe2iwrixvD2zrlungh8YYlHnxkcJH8
         OpTY/EDYAYUAwTum/xT8HjyQrhdNg5fBX7sdpII5FLHs7O3BwJT21XdX7K1pnh2eAWgD
         8scmUWwia4gt7Cl9FqaNHJxmrhRaVnJZg01fPtw9eOozsB/TDbtz0efb6A0SdIXAJ4J3
         YCJOdAiRT4nXtGZdihcXTKq6CjESHqbtxbIeApp+nG7h9YjOyhMeDwVrP1dM9pHmIGQi
         2jpw==
X-Forwarded-Encrypted: i=1; AKwUvBzRVlCyHz0qF8CU9y0h+0ghMmD1kMTTQ0C39owhEAKu7nvU1tnwaQ7oZJ6Rjtje0PXjR+eaf2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJavlDQAKncYHJ0v9Fef1aNmVNK/olDfC8AZ1fjjRn0kjiWH4dY
	mc0fGzUUmz1YXywfW/h3n8T5hoIJGi8dABFZrZw5GNTo/ebozsndBeiVNliKUejYyrsTsbLC6U7
	Dg5oMrHL+e0Vb6O3CdVdl1Cu15+dcnfj67cL/OngmcBjgARARfxUSmKjo7vL1K6O2tsz7F5j46q
	JPAW+JOR6jXvIoj0IHtuRUGgOMSArY8k/Z2ywXp6j5L6Kr48qNqfXQYPHI0Fv4Z3EH3ob1/v2c5
	fwWb7qzJdo=
X-Gm-Gg: AYBFou1wZ+H0KGpjyTP0eGFFhBSs8VEVSGhjWb1kQCQz/oJ5HJ1KjpaCTSdZtfz78k9
	SZkyroVpAd9N33DmU7Zr22N5cSojlwL2SCafX2GcKv/7Mp8I+t+Bse1gEnSCYwmhAMirN/SBYLW
	s0rCIspap1iRGlFbuoN2hxn5fyy0xM9QneSNcqxDOIm+ScIWrKCBcmQ4+vdPTg4P9FgNO9lG7CX
	j2e1KebzfnfD38phouafpG9NS1/rCATu8MelghxJew4uT7G993Qg+OP75DFB5R4ZGztfLt3k+ar
	61afr3HFcuNYGnUhTOKWzJSxu0sjt98RLQPCw52MRzv8+orJgXIu0dfwBdC2FGcvxWHIb+eGIg0
	qjU79iaeqT/XzjTja70ObuAgYrFAcPLO31WYEBuE9rkNAX+Zvz5C4O+yS7T/NsAQ3FDLZPjxseS
	sszBqscmw34EuhggzU90P2M/n6/GN9xqoQivo=
X-Received: by 2002:a17:90a:c886:b0:3ac:7874:639e with SMTP id 98e67ed59e1d1-3ae5819b7e2mr1005913a91.46.1793170700512;
        Tue, 27 Oct 2026 23:58:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae5a55eaefsm923400a91.4.2026.10.27.23.58.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 23:58:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c25edb54d22so72915666b.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793170698; x=1793775498; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziLbhss20krjxcMCbxNMM+8VpHUcyEGItU0nRi2Qyvw=;
        b=P8qZ1PKPWGqfQOhUzc0ErWniLsqVXm8a45yE8sYCD8mmA6FYJ6Brlmmk7uipml2OEM
         SoRGbAJnJGZUQf8MtJuney2lDTEPUfXGb1wdlXkRx5HHvJiJqpOXdR82d+IDcBI7CHDr
         HOwgpzFF5KLgwmVslRznyVR4Ffxdxyj0IZ4mk=
X-Forwarded-Encrypted: i=1; AKwUvByqE9HgSsr/ywMnjlfRAbyyTk3D6XZwNmElovGM91Mhp3sYZWa2y7m8p9RmtJEmNlpd0OpH1aE=@vger.kernel.org
X-Received: by 2002:a17:907:60d1:b0:c31:9a1c:de76 with SMTP id a640c23a62f3a-c49bdf389ccmr118124166b.14.1793170698610;
        Tue, 27 Oct 2026 23:58:18 -0700 (PDT)
X-Received: by 2002:a17:907:60d1:b0:c31:9a1c:de76 with SMTP id
 a640c23a62f3a-c49bdf389ccmr118123166b.14.1793170698293; Tue, 27 Oct 2026
 23:58:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027234940.1267225-1-kuba@kernel.org> <20261027234940.1267225-2-kuba@kernel.org>
In-Reply-To: <20261027234940.1267225-2-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 27 Oct 2026 23:58:05 -0700
X-Gm-Features: AclHuK-UHz9Rg7mnl7Mm329lW9kpZ0I5r72uTirtc-ae5Y3btAovPnN3DreNyDU
Message-ID: <CACKFLiksk59XGw7_zn6YpvpObh8Y=2cc6kbWTFjLf5CU2KzO_w@mail.gmail.com>
Subject: Re: [PATCH net 1/5] eth: bnxt: recycle agg buffers when Rx head
 buffer allocation fails
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, eddie.wai@broadcom.com, prashant@broadcom.com, 
	huangjw@broadcom.com, gospo@broadcom.com, brett.creeley@amd.com, 
	ap420073@gmail.com, joe@dama.to
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000886e56065ee116d6"

--000000000000886e56065ee116d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> Note the odd split of ownership here: rx_skb_func() only deals with
> the head buffer, the agg buffers stay with the caller in whatever
> state they are in, still on the ring without XDP, or frags of the
> xdp_buff with XDP. This complicates rx_skb_func() cleaning up all
> the buffers (head and frags), which would be more intuitive.

Yeah, rx_skb_func() only deals with the head buffer and it needs 7
function parameters already.  Letting it handle agg bufs would make it
more complicated.

I also double checked the TPA code path (copybreak and non-copybreak)
and it doesn't have this issue of leaking agg buffers during OOM.

Thanks for the patches.  I will review the whole set more thoroughly tomorr=
ow.

--000000000000886e56065ee116d6
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAnvRU3
OvQbe0f+2ri/5kposafz0fuBqbg4PK+6kMhaejAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjgwNjU4MThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAZ+4ncRi+U59DvK/F2aMm5ZJ0NcHtfFvFcfrloICEa
gwPYFKCV1jrInRakG0TFVKVANwHrZn8x/dYLy/oc98T1OQEu2hUTMG1cxExYliQgxClPv7YKnAIf
K4TO5FiA2mEK17ekB6Up6EQKlbs7ShJbusEzLTy2jEtcOjdMhB/YGdAO1oePoHKrj3VmUPEZxTxi
cAYUUiyjS4U8JuUAh3NXzJrOi/NZqQe5MNfVhVe6HS4fEktLHWLMRU5bK85lYjt4m/3K0wNa9L6G
Aa0YKS4keh/40sCRYRkv+urtIEMakSQZ6st/W0bHfzdu8K5k491qARYe8Kcknzb6+EwgmQob
--000000000000886e56065ee116d6--
