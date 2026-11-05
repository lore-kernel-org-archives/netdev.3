Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872012;
	b=KxRDjsne6TuCuD4aV2q4S67yUziP3HcCiq1Tvt0QadDXicPHbFO9papBx8I+cT63kJVo
	 59CJ25v78JuD6gOgpZiiHnuccQObcdrvSqMm4EHUcCh9J78cjCqhVUDMJIKNShHBuFQOm
	 fkeT/fdud2Ia/lMWyYa094eqZJNa/NnKj+Ib6Wbl/nLM8QrTiR1xmRxE24JKL+XmrnGCI
	 OcuvN/sPAyrGekc3BuCxpE7vZsTvC3XrDLGgVg5teGRz2ge5jQW037m+lVXVbbbuz8SEg
	 y8XM4Py8BhvoDTj+itx77Ri7cz+44/GQFiArMb5IaEiZ/bgYzCq4FVhiHMEHlDwD7bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872012;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iyLm2JJ7Bha5k7fF1WN/RBaS9++WFeK4ddT2bao+YYA=;
	b=JA3xf22kjLxANf8Fsn3EhLTv/zdhMRumrmyrFBHrtbvali/f1cuNR9bRJkaEGK+s/Rmr
	 7vHUP58dIhgfKPKJG97InW5ev1BI7V+a+buiks+0gHmyEHtCZKM5+goxKRR55+nyRehhg
	 hN+/s52ui/hbGlh4gNsq/tD2KxdpV9oFNHWCchZA8tIq2PEJYVR8qPZ0jA4DlnQBMWGgS
	 3XxCtKOsesaalr5qVM8wg55yfVdIyg59RcJ53oGfmodA8811MFe0FDueHWeZBBngX+WPS
	 SpLFX6u5pm5Onen9lij19CjobpxYJwNk2QiUh5xmBg3CYnZOUvPAVvtVSxogbTjionQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDbEXYtD;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IPe7dai3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7A606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF7A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDbEXYtD;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IPe7dai3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793872010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyLm2JJ7Bha5k7fF1WN/RBaS9++WFeK4ddT2bao+YYA=;
	b=SDbEXYtDBFy+nN/VLO/p7fNZ9zQd79FDJSaSgWTNvnSAiAm7lzG979eOakNO9FK3PorFqy
	vRZmOf8r2sJoOCBbNMjKr3wjSK1G6e5NTi8dTMF5oVsLu6e9jYDCFa/+tPmYq3Eek1NCcv
	IDt8qER22bTswxN+Hxih39VvH3j+7zE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-X4esOdK0PeWcaAh_iQ4enA-1; Thu, 05 Nov 2026 04:46:49 -0500
X-MC-Unique: X4esOdK0PeWcaAh_iQ4enA-1
X-Mimecast-MFC-AGG-ID: X4esOdK0PeWcaAh_iQ4enA_1793872008
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so12738325e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793872008; x=1794476808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyLm2JJ7Bha5k7fF1WN/RBaS9++WFeK4ddT2bao+YYA=;
        b=IPe7dai3A3TwSaQxmblHBD5Q4Q/rWHpStHnErIm77+s6Yc5s9qvi766wpSRCdtPWTX
         t4YpOqsSaNYxQIB62IuEpsghxR2yP/0Dadunp4d8kHLfXbyqLR6vj3pS6fee+9MRpGeq
         2arlYDjKzVJQB4zjAWNYzIRHnNiG+t4j3c942+OTR5sdgAx0QToEvm1pF9N5n5/Av8uY
         +e8tyDO9hO3WCJToAEElH0YZ/vIi3Ha5vxb3kItfdutfSRYhhkowAPz6S6jJ7ckm1BZp
         1hSJWq43riqIxkBaOsLQ5f8hEteYXx6j3oG0yb/LniWnX0nlwQ4Bf6+q2Yi2pPnpe2yV
         grRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872008; x=1794476808;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iyLm2JJ7Bha5k7fF1WN/RBaS9++WFeK4ddT2bao+YYA=;
        b=AcqdZ+qLd9oFVLh9f5aPnxV29UUGiYfiTi1ly4gj/Ey+MrYuqIQl3svOATbjWpl01Y
         j4oCz/0nmYyVgHAKYmCJ5keaH2io5knbmAcPWKnD7NWQFU2+Z7E/KAhwux/2AI7YPfuS
         MDKILlBxdihzDd6hGM0mFcHy9JFTEXeeqDNOmGqwAFktA+4D3dG4XRnY6/TttF17gu7z
         UzL+vatlKnvPmGFF30VpXXd16VHY6znhVtOzv42d5rj9Kbo2ISPA3eax+SuonaVrItyK
         A3Ajzk3JuMtaV1leLiRFFIeqZaJeDoqIJ4gMpH6FzjfzVwNf+U521BeYEwFeG+W/Lv03
         o22Q==
