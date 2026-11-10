Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794347284;
	b=hdgd6MiVNdDM/h8dL7ZQ5VHGQIPV2HlLAEc2mM7O90OCdAZVaNgmtpTM6Y7I07SIbiq7
	 dYHa+UrPMd6VWSh8dD2Ue8ckEPMOsOmflD8aQHmFKY6KPBfZj817niEc0H5d1dsPWqhZY
	 bIE2AeqlFBle+3THOlup7Oe6IOqKnHiWpbU3Oy0eK0FQ21MfsAotq9bU2gz36fnuKz6mB
	 GLk8Cra/GXNCWo46c6C58PFMe/pDusG4IUnI2UOt+tPzLD8Q3JFIIusB4JBJcwBcAfZj6
	 iErRfvV6jRQpeUgPYyw7lGzcy5Xgk7GsMmgQ+1d1gxqBy4ueZ7NsG8LPUI3vUJoQLIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347284;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=/WOcayzJUskhUHuQDojqHJCdJ99yTsrsphbc40waRqk=;
	b=2HTbVlwfZ7+Z5Z5L/5ZBuTMzswgepOAP6+EIX8R/qnf3y1k2Pxf87RCGCSESxBG7gV5J
	 BqAMviGJRuTAwhX8iX0oYtPDCcy2X+s2xn5Ri0iq+CKsVB7+K0+1Wr8XjtIN9vq0wSRQQ
	 iwmVykdqwiFXKqxKeTLnYVczjS0LHWX534FWgkXxNIcVvyYXk7jwTWETISiPP5uX6l4rt
	 iqeLBocC9CAfc6+KY+Z/PWdI7rZMulZ9lcPaSGIgA7eLSrlNhgh23LyqoROoFiuog7Dht
	 +qgl6CuljvOzLvkn1FaLZP5bf8K8pDwqACjTmZjY5S4j2H+XfEth9cuEOIIt/acMOSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CB606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 198CB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso1381621a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794347282; cv=none;
        d=google.com; s=arc-20260327;
        b=kSzDswBDCv1teEPYzuUdgcUN+TTDs43+cFDxz8tDPYkn6rsEYHNSCBk8gcT8Ej+FGp
         BYw+kBb2/9MvgdLIKK3cKKzPn9/SBgeijVTVWls9ILvfHN0rWCU7wW4T7YOJfDHaF024
         LsRta5tp5QZD15OBm19AlnDUY2B6wYFiDAaMiAOAJSfYE5Ad3Vgu0kZOAuJ9XlCUaV0P
         7/7WPOMfTKJnJd7Gb2/ftPWuRkYFq0b8F6cEPsF1ap0JxuP3fdK3lmRmCZD/cdk3yrWL
         OlkROfhkRyylVQgmm1C0Xrj/Wl+fbJ63UT8OXSS/1EDZBaiRP9jvzyrLnjxH0iGNdyti
         S75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=/WOcayzJUskhUHuQDojqHJCdJ99yTsrsphbc40waRqk=;
        fh=peAzZUUcgBViIJtETQMzy7ctgT3ZYf6PKwNxBk+i474=;
        b=sCgs95vdbELk+mLiYt74Wc6ipbDIpkpKZtiY5lmvfVFg4l6xN7lXeKY92mX1wW//op
         K3wbH/LnPqhZMtLgXYpCFx3y9LKzuY6GfKO/QbwtGiKDSnvIyji/ufHIFEp0cZ0KHXEn
         KdSBPZ3CSePq4IlUoXCgNF1ibmeWCPUrrPzkQCmn9shTMzrcXdQ6j0E0KohQEBloecPA
         oQ1XIxmuj6OG7Z7lBf81VMuOnO8h0vX2gjKiTU07ffNfzKVy/80TXev/U7KC0e1VVmYB
         13FrDg7lMTYRTHcuDnOXJlkpxsUmupLyUKGyDhjD3Y7GQlxrh1BJGycg7ezzRquDZTZj
         A1jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794347282; x=1794952082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WOcayzJUskhUHuQDojqHJCdJ99yTsrsphbc40waRqk=;
        b=MMOaYZ3PduFL1mK7AgPpv3p0oFhd5GyCj16npzJn4rRBrwyzdo8r7BrBI9cECibsa3
         UEXDOJTw074Mi3jrSdiwOYDfA3IfgjICKGouI4Nbr2zyMoMw0wUOzNRA2UZ4hvDg/GFK
         PjghQtyy0Ila4xiFyOOo2EwQMfrs5E09D0DVTusOv8H3uQfTS14MXOaSmEQR+mhAEBNX
         4x8iGLTezOEKr7mmI2W8JNZ/DWezSSNPFhZoVVXnQUNr4FmdWsPBQvG3LdICvxQGMVJh
         PhIBQ4sysac/4ap58JVXbmsJrrQhdqrjvkOd/AoYn6Urzz7hMCS2ITFw3ARCeq3ecKjO
         uvuw==
