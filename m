Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754A3C09ED;
	Mon,  7 Sep 2026 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817240; cv=none; b=TdJW5kKVRAxUP3wH3muznPmhzRyIfbKP21mmQJ0cFkyGXYSiIzD36cA5zkmhr0rbAwsmDuLStSd21uLzpwgffOGo0hlOE17G3bakP5JjpeEqHqMQ+MSNrLRYBWthq9qwBZThR+dXxbgJShDPyDMyhGLctBfcUqjkp60J1tYPN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817240; c=relaxed/simple;
	bh=AoNhkfDL2g5hcD049jqrwuorzsxRtzcCGwqmJwIc6bY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iU2I96/tGGW2DfwKuLqT6SSlNmuQd0ZRPHjM8nAosHIBAJSabDn+pxJfzGsZwFvk5rBIkHOtAOmApRkmx8rjKDy8OnZU/VlXcrCjv7d1Ix1huyPVT+ESXjei3rZQrWxASe7VMqn6tzxoczjEPkXjrJQVbOmvwzBZzysS370o98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohynTBN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohynTBN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D697F1F00A3D;
	Mon,  7 Sep 2026 21:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817239;
	bh=1XANjsc2vMpx15rysscZxoQQL80S+Rxl8RCyUpnbJX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ohynTBN0gaKjJeXO+1/k/SiDvu/ifHPIe35JIDzYF7+AFObyRCkl4tfEJ4axkKlQp
	 cilaWM6E/N7XpvCQUTYe9W5qhxDGpmTcpUHNcHDJdSoLFHNZ1TLuqMXzqQeGiaJTgw
	 KCnuqTizuorQ09lMHT1YVnAP2OsxGPaPRSwGFeBYL3McHkJ1saYCMCeUKutElQBbsE
	 I54kkHknDkxcsUUiveIt9RRzFvskv1uLutiDyCiAo8HR1m8wmGLBAngZoUmQC8qOy5
	 rn9MxP68dKwgH+Nev5/bm83vn7JlZBBxTstoW33Uaoix4/tDHNDmxcdTSPdPUqF4Se
	 sM9JrE1qHKSOA==
Date: Mon, 7 Sep 2026 14:40:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, "Hariprasad Kelam"
 <hkelam@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <20260907144038.0937d6ff@kernel.org>
In-Reply-To: <20260907042827.4077114-1-rkannoth@marvell.com>
References: <20260907042827.4077114-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 09:58:27 +0530 Ratheesh Kannoth wrote:
> otx2_get_link_ksettings() already fills speed, duplex, autoneg, link
> modes and FEC from CGX firmware data, but leaves cmd->base.port unset.
> As a result, ethtool does not show the physical connector type even
> though the firmware provides it in fwdata.port.
> 
> Populate cmd->base.port from rsp->fwdata.port so users can see values
> such as PORT_TP or PORT_AUI via ethtool.

I said:

  drivers should not blindly pass values between uAPI and the FW.

That means you have to add some explicit validation/translation
for each value even if they are numerically identical.
