Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D93BB132
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188398; cv=none; b=IKGH8DxjmRngJNdhQQNI9y+/DWQjRNSmsn7GalhfXsWCejJGc7/cpUB6ycWD8kPQ8IVSJDdrAXaZgIpdPD4pMHwkmIK2hYFBqpDXVVHiFB8nA9RN7hwJsDfWS548RSGgDvi4tucSyk86mwfH8gl8V5x33xGEvb9zTp3FG6Nf2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188398; c=relaxed/simple;
	bh=1r3uNyeQ1hxykitIyv5fh9uFKbV+E7x1V62XJhSx1yc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjA59HPTzp0jrLZUpoG+h9scLEXPggaPFeYnwH6Vn9bTGn7ohdt1kLqsv4RRDP68rH9hm+aQdoK24ZzsfcBPJkYupWnbpQ769yX99N5+c9FI3GRiDqNIVoKE1sj9iRW8sSvDig/ykiISeQB8JHzfq+BSOZZcRrzBfE45WNtDLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=gDR+LqQA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gDR+LqQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784188385;
	bh=1r3uNyeQ1hxykitIyv5fh9uFKbV+E7x1V62XJhSx1yc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gDR+LqQA/LUdkjl4NhyaB1Gc+R+KHZAPupASueX094uYSpbCSk3SjfbgcYIVTjU6m
	 mW4EQ/UJl0N1hv5BR8YcwBSGemmZWF/4IBtQHJpuPe5LGNKYTakbY7nHuXR8Fd2tVG
	 Mf5SLeqEbjTHgA7yZLg/+MJTnKRkxKmZty3SJNDpNtOQmvTQdAsXPw6xCtkF1cb2rj
	 HKCerM3PcstdUk2Io89pwEpP06z4ll49Tj5RIZxfJctxcB7E6l6C7FiH1rHuW9a+SE
	 XEwdnSx14jCqHHRDm1Mx0ufrGYGs3lGIE0KNLkYGHCEb8qXio17z8AOpZ1ZX35dQSS
	 fV5O8yOZjZf6Q==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E0429656A0;
	Thu, 16 Jul 2026 15:53:04 +0800 (AWST)
Message-ID: <0a612d9727855fc8711a6066645a3d06801a5ee2.camel@codeconstruct.com.au>
Subject: Re: [PATCH net v2] mctp: check register_netdevice_notifier() error
 in mctp_device_init()
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Kuniyuki Iwashima <kuniyu@google.com>, Minhong He <heminhong@kylinos.cn>
Cc: matt@codeconstruct.com.au, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Thu, 16 Jul 2026 15:53:04 +0800
In-Reply-To: <CAAVpQUDLgW9C_DcrHfWpRB8VN1Y28k+4+ufp_v2A5YPzep9mZg@mail.gmail.com>
References: 
	<20d74693ac673ba1db0c0052a7236db777fc5ec5.camel@codeconstruct.com.au>
	 <20260716063534.116793-1-heminhong@kylinos.cn>
	 <CAAVpQUDLgW9C_DcrHfWpRB8VN1Y28k+4+ufp_v2A5YPzep9mZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

> > Fixes: d51705614f66 ("mctp: Handle error of rtnl_register_module().")
>=20
> The bug predates the commit:
>=20
> $ git blame -L:mctp_device_init net/mctp/device.c d51705614f668~

We could alter this to the original commit (before the error paths were
introduced), at 583be982d9347, but would also need to pull d51705614f66
as a prereq, or fix the conflicts with earlier stable backports.

This sounds sensible to me, but is a fairly unlikely error path in
general.

Cheers,


Jeremy
