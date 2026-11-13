Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794591103;
	b=4gh0xtn73PIFWg1bO2NeSk72FoOUgBN2lJfjJ5dUqxsugqZCIWCwgTpoRgXW4OJtAmpc
	 DWTdlTn54RCVDIlXCqdH9tc1NJ60ocSrYPY8lCwGfzH/Av5T2Jt/lVAGj2hAA1wpb0cZ4
	 O08O6ZIaYQScPbLbyRkWuKQW/EbolOPHME7T8BAywqQn06j7doEN8dF8ADCRjk1+RxDaB
	 CrTkdJ7tIF566oxbRMK6XWXfFAaOLd/7jFJ8tkiawlsgDw5lbFBdc5W3oqLd8+U2FPQB4
	 A9CYgtTSftaiOV3CveoX4xxFMPEDbFHv1Be37rtGM6NskwpqAl7gEQmp4Ee/oR7vocw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=EtswxBGyiXS8JSPC03lPz9UgjYYoAr3Fyq32GpLBvdM=;
	b=jkUZXk1mnqo4K+P7uI/CRVhrjZ8sfcFY02ys7ccmj9AwFWJSL7g+nrjkoOcavuHIsVIT
	 TAeDgVAC0aSdt0DWJwOr4XJLM9lNRGAUelrsiLBOO13UsT9apEUrItmcRGipJJGFVE4gZ
	 9VqarKijuWxASJVumcJWclVPUqJIO0+LJopOj7aOvB4LCfZ4qKwkBTlEDbuJdImPbIgm9
	 m4OuKPpfFfSAUoTFycJzSsyae05Ob094TixGIGUGmkkFKSNOl7K8ndpEF3/HCGLRao8IX
	 1XJFuDsdOLl4CpJ/0rpUByuMPECw7UvnM6m2vJPl0RlFN3u0QaawHRX8YAO35yvZEoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=le7K08J2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E506074B06
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E506074B06
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=le7K08J2
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67c0bd676eeso1077820d50.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:31:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794591102; cv=none;
        d=google.com; s=arc-20260327;
        b=ofxNAX2IOgm1LyPDUF9vSBq4hPP/U6eImp1HnW9AwTL8CJ04ChwV9pC2Y7Ytb8fnwK
         xG/TjFKq+oTcTQ2f0Tn79fEuZMO1WNzpwmBosdOAPkVMFQcXAyMtl58SP8izkUFU/Wiq
         LYHcEyKKHDjS/2VvzSRxKzqur0HsoJzoDTGwCMAwCFt01b2KlvYFs8zcfy/HC3rVrBWg
         VolnLeM/9nZSOIDTGHsRpAW/ZTXvRDGEVJ7l1AJMmpg5zHzBGLIeeMi4BYAbAm3sygr1
         LXNkmsv+RHrI5+uZB3PfwsmvwFRzZ1Py0PBRJUVv6uzU21PxT4V4d+WTZfqHSVcqswKN
         Vvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EtswxBGyiXS8JSPC03lPz9UgjYYoAr3Fyq32GpLBvdM=;
        fh=Nm7nsdSynxdNIc8xG+GOekIv/H+TS4nl1wfe6TEOGMc=;
        b=HkSsZeeEu2y/o3v+V6BiKr3aBAXTRWTnf66ZGsQZkK1w0AC2egKYY0ypUD+MBHvEkV
         LgNbBvcB2hZZH/kOP8gc/ZYuT/IjkA7XNpwDSeWwmGBZTXYUIu0LNnFrucHJInfc6XZn
         /I84Q0k77wA9Xni3FM3aT4e413+785TkrCJXSc8LnSKVY/ZYwrLBZITFK7fyUZ4pvAsG
         ysDvkTuS+2WrZyY9K9o77dCBMGyLq+Yd8wqpvxzWigXCKBiKfRLY12F7OIX7XWSnY9V+
         coHzF2e9Y7IF9Rl8Kj7l+cb0YhJtWNWP+Y9hc5g005FAnYBRipej205WWSfOCW/nkrbM
         NUFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794591102; x=1795195902; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtswxBGyiXS8JSPC03lPz9UgjYYoAr3Fyq32GpLBvdM=;
        b=le7K08J2bA9Hr/68cdqwbf46C9tMiphP0VQXGYffptEgLGcYlBKFs1xCYmmjfWjy2E
         XIszWAT/7Xhu4ghnVl3bc/lkD3OXCS+X+Sm9CF+iBsK3mKNKSdMaYb/9r7sGzSB1TqX4
         00vaf2a2WnZQMW1Xe61TFGa6iALCGdNBSUY/M2ghQlI3neAa9DiyMLIG7WIID9pwE+XF
         M/t3wHfr+NXVnw+PnTtamguLyZXa/fpwaLUAg4I4Frca9/0u8MW0fZ0xPj0dCGmRxMrp
         OeKijB7gk77FddFRj8+DPtNF3nc5508pL9LOQe+rsb5MZGk+5Fd5fWLJtsbl2ke2sY/d
         uMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794591102; x=1795195902;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EtswxBGyiXS8JSPC03lPz9UgjYYoAr3Fyq32GpLBvdM=;
        b=HLreLsJMAxhPRKone/SZZDODalXiLGu0rWMUqlD9LSShMPjDw7fNWT7kiyPFKtTnYp
         pI8To/sTuXwCMUecddtqJLbzhTcTT/hmPhBmEWGYmoKEKfeeUjbvcoZdlqXEput2SE2W
         RSWDerjeqphXIrERsDiutdzgr8g5dVZCNrfSlbwIrz+g6DzgBwvwAHBm00bi9sW0zlDy
         jiHxZkr+EL3lppTPeBubdLpWs/mKAT2lpU0QlyJnJcwxpyERjRg+EktF8906KNfEzPhd
         1TFC+t1GhkQsOS1gN4+4yxo22BpwrmlkMOnjlGJqrHnFiB5QCmW9GmaLmxgCbvdAqxZs
         gCsg==
