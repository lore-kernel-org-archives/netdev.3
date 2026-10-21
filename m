Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574647;
	b=UdzxmHKNjq4fXafby7L56jXdd6JJjcs8ecnL5FN5AlL/0xoSJlUjG5UBt8S/4r9pxb1y
	 QLZEbe4Zwj5ONsvL+zJyuPbhbkwAtZssdHGZgXSK+xaWfUBeXdvRwbegNW8Tj8zMcNFre
	 17LR3RWCnC7GsczQ+ONkABvoRWOkx84axb3BfOiYr0I41oOS/6+vX+XM8qPPsrxey7Owr
	 nMQsn0Z5x9YFukT8EPSnp6nHtDvkkaMXL+S52aRsQ+F1v61oCgaFzyVW6gErhdBIM3yTH
	 91UWY9DVEgrMaOMxm261K07VoGKGr0PdWSrfjsTJOtdED1lbUOTywrKIP4mGRuObmSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574647;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GDjWBMaaWCM/Dip/yS4QB10iZNdENkMyLTjWj9Cm2VI=;
	b=Wx3sYjgIttHU39IbHPTkkbeLPbPqbywYbZCh47oTn8COq79/MmIwA2OZyNSbcCNDgwTQ
	 giSpEI/P8C93ltl5yxUNuSdvmbgTk5GhhVuBDORfQyK037ejqjtO/LYsRmY67zOdrm8n/
	 20HB/iPkzTrhCvt92P6ekKxtMcQvH79USy7R1/XqiGFd5cXibStLp9PV0U9xFOkHDPCJm
	 12S/Nh+YVmrAC1Ur9xDpq7X/6jMMTSR/PRu0ZQ/aTLRk+POFteSTp6T7w+9gmrSNYNaMK
	 VKz4dGjE23C5DOD1O7mEF6aSn5oKfaNLJiZF4rLOJyqUQmnl3ilsLYiAX0F2bDjclGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gsFVvLBb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fsv3eCb2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D47606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D47606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gsFVvLBb;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fsv3eCb2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792574645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDjWBMaaWCM/Dip/yS4QB10iZNdENkMyLTjWj9Cm2VI=;
	b=gsFVvLBb3Ze/qrCrLdykRRfzcw69btxcB0gCgQeSpneWyn4d4LFz/YmKvosgUidwRP4owX
	1tWE8KNEEVPUJ/jjCCdpV8/OEvws0o+Ot/nL2JtViaiIezbLYwCPv00alkPEq/LgcGKv+r
	7N8Ntz7mfVKza1zU1WrbamXdlIYgbJE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ymJZviiLPwyhEcSd-AaCkw-1; Wed, 21 Oct 2026 05:24:04 -0400
X-MC-Unique: ymJZviiLPwyhEcSd-AaCkw-1
X-Mimecast-MFC-AGG-ID: ymJZviiLPwyhEcSd-AaCkw_1792574643
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a2000d5ebeso2098285e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792574643; x=1793179443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDjWBMaaWCM/Dip/yS4QB10iZNdENkMyLTjWj9Cm2VI=;
        b=Fsv3eCb2hvtJGyMxZkNIhOKkdSw2V2aFArwX//TQYAeuGpTLOXdRa4huZqbRU8sXQk
         LwNYY8D0Th2J9Cia7FHsxeRl0hhiouqZ220uXw62J33okW5ygtWX1obFeeMVarYii5bH
         Sx25R4AqX2nQ1Qye2morCoSMQbJMMOXN1BpS7Qz6/WvVyYxG4Zxo/WPV97CkOlsYQbv8
         P6ED2sb8nd5JsVz8dcm3QQPWx6rs6VFfByJ2WawxfA3FPMojG8yCTc8GnQrAFbOpaYAW
         MRc1QSLGKRl2S2Ml8n+tGNyYFzemhwc6jmmYTZwM+kTfAgJAfiiKqqs8sgsUA6a+EFrU
         D+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792574643; x=1793179443;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDjWBMaaWCM/Dip/yS4QB10iZNdENkMyLTjWj9Cm2VI=;
        b=cGjA+HIBtWTSncPZgckFx3WuXKx+KQEydjM1fHBvv2IrcU4RpI5MKtgRI3sMPuHxkr
         fuRZ2c8tvZjNL20v/NDtAP/6ajiklRll95IvwOah2sh5/9wDqtOOa/kdzzrY1jSIunl4
         Iccazx5sq5KWYPlkMDbr5yAKRdNzwIZ1UXvswCWtUUV6RSY7Ash2ggrzeT1sohIV2w/h
         a900MaYnF7pGgINo4vY1w2PeaLJZ/NxpjBnErUVXwnneCQ16IfCBQCZIeGXDqwm15jj2
         VI+CYuUjy4KqBuXvWlcWtwx9swVOXZ4QZyPax65wWcpEgDbRq4eoJBcPpXd3J/gpnguD
         MnpA==
