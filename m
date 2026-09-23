Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DB378D8D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136875; cv=none; b=B5+tuhlgni07p3qXDpXsd6jsBdyC23g7ZqQuG0sg5rOG6oUVp1RIbkFNCOk089sCyRCdoiKnFIeWd6F27TS+exWgCcw0hSJxTLDP7SMsutFZBWY5ernPORHMNZMr+GJthbEwI4iOGpSUkRV0tL1aNj48F38WR9z2zk41IG5kqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136875; c=relaxed/simple;
	bh=b1nwoWCDt4xSSUHLv4di3MI/99Rl+Kl1VgHrdEGh5+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJijm1f2B3by9Qb0KvVrMoCGE2UmJprVd2UYD1oS634LA/xTrHOM7h61oyfMTZczzNEfQ+JQtc8pcs9BoaPJXKxKxHyNwhQ4JXIH9GocGYuPqWCughauEYXNcz5ocgVKOO/4dohJ0kPbxqbgXhPNHJFbYN6ozOqUj0KY0nOg5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H5vcPjLR; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H5vcPjLR"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-530ea5dafd4so1492361cf.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790136873; x=1790741673;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QgvfhjPV33vV1UmGusRVlmGxfpp81r3M/A4ZC6AJW4=;
        b=mSXgqgBKuLZfBgEWIPWhFu+UFUAA/BbjCsiBJ1JmMOsmvMyTtDuItv317l/BW+etev
         7FeIKhol1/dcQ9nlZum/5SqaGpwCAO3ixcC+OVtSy84AYSFVUa+TOb/Aems3kT/QgsVo
         gObX2CTuOe7wlXQaFOczJtr6HXDZz1EvG6trsujTVk8IuUp/3nWJ8+kTpd9ZNlFKeVNt
         bXym2jC6jnS+kyTZkI5prIQnMeCjW4y32rp/wvpx+TIRnsMPpEf/Q+HBKG5ieZhvCWR+
         apGmitaSGgcTQ9pA17V2FxsaHb5Qd1BaQKIU6pQIy6chVzA5+dOHELadYaJd46Cs+Jx8
         FAjQ==
X-Gm-Message-State: AFuF++kRTw8qw0joZxT36RgEot9LpUlfrhP9PSgfpQHgaAEnqV9p4NmW
	PhqHHX8V8MOvEgolBP3WAULQxrI23Px602v6++LYpZI0XBlyRFOVCAhOB/mH1LUPKTf4RDCUXIo
	wwE+wFlg7M8udAjXcQUjPQ62zUz7+0AaVKQbgOI/uUfkg7Omds0YLeA82zGL/8CjkX1erSJi1H9
	1flnESoksPt2DKBWhSbdUUnpOSKs/2R/ylVH9t0RoqtVHHeln02jlZlnQR7J/VkY5t+rlfE12Ic
	3tnr+xumGw=
X-Gm-Gg: AYBFou31Q6IDh30qO6rsOnmFF+I56reuv+8c8Wc9kKd3zqrCA1snlqU1b29jcSylVbN
	G/uXigkLEjKbekoipGdTnmPzc1jDtLhzye7istcGrHWmnBCFoIEH7UXcG5PP0lrJy7FAKg7Cqea
	tPfca+5mOpP33Qc2ZTKHO8JbfSVzQiPMyfjAYzYmb07eYq/ZV5Ws6C4ZEqHwA6pmdlzjrPbHk/T
	zSOcBGpXC9hOWFXhfx9xb53vkJTSqq3v9YKxSTVm44LHbGobz8WFXIBW3OfeTp4N0twh6kGliH6
	ODnYkcXHd70/or3AvWDYOqUvqAO5UGxO4rS2gOFjUr8UmmLM4d7OjyEE3M5eogK4SbK+8x3vxQa
	AgWQ3XFy8TvxK1ybrdvLiXMmAAVNbxnCdnaf4EFQXPNrB3oC262Uk9szMsuJFDbhKlLDETSGxJ9
	KQip3vEFmJCGkWxgcl/VSPPs+mxvEmLbeSHZTt+7pSJqRC7A==
X-Received: by 2002:ac8:7f92:0:b0:530:4249:e7a9 with SMTP id d75a77b69052e-532eabdb731mr25877081cf.13.1790136872910;
        Tue, 22 Sep 2026 21:14:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-532eae6b171sm266891cf.12.2026.09.22.21.14.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2026 21:14:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2580a59d0dso36934566b.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790136871; x=1790741671; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7QgvfhjPV33vV1UmGusRVlmGxfpp81r3M/A4ZC6AJW4=;
        b=H5vcPjLR3aQkw7Ar0TvvrCIsw0wQdb8Ea/ftFoy4//nS2JwQvSiQTex3L09wd1Vf9i
         NlR4t+KX5sVtvVg/M5XsYebb92O9ljdfbNwypXH3DZbk6YEM0Ix39sL6BY/Et8xOHVYY
         fRqBDp/tQrDa66HS8rXmdfQVGs7OfO6dhWAcM=
