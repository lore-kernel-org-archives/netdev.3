Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794453857;
	b=hzS0ZL3pxOPyKRmMzbtR1+DPLf6bnzTHHZAew4d0zXeByl+VqcEa2OYnZdFlJK05C1FZ
	 M2au4HqTKODzoxO+2Db/UlsTT+lLI56An3MHZwRZn1/zZC5QqXGvdquFWFJLynmW14Aht
	 ey4vI3T9ADUmOv16bc1ZK0f3oBlnNhTT773E/EieVXfo7t6JFzA5GLe07IR9L1HW1L84h
	 +aGbe4nXQ10ctzFTFLFzQjLtgpOoIsgPP7pLGvqyXwCSSIpFw6/3OW3VNjUpQv4l1fuaD
	 pSdeLNpo+OqhWJ6uxbQAKD2ZP4cejqx8mxJ9BvxFGOV0RUg3vJbOIQ0+EalMWPDiKVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q4vGBoYjXFEqsa4lUNP8BKLQi2KAQQHSCj0yiO/z3RQ=;
	b=NkdOfJYthKB7ubwUCJl5JbvTaFxoTNM5fEh0lhCEeHlzzjcLPU78tiR9Tc/PA0J+eWTT
	 /sx5O+5kTke9YQGHm5LKROURW65O3eC711YdjUdnSZJn1poK3DU7RzdssVuOtOzeT8SgL
	 CNY7xr0z0NkQ4JcOnaxw38jyKfFs/wF09VLuq2MUhDb2//HLKxPIBXdt5lxvIfQSBdVBm
	 i6YwVZYaHEIYTVsqHP+ypg9RKPCHg9/m/DEDBd8Amx83WtAx556yq1B8UPoVOnr5eMSk3
	 09DhtL//yBZu+bTzEkIurYj7/xpu5e2PctgiVPhDUyEKSdLbpTZw5ZhO6YO77KJHIEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oHmtI1ml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9C606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BD9C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oHmtI1ml
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33fb4680717so4537054eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794453857; cv=none;
        d=google.com; s=arc-20260327;
        b=VgDnHSG/Bi9zQhcfYH6obfPZpSCt2pmIZMzWMcYN4GfXgjczpL1pQGBqNjpkghSQq8
         HIOhH5SViiZl+QFLdMaMSIpFqnx/QprV+pTo5Ri5CfyfftyTR4Wty9b5DEUJNrbygklK
         A0DWT7lsrl0RXS7VFuZ2INu/haaog775oPIQ+uKnNXck+ujRJO7cg+lJon9Fk1VFzApk
         JmXfCPLOR+lp0N2IaYNsn46FEIyKN0iV+TsHum9HIXE9LQx2DNGse4NO1gNvd+NEAAfh
         Vq1q7/4Z1HCO+KH079/Yo3sfMPRMjlkHteDi3QskYQU+wKNhiLcmDbpCO6F/aBa6B3oF
         VU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q4vGBoYjXFEqsa4lUNP8BKLQi2KAQQHSCj0yiO/z3RQ=;
        fh=WOEryvjXJ6AtqGSwSdq3DyWjlHbgaLHXznXJAwQy4XA=;
        b=YdYnJGPVMDByO/iqKKfgDOddqY2VYugaW9S9Tr9xrNKtu3mI4t1BGV16FKrxECwAHd
         u1KXPGX2u8J3ULfiZWANFSObPmOLKME5d7fVU0tMAG7KlicEwnUqGrcylnL7biqC+Igu
         JL6X1mG3xyP7tIk3dDJPuTfDiq/MHxkTHffS1dBsKl7iQ1vXlChOkBOTxum6lNdveSch
         ZmS6DZ4TOb1WW+/Dx1qJbLMHi2WQ0km5WtEfzuyJQtHVPmiUA+tanboAngGCdgqX7Uut
         5vqnYYfYn1/6wHEOQwA/ynYhn6gkHXqn0IeBe39i65TF8RK8b/bfhVXCq0O6tvRoazkN
         DHeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794453857; x=1795058657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q4vGBoYjXFEqsa4lUNP8BKLQi2KAQQHSCj0yiO/z3RQ=;
        b=oHmtI1mlCv4ejGkzncxu4FeiQZGkBkIG+Uipng9xKmEURLEeUg+XV/wMMGwyP4iUqy
         1ItFv9ibWqS7p/99s3Qm42lMFDBe/pmPegJQgBorqDceE0nhC8TQqWuynEn3UyxGVZDO
         euLuq7aziNRtCdc98K61q15gOB5u60w3kmItbRWwQdMYRxj3UIrTd24e+Re2GfxcxZ1Z
         HB9ReMrvDB0CAhX0T/iNV72w3DAFm12h1aEv5otcOb2DJw3PkYlMuobGefAmy0DRM4YU
         c/ihWqKX1tvaOizP2nIpgaEm16Hu6PVJPZminkArvqGxS+0dC0nrZ3boINckuDZXOy4/
         mwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453857; x=1795058657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q4vGBoYjXFEqsa4lUNP8BKLQi2KAQQHSCj0yiO/z3RQ=;
        b=dj/9p925K3/f1GntaO0edb9rkYibKTpj4fhJd8H31HY3KsE4xis4woM5U8SMM4ia2i
         vw+P8wlp8nBdW7KCUmW6sM6lDTosjF8ETuHPao+1axFHrzQA0zJjX+61ETZAxJtgqZWh
         nft2uXTl5FM0FmVWVABxzFk1Bu0ap039MoV84JZ6LdtnJ79F85TBe6Wncc+LHTb0TWS0
         mZWs+oyi2rBm0A9h46ZhmMwsDKIlQ1EE7lLMGPE6TQtToYXYf75cEvAg3bErSwPY5GzE
         SClzlJ1YA41Tf0p3q5D0oGaz12xt/YnqTzsQQ3g9USv77dB71RUPxu+0b5TdmbIqxRS1
         IQ7A==
