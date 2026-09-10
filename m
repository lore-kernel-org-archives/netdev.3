Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8F3955D6
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011009; cv=pass; b=kNNeHUIVuWLdaaR10TEoS4EYvg2VWDxr95fYSBChltp+tAIjLo+TkVLijqOX/h/W5DONeYuJ90ACTFtgK1F4sWhw+t15blftT+T+9KAtaDDW4BGn98rhSO+9UU6Wjn6G5RJhH08c6aDAZRSzwLV0DTLT6xzFRUk1tcS+Mk1/rSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011009; c=relaxed/simple;
	bh=hKMQeXyU6ts+i8KLdl+j8HVFtkABo1p2PRJLujgXu6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kskK+Xm9J6HQNVXh8sw1nMicw+cCU696FXoCz9WJDN0LV57NQP6EsVbGQBRLWOkWfGcemZTAvBPX0BxqEnkV1IN+SHykL2rdcPAtAnWyeHMXPjFQ5OOE6H87jAbyUXv2LuKE9JM/T3HccWcFVm5B9Yxm0nQnVZ+eTWeJsEig1xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rndTuQcT; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rndTuQcT"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b6031cbc6bso400777e87.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 20:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789011006; cv=none;
        d=google.com; s=arc-20260327;
        b=p9wMnbPxYjZtbKa+JgTfEVjvCYUo2F5nqhTJMWPeENhCUCbg8rWjT70TSwmfb+8R9G
         tQcHy1Y9KiZSUXtQf9p2LavBlKiI7/NxHHithbXpziP3vSh2hDYZCn5nuycy1VMx/+G+
         Myiqs2FyvQiZG/A/5NGQojOJVwd/tfdi+Fs81nimDA8y1y/c1fO6yCGip5S/l/EJ+Z67
         rUWI8hu9zq1i5+hBPxL7QJvv3S51Bm9Klvqa16YmVX8iFmUErBzHR1dqtgdhVyyENb0j
         kp6VUIFoB9FBquxK4+NHupYMXnlqqsdRsIl/BtYovN4enS8zEdA+MNAnPDbKbfEVm63Y
         BQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hKMQeXyU6ts+i8KLdl+j8HVFtkABo1p2PRJLujgXu6A=;
        fh=Flw963ijXOJTaXk5lJXT7sS616jyGy3GUgTTw+RAIkA=;
        b=b0Ug2cFvgISOS30GoSl1qX8aW87zAgirtWyuWroH+FAEdQPYiljVoAbSemfQp6bs2Q
         uZ8S0/bY/5WC4ygDOMijH2UZlEiTW0vxmzaijJPZdZdNtTG/xVhnbP7WnCxkRTEHeKaP
         ZH9jI5st/0wkmFjkja+R6GcjAn/5ou5D4bSJfVLELye++VWYgndV2Udp481vFe5ZLXp1
         zzkbkB9SwG0xG/JiDM9Qofy595JRPtHrnux7ZHXetRSIGOk0+IiCDcp9Mfu/NghNVFUV
         cVQwpFqgA/D4Jbm1QKYcWlgJ6oWMpFQ32d7W6zYAAulcnSjJdQDpeHixnVJ3cLndaR6o
         tcfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789011006; x=1789615806; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKMQeXyU6ts+i8KLdl+j8HVFtkABo1p2PRJLujgXu6A=;
        b=rndTuQcTR3/p6AQLnvqjbub4fh024UNfav+TVU8WF0N72b2LoT1bcT9udthf0DYUJP
         6fzQDj1dDCHnGjfdCNMAn7zG3SmHZW5S9hKF1rNsvQPyNAZiJTXADvCwBQm/Lrk0Gw7D
         VpayIdwDdwXvNXpQMmqbnKjyznyR1ZdU9UfYL1pWnBAjr/BoclxOgxwUYCEiauEqKgFh
         xXB5+hPQOvZBB1ZYUIudMlqOS1B7f7hv1iaKEMofr0kvwGAn2wbfXx+oscyTJSiqrSfx
         py0TPYZ2MJ9z6A7Z7U9LxhUwshwKJYP+GWNp1wJQPol9tZiPTtmyNbuy/eLWh4vtGG5x
         LkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789011006; x=1789615806;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hKMQeXyU6ts+i8KLdl+j8HVFtkABo1p2PRJLujgXu6A=;
        b=US92L9zPCy4mIzNf9iP3/6Zax5I4NP4uTUmIG38QhfP/aJGym84A5t+BvfMv8w9t50
         mfKKppip5/X/T4cRlahvdJvLE51psMvZsYbGm/St85P6fBI9W5ZkYpnzwnNq6MualHmw
         A/cPFAfnFCBzjJ5UxlKBpad+VAsY+wfJIEKdxT+H9GFY8yUjdisHcx/+ptcdqNZoOxPP
         yPdT9VHGAbLwnB6SNIxSrYnnZOdqvnrikb2e89gV4vK/gN1T+QASCaBkUeYHB22kLw1v
         JO+bAUu1R8nfuSYxk3HMmlutG0TThMYjwfF+E1WtaQImB/sDoPy2JINK6i8uY86wplrm
         dJGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaZXZAXf5EcoFTSAZ4txNklCP46aRIM4mVbronho8pcNYz6cXohliQL59p1hEwe22FYCPylvo=@vger.kernel.org