X-Forwarded-Encrypted: i=1; AKwUvBw2iZmW0iWiHctGv+ql86KdQNIAA3Ocxqtk9nIHV3a4J8kY84TcI68MnvfVLsucMvhLUwCkxoQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YjxBlSgPY+YTACAIb5jTMbYXYmTzSJqrKNpkrByGY2O0D3010
	mwfxOoRDUDFkO/agylOJukS7wMAf/out3irqcKQsE2D3S5aQ/myJSRsVCeU40IZGQRaamqz5bJO
	o5RaknpTQXsf8+8y7wQb8k4BAFsy2uxDd7lhqhVVH/bqbsytTdmIotT51tSKisHGHWg==
X-Gm-Gg: AYBFou3bWVkTn7hSgppm3l8Dp7ysh3WrSZP4LXz5qovRTelLLXrkgl9TJ22wOYjwbxV
	0TmocO4uAIEV/mdZMzVHvJ8ilNKOqb3YnPbk9KsJyBQx+Jln3LhxuMg/k3CUshyl+M3alTqQX9c
	gXvQ2jY5vp0drhKJ7gmatdDX9nKnaREvxHE9Oxo1K2U/Az658cLLuvXN+hBru66wcUltVHlL439
	HH9NmhwBfCM4OC6BwEBibKdwgcZhyBBIN9LTIZJmlI0G56J2waO6DQxHUoc64e1ypj7xyK5FdQY
	RUwFYTM6YVw9VwAWs3Wlx1hy+61xed27+xRYVXfcCVQw9FcAWechhFW8nxYarMQyyQ+GD0+ixat
	6eRn2jYsPt7H/xq2qXV0iUOh4/2R8udaj2Pl1tIz4fXpQacJwgpSfhwkHpR7ixZ/BxrYRwXUZ66
	fv438UPQ5tUKB3ni/Zw0ADtiHSfp+39ljPXq1iP6XaLVc=
X-Received: by 2002:a05:600c:848c:b0:4a5:dc5d:20f7 with SMTP id 5b1f17b1804b1-4ac175669d8mr452190155e9.14.1793872008401;
        Thu, 05 Nov 2026 01:46:48 -0800 (PST)
X-Received: by 2002:a05:600c:848c:b0:4a5:dc5d:20f7 with SMTP id 5b1f17b1804b1-4ac175669d8mr452189745e9.14.1793872007952;
        Thu, 05 Nov 2026 01:46:47 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b411de95b4sm84246655e9.0.2026.11.05.01.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:46:47 -0800 (PST)
Message-ID: <51aa2527-0a99-4d67-845a-a8b28f822efb@redhat.com>
Date: Thu, 5 Nov 2026 10:46:46 +0100
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
Subject: Re: [PATCH net,v3 00/13] Netfilter/IPVS fixes for net
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@kernel.org, horms@kernel.org, fw@strlen.de, ja@ssi.bg
References: <20261104090224.750548-1-pablo@netfilter.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104090224.750548-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 10:02, Pablo Neira Ayuso wrote:
> v3: keep back two patches in the series with sashiko reports that
>      suggest they need a bit more work.

I *think* Julian additionally suggested dropping/changing patch

ipvs: do not create conns from packets with port 0

but it looks untouched ?!?

Also AI review did not kick on this revision, likely because
the bot is confused by the mismatch between cover letter prefix
"net,v3" and the patches prefix "net".

I think a new revision may be needed?

/P

