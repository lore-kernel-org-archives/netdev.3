Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDA3CB542
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268030; cv=none; b=E7g/fiEkX43HUDwzRYuNUUPw+J+uRve4nQe5csPtmCmI+XCASQa5mBMuiB7HDjznIj8nHDRK5FhayfVpPNrj5etzzZGT1iEHKBaJ3S1QO9+YnIGt80I0eMI0vyadxsYQ85f2KB+vvmz6nqp/aj+KRhIJIre2mM9osq+HnVg1rh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268030; c=relaxed/simple;
	bh=i4Knpelcx55NOpMckpuWMCCobs64Lv/aVBgrIGa3IMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUYufwlbDSLdgmXaSDiHOJNIv9kkoh4ty6m0eqf+segoKH3y1vkck5j9QMI+dZh1bWJSJWlFapE8TeUtGL6BlgTWwLZDolhae3bNefKT0vhT3wOVLC1Pjg/LjQhPYsopVZDvDzNXAjtMqIenWsogPWlILhIpKSZRNVf+YVDq0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JTaLKvTo; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JTaLKvTo"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so96158a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268028; x=1785872828;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q5kEsr8y/HR8gYhCyCTCRDZaknilFCXX9UCza1LA+do=;
        b=T9Y5+ShZDAhtkMkh6OLDDKinb2l/iuD88jxVb7L9kKjL1d7GdCuYiep30AXGKS5cNT
         LgO17CMvurqfhSjkNODMYUgN7W6I+CFA/VJ0HzavAKSowcCCCyJPdpNDYTlHZSXDjcRl
         X2XSmw3E1CEVgFLl942LQrzKpqli4Fs1GcwAwN2YJD6pYByqp7rqufZH13ufG1H6ubDb
         K+DmnEoV3nr0nlr4fTDGz1cCMEzTc+FGJ3WVvj/NqfycosBHpUBC5ZyuzIOcxUcQwtC0
         iaSKJFoANIT96Is6o+Jx2OPPqJF32ya/Chr4knscqH0Q2OaRha8rJiMBp0ziUZJht8/Y
         spug==
X-Forwarded-Encrypted: i=1; AHgh+RraUKCPxZ5rJ5nfCw8bI6F+kne6fcELzMX7TKHshGC6oR7FCJx0u5uHupyhiv8gC/GokiIA/Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZNg9rV/Ha8wnqgFS6JjqjXtwXapNyi5FpNu9birSBBpAmAL3
	Fadsq31TfqlHV1SKfasZjrFVjOT2KoDHPUYMCFqXBgLlFNWx9CfkZcHvjSK6vU/EGCrGTuOkGDk
	M05v9S4/BkoOIHglaWG6YGN0Ullesp8xchmPXvj9YHoQanbconiQw/eZpqj04KVeBekqqWdCeYC
	WlVUfqhmFKkh5tzHgSdmfDB5b4nfEqj0l18gLOvxIkN0n3dSsEWVU80DDbRXaXIDxsWGrzvvN4S
	5MUpOUgbSU=
X-Gm-Gg: AR+sD11xCOqEbCW8Ju1EOGg7Z1p8+8SoX1MbgBrRjme1Ep6E2XCP7X+ZF0maM6iZZaW
	KxMHaNX+rl+yc4focEQvUmtNb1IKfFKJPrVc5fZiNd69I4XKJ0C67Gq82HYZrxL+6KCZk3sFLlC
	TnehT0eYGfr0MELjqi7G6WW7IS7Py5nnWPlSQLG5PaAbRdVHT1v4uVmhQzUMIAj359hM4CledxJ
	IweJkRLsuCWGbUwhlP5dS1fQZmIpwEEXiikEQc/uStRdRMqXidKU0sPFQV6D0TFbmenmAg9SSry
	CmpsXCunfUJYdhus12lZcSjcRaR4NuMZeFxXePnJ50TkcD0wMgGFb3m3PqK82YJfrppvoWObstH
	BZ/g8DNZ3rrlRAX/vnX+GB8qkstAb2884u5WqD42mWGj8uCXZpMVLFOPAt8J2M4KSqQVHG/Ymsf
	+9/mOYEQyFJzNNB5irq04WPYdYar5uSZb/IX8=
