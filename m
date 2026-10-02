Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F23CB8E6
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964020; cv=none; b=r318SgX7wyfbdk8Y13oOWfKvll9K+F2WmrvteXaf87H28vAXQGXMk3HiD+87O1x+34oj3VOmKF+xkoFY9hU5M5szTvechAxXdDl65hs6GcmNeRWdHqA5mj3boBPjKwCneri6DFqCTD9BSZWU8/qWlGr3hK+winBaaSvJlFDkh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964020; c=relaxed/simple;
	bh=r6flqehsHrWb6CQlzTZEdhNiKi0yciQzwv5u6pB5mjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmHDqF0Z0BFfZonUrmaibgAIl+EZj2FIFcglY42jUGe306G1TQXRGl9qFB6MKlL0RranCmImfyq3bS+R6OXHdi7eSi+f9rvUn0sZlxifHDO6znth7MZZ2ajARoC1BFp2SMxtS8uHINX1vpuV4Ed3cX0PHNSjpYgJ/lRyGqqlAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=bMyBXjZu; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="bMyBXjZu"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so6821163eec.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790964007; x=1791568807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yv+N4IL4x1ockBZPLIwDfbJ3RMrUTyIEDIlE+BiHgmU=;
        b=bMyBXjZuML/F+0wMHVla16AfPUv+3CivC7g0WsuuBCZ+htrc0AoAuZ0lETON4DkrZQ
         EUEU0PMEPQevmVtwzpnyRaf0QfFCYwiDDMM8pZ+iZDl1vKQPSe9lNVkq+W3PTwfALYo8
         bz+cRNtlXMSVgTYkseN2dPQEIlVjtDqgXXcuf20UpeepvgWe1fY2qGz+KDq3NB+r+yYw
         2ZSa/safKxkLCU76zLJmeAVak/BRslwali6kFM9EkBAN73G93BN5unbJrOoc31+fI2Ge
         Uz+G6Zj8ZYXp7J1VqcJMz1j74Vu5y4cIJ4a3p00AZRCxVQ6wJmGEQf6i/mtgAYATag8V
         u/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790964007; x=1791568807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yv+N4IL4x1ockBZPLIwDfbJ3RMrUTyIEDIlE+BiHgmU=;
        b=ETmJlC2Z0p+9Lrd5ShqqMwp8vmj8T7lXvwjYuUBO91nKIEL3SQjPln6zHwgjN/qZ0T
         PHrynmzFTpluOx07ejDmu75nmNjcjeds2Pj3NbCmy/OvD2gd1nvkc7gmzRD7MqpnO/o8
         A+Ht8pvnlIG37gkZGme3hJwZb2lBXAnb4XYnl9rNsY902KOMq5CdWmDzTb+1D0pF7SId
         7zaoLzAehlJdrC+/d9OLirKcUWJNUN1KUKqW3feOGX7UTz+VgMQHh0HquMk0EzwcTR5V
         vX/JeGwFjQUQsw7rcnzl+tI5yREgqsW1wT5VO0DhGh9qg1qhr2d3pFmvx7hNDMpUGwIe
         4IWA==
X-Gm-Message-State: AFuF++lVXJTMJ0ptgPaltBflhqrW0aAzMopyxwPdXpmDMHdO5NDuBHqr
	aYYZxPex5raQ3Y76ZKqOZ3KKVSHGgp+fLuwGHou0J0bf+EsjqA4IvorsdFoSPnl8W1wXWVATOD3
	DYLkgzROnURRQDSElFDTTD5vQOYnQzwDGSMSo/BSunYn9hqKcR9/mYby5ja/k3j2jZ1z9fvXw
X-Gm-Gg: AYBFou02kDyzF8ldCZk0ivGn7hrvb/a0zNxDVAfolw0LHl73f0imQ829GM1E0Wyfo6w
	6w6DS7Zi5fKIenx/nqAGN05u7gagXbJ3sluw3bx18rkN1WpJI2SZZnuJqlrvNikSFKU/eBVHywa
	Sm3zpWSDkr7YYtLyuhCt2ABSMpiBCs6JDfQTeQOScGCIjfN1XaTX9ysSA7RScczJTzCtebtm41L
	RdoSx+glqaWetws0bKo0XTH/DAmIQVoMeUzFeM8znnGvd9XIhgMS8Vfj0zA8a5S071Y9ECs2RXj
	Uzh1zSMCFVhC2Jkk592zY47W7vIQmmqrGnOhZB0dS2GawIsRp8xZeI1aSyQXFWlYjzTCyoWWTdF
	zEPnFd9+FJzNxu+C7H8QPlrl8um6f00RoEcop7q+0xeP0iq20kfsiZ6tLxsO6IC79pk3xVciFLa
	J5ceevo45E23csJVk/3mODGc39eYVB5XXoDuwh2nxCrxXV63oATZS2bxUMSgiOdA9Fd5E6iKhn+
	sai46T4YKYz1YoCCNVj4A==
X-Received: by 2002:a05:7301:4542:b0:351:5c7:2d05 with SMTP id 5a478bee46e88-351113ad0c0mr363351eec.4.1790964005672;
        Fri, 02 Oct 2026 11:00:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f150248b4sm7504330eec.30.2026.10.02.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:00:05 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
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
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v4 5/5] net: net_test: add tests for TCP re-segmentation
Date: Sat,  3 Oct 2026 01:59:50 +0800
Message-ID: <20261002175950.2243500-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.134bdb5c71ee0@gmail.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com> <20260930111526.2183107-6-wang.zhan@smartx.com> <willemdebruijn.kernel.134bdb5c71ee0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 15:53:09 -0400 Willem de Bruijn wrote:
> Given that we have the above (concise) testcases: 
>
> Do we need to add the below verbose code? What does it add, just the
> TCP specific path?

gso_test_tcp_resegment() is a v1 leftover, when tcp_gso_segment() needed a
max_segs exception in its "untrusted source" check.  max_segs is passed
through now, so it is unnecessary and can be dropped in v5.

gso_test_tcp_limit_l3_proto() was added in v3 for the L3 protocol limit
lookup fix (1/5).

gso_test_tcp_resegment_l3_len() was added in v3 for the 64 KiB cap on the
grouped output (4/5), from this sashiko report on v2:
https://lore.kernel.org/179002380484.2160803.13955762820082413555@kernel.org/

You are right that they are verbose and one-off.  I do not have a concrete plan
yet: I will try to trim them, or just drop them and add a selftest later.  Any
suggestions?
