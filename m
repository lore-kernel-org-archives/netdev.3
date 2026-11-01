Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793566655;
	b=46Fmv7VMHwXv/DfBYFprjk7gLreFg+seSt5B1vIofEvzL91LtaNGTVkEo9QHirK7CSbC
	 AMfDj9q1hWir/kNlP62v7HQOuB7JkKPm2zK/7rSl3LO5Mg/5dxFtljuFx3A6m4YZ8qjqy
	 W84iXwc1I6HeqKAb7HHFFrVz3wfBFfidjZVhCtRD+xl8C8ifqnuGLe3AubRBHtDR0mA47
	 lmiU4GWb4Kb8bYM8o/1cUoy43muo/vRygdwrUOLc1l4rXPRPQeHWXHRFeaDYqOVGPXYli
	 MXUwCKnGPnYYMb+Q3Iy53weuWi0eqMpgnrhevCicPzf5eAZdPuDENK8xX/l06xPS/Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QPohgoPuf5d963Y2G/ZdUa/zMplXrQUxWQ1kLVkoHy8=;
	b=cOPDyON1SRiJHKjaHTdC94aMYkaUBLPtcuIsx2AIoSgWG1Dsl8+bO0aGG6LSahHypHcO
	 buYYEvCH0L6Z28ZGa/9ePQ5T+SNYTpvsg1l8MIAsPqhayN4+VWCoIbBhIe4v6NVBxbUGu
	 vRX86DtUtRWOiVao3cNK13479Z44SwLW6W/fqHLTuu7cJUL0nO5kRRaEekXJYGaAKosjQ
	 SnUCoQ4uuEweHf5kcTecs35ZmCkhZxNMyovYGOwFKf1ZATFplZEPHkqx1z7UWjUXrmr6O
	 4mOBOf8IFoFmFMb31kiGD2LEuOS5rvIpKYeRBgmnSnYXpF6JMxTJ54tNRHNlWOH7g+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sartura.hr;
	spf=pass smtp.mailfrom=sartura.hr;
	dkim=pass header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=PfdrVEH9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62690606A326
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 20:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62690606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=PfdrVEH9
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1061731a91.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 12:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793566654; cv=none;
        d=google.com; s=arc-20260327;
        b=hyighwHlI5YwZ/5s4Zy5mzemX4PSM9lhABlAtlQLKeuk3l2dsgAYhPKYiNg5l+FKpI
         nG8Ryihxu3RHJuqw8TUyFKvBQ1TE6kdW4/jo6WJIqWDuCmicMH0r2h4R/b4h9v5k5Cyu
         FIyOhD2uv6MoOTZGQ46sgWd+ljuUDC8+yOswLQJttTnmgYMQhbslqM5wNbAEZUONgZY+
         e0Nu34ejyBoEQsWw74xQ/PybSG90sA7R1h1pDs8UCXJWf8yz2giPO+FgtBqDABCadZVR
         crgdxb6pSggNiNqNvF9LiHpjiGWkQ3xLTfZh6UIcjG84sB26ztUbp7EHkFiJ2iFOiaAz
         yi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QPohgoPuf5d963Y2G/ZdUa/zMplXrQUxWQ1kLVkoHy8=;
        fh=BC2eIPBSHlieeKhqqaFVCxU9eEHNzm+ArWooS7886Rs=;
        b=LQQQSrf7SA/1VdyNvK0XW5HNvqC2Sld3yu4XeTBiRIvamVxIuuhpRmOVh5VxahsXI3
         enH/AdnglofwqDMVI3i8+7t1ENj2oCkLBa3LN1Tc7qb5F1WoByNNudI2UwEO/apzWBKn
         yWaaXMtIlyOHPCkqaNtIRecqsQF1n0CRX5rdFWSSmuv3lKhrrNwuwFqb6HDac+bv9z0X
         Pok8TGqC+0PR9PzXq9gFjtRiB9+Icykv1elFwLXEyZPWAzakzxpC7vgIdLz7YQxcdFAY
         d1ote9dwsQ7bhkHKtJl8KogVNCbJiaGxqN1Vq2vEvs4mCCzt5QQ661whgSBFm/4ml+bu
         Oiaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1793566654; x=1794171454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QPohgoPuf5d963Y2G/ZdUa/zMplXrQUxWQ1kLVkoHy8=;
        b=PfdrVEH9VF8i06vBnK1r/kJ3TMJdZ9l7DDBY/wtcVylKvRxCBH1W9o3zCCh/oHrGe9
         NoSgsSmDrqewDYraCvEDVnf78u6oGK7DKAUl4sewkY5yys4PRJ9Eu7vxxDKHAKlupVrX
         As/P+kqU288ALl4t/nSche2fXbeQZDR2BHKavCxMJiVvacpiXP8H89/UJQdmLxeiwOFA
         hKX8uUJh5cnrDbAvtsLIRVX5r+Hrvsz3MKJofUMr08xfWAK53NN30fdiReZfaxgdcF6P
         737nLz1BSfoWe4/UJFCFOmOpASN9iUC6WCSRRdxcwIdfdi2EeAUkZERg7kCJ4lwxom6a
         +ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793566654; x=1794171454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QPohgoPuf5d963Y2G/ZdUa/zMplXrQUxWQ1kLVkoHy8=;
        b=P2heufbBxQRMk07ykk1CLSdDbBHfJYqTb2VUx2WRQCHAwDwPjAEw7vFCgUycpFbOjQ
         FV++QBMFNWEnlvqMxSSoZmaNL6qN+P2Sh3YaGMWizaT0GybXIAO6IjKMqyqr2GcDgy9+
         OmtRPRMCLdJpo70ypu6xZuedFnY5radNgEflD7QR0Svz+QSnKGB5538J9yFE/H8sSzc9
         PghCyISFOokONoDV5rmjLEW7OQ0POfd3a+SV8Pxs4KGeEXjx+OiDQs/QUzMg1IpXVBGS
         yVFflKVO4KgNVZqQCwxM7Trh1P9L9RwC1H8318lHQzLyEUEOJsq3cUWphm10pXky2IjB
         jY4A==
