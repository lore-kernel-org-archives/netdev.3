Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BD286A7;
	Wed, 27 May 2026 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842473; cv=none; b=GbR9s3wbsGRi6Fov20E8py8a2ZqD+k/eVkbtIMPKNCLTJyqiG5aDS9DBw9k/gN63vFle1+jbpgBIs7tsJz23RD7lbBTu5+8bFgbBSAMSmeJA7tRDeMzYgiS/Y+LZKCV1OA+DdQDP5MVmgWn3B50aQZYifvynrpc39SKUvmKPeSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842473; c=relaxed/simple;
	bh=ra7Oz073RjE+U2+8J8dgz2QFCuDUuu+cO2z3gbGFVrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDfJohB/1fqsHeqEs6dk5oDoLpKFagiUHZLisUjSB0z4lRmasBNs/TYNcQBFbqIYjtye242Y9M2+rcxHlPAtT2fQuwsHWArGfqGZ1vD4RqLX0j5J7/kkk4KC3SGDUBkNzm1oYxxrXTS5m1BKndoOcvLmsJqzNRGCZSdnjz3POJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kscmmn5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kscmmn5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949001F000E9;
	Wed, 27 May 2026 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779842472;
	bh=eWkorYtFhHkTvSvLXaoXTvQR814IbU+cPMEBwMjnO7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kscmmn5Tax+6xxlIPAR7dUestp5ATZIKrFeFkepUqFMhgdlJyHUgh48ubPNF2kdFV
	 o26eTUXEb5FOa7P6EcxuKyej6ssUtYtcMJkSV5qYxwZoNJtsnnxyCVEzY4HNweYmkP
	 D1dwEd7eIcK5qFQLLTI8gcQ/0yUIl9ZgGkSBSFaAidVKUi4lCpRpjsQLheAn2H4nse
	 MlKUhqJ5iA7Uv5+bvddKMDe1/VxULFhjKkZz79X+lzTbA8l52/wj3NmsafrHqltN/s
	 QyfzkIvdpUreX/UqrQY9NiGNtneqqYrlfrGXU8KY5FFGFVjEC04k128PG8t5nVPfu0
	 q1IF4BnD5AyZA==
Date: Tue, 26 May 2026 17:41:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <han.junyang@zte.com.cn>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ran.ming@zte.com.cn>, <han.chengfei@zte.com.cn>,
 <zhang.yanze@zte.com.cn>
Subject: Re: [PATCH net-next v4 1/2] net/ethernet: add ZTE network driver
 support
Message-ID: <20260526174110.51876645@kernel.org>
In-Reply-To: <20260523174117467bbQo_yaI9XS_2nfd7pO6u@zte.com.cn>
References: <20260523174117467bbQo_yaI9XS_2nfd7pO6u@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 17:41:17 +0800 (CST) han.junyang@zte.com.cn wrote:
> Add basic framework for ZTE DingHai ethernet PF driver, including
> Kconfig/Makefile build support and PCIe device probe/remove skeleton.


sparse (make C=1) says:

drivers/net/ethernet/zte/dinghai/en_pf.c:405:43: warning: incorrect type in argument 2 (different address spaces)
drivers/net/ethernet/zte/dinghai/en_pf.c:405:43:    expected void [noderef] __iomem *
drivers/net/ethernet/zte/dinghai/en_pf.c:405:43:    got void *priv

please fix, and when you repost make sure that the posting is threaded
correctly (patches are in-reply-to the cover letter). Please use 
git send-email or b4 if possible.
-- 
pw-bot: cr
