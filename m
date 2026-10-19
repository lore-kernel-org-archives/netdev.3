Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422558;
	b=aZztDolTthiVuZS3PZwY9fbZrvFF4QezpezDVLc+sHwMydYz6TUGlVjAC0vCUiMwJb+4
	 ISmJCeC3v4p1yXs3PjgkF4k5nXbgvUp5/0fCkZZaKqQP17oKnLXXJdUTPDRCn7hrQgiVL
	 Bsq/RKlwyn8J80YHP3ZWTAw4zLt/OfkfFLiFU5u91lxr05BPGEm1F0oK6SEoAgRHgO8RH
	 V7zpWoHDTpT0iFH/SWpQ1vhaIP3JOI2+Qu1fvSWVsNu3T8WlDUXm8MtgsIsBeMu7g5UKl
	 5Ae1CdzPKo2sBuSinjziHtA44HEY/+trATZ8XCLaUBg2WnYTeLB/QOremH9/YRGdcTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ddB4FacqIQ3q4kAqUUsX/lS6szbTGftArKoCUpP16Is=;
	b=q0HYZJE5Gay8OdMwQPyN/i+pywMXeOQOPW/qfMcK8a9cCU0hQXok846YkUUM2GCas7rl
	 hp1BQ/3thrjBTpLJlp2r2FYF2H3T2wQ6O+viyhHTb5CyeGnKB4M9V7xbaUWUywVcQx4vM
	 j2xt3P9JQE5/A5cxMWt9iENWzoH2H9cu1iAATj2wi9JejTcvk3e9NJboWq8P8T0HloWhf
	 kHUf29OnBPNpiz4TOtLQ4lurBn2OaEqhQYUy9T7hygtA8t8a/vplVZcupZcq1nLd/Qd0r
	 MpCyo4qk2RDBFUeZ0LyrskqEozdfg2EYN8u7JnJ7ZJo66n+vu+DAYjdT66y1OuJLaGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PQX0gmjX;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BE608607E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 689BE608607E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PQX0gmjX
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535a54bed9so3060405eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792422557; x=1793027357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddB4FacqIQ3q4kAqUUsX/lS6szbTGftArKoCUpP16Is=;
        b=PQX0gmjXqloOScR31IyWgcireQx9fQT73X3Zpe08XKJbs8GqVMJ4KNbjN8+L60KuXS
         5Vk10qFz9nXu8jDZwILHl0ivMfQSmgPWmV+ssVfeRAfCsvf6J6Jkoq6OHAfEpBSUCAgU
         V45rL/7HO/YKrsqIyxvZwkaJ2Meo12GUZ5zSuKBZ0eSiuBjPxy4v/VSaxclARSLcXbxU
         deApW+wAePATk/kvUdSUJYGKE/9RI9ssbaDtNOaFOKM7Lc54fLOx351BxdQT7Z3/rW6f
         JCzWV9sfBRW7hpFcyPi330cllnO7OxWGT8RB7z3YI7SknpDdFHJk3AcJyaZlZdP+AprG
         PD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792422557; x=1793027357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddB4FacqIQ3q4kAqUUsX/lS6szbTGftArKoCUpP16Is=;
        b=NkK4bvHxH8DHa+vK6KAmI7Abt817jWzKFdy9cXdOUiy3x6Llahks7disCQrx2pVUp5
         jlEwefZDhV7o0BlkXxxuOLkH5ABjtjwd5j94MHGO/1Sn0/KN8FK64OEHgNaXlhzsFQ+O
         nDFlrs7g6lcXEhhrCMk/o9pquLXQIHbhwvSoSMEoGBO045iBJy2k0Bx2psY3RY8EfmYv
         2awf2KsPOAl96WnBGfqeUOa0pnMhAxIGO4gWwDJnL3CTzienS9MuIwua+99WhWuHvhY9
         Vh19qWQlU3Gi1GoXOIbNTSkT8IzaUI0bEmiqM3GjOQBoWREkgmPX0YEIiS0foFcOHymI
         fBkA==
