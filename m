Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84813B14D9
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134958; cv=pass; b=G5GaVHifqT8Q3DULZe7grJq1oMbdqYfKe14Q+v+sa4sfA1K3g5cDwCTeHu0oXQ6fkJ7JiMTGXtIdPn7HHU2HqVmFq04Knz6VEpeOvutz2zvCRBJzAj4k9fxMSyLd+n9SfLUhra9OJS813PY6OdksomJgi2NSmupp5h3R+XLee7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134958; c=relaxed/simple;
	bh=RRS6qEKxH+NimVpjKf06V/2sQCHRd4tVB6c5u/RsNs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5OT1U361NWRZorTYzTx9wASAfgM+zAM0chf3LLLSrHSL1ddsVEeexP8phfJfjKRmoXfpx78GzvieViYARpjqGHnRmrEtDSt4YPimzJMpghkRDf7mBTDQ+Yux4C36mE+zKuj2HMwtbpARvdrVjzmFln8kAeB1znocZtXVwIrhjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7i14aG2; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7i14aG2"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-80a6fbf797dso155543a34.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790134955; cv=none;
        d=google.com; s=arc-20260327;
        b=p986exB3BTnWlk5b9KPsW6zFGcymw+ERU5OETJckTU91bE2X3vxkfXFhvs9SsRuWv/
         FQOqkxbKrBd0/kvAkxM4R0pKkW2GDV2rExqSHBssKZvAUc+zqP2DYUIDgrjCfqilSZSf
         4ZwGkaw/3hAgiOAr8OJ+pYcxEqtb1Tf3Ctwto3X730nvurd49C1q5aZ5G4rnk9BAd1wQ
         FPaYpoaow5rbvnzw6HZudHZ7jMj+M+ctbQfILiU9tiirMytXyDCEpKEki+VyVrCXgZ/6
         e/6cvh0VG/N9/EH0D4/htucHLthG7+vVsdV1X9+eINDSivume2XQzEL97TOtYzzEo0/1
         jwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ETl0dM96QJlv5nuHoins0eKTRLoHFkMO6xGH/oLfeCU=;
        fh=d0WbW1z2jJO9n5hDpJR5v1PEFRZfEfP3ZstjV1C266o=;
        b=ZLHQFhpPDeeoLioIIbBlS7dT38Cdwi62upoj8AE1vltkTp9vOMN1XMc3YHVNeGG/sP
         4X4fcLApKUL3P3WDCsf/oKrjx444zbgHyzhy3psUfg7IkLsyIOJ6AFsYxF4t3Gj2GVTm
         QxFndBA3B9vziZ2N4kMV36xdaiBxZ02XJuSrROFB9WAizOkTv6St3u6onYx++yol9+uc
         +Y/eqCEOCIrFGEf+h/hiF9dBYZF5e6ZYsQDhnpABqn0jXfR681n1jtpTo0yNYeRcjVtF
         MUnLBWOXLdF9+NClaYV9RWYXW1mVa19NmRlG1slrBpUJb2lau6Fz+UcBoXxQF+WWtZqw
         PAyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134955; x=1790739755; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ETl0dM96QJlv5nuHoins0eKTRLoHFkMO6xGH/oLfeCU=;
        b=C7i14aG2bdgWqlopi+nQc6ZicQsDdeRNbLRI4NoCJsTi5CbKDln6oThZL7YI/ECfeX
         /2dMbXp6OVHkwj/KS4P8IFVrkdD31J3A5fplmByd/FkPwCLQxsl9bYLvk/yy1Gj9Y9qz
         HcKm8LlyC2xDeAKgLNADlIUHQ1ChrpWMN7nHrZeG63A9sctwXxekAQQ2BoI+UpvUwSiI
         k/OguCoTP+huCPmOLX0rUeZCEdgjM5UjaXifFevmz7h9qlvmPkzMI5/GkQS1wl6277AK
         MNS4Ezr0V43VHo5Hx5sqZ5B2jTVAHsk367MmZd3pt2sGUOBVo+HK2nRJtrVaL32+CCgn
         mdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134955; x=1790739755;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ETl0dM96QJlv5nuHoins0eKTRLoHFkMO6xGH/oLfeCU=;
        b=PtAbtMhec7UxHJd2DPQzh8GTYyzpwT8s2Z3rUnk8yseI9MkUqkG4KYKyANnyb8lOFl
         m26R3nlm0LuC1STLadm0W5LK3suKSJy4bIfrzAnUszcXr8RPlIdVwwbvDrOfEevviYkT
         4OLB1qTSKYkOCUxuI7WbiMs4MYio/pnkyPdO4KKDukk6WBdUSjOGL5BingIAol3uGlNS
         3Y8YLVKGzFJnSQD1lvdwHAsR44R/vdv0tFUIcjzN/BI96RgR2CjTX+v1dlQc+5OEkyVn
         Pa2efjP1HO4XXV3F2LPLKnsXLX94AAhxmbf6fBVBbD0lZP26bP264KE7+h6i/BWVrSro
         F7Gg==
