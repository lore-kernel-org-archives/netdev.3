Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC0BA3D
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012451; cv=none; b=hoII4rfGwqQA8cqce9qaFfSdnmLrJbFRDerAyPOiR8KIDUR4x9ntPTkhxPNGpVUKr1Z0ZivfexAY1EjieKaMhtOZqT7olQPZQZrzFtodrK1euD+sfcZGIdd96gm3EQ+tdTd0imQxdM15ffD2Y7/hq6jDjs0Cf/ilAH/mec+2UVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012451; c=relaxed/simple;
	bh=lmtVsM9hxNNbEPBCSyNIncwBgC0pZ/vdTkfaKgaZScY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t94yqnrnEheRi+YNAI1LKzTMnpFoek/0VJ4Vp/Aa8ZJOPl9i0DsQqU2ZmNN7v/jcHTU0kbXvC3V8IZS3tRfmVUa5g3VGQXlBvBQFHuwCRyJhA491o60RjDKdWm77s4l/rFbGDxEEraSWeQL0103LFrWJsVOT38NcNTpPSvphkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSFr2Gkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSFr2Gkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F0AC19424;
	Sun, 12 Apr 2026 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776012450;
	bh=lmtVsM9hxNNbEPBCSyNIncwBgC0pZ/vdTkfaKgaZScY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rSFr2GkwkYbwrKTUO3mYlShyoU0rlEIqAkL/paGQ3GXn0krCwAZnTh1HPRQ5d9XII
	 lM2YP76Cvx11LGMiWNAYPv/ifeyvK3mEL40pObmQhloXQgD79BgOxd3TSC5p8DNrW6
	 f1wtiw4V8tfSgJF/NcJmow1xZzOP1Qi9XXnA7Utz1fus8R5ltAaz9l5dZ8LgGmEGg1
	 Oj+6D/ImHfFYcM/J1P3HbcZBxkWdcFFuywMFOaToTIBrWZDZpnO05SxuZzCoZk24Xd
	 pnmkdIblpXAcVlarU6sn6lCkvHJOMDlVE2K+qGrgUFQRS1TJ+PlGrNosqWSGEo0F4M
	 acKFax/m69fug==
Date: Sun, 12 Apr 2026 09:47:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Mahesh Bandewar <maheshb@google.com>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] selftest: net: Use port outside of the
 default ip_local_ports in csum.c.
Message-ID: <20260412094729.334b8890@kernel.org>
In-Reply-To: <willemdebruijn.kernel.15ccd7e646278@gmail.com>
References: <20260410215420.1698033-1-kuniyu@google.com>
	<willemdebruijn.kernel.15ccd7e646278@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Apr 2026 15:18:56 -0400 Willem de Bruijn wrote:
> > diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
> > index e28884ce3ab3..4e044689bc37 100644
> > --- a/tools/testing/selftests/net/lib/csum.c
> > +++ b/tools/testing/selftests/net/lib/csum.c
> > @@ -105,9 +105,9 @@ static char *cfg_mac_src;
> >  static int cfg_proto = IPPROTO_UDP;
> >  static int cfg_payload_char = 'a';
> >  static int cfg_payload_len = 100;
> > -static uint16_t cfg_port_dst = 34000;  
> 
> This is paired with wait_port_listen(3400, .. in
> tools/testing/selftests/drivers/net/hw/csum.py

FWIW I can confirm that this caused the HW testing in NIPA to fail
the csum test since Friday.
