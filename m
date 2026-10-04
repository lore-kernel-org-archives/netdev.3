Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E640BCDB
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152980; cv=none; b=DYMyESONBgy3xDk9htK9pk1N+aY0RK1Qn9taj6V3b6N/W4ct6fs72m0WaapW1GhceJSPNxYbM5dRWQHy679R0AqZdgLkvzlp5Lh1fkFwK0FQR7Ukbxn+929G8rRd+v8AfQy8fkGkyE/wLUEEnGSLuYtipyR7zP0Mw6WcCmsbec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152980; c=relaxed/simple;
	bh=pjYHqVrJakpYslNDESZXBadEITXEdrG8xMuEDAI0MPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueeT2KKt3he39hFLxf0NgXlSQiS073RsheukNS+RyohH+GjJJjLrfrSFLQMkzJJvu4RKoZ9qZmEsjHYHxzWA98J448B4ArBKBcT8QVkh31MJ1wCrr9uF6nWKff71Uktbl8qbKHd0fsX1xyE8yFrg58VS6Qs2cLIZ/6RejS5o/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WVO3ZbPX; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WVO3ZbPX"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so1244335ad.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 15:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791152978; x=1791757778;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jD3uwkrpZjCv0Wlbr6Ru4u6L1FeTZJeGltyW7pRFIjw=;
        b=LHWidKOI0oXXyPwy6hjfCYpL57pqUqNznUI5KNl1VZSHADiwIKd1n7Rhl6p7Nly9zL
         fz+mhYSm7QI3q3xOFmDbZ/23GYqy4EJBZ7wiiKjoqQhCxfQl1aZGbduA5V3dAr3/C8eC
         4wAlbbI/KsZpo+p/xZA3uqWb42b8BQo+U0U0jGD69ONsWCsvsnFboVEaJi+kO3ZVrseC
         tYThXHE6LIFdCEJfv/BU8AwkSZtZlCsJLTwKj6IB58rN25gyFSshji6LvJyWqxdtoznN
         uaV0wZGhJtkeI5PxH5R2pjE2bXzTWuMaUBfqgfHRTf3jZUqukcckEMuftzxzn641JD36
         M51g==
X-Forwarded-Encrypted: i=1; AKwUvByJIvYGjYzy1/jzwXsseOcl8SZbvh5eupJGC4IQfFC/ykMtPanqJxrO/D+Vv89wmjh8xcXE8Vc=@vger.kernel.org
X-Gm-Message-State: AFuF++nldT4UaNsUDsdVCYKI5vuYr6L84o+72Rh16+2HOqnnvb1mncG1
	oerthoAj5vmWX2AW7mSwINHq/1HwQ9bU0hw3b383jRKmbme7aA25D391nc+89wzGzx3KwzAPD6d
	jStWsDyRiQzTXTIkAfgNgGwNVGJljezZugdHNktMwGT/ESTBGRuuOCjcTvCkQSJ1CWd3M8wIKGI
	UfrcHIDSoW5Ngns6O25nuO5qT+qgWLjwq5DyEpRgrLWnos3GRbn7trabKXy7/m3hkBAXaSvyDmo
	5pKNuoEPQ0=
X-Gm-Gg: AYBFou2ikuJ652lbcW02elrYT5hchNdXNDBvo8owIEOSzer5o2MsNSBtdJjDCi9YwTC
	gbFbZ6W2aW/F03rucyKKkEXUe0QRJOXHRhtvR20B+NdEwAaxmiDRku/j5bTTz33Exk8pUhcruBe
	ebwRikQXwKvRcERaHkdrlDgle3mp68P4QUwNdMHbWj1KR1N/EcA/CXmcb2mUNxTkYkDpbguT7u0
	7WSg10BNRPnw1JTY57E+6FM2gAc5X/QjkzWuD980Dy8WgGgNtXPyKWbSrrzfg/m0YSTTbKl8RGe
	x2rxFTPcdU6itV/EQJKPpJSGpleSeTKBo0av35zqUDLkf0X+H5hm9e6dKN+TVeQQQi6JHd/iHuq
	NlSLAP+ywBzi3bUFV1vNb6Pwi8paT/HQsmbaTe9RjHw4QDG+pwpPeIRYENdA7MiH6sfo5gX9wGx
	p3r9kD6GrHbLaByHDMghl9ZEz0sFAOfn5lZSI=
X-Received: by 2002:a05:6a20:e188:b0:3dd:a006:ed96 with SMTP id adf61e73a8af0-3e0bd15082fmr9236753637.44.1791152977919;
        Sun, 04 Oct 2026 15:29:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-ccb71bbc585sm1286663a12.1.2026.10.04.15.29.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2026 15:29:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c25edb54d22so133738466b.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791152975; x=1791757775; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jD3uwkrpZjCv0Wlbr6Ru4u6L1FeTZJeGltyW7pRFIjw=;
        b=WVO3ZbPX6V+PjBf7hbbgQHo2JRE9dkPcTHm3TDaYy0qe7UB0ZMyVKBZuK8Uh4P9Y2p
         efhg/pDbTWn7DvUIp9/16pttZEPFNAnqwnfs59JdSEb8WfzZkcAMrBcpoykJlL5kkyg3
         Y77L+Su8KfBti77w3MP+z0nqZLW8l52EHJaNY=
