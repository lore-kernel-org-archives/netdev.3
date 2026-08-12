Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB0440A0A
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539566; cv=none; b=pLsDNoxjaAycgp9bqjxMvZFgy9uCP9GukFgMXPiiGAT/8dkZRlEe97gIfxZ4At/0M/P5nEHbdLoidtl4yRBy27/vtDbYJ6g0evz6+qe8Pgp/aQQDA2ZtRNFd/djZcZVHwzQQwh5rMfaIs86IWdcakRO1xdeZ2uWQ0MJTMVzxCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539566; c=relaxed/simple;
	bh=pwPmH81nKJ/dKUdS2s7CTbyuKAaXa7TlPqH1NAnZE88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEA6CwaPeSl9Yi8T7yg1c/ukN1yWGWqYDGBlG7gNZygY/YzLdzYRK8VMoAFG9iXXyUI/L4GpZg/Ly2QBl1IKQJ6qT+GyDNScpTfQh4C/HS3XdMyQA4rabSQupoMCbl6g+0lG7d8NJuZ8TM8jBya8gFJUZmNfzymGr1RVCoUChJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huXcD3Y4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huXcD3Y4"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so805957a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786539564; x=1787144364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pwPmH81nKJ/dKUdS2s7CTbyuKAaXa7TlPqH1NAnZE88=;
        b=huXcD3Y4a+NGSEhnAUGpJITFh5w962uKMaKP9SbjOmgVuUJdBJAiaIcDfIn4YGjzZ+
         yOz8dk8IHfzNpanDbwl5E7TJpemEtCGizQqg42SDHZYFjFgbmcFgQD+einRaOf/iJj74
         vuO05TsgFd/I/lwY4VZWHVeRd2WRyr5GUBR+gczq8QNeg+RM4I3aaqFlf5/K/2vUE1a/
         9ZlUBv8ZhBUe+FD42x2e6sEGVu9UFQBhWEtuU+6Mov+bnhGtgnoPbMB+7DQm3mqicCou
         lWt1bpnEKoKFxAaifiT8R+jFTM8pNejJrWVH6sVyrL+tmg0nw8uZlCA2tMHiuUmQovvH
         WJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786539564; x=1787144364;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwPmH81nKJ/dKUdS2s7CTbyuKAaXa7TlPqH1NAnZE88=;
        b=Nx9WZUugh1zOAU6Dn1+lKeT6MEBYN80h5cAoxAYvhkQjOrJSlYEuibNWWXunQp9LVr
         ofjsmAR3KKqWU07ZEnPlW+IbJpNFZmkaEXW4eVXI5TSXUc6B/wY++nJc5ycvGuduiGx7
         Ymn0bI5Qym1RZ7ZE5OB+IpznmvVNU/lDqe44S11WLOMVb8j9w/AFKmtgxjaIKBNobpXx
         0+EGMo9Gi6qFBo/2w0USQBOL/AMqiJUGxS9pPq7zElIpADDamicSE5qe6S5NW9QCW+K5
         WBiGcfqjyOSJITrcFPjU5p5aA8DgJrOWQQ76yqli81yCwvs54a+m6x7PDK3BQGzFLmEW
         5GUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpe11lUQJrKXT63Yt3sg1JMcdlJTRei59nNsTBfVd0ZUsjHTlz1IlaQrhGtqt8Yb1CJIyAo67s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQFZE+wvhDyTmvDYen8mWARg5SggqLfowGmGfAlgYnbhxVhA0
	b7qMN5P48dzaPTy2vu8avT+90xW91bNhiuf3AzP7Bt3C3tvwHPNmMBIe
X-Gm-Gg: AR+sD114A32vRS1iP/hLlkqGb2Rp1uCGsxa1eT6lIB8uWRZXgVno5QAzBYCvoBK3wCE
	grnyywIiPeeOwL3ba3Tjqbgs0plfZ0wOg6IF0vh0/YDFUx4OL0NM7kqxD6V4Itufbzyh25UgQ0K
	yvF3cuCaRDgtTpsn3DMGzp/gEjTq4F0PS8jO6YimwKUK/+/AGyEMVPlJ4x1Xtyxj9DWc2FHqQNp
	atH0GTc1H3VW0h2TmNdM9KlCEchpfvzeck8kSW7IaGcwD54X/+owwa+WAM7DWpEn061yZcRpBeC
	KtohJzSRqLCMFYwhBHmkVs4tZL8Nenbnrf17BkpgQAyFMYkrUyIpP6q/Z3fKJ2olm41FXJf9sYf
	LyNrmEZRNYsz01nwvQtzrqDX8NLaYl50iC/QC2cBKxY5LX66NI+FLnPXBGa3japtXa3Gy99dmww
	ecMydH34cPBc9tut0c2htF1XDAYHRo3abp3Nt9nVH4iweN1IrHQq0fpdO23YlNDrUynydWs+2uq
	gcy
X-Received: by 2002:a17:90b:164b:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-3930128c13cmr4879261a91.7.1786539564092;
        Wed, 12 Aug 2026 05:59:24 -0700 (PDT)
Received: from zhuxin.hobot.cc ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392fe485255sm980949a91.2.2026.08.12.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:59:23 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	richardcochran@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
Date: Wed, 12 Aug 2026 20:59:12 +0800
Message-Id: <20260812202027.976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b3d90606-781a-4055-8529-e68e22a45ce9@bootlin.com>
References: <20260810100221.9166-1-zxyan0222@gmail.com> <b3d90606-781a-4055-8529-e68e22a45ce9@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maxime,

On 8/12/26 5:10 PM, Maxime Chevallier wrote:
> If there's an interrupt storm, then this should probably be a fix for -net
> with a Fixes tag.

There is no interrupt storm. XGMAC_TSIE was never enabled before this
patch (XGMAC_INT_DEFAULT_EN was LPIIE | PMTIE only), and
dwxgmac2_host_irq_status() masks the status with the enable mask, so
XGMAC_INT_TSIS could never fire. The actual symptom is that
auxiliary-snapshot extts events were never reported -- a feature that
was never wired up, not a live interrupt storm.

So I'd like to keep this on net-next as a new feature rather than
retarget it to net.

Thanks,
Zxyan