X-Forwarded-Encrypted: i=1; AKwUvBx3TaaeIXb11tgFPno+iqWYXVDEcJZeoClhgTXK71Wj1rIiouWmEyyVzUqDdndORlqYloPohgU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUINBuHuo/eljaWSOvn4S8ujR4RTxn2ILLzj/hKgkaqvxys3IL
	SQ1CAsBjFsjElmVkAiA4/HN5o5kNP1AGfIEe+hg+QGYHszS1XAZJ+sOCIeQ0+/G+GJbSfBerfPm
	MHWWn7NVHniICha+c38A3kC8JT80liHHW2lCAdWj52foVZlfUotB7OR519A==
X-Gm-Gg: AYBFou1coDHqso7H9Bjf+/Gl0XZ1EhV10phOOCvQ9ltZ/9ub2+01JX7mTy5o4F4Qp3s
	GR/OgHnIv8uQW68CnN8vRwr/tvVdXJBr/0a8vxDoqK2kMkIYDfKe4RQLSp52k3btR6pRKdMYPK1
	e7kX6ku3SFLzrwmQmEheCk8vgvEQ7HG5qLRYKrqC6oVFA3ndOQxR11Jsrg1ky+vmnfiXpSiyGJQ
	7L3BeI73zDh8zsAkkX8liD3PPIAluowJxZKAQmy259CVc+guxptZUtS+y5JGwUvUQLLV+8j5gtE
	a4klM1HuvlElxiqQRfWXSZGXWyoS0yUsBeWgWoYb1fE6CBYs8z44N0RP0+1pfzkSQMGOn88W19I
	s/2MgO2kdA0W4HW4dy0k2LIFSQujmEK9c6/7j3H9cdTwbTsm/N3tLRWzYfpAHWMq+BDU+3XjYYA
	==
X-Received: by 2002:a05:600c:3b2a:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a1fdd4ea2amr27060485e9.27.1792574643114;
        Wed, 21 Oct 2026 02:24:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a1fdd4ea2amr27060065e9.27.1792574642667;
        Wed, 21 Oct 2026 02:24:02 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828ca3sm4279047f8f.25.2026.10.21.02.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 02:24:01 -0700 (PDT)
Message-ID: <130d9b15-238e-48c6-a293-f48e7d1ada06@redhat.com>
Date: Wed, 21 Oct 2026 11:24:00 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 06/10] net: phy: phy_port: Store information
 about a port's upstream
To: netdev-bot+sashiko@kernel.org, maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la, chleroy@kernel.org
References: <20261016133107.54054-7-maxime.chevallier@bootlin.com>
 <179241678791.3135.1638003219102257102@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179241678791.3135.1638003219102257102@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/19/26 15:33, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] net: phy: UAF in upstream_port when connect_phy fails

I think this concern has not been reported nor answered in previous
revision? Same for the ops-lock related in the next patch.

I understand that the high prio comment on patch 9 still relates to
PHY-in-SFP unbinding and should be addressed separately, am I correct?

The problem is that the net-next PR should be coming very soon and
the backlog is still very long, we need a fast clear-cut.

/P

