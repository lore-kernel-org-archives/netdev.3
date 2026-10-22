Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792643305;
	b=5qi+2o7cKVrWAKxYlFsOVLnKjuOcMKEn/1X/sTlIx/e/7EViOudjOLONVC7StLgnRPgU
	 gxtfc/L/TZ02VHPaDb/f8gkzpSaZq+1dwjcfH1xSloAnnLq9Sw68W4gJj80jZKgvsxH04
	 oFntyn6wYWQzAbcgzDDF4iwDaDLzb0749IsUIdbLI+Qeiw6Y2CsUsdrsOEqSfOmm6CBjH
	 Mq8/RdoWi13nmjHOgyfWbf1Q2F8YX7WK1OmA8tPW3Jt2rKBZrW04uBxfx37lUeGG6r1Ke
	 Wlwt5GTSKELYGEgmM1er+najlGKccZCvJpiVvAhLACfDpoOq8hjx+s2qPUUPzC+HhEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643305;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JihyxIzLjvnXhxbKdnsU8Kp0oaWDTKIRNra+zU/7tSE=;
	b=IoljSjNkGJR0N7so6/iUK84twmefH6SkY/rCpuJgAvphc6Rs+ci7A9HkSJed4SGa/FC6
	 9ZMxuqBz28vXaVcMn1M2XXuLmdt1Nh+8D9rcuHSUy7p056KnhkIfYTGJSZ0PMbyTmFKjK
	 v7AeLdE0tXxYNzZ55khD6Pe4sMFiYJmpt6QCxftGL4/er0Onsfy24KV0jxlmjFIT8lkqA
	 E65mBEEhRQpu7mULWICZgb22YmnZtHWLr8aV3sGTW4FY8D5RBscayHASMCD5PeXZTU9iz
	 o3B4pickqTad2Ebl1t0rg6OdO6RCluqydH8ZgDFhgxfe07Hq2vSxVqYx8IDLwg65+rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307B606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F31F000C8
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792643305;
	bh=JihyxIzLjvnXhxbKdnsU8Kp0oaWDTKIRNra+zU/7tSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ljBHlRojo3Otbiewv8zIxqKrtp+tyJy+dT3Q9UQPMZUb6zSUsX/Yo08tMWxN5LTXD
	 Tz2p3AZhCzZ3wHGMDBIcFTnOp07xH+5ha5T4dhwyjwcvisl3WFQvwBMdZ6OZUR2TAf
	 EKMUdp1kCx2pBODspRVidavxNid0ij+bEN3whm/8Pg5Z6FHAdGxwULmSYHjmX3RXBM
	 Vn5I8x2v3adYZPUnXpvJYtve/ZnSh07QQBZof/+C4biLSOJE3TS6M+ksAlz29NiCb9
	 JlAiKNxK8KuuxTEhZg6gWqIK5DeFIshf/hkdemLqYIwvFCf04gNWMrLLStpsFXvxl5
	 moZzaBr/3LYLQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6deb848ddd7so893632eaf.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 21:28:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx/jQL0wvUjtgh8OhzcME7DMAfbVKVFv+IWNR95eEY8eA5aBSdVjMqoXq/OVr7a/+SjoV5jJcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdINMMMSUvazE8aHlFpPmbYNU37rqeV5Ao9TRQlZS96mJtFRrV
	7tsYynf0zn2y4vx0S91Dcy5ritA0k/QPPtdNjQNahLEJYlncUMogrnMwPuJ5D9MzhSeJIQu7NN5
	UJWjVw2bDEG+29jd97Pzir6W4NJddW6g=
X-Received: by 2002:a05:6820:4cc3:b0:6c3:19de:d1ef with SMTP id
 006d021491bc7-709400b7315mr2549029eaf.20.1792643304627; Wed, 21 Oct 2026
 21:28:24 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
In-Reply-To: <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 06:28:13 +0200
X-Gmail-Original-Message-ID: <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
X-Gm-Features: AclHuK_x9x-dpxJb47_Ejll7cdrs3Kd_pJ6JEFAwdGO0NJ9AJEIeXNJiDE4pBUg
Message-ID: <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
Subject: Re: ZDI-CAN-33367: New Vulnerability Report
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: "security@kernel.org" <security@kernel.org>, 
	"maintainer:NETWORKING [GENERAL" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:NETWORKING [GENERAL" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 23:47, zdi-disclosures@trendmicro.com
<zdi-disclosures@trendmicro.com> a =C3=A9crit :
>
> ZDI-CAN-33367: Linux Kernel skbuff skb_zerocopy Improper Ownership Manage=
ment Local Privilege Escalation Vulnerability
>
> -- CVSS -----------------------------------------
>
> 7.8: AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H
>
> -- ABSTRACT -------------------------------------
>
> Trend Micro's Zero Day Initiative has identified a vulnerability affectin=
g the following products:
> Linux - Kernel
>
> -- VULNERABILITY DETAILS ------------------------
> * Version Tested:7.3-rc1
> * Platform Tested:debian trixie
>

I had to cut this report. Way too long, I could not see a patch in it.

We were fortunate to receive a report with a patch from another source
one week ago. Patch will be available soon.
