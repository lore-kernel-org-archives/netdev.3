Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4E314D37;
	Mon, 29 Jun 2026 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774432; cv=none; b=YYlQoy7/dr2Px2vi6mkVefbWOWruGI6gXRdKd8WEMQp3jxG4ChZOZ13kd9ROvD7vUtj9nMJ0ehLPyj0jJSl74G/XgyfdxDM0vdypINyQd7C/ZJc3G3MIFRjEuZYBqSpRl8YN+iS7qBU6jg6JsHeXLlwdqwRwhS89ZhIYrb/5Ziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774432; c=relaxed/simple;
	bh=ARt1Z4YduAp4lmJRODhPvOwkpI7mejO9z5zoCMJZQtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6LmvA3EyNr8RAXfClhyttlxFdKejGCH3Z4WVFMQ5aKMEeeOK8ZlocxBS5xAj5qprZ0XLTagu+akVzv99KXT516wmm7IudbkwfB6OPDnDdJMLOW/0Yglfjw6ceTJFCk2kEMB5mg8nji80iP8LlnlDDSAZgI7YJPdDUYQ1GxuLFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QutELweP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QutELweP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994A11F000E9;
	Mon, 29 Jun 2026 23:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774430;
	bh=HrnE64EHRx3WynIv3KKZBo6BUeYuEJ+Zrf3gjdAKliE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QutELwePkV1BJ18gSW5mCUredBf79l+e45qrTNVCH2rpIiqEHluuK1martZlf5YxS
	 NYyDec1JHsRDEqDWSfeU2jUrCGR6X8UKwdrMXwmLr835SiQvdguT3VCWcKNQ77Vgdd
	 mUakcccRqkxy/r3bbpNU4rcFgSztUCLBIfSEUBvZWCqUi5Xk22ZGR0lpLgyaqwOvGt
	 3/yWDwr3ZvJC/AG/MGFTmVvpaNgomOFDfAWTIIx8ANPNLN185UkEc+hxObOok97gzU
	 cKjFEUrASd+yXVdxpZxZW79Vsk5rDXY5JMTlvbOY2pAO+bvNTbyn6mIv8NtdNWSUD+
	 0q9Z3FU65y9fQ==
Date: Mon, 29 Jun 2026 16:07:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: dsa: qca8k: fall back to ethernet-ports
 node name for LEDs
Message-ID: <20260629160709.121d9cba@kernel.org>
In-Reply-To: <20260628225742.1191229-1-rosenp@gmail.com>
References: <20260628225742.1191229-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 15:57:42 -0700 Rosen Penev wrote:
> The device tree binding allows both "ports" and "ethernet-ports" as
> the container node name.  Try "ethernet-ports" when "ports" is absent
> so that newer DTBs with the preferred name work.
> 
> This matches the handling already present in qca8k-8xxx.c

Sorry, but net-next was still closed when you posted.
It'd be unfair towards those who follow the announcements to consider
this posting, you'll have to resend.
