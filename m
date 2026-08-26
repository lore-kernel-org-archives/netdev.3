Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11C7391842
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747885; cv=none; b=XQ7rakFApn3YC9M39PJI2ylkJdmIANeFsmKCeHXS1DeWgex7cImJ3Bcto9TJDIlU7LGR57ThPnz0QAgGvXfj4RAGd6QtZUjn+uDIqh2pkSoB+/aDU+IVNGWNIQYcpTRYAB2BiREA3/ecXVdVMpeF3AOTjGch3qMAaUxsrXsfbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747885; c=relaxed/simple;
	bh=FqlU5d14kO0yE9Obqb67f7D9zHTqrzhNNCBaLdQWtBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYDrz+PjEq/yp2xxJ+O6H6ZA6nGIFJpezhFOvx65AsA4jrv4ombHRJYV8aG8OdET5KDyMQGwye4xQTftwSmtn/fqVS0s7oA3+FSZ/I2UGvMCuSH44Tt44l9hdETy++pPswZoUh4R3HKx1O9N0UVxjq4ZaJytfeSwye4frDhwmGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EY5W0+Wt; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EY5W0+Wt"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-84e27035206so408315b3a.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747883; x=1788352683;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FqlU5d14kO0yE9Obqb67f7D9zHTqrzhNNCBaLdQWtBM=;
        b=eYbMn42jT09iDoNkXkoSMJTQShdky5DEroJ036GlKv0RQGbWjvgIqIMwkRoqtY4jgQ
         JhC7oZmwQs7tjtQlSx8oHEk2f+bpnXBRtoYFBwKrQVGruKZesDmvUyCAJmVg5kqENnPJ
         6hJKTq38NukSb66496wp7rvmTIm0kZ7Q1CxFeofmxxitdP2EEq9ZmPA6ynWg6AGM78kn
         WQZBWr1XTP4VfibzgJO4njPFH77V986CLQ8P+lbZfd6L7890GzS77dwBAeRAnZ73xHt9
         n1HLHXo1tj3CnnoZSAPtw6zYMfHJuKmOnvopZN5/C1G19eNKX3wC3sYIAsHnOxrw598U
         VD0A==
X-Forwarded-Encrypted: i=1; AHgh+Rp5vxOkjcyaCbnFWziwBvkuDZAbXdLobfOc1lQwrCUi7w9R8ugDR3p6y1rDHU5HHbpUz7rhlNM=@vger.kernel.org
X-Gm-Message-State: AFuF++nULIPPPkH03HyWofq4JCNnZ1OlUzb69F6lq6UPr4qTFtqt6d4w
	pKsbMRklGqRJbD30wGEtrulio0oV23cCHIlE1RN3/lj4R0SKSmVLFiCSo57bQO5aurZxnVI/3Ok
	PclzpbNjGllyAJCzgrXnlU0xzJ63PB/CxcQqH3gezMZVK0eIk0cojETze09qNr+IfrcSiFrQ3D/
	2MaeJWhVVPd9tlHawxzctyowvNd2wnyn0XDitD68oA9JJ8ZQZ01dci0u6f7ncn4b+pwtjGHvNAs
	tQfwCvgMPyjj+CD7g==
X-Gm-Gg: AR+sD13G6Pp+eSAoH/5O3YMxiBlwB+VzA+MMkfBP3FHEIj1idOWluUhe8AOdFsh9ca9
	Fm/kYrlc5fnZg84DernV94ShsL5JHlni8zQ/xBXzkQaOKK0Kx44ek6UYy0tmtkJzAxBQFVdeSXW
	0BwStKbNmdSE9KSLlo3NnStlgVrmKgrVjzfRKYnR1Mq5pZwFWc+enZByf+ht/nTemMGACv+ir7e
	/0lmzGKk0/Xvc2g5mALcSdni3H3VUVsEQfGsGVIZwa73cpxDlHC7Oamkj+4ceiosyUid2/K8gv3
	I+h7O/fAyS9Nvdxppai647DW27f03SEOqpCarsJZeO7Au3ttX4qpcEf6C1uPN9sGU4MFAXbSDT8
	2ilupRNfxMD9oKh3O5kC2VeuyjmBXGwz8hXQp0pt//cLgmUSrki69IEKVKYmcnkr0/yWU+uXM+j
	l8XGip8KowR8V5/s++mGmOJ4lnG4gsxznDZIiU9Z6feQ==
X-Received: by 2002:a05:6a00:1888:b0:848:4754:28e4 with SMTP id d2e1a72fcca58-853755c2fdemr11364646b3a.15.1787747882881;
        Wed, 26 Aug 2026 05:38:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8538d8b5a8esm898739b3a.8.2026.08.26.05.38.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2026 05:38:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c210c66672eso80072366b.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787747880; x=1788352680; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FqlU5d14kO0yE9Obqb67f7D9zHTqrzhNNCBaLdQWtBM=;
        b=EY5W0+WtFsFOaOSmDSVenrLHmjZWKnZ+uKBnpgsRSOwstcQTm5NgN9sAGUlTRhvYgz
         KwcUO6MVTU1/4tPh6PJ4EBu45sGtb272klNpnEqIz0Ow6rKp+cqyrcYR7SzX6UnFEXl1
         h+utLhqXShiGOVzin++d0JQEnza4kYt6f2Xy4=
