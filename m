Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351869;
	b=XM8pcCMzxUJ0rRw7Bl9M1S+sCKNBQYpcX/N7T16DQrpmcfNTIc8C6b2qwkHWSGc61JTd
	 ET9BoZu0pMbMWO0O9AuyPGs7ctuNodBlHvbNSOxOSeB7f+Bnhcy0ay4kkRYnauBVkgiPE
	 bZl7N+k2eYA6V62YSNR9kCVWn75/AKcWERRK1t1QYGLwUbXtZZo4fip61SnJ1Icjklcbz
	 asOkAEO4CKwZmKK29PLrp89JJuM2yoL4meQ1uknUndD9EX0pVyB710cNxGgM/xqq9i+Hg
	 BfNWgXSFsHCfduzsJf1u8ozNQBGET0a8+o4lBeVnDWnxsxfxzNo6ohH07oO8vF9rN9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351869;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:X-DetectorID-Processed:
	 Content-Type;
	bh=nYq9pM6sTwrldFRXuQUjDR/R4e5lyTcU497hGAhNfO0=;
	b=CELU7CkadX7AKt25BX1iiHZeRjREorqqQu6TgS5LwvqcmaMprBBn3iThig+BmA6x4EQZ
	 dqp1rjWU3VsHmeOabbvlNFpHA+ojVpsCTGb6ZWZ5T0ojMVsJgH/BMk/tbWfFsPoGG7FrX
	 Y0Rkqtrysd+QLUiN2NdonkLfp/Xc7RmOZwa7V0i2X7rSxN5vLJWRd/Frxq9GSx7jwDO9I
	 CwLWcUfIJB3qqByUqOoSltFv0QSGs8dCgpvsveaQkPNCKh3M+1AOwhlrrofC6ZaxHTl3L
	 eJdt0n6ZzMEjibSBnSZe8Nb/eozRDOuA9HLBb6OPZqfmvUTOBCNHLE1+Hi+SJtCaZ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LRJNSsWY;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBFA606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBFA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LRJNSsWY
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso1312917a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794351868; x=1794956668;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nYq9pM6sTwrldFRXuQUjDR/R4e5lyTcU497hGAhNfO0=;
        b=XL6msrZGH5ryvyfk4Mj4mK6Xl4OmOtcQ27GZSC0+Jz8IOHB3LhdmhyZ3w/qptTWdPU
         Ws0CLXBvdmyisu4N5C73T9bOv/ebYs/zOHMFbL/k+QgSG7+RTLDX7EydjtemMD2D5gmX
         rIY6YKITyKmyrHpvzFVyvFtni2Tkgf7TdEcOez2bckcilUjIkPdSZso2XQs3PuzJ+q1l
         UG/cmWEKGGAtZm8MOl55x3JHtDmaj6yLmyHwOGMl41n/l/eUe0OJRr3RD3ldnS0acq4h
         qf7JIPGUlM+ar4C+ovngIR7cA9KxRBVbEFhbbCEvrm+GHfaW+m8S+vf+QSe7RxVNIy1k
         1FrA==
X-Forwarded-Encrypted: i=1; AL+hErFEpQ4185y2ceD2TPeFOH/DyIH9dg40TC7i9cOPn2rCTFtFv1GfK8Pu4xBlpCJ3oA8kDZDT8mM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m88Muj0nWoH80WiV2PuI5u1cYoEgT3QxxT0c61msF4gKKU/IS
	EKpdZijlJZHnik6SMD5h7uceXfaMzJW75dc2HolF1k+4Y1drKTyyyYCOO8mTrvGjZxLKgHonFMi
	fnh09l71gVRh0pbhfJsaY+hqYebvE7a6KQdLRjMdeITr461yTeWwTAlxeuwewIV8TnQCW2E32hg
	MlC0zObq2XabBqbzUQm+pWgfLzq0pXv+skb8mZNkxSX1evsnJghGMlg0LkyNDzBX1sGnlIfnn/X
	LA18hYdWN4=
X-Gm-Gg: AYBFou22/kImoiaJ3UQLdmqD/EmM7IsnxEyYcUnG448YnUZVnHCTFFGakFSu69KUaJZ
	wODWOunQfR85BLYN/7TkRm01xxylD6LybTiF4u5RKhLBHQxiKkbASAQ/KJI6AxObZzHZYd2XYj9
	oK30o4OJNwpxQUplvJK3DnWyESvzmQja6wzGsvsKwD8NOYxL7/N/GcrUPtxP1GxnCp0cnshpfyq
	USKR8Bi4sMmnxTZllCzwbz77F8G/4cDkO6p4x9peb+Hfx7PPavWSLPtaW8Er9PGb2NtuPz9fUxQ
	XoW/iattx2uNSlBuD/p1LNiTi7fx7gXkcdxkDiMFhkUFTgeuds8avaCOUgObhFxJqP4wjaJn0Ec
	8WnGGJ+9CuA+gQ4LG/EaN4yOgWhUz61Oz7xwv/IkQSMCa1UCRLUHa6u8QvGH4bGpxntUsKO+V34
	TzNwZSQG3pjI6tesrMNmtAB7HB+/bsaQeSYEo=