X-Received: by 2002:a05:6a21:6a0d:b0:3c3:bf10:419a with SMTP id adf61e73a8af0-3c8ba637b0fmr4646910637.71.1785268028242;
        Tue, 28 Jul 2026 12:47:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbdba06ed65sm4905a12.10.2026.07.28.12.47.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2026 12:47:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1f3117bc6bso18897766b.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785268026; x=1785872826; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5kEsr8y/HR8gYhCyCTCRDZaknilFCXX9UCza1LA+do=;
        b=JTaLKvTohChJ+04+wu1H10rqx55gOXoC6GSz6VSTzcRLQgv0jDBnyZs7/nXqwgzE1H
         y16vm4MeMidBwiChdwpw7W2K7rM5i/5Na1mxkUorOTUorpxoRgfsCkbVgQRLeMKe8oog
         9C8sF9r2V1/HpMkAqEHGldiEYq/h1hLeNbgBM=
X-Forwarded-Encrypted: i=1; AHgh+RozGV/pBg+8Q108eePIf72fCIQuLstx2CCWzLYAwAb1AbNZbi50UxgmmnNH+z9cltuhY0EUPzI=@vger.kernel.org
X-Received: by 2002:a17:907:e916:b0:c16:13e7:fd63 with SMTP id a640c23a62f3a-c1f71b4326emr199286866b.0.1785268026045;
        Tue, 28 Jul 2026 12:47:06 -0700 (PDT)
X-Received: by 2002:a17:907:e916:b0:c16:13e7:fd63 with SMTP id
 a640c23a62f3a-c1f71b4326emr199284366b.0.1785268025565; Tue, 28 Jul 2026
 12:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728191146.1744825-1-will.chen.tty@gmail.com>
In-Reply-To: <20260728191146.1744825-1-will.chen.tty@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 28 Jul 2026 12:46:52 -0700
X-Gm-Features: AUfX_myrKMJwMnxDEVyR8AV53WHzgsWyMv2kKjPkvGlRK0gM4sdAuudXwXH8Z9w
Message-ID: <CACKFLi=OL=FBZ+L9fQH9cXqMrDtgnqqsTX+OjHqp0ssuDU+mXQ@mail.gmail.com>
Subject: Re: [PATCH net] bnxt: fix memory leak in bnxt_queue_mem_alloc error cases
To: Will Chen <will.chen.tty@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008aa5260657b11a05"

--0000000000008aa5260657b11a05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:11=E2=80=AFPM Will Chen <will.chen.tty@gmail.com=
> wrote:
>
> There is a small memory leak in bnxt_queue_mem_alloc:
> when bnxt_alloc_rx_agg_bmap() succeeds
> but bnxt_alloc_one_tpa_info() later fails,
> the rx_agg_bmap allocated by bnxt_alloc_rx_agg_bmap()
> is not freed in the fallthrough cleanup cases.
>
> Simply free the rx_agg_bmap in the err_free_tpa_info case,
> as this is the only remaining error path where
> rx_agg_bmap is allocated and needs to be freed.
>
> Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementatio=
n")
> Signed-off-by: Will Chen <will.chen.tty@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 7513618793da..c30507dd824e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16267,6 +16267,8 @@ static int bnxt_queue_mem_alloc(struct net_device=
 *dev,
>
>  err_free_tpa_info:
>         bnxt_free_one_tpa_info(bp, clone);
> +       kfree(clone->rx_agg_bmap);
> +       clone->rx_agg_bmap =3D NULL;

I think logically, these 2 lines should be moved below under
err_free_rx_agg_ring because it is memory related to the agg ring.  We
may need to initialize clone->rx_agg_bmap =3D NULL near the top of the
function to be more complete.  Thanks.

>  err_free_rx_agg_ring:
>         bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>  err_free_rx_ring:
>

--0000000000008aa5260657b11a05
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCxiUw8
vX80ZMVxAC4ZkUDLs2zPTaBWJOexgHBPfS3aNTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA3MjgxOTQ3MDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBzv7oQh9EkJgg3rTb9e6vzJjI9IX1WWYKI5i23R5Gr
kYw91gU07sGc0K1+LOeDIQWAie2Ww3aCeMJGUwhkjG8LxYJPkJSLp/LdklqYQh4cmdiOTi0/uRSe
BlL9eTWU+jr2Vj8Vvf1PLWW57DfB7WPdfrBUZCojr3cHN0oQcKXzfJtecxbr8f19EY0V1SoV7McH
aLGTKMv0KV3DwFdBPES+Zjp/wJ8ydBn6VZSh2zx5TfFzHfqg0XvN8N2EdYDYObgexkqQU6ERLoaC
0nSVOaeC0uhRHrAkHYiFmo+kYfFtInRWJUU/gPVL2T3en+BjCLM6vKa+ArOcNIuW4UJXYfiw
--0000000000008aa5260657b11a05--