X-Forwarded-Encrypted: i=1; AHgh+RoCDEB1wta+q7DxOcSI1damQDobg5HvhBVj4SlWA8EKqNEp8d8oungwUiYHPW680JxT0uHsAwo=@vger.kernel.org
X-Received: by 2002:a05:6000:4a14:b0:47f:9096:3ef1 with SMTP id ffacd0b85a97d-482e26899efmr7531863f8f.9.1787747423871;
        Wed, 26 Aug 2026 05:30:23 -0700 (PDT)
X-Received: by 2002:a05:6000:4a14:b0:47f:9096:3ef1 with SMTP id
 ffacd0b85a97d-482e26899efmr7531799f8f.9.1787747423437; Wed, 26 Aug 2026
 05:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826000234.2031564-1-joe@dama.to> <CACKFLi=gFqMz2nu_6gf_pX0JBXxsygcuzUwXAdqL=8XR0Jogng@mail.gmail.com>
In-Reply-To: <CACKFLi=gFqMz2nu_6gf_pX0JBXxsygcuzUwXAdqL=8XR0Jogng@mail.gmail.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Wed, 26 Aug 2026 08:30:11 -0400
X-Gm-Features: AcwNN1XkZ2TeVi02ehUP9iKyMms2IsgfGsNkChcO8ZQtYv2Be7FwbhxsMjxfah0
Message-ID: <CACDg6nWtE+0tcHqEgd_+=kHKpFGf-78Rc3ALyzJO9ZZkV2g=uA@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Write doorbell when linearizing skb fails
To: Michael Chan <michael.chan@broadcom.com>
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Simon Horman <horms@kernel.org>, 
	kalesh-anakkur.purayil@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000063926c0659f27d3e"

--00000000000063926c0659f27d3e
Content-Type: multipart/alternative; boundary="0000000000001f6f520659f262e3"

