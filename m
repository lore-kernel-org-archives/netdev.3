Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258129;
	b=QjedMHLiiMmTa/rVGphuAPGhwR/mUArvhAO4wBvOOYUktte7mbZGW7sUn+T5NJVIUUdf
	 /MEPRh1/GH4d5m06tHvisLf2n3Y7gYXamIm/gUdtLrdC5yRjCl0bTy1xo+yRRb8IGXUR4
	 TKQMZ1f9CfjxQKfSpdoBlTLs8/9cHwxXHpgw5Gs9uHAkuRICUIDbJqQSafKTyrbanj5sf
	 LHOrXOH76KuseR204fxreGp1J53owuY942Q40uUhJkwg8hP/GjHk3RO1nWAPOPPdhNNYI
	 3yQb0bKzb9PS9BHPLCMjYYflROKg5GWMGh4nZ2SrqLtrECalnsV0vJxA3y+/Qw4uhqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258129;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=Aw1fvkj6ra5Fx4fVyenle5OoSaRHblNpxKG5E2aTIHo=;
	b=tOJqx/dBOYOo58Hj1nbnWlOWO7Js9iBMiFdq1LOZuz/AH2vJuUl4+fPyxebRJoiJOB3Z
	 sZhQcyK5FsI1Kxz8CBlvju3lIdJDOYA4HEHgl3aG0vrOXirzMYLeFtzEoFD+xwDU6WSV7
	 3S8KA46UnVJ7JP3gtaEndnTgVTxD867q9SqPG1fJg78GW2Y2xg6gHIqwxFy+QY0dCdcMF
	 vW+P1weI7HytNXwh1d3/vQ6cOnY/Mdg8gNdaAYJPekiCWZ7XEC3DTG/ov9LpD21MpherQ
	 ecwrez5/OPPEhV71zEerbuinICyLT8CusmyZPyEbXvSt1BKIr0g4IhMjazUHdX08hjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f6LPWqXb;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CE606A329
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E40CE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f6LPWqXb
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so853888a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793258128; x=1793862928;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aw1fvkj6ra5Fx4fVyenle5OoSaRHblNpxKG5E2aTIHo=;
        b=KZyy7Db8fvhTc44dOffBgJsfvX/uHAXuWK4q/vCsUMMcMxr12RYdooAwXt0uxoaufT
         F0wOgsI/i0bN1y0/S741hT5ooAxyU1N1HuHOrtMizdMV5OPpeXFGWEcRrRYmELrdD3tc
         ZUyGM4xMsQsDO8lgcTi/YFPz1QasoM/j4o8is8WJ7fmij4niJxcs9bNrIXlUk/M7m14a
         1rqR2yTZrdrvVGjfp1wNlIRZSrthbbfsLjvlB1ozEIWiQgwqdyztnTw6WBV6VoOmodZe
         jxuk5F8ckWGqVcYxryOQ99HvAGkN02+EFmBK1fh+qY43EDFkOSpP062NlCQUjvv0SOgO
         Z4CA==
X-Forwarded-Encrypted: i=1; AKwUvBxVIwiCJh8TOP7Xav3iUe2oZAfZmO4O7Rst6I/t7eRdOqYIlRIuycAefeiCNrIpKV8A7hEzh4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKp/rEqCxmFag0IRsMfbAlA14HBqPocBSduRIoTlfVbb2n1BrXZ
	xhjTSN9lqJM9zChRtP14Bt7rsmrjZLSwN3+15VNoBvwWlEorZjnuiUae8y4FdM0UIiEw+nQh3fW
	ywldbbub84mD2HOZ+X5d7XIgq6PLVHEqcT31tZko87zbKiK5+Rvi2OvGcGTYFr8Zo+P0P0zXOOw
	4qe1UNe4FP4yC8fn1MPxDUVu8XxflXAfM0mNsDLNe+QhUwUUtbl2a/666x6mp5tmuEUbuWhqRhd
	ll1WGJvUA==
