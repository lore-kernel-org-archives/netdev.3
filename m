Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD735CB7B
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304417; cv=none; b=q6IgLhAUkXXVt1OnVk1sG/QNbpFC2OlBmWskGMz5KV/yOTIt3PdHMx0tI06SvhNOTkHltFbDnugFoBkq8wKhGeJYM9JyIsv0oPAL0dIL8ap0p7Q81qUVaQcq9vlqO71OSkFNIfNG3H7f9hhmq2+bBGtZ4cd2x7FL4r6Fau8Sy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304417; c=relaxed/simple;
	bh=bYXy3LdMj+0XWlcZO03oYQc6uOT3hzveDRqcIhsWjcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KHKi3Wv6DxBzGIka4jVsJVC7Hzf6HgNi3xjC4ZHulfdW41OFAHqJ3l46gDe6+2wyUy5TlTtd2IGkATfklyWlDFpn5y+KL0HiD3nAZ2gqPZjHGp1E3wvWwbnEGiFTwy/Y9Bij83BcdBohzLLo7up38nv2t4EZdeIl2QN9J2XjsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsRkOhn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsRkOhn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487DEC4CEF7;
	Mon, 23 Mar 2026 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774304417;
	bh=bYXy3LdMj+0XWlcZO03oYQc6uOT3hzveDRqcIhsWjcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LsRkOhn935rAVUXAN56mv/yfOFeKXpBNOFK4iU+/i2v8bp07rTM0BMVN6sn4HTdqS
	 7DDYTJcitjUK2j5ZUiNusRiD6VmkHr1dVk3eMT4rts8b58IFwhMQoRrPQdcsS70Yo/
	 YB//i7jAxXWTPXuUhf8JLgWPE3WNeGkNOSTx/ROrCYDnEdl27NmaqAGikhVlVvJ/vU
	 JEPONe4rHQFREY1ECd1qsiZ8W/dbhJ+SqXXc6wRlxTQ3TPUPPyNK6BDXz1ebuI8YXO
	 LDiEnBgtXLqt3dgjkQAKYkdOrhHNGiaMVZB8TwsGnV+rf1sAHxMHgbJO+iXLwFlX2n
	 WtiP6dRz20ttQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3E3808200;
	Mon, 23 Mar 2026 22:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 ethtool] cmis: Fix incorrect LSB field used for
 wavelength
 tolerance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177430440554.345009.8468557542937446046.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 22:20:05 +0000
References: <20260321153905.644959-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260321153905.644959-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: danieller@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org,
 mkubecek@suse.cz, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Sat, 21 Mar 2026 08:39:02 -0700 you wrote:
> The wavelength tolerance calculation mistakenly uses the nominal
> wavelength LSB field (CMIS_NOM_WAVELENGTH_LSB) instead of the correct
> tolerance LSB field (CMIS_WAVELENGTH_TOL_LSB). This causes incorrect
> values to be reported for the "Laser wavelength tolerance".
> 
> Use CMIS_NOM_WAVELENGTH_LSB -> CMIS_WAVELENGTH_TOL_LSB.
> correct 0.005 nm LSB scaling for the tolerance field (per CMIS)
> 
> [...]

Here is the summary with links:
  - [v2,ethtool] cmis: Fix incorrect LSB field used for wavelength tolerance
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=40d272752bb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


