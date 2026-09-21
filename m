Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D84E0B78
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016220; cv=none; b=qX08nGFQRCKaeZQl1PkS1QmHXze8T0EBhyQA4zrJX/PVU+5llwFdgT8UQEbR8s502LB0VOVhMV/FKaMT9ocEk2KR5uLyVpNTxFHYPCmC4ZnQaIfKmLfAodrh0giOW6GXybKS8dbd4Dyk5vE4ZGCg8Sd/t6Vxed9E46+b3ioCC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016220; c=relaxed/simple;
	bh=8xVNcCCnqs8JZAkv5ynaLQmALpySnD0v2Xf2MRO697w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0pgD7WDX8YDbWprI1SOHguuVBfLaTMU3pbLwWliIEBXsLoKWd2Gf32/MwHgKvlAiP9vJ3l7Ucw/qxqDjIgBH6+X+c5hMOzJ/m8jgZ8kyPKDbLOFLoeSjmowG8wftM0UEOD/GVwIYQ7P2Xi4hM4/hG5rN+YFCJ2zLOH2bcZ9MbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jql/xAwP; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jql/xAwP"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so2455330a91.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790016217; x=1790621017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xVNcCCnqs8JZAkv5ynaLQmALpySnD0v2Xf2MRO697w=;
        b=Jql/xAwPmwg6ql8IeZd+1LVZrqh++0GRdEurNQD2OSVTrwuo0wFvgMlpqHi4pD9BFB
         +HMScaT7HRyCdlUPmzQ/ReL0AQpQci1x0qHjo0V3tgJMytvIcCL/AzcideLDEGflOKNC
         xdrNtBlnJGEYOrhQp2MEkPgmIh0N9jdtou2QzG6JKo9Q2BFxbe0e1Y1XpHd2VXFpJLrY
         iSEyFnRSwdQANf5hfiF+beQNQro07NG4S1kPA3zW2FzYiWjPpfItZ0GbQ5j5X0F5nErv
         rkbipOu06DEAxCPGMqqOsJ64qH+UWSAXKZa2MmOaNtxr5iGsvyNVHxQ0HmmByW6Dd36o
         ZuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790016217; x=1790621017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xVNcCCnqs8JZAkv5ynaLQmALpySnD0v2Xf2MRO697w=;
        b=gyPMX0MWGrlRzpY4W42QYzeKaLEHUhypKVQScm6WQEp67TgpILpnppq6LLZ4nEa8lE
         iUAqQlK2ICE2HkYtDhCWwkGdskK0YTzm42MFz/mRxdHRwfJmo9t70EEylnhtZh3bxPZW
         4XfsgA1cPeUKujtHRSZdWNbPpQhI6FrGmFDVd9U8axQYfMQI8mJXmJhIfRdWfSau27Cq
         ueYeyW6zEz8RWIHYPVWkC7lhtSXSG3hN0sqx/OJ+S6m9ueDPsTPKQBc/+ARn7Wvto7yB
         ZeRFsRSBLGnegLgq6kuiKpv/J4KQGGF/l4SGxBDkEYmzwzC0bjtqb2PmVJXO9nWncsUN
         xZKA==
X-Forwarded-Encrypted: i=1; AKwUvByDVB1UXLO23IrqBkrbQIEZcPGplHLNPVrV9wiegXqpCnLIwBF9EJ89Ey8BidDFhQKh2lEnDBo=@vger.kernel.org
X-Gm-Message-State: AFuF++n/qy/SbfYlrLPugWwi+yr+RhXhTfE11mFg0BMYrO+XjdSc6esY
	ZrtiBhPczRLXwgbyB0n8Ncnzpjou55XpLLEwC6bfCyGTiHy/o2Omtx0b
X-Gm-Gg: AYBFou1U3VfI7zgp2yVS2sEMnNfFkMGurVFUkuX/+vcb7VYu4iWm6beGhYdHGOyuGtV
	/u9Y0dOhJBXtE1mcUYQWHcENNj1FyNP5ZiPSHDR06V4xy/Az7E+gZ7tWcM99+Dl4qQm3MAA7Bld
	+dc8h11wAo1wusw7f6IGiGxlM6kfGRZubgU8J2HI1g5WIXodTnM0V+KNhaPVIf+mfg9R32Qosol
	VQNhtQU3wxeemLNoSMAxgLmsogtx4waDgRoowfZbm0nbijx8nKgZJDDnF6TQzzjfParkwdTO1nQ
	ie/BMmpVDbyuNopWcw6YnMkPu1WAKBQ6DtYlyfZ7thLXCEsbiAskbykfkzMxnxxBzDelCpThKLM
	oL/J6wuImzsWrupbG0BCSjzzWywiTfrA/a7irB5hq0VqG2B3yptYV02cZYSZpR3USPm3136hM3w
	Q4JsKu9Bj21dRW39dsSvxzJ9DHnKVdO55wsUuZVuLvSMYjH16PPGUiK+oKVf0BPm71dEEO
X-Received: by 2002:a17:90b:56c5:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-39e549787b4mr18463027a91.0.1790016216901;
        Mon, 21 Sep 2026 11:43:36 -0700 (PDT)
Received: from localhost ([180.184.77.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06702167esm611149a91.1.2026.09.21.11.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:43:35 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dairui Zhang <zhangdairui@gmail.com>
Subject: Re: [BUG] net: devmem: NETDEV_CMD_BIND_TX has no permission check and no accounting
Date: Tue, 22 Sep 2026 02:43:31 +0800
Message-ID: <20260921184331.1415909-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arF4n8rQtVzxy0da@devvm7509.cco0.facebook.com>
References: <arF4n8rQtVzxy0da@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stanislav Fomichev wrote:
> I was gonna do it, but looks like you volunteered yourself? We do
> get this almost every day now:
>
> https://lore.kernel.org/netdev/20260918150858.3c98728d@kernel.org/

Thanks for the pointer - I see the same flag patch was posted just
a few days ago. Sorry for adding to the pile, I should have
searched the list harder before sending.

That leaves the accounting side as my one remaining question. With
bind-tx unprivileged on purpose, is there anything that stops a
user from exhausting memory and IOMMU mappings by binding over and
over? As far as I can see there's no per-socket or per-user limit,
the allocations don't go to memcg (GFP_KERNEL, devmem.c:214), and
repeated binds of the same dmabuf fd aren't deduplicated - but I
may well be missing a guard somewhere.

If there isn't one, is that a gap you'd want a patch for, or is it
considered acceptable in practice? Happy to help either way, just
tell me which direction you'd prefer.

Thanks,
Dairui Zhang
