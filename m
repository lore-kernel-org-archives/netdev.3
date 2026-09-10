Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47D3AD515;
	Thu, 10 Sep 2026 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084777; cv=none; b=RlzhQoskF/V5BYI/mTz9SfXNbylQoTtO4g1XZUzRK9gfrVISEy7qx0XAYTpmM5Ey4iC0EzB4RF8RpMTYI+x6/YnisbJy50d+eYEaXe7rUGSzBQGdm3/W0244OCG3c9O0OTqxJrXQy9eTT1EoUc4+jqR9WsouGDbVbvm4Dnvr5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084777; c=relaxed/simple;
	bh=0S7jHaqPiMK+ukB+nHt2yVxhhuovVB+dNYW3fLN0xmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9q60ClpCR0BgZheHcV393UwFxuRaPbf/CwJHeh0EjGfzVdXYLiThUXiJdJGEE4QMLxgb9HDjW+Agme3EAEfVgjYJxBTK4SDEHPpdQesJJVepEvRS1OBwXyO/eFkBW2LO0jbIVOeuhyoytEz0q0omOARhikANcvPA3PkneB311M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfKq8btt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfKq8btt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5372B1F000FF;
	Thu, 10 Sep 2026 23:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084775;
	bh=KUPx3xy3dqT+M3mAyBomSYahPIS2TrNTV9gwG2LCJ+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JfKq8btts+zXP9h1K/+JazUqbA/Bw9PRQsIx3FkxZs5DzJFHVpIvLa/ibZBfuzRFK
	 qg05ttljbhq/WfXS1KGMlBJUFwOizHiW0ssU2U6TI4PSkcl+4UnxjM+nVS1fWyyFsE
	 nuG+VzoIHS9/Injo/oPweMT7Lp8iMX23M5zmHC1Av0se0HXd1ma54ol27fBgKKoOWw
	 DyLBr6LfyRZgbAc3NfF/yOA5a8qTcJx0/AFHcm+EJFelfSamHyNuWkp2fXKzjFtBV1
	 txbvnqGIoDpLY2u1Kax0xJV5stN4zEbaEC7Jq0S1/rhp+rA/+SSqiafGbnNDKQS3q4
	 xCJLaZfA9CqBg==
Date: Thu, 10 Sep 2026 16:59:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [net-next, v2 08/11] bnge: add NTUPLE filter infrastructure
Message-ID: <20260910165934.0ffdbd31@kernel.org>
In-Reply-To: <20260908093053.2596020-9-vikas.gupta@broadcom.com>
References: <20260908093053.2596020-1-vikas.gupta@broadcom.com>
	<20260908093053.2596020-9-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 15:00:50 +0530 Vikas Gupta wrote:
> Add the core NTUPLE filter data structures and firmware command
> wrappers needed for flow rule management.
> This helps further patches implement user-created NTUPLE rules
> as well as rules via kernel flow steering.

sparse flags:

drivers/net/ethernet/broadcom/bnge/bnge_filter.c:202:16: warning: incorrect type in return expression (different base types)
drivers/net/ethernet/broadcom/bnge/bnge_filter.c:202:16:    expected unsigned long long
drivers/net/ethernet/broadcom/bnge/bnge_filter.c:202:16:    got restricted __le64 [assigned] [usertype] id

There's another one of these in patch 10.
-- 
pw-bot: cr
