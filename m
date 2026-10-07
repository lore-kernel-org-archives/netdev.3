Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F1430CCA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397556; cv=none; b=tVohH37XwB69WGvVQzotbZlZhE1AdqyxFhKXSHG8il2xEWzPi+yIE3NMX242d4CBGRJJXjTO3L/HypwNxEyMauDLCjE2OOiYAD5BEs2eaI5+M+AgRiEj3EuEWYM+h1v4P+ssrSCGjY2h2fHxiAv4h7Jbb9URkyN7RKjRuc0W73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397556; c=relaxed/simple;
	bh=f7LJdPPGst2ABs92k8Y6jLvaVz3FtBc2OPOggR7SA68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPvbbnpP4zJlMScL3NYWgbAsVUutHv3hrh5CwSKXDeRKWRt1xfnMYs74bTehgBuroecizzW28d2z5DJFCGIVk0nH/dHqN2A3q6r+zpwVTLVC8nn7F+M4R3WvTaX75AfjJ0g9jDzMunsAwwD1Fp7CeMsbaffEKNrP/vwHGFFzviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=arjY9/+A; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="arjY9/+A"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93cc31c18ebso132227185a.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791397553; x=1792002353; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oBM/k3W16ZFa2deUK8cxyFeMvcY1i1trfri8zjFob3U=;
        b=arjY9/+AY0dpa26u7lqWEUACwzz9Uwp2AB3yWYLNfMjRepiN02R3Z8EE97/KXMfIdV
         b3WnT6Yu+PS78L/ZAV5OWPMf9+JVMphp68mhlFGcm9voLQQYqu1/iVgAxY/Y6NAojx53
         dwep0EyVBmHKgg/1+TtQCRboJwNP4XtY7S2Sb9sAgdeNo3nr3zWY04MVC8eblTGJaqKt
         +r0fOtRAPddZZQEp7vQ00z3dqV6ayv5mZiQwG+LNGEmWI+OwvJKr81ELSNo47Ym0DBRI
         1A2msykTh0eCKUHbe4IWZp3pV7lwCGX73wbfnBq3yzLHg/rOCM46uuCNgH4+xiRvxQZL
         Zmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791397553; x=1792002353;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBM/k3W16ZFa2deUK8cxyFeMvcY1i1trfri8zjFob3U=;
        b=gvS5Acv4H/QNNub8Lj9ApzUj/nDamsWZlh2HyOlecvnq2mbavYjozBXTBdTHV+/ACf
         8ZbQGcRUxiL+heK13hvQPNepAxOnunjUrI90QcVWfssjG+t8lr+XLSlVXg5S7IOHJiBz
         nHtl5e8Ctc8Kj2LLS5ZQLBhdQqGf34/YTVKS2S9xanmEndLHxkWgLkrDSH9xa/EFM+6o
         HHBwWfU9a1oY5gmZPkMeNexaU5LtWZ4osG4kq8DB60iZi8iUQ/uWnLXuga8Ck9JyZ+eJ
         tw1bR0PLNNWstVSrvoQM8hj3VODMmHltd09Ygb8GY28vfUaWqfLapgcW2r9qpzPwyRMa
         fWSw==
X-Forwarded-Encrypted: i=1; AKwUvBwdZkSAgk7yQi0kaF+CY+Ot/vSqx53bcxeyHbhcgOwCp+hLyTjLMZC2YDKdjbPd5lrRTavgb40=@vger.kernel.org
X-Gm-Message-State: AFuF++lCws0KR45XKLLkH6tVzzqmdAolCj7bK7xMfZDu5YQ/BzzYFZnv
	NdQ5Lv4UlRFrAMPBJ4dvAGdglGhDCYk21QV3Bc0B1QvfSHtenkUhi8hmt5lwWybD3eQ=
X-Gm-Gg: AYBFou2YY/jCMItFcAh5LKweC6hsJBcwoyZpdlW6Ts7NxvVQEQNtSIScvhlIATqHfrR
	ZOz1F6/C8pzDK9ItpjpqhcyUw4mLV/oDcX3HtgPFlLViWkfksFCm3aKC0O8E7hsuDySZ/Mtnp2f
	X9yVdlHz0gyKevb6p259dSmhPLxGA45FvhM1+Au6upSIksOcYRAgOy5K4/rV+VIoEsBpoIRFFP1
	AkoayBVjxcy6h+39RYTyXnz7pMedS8TZsiNdj0OHe7C8FBOmkcZpqGCo11B5wXRnSt8iGIHz7Ng
	aMBUuLxj24/g8hMrgZJBsCmVYf3bTpd4SeE+Qwj8s3CF40NsdNyG8K5/XpG/zXpOmz0MnuYMcmz
	Fzybi+opNJ5xHf2LlR1fLs5PvM7eGM5tB6kpL+al2jtXO5JzMiQtEPH8NpROQAwbj6iqac1h5dq
	bNC1uMpLvBoIiUls0Dzz4g4Qze74AlbGtuXIILDGXjyoe/HGJskE6QDXybFwlkbInUSgaPvV4rM
	YyqLB94g9RCt7w=
X-Received: by 2002:a05:620a:84ca:b0:93b:ebd8:9147 with SMTP id af79cd13be357-93e9b71e80cmr544420185a.18.1791397553212;
        Wed, 07 Oct 2026 11:25:53 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e99157d6asm278314085a.23.2026.10.07.11.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:25:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: netdev-bot+sinfo@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Date: Wed, 07 Oct 2026 18:25:08 -0000
Message-ID: <179139750821.4.9072526328443780658@toxicpanda.com>
In-Reply-To: <179139448190.2527009.17897220638829712578@kernel.org>
References:
 <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
 <179139448190.2527009.17897220638829712578@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 07, 2026 at 05:34:41PM +0000, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Found during development.  I was converting the BUG_ON()s in skbuff.c
[1], and the conversion of the leftover-length BUG_ON() in
skb_copy_and_csum_bits() zeroes the part of the caller's buffer it
couldn't fill.  An LLM review of that change pointed out that the
existing unreadable-frags early return in the same function leaves the
buffer unfilled.  I confirmed it by reading the code and with a test
module that marks a nonlinear skb unreadable.  It hasn't been hit in
production that I know of.

[1] https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/

Thanks,
Josef
