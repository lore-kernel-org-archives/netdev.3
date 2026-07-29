Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7547437465
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314381; cv=pass; b=Rx4vrTXp5ZHzaYPLXrqvlrofej2K9rz33ufLOKCqZj+0W+qzG8yaenMOz+4jhyNO8NsE0wzFiywsvYSSO13Tz5hbE1OsY9rKf65Et1tyGOBGXqwfm08WpKllIChWbWC/HlbQTHFTiFRuKnzXe79SwSHUI6iYciXz+cdPtQeCe5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314381; c=relaxed/simple;
	bh=CQXX4ctSvXrji6QEdG5MGhj7dPGXqSfCzroNk5lQS+0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j4jAh6ZIzjpqkkNgAqaZBqMMbjhCYDA3LVUV9czlNsQXHFU210Pg+2QOfpXrf6cfB9DHRxFYQuaBEVO6hTE7mcsi78VJ3/cWPzCGuKeHPnCqBfUhXYRNYwmHikrfaDAAD9hol252Co1uH2vpdtCU5dGI60L/FpOfsp5gR/bJKP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=H2ZiknJR; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="H2ZiknJR"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-495b98b4f6aso262791b6e.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 01:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785314376; cv=none;
        d=google.com; s=arc-20260327;
        b=RXFxxCzHkMH/YY2fH3JfsWmGCvFBwRMdmMRDTk4iR8vV5vhCIwFF5YFLP5mzs7MJ/6
         bSNmD1UvvmC1u5EVN3oDhVc9Abn5ifya6wxigrZWonOh21wJ4+/WjeuGeeuTt45aBEG2
         4hlp5xrKpm+k/90n8Z4EopgZ7hsYPxhAPZXBYs8JVQ5aeGZeMbwMJJWMB8sJhaFlkYS5
         vUq+UIaYsTOWP4wiwf/r+1EpNuWe8p/8KQf4z/OSgD7IvTRBb5QcEtezlfssigaPG9XY
         DWxrwGT+r32/it/xO8oZ9LFlyJ3w5xLMHBN/XflRDS5yETH+5FZkRFaLvPU+edkwTE8i
         wmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IRxmbjSsoN1Ypj+ARH3lkQXOGvAlo09s4aFGYYGpRVE=;
        fh=QlJ4ey5QodG7liC6XG8G01wE9e7Or/56bJzobnTT5ug=;
        b=cAH6MqVwW/79crKtH0XxjWSHh/8PMRPnKBNRKa3R+HwUZhn97n8gaGj4B+zDKVtPww
         PLCN1hmHL1WzJGMUS7uZeEAtE3gCRnyDzW8/i3Pni3zGx8fA0TAbIQOdO/m4sdmfvJJT
         sg0iFoplxYsnj+U+H+mQzh3x3WSvGuuWwauM8bEgy5kT6Q0vlF+ssYBv3gdpy0QP2s02
         lcTCuPxVyecwh48lcS94h8bRxkMvMqxlo+Hmyr8M4WRA+zOSsBzKXluodq+5ZKWe6550
         TJVt/5FMnIcXcMxijTBqGiUEhmC4beIRjORaSgaF7BCWhpfEu4El6TmdnmEaEa6dYuWa
         jozg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785314376; x=1785919176; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IRxmbjSsoN1Ypj+ARH3lkQXOGvAlo09s4aFGYYGpRVE=;
        b=H2ZiknJRxKkGAxIpmoo1hoQa0s2IJx/GedqGMn7B/zKDX4ywxyy+EwNmSYsqqxObQC
         3OK0omHf9xFHgA5xRv1vozkuZr+Sd6bPiKOSW3As7VfrQsXbcjUi9YRnprklIuvPpBHw
         /b3GWa5CQR79qQAgNxcFFxhEfhUZ5IFSNaWpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785314376; x=1785919176;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IRxmbjSsoN1Ypj+ARH3lkQXOGvAlo09s4aFGYYGpRVE=;
        b=lBh5gdFoqKaV8FKmw0GWH8boJJ9g/LmmTmoEyma3tJ5SMqGvqzxCvk1Vdtl+yFbOky
         5VjvdoFguYAuSH1rP4b7gbWRbk7eWcaRLUCEsyLP+wGk0JsTo7kJy6xDxiMlW5Jq2Uie
         cBbR3ulscWk3dv1+nyu1Cr6R2CEJcRaigF/VTaODMIMDz26zmuWVNaKuKRxdCVPJkrCT
         5k1lOpKBnXIOzOmB3HoTaFvwJGPsduaIGYCcCBVLtKr3GPonQ+O9PS9FUrLIPEeMUh9/
         GmuJIn70VrsMnnwCNYiAPNESvO2NaI7wlcqqbAfTmiFU2zax0UHqm8X8G+ZDkUe8oaiN
         bMXg==
