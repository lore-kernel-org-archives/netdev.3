Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E93126D6
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831605; cv=pass; b=MduqPGZt9cnfxe343xgpg0NmfFyz3JhmX2d4wqklSOxbE5/89QD0tEZb5xCS3zih+fVu3jc4eEYCfsLPIu9wbZmbMHdf99BggBBYAm06AAiz6TJQfz6kUh4Ovr6ewT39CzVtm7Rn6ChcegU7WnElgx66wzfJu88JoFBrbBrZsEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831605; c=relaxed/simple;
	bh=5zuDYty8Bmr1QCZL1/0J0BM+bw13EUZbfwMloSDt9H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpy+mcy1VT4vSxsgBUj5QD1RXeElMlPUpBjBX+EfJVtcDrTK+WJIJTjYjkNji9mxCYcuXYSSTf4gLyzGhyj1vNpS93CK9jr79ZEucagx/0nHSQI4W1bIq2f1R+FC4XzMVgNfDCanvGIMGsFYGfdg1UR8A91h9vENWG6AocsZFOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RANM6gVK; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RANM6gVK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so3547437a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 18:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788831603; cv=none;
        d=google.com; s=arc-20260327;
        b=mmqKFdViqbY80Oh3U+f5cR0RiJbAKHRXaRtPj3bHpHK5zDbuwXLtc0aemxMaYti/nt
         jToLXWZi/vIQn8ICgiuzlB1iHpviZ3e1kZ0mzCViYwtcF4wdgs0moeIEqEQTns4BUZU2
         uXzjNKJInS35ER+xiP7/ZEAymt3AtvxnGp3hohRls9a0WO/MclWcLc3bFJ9a0mkiT2EL
         jAUawznMqHUJiM2ujifT6znkSbEjUvlIQVXfO1beptsFnvl5JjeIm8Qhf0Byzyk7Zl31
         KUzExBE6cycbvhcB4DsW7PotXr4i71qfd9anAitJNOtkK28VZNQBgBWyascttoGpwsOi
         NdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5zuDYty8Bmr1QCZL1/0J0BM+bw13EUZbfwMloSDt9H8=;
        fh=vNCfscpkdfA3YxL9zDPcW9IO6PSoK793TSt8peFOPCc=;
        b=n6ES/766H/RpNFbyYarEQzFd4gCmRo8X2RVDjjmzh8rYLetXLA3AiPizCBMqfsXjFG
         1RPwHDKTUy3mCyD2zPaAIhU36VKVvqvmgK6Ojmfqy61lCpnMLQCjZBBjN+Vx2xx3UB0F
         vno59zqoM9Z7HSOevbeSn+hk900mnwnYo/S/J/XCG01yUaIldaZh/NfPEEPOksCQKXlD
         3sbd0IMDL9sSdbg8U5R9qGiWFgcX3jsQHTNysY463I8b5iF+WxN3NYVxH4HvBsfL3g0E
         n9G/RR2hqP7mojNLN3s9WFFZYmqqQN8aMZ5xqpsu2N5kZo/sbT0fVJj3/ZsnqutvSwUg
         +9Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788831603; x=1789436403; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zuDYty8Bmr1QCZL1/0J0BM+bw13EUZbfwMloSDt9H8=;
        b=RANM6gVK6rKzl9eqrRVB6EpiSgZikxgUqpMd6BLtBZHq8akOzlT8RuLDQjD4GWvMGU
         JmoKesLK/JkcYRTNGVGfv3VhkqRSBTDlIig55Z/K5x9+7cDuYQAusUcL+SeUyB4P3btN
         8CBYdbyRd7fMXHc6Qt1e/J/UIzqa+sTko0zQIog8GejcpN2t+G6UtEpjMAaT4I4jK2MC
         F1sEybunZyl4w388n71gEBkkwrp7dn15I6MDPpz0gUCsJPdG8H8h/lXws+t4X9+xYyIL
         FoLJsUT8z+l0ULc4zPlpFqhQPRvah4AOyXB/eSG94xQ63VLmOm6k/zW1CuBRaBVz/23y
         TYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788831603; x=1789436403;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5zuDYty8Bmr1QCZL1/0J0BM+bw13EUZbfwMloSDt9H8=;
        b=UbwqCHoFCOkkz+429GEGTitser4eSk8zL84FR49WVQh5nNSP1q1dIqCUoNRT/VkUrj
         dYAM9z/p0bnlT7c7DFY7dbBACAldMUrNyedTulnnb8HNEEHrCh2w0RM/L+09t3dsj2YP
         eXlgvtPUrAeHhsUi2k74EHYHO6lm2gw0oYxktIsLs+YGx5A5F3LHE8oyylbfELMyCy2R
         r47Zm7XVi8E0im0fvJ9Uapl3/4UBk4tLDdSNyz4aIWtHgINeTN1PfFlIBsq9hbXB1Htd
         6EC679iXQSQEhnQ7cecF8wyeCtYsI7gXWy73sZ0CEW0AG73OrlfiHsTaRyXobX5V/uGF
         uv8g==
