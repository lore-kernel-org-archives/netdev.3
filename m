Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD44A49BE
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384616; cv=none; b=TYcjjrZidzIKT31W3gKqN9n68ji2EKY7JvM6dvt5bIhgtokoIiHxXAC6wyBVgo71SDQEvbkpWdKwCdgR/h+Cc/sBnCVTiHap/GoC5kwPPVmjzXhWjEJvFTiFNQRmeYRLFOvV5GpDjSAFz83Uz6ZHfdHfPALKheEefhOuTffJbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384616; c=relaxed/simple;
	bh=DtLW2TlvpGvM6hV7rxhC4fpV2L2eYZv026J/B1/JswE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=e9/QQgsEjWU5YV/YeEIjS2/UsEPqe/s/4FWnVynUDURKAM5z0PTkrTlIlFc2YJUrYSfXFc73y21g5QgLrO28sb+DvIuK6pSvRdMD5bDRKbtSCsZ7plh/dUC6kscRaLnFe7tLRY3kGHySdnOKmCFMCjYXXsL+8W6tR8zwSAbd6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdz264Cp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdz264Cp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8a83d2706fdso35187237b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791384608; x=1791989408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R5S9y3rm49FcBbD2GVDr+s54p4RcgRdmhC0n7fWz+ME=;
        b=fdz264Cp2G8Z/ltyHdIO0aIQSkeYspGBR3kVFF/2Ks4+3YFIWsJUI3x2KlmWnf6WP0
         U8wXEbRCDfzMAsfeEvwFQ5xWZItwAvgSdXUKQ0wYqIfdGxsOsNrgdw+zz/0UlYDrUK+b
         Stm1zUFuHsKeYuXlHG2GrHdGtJGorQ3XR+2eWcSTquM0th9QDNdubXg9omqhP+02gsgV
         9hdcopXhkdgqWXuU0Xhu/S5vSqbRTMDR98GodN/YHgaLNZxdFfPS6ps5caVe+3b/gMQz
         5Nbr0ObPecxrNhF38cpixnYcnyaoD7U5GbHbnLcGlcOjNUS+ySmWHzamLhT480F8aWu/
         /hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791384608; x=1791989408;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5S9y3rm49FcBbD2GVDr+s54p4RcgRdmhC0n7fWz+ME=;
        b=eaCBYQ4jbJImG36/O5cxEKSgvR2Dn9dvLy2XXnKmB1RE5lDaGbc1QJpcwAbTqw15eA
         19SQh72pQcD5kbnQIZUlruR7LdjVJlzcp7q9LooJA9GRuU+3+RUaNnaYJQI+j2SC0aSP
         MjPG0pr/N9gOusCs/WzovOCu/NVfcMXjSmxZlUvKsmw0ZfLBeT4G0hxGocRXXsuemiBD
         6doYO7NH1E+doNLuJkerDOcArP1YSfIe7OCfxDpNHSKK+bTD5DYPsiMMSwtsoVT73xG7
         Jb1SEAVCN9OBYXfWyRcVeaAOd3c5fLG8Zf3/f4aM4jnLopRueONgZc96wxtQ2Jr/p1Gc
         GKyA==
X-Gm-Message-State: AFq9FYKKzk3fEaakXccKIMB6NdWsBCEHkRd0LT0kpx3djaK/r7NzmaE1
	GwQ/CdPrN2Bau7nSH4DA+1ZkaBXyrlfEz0ETjpbvaSz2SDjAoCBd1E+V
X-Gm-Gg: AYBFou3vyDRDFlyrOfxN452EiG3zAMhZbPhxDXJck3j9jEfhGNgRYVbyw0cE+blhizn
	Q5qqCCt/U5HHz89U2voFg6Rd89XoWBNgehz2MrLr9iVDiOL+1KR9+VB1IJc61xhgJ4mH00mJn+A
	3ZIDDjVmivBs9r777wOY4XiY4noPMXYrOywYElboYSRrdL9mvTmHLE3xqiG+EhhZlKOaa0zaqYd
	X3P5KkGyLwuC+yjxoYxfwpqWP1LE9lEKOwCkH2OR21tiotBbCB25CNmGMi8jZQYYANWDnheXIVl
	u7FLxOcdyXOL5SERJZgmzShF2RCueR6h2trmzQjgu7pebnvZEZ4HV2TCiBDHsNmpwZxQ5o9tSIA
	UeVSvd1K2tHSHt3GtEExIm07thwE6xj78l9ocmb/8iqZ4mkNLhxHhMb9til/xBodB4GyoFtlxB9
	ih+Wicw6mH63QB16lHOd2DxZVlO03heYa2PfqxoiYUe3891Y+CPFdTqV/kKKX7qpNCvtLIEFnBp
	ycrHEOSZD4O73m9xet1Dt4gNTRQRFjA5JMDaA8v4x1FZ4InluaeEcyVNQ3hJM8tjznPGrJA3ypA
	jgRkLfYqC7k1LpKxGLNDQXIKpsETHk2sdK2VCg==
X-Received: by 2002:a05:690c:3481:b0:8ae:c3f4:3da8 with SMTP id 00721157ae682-8b05b172ff5mr16418657b3.85.1791384608412;
        Wed, 07 Oct 2026 07:50:08 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05abb8b72sm9302657b3.34.2026.10.07.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:50:07 -0700 (PDT)
Date: Wed, 07 Oct 2026 10:50:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.235bf1cecf85f@gmail.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
Subject: Re: [PATCH net-next 1/9] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Josef Bacik wrote:
> When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
> after copying only the linear part, and the rest of the caller's buffer
> is left as it was.  The callers copy into a buffer that is about to go
> out on the wire: an ICMP error quoting the offending packet, or a
> driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
> is zeroed beforehand, so whatever was in memory there gets sent.
> 
> Zero the part of the buffer we didn't fill.  The checksum is already
> wrong in this case, so the packet still gets dropped by the receiver,
> it just doesn't carry anything it shouldn't.  Only zero for a positive
> @len, a negative one from a broken caller must not turn into a huge
> memset().
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This should be a stand-alone fix sent to net (and stable)?
