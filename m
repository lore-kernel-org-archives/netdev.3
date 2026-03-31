Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7836330D35;
	Tue, 31 Mar 2026 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919743; cv=none; b=f7jCc6v549k/dNxiQIcyz9dNivPy02J1pSAHJih2VDjfJtM31R/UH0wWK8E3nZiQNbGxexL7q6CbCXH2C2YBuCtHKHdKsBN9wpuxEpdhwrlY5QeJd4prp3u/tgbecLeUftjV/3237cAjPO3Pn36/o2SgCpSZGcW5Lgb+eB3QB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919743; c=relaxed/simple;
	bh=UBaPmHil6IXzTPcGISlvOCZ/I22GqdHJcpvM+detDE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoJ/9saY9eve3vnlKM8/GhjtLvZ4ND2ZocgtEArV2ndopUN4GzYK3buSvh+qVJtjbLRBEvtbKltqZ8Kad/voNI31TDDhT3Q9GgNOvqCqUaZeUG47xWBlYNz0wZ/ZI3dQhlYp4j/GjBa0njdL9e0YDZPXdMn9tZGBInzYpzuriIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGFqBAq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGFqBAq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50D2C4CEF7;
	Tue, 31 Mar 2026 01:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774919742;
	bh=UBaPmHil6IXzTPcGISlvOCZ/I22GqdHJcpvM+detDE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGFqBAq1gLiql5UYZ9Thr89MaqQPfSieEyrRByzEnmw6W+UlRkoRuYXeAWU5f20VC
	 RK5GTMSeEJWqFA8QQlXDFYZPWnLx8byWoqB0TKBB9kEEMFWr5Qsm0FEHThKMEnWhwf
	 Vrja5eqoS+ixLOqethGSfQN/E1D+IJmizzqGQvNU5ugeT/ZOkyIp/HyhRLY3MVKxgi
	 LPpZsCuFtMG2tCO++trNyTdDRKwOrTStV60XIzLCxjDQGQCVDG+DbBgRg0FgJZwCMf
	 8dcFC2hcoT/blb1ciC0UcEjA85CyGgFUR/AaTvz8lIrFJZYVxGbZprsnLqhcRsasP8
	 xAyfh9brUonWQ==
Date: Mon, 30 Mar 2026 18:15:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kangzheng Gu <xiaoguai0992@gmail.com>
Cc: gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kees@kernel.org, p@1g4.org,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-shapers: free rollback entries using kfree_rcu
Message-ID: <20260330181541.5a3c9f73@kernel.org>
In-Reply-To: <20260328185804.41325-1-xiaoguai0992@gmail.com>
References: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com>
	<20260328185804.41325-1-xiaoguai0992@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Mar 2026 18:58:04 +0000 Kangzheng Gu wrote:
> net_shaper_rollback() removes NET_SHAPER_NOT_VALID entries and frees
> them using kfree(), which can race with net_shaper_nl_get_dumpit() and
> lead to a use-after-free in net_shaper_fill_one().
> 
> Use kfree_rcu() instead of kfree() to free rollback entries, since
> net_shaper_nl_get_dumpit() protects shaper access with rcu_read_lock().

If dump can see NOT_VALID entries we have a bigger problem than a UAF
don't you think? :/
