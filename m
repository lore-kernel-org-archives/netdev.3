Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914632BF4B
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874236; cv=none; b=gxr/k1FztINSlIVj3tCgnqEhPxx0GJlqPeAqoS6MHwW/1RNG3Cs++jP2pYadjwZGN3PXMtuIoSPowNrj26+KRkIcfYBggGswx9lAC4S9S6xVOKP97SuRkCQ4j9Xmc2Jogg3/RWoLWIg95o7kr/GR090Z9SdYrCeAvkfhfddBRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874236; c=relaxed/simple;
	bh=TKIfXv1Vqs7r3rpI3b9OhjjHoDUPUgwo3WVJteIG2iM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/osLM6va4zYUSy2sxfzdx9fno4ZjR/FVSnVGpHTT/7SJcyatq79E/673GewuUr0EbAvkGNxKnniKbjGQJDjXFLzvkWf0SOgTIm9P0Zzt5gHjGKJjSjFCBSGjJhZPepXi4xC36upkBNSifV8i+gXgLtP70USY7acMLX8fCTPQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBpINfF9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBpINfF9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d01663d816so3442955ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874234; x=1788479034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILqi973ot8v837RktsIzxLZA+rY1smEq6s+lJMdBodI=;
        b=HBpINfF9vXea61RSOrPiwX5JptG+OL/7fQPNNq/aeWEgaTdUKLMiOL0U7sbkjX15kj
         rj6aBz7JrR8GzXkSeKF1zVTDfTJJfK17yNq+b2JCx1pQVc3KjsYtaeJm/ieZtL9IXbhr
         NLq8M9bID/JvCkUS53In9smtcbozZ1A8PhNUU/wIcCaMwqr821OSRypw+Rv5iY/JZsOF
         Ehohf0Q9OIWmr0CyDts50J6n+S5JvruexNlsl/fS2jeE93ttHP11tXaRT2xNDminP5ag
         h0rqRZYVqwv2mEJzj8iayJbltD80rYqebSc43TZThiYKQgdVEYbotO4+khnSPIeFV3k/
         YYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874234; x=1788479034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ILqi973ot8v837RktsIzxLZA+rY1smEq6s+lJMdBodI=;
        b=BLxc7EtAPmj/Xz7BnGant4R8hHfVcNzMV4+ROAynmqzcfD0giMxn66r+3lZQaXaUgj
         0hKTiYBvamUa+iYCy5xVcj3SNoCCxnRm3C09xefpVte/wLxiDoHOt20ftFYc+Fe1KOY+
         b8TtcVTWjRXmfdJOjrOP8GXDp8HHgXKBfrKwidbju+BtT+ZuwzAT1vzE25j4z3K+RnUC
         qI+fWQGTpCXyzRDZ0DIitE3iYAv0Gj9mfyZV3RYpIM784LZ7+93QNI9e1YMy0lE7MGJz
         rc01NZ7Y+LdtEb2cdCeoB+uqjzcXz3CXi/DwXk/gai4gb9ZGRTOk/2nLdh++M+KSP0VZ
         bi2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqr7wHM8emfCOrdXG5Vmk5ZOaNGn1weFWVcT50+gCzmxmOadXNaQs3DnV0Vzlh9xNNZAw4uaH0=@vger.kernel.org
X-Gm-Message-State: AFuF++nUZoRt4xGAB+swZyvr/eEfR0l2JHwxPvAeKoS09TMMWcoSBvWd
	1b8TlvS/7tOLoSJA3zhV2kmM7Y+JOdNAr0kDJtxAM+XHA7F8AvI2iM95
X-Gm-Gg: AR+sD12JsUrmSkUFTAM5D+SYZn3dGW2lCs+2EIb9VwwAujqq/LZ3FP8ptvpjNzp16vE
	NaktHBldx41Pzk4rl6ACRHWwSw5OuviZCMjkUDjai3wxVrDw84zNSzmOs6OzA4dkUPeaMu2VZ+t
	CTpYEFR4doiXFHRl6vfvDIg+FkRnDHu4hfZqpds5oinbqYBzdh5PyzCyJak81JmaZB9AX4Ya2qL
	ynDUHUoeSbVnBQ38MYzlAIN3gk+a4aha5Rk3jUygiUgkAPBbkLxH39JvR5c2Fhn0l8PkSJvJaeG
	FMt659x189UTyMkTHcyuefT1r13cqWCHSBLegayTGzsn30whV0xflbABid8VHrZ8xDrta6P6Mrs
	eEULLrN0mf4Vu9v2wfcoysskyKAbhXN3b8sqHlEUiDMDwwQqJwdVA6bAhpI5TTu5ANWwOK+eUd3
	xwE6H4dZFaW2tEaHiPFlDc3Kd+wIjNF/7YQZD0h34kCkyreQWlGwIiK1BWXpC7j9GbxCRbci+Cy
	nwawaJLk3Qg1EneBKPN6ZU3qUfclKW+J+taTexBfAgODfV1Xg5t1zbTlQfoZQVx5+tNTC2j9PYU
	LgFnrmNQu8cNSHNlrNi3MEDdNd6olobYedD1jmk=
X-Received: by 2002:a17:903:9cf:b0:2d6:ff5f:eeda with SMTP id d9443c01a7336-2d74dc3015bmr59321195ad.6.1787874234232;
        Thu, 27 Aug 2026 16:43:54 -0700 (PDT)
Received: from localhost.localdomain (2403-4800-2450-5401--2d10.sta.dodo.net.au. [2403:4800:2450:5401::2d10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7594fc349sm101045ad.10.2026.08.27.16.43.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:43:53 -0700 (PDT)
From: aslan.jnn@gmail.com
To: Simon Horman <horms@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	netdev@vger.kernel.org,
	Thomas.Lendacky@amd.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2] net: amd-xgbe: support receiving packets with bad FCS
Date: Fri, 28 Aug 2026 09:43:26 +1000
Message-Id: <20260827234326.72730-1-aslan.jnn@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260821103924.GH265046@horms.kernel.org>
References: <20260821103924.GH265046@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Simon,

Yes, I've missed a few things on my v2. I've taken your suggestions into
account on my v3 patch here:

https://lore.kernel.org/all/20260827232220.69907-1-aslan.jnn@gmail.com

I've included your suggestions there including setting my "From" config and
reinstantiating the `Fixes` line. Thanks a lot Simon for your guidance and
patience, for my first ever submission to Linux kernel! I highly appreciate
it!

  James

On Fri, Aug 21, 2026 at 11:39:24AM +0100, Simon Horman <horms@kernel.org> wrote:
> On Wed, Aug 19, 2026 at 07:16:56PM +1000, James wrote:
>
> Hi James,
>
> I think this warrants a fixes tag
> (no blank line between it and your signed-off-by line).
>
> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
>
>
> net:amd-xgbe: discard rx packets with bad FCS
>
>
> I think you may have forgotten to update the patch description
> as per the suggestion made by David in his review of v1.
>
> 	net: amd-xgbe: discard rx packets with bad FCS
>
> And, some points on process:
>
> * Please post updated versions of patches
>   as separate threads rather than as respones to earlier versions.
>
> * Please make sure the author of the patch matches the signed off by line.
>   You can do this by updating the from address in the email. Or
>   if that is not possible add an extra From: line at exactly
>   the first line of the body of the email.
>
> Thanks!
>
> -- 
> pw-bot: changes-requested