X-Gm-Gg: AYBFou37SvbZNOJYE5M27xJwh40rAA93v98d8Y5SDQ5yInKmClqoXB6cWwv/vOUJyft
	JPYlloOmtUuyJSDA9UIPM5n7Fe7fZerZs1wWOzWuvSOKLDr4wugvM7PFv74GQNoRO546JhBoiXv
	Qc4LG8d2P1AIfUzU8MaqhSqn1APlPNWQTphUCLmD1f9PoDccBQ8ngTOgS523F24K8WOikT9JLbc
	ZqYjHenZ0GO/MtEUV1RruUKixDokZ+NyoiYR7PrbBLkAEQs6LnXuZymtRjo/YWJmvAfyW46liQ8
	pGQzlFxjd9S1sWSyO5LC8ICb76g0BJAzW61CALIeR9pxI/nSqsOzwVv2wEzD5yad+9D4ynBblJA
	TKFD3u5az2qs/DXh87O29Ds5ycuv5R7rjJzgmCEdIT4xni2RTxUSjVUcMTXhBKhVhQp3Wlf7pVD
	HcGt4hEgisW2Nl3/Xeh4mjFHjpfk4cx00IGA==
X-Received: by 2002:a17:90b:3841:b0:3ac:9259:1234 with SMTP id 98e67ed59e1d1-3ae58176ce3mr3515599a91.39.1793258128012;
        Thu, 29 Oct 2026 00:15:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e84adc9sm1418737a91.5.2026.10.29.00.15.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 00:15:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e942b1cc86so17866745ad.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793258126; x=1793862926; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aw1fvkj6ra5Fx4fVyenle5OoSaRHblNpxKG5E2aTIHo=;
        b=f6LPWqXbGoEEJ3igqa+KYMSIPQJqQLl5xFEffcZu73nWEa8yMR764Dh/kHiPI9t2k2
         EsPdqLGJJeooGyJQ+YWw/Jcc9Z2fCy9uJo4DBRHl3Wi9nrxSCr39PyZUr2semelJ2Yz+
         sEk5Wi9zWXFCKc3XCI5arkUZKlwiOhGV3urG0=
X-Forwarded-Encrypted: i=1; AKwUvBzSzTwoC4EFiETvZfI/KiKbXYQQZ47LnU++RGam7T4GRI3eXMsSymJs6eX0Tcjfi9MthlYnfqo=@vger.kernel.org
X-Received: by 2002:a17:903:3885:b0:2dd:ad73:5b6d with SMTP id d9443c01a7336-2eb0042b156mr42350815ad.29.1793258126220;
        Thu, 29 Oct 2026 00:15:26 -0700 (PDT)
X-Received: by 2002:a17:903:3885:b0:2dd:ad73:5b6d with SMTP id
 d9443c01a7336-2eb0042b156mr42350555ad.29.1793258125845; Thu, 29 Oct 2026
 00:15:25 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009-psp-v2-0-5596ab50f677@gmail.com> <20261009-psp-v2-4-5596ab50f677@gmail.com>
 <CAPHeo3erVfzLE0wTmz4=0HKWdOL63+7W2KXO67OuEfRXhf_M8Q@mail.gmail.com> <20261028152950.6624ee83@kernel.org>
In-Reply-To: <20261028152950.6624ee83@kernel.org>
From: Kiran Kella <kiran.kella@broadcom.com>
Date: Thu, 29 Oct 2026 12:44:48 +0530
X-Gm-Features: AclHuK8DHaah1R1ZECZHg9AkA4F_fCsiPZH84nmo9xD4V-Igd_4si7RqHGYezzk
Message-ID: <CAPHeo3c0RP34ASvzV3UrwDa4PvXHhuAOq1+-Bn0Z5+QXFV+BpA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/7] psp: add core tracked stat for
 outstanding tx keys
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a30cfb065ef571ae"

--000000000000a30cfb065ef571ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Oct 2026 17:16:17 +0530 Kiran Kella wrote:
> > > +      -
> > > +        name: tx-key-count
> > > +        type: uint
> > > +        doc: |
> > > +          Current number of Tx keys installed on the device.
> > > +          Only visible if the driver stores keys on device.
> > > +          Kernel statistic.
> > >
> >
> > Maybe it is good to have a counter that denotes the number of PSP
> > sessions set up on a device, which is managed in
> > psp_dev_tx_key_add/psp_dev_tx_key_del operations similar to the
> > tx-key-count. That way, even in non-SADB drivers the user can know the
> > scale of the PSP sessions set up on a device at any time.
>
> AFAIR the thinking was to also implicitly flag that the device has
> an SADB here. So this stat should probably be called tx-sadb-key-count.
> We couldn't think of a reason to count the tx keys when SADB is not
> present. Rx keys? maybe, because of SPI exhaustion. Tx keys - why..

