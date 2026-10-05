Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7A315D40
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235226; cv=none; b=RUkuL6brhE+bTcBP8KlRdaCA/LviGM5SYoNCl0+0861a9M8rt+Qa05h85sF5l8mTGcohYWks2nz0IG5hLfNzjGgGLo3CT4Z7JZl2XObyszP1C8y7amT9di7XHPFLb++8fSan0b1Rgr2nLK7/Ta2c2NgGDYzFFjXnayUBg7loIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235226; c=relaxed/simple;
	bh=7XvMoZmtsZIWL3FDKVW6ia1/PqdjN347tZrevHVbUYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf+ylLSRg989wwzcPY6qWH9Il8MrbgVtofhNULHW1s6Q5D8CXMvdk+EAPernEL9DLXMZVUVWeqBE3sw88Rk85w7p5QKDD3CyewnmVD8C5YPCFNn41R/UnfbkEz6kKOECQp+CSaR0WcCTMVcPbmuP8KglhFCsrUAaqs4QrK9bEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=V93cToq2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="V93cToq2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1722c37c9so11862945e9.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791235219; x=1791840019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rc7IAhff66GVhjOkCyBspogq0Dd5n6sEZ9HS+Dhw3U=;
        b=V93cToq20mpxIog4BVKjoJS2p5s329lxDjxRyC8+DAtuQnVOz7X+7u4l/zKT5G57ud
         PUJsLBjS5AFVFSo2M0TllH/P30GvWdbGfbCQ/M/Po5Q2+N6pl+qCVIfZdVsfrAQeFP8y
         JnWR7aunbp1aiLdjRV9UpcOyOUfFCn12R0b7H9Q8epNzKgef61jULnLAz4xll6p2ZRd2
         t7W12kRrlXkMtsz1r0PeVmNx7DIR8U1TDdV6SDqgfhPA959cS2rut2U51trZwerOY4e0
         vuROsy55JTMfifcSXpQBoywetNOR9FVCR3yy6poO2/2ULxvZqUSp6yIysPg4t2Pk0vxN
         rNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235219; x=1791840019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rc7IAhff66GVhjOkCyBspogq0Dd5n6sEZ9HS+Dhw3U=;
        b=EZxJK02vgx6kHA7cQUS5s1cJr94IoQP1EGTzl22CvEKZHNn0VqB3CAZq1AA1k5GTPn
         zNC4fHBhzrgwLpiSROb66HOUlZo66EohZtItWNRwRBjLNVepZsH0hUwmJ1eZ4GShvzh3
         z8R05MIq/NlSmd8zB3yLwuVX6jVAvpengoIgU9WwJNJLFsRZwU97rnWeiPuxb6GsNiQQ
         SiaRm0X89+nFfNMamqG+KtczAolLx7R1xHP0S+7Lgi3dks+cNSabjBU/sVU57Ru4PRWL
         cSL6s62EedRv+iF5ouXhVEm11M84oG2ZZ/XtK5nuT/PCoAS2mKd51l0cHU/ydDAzSUJo
         EfTw==
X-Forwarded-Encrypted: i=1; AKwUvBzQhBWJEw4OxkIvr1cWVNykhxNYtrYMEJFlmKdjwJVtSR/dMmXTUrgjZtBXoUXccWy74iugVOc=@vger.kernel.org
X-Gm-Message-State: AFuF++n2v1e+befptqQwVzAlGUXo9BYte5BtDmAEtSE1bNaOIpKVxcRE
	zrgXCH6pefHT9i57QJ1QX+oESNYz0RRKpITOeyGgmKry0pw0aYC7EnwknpX7eEWMEQ==
X-Gm-Gg: AYBFou096798z57e4SxIDpErkwhnDOpdcKuQmPqJpx8W9T2gArDT/AUiDWNeWmZtDU4
	luuWUoxkk88q7sXxX/ceG775TDNhqRsOXFdgwKzd51OSRQyXgU6Cf0AciWDZp2PpkxKMLjYNnPk
	Xv5vvb00t/pA1gO4BgYMLMpcwNPTXHJf3G6yJgsi+jSuuH5fpxChcbHE9EeXw5pvfVtfxh0BNai
	92q8Y5iQx6dP/MhOwEydMe9RX1/XoQS+F0FIIJ+lp7rR3NiIpXgryzrcov8hhzRQutScUUgK/sg
	L1S91g/NUjoY8Ca7Oc9yVf/Nzfj4DrdCXPFCV0ynpVU2m0WR1JQ7cR4Z7mHi3rMY67pi4/ZgpMe
	u1PcuM9ZS+m3MqSqXwK2n5tqbru7j5kuAyslRcBEJJAGLXF9KRU1nneQKM22S6CSOLeJzaAOQ2D
	uIQlA8JCPGZm1dvK+34TwHGGoPX6/EPLu9doVrWO+Q93Ra0Hl6Z8zOfTZUWJSBYrQVe9hYmDJaw
	JtMAxpFRVWQsqLuHgrHdSsQpiGQVt0g9TKnG2fzzeKEW1MBQMkiIPytiaz1vquuW0Yh8Vnv60YW
	SOrAHmGxDW4avcNmaQR04wR8OxIyuZRzOba46upbjkWkzK1/C0DPnMOQYJJTl7qG1oNShStDzWl
	jpWSYcamQLFUGYq1NyoIqVPx/bWfayRvVB1WlZRIS9bEmpckalT9v+1pqAlW3zQBeQVI=
X-Received: by 2002:a05:600c:3510:b0:4a0:c4:a1e0 with SMTP id 5b1f17b1804b1-4a02756729dmr208314965e9.9.1791235219172;
        Mon, 05 Oct 2026 14:20:19 -0700 (PDT)
Received: from Desktop ([187.40.54.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178cafaa5sm21526585e9.5.2026.10.05.14.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 14:20:18 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: sashiko-reviews@lists.linux.dev
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	pablo@netfilter.org,
	fw@strlen.de,
	lorenzo@kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH nf-next v3 2/3] netfilter: flowtable: carry a priority into the offload
Date: Mon,  5 Oct 2026 23:19:54 +0200
Message-ID: <20261005211955.2971-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005171647.CCCB51F0089B@smtp.kernel.org>
References: <20261005171647.CCCB51F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does this silently ignore explicit QoS queuing requests from TC flower?

Yes, and the commit message says so. mtk gets tc flower rules and
flowtable flows through the same block callback, so
mtk_flow_offload_replace() cannot reject one and accept the other.

Rejecting the action would stop offload for every IPv4 flow with a
non-zero TOS, because ip_forward() sets the priority from the TOS by
default:

    net/ipv4/ip_forward.c, ip_forward():
        if (READ_ONCE(net->ipv4.sysctl_ip_fwd_update_priority))
                skb->priority = rt_tos2priority(iph->tos);

A flow forwarded by the mtk PPE does not go through the egress qdisc, so
the priority has nothing to select there. mtk already accepts and
ignores FLOW_ACTION_CSUM in the same way.

No change planned for this one.