X-Forwarded-Encrypted: i=1; AKwUvByv3Xtf17K8m40bwHd7mP4ZtUs1+MMOcbAxd+D9aQgFiUUGp2ssJ+/uf13DmFpdBNSrBhsm1YI=@vger.kernel.org
X-Received: by 2002:a17:907:94cd:b0:c29:f5d8:9c7c with SMTP id a640c23a62f3a-c2e4af89b5cmr815107366b.43.1791152975259;
        Sun, 04 Oct 2026 15:29:35 -0700 (PDT)
X-Received: by 2002:a17:907:94cd:b0:c29:f5d8:9c7c with SMTP id
 a640c23a62f3a-c2e4af89b5cmr815107166b.43.1791152974854; Sun, 04 Oct 2026
 15:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004122616.56714cbd@nargothrond> <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
 <20261004163532.3134dd41@nargothrond> <20261004192902.3ab3b7f3@nargothrond>
 <919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org> <854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
In-Reply-To: <854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 4 Oct 2026 15:29:22 -0700
X-Gm-Features: AclHuK82XpdJ6aUV-AeOoMZWPm7tuCGvPjyZuGpcDrm46DyjpESoCgDjVC3qc4A
Message-ID: <CACKFLine2gKepH57mg5j2YYWsX-qU8-EfJfnqWiYUEhpXL1F9Q@mail.gmail.com>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Eric Dumazet <edumazet@kernel.org>
Cc: Stefan Fleischmann <sfle@kth.se>, netdev@vger.kernel.org, stable@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev, 
	Joe Damato <joe@dama.to>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d86e81065d0b4c4c"

--000000000000d86e81065d0b4c4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 2:11=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:

> A more polished patch would be this one.
>
> bnxt_start_xmit() needs an audit I think :/
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index
> d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..48e544544754b04cff891bda5bc86cc=
370e0aa0b
> 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -486,7 +486,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>          struct netdev_queue *txq;
>          int i;
>          dma_addr_t mapping;
> -       unsigned int length, pad =3D 0;
> +       unsigned int length;
>          u32 len, free_size, vlan_tag_flags, cfa_action, flags;
>          struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
>          struct pci_dev *pdev =3D bp->pdev;
> @@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>          }
>
>   normal_tx:
> -       if (length < BNXT_MIN_PKT_SIZE) {
> -               pad =3D BNXT_MIN_PKT_SIZE - length;
> -               if (skb_pad(skb, pad))
> -                       /* SKB already freed. */
> -                       goto tx_kick_pending;
> -               length =3D BNXT_MIN_PKT_SIZE;
> +       if (skb_padto(skb, BNXT_MIN_PKT_SIZE)) {
> +               /* SKB already freed. */
> +               goto tx_kick_pending;
>          }
> -
> +       length =3D skb->len;

I think skb->len is not updated with the padded length here.  So the
HW will drop the packet seeing that the length is too short.  There is
another skb_put_padto() that might work better?

> +       len =3D skb_headlen(skb);
>          mapping =3D dma_map_single(&pdev->dev, skb->data, len,
> DMA_TO_DEVICE);
>
>          if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
> @@ -759,10 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>                  txbd->tx_bd_len_flags_type =3D cpu_to_le32(flags);
>          }
>
> -       flags &=3D ~TX_BD_LEN;
> -       txbd->tx_bd_len_flags_type =3D
> -               cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
> -                           TX_BD_FLAGS_PACKET_END);
> +       txbd->tx_bd_len_flags_type |=3D cpu_to_le32(TX_BD_FLAGS_PACKET_EN=
D);
>
>          netdev_tx_sent_queue(txq, skb->len);

--000000000000d86e81065d0b4c4c
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCDXkdH
Hy8zu49O2ZTsoVpmTJuRCtItEFFFYNCY1Q/SBTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjEwMDQyMjI5MzVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCTumSds/WCZo3BFh7TU0Usi6d9wpGTraDaQwgWBKke
LdRq66YUklKwcTapkTRnq3wQeFcm0mNLHGkKuHT2RPY7KBKSY3sZuWa0W2zkOM5rpFbjttaKK0HK
+T3FaeCz+4aHi/4yd2MEfe+MStRSxNC28p04kV/o81oqTonR4dW1Zo59zaSSAiipK5dan/26M5X3
gLPS9KAeut2bhkb+DveyMGbQHD/2qhyJVnYMZ+3mmvWvyS2dkfJPJV/awz6LrZxN4GNbV5Yb/+nb
oaz15cjmfZLV42KiAisI7GXRIftC1auHncHqtRZfl0vXHfE/Mc017Ci5tHGl7/NkJ7UHKe0M
--000000000000d86e81065d0b4c4c--
