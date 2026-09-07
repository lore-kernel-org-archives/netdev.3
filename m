Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C444BCB4
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773507; cv=none; b=AX5tumFymzfE4jrW4KkOgDI50FjLw4o0j5IeEJejeYvyFrEdpR3i6WDZo3OawSDFn2VBStdGn4MajtpBwNOQGjtxZo1LYZ6YKAXhgO/r6kw4tgWbYTd1H1WfA+Hve4VNmMWYGHOzmZS79ZA/wu7NnaJQpQUXBvXnwv11a63sOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773507; c=relaxed/simple;
	bh=Th+Z1q0V4zPiQYGZPxtT9YSQKgS/aF+czsGn/Ny+bDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIFv4MCBV4peWVnrsCYRbfebuDgz+oLLjL6LSzCb4156Yunj5+zNzrgDygeTsi7QX0EZleMe4d5eum11DomJUznrqlT/Snsfk4YEApNEex7HF1YQGrbW3uUa8oD3IU9K5ftNSOl8yWKagnCvTJMgGB8wd2y5c58H2SXWS5kVGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW5+NEID; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW5+NEID"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f0167e59a3so2247199a34.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788773505; x=1789378305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vh36yaSDktV57csBdLTXMj3w1R2afjebrhYltH9Evw4=;
        b=dW5+NEIDIDCU1lIVCZE0WcbWayJJFOY1wVqVu31s1DiKcsB6R4NT1x8NcP5cQWvsDF
         rwJS+vQga1XPrjYW54uFjpgPMueZzOMok+BnGLzAPK75rQq7u5y1fiCqqINlT8CrOU0s
         f0jTHiyH16LXl4s57uU5G2vPSSqfLVtIs5pI6mrUxEigN9hxCh/jJyiaeBCs7FE8qx2W
         z+v25oJhDw9C1jzY0vvp2dkJhjbTk9s3LS/yq7Rz8UQcC9G4BKf9pTi+P7UCIGtgwi29
         deAQC+i6zpZcSh1wjC4QMVNU/LHVOp39fOoLL+15s2BQtf9N3r8s9cl9fnuFwwp58dRV
         hIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773505; x=1789378305;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vh36yaSDktV57csBdLTXMj3w1R2afjebrhYltH9Evw4=;
        b=bzBkWEeKG1xJCE/hK5lBSF4wQn36Rsg4ilPrarfccOVBok/ONtznLL0uhd8BDi3y4S
         cf2cX5LImw/0kgyjH8eeInFNYC2GxgLvB3KEn//+lbV6QzIJ+EuExqkx8uaDf5B3ZMRn
         ZP/CUtKRC1I1ETe1XcwJK8gp7M3rZz3nurz96eOyh6IY0NBBEnlji/O10uU+mhe3/CwS
         KSH0qx0iwGgEmu62zukuYZNaSVD7AESnqJ1F2REgYNRDMUM1AKnVAyCiFpCzcOs3TzJZ
         35RKfUhJWTZ2S8PWqDeEJQWKbk4q1HrGCHmb9ox8L3Vw3msDzsS8xJMAtiuiyi7EPcv9
         lApA==
X-Forwarded-Encrypted: i=1; AKwUvBxHtuTfctmkDOsObcWGhdfFsVbOceJ7SP4lrTyeNXkoKPtViwZxKyYZevvhzFGysWPAjxzoQ7A=@vger.kernel.org
X-Gm-Message-State: AFuF++nN2R8fkVP/GNhAi5grXweqr/MOfIxf+fuZoIAqQTV6/xwjDbEm
	DzDO5kG7dfewZR9E5iYA8T4IHnmNtekCjluX2b5ydd/8Bkp0K5HpnJ/1J3KJQ9IyeIM=
X-Gm-Gg: AYBFou3IeOQtckPAJXvqMovPwy55MnPc3WycnGbnHVmL4pqe+7RnQHfUvlJmBZ+74Fh
	vDbflsK1BK6r7tUIHDH6LiNOjYD5PouX2960eJ3CY6LsRupM6H8xl4rECzdPyNYbYVnrS1RCO/U
	pRRpaLeGLV1FCo1inLGst4SLH89P6CHUupeTJvYv94GwTGuZF3QvNg0QGzNHOcRZc17Jz0Cb8tD
	3GOFUK+jg7vdCZr4w7+NBLQEQEmg74TOaxLW2W9RaIlHFrEAXMQJoZ7+z9ntBTsQzlePgbVKdZH
	nfrMCh9ZYO5zQssgwNzhpvV5Xv4k5tThvs0ITzWN6hcEY5lo+OxSyhrC0LhX/a45KIXAvepT/W7
	vPjmddgJE+wWAeITyyL+pDigOyVke13HItiDdP8f3OmA3XHY7CLq1S78ttlb0hRQfaiDiAXBFIE
	BOHq4nKr+Gpj4Nz6mJD8764Oj/51UobaUjpaul5ZJwDudI3Jg/9vYJieXzhbnvzcIzYQGFYu30k
	AWeYRWEgboPwA==
X-Received: by 2002:a05:6830:34a0:b0:7fa:ab72:9e04 with SMTP id 46e09a7af769-7faab72a877mr12868818a34.28.1788773504746;
        Mon, 07 Sep 2026 02:31:44 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33517b57ac8sm16320232eec.28.2026.09.07.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:31:44 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fix repeated word 'to' in comment
Date: Mon,  7 Sep 2026 15:01:38 +0530
Message-ID: <20260907093138.24589-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aa963ff1-0cfb-48de-ba76-d37467676a78@linux.dev>
References: <20260907063804.26581-1-hemanth.selam@gmail.com> <aa963ff1-0cfb-48de-ba76-d37467676a78@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 04:16:00PM +0800, Xuanqiang Luo wrote:
> Typo fixes are cleanups.
> Please specify the target tree: use [PATCH net-next] instead of a bare
> [PATCH].

You are right, and thank you for the correction.  I missed
maintainer-netdev.rst on this; it asks for the tree in the subject and I
sent these with a bare [PATCH].

The same document also asks not to repost within 24 hours, so rather
than resend immediately I will send v2 tomorrow as

  [PATCH net-next] gtp: fix repeated word 'to' in comment

which also fixes the subject prefix, since "net:" does not name the file
being touched.  I will do the same for the other patches I sent to
netdev today, and use the right tree for the wireless and wpan ones.

Hemanth