X-Forwarded-Encrypted: i=1; AL+hErHEsaVU+SIVahkuf5FsIwWBPABbJEnXreuq7yxvG8dUPTDa6v6IWNFsY3jDd+Lu2T04VgaFuH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lsuEnpsDRPljP/YP4DE8VpontSVseqVf1smUpgSznS3U5IkZ9
	WbFL6C2NgtjgDioj6uyRbKeH38GMab4GyHS7otskGPF8taWQVb4NHTAfJ8xr4o2BLAT9LcI9pWg
	bKsrF/2V3cmHsxzU6TvkLdvxP6zIIUk8=
X-Gm-Gg: AYBFou0pBaS9AerzzWlVttQT3fEM2Rb6XRYQ+kl4xmog6bovg10Tc0aJwL37po4QCLS
	XRg3OEP/b2/iNaoQZkmC5UD330kGQWkGaypcPuQI90ZPLV2QKCqhUOpvbz9xAhdr4nd/BLHRKq0
	8fMKeNkJt+D4UPco2VUnFC7ycuA2rLiSvdnkbw2101LUUKOTgaiCuBIIFrXYCtCv4k3qFxL69e8
	tdMHc95DgGhrEsyCVnpaD3dQJTfkuTqDyK3vLutppsBRq92F1jGeR+LeYJht97eKdzfkpdaoacJ
	F/ZmP1jUfxEjAaiax0nIVdpB8FdqCqsTElxMmfy9izn67vCaw5oeJoNHHG1J3VSvDqgeKClnJd+
	mh/UH67RwIc3zZgImE8T8GgTjfw/lwh4sLiFY/ak5znLv+t1/2+zpCb7UDPK/Pc4RH45m
X-Received: by 2002:a05:690e:4510:20b0:675:47ba:2183 with SMTP id
 956f58d0204a3-67d89709f2dmr1486987d50.53.1794591102378; Fri, 13 Nov 2026
 09:31:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113003217.197757-1-ansuelsmth@gmail.com> <20261113003217.197757-11-ansuelsmth@gmail.com>
 <737e3c57-9aad-4081-ac75-f79cb2084349@kernel.org>
In-Reply-To: <737e3c57-9aad-4081-ac75-f79cb2084349@kernel.org>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Fri, 13 Nov 2026 18:31:31 +0100
X-Gm-Features: AclHuK_T9pn_LFNwcoFkFSy1mvqcLyRF0a8TMF1gVMEOv5saT-u9fzFGXIXxZrg
Message-ID: <CA+_ehUxzPo--g+Ksd_0xJZo7_bhYZ-B17wG3OyGtU=3aa6B+WA@mail.gmail.com>
Subject: Re: [PATCH net-next v19 10/15] net: Document PCS subsystem
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 13 nov 2026 alle ore 11:52 Matthieu Baerts
<matttbe@kernel.org> ha scritto:
>
> Hi Christian,
>
> Thank you for the patch.
>
> On 13/11/2026 01:32, Christian Marangi wrote:
> > Add extensive documentation of the new PCS subsystem and the fwnode
> > implementation with producer/consumer API.
> >
> > Also update the sfp-phylink migration guide.
>
> FYI, the Netdev CI seems to have issues with this patch when building
> the documentation, because a new warning is visible:
>
>
> /srv/nipa-builds-contest/testing/wt-doc-build/Documentation/networking/pcs.rst:3:
> WARNING: Duplicate C declaration, also defined at networking/kapi:486.
>
> When executing:
>
>   https://github.com/linux-netdev/nipa/blob/main/contest/tests/build-doc.sh
>
> Logs:
>
>   https://netdev-ctrl.bots.linux.dev/build/doc-build/results/909345/
>

Hi Matt,

thanks for checking this... Yep I manage to reproduce and I fixed it.

Will be present in v20.