X-Forwarded-Encrypted: i=1; AKwUvBwdANkeu5YgR6eaEKc1trWAZx9k791SdgebDEYrXsynl1jD+mcDEiixiCmrvyT5N8eccJ0knmY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1zmYWL+kimJh2pyhxH/7wGbXkgs/PeVwb7/PX+AjcBArsSZZD
	oi8HJUWva/ypD6VjgbE4OB0aeVB5D5ZEIJ3jBO2JyjT0Ib1zkRwkNGA7IsSZtQtl
X-Gm-Gg: AYBFou24JtpV7t5p4c2Dqs4EZc7uCvr/Xm8RXl+OAnnvqFg5ffwK3AM76QlfB1rZOLp
	Q8uSu97VKXgpGCNJQ2/GYgB6WjGnuOCuNTn41JQ56x2JWw5ngAky9kjZcMusQL71HMC6CzFTI1e
	/yz9Wwdj74aKLCFwXKX3WM9Tt15maPWJiwlGc385qt0+t5+qpoGNtg627v5AWxfB/j9mLXf5SVM
	lZFriv97wi1uesPM4tzmrmBKpnvPMxi1MpUXTcwcph64wo8qACLbMEkgzG5DWqSNhAnLtQCfMoM
	BqQrOp6C9/G7KzJREWQP2441tlL8cB9bpumBVPom+P3LuaBH2tn/kApj4PTSLOxU2yGhaVHAetj
	Ea91Glkwtx3KrhT3P30/kZBgPoSmXblRscJNajWjJTA9z0+ykoEEJoy2fVAIQQDr6eoJjMe/pXU
	uFz9f2yniy/hJV89Gw7sQ9RsQq+DJynKKyI9QTFRfs1pmNJv//jvOqpZ9kTP7RTBWPkAAyUAQQR
	lzmAa+7wVM7SxK0Rh3oLRU=
X-Received: by 2002:a05:7300:ea8e:b0:360:c266:cdd8 with SMTP id 5a478bee46e88-361a1f5679amr10624281eec.24.1792422557361;
        Mon, 19 Oct 2026 08:09:17 -0700 (PDT)
Received: from CHANDRUS-NITRO.localdomain ([106.200.8.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm34680599eec.7.2026.10.19.08.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:09:17 -0700 (PDT)
From: Chandru Gopi <chandru.gopi.dev@gmail.com>
To: maoyixie.tju@gmail.com
Cc: alex.aring@gmail.com,
	linux-wpan@vger.kernel.org,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	stefan@datenfreihafen.org
Subject: Re: nl802154: GET_WPAN_PHY dump resolves NL802154_ATTR_IFINDEX in init_net
Date: Mon, 19 Oct 2026 15:13:22 +0000
Message-ID: <20261019151322.8175-1-chandru.gopi.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920165057.3753458-1-maoyixie.tju@gmail.com>
References: <20260920165057.3753458-1-maoyixie.tju@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 00:50:57 +0800, Maoyi Xie wrote:
> Does this look like a real bug? If it does, I am happy to send a patch,
> or to leave the fix to you.

Yes, I can reproduce it on v7.3-rc7 (58161ead29e5, Oct 16 2026) in
x86_64 QEMU with two mac802154_hwsim radios. The lookup at
net/ieee802154/nl802154.c:584 is unchanged, and I did not see a fix on
the list or in mainline as of today.

Setup: wpan0 on phy0 and wpan1 on phy1, both in init_net. phy1 is moved
into a fresh netns with "iwpan phy phy1 set netns <pid>". From inside
that netns I send NL802154_CMD_GET_WPAN_PHY dumps:

                                          before        after
  no ifindex filter                       1 phy         1 phy
  ifindex of wpan1 (in this netns)        ENODEV        1 phy
  ifindex of wpan0 (only in init_net)     empty dump    ENODEV

"after" is with __dev_get_by_index(&init_net, ifidx) replaced by
__dev_get_by_index(sock_net(skb->sk), ifidx), as you suggested. Both
cases now return what you described, and the init_net baseline is
unchanged. No warnings were printed during the netns move.

I used a short static C program with raw generic netlink for this. I
am happy to turn it into a hwsim-based selftest, and can put it
wherever you think it belongs.

Are you still planning to send the fix? I can send it, with you as
Reported-by, or send the selftest alongside yours, whichever you
prefer.

Thanks,
Chandru
