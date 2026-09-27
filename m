Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15335C190
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790484108; cv=none; b=IzmP/cSssnEmn+L2Lkqce5aOynDS0EhIXLrjbmNp1dMY7WVIbtAFXR5ua3WQwEYU+XYY1pSMhEWHwKE6HvSkCLpf8aeq3YRp9x8shdlJpYniE8dOeKtR+cgh5+hsycbuHocHxaopyTowruVBKLnKYM3M7UIJJv9vMzq0zocQktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790484108; c=relaxed/simple;
	bh=aSIQliU8fMQFvFPepj6X9dk5tV3aAChq7NCseb3A15w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ivvtpyFG9jxhsGUIrDs+oUpicExpz6fBeBh6lRl4i2I/rZIH79YnlKUHwLeXLU84wRBSLA7n9i4CQmE+2NEqGZ4+df+bleJhFW9l68PMxb4jMcbbpS+QOHse+tCv3z0i683BNRqDdf1M5C6DBJMCB9+Z0+zXXnWC1KWNuwr/Bvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAiu+wus; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAiu+wus"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so905669a91.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790484106; x=1791088906; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aSIQliU8fMQFvFPepj6X9dk5tV3aAChq7NCseb3A15w=;
        b=EAiu+wusG9A/Tb9WV07FSVs9/QOiRuBuLBGZ1VkGsKhGwZCHrYYOeYp3RteNwYJ+2x
         OrW38fpkrNHQkPL3UUCzLi7aSLsJtcX5GtdU41+Ib8+oif30+CWB0r/ARqeWMU/O4usV
         4eTnwWl42QsRVVrYVtnpU0bx6gZnquIKehQtf1Y6QPiQfsGx4zqju5rr3wNDBLZ5JUo3
         ULiijcIWVCfAPMZWeFP9QA6LaF1skgua2++KoXNKf/L8K5l3RDTySZ7qwNuCE8lX2+c1
         pvGF06LvqsqUjNF8tyi91kmAd3agOpdS1VoQhyVKdly79n984HlKtPpEX3tvqW5wRBU4
         XMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790484106; x=1791088906;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSIQliU8fMQFvFPepj6X9dk5tV3aAChq7NCseb3A15w=;
        b=RupzoIe9rXu/u4d8HxxIFALy9BE31UAA9mX22fmpMtWIesn14Xx/4ojvyrCW5gc/fs
         ia13lKof1nbK6MPt12bGry3u9+z3NNeWurAY6Mp/hv530q9cBOrJegzNve24WDwb+k74
         dXZykr+spirnAyI2LWT4XsGv1QDoLu3zPDWOs4MgmquPLCD6c+L0wkDJIPFEjGJ73X7r
         GW+KKNZL+rL242EOf1fHecJO0q83C2fBRWnQKDod9G8aCU6JEXfYfum7FaIrtXIgsaGK
         DAKHbAiPNq+RIZkJWtAlg5cE5zvtPVKtbD9en+gikzFn1gy0vYmnpV8IBG5Omk4oIV+D
         0ZtA==
X-Forwarded-Encrypted: i=1; AKwUvBzCe03oMwNOdeh3pCVZN5Iq2vmC63mBEcur8lzyJoFHEy9ug7C64ioA2wJfaC46Fpdywl2q5uc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuIbva1YRgTKLuk8VJnu5cgHmMHdHqu7h79SQRnt29+JCqd2hl
	qeUuTA+21BbHMwyo39SCaL9BaIHv9vLHV4G4JMmmv1lRkc6UXLu5murw
X-Gm-Gg: AYBFou2GaF5fMmSpueLccmreH3yAbSvUDcF8Vv50BrpnZiFdGmAzHlD0NmWEflZnXeP
	TM7Xh/qsfQq3CWIlthMtpS28rO5kuYS/juWeDPatj0aStk9sfqKZEcvLx5I9IVIZ00KcDWbFY4Q
	DY7BRM2spgaj7lySniyBubX/X7TMK40lXGNqguQJI+ihSWQvIhIluKCEXrqAiaTNP+ZyrA0evcG
	e7p07EGCMKxFp4bZXlM3YCjav+r0O0ZiQRxBy1eQxrJAGPk+va0rhSovGtMbEmZjz/D2hr+DFq3
	wlvwYwVgTqulwKcMz+IKWGAHCtBb0NlEhVC3O/GScY3udM57MncrRwoNRWeyb3u5RK7fHaQr4QL
	/kb3ayYCEZdeLNnTwatS7ohllcuKKOUVvemS8NNeY9ezsyBI6nmtlWd5mDuchs59KKFitOW4kGJ
	Mjh+IHoubw3k+8oybCMLUXW1rhBiOwnldldOH17sy9Eiyo1m9Vz5rXgoa5lM+EbYxybTdqsUOOF
	gOHXapkekTzaGnUbV1hJzHF3zEs+vzCDoM3Vx/hVxRusNsOBmqJ7amENguWWYegB5J/L8BBM15i
	o/M=
X-Received: by 2002:a17:90b:3d92:b0:3a0:f0a1:b45a with SMTP id 98e67ed59e1d1-3a0f0a1b93amr1697408a91.65.1790484106186;
        Sat, 26 Sep 2026 21:41:46 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm13099339a91.6.2026.09.26.21.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 21:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 04:41:41 +0000
Message-Id: <DLPTN52TGGMY.TPWL2GZA38RK@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <netdev@vger.kernel.org>, "Nick Hudson"
 <nhudson@akamai.com>, "Felix Fietkau" <nbd@openwrt.org>, "Qingfang Deng"
 <dqfext@gmail.com>
Subject: Re: [RFC bpf-next 0/3] bpf: Add PPPoE encap/decap support to
 bpf_skb_adjust_room
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "ThisSeanZhang" <thisseanzhang@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260926210757.2152159-1-thisseanzhang@gmail.com>
In-Reply-To: <20260926210757.2152159-1-thisseanzhang@gmail.com>

On Sat Sep 26, 2026 at 9:07 PM UTC, ThisSeanZhang wrote:
> Hello,
>
> This series adds PPPoE session encapsulation and decapsulation support to
> bpf_skb_adjust_room(), allowing TC BPF programs to update packet data and
> skb metadata consistently.

Why?
Is this a research project on what llm can implement?
It certainly can, but it's not a reason to add new uapi.

pw-bot: cr

