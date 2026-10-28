Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793169426;
	b=nn05xxu2UheQBmHofUvDO6gNW8ZLwPJ28H08dnTpBrp9Pl4EmLnw/kxtDFjEjVGUYhT1
	 47Q/rHEeE8GijAfObiegC1GQesvCeYCN9NiDjfIkGp0QYT6E0m/afYcx0WvPC3fus7PfC
	 uQHryJD0mzHhyYefsLGa9U8kzD1oG68CIgDMe+acYdW03R0Z8YRPiQPjFmqxhm0IoBDmO
	 KXu7u/DndSVYQARcNExyjCtFdJtP8tcnj1nDcwXjNT8O28v498NmeP8iBsZkVJvyU9DJx
	 ehHaIzO1U1WXIa1BzV5VRFn0LuuzRaSkFyi6daqmndzfEI8CdecZQSUgazGoEBll3Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169426;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=7nRHSiIJG8W7H1PkuWNdoZ7jhsi5b4NR43hlNauRuXg=;
	b=lDcZ+OFyDvS+AtEEpKC36HP20IjSYOJUdkF/IqyKvU91B/mXi52JomB3yl8CeWEfE1Re
	 avTAjLXJX93k5JcWDjmDquXk1LbymazPKSEWnt1qrT/I6/kN9ZxsC96RzUuhDa9UNZ9Q3
	 7FoRL+u/nJrRV/HkrWwtQQfI2k/a8szdkulg3aj51fUvwq1Sl/LehPG1SlcnPpYEQA/TO
	 KqxrqeqR8BSAlDqyjsioYx5vWR+dCJlA/KnYJA6XduRMr691aacofUqrxGei//RF4dvmj
	 Q1ia7VrIJrqNtZ1hmme1Zrtw9u5B6Ck3XUyfEXmtJeaSepG0uwD2Vo7z3kMiPW1fxkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="ZVx0P/ak";
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B3606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 06:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD1B3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZVx0P/ak
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so802473a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793169425; x=1793774225;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7nRHSiIJG8W7H1PkuWNdoZ7jhsi5b4NR43hlNauRuXg=;
        b=Abse7W2L6+FQDcDnbMtePHluEIt2mYhcyIxCEGBxTt8sbtK4qudRb0h/GtSMMvu8Zi
         f20Hc4Fsa2ZLn7/KtSflFDVPOmG5HLrLH+9eUwdpI0+iCTDdfp6YxWv37ZLCkfeUHi6j
         hwBeDJwknq7G+wLEbOgigGsLHc6K6b27MPkiKfemAOuObL8F7n7hbwMTw8dZwBXvIiYW
         5SJYeyg1emiS9cF7NmU3+Yc8OpgUlRyuQGsp3F8kwl+p5ISj0AmF0I2YW6huwKzlaOR/
         Dl6q6qExoysIxEGUz20pBPMFM2b8XMEb2M+cIfLfvoxD7IPhAH+ILVW6eB4rdR/LhEVg
         ETIg==
X-Forwarded-Encrypted: i=1; AKwUvByyowi8qmCwy7lQ8ABrbCSnipqsXZ7tib33mkTl3HHWBD58U+QbcxGPHFvytPCREuiHWWD25hs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNOspRvqMQR/FNdisvlwxjLzHRlT9NYS8UIYFZUQ1OWuVWjZVE
	Ox0ff2+pcH/aczsTWpFw8H07vEJmsyvlHyeUfdgMGea0hveV52QU6RTVDkVc6Zbkc7ZuHTm0lzz
	ZsGOBn4cUSZ8JcfS5mORb7/xtWfHGHnH3aDEVj8neuwRnOCs5Yh4555fLlQVoGveXjcdRhgSAHz
	3eLz1P5QVGOvjFKtJEdpY66L3aRud5oQiPR5ECcl7kMzEOqxJoWOKPL4Fzy5GfNRC3ErgWEpKtn
	DQDHemAiA==
X-Gm-Gg: AYBFou3G9A6tXcYWBZ5nF1dwGFfmDhTA9dIH0cKfSJioapprlbF/xXHzw1zxUr1TKUb
	t2nyE/+eDKOmNEUp7JcO94wdEr/XJWaULteon9tdfvpAHhd8bBRKaeRoX0sgAvNYdtg4d8puOBN
	+zupY0w7EhZBSXezjWTumBTg+AxCRWpC00HLsLkoCzMk1+lFqmPjCg2a0q+npeCe/0XahiU37Tc
	qjOSHu9ThgqaU4bB+8UbcP4m4mnJ5idTkHtFeiJyOIJimOmjKaXGExPoQ4VZyTjD8aubTaL5yLN
	RTdRF23OBNxhnL0PPdo/0oDJMLZ6rz7KEkwVBfIpPR3TmesTxUeEZhkSGrKndkFJlLqWtORe53L
	RDM9gc+LkBE30GWP7WD/btpQWEl7XlqImfdJcKTxbuFnHXxOSS7FNEYfXsTZBi1OGh6MqeUOBh7
	7Al/Bazpixn+gtn1Yscb/7jBp5Yg6ohTUJaQ==
