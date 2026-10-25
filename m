Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966946;
	b=exj0qBUzmSoQLcwoIyy2yG0rdaDIcYoRyqtBhG6AjdIHAZFomgFRksqREDzC1oXFoo/l
	 4G+Rx2A1MHpuMbDLIIqFd/q903WYFldUOtQvu4RO818SZdSk5egXsUZqO/aAR/fQOzrOW
	 EhN0PKLZObMVFeF1pSZfx8UCVPF4ZoviwriKnJ+rRbaJHQ2UKoETcmkcxYhphqHdBL/zC
	 H9UCmJGcbn4JSqAORae3HBNreZucf+ZS4wQnbd/vqe+lLWp/JfRQSVOnh5TdcIpBYAnzT
	 MVdiSbge2Ldo85alLFzd9UnPc94rAP47f8IHQWaYgE29az9oUzxVxGXJLcyG9MQ5Dzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JHklEn30wJDLqR8cfRWebRp9vStY4nLqfgGh3NzvKog=;
	b=inVwV6NWUJRbF6it5hbOrCY1Omr7JhhIXFVqc/5quSIbUiykxNh4Ekty/LlrUJlmSxbt
	 xvXGRsZ0RfWGqviZa9jcGHrl736mJYHIrB0Kh6zSviRU1jQ0v528msx+ibMD5n8AMXd3e
	 GGeSIw+i9nGkOgTwcxr/65nhXSpDJTfpn9fkkJ4lmrMZDxC+kwv+HmYDSP2iCIx8tcL34
	 J290SbHF+oImKNV9ORdbtlgoUjuNSSaCOQzMkpKW6hZ2z4/8BCrALlNNgRl77vSyyfiJK
	 lwtD/ll4E2k/oJCRqRYRFcJLAX7R7S9f9zbFoGbwfBAVLs2PYMmtQT0a4ptlXTReSOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XaS8sTxH;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF2606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 22:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XaS8sTxH
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1871313f8f.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792966944; x=1793571744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHklEn30wJDLqR8cfRWebRp9vStY4nLqfgGh3NzvKog=;
        b=XaS8sTxHo2+xHpwCMV1K0GQnO6/WX4opGfkaK7URg32qnlsMedOETS1m/jGTCniFZm
         Z4r/jlNUV3FVT38K+somkS0q80z5VRVbH0TV3tUkRo/gSjspQuOOrZ6JQO5jdYNANgev
         0EmfP8A9arvxFjvD9pRn4ijJDRyuMZYxSC501Qz7D5F6tGvyB77kQXOhn7qNf1Gw5CoS
         o5T2GNO9wbYKXh5yLDxTnqApxkDPj0gIqgdoE0RPmz0N7LV+uV2ZpxCz/nVQ3NYpq2CK
         vaYzr9rBeC16R8SL0/RAHGyGD3twD0dJosB+bfSJsIb53VQWoch+AZznGlZjodIg+hyG
         ocYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792966944; x=1793571744;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHklEn30wJDLqR8cfRWebRp9vStY4nLqfgGh3NzvKog=;
        b=qz/1HRtBO/x6vV5PeMwOOlS3l2tjRh3XKlQyK6RUqqz+95JW9jVRtIkMLimRY7K+We
         LsSKdW/t4iA4E6WFjAv+J/ix03CwmAx2XyE6IfNR+XRjNk7/mkqK6sHqQeHdofXJG2+2
         RNHhaiQ/HNCt/fz3AjRuWC/FAalzSGvMzMnwy3XDVVtuNfTyml0yC8cFNf2NXxokAEyu
         XFWJeDRCN8yOzUvobdo7xy8e8QljvxqWGLCvIc/tjuTgDgrddDbm06RSOoednni1dG0x
         d88lt3S2f0Yz118APg3ath7YEcp11J4yI8/v3CctPDAmjg82pMvh4s/agGEfffWvNXu9
         VJqA==
X-Forwarded-Encrypted: i=1; AKwUvBxhickvjZ+sg71NxuY7L8ZlSCk+EtWX1tdqtRH1JEjh81DJsaZJY7XF9D492wuG6sO6wdpqKUo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvSwcYfmTWc/HgZfo8ggCfpoR/RnSKbvxS85g1kcup//lchVwU
	vBWZ06EbR/QWeS35AKCMgilAcZKUeboPBSWwt7ytk4GSjXpNYLUYfC0=
X-Gm-Gg: AYBFou2jpz3wli5GRxVWrXjrq0KoVZUHPbF4bsf8nKgJPTzlphPpQJGK3znAen1Qtil
	409r5GUJpiCi4VGaBRlRqtvEhzXzJ7ihfSOjvGADjcsJhjYEFLNKLZ5/P7lyCtxDgMekCuF6O/z
	GPMxRR5pqVd1By2xSOH4T62Rh6ho7/sYnU+lQMtSDINJIr8bX8w9fMnqSNrwIQtOvx4DdpA7Okv
	HEfE8fBqN8yJhW+y4O274aUuvsw+dJSzvnJyH3Lnj+Kd++yghlb7iNtdj4EO2dCesm00a2C2qcC
	qYOqigtt2okJ3EiMuulznjNsv9U7lxh8HqO0JnHSwUeR7iOzO8UAFTUVI53XX/YqWFbFkmfZWHd
	RBJEyouBcDgHi/UoaMj5CVfDe87Up5pCLVR9e3/2CUWHdETdQc+0GHOgQh6UKcjdK7fDp5PXCbx
	I5pb2XOjIEtb7e4/cT8HBMuKB4H4l0Iy2TXTmdaj7f4YVOXpXLn/x+gMU1BOaKL7KbWcyZ6O5Pf
	fnpyzxhUbKo+f7mFfMlWxfkbNrgG9wyGJyl4Q==
X-Received: by 2002:a05:600c:8518:b0:4a1:a49e:a925 with SMTP id 5b1f17b1804b1-4a35acebf0bmr87766305e9.35.1792966944266;
        Sun, 25 Oct 2026 15:22:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3da7sm13306612f8f.20.2026.10.25.15.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:22:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	david.lebrun@uclouvain.be,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] seg6: fix tun_src RCU lifetime on namespace teardown
Date: Sun, 25 Oct 2026 22:22:22 +0000
Message-ID: <20261025222222.1064464-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179278529389.3327.1530536500905686255@kernel.org>
References: <179278529389.3327.1530536500905686255@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by manual code inspection while auditing RCU lifetime
patterns in the seg6 subsystem.  The issue is theoretical --
found by reading the source, not triggered in production.
