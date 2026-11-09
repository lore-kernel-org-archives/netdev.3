Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794268539;
	b=3o4uPYt3OeHiAK6dbzefPmiCXxTlS2qH4Rr6BTJoK7lowAetsW+lJdOH5Bk63ZalOwrY
	 zDZgVBpUJddY1gYdnxM+8LOLhl+2dCFS8wbIhuwZb8J/V5bHC3AF2E/InkvQKtwUn+sXS
	 nPIQVbg4QQ6yqFmgBUhmKDirXgAtVeRggV1lbumrxZP1CtW7Lo2SjjLiySF4zyuHtcdhA
	 NW6xo3ZrYw3H2Gf4LJXXSU8c1d4o+muPdPANLjZtnf/xKXqgbVG5RHiFbrGyWJlWTnfvf
	 tHQwZ0vCVpHzqsv+S8LsEh1UJq7PbfjG3kJUt+myFaWVHYo0y8Uuoj6DCDEdl/jtyfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=vu+wnppFR9QRGbA4MP6355thGLq+lw3Hk7iDNGQZ+n4=;
	b=TFw81KN31XMqmqStkvUHfOQra0mNTf5BHujHZMgWMhPxtVy2ARFnCS/C1KXwK/uSVCGN
	 Uua2zyKHurLA8ClG/bWRrKQWSkpi7bGN62KtKBfrfK6UrzdL9EbZrMfhZ03nY+IV3hRlG
	 97CXuiBlqUI20fPtkitBw6LW6MPnSePrGIyWWLNrOLbobXXrk+sBK1r2sGcWm4tAaTao0
	 hpGjMZcCd61HZt+YJypnYkogME8Y6+qK0K/DwZ7RZgyF/+0cx3MwPAlAS9RSz1HzBa/Yg
	 90pxz18kOym57Z7FyOJoCoiILdFLfDL1Q3LH1KHythtywfJMEjWqfO06aV7vMl+sZXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jfQ2NAM4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B980606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B980606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jfQ2NAM4
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c434376dbebso270367866b.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794268537; cv=none;
        d=google.com; s=arc-20260327;
        b=gsYxTDR3DZk8cEAf7GerTWuiFzY6AtzRmGZFgGYzUt9Taxpbnp0HaG4ggzvN5LsWWT
         bDWxsJSxEzuVyXotLJT+x8ULpIIkXD6JAnPMj8NdnSSkP/2IxXqzLVlQFwQZliVntPmj
         MqboRoWG6zRg6XYJEzeyfXhGOoGIQhSSgRAS2MRU0HDrfdULYiut/hm0SnHjkZIvaXii
         LNpoIbfchoKtp8NtpSP6t0I0RmDhjui0pjopVEFhJiglZtm4onBdQcotd1BuG3qsOBgN
         rx/Mg1p8Rfh2S1IGJYjbrZ3aFKTDdWkR42baR4Va49Vr/n+XQilN9ActHu8MVMOaTp/0
         dWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vu+wnppFR9QRGbA4MP6355thGLq+lw3Hk7iDNGQZ+n4=;
        fh=0Y5v3dBBrXS4m2+Qe7YnmMNZ3BRwNbJmsFDRMmk3xjE=;
        b=ok5mtTzvZLHcD1q0Rxh6y6G84V3ntuRFtdx+B8dnM/GfG6KpPN383ZCSSJbAS4b7PN
         b7GPECn6KXiXG6bDOkrwDbTqHUOXG4gatIYFr8l8VrrJ4fpfBp49phripkZ7U4Q4oaHO
         dhZvLSYffnV8I1tfFNdA3DwtnQdQa8X8lXGjNocGpHKJ2HA5DeC5Ee48Usxui6dlfBn6
         tLAgm+c7fDbzUsn/On7NefZM7sUc3I7l/sJpwy+WPJjpwA7cYzi4XTj8T8VbRWlbObT1
         cTzC9FA3I/GImKUHB1gx/pV50RbHCXyQSm/Gs7rQfvh7gqPyZleS/LO+CcEhVScZgMvI
         9jVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268537; x=1794873337; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vu+wnppFR9QRGbA4MP6355thGLq+lw3Hk7iDNGQZ+n4=;
        b=jfQ2NAM4FU7oY3HuUq61BeSBQJUGe2ZBJ/1u1ZS/SWALIF6uOmm9S44mV7J3pJ6Tcj
         FbNZH3C+i1PxOC/PLVr5hQtByedOCPgeFt/NXtvM1tyrgy6fj1MmgGo/SgFDeHnlHbqq
         I+i3u2e94M0Hytfzs7r/U2JVssb7JNZ1x0zqehjfuEtolRCxYvEbI458d/mHKxXIcYTG
         BW0l5V6KOA0FhrXy31mQ1EQwI61C8R/ZQ/LwW17zIqgurRDrTrgT4mtlr5mG7LHm78RC
         9N9v0B/nW19KNMwKwerw7GRImfv+qk2qP4VCmrmhtmxluyXqxJSskBnNq4Q2TAwgdHdJ
         CpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268537; x=1794873337;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vu+wnppFR9QRGbA4MP6355thGLq+lw3Hk7iDNGQZ+n4=;
        b=zQTWcRxZhj/p9FqmqnrjYgSpB+A4kZJTEgIuP/7Vcl5QY7ELVO3KQfgTLb6316L5pw
         aSlckb6F7DvUSCL2Z8gQv3yqQ40V2jq/w8N+pK/KL65dszXphcVs0Nl8vkn/qj4h9RTy
         Pu7/ZoM+FlIGmC6r0B4w44azPhVEKuBNhi+RWcpPIUwP/Hug8TALXANSzT1cwF6wrk8v
         Oz1LCYG8nBoMhTExtseC3Bub3sePUe49M3HZDNnVsF6fMyXq3/ehPFXJVfiddzrrLsBe
         u+QRDy/KNd/jE6L43XflLkB6S9Jhkb/U1CS7EsFklKJKJYrokzRZ2OUfl/AUmc/3T+N1
         mlpQ==
