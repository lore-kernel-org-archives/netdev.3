Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE502F8E98
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781081; cv=none; b=BKpvbtFRvD20x6LrC483YUvh9yqU85JCt9yHT+ZnJV3L6JsVlpLuJnwzY0AUlx2haILQ24OZ6TOmnPzaxPYkljoCLXCndXoS63N+1PyXE/uqILLquCzpkz0izK17u6/SJXaI5cFaPXkN5OTjjTVJ698mAimbzqTTDkyRMsyeII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781081; c=relaxed/simple;
	bh=VHRDacBvIcvaD3EeGZjqUhghQgLI0/sOWRk6kjCWSHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+iY4hO7VLOBvfW9IKiPs6eKyuJXqYKJskpPvsiWd0k1kiHpe3Fv0C7UGRRmc1dyEQipJg0yQOhrE/kbPEueOYs6UHxG/5VaJspxAMxIIx2h/624FZVfLdxabPCY7zGQy16YvmNzWr1hWvyOSsIFvOyTYNkABaUhxG0dKXh7b4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddcD+7oR; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddcD+7oR"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-144f79153f5so3777499c88.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 21:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791781079; x=1792385879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4r2duJGpWXQRzkludK1kNjL6OFMP61EO9Bgn2dWvRnU=;
        b=ddcD+7oRxaxZGswhIygytO2hY0JtyP8knSGJ0w5COI9w2IPK1FcZE6b6BZ8jRFu/c/
         wBmcrIGMD/exIKKOF4OmakYsLLAINMeixgkQNB0TbYq1PN2wHa473Fx+f8pbIoGKbakR
         umItDo88LtXnuJgRTGrxQxwao3slT/ZpF2Q6thOFHTmKbk4rOryYTpu+Mk5+/LoLuznQ
         E6Im5AJjGr6erQjBMRMcfKdFAnc3jh3MNMoaIONcQzVHIr60EEdSlG4PoYzAozzCblhF
         K1GewhlnQGUA0mw1MFfjbpFuV+755RYVWXWLlTmPGZ5qnx87swlIv+yK49fhtT4wc3Rc
         Ahuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791781079; x=1792385879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4r2duJGpWXQRzkludK1kNjL6OFMP61EO9Bgn2dWvRnU=;
        b=x0NpDRmB+TmqOgeC+2rc9pIDA3eLJIPyUIHrsn4UE78RuzyKUyr29u+ejjkAXGTvlx
         RK3mvMYFPlYHZ8Tlx1cFddpviIoD4c+iDv+eXoQSsCmnEdjkJNaBTVuTptpxhxL80S5Q
         CnXShRwwuyKXefeECouSAjxcPpN+jswiZRMcNnWMryKb+R9lOim8TFBTDbkf0E3kyK3Y
         J4NS3SEyz+JU519s3kj4Sp5j1ueGBEAGgq3EK5u85Z+xTXcGiTquAP8CaS03gEgivQeL
         plVHvGcCYyyP7KY8MOOv1O7Ik2/hSPG//xKFBuVWW8TengRKk4jsfvn3TYX7GSZGqwtm
         pRbg==
X-Forwarded-Encrypted: i=1; AKwUvBy4GTw83ZgjgSRGe9T/dvISRL/Bzl0OJM/sw3bhh/mKBAbpMkCkr6Cl0Ffoqo8QsE/gKsus7as=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPmeZtBCi1ZsqN2TXLne4yobyQ3JpRBe+taVqI0M9jOWP0g8yG
	+RsrWTeKgrFuB7fl73LhER49TKb1Lz9bwKEZZi5xXB92YMk3sU39kupGrGgzkV9Q
X-Gm-Gg: AYBFou27U+qPvUcgoAuzmG+aBato3jUgHgt72ZQ2wXKQk4M2o9grxh6bFO/fq8aRW2P
	OElTItSoA53QMQF8yJStAjR0EkaVk3hkRwA7rgjB5BmhCsSQYc9EOCAsHYS8gZe9XDA4IvhZWrU
	n8O6tK5nLkDkVAPMRlIHLpe/rdtj6ReGUT6YueqdbtICGyrjpxiD2U99xtSjnOFl9JmQUkDL4PX
	6pYHBU3Pf41MzbOkhaRO3tN51e4V/MxeWrFSIHMY0uGDI2fSaa1f89I4uEu/NfpAsRd9okRc4LC
	jSxRWStgQGTskBMnAiRYG1cUCFxTz+R7IAm0+giJ21k4S7Hw7xfBqHwAh1O1VP1o+OhT4LtrL30
	1HAmMWnXgyuvwYlzsSpfLpKmHQy5yboJ0vrFRcCfeLbSkKC3vECR6HJDQ1uhjuecoAH3ytulVQT
	7MuvB6dBKEKqjfI59bKdOgx9InN4e9lKwIFJNh0ooQEUWcZAwOfmv0gv2I4nJrGuQOliuHoPnjA
	nnZrSgYLoOKDh4AWNuXg0sz+jp1Xl4e5oPl/cj73czCEFWF2se6JkZE5yDlXemURXfkZGLZc3R+
	jxrMVShi+tqQAyUwVPncnSIZp4h2ItP5tyDt+kK4C86MSHHSKMV9/fm7GA3k5WjhZD0NcI6cqnQ
	MXWdZSLAb/o60WBK3Z1uH3b0Y9QLQ4U/wDyB12AqcB8bz7/ra736DKFo=
X-Received: by 2002:a05:7023:889:b0:155:4a09:a228 with SMTP id a92af1059eb24-16a5afe5e1dmr11902752c88.8.1791781078853;
        Sun, 11 Oct 2026 21:57:58 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1699718c547sm25367340c88.3.2026.10.11.21.57.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 21:57:58 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] tcp: keep the route window on the SYN when SO_RCVBUF is set before connect
Date: Mon, 12 Oct 2026 10:27:51 +0530
Message-ID: <20261012045751.47179-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179171754826.2527009.561712354727529429@kernel.org>
References: <179171754826.2527009.561712354727529429@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 11, 2026, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>  - How the issue was discovered ...

Found by manual code inspection assisted by an LLM (Claude Code, Claude
Opus) while reviewing the networking changes that set window_clamp on
unconnected sockets, then confirmed before posting with the packetdrill
test included as patch 2/2 and a veth/netns reproducer. The patches
carry an "Assisted-by: LLM" tag for that reason.

Thanks,
Shashank
