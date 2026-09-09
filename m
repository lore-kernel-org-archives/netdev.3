Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28495221E6
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952558; cv=pass; b=qAY/b9p5elu1d4obJvCedcnA/UExD2oleVk/E5zM7hN8+cgU9MdnrCPHX/87afCo8UASVik8kpgxGPV902zmuoeBnQv4vvCmc/xrPuA1OOfuhpwBASiJ7V+6iwRABIY+r3gGwDJGA1gZJ0JS/vF1tn1cWlNuDx+TTWSGJhAKZlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952558; c=relaxed/simple;
	bh=+j50wNv2r3xNtSsPdNlvPp69DU3jj8cq2MKhSUhc5Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Voi0TO5pRArIS/JYLAY7MMx545VJneiGlzyDwoPZViYY+KsUvHUfb15U0fqGKIUGJjasLMDljkSBZY4s2utYSI16eSnNFbMGTO0iQ3vLlUUBdabNpK3WaaC2vVRK0AQEppZHQBdU1VXhOGwdNGg2nMB/VplDZjjhm/aZY3sZnqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C63zya/L; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C63zya/L"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b5607bd3b5so3450644e87.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 04:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788952553; cv=none;
        d=google.com; s=arc-20260327;
        b=UDAqbTTsRjKVsAhmazCw+T2uRMtUy8cvVd/M8Q3X8271DV4xomrTWPFCs/9zDk5rxM
         8927kQiHA88l6WLY08Suue8bdqC1aqrHcplUVwYXQ8AvND+yInnDmYWp9TNTgsHw/ynx
         gFvjRWaZBXXa9R8XY569UvS+MPevtnmnTpUqDCTqKL5m5nlOTFKqul3cbt8tahyMO2By
         xKBI1Baq7nuFWjTtu8xhk63HnE5ixmK20RMxDl3PkdnX/rV5FshLX1pRkiZ62b8QqIrM
         7eGnBMJqBhnmNihIR+dmD840fxRX1THOOfWD/t7fyTrFzZ85HGzLDCn68KKs4edYnyGF
         JlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y4cdUU4wdLJreuRLma15s70p7885T7zuEzvFUDm+iJY=;
        fh=kfoazHsvTaWFSTDkyNy1vf14TX2+Rz66YBnI7wfzD6I=;
        b=LZFYGoeCLgMUiCSgNf5oBvlkszjg+Y4gwSdshqrssTCQuR+cApHz/DYORsOI19qMxT
         mrR3cPdTUnwTieqL4Xz7wNeGckjfXSulzEc9FXjWF191hC4W4skiyg8H+bRVJTqdI7mR
         bq5skf9rlB99sYgvw9ZOm97xVO3WN8Gv8uec4WZLvE0JBN8EbJ3onphn/RIKhFTccHXS
         0nswUCDFYBKbBeUToK7Zy7Z0lZsBxTSjEfiXJ8KOVqS+BKd+hkS0UlpbltWI/paFYcxM
         hqfQi86tTXp5RFGo7Lp2Ak8cZi+xu89hlaWw/vipAuYuKShP/Au48gu7pVrJn2KTTzK0
         aWEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788952553; x=1789557353; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4cdUU4wdLJreuRLma15s70p7885T7zuEzvFUDm+iJY=;
        b=C63zya/LpWmCGXJ1ydVUM8LXgdoY+CC82am8T57E8i3/V5F9xluwuc2hR1pjWzQEs2
         F8u00psAJXRgzh7vjx61DAZtcnQNVcqbOxSuWdJPkIbMeV4z2NVb8OTpY+dyDVv/TkBS
         tUV15Gxh9lmoN3RwMUP8O0OY0n4460nL+qIigFIboYrsBiwBRvR0uZ0JKJ8uEb8eeJnm
         qdqPQkvstuB8WAElfpkMca/EHjnoGLOl+e6Nw41snfE0Sw171BS9GQ0mUJvDUvXd1Bom
         d5uB4V3GTcnnhg8yTkOUTgWfBhQGzq4EtQrA/9okQ6uuOmc5NlG4liq0/acgJy3xHrTQ
         3jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952553; x=1789557353;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y4cdUU4wdLJreuRLma15s70p7885T7zuEzvFUDm+iJY=;
        b=Q4d0EfJEPIOh3NdOuwT1zggsjYnNwkn86AOSUDCnbtTb8IFYJ6DLkhPLyhcbupseS6
         Wf7y1QxdfZAm/u5pbBaf6uoRN97QcVsj3SsEOS0Dh58Fh7Us6gPqSX8iN6sgz/t1S/vH
         Wy1iI4V6T/QkFPMgzUDsSrwBDJ5a69B4AZKc34bGbjCjvV5iGBeRk1vLvaA11uohxdEK
         2OpID8h2o9fgePTMmgGaNwaUjyH+s6Oj93RgZyQIlqI7EOE7edkLnoWUiy8plXSJ61Q0
         Cft7y2UnSngSdPLFGhtolvkM9djECHJuxYf2TK/GqtsjnHTC/AX7qe4UIcsoQoMOUIrl
         VxVA==
