Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79C41A574;
	Tue, 15 Sep 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487683; cv=none; b=S3CfnH0eJGVtqGOpOAC1Vtg7pzLfC4Uyt4Ok6JA81r9/dDNwVP2RoYUyA1p3pnWpdCNMZmgqtg/m5J57q32a9vYozWDqak9vAY4sStocmzyOKxF0n/9aM1l0asyaOXv21iMyEV168u5+rJdvB+7p7F4yc1cryFjGUd7ZarwS68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487683; c=relaxed/simple;
	bh=WaeE+NSg9/0bGJcOBZhmrICzPz1mWGmKuF80sJgwbh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCuhyDYQdhHos9TQuktBrJMtBg6dXF+Iv/PyKMTljH1PbCCOVFGu+SK1w7082+z0Ws83JQ5Eo+U4I9u3D3YPq8heislMJAtEcZvaDhRnZDCad9/B/Zhq+rY02IvvunwON74C+vmZqweEXzHOFW2xqyn1hQTfMLruf/1Usw7JJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwu67oTG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwu67oTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37BD1F000FF;
	Tue, 15 Sep 2026 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487682;
	bh=WaeE+NSg9/0bGJcOBZhmrICzPz1mWGmKuF80sJgwbh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mwu67oTGvqcGQJf6Y6axLXY0b1Ndd5AX0PuU1dsJ5j4wusamnmrcE8SnRkCHiX/ts
	 oAUqpQdYsNOLSKbCNLIM2oU1dgO3k/jb8SPr/LSNFGdR9VTsejxVFiMMSMMII7bUIo
	 Df1ZUbr+Zbbxpl7h06I9VzbFvmDMIqWsv/84erv9zCh8mgqFgu0XcPO+xtxW8bjBJB
	 PbuhMqece235IDXkals0n6uTwIfYuJJCYwKWJVcx/FcdHw1Ro0Wg/t1g2bq007pp8E
	 XuyiAAm4rPXLzvgnYAFe7k6k5mnG2mX1cyEqvmwkY90RxElZluu48VPqYyl1TGKTfX
	 K3GKNsxKOn6qg==
Date: Tue, 15 Sep 2026 08:54:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: tmbates12 <tmbates12@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] netlink: fix ynl spec tooling robustness
 bugs
Message-ID: <20260915085441.67bc0d4b@kernel.org>
In-Reply-To: <CAC4WM+yDbV90Az8g1iTY=UepiDc7a4cWoo3tOEN62VYm55u5MQ@mail.gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
	<20260910192314.209ecb01@kernel.org>
	<CAC4WM+zvK1zFuPfS5WnzuDR3b_DRX==x_S=Gg7LSLgZb9=33Ng@mail.gmail.com>
	<20260914161206.40a049ed@kernel.org>
	<CAC4WM+yDbV90Az8g1iTY=UepiDc7a4cWoo3tOEN62VYm55u5MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 21:46:09 -0400 tmbates12 wrote:
> I'd assume that starting the bridge spec out as an RFC would be appropriate
> while we see how much work it'll take, but I'd just like to confirm beforehand.

RFC or PATCH doesn't really matter here. RFC sounds fine
