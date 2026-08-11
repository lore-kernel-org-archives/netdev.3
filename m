Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FD42C4FA
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490620; cv=none; b=EDKXk+bCCDm6nEnB1Qs7IutL/GI/epwm8FkaARGV8ksI+z/Ih+AiUhVaAY+IuLXpJHk/P/JPdGdLIJ1oRbx8BlsGJWoCgcQE4Y8ZEdqMF7nLgqyaS/r9NF3bpWzNk5bJGmWN3PwXEYOrEA0wgj36FEmzyrzO4SkMi3v2cKEfXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490620; c=relaxed/simple;
	bh=Ot9Ma4G9S6KldkbD7iXDeKWbcfm1s5OnaLLJ4Fgthzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tubPbLJxXwUhZFQEsizgpeepapCBcSs+J7iOnILTfH+FuPKLL1tLCpiPg707WuaGNXrsnpYeVm1YSoYj97j8bmYXeRXyyZrcPIfnfyKO8L1VlttaQpJ0qETDhUr23AHbDXS3vyK6gmvmUS8CM2xYJ8LK+UzwEEdvEZkHE0y9I6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=JgjhEBHj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="JgjhEBHj"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dcbade417so453793a91.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1786490619; x=1787095419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OiMQjuZvICnDTAVzy019RWc7NqXgFAbZ/LVCKwIUSM=;
        b=JgjhEBHj/xRiEzJ42AksCtH5B6CFPVrkrsIYuilyc89Z0rHIw/Z7tiXWEYYkYcBcWy
         57BKyKsGm7dxdlSLif4zIUWnBlJpNwcT8RLVlQMapmZSf5Q5U9Ohi8WvebjfFW/W6TFh
         XyflvbErygk5KWMAEvE93vJLv5oMaVNIbkJA+Upm97Kkwl4kx8G++Elhii5cu9IBwv/a
         8/Plg4Mch+btdfbaVzl37Q+CeFLT7Awt1vM4Zq9hg1xFMZ0aLcFYKpCq00zny+KFzZlf
         NsOqETnqGeZ/hp4jDFIvzGRD/Rml1M95MHcnwCeD+syxeZnXfJdwpR9YDNiC8y+Gj/fu
         /YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786490619; x=1787095419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0OiMQjuZvICnDTAVzy019RWc7NqXgFAbZ/LVCKwIUSM=;
        b=IxNy7gQnNZ+UIWk8+DRMS0ntsszUo4lUMmJiKQteWtrrN0lKaI2Zl7Brqs3JeA5h+u
         881zzIqgVrcbRvBN6vuaRi06IOulZnxUQJVDE1qY3LokMM8JulPB+ipnv0kt3j/rtiYo
         T9GRe5W3atMgHTsTIAUXt1R0NJHyTv/puNQlt0qjA26HqppOrrg1vjyb6Ggv5/XJAXiC
         /yPnMmsVLdgB/9n5OWGhve8R92uDHgLUe8S4z92dPOvukI9/IS8JkQHdJq4LE+/CyjKd
         jHx7UHqg8WTWMdxc3AoqZ1Cclyv6VjpMA8gJLokyv22pBeAzMbbs1apENx7zl6Nrdd1g
         Zbbw==
X-Gm-Message-State: AOJu0Yz8mBa9hsICAD5CI+J1F32I8ZxUM08Mg1GxTTnHuSjHTkW2ge6z
	35UQwv14eVM9Gojz5AlvaQ0121RV5kUaJhPSW2apGO4pH1Lfo51YN9aTHud908GKvIw=
X-Gm-Gg: AR+sD10UhPyNNgLHyK7yijwLe4GBYS9rrrjFhTBVC0RBVWIT/1Jpeuef8nP/Z0wTdA9
	r8p8EvvZq6ipSJnSJnzAKKc6qgzQEdJJnFC0ScSds3Z0m/H4xpJIlT/O0k+Z2m1SwUgM4zXltUU
	mEpUJFUHchNc0Lig1MA7bkZpfPNz8K4emYoDJIxlkwcEYzwKm1PFTIZTCC+6gGIwv5jGFtcpIII
	rqgwUA/uTTKBeqAODC2jllPUd0CwMOh3J6onlEOnQNgimVRu6djRX8u9jjG9/q/q31zip/5qyMU
	SrfNXh5Rsq/ZgrbHLJaPgUtiY3BhpfX4N8btWydYKCuV6QSdk0KJEte14lW38lFDQTtlxbl6rwR
	/Tta9E0n5N+3anc8KzPzRpSjXJfmSaIpDc65FjFeSpYd3z7Q7nrFd72ayUC+4qPfYCHWWOUlmt9
	EpAa+5tr12quJfYku9gQivLJA2eUlJSxU1AMhebxdj4luTqENj1wUMHFE5EF5lqbs4FQRjEC9Vp
	398Q9fITX8=
X-Received: by 2002:a17:90b:390c:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3930119eff3mr683321a91.1.1786490618907;
        Tue, 11 Aug 2026 16:23:38 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:365f:6c09:b402:1986])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392fe4b1659sm259260a91.3.2026.08.11.16.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:23:38 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: leitao@debian.org
Cc: netdev@vger.kernel.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	wenjia@linux.ibm.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net v5 1/3] net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()
Date: Wed, 12 Aug 2026 08:23:23 +0900
Message-ID: <20260811232323.47117-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <anNA7V8wqhI6OEqf@gmail.com>
References: <anNA7V8wqhI6OEqf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Instead of these two kfree, can you just 'goto out' ? out: seems to do
> the free nows, and rc is 0 above.

Done in v6.

> Also, is send_req_add_link_resp always false in smc_llc_srv_add_link() ?

Not throughout: it is true for a peer REQ_ADD_LINK, and the early gotos
above smc_llc.c:1495 use it.  Every path that reaches the success return
passes that line, which clears it, so it is false there and the goto is
equivalent - with your suggestion applied the object code of
smc_llc_srv_add_link() is unchanged.

Best regards,
Yehyeong Lee