X-Received: by 2002:a17:907:9410:b0:c29:41e1:c918 with SMTP id a640c23a62f3a-c2aade3f89amr107993866b.1.1790136871220;
        Tue, 22 Sep 2026 21:14:31 -0700 (PDT)
X-Received: by 2002:a17:907:9410:b0:c29:41e1:c918 with SMTP id
 a640c23a62f3a-c2aade3f89amr107992266b.1.1790136870821; Tue, 22 Sep 2026
 21:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922182405.1290749-1-joe@dama.to> <20260922182405.1290749-3-joe@dama.to>
In-Reply-To: <20260922182405.1290749-3-joe@dama.to>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 22 Sep 2026 21:14:18 -0700
X-Gm-Features: AclHuK_e4Gt7Dv3XPW09iCAf1S03Mu7dXH__bdIt3P0qo_pmNoYoWQWLfzZIffo
Message-ID: <CACKFLimrDMPfWRz9cUadTNDs5X6LYqZS2vJrujmuSb8NQ57yVA@mail.gmail.com>
Subject: Re: [RFC net v2 2/3] bnxt_en: check HWRM response if completion never arrives
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Prashant Sreedharan <prashant@broadcom.com>, horms@kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000052b253065c1eb82e"

--00000000000052b253065c1eb82e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:24=E2=80=AFAM Joe Damato <joe@dama.to> wrote:

> @@ -582,12 +606,39 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt=
_hwrm_ctx *ctx)
>                 }
>
>                 if (READ_ONCE(token->state) !=3D BNXT_HWRM_COMPLETE) {
> -                       hwrm_err(bp, ctx, "Resp cmpl intr err msg: 0x%x\n=
",
> -                                req_type);
> -                       goto exit;
> +                       bool completed =3D false;
> +                       u8 valid_byte =3D 0;
> +
> +                       /* The completion ring entry was not delivered fo=
r
> +                        * some reason. It might be possible that the com=
mand
> +                        * was carried out even without a completion bein=
g
> +                        * posted. Check the response before giving up an=
d log
> +                        * the state.
> +                        */
> +                       len =3D le16_to_cpu(READ_ONCE(ctx->resp->resp_len=
));
> +                       if (len &&
> +                           READ_ONCE(ctx->resp->seq_id) =3D=3D ctx->req-=
>seq_id) {
> +                               valid =3D (u8 *)ctx->resp + len - 1;
> +                               completed =3D hwrm_wait_for_valid(valid) =
<
> +                                           HWRM_VALID_BIT_DELAY_USEC;

I feel that it is not necessary to wait for the valid bit in this
case.  We have already waited several seconds for the interrupt and it
never came.  By now, the whole response should be valid if we got it.

This differs from the polling case below which polls for a non-zero
length.  As soon as we see the length, we need to wait a bit for the
valid bit which is at the end of the message.

> +                               valid_byte =3D *valid;
> +                       }
> +                       if (!completed) {
> +                               hwrm_err(bp, ctx,
> +                                        "Resp cmpl intr err msg: 0x%x le=
n:%d valid:0x%x seq:0x%x/0x%x\n",
> +                                        req_type, len, valid_byte,
> +                                        le16_to_cpu(READ_ONCE(ctx->resp-=
>seq_id)),
> +                                        le16_to_cpu(ctx->req->seq_id));
> +                               goto exit;
> +                       }
> +                       netdev_warn(bp->dev,
> +                                   "Resp cmpl intr not delivered, msg: 0=
x%x completed anyway (len:%d valid:0x%x err:0x%x)\n",
> +                                   req_type, len, valid_byte,
> +                                   le16_to_cpu(ctx->resp->error_code));
> +               } else {
> +                       len =3D le16_to_cpu(READ_ONCE(ctx->resp->resp_len=
));
> +                       valid =3D ((u8 *)ctx->resp) + len - 1;
>                 }
> -               len =3D le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
> -               valid =3D ((u8 *)ctx->resp) + len - 1;
>         } else {
>                 __le16 seen_out_of_seq =3D ctx->req->seq_id; /* will neve=
r see */
>                 int j;

--00000000000052b253065c1eb82e
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCq8q1n
aHifGxFYDvklv6KfT8nKVho0vkUPOz6+VR9ozDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA5MjMwNDE0MzFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAi0fz6Gyif8tZjbaMWMyOc2komut5dniwn8bUwvKTh
MywGxrUgk6Pl8tnl5txembn7HsbYmHa47ddz4ZhmCOWel2lbIyJP/Xyo6JFo7MK/FZejee1guzct
SwJ9TbsvIPOeE2Rcsu+95sptsNXIzMST1LDINk5ssoDgCZgHQMtfcjgBwM9AQFP/P+YWcSogAJhU
8Ey2UMAkIVJ3Rx4bwE4qNWHIc8t5pFmR8U2/D4LLYctwNsvnmWyFkl+VFZJutkPWSF/IWS6q9iLx
/0WV0GlaoerYsqQ/WAJQ/pAjmhTPqgMUNIJuWcNbeYk/0Xa+3Av0nrLQeFFKDS36AHU5f9qi
--00000000000052b253065c1eb82e--