X-Gm-Message-State: AFuF++n2RCbvihnC6EA3/IdMOnpllpXw8r/bQK70pAupI3cn8YfA8Wwb
	iAgRyrK54GoZj5lIKtBI0ju2luDeSVAJUkMPvaC4SZ+XPELY9A4Urlqp/dT4ugGJ+uMXcS6A+vT
	TE6uU7Bsbc4sDuxFMKzPIJr6FaP0HZ9I=
X-Gm-Gg: AYBFou2JN0y7JggvESgphmct6mZrC5SluALszZvajOZC90ME83otWB3vTv9ifhd8U48
	VXjbIA/isBdLamK6TEqsj/kwSX1ZXLBm4cmiQof75+oGaaRqRa+k0ilmspVWmBloK6aui317mCH
	2Nex5WhxDWfIH26s7GD1EiwlTjFJpVh1yiqad1mhc4p4i4FDshJtYeROe8yDkhFKmzVWsxxS2kq
	95230KR4MY+rRoD32hh5QSPLq82/nibCWFa98UFhO1+RjIY5KVSzZZT2AOW7FMCGBvgfWZoV6zr
	vQebBUoFOnlbqu/0fuwF4R+GAFhF1QIzUvm28EuGYQ825qVXUw/8iUUokjvdRyrXU+Vl2ifXuDs
	rAoLSxp54ph+F6jjdN9PANTnRCNwobSQjx0JAIgSLgg==
X-Received: by 2002:a05:6512:ba3:b0:5b0:137f:9476 with SMTP id
 2adb3069b0e04-5b616f324cfmr8459587e87.16.1789011005505; Wed, 09 Sep 2026
 20:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909013401.14408-3-sigefriedhyy@gmail.com> <178900489382.219967.10423938088246016510@kernel.org>
In-Reply-To: <178900489382.219967.10423938088246016510@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Thu, 10 Sep 2026 12:29:52 +0900
X-Gm-Features: AcwNN1W3iAVVXhnzuL3KuPFsuIhRBn-XyXWkWtewcmOJpG0IlXnw0mTZipXuuMo
Message-ID: <CA+7S2vKWh=ERReF73qhw3Tzz4uxJyjxded6MEvjSzkq6yP33Hw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] netlink: specs: rt-addr: document
 AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, donald.hunter@gmail.com, 
	edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> should it also mention that an AF_UNSPEC dump does not include the
> AF_PACKET entries?

AF_UNSPEC dump returns -EOPNOTSUPP now, there is no PF_UNSPEC handler
for RTM_GETMULTICAST, so nothing is silently left out. I'll say that
ifa-family must be set in v4.
