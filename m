Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29743164BB
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288481; cv=none; b=bygvwx4F2DrHMIPfgnt/ZzsWwYz+3qfVjM2hUigZXPjU2bR+dBMKO1qPqY1BLn9bFpPkN8fLDLrDOuz+vWye3GK6nn6a6fVDv0HNKiPjycIvShlhpguzoi4hbxPM14aQNcs4Ur+IyVcY+LxTcTPw+kVFGT6pS2PfLBC4WJZ/HRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288481; c=relaxed/simple;
	bh=ESeD/ZAXmJY59zUgjORmhYeio5Kr8jPgw7HiOlqo0ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOvXpyghOGU7uYMSJNq/pGHD4DEhmnYtd70bZ2DwHkZeb2Hd1Sz/cA98Sbg/ID6EtzjWIWAzZx31XFdUmnnux4aUA+ZAdHVL+u+be0NUCX0W5N3zBegJqTBlz+GplpYkZvHVdU3sSj1j+YPMXzucGjtk5E6TaDN8wUI1FY2RnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=oYD8KUe6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="oYD8KUe6"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso1582217a12.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792288478; x=1792893278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ng0CE/gjPTE+OIlSfddS/+J7PTYfSFF20bemZKRWDt4=;
        b=oYD8KUe6KJDoXciAtxuF/6+4gh+2ihWLWkPCqNHeBC0g38HGRiWAp3veyWmM+0k1aA
         e7Dqrg+3Nl4QkrxKUO8UxpC8W6soE9RBKhiiLhkPM4GNfJ+1HL4MEJ41LcdE7htHlBKp
         rktxdzaA1KxUQIAvhlL8POMB+VmeYe1xmz8nfXOZlK+l3IZ72Hn+FnHKG07rTn492k9E
         GI85GZNpfGVQ+wvxkk3R2zvQFxVOAPV2YrgZ8aTHapDIcs/ziNzzKVWlXnxX5jFfz+G/
         ltVo2QAJ+ZWzAnSQB0cnZk0JQrvHfuwcZ/k2j6d44VieDtd31Imp4wsJastg7gCgHpq8
         CZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288478; x=1792893278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ng0CE/gjPTE+OIlSfddS/+J7PTYfSFF20bemZKRWDt4=;
        b=OTR4zhRwg8T4nFoxRRKbTZ8+7mjs6TsR7A3Y8iXdlDEW+xbDH6OLiW7m7mmLjis8ms
         02gazy72RT1ThmZx+i2siZrUmMRwodyS4wVEWkBFgI0p0ul1suvqhCLYBo3IVEutKxvM
         MXuTqjSkC4p3a9Hg5N/8A+BAIT/k0ple9OphEyD3CH1eGVeOKhLAu3Z7Ry7daosgCRxc
         XvSJHoBT+Ywv7Z7RTJMrfkMAgFls1FxTAtFnVv1nFwTh0WJ9lhrsWTIz8rLfPw7iNH96
         MxZnftXFlArYhZk9SoCPBRy7V5n3/DQ667x2Hc188FI5xsHDFdh6mB/+bVGOEOl1aWen
         MLiw==
X-Forwarded-Encrypted: i=1; AKwUvBzyR0uzMG/sRxcpgejUmTax9zNFcBLSfwa5mYY7SlEdhX/DEWzk0ZgPMnYfjuCceXvXFeFHbmY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLygZT75zp8wt6cDatOPhoLzId2F1TkCxGwysdWa1SzuPKDw1Cy
	5yvcelt5pKIO0b45l1GG3WvlaqBGOLfpVCkzJaxM8jpGJLggspr+1k/vTnVHGvMzjQ==
X-Gm-Gg: AYBFou3hsBlbBdEMImMhaxGGeFHKWicYxuMquq4vzXEOMYpSL5zUClqxQXTtYTrihFf
	3x+Kh+xQEdoy66PCwGGMqv9Lt1IkssqsKRc+yG7oAFfKqsRTGdZ+WP7TGFtZq90/VyNP+2HTyk9
	puEK8f1hqScZV48cEi3JjCxmqoP1HIZDRbMvmiGPSjjto2SfMXc/+PQTlnQD/QUvHPoLOwOf3Zu
	l3x8DToVgdLnDmUvxFj7Pj7Gl/bw6+ZFbZcG4MeWY/w1zak74tOZl13JgzFpud7e0A8cMvmufb9
	yAE1OxXRHzttgTLJt+osOtfPycZhKDYeGDPH324NT8wW48nnxhLGdx95c8u2KgGHoBP+oSNHCC6
	szuihP2m865+Ti5mJhCUA1giBXbEvCCb+Z1GX9MTrid8QUwTTu8ktzuXUudx6d6mOc9vcD2DRhQ
	L2uSfusTSk3CD5rqvfHrZmb5d5DcD9a6XFJng3Ct5AIRvS5VlFuBzXo/92/WJZpZqkcNkfNWxPH
	u6q7VAYrza6q0gr9d4n8xt0kdtqgD0IDqH9zeY8ShxI8TSqDH/Yda/uYyKdR2JD4cGlwfrwKtJj
	oCcP1pOj1XXTf6Jbbw9OHeO6L+dboy1wGZPdJjVTfcW8F/Irf+/e+vq/eE2lZE28vhm+a28VrjW
	C8oH5LGFeEG0rKH7ktfDMesOupPbU9fpr0uQ72YVtf39Fnxfh8obC5Q8ws34iK7lhtB4oNeqlgT
	HG17DfbXbY1JMTlEvLwE5Q8cm0LEb2Ybp4OJRm41on0ELMLPPIdzj6zXmsGQtylSc6thg+rfasC
	dxteXp/
X-Received: by 2002:a05:6402:2350:b0:6b1:d8fe:52c0 with SMTP id 4fb4d7f45d1cf-6b3a81c05a3mr2284727a12.33.1792288478126;
        Sat, 17 Oct 2026 18:54:38 -0700 (PDT)
Received: from Desktop.fritz.box (p200300f247424f103187cc9af620d661.dip0.t-ipconnect.de. [2003:f2:4742:4f10:3187:cc9a:f620:d661])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1c7ff2sm2390429a12.19.2026.10.17.18.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:54:37 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org
Cc: netfilter-devel@vger.kernel.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	geldot@protonmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next v2 0/4] netfilter: offload a TCP flow whose reply is never seen
Date: Sun, 18 Oct 2026 03:54:34 +0200
Message-ID: <20261018015434.3326758-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004171628.3544978-1-julius@bairaktaris.de>
References: <20261004171628.3544978-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 03:42:58AM +0200, Pablo Neira Ayuso wrote:
> This series are a no-go in this approach.

Understood, I drop it.

> Please, given we are discussing one series of you quite recently...
> let's handle one thing at a time.

Agreed, the fdb series first.

Some context on why there are so many: they all come from the OpenWrt
PR that adds flowtable offload for the Qualcomm IPQ807x PPE:

  https://github.com/openwrt/openwrt/pull/24806

That PR carries the kernel changes it needs as patches. I am sending
them upstream so that OpenWrt can carry backports instead of local
patches.

I know the rule that there must be an in-tree user. The PPE driver is
not upstream, so I only send changes that stand on their own: fixes to
the software path, or features that existing drivers like airoha and
mtk use.

Julius