X-Forwarded-Encrypted: i=1; AKwUvBwCRWADI1NuSNsE8NJNAW12TUu/tAafmHDrn7GdnurK30VpguWkzFlTOcYY6iIQ4GMHjGCxnLo=@vger.kernel.org
X-Gm-Message-State: AFuF++kB7U4RifQ0z7ab8qJTFGLB+Z9VthWhOrVwRQrjZxZOopXWXnty
	U7fWnjFDqlc5koEmpOh+l9PigcNgPDK7xmTFKDNLjJu0iFFiH0nAco3aghy4rtLkpA2DuQl8/m0
	HM7KEEqs2ZQw5NXD2ANa6L+N2BJrXStk=
X-Gm-Gg: AYBFou0RrRcRRXFATUSiH3sBblsrU46f9T148bOpNrfWYbwTKdpBshb3pGhb1ak/gDA
	Ihxv9cX65c52Ia7BiquGfCJFH98E9Oz8D6HsPAgdsVMsAMSm9s0V4putOqOz3EGVQ6Eqk8xzNQi
	ssE9VLkSniPZD85wtrmj+KCpBW5gPnZ3n0tq/jeB96WPhi6XDqiafWrA8vq1pm50t25+YDtJCUq
	jabmY3RL7ZTn4o+yM1BH8qC3kWwSLr+ickVTZw66668ddJhr3iZ0w2qakyDgKz1W8tl3EpxsrQh
	1pO4JxBgKvgwsTbCBjwDZ2nrhZVVs3lAItA8Xy5X9jOiekc0/V55Nn77mFsKvmLKVniy+UYbT9y
	rUdJfifQ0/7LsnN/DZ2BwFukWaNiNgo6BCkx5cVuTKnU=
X-Received: by 2002:a05:6512:108e:b0:5b4:a9e1:b8a4 with SMTP id
 2adb3069b0e04-5b616f4a238mr5849435e87.25.1788952553103; Wed, 09 Sep 2026
 04:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909013401.14408-1-sigefriedhyy@gmail.com>
 <20260909013401.14408-2-sigefriedhyy@gmail.com> <175b6b01-2f8e-4b77-8504-6f26d9f8df98@6wind.com>
In-Reply-To: <175b6b01-2f8e-4b77-8504-6f26d9f8df98@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 9 Sep 2026 20:15:42 +0900
X-Gm-Features: AcwNN1UbxNJzD9rsLIr-ful2KYX9yromNjRe3aj1Ks5MUzUlvT_D5TZcbmgqvTo
Message-ID: <CA+7S2vKm=4_JBocQPq7OCZ6ZSaVOVS7UUzQN5Rd_+ABAFBkQ_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] rtnetlink: add AF_PACKET multicast dumps
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +  - IFA_F_PERMANENT marks entries added with SIOCADDMULTI
> > +    (netdev_hw_addr::global_use, "static" in "ip maddr")
> The global flag is also set for addresses added via dev_mc_add_excl(), ie by
> some drivers.

Thanks for the reminder, will fix the comment in patchset v3

> > +     ifm->ifa_flags = ha->global_use ? IFA_F_PERMANENT : 0;
> I wonder if adding a new attribute IFA_F_GLOBAL would not make the API more
> understandable.

Good point, IFA_F_GLOBAL is indeed a better API that will fixed in patchset v3.

> > +     struct net *net = sock_net(skb->sk);
> For consistency with ipv4/ipv6, it would be nice to handle IFA_TARGET_NETNSID.

Will do in v3.

Thanks,

Yuyang
