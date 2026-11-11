Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422161;
	b=1tt5DWIo28kpo8PpTFtUvrQabbrpcbDUTvIombQKslTxYwNtPfNmwxC3QXJCZkrz2PBF
	 hdauoucUsf8ZuXSbjZoe9y/I78agPa7N6gZkONI+jNhgpWLar9yihQdB0y/90l8Gc93Zk
	 tIsrt6Z5ZxPH4FXKgUyrH4mUkQzhJrvnlc0xfkCNMjGRKdpihXcXZ+4ZDhRhopcW0mJjD
	 MIVIA3qip4gSwoIeBda0/hn060Kw4bq2JlqytvKQFrUKkduIgBH1xsevCbX2LCaQck6Ih
	 agmeHsknWlr1sAP+UDdciIgdaOO5VpSWhk/9xUYGXvwtWkPcRLrosQhf48vJlIh+RNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422161;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0nCJqNALzoa38q4NghyGBa8FqmSfaNqLC5xygejX/0E=;
	b=t/LGpc+KGyBnxVmrElfBwJUrXd9oxDrew71FGD/k7g/JCzKroygRGQVKOPCyzCrQmgAr
	 O1Frp76TP6zju1bIP8fiwnI52anBWghW1KxoEjfK/Li9rbMBpuiWeQrkevAnp+LyYozSb
	 bSzOlBLxr5UeYhD/V3q16/L9apSk4i3dnZx1mg5bvS0TqeLdKxra263dCY70i/DNX/HLM
	 1p4O2U/Lm1KGP0/XAcocSL0UAN5RirZpg7s1Stvwh9NTDtOA+P8ky+RoZQ1+reDMdqSHP
	 mLFl4geTBtDJjRUKv/v6a10pvaDkVMqxwJLVmI5YwrlFAfNWlxfhipO/JFgD637TQtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZX4Mrvrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBA606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZX4Mrvrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7E01F00A05;
	Wed, 11 Nov 2026 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422160;
	bh=0nCJqNALzoa38q4NghyGBa8FqmSfaNqLC5xygejX/0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZX4MrvrdjE0YnOL0mjA+OxE/qVBulxapiEiqkE7yAtsTz0IfGg74jsiRoAv9GTEUw
	 791CnSZXgPJbSRYS0AsHahqawFiFODUdWIqguB/MrGLPy6I+RuvRMwxkuwVN7y2HLW
	 49WIiYqMrTpy/lSwy4u0YwUKO383TkbnN5l9qh1znSIeXSh3Rr5cp6TVpQ6HzEdUoT
	 uCKNDTOX1mEaaC6TOGYFlqS7HtdpkgpHf+7NQivMnVzLqqBNqIMVAJzChSlQtLsz1T
	 Q/ZtukOnEfBAeRfyuUKMbRG+6TIvyU6IaaUoVkybRJBWAr7vM5Oz2B7Z8Pzkppc2wA
	 Zaef1Eak+xH6A==
Date: Wed, 11 Nov 2026 10:35:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 kameroncarr@linux.microsoft.com, ernis@linux.microsoft.com
Subject: Re: [PATCH net-next v2 3/5] hv_netvsc: treat the VF's XDP program
 the way bonding treats a slave's
Message-ID: <20261111103559.6a5ea13f@kernel.org>
In-Reply-To: <179439413096.2199510.13357896520403888843@kernel.org>
References: <20261109194843.1353592-4-kuba@kernel.org>
	<179439413096.2199510.13357896520403888843@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 10:48:50 +0000 netdev-bot+sashiko@kernel.org wrote:
> This take-back depends on netvsc's channel program, not on whether a
> program was actually pushed to the VF. Can the VF be left running
> netvsc's program when the two get out of sync?

Yes, the netvsc changes unblock core work which will let us distinguish
which progs were propagated and which attached directly. IOW fixing this
is sort of the point of the work..
