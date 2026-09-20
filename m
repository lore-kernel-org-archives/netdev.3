Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE12D9ECB
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908646; cv=none; b=b53KrGRTwV30cJcz3axMjXmWF5vIBOHpewJ9WC+2S2veY7G1XjRnircbiNl9pCeFSuYWn2BMvaMniraEDpQiTOgosl+Pghg1UVE3io481x5bSeFGmM3pMiM6PhFDvzeX31QmTK+Y9DP1pK0OMAZDD0U7DuXpGjd/4/EMfL2VD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908646; c=relaxed/simple;
	bh=OH55odpVMa7sAvz5GT0UGHBaUUgDdOpKNkf9M4wvm7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMGHb5XuH4CqFrBLie4vzT29pb6Z22U/wszLm4owfwQFsY1C9eGhUjgL+S7FxPt6h2D08PMogsR1OiNs3jJw8wUVE1NwoyBRqapvkmmr40WzgUO/jpGcv3BSM6Z4+H+bS7wKBMsMjDNrNtgkDzBmNLIavlcvEjRdMzD4P3CIIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=EYphPP4b; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="EYphPP4b"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1891220a91.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789908631; x=1790513431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0NI5VxCFQynKWeJfcXnLCEZzTHswNnIGNtnh7X+/4c=;
        b=EYphPP4bKFYU2lT9RCxxV6hQJdlHlFfo82h2aFIhUPTPMZW0UPNM5bOiwvmILiKr4p
         Hwxo3YT8vJCSpf3uUWalJ0EXJTXlkZDCWdKfGPZ1PpIOSpSjb1smgUvLTkO/CZRwJS0j
         UrHnh6JF7+QHHQxZIFylvsJpFgwTl9gLFbu35iT7YKp+UIz5JdF1fKp7byh1IJd6PjTK
         L2xi2W92xh5uSiTHLlGEzN45jt07TELzk+Q++qeD6w9cuu48f3KE4aZEwE4BGMAj2KuG
         B7kYR6C9tPQYpc00mk6B7MCGBZ69HMUCPrgTfBSDFKtcmWEW+tb9WgHG3l4ShsrXO+MK
         KOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908631; x=1790513431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s0NI5VxCFQynKWeJfcXnLCEZzTHswNnIGNtnh7X+/4c=;
        b=cmtEUhf/0m/zPVyv5bhcHuZGv1giWfArU9WSMW6VnUgFsZrR7asfspwdOrfxS3KYDk
         z6J3/Pk0/fxHuvqwwHGjyrR4zf2JlnKknXP9cqeCh6UoKtsLE9hSAfDySDQ1b7tlDCMM
         +aXLL0dq664gNlCP5bf5IJ95UPiSBGl05CvWVKxGFTqCDn3Y5NrmR4K2mUgsCknjxCCR
         r7Q9rasuoe5EDAtgBz8LFB3KWU6oq1zO6tmMPNx0Q124j7/hWU3Ytg/kSbETR9fXGwbc
         8onP7CS1UChLqLmDG9aQBOFvyRy2jvTgzcOoYCFFIK90Gopd8MFFSWEXAzo7J98UkiWc
         Y8Tg==
X-Gm-Message-State: AFuF++nqu3p36MjLDuis/MqdmYFnjpS3ovTHQVWnv038Quy6rRb6cGYn
	lovvvkXDJy02l57C910hM6h+xDikck4EFnKO/eUAIrlATWRVJngxNU6h93D0NMxWnFAE3bPbBzD
	lNBpsvCq+AsiFI9RRTEcJdmz54jxrkXSm/lV6OTYSv4WhLrLgs3SQBtFSee/hgUxyL9xhUdDjb4
	w=
X-Gm-Gg: AYBFou18yuAiw9UWU0Whe5vcG3nxBIYvLhFYIXXOx+d3fG9bDyCuGfGQtUGDMqmq+Sq
	v9hHRBFOk9hDu7WJqxGjcySWS2Gx4cMB5i9wgQr/PnWaOIHsBTLIdEMna4Ds6HknT3jS02so2tU
	zGvC3kIOvunCAt9lmGVYejUESbb4qqe9G1QGt0fcQoq94CdKrwFhlJdC9niwkRolSCeU7O/lYrb
	a9vNXza/hHbi1SNtl1iZpsRevRG2aCbaAkH2VXUwD6ndz7tzBzzvk0+Ygo3j7vdP04w22ut+dml
	R/vPc3Cf88MYsuGG7xCm4MUKBypf+fNnPkCaJ51XkHQPfyceOHBujIvP0DmcUFEXO3Uo5v/J/zm
	c7HE3FVHenlepNazDhFsTYaueZ6XhPIGhcT9s2ohMj24nZbFp/cyEw8fYjiJ7xagh97iBaKYMAn
	Wzuo7omZhdofe4dUUWIHPBNE2fW/YNy0cTpRPNi8ER94vJKX9shQ/qPFQZ9iOtyyCm03/dJ8jyo
	RDuoVyFS1k=
X-Received: by 2002:a17:90a:4cc7:b0:3a0:4384:ae14 with SMTP id 98e67ed59e1d1-3a04393f375mr525178a91.20.1789908630612;
        Sun, 20 Sep 2026 05:50:30 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm4120272c88.6.2026.09.20.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:50:30 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	leon@kernel.org,
	huyn@nvidia.com,
	raeds@nvidia.com
Subject: Re: [PATCH net] xfrm: free the whole skb list on the packet offload drop
Date: Sun, 20 Sep 2026 20:50:19 +0800
Message-ID: <20260920125019.3609114-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920115048.3549614-1-wang.zhan@smartx.com>
References: <20260920115048.3549614-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please ignore this patch.  Re-reading the packet offload output path, I
cannot construct a case where that drop sees a segmented list, so it is
not fixing a reachable leak.

pw-bot: rejected