X-Forwarded-Encrypted: i=1; AL+hErEumGYhYEzRrmzFpusl9llEUUXkgh2t4wsy67mM7I1IO4CmQJiAnfBN2a+FUHgxVfB0tGZoFsg=@vger.kernel.org
X-Gm-Message-State: APuU4Z83yewxLlr25bN6l0Oml8DUv0u1heP7C42uMLSm5jFdbauM85JF
	i8Cosl1OM3Hx2OOrsVKRKKNTKQprZlP1XdY65tMuMNedCholfur05/rcHDs95HZoRZFMjtMJgNY
	7aGZwwXLxpAT8BnJPVfnQL1g+C5pxaT8=
X-Gm-Gg: AYBFou1m9eI/rJ+fqGbvoNz+1MPMMxsMLJGHOHoClaUK52kqHlfTwqApQFBYkH37qQo
	OiUjAZQWFuVQSF7TbNf7zVS/4aBpdvPlj0Jmv2LZ4wNKdUA3PyAJADWUyY8pF31tRYrWHcLQmak
	7W43GsvGTDKJSsE0UquUWrCV/k16tt66HobgrXC/tQoxztY2VYAhIBpjiXJqOkdMU5SKZDlIrVp
	EHpYOwbYdEdPLBU6wGHtPU+O1Uo0L3vWipZy8wxHmmGKqdbHwzeWn0mI7c0jx9K66K06d/cJPX4
	kbH49nMex2q/d4V91HeUNANJFIMdaBAUAem3eWQEHkjY6IvgT4ONU1oq1QiUNaGN1eMs3UdhAhC
	nYlinC0xJI2AwAd254FCg94F0T9Er6bIv7WrCrI0VGlzQe0lhtuhwj27ykrW3bBCFwwlM
X-Received: by 2002:a05:7300:2324:b0:369:4c3f:8a5 with SMTP id
 5a478bee46e88-376858967b7mr6629283eec.14.1794453856441; Wed, 11 Nov 2026
 19:24:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109124933.1603575-1-hj351016@gmail.com> <20261111172718.1e41f48b@kernel.org>
In-Reply-To: <20261111172718.1e41f48b@kernel.org>
From: khj <hj351016@gmail.com>
Date: Thu, 12 Nov 2026 12:24:04 +0900
X-Gm-Features: AclHuK8dZXGZrK50IL11IFqhm4T154m_E5AYrfNaDTyQqii--eKK6YwdxrFnb7g
Message-ID: <CAGr5VtMkhKim-qOuHBOo-6S+o3uf3J9mcKF1MRKGFZ0_XZraQQ@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: iosm: cancel adb_timer on cleanup to avoid use-after-free
To: Jakub Kicinski <kuba@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood, I'll drop this one. Sorry for the noise -- I won't send
untested driver fixes to netdev.

2026=EB=85=84 11=EC=9B=94 12=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:27,=
 Jakub Kicinski <kuba@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon,  9 Nov 2026 21:49:33 +0900 hyunjungg wrote:
> > Found by static analysis; not tested on real hardware (needs an Intel
> > M.2 7360 WWAN modem).
>
> Please don't send these low effort untested driver fixes for networking.