X-Forwarded-Encrypted: i=1; AKwUvBwcHfed+5SVhaMiQdMrjC7fZqnqxxNcYXpMjytqQ05SgTBTSk0Bs5GADizte1FFULu6iP7AVJA=@vger.kernel.org
X-Gm-Message-State: AFuF++m+JVEudNcYaC4nGijr4z0NJlI+Z7hB5JY3uaBZ2yiR/2NnYRLp
	XSO0wgYr5VgT8Iwhg8avdZiGR7+O2jYJSBplsvjIECtkqn5x9jeXQA+YDJZPn7h13CfdwWDjWzS
	m1WUXaulB8jYZaZ2yMOmesHKc6bIUL68=
X-Gm-Gg: AYBFou1mQ+UL6+S6NBb1ylZOVXg5vPwBL0FcqRdL5uz6HRufkyywvLa55EFxXd58Kk/
	R+heEXFzArIX11qi4aSBynMkEzvVLDBJyFYMr5mSHKwaT25D5llvvFv10IEcu9PvS83BvOUjbD3
	2QZrGui7g+s13wne2u1FivK05Wi9JhuaOhLkKL4jXw0T2fGtq8NwJpuiIoZaYyO7LMgt0gRfLe0
	sbZNIPEb6LL4PZhst2xn/xMHi6EHhAx3xdxO0QdX3448kCVBZGM+rZxsgDZAJBQcR8KRQzaL7Xi
	Ypdrh1Zg5tkjyWoKBHhxVx8T3+zz44I6LU0Y3xwdiv3pJXbc9A+XbIdpapwjdooQeRCV/aaKipY
	24rjlqrshoGhHc/8X6K42bSUx5U3Lw7L2mu1xcOhtcA25V5QZoFUEhipb
X-Received: by 2002:a17:90b:2d46:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-39b2620a25emr36859083a91.15.1788831603448; Mon, 07 Sep 2026
 18:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904105542.70540-1-phucduc.bui@gmail.com> <20260906131711.247708-1-horms@kernel.org>
 <CAABR9nFYrmteCtb6E_txg13U31Bf50p0PUBvaOXi3gmT7Z+0RQ@mail.gmail.com>
 <GV2PR04MB1173965A34420E072C0DD3A1988B22@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nHUXPL8dV8iqJ-x4OWRLw-qRm8MTq_QDTEJ94WhLWRiqg@mail.gmail.com> <ap7fP5Lz04kySgn9@pve>
In-Reply-To: <ap7fP5Lz04kySgn9@pve>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 8 Sep 2026 08:39:52 +0700
X-Gm-Features: AcwNN1WskE-ZrizZC_ni21bq3lop72zxd2TyEp9MyLsJLSJ8j4zlvcW0r8mEdEY
Message-ID: <CAABR9nHLcR103aADF1WMSEkw-_BjWB9vyWXENJCYfjX5Wz1nkw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: fec: Propagate PTP initialization errors
To: Shengzhuo Wei <me@cherr.cc>
Cc: Wei Fang <wei.fang@nxp.com>, Simon Horman <horms@kernel.org>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "swboyd@chromium.org" <swboyd@chromium.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Shengzhuo Wei,

Thanks for reaching out.

>
> Are you planning a separate patch for the IRQ lifetime issue? I'd
> like to coordinate so that we cover these paths without duplicating
> the work.
>

I'm not working on a separate patch for this,
so please feel free to handle all of it in your v2.
Thanks for taking care of it.

Best regards,
Phuc
