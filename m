Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253007;
	b=hrgvzEKkOG56t4hBmsSZz07EfSAx+MrZNH4oFXas9lHunCvQr5e16EpnZX9oPArbtxZs
	 UAilp9KdVtcQGn6KfWrKGDjMg13nxwU88X86x71GlOoBuOR1/EYvBan6ZS2sWbTVryKT8
	 t9mGyQwFVh8pxV+nPGC5FK7sjUNDCzFFq4kNmvRwQt1UN2JCIk0du5pLbg5GNW4HA+UH2
	 E94cq1Gw6ctC0Bfa5/p12Xu99TNcKbDIWo+BMuCxpDf4uv6jTNkhHhmrl+8NEripjryUh
	 WhWgZJGdM7zKo0nrfiKDea8uViYUioiRBBlbv/imV/0ycg/yhClH2X4irSCqcNevvnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253007;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=swSuODFGlPL6vBqezxZQk4nEWaNKr0jGbxxhLkcaUsQ=;
	b=Vhn2SnN5e11VE5NVeIfhQTTqw6+9uEa7sK9/R+SftL9V4LAdgGi1cDKtJFRZJH3fV2Ya
	 NpIgO2S/J3MSE61QC/iz9DlyurNce8t0jBXKSN7Kmbu8kO6WLwGjLGqeDPPncxm/80zVi
	 Wi6uJDKqNcmnkyTNma7DFRlxHEMranEDkBeEVX6Soq5QFYsnv+oC2XX4m0Dj92q6Pn95I
	 a9BdrM+f9jSDbv+ec2a1hsiew9jpOnjCtuhm5ojcUoNY6Bejp1u5MA0c5MjE3dYOhVmhu
	 0aXxryVzBRVtpcR4y17HliLlGjJvXoV85qvVT/yeCZ9yXkInronUIecYIqM72gcRb5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GRvRSHs5;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA16606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GRvRSHs5
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so713550a12.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253007; x=1793857807;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=swSuODFGlPL6vBqezxZQk4nEWaNKr0jGbxxhLkcaUsQ=;
        b=1/YCYZJYXzvlzXe/ysf6PPHCsc+S5OzeYll4y6wCziFTIaJYwA9Y8+07Cp6woQy03r
         Zr5HjFsgi3fo7FrgZWKEkWaPTAsRBJFrLdKr5SwWbwxgo2M57hPhp7NARoqZ7cPYfbiq
         5Vi6of4bh0iXsupcBUpCdLpRjeQc05aK1c2+DYcQdmEWIAqLxH+b/0Oe+GL+69jOzaye
         uz10GcVMNRdaAzY64YV0l7FONgCYvUXj94PWbG0VnAMrVMywxUA6hOLQk/rZIcNligOE
         CukGBSY3fcOQVTZ9T1vKsvrR8wq9XPJENAGWJeNfYH8DKNATHQ3Ia6+miaXezse68AUo
         bFnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXIhG4JNuWEJDYxbQr6eqgXHgbOIVZSeJvUcqE6xKJal3UIT+9lQcuwg/FPa8PQiDvT5PaqRA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQtJoAmnpC0/0DJtlWUOg4GNn90cMUAtsRt07IUs2K3+78ZBWk
	HgUGak5tNpAKP1ulub6sEbsHORB0kXIAyVIK/ROneLD7Rl77b5pbJgsl1HPFqzwI+UYW+KKkbl7
	nTuFY+iTJf5NawufZEVM58Tw2rUDvxDTtCfnwUKRU3yHIRYRxBUQH/s3YJZwbfFkSYo0kfeANJA
	r6IoaSl+U1SF9MpGARfUYwMIKhALiZtYhTBekEQRB+gYNLZClL5IFKpWSOcz3zH0kFpZ9fWG7kQ
	PdpTZ2T3KY=
X-Gm-Gg: AYBFou20ToqoWkgrRyv6O50G4H/kDZoApnZNd4ZqE3ByKK6d7is8Kx6KgUC03TiDj25
	wRVJ2Bl5V7BFLqeAp++D1O5ytlGUzYT7WKTu6EF8e8c0ycjr2RsnNBws/LskGpkQ+bJ1efvfGEX
	ZSIfBnxbnqB0BP3QNXNOoohlVtye9qBqJ2P1+aymW+O1RCXecSS3iJFF7gDtefg4sl8dGnS3Be4
	9aS8A/wjEYMQ+S5FjOaLd58jFataPCZJzibl/5lRvVUGed9sEeohUc7XIw7Mp++Qq3WJ9JaZ61g
	spJGPkrpKKlT2Q3MME5Qvi58VJ23d3DiPGvPdYiA8owZNJDIwO1r9MZ2aD0eC0nJ67nyPGr6S8M
	BmRy5vPXIEzTmJ7vzyVB7H+RjHd3mfpDCALy9Bv8q7RlLPAyVXJoj7mlcdnjHGKBcHT/ulhngr4
	YBTaNNiqvicH7ZSqb8VhS5eqEJKhmWYGvt2WI=