X-Received: by 2002:a17:90b:3ec5:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3b182f298f7mr509161a91.52.1794351867597;
        Tue, 10 Nov 2026 15:04:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17da4b500sm790853a91.2.2026.11.10.15.04.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 15:04:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a5d57a8d51so3076602a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794351865; x=1794956665; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYq9pM6sTwrldFRXuQUjDR/R4e5lyTcU497hGAhNfO0=;
        b=LRJNSsWYqVXJGncmDxxdk9+vrQtDrPkrJLV25f3wjsZs3TMHEL0t3TbqnXuaQDhkpg
         9utTaaIsq4uisx0TqgyKG8Lt/Rm7N/G86odFQ1IW7U4vu3M7Tr5SprB+KhXEbYmGaY4H
         jqhJxiuRUrT4OjUbnuxAKaWvyLlVqVBvjcikA=
X-Forwarded-Encrypted: i=1; AL+hErFtwcrZ1LVyM/gjQe+88nLHqPWCSVbKAsphy7xIvEEzyoybJlgVJS0JtvsBzHmkP0CHQ68hous=@vger.kernel.org
X-Received: by 2002:aa7:d901:0:b0:6b1:b97b:745 with SMTP id 4fb4d7f45d1cf-6b7775ec3c7mr399100a12.29.1794351865408;
        Tue, 10 Nov 2026 15:04:25 -0800 (PST)
X-Received: by 2002:aa7:d901:0:b0:6b1:b97b:745 with SMTP id
 4fb4d7f45d1cf-6b7775ec3c7mr399086a12.29.1794351865049; Tue, 10 Nov 2026
 15:04:25 -0800 (PST)
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
 <CACKFLinPK+wR=TMA3zNJDKQR_=HfMFUHPxKS+yhvv9SegZw7Ow@mail.gmail.com>
 <avNWzavrxJSasfp5@devvm20253.cco0.facebook.com> <CACKFLikU8ax8-VN+EiAhrn_w+2=yex2TNHPxEYqni6g0BKHKKQ@mail.gmail.com>
 <avOXJf5yl8ajf8Qr@devvm20253.cco0.facebook.com>
In-Reply-To: <avOXJf5yl8ajf8Qr@devvm20253.cco0.facebook.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 10 Nov 2026 15:04:12 -0800
X-Gm-Features: AclHuK_cW_HHwh2JJSfJN6ZxDLcIaDEDtetVv56JzQyB31my1TzTAGufMW1nTAI
Message-ID: <CACKFLinsQdoZhEnhmZmMEMZVyGC10KZZRciBGLzA12W2iOK60Q@mail.gmail.com>
Subject: Re: [PATCH net v5 0/4] bnxt_en: Make RING FREE more robust
To: Joe Damato <joe@dama.to>, Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, 
	Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008e4a54065ff419fd"

--0000000000008e4a54065ff419fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:13=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> On Tue, Nov 10, 2026 at 10:14:50AM -0800, Michael Chan wrote:
> > I'm copying our RoCE developers Selvin and Kalesh.  I think that if
> > you call bnxt_re_suspend() before you disable DMA, nothing special
> > needs to be done because the chip is still functioning.  It will go
> > through the normal removal process.
>
> I'm probably missing something but I think that the ring frees can only f=
ail
> in __bnxt_close_nic, where rtnl and the netdev instance lock are held. DM=
A has
> to be stopped before bnxt_free_mem. bnxt_re_suspend() takes both locks, s=
o it
> can't be called.
>
> I think there's two options:
>
> 1. Stop DMA as now, but queue a work item to run bnxt_ulp_stop without th=
e
> locks. bnxt_re_suspend would need to treat BNXT_STATE_DMA_STOPPED like
> FW_FATAL_COND and take the detach path.
>
> or
>
> 2. Call bnxt_ulp_stop() in bnxt_reset() before taking the locks, the way
> bnxt_fw_reset() does, and bnxt_ulp_start() after a successful reopen. Tha=
t
> covers the TX timeout reset, which is where all the ring free failves I'v=
e
> seen come from and it doesn't need any bnxt_re change, but it restarts Ro=
CE on
> every TX timeout and it wouldn't cover a case where the user triggers
> close/open.
>

I have a slight preference for option 2 because TX timeout ->
bnxt_reset() should be rare and stopping RoCE briefly even if all the
HWRM_RING_FREE calls succeed should be ok.  We don't want to stop RoCE
unnecessarily during a user-initiated close/open though (failure
should be very rare).  So we may still need option 1 to cover the
other rare failure cases.

Let's wait for Selvin's and Kalesh's feedback.

--0000000000008e4a54065ff419fd
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCxbv1W
c38b1Jj+HMctxcqV8K/4+OEoCbPCTbHC71XD0zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjExMTAyMzA0MjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBSnmJw9Q2BhoUDEClPex8S43xM8QvMJ66kgWiq3fMl
iRcTtnXIPXRjYknqhuBq/POTHjuBA7oYCZnRm8+85XJzI8KWimbh1Dm3J6qRD9SbBhRemcBzUAjK
4HBEX/8JyotR/LM4dO3gIs/ZgH4y3U9Virp8Anysv3igOEzUxrpCWQRvaI1N+S8EF4zMHnX2Bi20
Q6yN3J3MJXkVVdZf5znSdTXCGXMNYaDwlGAnqZ8uxYoObFn10X2FHpZAjVRWc9VcHaeIsg2DusBk
MA1EygzCm+Qy/IabpqwDSsV60lX2PpNMd1uy/dE90ZC1ZttHuX/ErTBbIYSUpsS2Ij6aPLkR
--0000000000008e4a54065ff419fd--