X-Gm-Message-State: AOJu0YyAFHMKhVxtvSyLdx/vTVqjdt+4biPmovikEGX+k8OU+77Ya8wB
	4mA18tf7JimM+Ka16LJQt/NwXgvNnMxXP1SXcZ6MMweOkdVRgQytORD1b9jSwQAtRpoO4e2BFV9
	D6DiSBzwWNf/a4xXDoEcHMhUsfNgeu5r2zvyzN5Yj1VaYyDK+57a95O7C7lKO
X-Gm-Gg: AR+sD11JjFzExO1DAVDhO3xSS7Tzr3b8dBrHgJ5weL2U8c1go8SsSDsvLT87+dkPr2Z
	a+BinF5noYcMYRjFemBmGj4Tl/PDlpSFqHB9g3MqfagFp1skNP8FYXtxS55whhWaeY/yCUY3KaV
	Z1LgW+vxGt0cNaT8n3rSJxi8ycNhWpp5l/UaeQ274fVP9E4yUe+biaXENUzI3WWuFabq/qo3/3O
	mA/dnv7bYoUuTr85lzVAogiKg5rKfVXfcs/A5v+qdKPfK0KGAn9OTKwLkvoT87wtvVOy4LTnpL1
	wkKzHov/sW46tKmJkjOXUYlmL2uXBWXWfBE0PxqhKkbNZ5n/2O0RQf+Q
X-Received: by 2002:a05:6808:221d:b0:4a4:2724:fd81 with SMTP id
 5614622812f47-4ad5b9c192fmr4026145b6e.23.1785314375770; Wed, 29 Jul 2026
 01:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7J2067OR7Jqx?= <kennethbwlee@snu.ac.kr>
Date: Wed, 29 Jul 2026 17:39:22 +0900
X-Gm-Features: AUfX_mz-LYraq1mxCclPsf9J5Nk24EKrP-DcZgo_vtFr3GApp9M1Q6bbvUvUtoY
Message-ID: <CANJoUNwAU9r4DTL8mM7uSJA0aCAE_YbjrqAXAzETnbv2KpY7Ow@mail.gmail.com>
Subject: [PATCH net v1] net: ip_gre: use checksum-aware trim for ERSPAN
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, "idosch@nvidia.com" <idosch@nvidia.com>, davem@davemloft.net, 
	"edumazet@google.com" <edumazet@google.com>, kuba@kernel.org, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"rhkrqnwk98@gmail.com" <rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset="UTF-8"

ERSPAN currently uses pskb_trim() when truncating packets to the device
MTU.  For a CHECKSUM_PARTIAL skb, that helper can leave csum_start and
csum_offset pointing at a checksum field outside the new packet length.
The skb can then reach skb_checksum_help() during transmit validation,
which warns when the checksum offset is beyond skb_headlen().

Use pskb_trim_rcsum() in both ERSPAN transmit paths.  It rejects a
CHECKSUM_PARTIAL skb whose checksum field is no longer in the trimmed
linear data and returns -EINVAL.  The existing error paths then free the
skb instead of transmitting inconsistent checksum metadata.

This issue was found using a customized syzkaller-based fuzzer.

Tested on Linux v7.1-rc6 (e43ffb69e043), x86_64, with a diagnostic C
reproducer derived from the syzkaller reproducer and resolving erspan0
at runtime. The unpatched kernel reported
offset (4516) >= skb_headlen() (3730) and panicked with panic_on_warn.
The patched kernel ran the same program without the warning or panic.

Fixes: f192970de860 ("ip_gre: check packet length and mtu correctly in
erspan tx")

Found-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Kenneth Lee <kennethbwlee@snu.ac.kr>
---
 net/ipv4/ip_gre.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 169e2921a851..16f80620f6d1 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -576,7 +576,7 @@ static void erspan_fb_xmit(struct sk_buff *skb,
struct net_device *dev)
         goto err_free_skb;

     if (skb->len > dev->mtu + dev->hard_header_len) {
-        if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+        if (pskb_trim_rcsum(skb, dev->mtu + dev->hard_header_len))
             goto err_free_skb;
         truncate = true;
     }
@@ -723,7 +723,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
         goto free_skb;

     if (skb->len > dev->mtu + dev->hard_header_len) {
-        if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+        if (pskb_trim_rcsum(skb, dev->mtu + dev->hard_header_len))
             goto free_skb;
         truncate = true;
     }
-- 
2.53.0
