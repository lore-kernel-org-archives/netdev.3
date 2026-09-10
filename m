Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57F459AE1;
	Thu, 10 Sep 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036906; cv=none; b=nKL1RLpKa9Kp+eWH5aRr6d2MRBVP/8bI3uPYtl7CeUcZ46BV0JrMERrmQEU2kmt+CRlFB6EkBCZYT+f7DsH6XXnuhK/DzBQHf6dWMo1b89RChx76tAM1gChi3mQ12LDohLKPlru5FLpqajC+G52TDTw3Jd9rFI/WEWBIqa2oEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036906; c=relaxed/simple;
	bh=bCdLUvLNdPzUfA00drm43QLKGNP58OPidRNhLCm+YPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRQ89ovT2GLxQ0Vgae2JrpKJBXyAWMISYm1kffcxkK9l7pygT/GsHGZVSK7XQJeZrRnqQ+KggVkUXONntC+Ntt5BpqC3e6yOx7DjI2zpsPdrl3hE4q2owR5B/sf+XvDlh4Pz3qLoAqdYM5g7MXa5ES5UUzZjGCqGwP6o2avuEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOiW5SBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOiW5SBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9811F000FF;
	Thu, 10 Sep 2026 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036904;
	bh=yOAhK6n597fJIuywcqX9tq+2ds0k78AUamC1HUbRR6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KOiW5SBZLQfypVk12lEM3xaNaLkDUcP1kPjCx6CoIdLC/vbUQHsLe5rsX1zkDKLCI
	 Nnf6w4WwqWte8UEvcKfo/fhGv7XSSrn7rfVC2yj4Hsz/K6r86/wJTLLkrSLmhHMZsG
	 EeZn8rc2zfGrTcDeKrUqykHyvoDNHjdCvFhSkwUmrpHW1d97floqS3MGGoYsT/nFAF
	 vpiRaQRDILKYxBZz6Lj5b65WqFvKb3v67sC/uEJ26PaTHADXHIv4X1h7Oh+QcCKUoV
	 GY2ycGAwem3QYtpBmxWrDliJNPcXE3L9IYp+VyXDYbXw+wktDeizRWGYcS3RXkPiJc
	 3S9N/eJvqoLtQ==
Date: Thu, 10 Sep 2026 11:41:40 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev-bot+sashiko@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sgoutham@marvell.com, hkelam@marvell.com
Subject: Re: [PATCH v3 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
Message-ID: <20260910104140.GC40544@horms.kernel.org>
References: <20260909040621.397255-1-rkannoth@marvell.com>
 <178901476356.219967.4043623609208931989@kernel.org>
 <aqJycF8VS6268u7o@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqJycF8VS6268u7o@rkannoth-OptiPlex-7090>

On Thu, Sep 10, 2026 at 02:33:44PM +0530, Ratheesh Kannoth wrote:
> On 2026-09-10 at 10:02:43, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > Critical: 0 · High: 0 · Medium: 1 · Low: 0
> >
> > - [Medium] otx2_get_link_ksettings()
> >   (drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:1236)…
> FW is setting it properly.

Fair enough.

Reviewed-by: Simon Horman <horms@kernel.org>

