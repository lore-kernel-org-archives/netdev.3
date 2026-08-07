Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EB44780B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082893; cv=none; b=qSjOQkCxlvIgf/WCZIMBg52QwzZl8RD7HHFOwz7RpMyXoq4hPyGzeZoEhjz5b7pwhCa60wHF+vHCItSj/FQatVyqFqoXyjq9yUN11BoW62+mufxFPo9ot3H6B6rSoeaz6VO/VGLYAWXMn74KAgN17tIWgsyYonwPs3cAhywY7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082893; c=relaxed/simple;
	bh=Dmo8PuWB2dyUoK6CmLhGPKx4UKIqxhrcgydV6J6fjVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXXpE3NNKbS0vDwoSilzTzjRwdzYRGhizW1SBoQP53WdnV1J3Om7oMDQXzHcGiP3fCVahDEr5DtyChsudCAPim1c5pHKg50iWP6GF92/Ui4JTIEYIpwn/bWdBaLC91MGYUcWYzAt8bpB/DVule45cuig0KrX4anQ8jMcBHJhVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoAvT18q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoAvT18q"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacb8416a1so31630005ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 23:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786082891; x=1786687691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=18ijIQgRx8E7vlxXhmmv1XyuTJzNC88cfZUUTJ5jyFU=;
        b=HoAvT18qxavceu15X4/lZwb56W/bP2jc8qkJtDGPP3i1YoDtWTwbmMcxBvo9aIhsNq
         fc3CfaB2v8nbcNkl5TuOpMkVizORpLPpS1ATsTADk2gJ9CCw13O5oO2R/Wxn6dxqs9a6
         pJxGFpT2HP/gmSn9SpeaMa/2vBMSNFEZ1sVCFEeKKTWdZAnC6O5FDtueZOIngAUb1zzn
         ik/U8nwMIU6CvA0TPYKY1+kZrL1S3rFyDbCjgnk/IILIcqkzLCBbUd1aOeqItDa+wHf9
         QrC8ya/t08F+bieT9F/x2qe5EUzSbqOaVFnmsSMHOqMUbf8g8LfAMpWUGW04A0xXdjs4
         +2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786082891; x=1786687691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=18ijIQgRx8E7vlxXhmmv1XyuTJzNC88cfZUUTJ5jyFU=;
        b=CgjY7LFsjZx7v4gU0mwJ6N7AvgPRIc76QFsfP7v1p5ZAPN2VZbnge9oKFpzx6gDHug
         KJgxoDbn8K+uysCXacp/drYmNMpWPde3Eh/EUIhZ1CQOAic0L/GxUmNVTv96MxKUhZms
         WltbNEY/T2/EqYC0DglAzk4qUXNQPfftAgeUt3JL9o1uHRgcoDs4D6abazqT7IWkeT+F
         43Ve0q5gy2zcuKyJvHpS8acB/j7f6+whUOc2N8hWtjoilpFbcCFuXbcjtD8HGmgC4a1/
         sSGnzntzuQh65S27nAofHuBdg9jtwTYgShLQdFAm2QfOrsB6TbvumhNJaHcw+qCdL0rx
         2qpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEpy1PiaJ0GPg2qMS9lIlJM11lChGBcN1/RFWpg+w0kz0YVws1m4aNTN95/EonjNAuHG/23/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHDqk+Ne0QLyVq6HuO6EeIG1aa+k3lgk00HRWLDIITegCnPOX
	EWueqqP6sKens1LOzkNjbQ2QqG3jrTl9PlOWlOoMufTsEuhzJWfyABjh
X-Gm-Gg: AR+sD11iXdG08koCzxlP7hHK3np/JI3Nkz2/kY7bdZ+b2IDwD53UEgCoQIjmrgZViEi
	Oqmu0G1u2FyfW2J3Dr/LqjO29ahU4Fq0leeDiAoxcbJdudCFKonoCkPI+2q4NU1pqDhfnsndTN3
	S1f0gPtBFnf/cFomV8UxnIPz03lkWXoYt6VqOOMostBGXK8ABMJFOquW/mDVGn3qZSJnf5R12do
	bA6wE20D/j9rVVV1NS9z0Npkaz/HGoEQY0wFU7y8dqbT70dHeggKA8J6fnsp8DJKvv21vwCFERz
	dMNJdrM2dX6aCKasWJw0KT6vKBo2fIwJVO71fgAPYzunS0uMX0LGEUVEHm8FHNXRBOjZHwvP9Fo
	WeeW3ytWccIW5mkw1Pj4qAO3iRbuJbIgxNdah4aScT78Ei1jVby5XqV5TVe9e2YAZZjOvqSlIcv
	f6wq0ls0Y9jMmlKXbn/VSiyzbSV0OEXJ7wemEloEfQu0I0GDhtI7bC+JE=
X-Received: by 2002:a17:90b:3841:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-3903c54b375mr20314536a91.6.1786082891033;
        Thu, 06 Aug 2026 23:08:11 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b136c67bsm614385a91.0.2026.08.06.23.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:08:10 -0700 (PDT)
Date: Fri, 7 Aug 2026 14:08:04 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, 
	sdf.kernel@gmail.com, houminxi@gmail.com
Subject: Re: [PATCH net] tools/ynl: add ovs_packet uapi header in
 Makefile.deps
Message-ID: <anV2I33ZJyI7xAiv@fedora>
References: <20260807001918.61957-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20260807001918.61957-1-kuba@kernel.org>

On 06.08.2026 17:19, Jakub Kicinski wrote:
>ovs_packet spec needs to fetch the right uAPI header,
>like other ovs specs already do. Otherwise build breaks
>on very old distros (Ubuntu 22.04).
>
>Spec was added by commit b82bfddc46e2 ("netlink: specs: add OVS packet
>family specification").
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>CC: donald.hunter@gmail.com
>CC: sdf.kernel@gmail.com
>CC: houminxi@gmail.com
>---
> tools/net/ynl/Makefile.deps | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
>index 43d06ecbae93..2771375339d9 100644
>--- a/tools/net/ynl/Makefile.deps
>+++ b/tools/net/ynl/Makefile.deps
>@@ -35,6 +35,7 @@ CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
> CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN_H,ovpn.h)
> CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
> CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
>+CFLAGS_ovs_packet:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
> CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
> CFLAGS_psp:=$(call get_hdr_inc,_LINUX_PSP_H,psp.h)
> CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
>-- 
>2.55.0
>

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
