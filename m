Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5513C0A17
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574580; cv=none; b=hbrB7R0HmhiosNQdMb4xybxiQvHYtxtKeeIaaOFT5qtR0aVYWuqY9+dffdkumhIfP+ojb52XMhzh3E5JbCfF0JLwFSa4DPFLd8acG6XQ3DfsJkDJneEaGuxZhXUlrtsYkSuepq+prXsnvC3p5pYU0CGGMKStMObppa05NxChpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574580; c=relaxed/simple;
	bh=PYJO3BRdZuUQ2tA6+R6jTGrvu9LtNBMxYQ5mNvCBr0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KktkaIxKWS19D1FZ/rJbuLDxE09e1Ijbrv2Wvf60GzNiIanrxwQNUZaNCH22DpK9wXdAdHEdc4rbgWr7x70GUvkYUguxWJqoye86Dep/8noWwiAyCy3PXF5kzQVA5YMoQVkZgDcg1qC8nuPvtuEPxSoZLEc3wzYb+YTNynAOEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=SwLVW1xw; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="SwLVW1xw"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so3736153eec.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790574572; x=1791179372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+A3YyPH8GVczArjQU1JaX5+TvDc91iqyVUi3xBaNlrc=;
        b=SwLVW1xwDqkKVzsS9X/XP/Rm0YxfNjk+NeUJhLQ0kHEpWJvgsLKnYVHUS8IP/nV/R4
         mpQVYGhWET7TLJhMIQApM+3aQi7i1lJTZpbaKKzWfS8DVnU4zj5mGLTjg1HiRZeV9Dwk
         Dcc7l3mesdeijXih1+6G92fGgpZKdZLmo/BarLcV++CEDmDlS+KrQFtPASz5iGKKpYpS
         R4qh6Mp04rw7lg6eBF+oILw9T/Zl4WlxmhmGD4g+zdg3Ll5LYXkSMhn9yUoN6dJZ2hcM
         uTC/3AJLqPPGdxZczwz1qiFgSAeRVouH9NmTZizCeMgR1qLtpjrmYwq/KSWf/iAchEMV
         MXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790574572; x=1791179372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+A3YyPH8GVczArjQU1JaX5+TvDc91iqyVUi3xBaNlrc=;
        b=M1GYxvr8q7G0kkUxMyoEtqYT0xwvq5qJzsJM26OjG6JohXLQNPVlpJGx6dvWd6kbLG
         5k9m3W3EQAFDRXypfBxS3Ssgm/8IsQTZiniCkx4MPkIW/c+0s4EpkTzb1Ne/fYv7Kc9G
         sy+0gBhFVenof8PhSPur+HSxPOuDoWEkOFxBVKZDHu+om9cy3ftku7ucvFpzq5pDwIKs
         dA0qNAVm6cZQJpio7R/Cc5ZIF/vPEeF4c2hAd1uicz7IW7KOir231Tk2fhlqkGB+2HG0
         BzffT0w2QRTWS3FQLFqf1R5s1s9u5Y7ybfFn4/5v/kmDbHQeLioHp38v1E9qioMdozkM
         dslw==
X-Forwarded-Encrypted: i=1; AKwUvBxgf3DNa5noJZY3Xx3gGI8arE/2A1gvF71awYLsPufGJwgwPw+YgyjwTDE4FRBzqE1xdQc96s8=@vger.kernel.org
X-Gm-Message-State: AFuF++lSySWa7eLlyvohyaWxGEjITrpt/X8sTfzrR70g/A8l5usZ8+kW
	a1Mtb1PvmA/SNvkifxobom0M3ljzytbFCXl3JJ4I3c3PF2A5nvLN1r9R38CjU0uliQbNwtBVkw+
	/u4a07kByR0lYiuJuBilmhfJWTY9IgrN1YHzpN1BfFDMvg14Dscn4fUaQGDYkLWk2f+icBmvMTq
	w=
X-Gm-Gg: AYBFou2lSLS4Ts0X+QK9ZVm1wYjs755w+kF1jbEBG4itjh3zE4HTK8OOQpsAFOiaDS8
	9q2Y7E7ycAsj92yQm5IjHDc/oyqJ+TrsNn3hIaSs+DzqzWknkj8d3m1eSrnv64Med4ei9yK7PFi
	2FIb/sKxtjAbf3YQ+y01F8F+rcOU3GJiPCGA96PSSg9AHd9Xuuuv+TR4lOsLijrybdVo8XT0gXF
	BxdqaxYH5yp30P/AQh8TiuyZlCD7lcm1habvAEKiaOIRkz4roMrJ+rXRpirMHuqKqFGHpjCHplh
	IINGMgLrjwg7BQHal626iDdXcDS9gsehgP/XDuEKlHgLBynq+Uwg7/ElYsbXAzEwIvHILYAkAwN
	1LNx8phAUVYboA+EQAjDEWYqmc6v1chP1MXodDa2flUC422s+91EOqcJYIj64EcwlZ4kVDLb+yA
	24smsoq6oEXfEsZrIZDthu7V88aDw3Ti0iJODa7efxIhuqK8nBZTueUSVSU/eKTOAHiRoQkixGI
	fyYB4fc4SY=
X-Received: by 2002:a05:7300:fe8a:b0:33c:284c:d91e with SMTP id 5a478bee46e88-342705b702amr8511963eec.8.1790574571889;
        Sun, 27 Sep 2026 22:49:31 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3444fd04d93sm7611370eec.12.2026.09.27.22.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:49:31 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev-bot+sinfo@kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 0/5] net: resegment oversized TCP GSO skbs
Date: Mon, 28 Sep 2026 13:49:20 +0800
Message-ID: <20260928054920.1434795-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179057071651.31693.213200671694715782@kernel.org>
References: <20260928044102.1004310-1-wang.zhan@smartx.com> <179057071651.31693.213200671694715782@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 04:45:18 +0000 netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Only 1/5 carries a Fixes tag; the rest is new feature work.  1/5 was found
by code inspection while writing the resegmentation path, and it is covered
by the KUnit case gso_test_tcp_limit_l3_proto() in 5/5, which fails on the
unpatched tree: a tagged IPv6 frame is measured against the IPv4 limit and
segmented although the device could send it as one TSO frame, no crash.
