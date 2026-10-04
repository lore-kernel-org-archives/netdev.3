Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29937C11C
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135208; cv=none; b=PnfmydULuqLHbf9V+o9Zh8SmT91x0mfKKfurG9e4m7uqsAvYJa7w68c6PpXsTwOYVuCLpwqKYQnyN5Ww7AIYQRtHBZCW9Z3g2azVslkXz8CR2Tj0p/SH7UxnPVS3CDu2EYM5AzmlMIKa9aFR5hvUQ85PFyo/pjCWGanAMStsZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135208; c=relaxed/simple;
	bh=eCJ/xgGOZpf3QBfsJ28uBGeOBNwffgZsfhRIp63slgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyHIUMOzbtqmCxymQxyX7/jXJ6wHC7pAL1ak+Q/C/TuUA/ssTIcBBx00xfrwNOMZxBjTF1vw1QB+pDg+XNwBPHLx47jrDWtlKn3HEXb7IIba/MAfZdhriwdgCsSiG9nUBTnHqcCM4a/KbRhYpAVSKm2pcEEXy8bYjZ3y266uhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnFurfGL; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnFurfGL"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b1743e9c7so905961eec.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791135206; x=1791740006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCJ/xgGOZpf3QBfsJ28uBGeOBNwffgZsfhRIp63slgw=;
        b=MnFurfGLZdm1wwOVkmkg+BTyflG0y6kD4pqWYCy8ExSjhsnevDG/6gW6w3RDYrG8JJ
         4Y0NYFiwCW+/jNePXjKKkDZ9KJkGEJugkQe22jg3SCdNouJxL9SMnlQ+kt/so+9cMnpv
         /LRW5DUEEh8bCPwnAYjBlTrSIXLQK+MDSchNl6kV/IjZEAAQsO3t+T9MQ9Oc8o5qfXiz
         6DHYJWMwCDBWv7/dFe0kyecclvQAPQVTRhuxu6Dd5+1Tx6ZvsCYKuHpbw0ZpI0AWJ3Bu
         JGVbnCpfSXREfWoRtLXD7hhkcX+WEJIo+1X76K5XYLx50nALyPV0pvXeHdyB77akztnT
         EBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135206; x=1791740006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCJ/xgGOZpf3QBfsJ28uBGeOBNwffgZsfhRIp63slgw=;
        b=2Szd9JZfypyAuPTeP9VnQSK/P5rvLr6W15B1kqeyCH/YCHDHNBsxpFQ/5U3IcyoKBK
         30RFIIuT4T2/R1T9L2HRB4mCgE4J/3fCq4AyGkLO0Kn0WwzmSEU9TpP3nGoNpqka/fyX
         FuqqaYuf8++C4Dpm5RlF6BuvNsBcMyTqiuUaf26hGwHfRWSljrGAn+1emxfnMk/b5mRu
         li8p4tJWHw3kvY8dD+r6kfGJw9VViuTLrlmaD0InbufHDTLoZ7KPgvmMzdcfa3vJ/Z+l
         wnIhX3PxbqIaEulEktuUmEHFpEtoFtFzACG4UQnkRnzU1vJyiqUwVwyXS9d2rBXfzzS7
         szEA==
X-Forwarded-Encrypted: i=1; AKwUvBw7Wcs65kRHQI1ZV9Xy7T4QSAYj9yIpja/FbTf/i+XhwzNojHLWuqHqkQaYVcChd1HFT/Yno1o=@vger.kernel.org
X-Gm-Message-State: AFuF++kICKo/MlsEv3QMo+J6Z1a0XtZl7G1ehToGkHL9mdPAbngGyDhH
	r+tD7N10igWFJeWQI8oL4VNu8YdvI4+YvLyGB7ekDDCG1rQ5OM+UTOs+
X-Gm-Gg: AYBFou1t6tkoBiQrRtboDVQz5xYhWKPoHYgVa2oueRl+m/p+I+o/LKCKSNLHXnaXFX8
	LXuWs1Lh1DNP/GRpUHr74AuwdwEmmVqdcIkzUVAjgidCjOiyu+W6of6jBpDuped1Y/fD5cUcTkb
	gR1xs3cgrD6MgsDRGRUUWpi98yTsimqFmUSavc4fgBesGMJLrDQ0Xe+R+C/56OXavPVFecDpvhf
	7luReDVxrDlA2BlTe6WjLEHme231B6z7x85StE0X8xIThLyz0ttqMLafmwWNbWSUqtdbiCCC5A+
	U68srKtDA4JkfPDwbj5gojXo/sBRAK/piL3o4oOn5BpOAgpe3XylbGnVb5y9g2f72eXbkWRhhYZ
	P1NXmIO+Rfwl8jzJ77rYUHj1lf/LMSbMwwsOsxyIC6qnTaU5zts6k7A1MihtMTjo7Hf2iae+8Tz
	t5C+GXodGeZjeeDxUUNwQzQEdjXIkD/LO274hW8LkBpGOM5j0KToKpJ8IYhEnkoIzzu97/LTAwD
	sk/JAzfsTXnsyO0grvvvw==
X-Received: by 2002:a05:7301:786:b0:351:3106:4a33 with SMTP id 5a478bee46e88-35131065510mr305442eec.10.1791135206515;
        Sun, 04 Oct 2026 10:33:26 -0700 (PDT)
Received: from umang-Inspiron-3501 ([2401:4900:1f3b:8187:3c41:9181:ca6a:23ec])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127021d1esm6966533eec.4.2026.10.04.10.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:33:26 -0700 (PDT)
From: Umang Pokhriyal <umangpokhriyall@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tap: report IFF_DETACH_QUEUE in TUNGETIFF
Date: Sun,  4 Oct 2026 23:02:23 +0530
Message-ID: <20261004173224.33809-1-umangpokhriyall@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179087539624.434549.6585301310404315341@kernel.org>
References: <179087539624.434549.6585301310404315341@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 05:23:16PM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Can this break a read-modify-write of TUNGETIFF and TUNSETIFF on a
> detached queue?

Yes. tap accepts TUNSETIFF on a bound fd and tun does not, so only tap
has this round trip. v2 will ignore IFF_DETACH_QUEUE in TUNSETIFF.

> [Severity: Low]
> If it is meant as feature parity for net-next, could the commit message
> say so instead of calling it a bug?

It is meant as parity with tun for net-next. v2 will say so.

pw-bot: cr