X-Forwarded-Encrypted: i=1; AKwUvBwh5sOCfY0nnS4wPlnsIzvaxMfyDm/1HTT35WVl2r7qdaDAFNrXp1izGt92aG1GoU/Lb2SA06s=@vger.kernel.org
X-Gm-Message-State: AFuF++mic040vyhQ+WdR8hAtzL06r2cOGJ9uEF+lA1FfXYS7USchHgct
	3eNWVqhE154EdLm0eWYBQezudu3Xin+8VXT3YyRZhKxYB2mdQ05Cz5a/hOq5u3C4COXC4pO/Cxk
	26itDs3z/c2Q0zdQnHp8Wk5DHwGbttRE=
X-Gm-Gg: AYBFou1S80zcj9bBlP15IxPf/vpWzdZQdaqOA1BjhYYzqVA4hnF9DV6xUaEWRHt/QsF
	25QrICnAgA6LYpFJC7H7Z9i6hG/I+Ty7Gb0DgXB2oM3onmU4AC7eA4IhONjNZBWgr9aOUKe4s2b
	U00TFhauuF70QnlA+SKzV+p1ezgfiH2DX9lL2TFHuzNW85tbPkcujEYSMCMz1LrPkLyrEGRzk1L
	7kp+HSzFvlOTEHgnlZBUa0fJTQ0E8x/FuU/zlvq7zpHM1GFAdofwgc3S7jljyLqxdqatpVYDott
	CN8lQshIkdBuZbiFLi+QJG8N3+qUpnmOv3qKolZ7L3OMBoaO1BgdFVsKpRYTtyl3h8hccM2JiOC
	QhuQ3nAqSzfUST0nvdmLtrsrak6FbLd/GHpxNp/tVaY2J
X-Received: by 2002:a05:6830:67f7:b0:7f9:555:1def with SMTP id
 46e09a7af769-815fa7a1a70mr1301644a34.11.1790134955518; Tue, 22 Sep 2026
 20:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921235951.3214-5-sigefriedhyy@gmail.com> <179012275175.2160803.16091441325063775173@kernel.org>
In-Reply-To: <179012275175.2160803.16091441325063775173@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 23 Sep 2026 12:42:21 +0900
X-Gm-Features: AclHuK8TXSgkkQWPa_o2Ozz0Yhcd3LUGBcSyKUw1APvq-PmiuvaOCRWU4_ZVJVI
Message-ID: <CA+7S2vLn07uAcPQTV21eXOsCMmG6EVOaM0NBAkRtHcmeLZf7yg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/4] selftests: net: test AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com, 
	jacob.e.keller@intel.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> - [High] dev_mc_fill_addr() (net/core/dev_addr_lists.c:1210) emits
>   IFA_MULTICAST with `nla_put(skb, IFA_MULTICAST, dev->addr_len

Existing issue, /proc/net/dev_mcast prints the same bytes. Should be
addressed separately.

> - [Medium] dump_mcaddr_l2_check()
>   (tools/testing/selftests/net/rtnetlink.py:113) issues the new

This is WAI.