Tx keys to just provide info to the user about the scale of active PSP
bidirectional sessions (after the key exchange) for debuggability and
for any other derived scaling/performance metrics.
Especially for non-SADB drivers, where there is no device limit on the
Tx keys that can be created (of course limited by the SPI exhaustion
on the peer).

--000000000000a30cfb065ef571ae
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ksPFF8lRQaSHMJFFWI2usTUpS9gKxRAuJyHc0xlNKy4vK2ZEic8RWs34T6LcL98JR51RaKtE0Dw9
7F/uUf87z+/74aOyyxrTl58LlkxL/+1yMEHZhyn6z30LHQuA52TSp7uD3au8gu0YN+hKIsPBKVbs
dzf/bW6eDpGSwgwRzqF2BcDBOUA9U2mB2cxinBxOxCVbYRy//Q46OuAx0pXw8trIkPDdp8kHAoWD
7JxJ70nrdMy8VRmC02NQp185/6szeMFYLA0CAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYa2lyYW4ua2VsbGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBS/iTArBeV9hFyyktvkwzGbaKne3zAN
BgkqhkiG9w0BAQsFAAOCAgEAdavxLwcm6Kj3S7/bA/IO6B6MTHIndKyB630T3CTPeOeuHV7ZS4wr
rDZbrSjERD36308lnaXSESlcu8LX2SKJ0KqNM3VQNTawSKS4wMXlyTzOBfaslsjtFiT4jQW9Py6u
6nf1EVoQ6YTCGJ+htyKqFgIljJIdBBOvXY+gECh/DC+VbLUVK9CgZLKkFJ5udhYvw1tOc3zOXGOd
kwaK7AtwRSLgNt5RSAaikL6bvU1kUWgITNKKhBK5F3CNUbR0hD/i7yG6Afdh27V1T7FEdV07fBbu
3+AVnAdbZmHfnB2T8lHTaR9GbgkF6lG/a8I+eUG5NPrDEM+afXT7/+zOTjf799qoyhMdfgp90DEW
9ukfyqfUq37ctBG4TdnDlxtkwy9XYw0Avotf2lrYy+6MYjt3cZFF+AF/F6ANk+Gx9zH5gyeUlruJ
+aqmP1U1lX/n2YEXAfiLJulbb3Jfi8lvyYzHXpHLIFtLfyVOzUXdGdj3dVxxFSPJ4uXmpk2SLExM
W7+cvJ+PxSJyWK723U609whQmqbVRz5B49CjNt/exjWtBGGjCwLPMGNWbHbwtDVWcoZzE0KoL7EK
VPB0t6uom5ElZ+qieZghO80tR/MW2eL8i+EiVMwq5GF1Ni3D6uypwZYqgdicI0YGj7JCgrIzr1kC
xwtQkw5ij2CCUWXxadt/C9gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
AgxbhXTUwXZ3dIWSpigwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGcwqkj+U3mi
aoCvdub6vykMH+1kJy8zmZGrREg/DpnMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MTAyOTA3MTUyNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAEtF6gMuoedB5mvPI5klbqdmEcuK6aXqkHbd4ClYIlHUe6j1
/fZMCuuJ6iKf0NLQcOmG7jGMbmmbL2AVTGyGXTrAUcg2junlM0v0YFxjBlOQHZhqNAzb8n3794C6
MclMfxXlVrobRt50nwpDeXvWV37aU5CORdZTZOH29Joy1VOGXPQhQWgqcjbxPQ1gNOsAg7tAuzGL
Ds0IM0urLoY+VWn4dL2SKiwU12Rfs2zUOhf9TZ6psb7wE/CPSzINnZoUZtEaCzd6z3G5sDLepTZP
tIhbMjZEQrg5xjX1ocNMGbTKxKxBiM8jnLgfq5hzvax+IcpIBPjn6oxjwMiF003/ssk=
--000000000000a30cfb065ef571ae--
