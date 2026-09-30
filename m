Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AD443C2F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797859; cv=none; b=HFl3MYZM5qPQrQqunQU/9a9J5g4YE1GmiYNNTHNf2hhvQECJB6TqLR/4bbi5zOQEHVO4OkohDBc37bikgKBGftR/OXMJrJD2C3PguXhBxy2qXe3ubFAkITwPkIEo3Dv7/q2dhXBg08oApH7CucCbtKyszV30rBZv4cWeB8GOHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797859; c=relaxed/simple;
	bh=g8kSnvXNg0KFakuMMNxgd5z8HZ/cGn27nYQqTIEFHGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFEWTfUJEXaKr5xWeR+hU7I0Y4/qWEtQXQ8lgCRew35Bu3vgcyyOd0fdJ9KI5TFZ/RRh6A/BXqrfm20vqmoPR+Fo3OOKnIGWCX1vZ8O3DjIJl2xL/Wmzpqx03l8fsD6PMu+M6s+eCSNtPvi6xpiTFZgHp/5bhmpedrZ58vmt1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVJn29cp; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVJn29cp"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afd5b1678so731475f8f.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797854; x=1791402654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zG43L4MPOSqtW553TU6Kwtxr/jOwyLkxMDRoqbA2Niw=;
        b=hVJn29cpn3+KcOHe9SpXVCzTUo8yN2AuOuqmjhAiLUbmkPGjFAgAcGoTpn9s6P3gr4
         mPL8xwOQEhjbzymBOet/w8JSFmlicmA6aR8Elt3F0KE3Dt+gavy8Jwk2QoeBjo8NV/FV
         wjF51YRi4f+XfooLc6xkpgFjoA2sVpvA8arD3zA+m/h3diO4mPpxthhhcpKMTTg7RLUu
         pUC1OOmdKZUXXxtQtBlKsvR9NDZHz0eQdrt2/DLH1xJtou4KqgwAB6oy9ero8nwDy55w
         1PqBN48jv2E4Iw1C0dpi0rZZgAHYRbAh170N72AfmfuPZzuaFFCTthdwR1HM12r6GXZw
         2Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797854; x=1791402654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zG43L4MPOSqtW553TU6Kwtxr/jOwyLkxMDRoqbA2Niw=;
        b=2QH/TNiMoaLD3/0JSKx0dxmQa7WH7zSh4u+QQZGeI61/b3c3u/Dm6sxgrJmDcxzqMp
         SWPYlqUeeVjJBrqaoKwzD7PJeDXLbidGnRO6VZSmbt2Cp7mDtu3qiB5ahScZRlr57+l5
         IW2c0lAquPjpeDtIsR/X7XIpvH2ql/dgyvFRiFqG5t/mUI44Isxdr1FPQoak0Je268c9
         /vHrDpVvWgmLHVfLfx/seaCJYUV7oa6STmWPeDj5jq8527ix2kZlpP2+mujuCl212cur
         XTHS2KP4+283VLrsmKNZZLZJweSOe8/SJcGWORV8xproJu/PTw+G3ClBgoI3hkgUpayf
         Uxyg==
X-Forwarded-Encrypted: i=1; AKwUvByokhntuc/gRDg4Z7M2GNt0mFForJ7jOMCBv0h+xFnEHffYd097eoLpCXe0Jbnh68Bw96kFjo4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK/DZHKE1AmshKIhCla7ynikUXLYP3qPvyLe4957BDZOghLdaj
	5hDRVRs+J9IEtHNDR+kaA60+oqYc1BYz4pn4z+aKVtP1QVMOXFimfv0i
X-Gm-Gg: AYBFou2h3Ov+yoV6xi6w7mmAeaNaTHeArr4LGlFKHpQScAUD1/36PQdhsFFsb1849Ys
	uFobBz0ThwrmAI2mt+bW6WGMuOMKXHRuOXlFj8OmwvZS1vSDMJIJY/ewahYtWHi4vw9QSIlW331
	cVc/Hb2bqhJZQBaL5QPQemBQoGIZo58qnZLrqd81Bwx7yEuzQd/CNF+lncxRo3dr5l5IxtlPexc
	AlC8JKMRgHJq1pxQ/KRQa61jko3GV+rwUQaS75StCnKdwU0j4QDHIKzQioUQxwL06jxEuKUwmsW
	9Mlsue71Ojd+izFEd2Hj8TNPZAZzwkVCDFf4ozVsWZmJVJrISt15/G9Mfcvq7GOExjqo3D6mOyR
	in/ys+dRhNEgPUwxDL8j7P9hGfudA0JPnLulxBQ0agJLpdIIQ+HYLdf22sTo0RyYo4EGCE3G61x
	iCLlPn2y0uxmSkz+6DC2WhEl5TPg9ShPwtxmyXtrM2q++U5fJYM0P/uNn3oW3FvMyOPMcR9u6up
	51bmoby2ILfk5GoRTnFRDtQVwDaOWyjCjq/LB/cZbif
X-Received: by 2002:a05:6000:98d:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-48b0243dbe8mr4875486f8f.4.1790797853873;
        Wed, 30 Sep 2026 12:50:53 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0692b5c8sm1101574f8f.29.2026.09.30.12.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:50:53 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Wed, 30 Sep 2026 21:50:36 +0200
Message-ID: <20260930195038.64098-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179061238760.31693.2318453255259270234@kernel.org>
References: <20260928161830.351199-1-parri.andrea@gmail.com> <179061238760.31693.2318453255259270234@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Resending with the full Cc list, which I dropped by mistake in my
  previous reply. ]

On Mon, Sep 28, 2026 at 04:19:47PM +0000, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The issue was triggered, not only found by code inspection. I
reproduced it under virt-ng with a local test on a VLAN-aware bridge
with br_netfilter and IPv6 conntrack defrag enabled. The test sends a
fragmented IPv4 packet on one VLAN, then a fragmented IPv6 packet on
another VLAN that the bridge floods to several ports. The test is
available on request.

Symptoms: with the patch not applied, the refragmented IPv6 packets
leave the bridge with the wrong VLAN tag. This is the tag of the earlier
IPv4 flow when both refragmentations run on the same CPU. Otherwise the
packets go out untagged. There is no crash or warning; the only effect
is the wrong or missing tag on the wire. With the patch applied, all the
IPv6 fragments keep the correct VLAN tag.

Thanks,
  Andrea