X-Gm-Message-State: APuU4Z90YUw7WYiuTBk0cDgLm7mDKHIdq+VMvyjVwVQGpPWd8jxnYdHj
	bk91ZPV0/IbzPxLrtr85negMxcKziEoGJSEcIdZjyWl8sCrhdKwDLP760ojS3SSKKFIJlD6DvrT
	luJSK03K4HYjKv4iFawgSyq8/1jRBNfY=
X-Gm-Gg: AYBFou385Z1KlSCOvpsBmdkcwff2eVlzjtjPRBLLyYEMCjaSJz1TCUhJS+Pos2ZqzWT
	sNnXnKb6Ddqrp+tfvHBamCfap7bj7HgZmbn0/nAQoHYPwPU5hwn8UIvukjWaN3KNR8ToBkcdGDX
	9xiBzkZIOXo45+IXfGP9A/lx3iVbueRlJw94lZLO0DsAkjj6+Jt6D+zmKHt/AXOkF3sVUY7QKEv
	krOX15W+oS55J4l4zjBeDdf3lJEpnPdLArU4K44PZDaJLXiwzCc1jTS1pHuC+XabP/xomGnnWOW
	Sn6F9/ilh+oiBbNN+2PqeC7p3iqKW1X7J4ALPqFdhkaeIpt1j6xBY3EM63A+FzxsgGr32vybyFH
	nOb+/Kpmpt6YTLIKzImzOFA8tR+u5dWGt1+5H7aySd2jOahMAzRgA/TE2H82yT/GNCMaZQ5OeeL
	yTPInyqM1D
X-Received: by 2002:a17:906:9c93:b0:c4d:31be:1f27 with SMTP id
 a640c23a62f3a-c50495d5732mr66321066b.9.1794268537365; Mon, 09 Nov 2026
 15:55:37 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109231739.2561930-1-kudzo51@gmail.com> <db90cf8c-191f-4576-8b19-00b1b92c47e2@broadcom.com>
In-Reply-To: <db90cf8c-191f-4576-8b19-00b1b92c47e2@broadcom.com>
From: Mlody12 mlody12 <kudzo51@gmail.com>
Date: Tue, 10 Nov 2026 00:55:26 +0100
X-Gm-Features: AclHuK8fSIpA8flr_U9mbbgcHRsqzHG_ry7_aq9VPsL6sq7iwQw_ffFj2ZJTnDs
Message-ID: <CAM0KYu0_fH6Z0RUGCG7swSPRQNnsMfL5m3EvRscfPf2ZBXvwOQ@mail.gmail.com>
Subject: Re: BCM4908 Ethernet and 2.5G WAN: upstreaming plan and two questions
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>, 
	Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	bcm-kernel-feedback-list@broadcom.com, Justin Chen <justin.chen@broadcom.com>, 
	"William (Zhenghao) Zhang" <william.zhang@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Hi Florian,

Thanks for the quick reply, that clears up both questions.

I'll send the bcm4908_enet fixes to net as a series of seven patches,
and the SF2 flow control thresholds as a separate fix.

I'll hold off on my Clause 45 change to mdio-bcm-unimac for now. Would
it be possible to get a preview of your patch before it's posted? I
could test it on the AX6000 and AX11000 (BCM4908, with the BCM54991E
on the external MDIO bus) and compare it with my implementation. If
anything is missing, I could prepare a patch on top. We could then
send them together in one series, if that works for you.

If sharing it beforehand isn't possible, please Cc me when it's posted.

For the SerDes, I'll work on a phylink_pcs implementation in bcm_sf2
alongside the crossbar handling and send it for review.

I'll also prepare a separate net-next patch to make Clause 45 PHY
creation from an explicit Device Tree ID consistent with Clause 22.
I'll send that first so the WAN series can build on it.

Thanks again,
Kordian Kordian Chmielewski (mlody1212)
