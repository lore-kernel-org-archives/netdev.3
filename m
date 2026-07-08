Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AB3E8685
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493590; cv=none; b=ukXtwN3VZp3+rODcwpr95MnxXGlX+iYs17YRcXJcUoLvUVlCEwVk2LcAJaxauAHZ73bCfC1Xxx1oM7AblHi5y/0mlDL+PbnUQNMw9c9QluEHA6wsjcYa3OxGGfP6ETykqsRBnshOczIbVIkWPeuxkc4madyJsENThcwkBPxZnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493590; c=relaxed/simple;
	bh=YTZC1tr0nF6mz4Z+4cqem9+KX4IQ0CP2cybl++qADNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZ1t5CQ0HiXz+mqpIUadgn4rU97gpEQKAD0USxYcF7krchyuEE8nnvy9Rs6DLK2GKMC82E8B8vjwE9pwbIkO8ILpWJaFrRzPIenlUmttrSk757GTCPDhS/zFCtSM5dfvo6zpKQ5bHPAP1P416SqOleR1gRCkzpS7VaArP+ImWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np8YW2Hn; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np8YW2Hn"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so211316a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783493582; x=1784098382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTZC1tr0nF6mz4Z+4cqem9+KX4IQ0CP2cybl++qADNQ=;
        b=Np8YW2HnkALw/xRrFfngFUj8otJKmcYuTIIN/db4lY5ISBdJricV67NiABm5y2FS+f
         MPNQ+HoPRztd7y+Ga/tm3kJIrHR4wGJ4znD153WbviAguRHlgblZ00A5KCNF6gtR2ZSI
         kgorU6o2TvE6HG+SYBXCvA8x4AxyqEt5hU6OimI3DBoYFJJrybgCWpScUIrT+l72fOgK
         le0WYDAlvjXSWGszj4tfOc6rlc69HhIKYPoADVM3i5hfxZQX4/DrciTD4S+lUGy6g+ZS
         J514ayb6O2x99c5Z6x7mQ0UzYvBm4zrdAfVckr4i+3+0XR6FHaBixcyULUQ5skgqJFRO
         1tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783493582; x=1784098382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTZC1tr0nF6mz4Z+4cqem9+KX4IQ0CP2cybl++qADNQ=;
        b=g92B6G7dTB4go1a1ZXMF0JPK+ctfufW1Og8uaHzs33e90jR/c4mRVcRZk3qafyq4Po
         kcNFTqk6fIhrn+OZwac/der49ge8qOvw5BKM5f4hhX7vBGwyFsMMN3bd28MERtRpS4eq
         yI9ARU5ka6laudwvcMBY7YoPEUdkYZIOSgoHS+PFioQHIgmyXJW48n2ZJNuyd8zX2pR0
         lPj/jKLZkyWWfkdwgsTalMfkP2CI+dSbv/wZhpOn9RrFyoXsPA4HkaYXK7sr10eDxEF8
         i+lKdrIFkN3SqVsAP39kITvNn6dt5al/IBW/7Engdo9haiD+CSh8BXEYXrLiUFYdboNw
         FGxw==
X-Forwarded-Encrypted: i=1; AHgh+RpHCHwEhMSHjg1IU/J81JjZU+raymT1tqXhDNRRNwzhIijroKmPjTS6fwrXDcurZrHUOC1JrQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/omvmI9Tfwj7TuLSyZpyiwkWxhsBOPORa8/ImQI/dJc5XaQe
	bFFbjb5gsEsMmW41dmZHK30RVhMWPb5OdlStjs1NtPXf2ZetGLKp5+P+
X-Gm-Gg: AfdE7cmAZWwzZphSkjtLV9pGwkpBnaufqNa0wyfIc+/BtfOjU7QylSfMNn5WzLfNZLf
	1D2UmtUOeAyak45x/txNvhuXDD7nlBpzj4EwEaswbg4+XPTt1sowsKNBtrTSy4n8s5MIHBnctwy
	QDgyN/9NRjEHCVvOoij7Cxl+oUdGE02dsus7F1PlJx7flKF4hGvFRWzg8E2tXagEbPftVxACwTa
	DmA9dP72eVpCfhAJ9tEiAysDWzRJ8g76XICopaBQCHqM3wyp23TjxHjzT7hTWKO71/bq598sEd3
	z45wM8/onL4dApxfFwxpM5w+sOHwW4wR0oGzbG57WQb2GHgi/wg+53cMDaPN6BBKIzn2/ifGLcL
	9rI9fe7yd/pmxpkVCVH9O7voRxXOfBepYdvlKfGs0lkXU5jBdWiPcPT2WmvKazi/Z4Q+R9hiOeM
	K78rMT/xlsGBBfYDqIL/rORs9y0mdwBipEKCzxjMO+e3WzbezKqoYAdZcXtUuI
X-Received: by 2002:a05:6a20:258b:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3c0bceb6c9fmr1504879637.19.1783493582085;
        Tue, 07 Jul 2026 23:53:02 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm18477898c88.8.2026.07.07.23.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:53:01 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: emil@etsalapatis.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	eyal.birger@gmail.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rongtao@cestc.cn,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	toke@redhat.com,
	yatsenko@meta.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
Date: Wed,  8 Jul 2026 12:22:50 +0530
Message-ID: <20260708065250.707983-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DJSKN0TVIESF.1RVIJ8SRZRRBE@etsalapatis.com>
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com> <20260704092159.1256823-4-avinash.duduskar@gmail.com> <DJSKN0TVIESF.1RVIJ8SRZRRBE@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Here we add a bunch of shorthands for the topology we're setting up,
> but not for all interfaces/IPs. E.g.,
[...]
> The IPs are hardcoded here (and in the rest of the code below). AFAICT the
> logic is that the defines are to make it more obvious as to what the test
> is about. Is there a logic of this kind behind the naming convention?

Yes, the rule is inherited from the file: a value gets a define when
setup_netns() and the assertion table both use it, so the two sites
cannot drift and a table arm names what it targets (.daddr =
IPV4_VLAN_GW reads as intent). The new defines follow that.

The hardcoded addresses are in the netns and live-frames subtests,
which build their own single-function topologies the table never
references, so there is no second site to keep in sync. The bare
"veth1"/"veth2" strings predate this series; I left them alone rather
than churn lines the series does not otherwise touch.

The netns subtest does repeat its 10.66.0.x addresses a few times,
though, so I will give those a local define in v7 to keep the new code
consistent with itself.

Thanks for the reviews!

Avi