X-Gm-Message-State: APuU4Z+UmKWQBWIFcfDJtLNo2tZiOL3FSjWS6dI3LDTio7nhRyfp1ve1
	S6baO11LCASIk0wcqkEeXLmFCNWJLveitHApqi4KOWWFVOR+CGkhIQOzX4sRd8XD/9C8XzcwcGp
	Moq+h3fJ8KN2QRQz3Mi/Wm+8rsNQE23M2l6gsDBOCPA==
X-Gm-Gg: AYBFou0Y7me02znDanEPHdBBMwOUyt28rrpf+u4+cjYLK+0fXpVGeCl4tS6NgWYT/E/
	nIAyosZlH5ON8SJgtKpEKAsWq7jyiY2H0fFAHT8CihiKI+nvkiK/fo0j+IdaAe31lZ+bFEUOpYi
	6/bKBeNfMoUr+SOwFbYY0/MytiMvEmSWzcpNhqhYdBqIQ8HPIBA1ln9Aq0t0Xb+LgI7/skkSd+M
	ioDphYu9W+WxQxRMPkuW7sjOvvWPvM9yhomEXV8sL+8LQEORZtuyaxXMcwruO0c0rsqKFfqkiF1
	h4kQBn5JPyHU2U1X0zYXsIDZ/FvsCfhg99xC+8RcVdbGEu2E3plCeAsPsqLKxPfPbj0BITX7HYr
	IVjrjkumaDI8zGW9GBU+QxUCCDNNU/SWuIPYXn1T6m2I6mYET6zXPcp9d63B0ZCco9T3Azti1Nf
	gFUxsRTE10x87g52U=
X-Received: by 2002:a17:907:d311:b0:c40:cee7:3918 with SMTP id
 a640c23a62f3a-c5066d8cbc0mr27479766b.44.1794347281996; Tue, 10 Nov 2026
 13:48:01 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104151914.2651241-1-opensource@grische.xyz>
 <20261104151914.2651241-4-opensource@grische.xyz> <20261110122536.7cca85ce@kernel.org>
In-Reply-To: <20261110122536.7cca85ce@kernel.org>
From: Christian Schmidbauer <opensource@grische.xyz>
Date: Tue, 10 Nov 2026 22:47:39 +0100
X-Gm-Features: AclHuK-CLlMl769sSx84CkwDdaR-obj6arfB97PbP_3TdPcxS2uglw83nZZfEio
Message-ID: <CALsH2cyxzm3OTzyyFhBk_LSkFk4sw+6xcAtUc3hVJoLr8WO03w@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] net: stmmac: dwmac1000: stop hardware from
 dropping checksum-error packets
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, Oleksij Rempel <o.rempel@pengutronix.de>, stable@vger.kernel.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  4 Nov 2026 16:19:13 +0100 Christian Schmidbauer wrote:
> >  /* DMA operation mode defines (start/stop tx/rx are placed in common h=
eader)*/
> >  /* Disable Drop TCP/IP csum error */
> > +#define DMA_CONTROL_DT               0x04000000
>
> Maybe just me, since I don't know the HW, but what does _DT stand for
> in this context? Other bits seem to be documented with a comment,
> let's document the new one as well.
>
> Not sure what the comment above the new define is deferring to, either.
> Should it be removed?
>

DT is the Synopsys GMAC field name for bit 26 of the DMA Operation
Mode register, see [1]. The line above the define is actually its
description. The define was originally added in 47dd7a540b8a ("net:
add support for STMicroelectronics Ethernet controllers.") with the
comment on the same line, and when the define got removed in
5a78fd3debad ("net: stmmac: remove unused definitions") earlier this
year, the comment stayed behind.

I will move the comment back onto the line of the define in v3.

[1] https://docs.altera.com/v/u/resources/r642178/cyclone-v-hps-register-ma=
p
