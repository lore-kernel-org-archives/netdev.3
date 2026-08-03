Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526FC414DC9
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765562; cv=none; b=rq8S3HywuP7iM8xKutCjKP7H+t+vjKlQyXHtb6CCr0n4tQltla4AU8wkat7KMtixRt/v+3yS3J+NLdaZjdZ4oyYbFvrIhalLm4n0GAsKLt1rTF9fM6JPoih4Tss9dofC73pCWnAQC+DmYs0g7zFduzrMV0K0M8HcxVQlwNTdzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765562; c=relaxed/simple;
	bh=h1cPNjRA/0r6gNoruyluM5SfZi1K6x5n92plUA+GKx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7+E4DufYwFc/eeIc93A+jjZ2JJDE0F3KxpTtFFs+3+W5/FMAPBu5h0rEpv7hJ75B6y0kNKQzWe9Tw/vXOvJSzIxkq0jz1ICTzBv0rX/7s5L58LOGAI7GpT1ZA2UQQoS0oj0jPb3R3j7dzLI/IEXXwQhLh7OK98ov1TAcJvKXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py69VPX3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py69VPX3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caf228a910so24839855ad.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785765560; x=1786370360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1cPNjRA/0r6gNoruyluM5SfZi1K6x5n92plUA+GKx8=;
        b=Py69VPX31Vw+i+BdHdAX31VjutgUXIWSPj1zbNJRFFvRUxNuh51OqmzjDYPFeyb6sV
         Pg85rBnXCSDlMCp71BI4m+m5Pa1K/enCZyh5TIcbzq4KtW5IN/t+bvvRJg7p6Kes/FWi
         oe4wHrc2R/Nqy4jXhp7AubKt8il2FHQvNsxHnMke/ITASMtqLotc8G5WiQ/zDQSe74gb
         BEmkiVdlDhUZxh2nOkNsFbpWXfceabwBLrBV1UfHkhwkahPMVqNPTRW/3IlBpCtoJqTz
         7g00zB7aGas+0itOBg8N9ri7UzCPvTIEPUBurTCsP8Z3XMA4fpFgMhyQjweky0Gkh3aW
         SdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785765560; x=1786370360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1cPNjRA/0r6gNoruyluM5SfZi1K6x5n92plUA+GKx8=;
        b=MsxyTQR/CBFgg8HV6vgVHqmH3jdWETmCcCw5u7+E/EM9lG4pKJOMFanDk2YGzyZ1tv
         1VMaeueokmrW0FlcT6N8szcKnB7JfyUOAynLBiQwhHlQHAXbUVvCXHsW21WY5It3bGZK
         MYYlbGttnRxCQ3kA2fCycdwhKaVi+lzX0JBQRa4jtXyXmbmLftszcW3U6wqq9jOeNnJF
         IhtXpcjB5jO13s3wwmNySQ/5bBR+CuHOXwejIF1bdNTB/wUhYwodeYXzdvCaO2F3/mS7
         xXzFF1ZuHGtVqVuHsyK/6CUvaubns0pEKJ2qxD0eRbzU970Zkjegzgcu1w84Q2/mP/Bn
         4HPw==
X-Forwarded-Encrypted: i=1; AHgh+RrS6hLlmzJ1/oCH03d0YmSNJSwUFyYMPFZrRclrgpPhnk5jphRrcR+vobx1hUvZlFaanwim7jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9yzsUFxhZzjFebt/6QEw02j0Xg/YakQnC3Rvus1IM/qO44ER
	Zd5JRDUu88a3eBwt8UXj77k/sppYeLqlvwQEUUx6z75D9cDy7GTMBzdx
X-Gm-Gg: AR+sD12A9VssyfUaThedptNUrfu2Tv9pVGLsrV4zLV9oDt/y7S8Ck4kMBSlpDmJFKHK
	NTkHCfbgW7x1505RVFf4hg2hp+OV2Vkq2U2fn03RNRxio7siu0gPQBnNXehp69ZbagF2GjOgL3+
	8zijm1i6Rk473dPSNFmpnClNxWglM8AH3UWWCOhujOJ4DJdd0vig8xhDmfQ21DCSov4FdJNhrmR
	BBX56aD4o0z97xFMX85XW2D5Ru6XiZeeMsm/52iGhdGOlUWjLMnfDNiLMWPIsXCC0nDaxgb8W9L
	9w5SG6RnYov+uCEZhAWJQifz/4QV8+goiYraZdVKxjKpT5rjWsiL9SA1gjbRzTvtKISzgRLkubu
	VbHAf03EyTolJGz9jcvbL0qnHn8hmAYa5K+S5kyT4KM/XaYl6yDKffqYgINyQYGSaoS0d7+V9EJ
	LtTtdq/z9xvJLu62RVQpyaMRic2xloITdghDfGof0S6YWajpjJNI64M+V7POwYlgP4OQvUa+Mju
	iXggPk=
X-Received: by 2002:a17:902:e5cd:b0:2ca:d7a0:1312 with SMTP id d9443c01a7336-2d05229a2a8mr101594235ad.25.1785765560531;
        Mon, 03 Aug 2026 06:59:20 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.149.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04aea2514sm38586875ad.37.2026.08.03.06.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:59:20 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: maciej.fijalkowski@intel.com
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Mon,  3 Aug 2026 09:59:15 -0400
Message-ID: <20260803135915.1615-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <amnJiQHa9s5PtLek@boxer>
References: <amnJiQHa9s5PtLek@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the suggestions. I am back and will prepare and send v3 in the next few days.