X-Received: by 2002:a17:90b:17d1:b0:3ab:b764:826c with SMTP id 98e67ed59e1d1-3ae580a9da3mr3550434a91.12.1793253006495;
        Wed, 28 Oct 2026 22:50:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55d611b4sm1383520a91.1.2026.10.28.22.50.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 22:50:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4163a5400eso33131866b.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793253004; x=1793857804; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=swSuODFGlPL6vBqezxZQk4nEWaNKr0jGbxxhLkcaUsQ=;
        b=GRvRSHs5nzhcHllqeQBkIX6mBGk8q5jnObc78CniMXKBPeYiXW9PF2KbRNJ7gLRNcv
         ijus4UJbeS3Z6pQ7PX22GJpRv+o1/6OLhwDYsTD0IN2d5ppvN3v/HMCeNZiGa2Y+92sL
         6I4fKMGlJ5qIBn7kv+11zFZNDdXJLS2v1sfqU=
X-Forwarded-Encrypted: i=1; AKwUvBzVYuqHZ3el6pRhuRimSR+cWXhxOgwXgL2OlXgqObQAOor2u8BHZZxCqoxTq/jPyu7rwkyYiP8=@vger.kernel.org
X-Received: by 2002:a17:907:97d5:b0:c32:465f:826d with SMTP id a640c23a62f3a-c49d1216d37mr110130766b.17.1793253004557;
        Wed, 28 Oct 2026 22:50:04 -0700 (PDT)
X-Received: by 2002:a17:907:97d5:b0:c32:465f:826d with SMTP id
 a640c23a62f3a-c49d1216d37mr110129966b.17.1793253004262; Wed, 28 Oct 2026
 22:50:04 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027234940.1267225-1-kuba@kernel.org> <20261027234940.1267225-5-kuba@kernel.org>
In-Reply-To: <20261027234940.1267225-5-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 28 Oct 2026 22:49:52 -0700
X-Gm-Features: AclHuK-A0586qeYKEcJbkjOFwLt3KxT6I9I7zQtdu6OJNPaLaBZMA13IVkjZUAA
Message-ID: <CACKFLi=CdfiSR5ZGy2LmRV7NzNU82g5V7W=2_A9+Hct6fXj5rg@mail.gmail.com>
Subject: Re: [PATCH net 4/5] eth: bnxt: free XDP frags when xdp_do_redirect() fails
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, eddie.wai@broadcom.com, brett.creeley@amd.com, 
	ap420073@gmail.com, joe@dama.to, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000057978c065ef4400c"

--00000000000057978c065ef4400c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> When xdp_do_redirect() fails bnxt_rx_xdp() recycles the head page but
> not the frags of a multi-buffer frame. Their agg ring slots have
> already been refilled, so the pages leak, and the page pool can't be
> destroyed until they are returned, which will never happen. Redirect
> to an AF_XDP socket in copy mode fails this way with -ENOMEM whenever
> the socket's fill ring runs out of buffers.
> A socket bound without XDP_USE_SG also fails with -ENOSPC for every
> frame that doesn't fit in a single chunk.
>
Note that in the opposite direction of XDP_REDIRECT to bnxt, it will
not transmit multi-buffer packets.  Only the head buffer will be
transmitted but the whole buffer should be freed correctly.  Andy, can
you confirm and maybe provide some history on this?

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--00000000000057978c065ef4400c
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAU7eXO
j93lb8jWaKNEscfOlaZarhVG7JMQoJmjydgopDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMjkwNTUwMDRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCHSn2B2IZ6g7vwYUP5yQK7vOluTka1FOHXmOarhZ/J
0H24q9xVrENYckNXKsfxr+N5X/1RLzG7keVOHDZMCg8CvcqPsaFfJV+cRiBovBdvUl3CF5eZWCM0
jaNrmabzSfpGpLQMTe+bGr43hoVt5qhOTkmyY7LrVfK8XL4FFSCIm3GM4le11/frFnziLjQ+XR/o
D+W5Ab/xBTCkxBpVkn9V444NvgfN92Z6k8PVah7tL+UqCyO/GpKY7vbfkH8Bw4Ro43rgbaxwpkoF
lLMMf1xI6hUIuka2IXLqEg0U3ZVTev5FqkKMj+XryLjsmLjRIA8NXU1K8sTxiKx3HcwqL+Kz
--00000000000057978c065ef4400c--
