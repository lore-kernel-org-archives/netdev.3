Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DF2D6401
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027934; cv=none; b=ItE7tprcspkPuFHxCCHwU8TrhQzpC6k09DaPLwVh4wmjjjKPQhgsxZvRg0T/TfjsU/msZKQ1xeb3GweMaGs8zsakvl/OoW99lIGAQ0Zp/ZrwhCiNnOlAJ3eDLFKl4YL25tpQtTGn3PyKjGHxLnHDcDuomRBGMGrPDU2xTt3O9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027934; c=relaxed/simple;
	bh=CMSaxGP3eIqKcu8euueIQtFERGGu7GUah0ApqSAjdjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv4wp3dSji8uHNupZMNAhMEYRTR6yjYrrpdBQ0lAlZK4CkbhMRGeYXE2fslExXUWZeLWaDSQNG+k+SM4nFVIUjfW13s4GWB9lKTFSINFfVTfVu/dO6pVRjTmgjlT1cYE6zGtRYItw4DTK+LitxsNv2ZlOYI55LAIWeYY0A47ieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzkJizAg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzkJizAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F7EC116C6;
	Mon,  2 Feb 2026 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770027934;
	bh=CMSaxGP3eIqKcu8euueIQtFERGGu7GUah0ApqSAjdjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzkJizAgZc+iayIvgmIYgUy/wRE0dWGjOOraVoCQzHW1iAXzeBVrIPZo2COX9bxAG
	 hUx+cwqBm+6wVdbCnAFPpk60TcZgYEYzm+KqfXfcVG/06/BPIMhk3oKrNQ9Q6aT5W7
	 F1J32sQ9AOvAuDr+tli6RfcS0yyLUQNbE8A0hsx14PLDKRP/rCxnOUHlVHkSeguhfm
	 hMNKRom1K1G/30dDqbhfnFFyNjRrDfZ3B7ZBAOL4R37TenYu+RM4kY60FQm4NWbnXB
	 FCkXSb+JNuBIAD67ep4b1bOsgs/GY4Yg/IZmubE9KmanbMB+iWyp1TSBLx8nJrX7RU
	 KtL6x1hMHdjSw==
From: Simon Horman <horms@kernel.org>
To: takkozu@amazon.com
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	enjuk@amazon.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	piotr.kwapulinski@intel.com,
	pmenzel@molgen.mpg.de
Subject: Re: [iwl-next,v5,3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Mon,  2 Feb 2026 10:25:20 +0000
Message-ID: <20260202102520.1844644-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127085410.79645-8-takkozu@amazon.com>
References: <20260127085410.79645-8-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "I'm releasing this report for completeness. And while I
do think it is correct. I don't think it needs to block progress"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
igb: allow configuring RSS key via ethtool set_rxfh

This patch adds support for configuring the RSS key via ethtool's
set_rxfh interface. The change accepts a userspace-provided RSS key,
stores it in the adapter structure, and writes it to hardware registers.

> Change igc_set_rxfh() to accept and save a userspace-provided
> RSS key.

This isn't a code bug, but the commit message references "igc_set_rxfh()"
when the function being modified is actually igb_set_rxfh() in
drivers/net/ethernet/intel/igb/igb_ethtool.c. This typo was noted by
Aleksandr Loktionov in the v1 review:
https://lore.kernel.org/intel-wired-lan/IA3PR11MB89860A16782937C7E8C2E2DEE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com/

Should this be corrected to igb_set_rxfh() to match the actual code?