X-Forwarded-Encrypted: i=1; AKwUvBzmxqMIH/+AFMen3GPEMNj4CaLgPLISc8nXDO9oyIzmspK4jBfUBoOgJNF7attx3s8zDeC1+ws=@vger.kernel.org
X-Gm-Message-State: APuU4Z81HkFsX1b2n8846fr594L84eqH09/eeWDVgYGKHdydCcyFJhlx
	U0jTEPq7pDL4xlRLzjXIbM7zN0qrnNA1VqnNZhPE7Y5aTvsP7UfMPi604dO8EfouOlLS0qKlSF5
	QQe9mOlI6a8ijgtdTamX4ifhgsMKqcTiSFVpmYzQmTw==
X-Gm-Gg: AYBFou0M5nvKAZCcdN9SH8aAK2/ClwnlNWNNYpqUgkz5Tb5awPwn5xvAPBjWK0Ts3D9
	twbPMc5A2xxtuzNjNYtB+DvgLHFOm6VwapUdp4lpFGdys5+nio0fsbmTdhSaiWGw3rX26mmuMfU
	vmCU1ls+U7P4mwkMP+OY50yuirltREqSS4sKmrmlV0bzLuSBiL0JmJZ5mWk8nfnEI8ILIGvsqjA
	PVnLD/jkiXrr6NYS/Yr/WogZ2QVxvlF4hLilcSbInj7E2RqSx8thJRmQjF1JsCjekr93v57GFx5
	DclIrEWK1Yy/AQKVf4wLdSo9h7MI+yG6G9MFHTZQ7oH8ju7CQ872WSLC5I/+xZFiYMiZXyxhaz9
	fti70DekqLpVa4vtLPD0G61tU1VjbiSSv82sWRFnliE9Gk3E1qgy5OOiZP0lRI+gjNiPTtCEB1A
	kxSEvJQrNGHMOLbtU=
X-Received: by 2002:a17:90a:da86:b0:39e:21a7:5df5 with SMTP id
 98e67ed59e1d1-3ae897f61aamr6786067a91.24.1793566653699; Sun, 01 Nov 2026
 12:57:33 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <03055ffd-d015-4810-8b8a-678821fa6dcc@damex.org> <92e3383e-26f8-4bed-b487-1c52f6c4f420@roeck-us.net>
In-Reply-To: <92e3383e-26f8-4bed-b487-1c52f6c4f420@roeck-us.net>
From: Robert Marko <robert.marko@sartura.hr>
Date: Sun, 1 Nov 2026 21:57:22 +0100
X-Gm-Features: AclHuK85M4-bkzt8KtwzbjCxHOMk28x-2V4KLSaVQEH_PBp03_WXhAeiSslNHY8
Message-ID: <CA+HBbNE1qs8VBGXyZ6+4mmawi67RN-8RYVQU91hoGBWVfu60nA@mail.gmail.com>
Subject: Re: [RFC] hwmon: (tps23861) PSE-PD support, extend hwmon driver or
 move to pse-pd?
To: Guenter Roeck <linux@roeck-us.net>
Cc: Roman Kuzmitskii <roman@damex.org>, linux-hwmon@vger.kernel.org, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, kory.maincent@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 7:38=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 11/1/26 10:02, Roman Kuzmitskii wrote:
> > hi,
> >
> > TP-Link TL-SG2210P v3 (realtek rtl838x, openwrt) has two tps23861 for P=
oE.
> > driver is hwmon only. ports can be enabled via in*_enable sysfs, rest i=
s only reachable by poking i2c directly.
> > i would like to control them through PSE-PD instead (ethtool --set-pse)=
.
> >
> > i made patch for openwrt which registers pse_controller_dev from hwmon =
driver when node has pse-pis.
> > it does c33 admin state, power status, enable/disable, voltage and powe=
r class.
> > events are polled.
> > only ports with pse-pi node go to auto mode, and in*_enable is hidden w=
hile PSE is registered.
> > https://github.com/openwrt/openwrt/pull/26330 (tested on openwrt 6.18 k=
ernel)
> >
> > openwrt reviewers asked me to check with you first which way you prefer=
:
> > 1. extend hwmon driver with PSE-PD (like it is done right now)
> > 2. move driver to drivers/net/pse-pd and extend it with PSE-PD
> > 3. something else
> >
> The hardware monitoring "enable" attribute is supposed to enable monitori=
ng,
> not to enable some power delivery or network (or any other) port. That "p=
ort
> enable" feature using the hwmon ABI was sneaked in, and I am inclined to =
just
> remove the upstream driver for severe ABI violation.

Hi Guenther, I am the original driver author for tps23861.

Sorry for the ABI violation, that wasn't really clear back when it was
being written, especially with no PSE subsystem at all.

We can always just remove the enable attribute, the IC works in auto
mode by default anyway, instead of dropping the driver
as it is still useful for monitoring.

That being said, ideally it would just be moved to the PSE subsystem.

Regards,
Robert

>
> Guenter
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
