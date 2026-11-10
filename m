Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333111;
	b=M4Qi4cQfQkS5HafKofGpCTmDKIE9F89Eh7ac17geOvzl2EIKIVqHVtYwZAdmoL8FbIQH
	 YptAtetAt2tfiwA5HPF8p3srCO8qB2c2GE7XmI9+etHx5HBIqpLvPsFrRzmF5VNP+yc3Q
	 1C6Xz79vRXXxQ6wBCLGTKo95nbRk2pYWypihYUeD7gMsrJNNGFeQ36YnMRI5vq2Ibz6dx
	 ecdOlZFlh592W9AuxxnNycinGChabYNcc61W6fQ0abYI1tun9RDKYFwEXdEetooohSwvO
	 EARscOGuVfo9q4VVwH4C5VgFeffTYwTYDZaXHqJNFL6OSBbWw32rJDiac6ETgIokG4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bhispul0ewCHbq4vsceQr04zf2nGwRb6CQZ0KQ//7CM=;
	b=TwCOFf7G2rhS2zGf0V2Ybpwj1gSIN/1MfYrAgQV5h9W+NSR6Y+v1SlCkB9icr8hUYUYc
	 foWvoNvlOhBmJAQXNKQKqzHE9nhQPqgkd3mNP+eQ/qRp+60tUdJq17dgjGsOG4/8nIDpa
	 HtsUNXM9CNPBzM/qoy8bx80++URvLtpSnjnnqyFKZQSNDc3cj4Ow9s2nUZ+2R61mjlYQu
	 KNk+WOnU+fSWl5KHYzSWk6VDyC2GGZAVYgdN6KLor4VIPIjL/kPUUemHXHJGO7uVEjw+u
	 PWx7QPGYRoC8gIrsTSM5CZZCL9iPZKJ+gs7t6t/YeRu/nDUwa98vGwmvsgUTKAz2pEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UbRj4/l1";
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D6606A33E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B78D6606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UbRj4/l1
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b28d9537bcso1600630b6e.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333110; x=1794937910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bhispul0ewCHbq4vsceQr04zf2nGwRb6CQZ0KQ//7CM=;
        b=UbRj4/l1Aj8sYlatj5ZhTuvffrU1a+6SW/l3AZEwT/GlvNFEOUvbDI4M5UtFPoaS7n
         A/F/PMwebScx3Wva4W2OXAwak7ow6QMUZgzyQKersUeBJp5dBDKbiHEdmcrmR0GWnbNT
         nWatWVlyydfwqnCeUBGE44vm++7n59w873D0KwfP8zqXgKF5U5LP9Z7WWe4rprGXXPOF
         ypPNuO/0H0RWlZCEXuytcu70l/moqqz5v1/Mq+FGjKQi7IWfFPmBwCYGtJOgZmCUfAS0
         XuwaL1/kgF/rj/+lOFYfigmMjOa5wEP0IzuJhLTEPjWXkII1MtpZ3JbQroRYvxBdSwwP
         D60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333110; x=1794937910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bhispul0ewCHbq4vsceQr04zf2nGwRb6CQZ0KQ//7CM=;
        b=grwupRy3ke1Ad568YSzwGBBIdWq+l4tYO+77Xo5klOp0FbSihOnHp3hBGdJyDuiAC+
         H9ZsRMoF0Ck5eKfdKFjdMNrYN1bqVKuKDZhy23l0cQkmublG3InOyWzCx4RLcILlZD/V
         0cuF0G4TnkdtzEG22+ZjtiY4r8BXXmIkDNWj7dnZXotUjmvQOw3ztVAI0DyaTJ2Jii3W
         9UYAlUXsP0RsZSAdRk/a4yXfTz24UEs0dT+YQtWuYU19eFX51fAgMgPSy27JLPWBDfPn
         TlTtNAOpmpMAp8W+GmiWlSYbQQkxyHHqD49D44P7OLx7jGfCy7Ch2rLcFDLCoBq5/hnE
         N9Og==
X-Gm-Message-State: APuU4Z9KegBC/SWjB65+nbYJnZxmX/VAsgIV0M++wNARl51Bd7LVLSKg
	TnlrJfOCqtpEQIRV8OGcBCWaA9NOkcvKHSQeuULraNljDeMBBjXXmo2oknImTlJH
X-Gm-Gg: AYBFou15UXoejdDK972wcDdHjGIij8JrUsC6aHRG2OY5EhcKb606gn8IlWrj4P0jWr/
	WOy4vUtnw6V69xZQbZXqMCHwhgsAS/M+7r/hMFbjB3WMOWSrZKbrr9f05tQLgmYkOxj/QQ4WqS5
	slww+ziHbFVQOtBXicqPK+0mJyiXvaZKBNU3vWmHpfiCLl2mzgU4V7PFo9ZQKJfpjNCelHRWmLA
	vsJnxq6TLwj3WFYSX8MjZ28klgd1h+zvAGVKnTvPYq7F+0xlsyK2JXShXJAlE9/jgaIHUYGA+pn
	rsuaSU54bzP20xV80C5MhbmChVYvi2zZtUgaorSjoXpCYAIMoNOdtzTzXsFO4SF+562Tagz9IG5
	aCtQcSNX0VSWSB0n6iNGaMAPoA6+g2wp7QH8J8L7uEzCVLesZnLj5vaNuWRe3LuNPo0jT+N0Pw/
	IDoZ6P8mP+g7SJg9EJ3gnhQGXvVL8ytusx8NdJz0ZZvlbfpOCLK9CFwhGwdedM6qksUUZXn5a/A
	ZRbcOs78yMO7g9g6XGNNGG5TlJ4+igtQpM3GpVK1+4bvLYzvWlvnwBJfRU+WXQf7PFN83NYi8Dd
	0aU1NlVrwBB8w61zL6rzrK6G
X-Received: by 2002:a05:6808:c093:b0:4a4:c95a:38d1 with SMTP id 5614622812f47-56872839720mr1542650b6e.4.1794333109664;
        Tue, 10 Nov 2026 09:51:49 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905d3bab2sm2712060b6e.12.2026.11.10.09.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:51:48 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests/net/openvswitch: check that a failed set keeps the features
Date: Tue, 10 Nov 2026 12:51:34 -0500
Message-ID: <20261110175134.977835-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179423058020.994134.14656142555028492016@kernel.org>
References: <179423058020.994134.14656142555028492016@kernel.org>
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

On 2026-11-09 08:23, Sashiko wrote:
> [Medium] In test_dp_features, the skip path does not call ovs_exit_sig.
> [Low] CONFIG_NET_TC_SKB_EXT is not in sort order.
> [Low] Should CONFIG_NET_SCHED=y be added to the fragment too?

All three are in v3. The recirc round is a test of its own now, and it
calls ovs_exit_sig before it returns the skip code, like the other skips
in the middle of a test in that file.

The fragment has CONFIG_NET_SCHED=y, CONFIG_NET_CLS_ACT=y and
CONFIG_NET_TC_SKB_EXT=y, with the last one after CONFIG_NET_IPGRE_DEMUX
in the order that ignores underscores.

Two more changes on the way. The skip reason is printed to stdout, so a
run that skipped the recirc round no longer ends as a plain pass with no
sign that the round did not run. And the expected errno is read from
python rather than written as 95, because EOPNOTSUPP is 45 on alpha and
sparc, 122 on mips and 223 on parisc, where a hardcoded number would
turn a real failure into a skip.
