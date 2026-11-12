Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501220;
	b=iglIqTP5u4+89gLnBPR55MPooGiM96zhPlFHSe1/DqPfrxhgxD9bnwPfd6Q0bZGlbDAI
	 npdCIjvoSHoTTIcp3lEAIxcs1mkA8kZeaAbDHk58NlkBEVp2Sp/TwQXbTz4689fwoVQJn
	 AypPUiR2pLebNSpVGDY8v/pjZOpjhVg2FHHvkJKG5CquPfmmjwddk9GJQAnfwmfBygCFr
	 2q1j7SE2s5Vns9zXPHGDkgMgDbXVyeUxyG+xZ/8HFIqnzdNMqQtCgDmDMIUHUXIgjdc3l
	 v5r6aRpaxEZqFxKL8D4drSQqog83vYtf7Jkp7cOm8f6xNQW1CZ6H847bCkR6W3bK76w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501220;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y+y36wVI/Dfgd1WdEh5Z5HXjHzT/2gzfAPJDb0Rnf54=;
	b=UEzQgLztYHtn+/LxwnhE1NKMCv9a0UiLLc9Gv2t+cZ37jxHLlLEvNaV7c/ruPr6jKL9i
	 QtJCCbJMQQISPP1il2GYLWpNxViJhijVdJDpSl3pKYlV533Y0nksB2dtl6HpH499fqY/4
	 XzIMWP3dz+3KfcTBi869YwdRSDeNzSMFXM1/YpdCyquPnuaBmDQi/er2lXy03yHKKtKce
	 PI4ZpgEmgCw06YJgvMirFIz+swity//kEG5zef6y/qXraalysktqfWSdtsYoG3nkm51uC
	 dUvuzJuKjY0camvyboDQt5zKZcACp0qWiKVo9DPGjyykr0FrISgQhMAvO/jmigEhm/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNPmUobY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7360A5BE9;
	Thu, 12 Nov 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNPmUobY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14731F000C5;
	Thu, 12 Nov 2026 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501220;
	bh=Y+y36wVI/Dfgd1WdEh5Z5HXjHzT/2gzfAPJDb0Rnf54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fNPmUobY3Tt4N0S0iShSD3oZst2VWfjazlpW/bbw8Bc56qsIioCjoePIciRqGMpcz
	 mZTxsUQFPZ4PLjngCQEsQpFrwEGsp08MgyQfuTCkuToVtQdV/DMkiptjFgriAQ3NJV
	 JaZfOXFX0/3YgEgjg4Ihtc2fEk7wi7/xM0s2dhgT0b877s/vzBL+lzgJg4AfPSVP/9
	 8Ltu3uNZtMUVhD16wMxKCSG6zrek3ldfQHBxkKR2oqvexZzBEsgHmIfl4gIdzCUcsV
	 DRBu2LJ00r/K/ogMjAiLgaGsP2Unm27LhIvzJRx/dgW3uZrjA7s5A7ZQnP1axaAwFH
	 QBzYh5OBgByzw==
Date: Thu, 12 Nov 2026 08:33:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: <netdev-bot+sinfo@kernel.org>, <sean.tranchetti@oss.qualcomm.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4] net: qualcomm: rmnet: Update MTU handling during
 format changes
Message-ID: <20261112083339.0eabfebc@kernel.org>
In-Reply-To: <000801dd6f58$d38f1e00$7aad5a00$@oss.qualcomm.com>
References: <20261108075727.2031331-1-subash.a.kasiviswanathan@oss.qualcomm.com>
	<179412493254.488859.5909018726402609409@kernel.org>
	<000801dd6f58$d38f1e00$7aad5a00$@oss.qualcomm.com>
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

On Sun, 8 Nov 2026 01:11:58 -0700
subash.a.kasiviswanathan@oss.qualcomm.com wrote:
> > The evaluation is done by an LLM so it may be wrong, if you think that is the
> > case please reply and explain.  
> 
> The changes in the patch are addressing the code review comments from
> Sashiko and not tested on real hardware.

Add this info to the cover letter, like the bot is asking you to.
