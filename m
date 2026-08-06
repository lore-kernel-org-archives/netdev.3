Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE93F482E
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007312; cv=pass; b=pgIZpx3SVnWz6N8J0nCGIJIdosRJdaU1GvZvlzinj4mVc4f5byfJNWthWOs31vDZuGjHyG/RJJ/eKmZTarp1EfUNcsASvxiWg1kUiRkZxdbMNmQYnmqKEiMaX2nFOR/kqgVCQt7RTqB5vO849DrHlnbppO+7SD4enEEFEK0aBDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007312; c=relaxed/simple;
	bh=89OMrT3Z6DddhWogs306TDGgtKr4lphAjTbSwQXv5cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tz1PVmrgB5jNsadR3hxwzQA1ye/7QsmfTOjlC2GWSRbK3cv+b5P2dzbm8X0SRQdd+hXxr+Tgt47hMqDrKHGHScLHe/Jwtwf+WgQbHWWyJtJdNA7Scc3+r9ftokOIdzMwZ4IgSp8c9clhUr1tUAg8DxY0dGBf/vT5HPgY16ne8+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+uhSyjK; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+uhSyjK"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a17f91so3006622a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 02:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786007309; cv=none;
        d=google.com; s=arc-20260327;
        b=i9Ucvd5mgLhCrBeuBlpRPlr9i/diVbJgqLzWOGpsx1i9YxxsTCUxoX3FuMCWHJIFai
         Sqep6Kaw3kqZrd0rZOZ1CVwujEKIiTBsq20yO8JLAQLfxzWZK+tMSWDoD2n8+H1jdHsk
         HPZZ9XKT6uy1SLc72M8NfgpNCbvV6/aUbTP/Nh4JhFbeVU9NhaZCNJ/HsmLDwZaHkpMq
         8Lhg2LOzW6DM1UBPq8QG0kxZ0Sucdy6brGl5F4q7Vd3Zx1uxp2033puk4YtVeDL5uQL8
         SqvuPB3RvMwMBZUqt+xpdzHtSr27pjPFgwredICJMDp71RVZHXWatyKneDI9RcN0CVaq
         naYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=89OMrT3Z6DddhWogs306TDGgtKr4lphAjTbSwQXv5cQ=;
        fh=QPOUND/uVXplYCsrGmL2GNW815I5zpWOlcfrdt7yIfM=;
        b=cAigfRqjbHWfMXsrRLGnLg1VujjkIvHSQRmEJykKSfMZjssT3c0hZj8r/JAbdQMZkg
         2G0fInrWiG2WONEBcbEWkQAIKEHUDX6t0eyFzgp0dkriSWPZiOhB5yRvgcBraOayBC15
         9fSPgYLcStMpBB3Be62K89freuIIL5BA/tTTjdsypR/Rd6tT5/cn3PXtNGQRlSQHsTI9
         mEI1LTjVkpQ6yMjF+McuOP+1viH2Dgo1T2hETQhUz4dPdRWfeboEFKuivFaI0A8Kf34u
         ujANxsO4uItTX8S8zKTQMeJp63tJ7CvRAiKx3F9PdDik86OZ1MAwNmXOlZGNTc87grZN
         S+/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786007309; x=1786612109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=89OMrT3Z6DddhWogs306TDGgtKr4lphAjTbSwQXv5cQ=;
        b=B+uhSyjKasC25QUPcqOmRw45XKRxiZYH9hDgQi+4+yYDCwQz42avIKHYWZQBuu8DwH
         Chu1bOmNmy2vqxZs3lmPKA/nE1PFHBDSw24MZsheONSas5ALcX47R2GR/voOpMOHrWSO
         cWvNB3ImVQFoysA3A/6dl49IPx35wnA4vDrY7ER+p2gAVZPKnE6BetFq6jVBkmEYK/If
         4d5Om5Kholcp/rrnX5+GxXntdlIYtR9rlFNrMRZDmRs2ID9Gd2dV/R6sIOjB374k+ePf
         WOmPCrM6n8+zrREO4z5PeW18N3IXThLCcG8Yhas/LGCxlY8KVDDk1amqK9iyikUF4jz/
         BDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007309; x=1786612109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89OMrT3Z6DddhWogs306TDGgtKr4lphAjTbSwQXv5cQ=;
        b=rpoXljQpDXtBlB3XLidJA6DPwBerK8xwR0lrl1xzLCzVsrv0KIEoP3nSUeqYSRWPS4
         hhAG8hqm+d2IKqDh8skIh+LRvS8RTguBVgmFz3l619U/F1fi6c3Yg1qgQtf6wiA+vHT9
         H0i5NJI6WzYJyje8xHj3G1DJ6LZ7W3UrGAK/g65lHURTUlMoyvU8ARHax3PVGBVD6SSR
         bw2ULRfMZGZSN/Cdxs3sHOWr6DPRfXkyZSUfyaovl+zyH9HV11kLVUF7nE0bnxqupqkE
         ySzuSm8jximxdO6gZLOLNDu+1CDizbheWi1dQbPObuC/9aNTGdVWXrhE3jb3MDLlrwcq
         fHCQ==
X-Gm-Message-State: AOJu0YwskXghwe7vaFSHs2+rBqs2cP72eSXqf0h+ddkSXksB5lqU0l8q
	hKwQIy8ZrUpnSYCsDplNTa9DF3ts9CT7Q8oSeIKfGhD26rwqcxPIuNJ3TJFe8SURXsyJAwwtlDp
	LZeXhZyjQlaNCYJxZUIzX0zREYjfegBM=
X-Gm-Gg: AR+sD12z9j3FEgp7V+Nmd5HMfqvRZKFmoBGGDGBbvV70jCZlZF5z+skoQnu5A6Jn7hZ
	OezujVqYL2pNOGB/FOSygOLjE+qGMhtXZ68Z85A2T1mbXXazyO/34HhNl+GHbmRKrJRfb/hGEmB
	6+UfQTk+mdKkq7ZbILKEtIdBwCFwlx9SGaiK7ryjq2ZLSJZMcRMRNWKpG/hEURYCLzQll4Xcdz8
	PpGFONgxPxgPo+ZSIziWlpWrmcTMQ2ecZKBDJerNXn9Z2JDdfrBtPDkSktbbhVGEXtRXhIuvZEs
	nbZ4PeKC+tcdMfsNoGgP7xL82Nh0qdTk8m+mcb37VhqM9w==
X-Received: by 2002:a17:907:d20:b0:c1c:257e:4888 with SMTP id
 a640c23a62f3a-c2039cc4dc5mr697561666b.27.1786007308631; Thu, 06 Aug 2026
 02:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
 <20260805085540.452260-2-a.shimko.dev@gmail.com> <20260806-classy-cuddly-limpet-9e6d8a@quoll>
In-Reply-To: <20260806-classy-cuddly-limpet-9e6d8a@quoll>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 6 Aug 2026 12:08:17 +0300
X-Gm-Features: AUfX_mwwygKwfn76cx2uol6W1X4L3NrQoylixOyCec7ouNwhftzJtJH1SwjbW6s
Message-ID: <CAOPX745Y_bq3b7hd0HUgF3VS74GBWKizgtxZn=65wMB2RCeicA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] dt-bindings: vendor-prefixes: add
 Guangdong Dapu Telecom Co., Ltd.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, Aug 6, 2026 at 10:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Thank you for the review.

--
Best regards,
Artem
