Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4573994AD;
	Thu, 22 Jan 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098107; cv=none; b=DV4WrKsCFjCywZ5aDhj+taqH452/xRJ1FDpvgc+JL4KW1Occw5W/sZzsahzMx64GxjMJNO3CwzJGtzw5a3B4enQn7lKnhyrWuWk91H4cmIi1siPaif1LT4JQ1v15630Lz3Ra4/+wPrUOt53e9kHeUg1qxcE7U4qkol9qkQ477S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098107; c=relaxed/simple;
	bh=KhaqxuaTMA0SiOWI18UsVIS+wXCJkmLtCI0y06ff6qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjeiQPKFCYu6mlkAkznJ5fNyLMNWjDJxH/6NdJx59lPdnthtVeLBMJsTPaF/RLqQdACLYwcpglnRdh9m0dxvTTJ/cyQATjGNvzgUTIO8zzQTcATASTGbZniFxxPc7DNMAsKgFbKlq6rebNiZKbW/3+RMWKxW3n39Lz4n8Ystir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT5yWHwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT5yWHwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84DCC116C6;
	Thu, 22 Jan 2026 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098106;
	bh=KhaqxuaTMA0SiOWI18UsVIS+wXCJkmLtCI0y06ff6qQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kT5yWHwpLgO5uOc0y4g6eTLU3F8AQINpNiH4dp71jpJgsNMokIFcqHRdBkZx8OYW4
	 Ok0i1CfqnjQCs3jqEm2S/zbzyKsuO1w4+92mYSPq1HZi664IwZREhSF7AFcQK7MX1O
	 13a1zjEiZ8MaCLDMb/9D/Nyhvl7FUCNge2Zma2Fmg3SmBP+rYnHJymLS+z+LUMGwV+
	 EdU8M2NoTmLizGh+JqccfwyoIcu9zDZfK8zqFpdAd8OEiPtn1Qh9l8XYKeX7Wim3+v
	 JvzJW60ljRypIbIZX2vRaE7BMgkGt/VZL+hgQ0JguQjBJJWiLyn6J0rMdahWduUS9b
	 eeWFWCZ08DQbQ==
Date: Thu, 22 Jan 2026 08:08:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net] net: mvpp2: cls: Fix memory leak in
 mvpp2_ethtool_cls_rule_ins()
Message-ID: <20260122080825.39eb96b4@kernel.org>
In-Reply-To: <20260121140600.3903164-1-zilin@seu.edu.cn>
References: <20260121140600.3903164-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 14:06:00 +0000 Zilin Guan wrote:
> Fixes: f4f1ba18195d ("net: mvpp2: cls: Report an error for unsupported flow types")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Please feed the _patch_ to the get_maintainter script.
The author of the commit under Fixes should be cced, please repost.
-- 
pw-bot: cr
