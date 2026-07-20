Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE92E62A9;
	Mon, 20 Jul 2026 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590501; cv=none; b=CpLrYN2/gcc2EvA4h2laHvhORJyya8LjPHKr82BDDQlVEPbKzHKv2oROaEJvdZes1GYggK5+z6nFhYdbnF5CS3qxoIl88E9V56otz+8v0109KRurXefoh+UrCIn8Yy+CKniUkwqAr075llSnUme3KM0z5F3Pqi5mO0jTP4+4jyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590501; c=relaxed/simple;
	bh=7aa2+SAG2C6gR7ALtfyV9WQg6FUhA8uRTuM8opOqgP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABgNJbS6QK6W5MkSyNz0U14TpBmTV1eJKp5PcMlxD73AZOQCKrtCX6sHVOpSaTUxkPZd2+aY1d3iqeOYaV3q59xgpC78hW1FBWohYESvXjA+0r+rCpAoQIL6B/qpGfiVaOMYMoWzv/8lELu4dR3+BbGsdWGp+fCPXj6hMrT7i+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuaAVhL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuaAVhL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FDE1F00A3A;
	Mon, 20 Jul 2026 23:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590500;
	bh=7aa2+SAG2C6gR7ALtfyV9WQg6FUhA8uRTuM8opOqgP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AuaAVhL9Jqs8VUiA7Rs6S41lN3PULXezlGsjpJNEDXhV80vsWsLP+l45yWGGepXBN
	 jKcvSOSb/Y1xtkARCMM905Z1n2WWZvOqlqJptgkYZ2FQqzOVbRmQPK96kE6X5N9tiR
	 9S6SFD3oyxTqPisXK/JjxaQALsy7meD0botqZpVMUS+ElMvmwa6wvlbKxFrb9mKcLN
	 YcRfguCCXxVS+FMjqz7cwwwHm/cAVauu/VAelTLGlajj14hL0VmortO4HMu5eDHtov
	 KHQGte4fsA/mYD0RdS+cPAXQZzZfKUzXvOvl+H1/a6rSe7tgHi2uXki9lTkgdks45T
	 FS2xKC1nUrSWg==
Date: Mon, 20 Jul 2026 16:34:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <daniel@makrotopia.org>,
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v9 0/4] Add support for RTL8261C_CG
Message-ID: <20260720163458.21c6fc35@kernel.org>
In-Reply-To: <20260703071330.1707-1-javen_xu@realsil.com.cn>
References: <20260703071330.1707-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 15:13:26 +0800 javen wrote:
> Add support for RTL8261C_CG and add support for loading firmware.

The netdev patch queue has overflown, if this patch is necessary you
will have to repost it.