--0000000000001f6f520659f262e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:00=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com>
wrote:
>
> On Tue, Aug 25, 2026 at 5:02=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
> >
> > When the driver is handed a burst of packets, the doorbell is deferred
> > until the end. If the last packet has a huge number of frags, but fails
> > to linearize, the doorbell will not be written adding latency on TX for
> > any packets in the ring and holding their DMA mappings until the next
> > TX. Note that the queue is not stopped, so this issue would delay
> > pending BDs until the next TX.
> >
> > This issue was discovered by Sashiko and reading the code verifies that=
,
> > while unlikely, it is possible.
> >
> > Fix this by jumping to tx_free, which replicates the same pre-existing
> > logic but also writes the doorbell.
> >
> > Fixes: b91e82129400 ("bnxt_en: Linearize TX SKB if the fragments exceed
the max")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joe Damato <joe@dama.to>
>
> Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Looks good to me, too.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

--0000000000001f6f520659f262e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Aug 26, 2026 at 2:00=E2=80=AFAM Michael Chan &lt;<=
a href=3D"mailto:michael.chan@broadcom.com">michael.chan@broadcom.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Tue, Aug 25, 2026 at 5:02=E2=80=AFPM Joe Damat=
o &lt;<a href=3D"mailto:joe@dama.to">joe@dama.to</a>&gt; wrote:<br>&gt; &gt=
;<br>&gt; &gt; When the driver is handed a burst of packets, the doorbell i=
s deferred<br>&gt; &gt; until the end. If the last packet has a huge number=
 of frags, but fails<br>&gt; &gt; to linearize, the doorbell will not be wr=
itten adding latency on TX for<br>&gt; &gt; any packets in the ring and hol=
ding their DMA mappings until the next<br>&gt; &gt; TX. Note that the queue=
 is not stopped, so this issue would delay<br>&gt; &gt; pending BDs until t=
he next TX.<br>&gt; &gt;<br>&gt; &gt; This issue was discovered by Sashiko =
and reading the code verifies that,<br>&gt; &gt; while unlikely, it is poss=
ible.<br>&gt; &gt;<br>&gt; &gt; Fix this by jumping to tx_free, which repli=
cates the same pre-existing<br>&gt; &gt; logic but also writes the doorbell=
.<br>&gt; &gt;<br>&gt; &gt; Fixes: b91e82129400 (&quot;bnxt_en: Linearize T=
X SKB if the fragments exceed the max&quot;)<br>&gt; &gt; Cc: <a href=3D"ma=
ilto:stable@vger.kernel.org">stable@vger.kernel.org</a><br>&gt; &gt; Signed=
-off-by: Joe Damato &lt;<a href=3D"mailto:joe@dama.to">joe@dama.to</a>&gt;<=
br>&gt;<br>&gt; Thanks.<br>&gt; Reviewed-by: Michael Chan &lt;<a href=3D"ma=
ilto:michael.chan@broadcom.com">michael.chan@broadcom.com</a>&gt;<div><br><=
/div><div>Looks good to me, too.</div><div><br></div><div>Reviewed-by: Andy=
 Gospodarek &lt;<a href=3D"mailto:gospo@broadcom.com">gospo@broadcom.com</a=
>&gt;</div><div><br></div></div>

--0000000000001f6f520659f262e3--

--00000000000063926c0659f27d3e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGozCCBIug
AwIBAgIMLAiVyur+1MRjdDgxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDMwNVoXDTI3MDYyMTEzNDMwNVowgeYxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKR29zcG9kYXJlazEPMA0GA1UEKhMGQW5kcmV3MRYwFAYDVQQKEw1CUk9B
RENPTSBJTkMuMScwJQYDVQQDDB5hbmRyZXcuZ29zcG9kYXJla0Bicm9hZGNvbS5jb20xLTArBgkq
hkiG9w0BCQEWHmFuZHJldy5nb3Nwb2RhcmVrQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOP/A/G3pTTF6D8/BCAHpxJpQjOueWirQLqbjFWJTHsh6ADFdvKs+izD
0snfZopX+ZSMfR+NKl12zoJaZy/HTGiXvyeLACXBAP5i8J+smf3H0UZo+ztl9s/CLIxDfjquoQYV
UHAKWXC5euJvZ4N4/n2E35/OV6VV3JeKQHAiSOXhljrejDS6Wk96WYaQKawDm0jYH6OoXDnR/CMn
3bcNBRgaGW5VtJUP5jpTLrsQFC25kFf6fA5/HWLsVdOwkBWic80s6HCG0ROnFWnbLPL49NGItRmc
Cndhx/wUdeIk/qDpB3NiaC0IsvVNnZLIIbEl5kBojwkZV0jD/VicntRDJ78CAwEAAaOCAeIwggHe
MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEF
BQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNt
aW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoD
AjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBB
BgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNh
MjAyMy5jcmwwKQYDVR0RBCIwIIEeYW5kcmV3Lmdvc3BvZGFyZWtAYnJvYWRjb20uY29tMBMGA1Ud
JQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQW
BBTQMVctYYJaUBLeJgZz6cT67l9WmjANBgkqhkiG9w0BAQsFAAOCAgEARE5k774M2TzT1K6LUDrm
HBHxHxe8rQpJrB59lyOANT2BjSITyUXPC/Up9ExGhYbioibOJALdaBhATnMgqw03EJLpr7Sy/mY9
g/LlaPMSHU0vcuhuU15DAwQfJ9Liw4K9AmTo0MnPKgiSDLWT8yuphPFiXATg1x8+K1b/KEt8t3Cx
3pY6cGPUH4iJXz801q7ka38emkBlMKS4i7eWgwCSHR/9c7JvlrVYT5+wqYCbmPasbv3jNS0MfEdY
qNLhtJABTy1ePhWmAzFMlbexVyN3FeWCOtxrnnD6tFhYt9dMX2kSvti9voE1cPJfyHj7IhvHVlUc
aBR5GY5F9netDgPvbqg1YpqYZwxblN6i91QhywTGSydHpbgJAmVEEp9rKvGJirwRjORPt0wXb3b6
6BzJD4dFfmqoXVKRl6WHOOICEKWVcD0OnPRdCJEXiSW6y1xobGpElvWmB7lGIE+W9V/Efv17PdJa
/u6hPkFWZBhzmFzEWDSaWvsfJpk3Jb+8oHhOk0IERLc4VLhPNhyMOQq+aL30GjEej1lqr79p5a70
/+WaRxxlypFBMj2V0384P2ACDsYAayPdKSx5aoEJWmW2cc/xR0LxENIsNWeqUBvEjcA6Qud56l66
dGBNtVCEGdHfKttDlWel93rPRa77UmnqEt+6YNFCXnuhaSUJGOA0yxQxggJXMIICUwIBATBiMFIx
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxT
aWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwsCJXK6v7UxGN0ODEwDQYJYIZIAWUDBAIBBQCggccw
LwYJKoZIhvcNAQkEMSIEIP/GfMYdSFfOvro2wLfibX5OVZyuw2VekzDiBMjw5O7HMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDgyNjEyMzgwMFowXAYJKoZIhvcN
AQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0D
BzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBANJyzLoHbNuNyYXU
rjMdcTrVz3u16S/u3+mE4MWYb+JTvi3LBfjm1A3m1jfHQHGP//UUaNWr+jli8J3LAh7lmaET3gNZ
q4DwMmA51nvCvKzPFFWQcZcYRp5ho/VxIJcBHCU+qwbqTcsyFuqY5dpAP3wN9OWBcdictwaDconY
PeqoLjJpNWU/GxG7OsNR+mYlhS5tFmsWoGK8vEm8yR3ST0WO7hFSiPqbNgMbJ7gz5NW4oru96EnP
hmesh7nwFbdzG6qTCHoWrd6BMjdPTYNUpwBsGbealyE5/sgBc7F4j8CiIXnjN83AjfG7nMPVRYCS
kWix2UAqZYYDxAdi2/r2Gr8=
--00000000000063926c0659f27d3e--
