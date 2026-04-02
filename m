Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4E2EBBAF
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144943; cv=none; b=dJ7cZe7855h8MNaF4D3nM1+1fvJGf13IHZ3DV93bpWHecNOHaWgwl9flRZvZB5u/n6SNhTEWcpLI9Ad0BCv4MlhWwDQSoXYmhNKye8odEmysa/gZU8hhGkkYbAD2nk+ztJpavMgFlHI+ChAC31TxqLIF7UFd1mdYekWDh/ndJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144943; c=relaxed/simple;
	bh=aelPaTj63pecJQRH2s38OpLDrj0abGCIvBltGquiMfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=il+YxIadUziW1egcPjv7f9OWYNBxS46P1ouoL1VaO+QM5gGkCM/0eN0PNWbBWgjkFnj2gEKMjmuzLb/YYetpFqDsFxBP2dPrjfPM2QhuT3uUfHNNPN4ziH0Q+IvRJlx9UBNkQOtSArbOZV82ykBE6ive+FNwQyPILxCVPsIpmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Dyb8LWcd; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Dyb8LWcd"
Received: by dvalin.narfation.org (Postfix) id 4C66020D7E;
	Thu, 02 Apr 2026 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1775144475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMLKN6+DFzl+KveR0ngqcK+e+QLEHyshk8tGIc9QbzQ=;
	b=Dyb8LWcdbbOgiyhpzVg7petD/yM5XsqLAiNoyKpQuSeYN6jOApYKdwv1XZZQXA9kuDM2fj
	ZzzgXlpj89C/wOQI4k0Nc87Qkf5GynHJnG7RF/yVxnBhkUquB76M8WgjEM+ck87R7LDMX0
	bBuNWO+jt22t+JaRo5sVKSaqbYNRRVQ=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	Ren Wei <n05ec@lzu.edu.cn>
Cc: Sven Eckelmann <sven@narfation.org>,
	marek.lindner@mailbox.org,
	antonio@mandelbit.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	caoruide123@gmail.com
Subject: Re: [PATCH net 1/1] batman-adv: reject oversized global TT response buffers
Date: Thu,  2 Apr 2026 17:40:50 +0200
Message-ID: <177514407836.3993083.12834978230665818269.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f1ae21c92be31b48651378f1ceba0dbbb43c2847.1774947926.git.caoruide123@gmail.com>
References: <f1ae21c92be31b48651378f1ceba0dbbb43c2847.1774947926.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 02 Apr 2026 23:12:31 +0800, Ren Wei wrote:
> batman-adv: reject oversized global TT response buffers

Applied, thanks!

[1/1] batman-adv: reject oversized global TT response buffers
      https://git.open-mesh.org/linux-merge.git/commit/?h=batadv/net&id=3a359bf5c61d52e7f09754108309d637532164a6

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>
