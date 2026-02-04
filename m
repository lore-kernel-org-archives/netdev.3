Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA4410D30;
	Wed,  4 Feb 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215149; cv=none; b=fbS4ISSFFlaa1P0crty4+ldMwtcNc3d/A1psnqK1UybQXImulgyQuErLP6+YG30J0va64wRF1BVLEl/W5wnTbrQ/8ZYXi8HlanVN7QPu2Q7XSR+stHqFRVVrdnurRFS2k3cfaXKf1hPIH2ujtqWxCA3HwADjLUtR4tjASgKm4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215149; c=relaxed/simple;
	bh=UKQ7n5eRMKm18Jsr0H3xh1Q4lAY3MboBngp44b5vomM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTLp4y5cBu7Jr3hNGGN10RiOOQmHjU80HOWnleG5HDnMWPdaJ4LhgcARUe6XjY1EySSfpCKPBkECr3E6HOU/fD+6QTOLPVcSm/Zo4E9d+S6EKToT1s6Gv83obpEKhZ0m7sryIzXuyJWeWg0qAgB5rabFnEVJqYVUPw8/MiQaXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ttg/iyo9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ttg/iyo9"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f5jLq1gKZz9tfs;
	Wed,  4 Feb 2026 15:25:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770215139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVuLn4uEJ9+UsDMLkQEqxans2v9GDBjUZCsTXAt53cY=;
	b=ttg/iyo9PKoY4uTtGqrtVSI/gvHqZR74i0dYPfH+lQ+50ydE0WKZ4mzx7SAKb1syeTd82D
	W6IXW0CE7oVFhdHaWDnV93kowIja5GtEj6H8YnZksqrMHxHQSOBVeIjpg3PQZbkuK2JiOv
	bengvoH61IiQJkYhPvhVDyJNJ/BFJ418cdYfXndRmLO9DeHWhBOVBKgSQeK5cAhYiwbkpp
	p2H8Hpb8h6QY8XwDaK9RxWT3McxYQZ0ugyZX2Fxga+5FkLmgaNyDfeWLygusv8RNuflKGI
	KgzVWM8+qBHMmaoafIlce/bnjp1eJhkingoF7D/+5o+wi/wLubl2G+nSRQwtpA==
Message-ID: <a37be87a-e1aa-443a-9005-da62e4f51d63@mailbox.org>
Date: Wed, 4 Feb 2026 15:25:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH v3 3/3] net: phy: realtek: Add property to enable
 SSC
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251218173718.12878-1-marek.vasut@mailbox.org>
 <20251218173718.12878-3-marek.vasut@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251218173718.12878-3-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bx97ksdkggcwqo5zkieas9s1xnz73be6
X-MBO-RS-ID: cd8ea292a1d590c7a53

On 12/18/25 6:36 PM, Marek Vasut wrote:
> Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
> follows EMI improvement application note Rev. 1.2 for these PHYs.
> 
> The current implementation enables SSC for both RXC and SYSCLK clock
> signals. Introduce DT properties 'realtek,clkout-ssc-enable',
> 'realtek,rxc-ssc-enable' and 'realtek,sysclk-ssc-enable' which control
> CLKOUT, RXC and SYSCLK SSC spread spectrum clocking enablement on these
> signals.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
Is there anything that should be adjusted in these patches ?