X-Received: by 2002:a17:90b:3806:b0:3ad:413f:5a1c with SMTP id 98e67ed59e1d1-3ae403dd41cmr2871987a91.11.1793169425146;
        Tue, 27 Oct 2026 23:37:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57a0bb3esm484270a91.3.2026.10.27.23.37.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 23:37:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a08903566dso1315643b3a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793169423; x=1793774223; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nRHSiIJG8W7H1PkuWNdoZ7jhsi5b4NR43hlNauRuXg=;
        b=ZVx0P/akWo20xhHZRVFrNJztn5PsQ031aJxGcTyneDMJ9cncb4U41V85TPW9DX7boa
         opZHavAIhaYys/eRj2qAS0wekPmGg0etV9xD1zng84NV07hwi5EiK4N2JKLfeAdX9fhB
         hYJ9xH5f5YUBcLAS4+tdwDF7pe2SNc9eAjWuQ=
X-Forwarded-Encrypted: i=1; AKwUvBxZaTpruARYTtWoCuMIbyJuasAl52oCDnbk74Xxbvg33qdFQmFYw0QA/BihCb09OZsk4/PgCmc=@vger.kernel.org
X-Received: by 2002:a05:6a00:2ea8:b0:8a0:2882:852c with SMTP id d2e1a72fcca58-8a5a61ebd1bmr2630274b3a.51.1793169423231;
        Tue, 27 Oct 2026 23:37:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:2ea8:b0:8a0:2882:852c with SMTP id
 d2e1a72fcca58-8a5a61ebd1bmr2630256b3a.51.1793169422838; Tue, 27 Oct 2026
 23:37:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025040523.678027-1-weiwan@google.com> <20261025040523.678027-2-weiwan@google.com>
In-Reply-To: <20261025040523.678027-2-weiwan@google.com>
From: Kiran Kella <kiran.kella@broadcom.com>
Date: Wed, 28 Oct 2026 12:06:23 +0530
X-Gm-Features: AclHuK-xiaLaTaJffCEzdjnvnAHPfm-GS44uQy8U-8XXD_ERkLiZ6X7YePgcL9w
Message-ID: <CAPHeo3e4aySBroVOr9WeScb=nc_NR8dmjc-mhmCYvVNOqQPV5Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: Make PSP skb extension survive packet scrubbing
To: Wei Wang <weiwan@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000844a31065ee0cab5"

--000000000000844a31065ee0cab5
Content-Type: text/plain; charset="UTF-8"

> +void skb_ext_scrub(struct sk_buff *skb)
> +{
> +       unsigned int id;
> +
> +       if (likely(!skb->active_extensions))
> +               return;
> +
> +       for (id = 0; id < SKB_EXT_NUM; id++) {
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +               if (id == SKB_EXT_PSP)
> +                       continue;
> +#endif
> +               skb_ext_del(skb, id);
> +       }
> +}

Thanks for the fix.
We saw the same issue with skb extension reset when testing with
vxlans associated to a psp device.

> +EXPORT_SYMBOL(skb_ext_scrub);
>  #endif /* CONFIG_SKB_EXTENSIONS */
>
>  static void kfree_skb_napi_cache(struct sk_buff *skb)
> --
> 2.56.0.257.gf7497c7d27-goog
>
>

--000000000000844a31065ee0cab5
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
AgxbhXTUwXZ3dIWSpigwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIA9Oc71jdteu
Q7Ubx187XkZx1ZNJDDpO0N0E6LFZsz7ZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MTAyODA2MzcwM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAMDMtL6KInmrnKkQe7mvzgNdLrVIAEcXL2YSXiMEsXeE720k
pWossB2D7FT4J3bYYsKUKJUMllJP6eL1N8fsdxtuMSNita0TpyEMD0wd108JQiqOjNc5KgXhIkG5
oF55YHw6OtwhYPbcL8RHgTfCUoPkR0KKdUz5MxyzY2Phx6gU4etlfaurCQmXbGBxmJPR8TNvCK8e
LsaEStPyKJPz1cnUW5hNi5ZS0648RiZU70o0HzTU4m1PHa5qi+2mdga5f0NMH6d71/P0bwt91c/J
on8GtbKo/IpLomU3lcEHdN0CxmpHA3t1/oJ7QVB/GEVt/ymHXtf060/grL9Tveua01E=
--000000000000844a31065ee0cab5--
