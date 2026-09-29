Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24123AAF63;
	Tue, 29 Sep 2026 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649000; cv=none; b=WgGEiJO3K6hOhHx9kPO33A5QR2RFaQi9mSqnlT3QZ4qnLQ4M4cHyhoBXHQTH/jMza+N87ovLHktwf/Iic8fNGYUzpVVeNizM54QEIm2F2tqugdbWYjNWBR8B9HMeu9ZjRmUZtm5TGm1mGtCqpILp/vhp2AqZM/C3r6JKQUubKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649000; c=relaxed/simple;
	bh=+84unWkjrz+wVTfkhZ8GNuIZ56qeIiZ/OOiC2RRua4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YW5A+3bnnIB5S9a8coVOVX8TFrjl/IK8exD9sDP0LGYblqDlMrNBOLoduqc7SExeUWIOX3m7tkPSPLz0KDej5B4XZ5GR7lqb30WeLqklCRDymvFat22+a9d2HPSfW0VnLqa/taLo6HIDXdoWLKVvCYJku+p3RYm5CkEgTCEioc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuOe1bf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuOe1bf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B11F000FF;
	Tue, 29 Sep 2026 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648998;
	bh=lhqadIBHKQumpXJlR69ddDyHY+pPbIX1O+PCClmJv5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kuOe1bf0y5LC6+NzFCm7RXiL1dURMS3vrG2WgcX1hoQZOEAZXa7ZJfEetG/oyOs5H
	 EULZK3/Upikox/3HXUy6KlG2EFPENzcpuI0ouAGJaKy1OMpCUHpxQ39wkOHkJrVFTH
	 A1tFJlGqFkwb1d1KudZ0/7H+J/HeJp9LXsSQ/nqV+xFq3LilFuvTAl/RCzr3QEEMz0
	 K67O8XRL5kH8xGJw5eevEbhPPplSdJYcrUzPSYCaR5ICC+jtnqnXILi4Lwf5wQ9y88
	 EHjLcOTp9HVFx9pLcHFpbPxjngj3oo0Wl+NLYOdfA5qD3YCesShoZWbmxZ7bKMpQ7j
	 8IMUT7++sLJdw==
Date: Mon, 28 Sep 2026 19:29:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Nicolai Buchwitz
 <nb@tipi-net.de>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
Message-ID: <20260928192957.31dd51df@kernel.org>
In-Reply-To: <8100d62f-7615-4129-a633-7f4c7404a0e2@bootlin.com>
References: <20260925135237.3432266-3-nb@tipi-net.de>
	<179043085090.2160803.7251184093173489740@kernel.org>
	<5ee2fdb9e5303f23b2d61c06479df489@tipi-net.de>
	<8100d62f-7615-4129-a633-7f4c7404a0e2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 20:03:14 +0200 Maxime Chevallier wrote:
> > There is no in-tree driver with ndo_hwtstamp_set but not _get. All 73 files
> > have them in pairs...
> > 
> > Even further, the asymmetry is on purpose. The get side tests ndo_hwtstamp_get
> > and the set side tests ndo_hwtstamp_set, each gate testing what its own operation
> > needs.
> > 
> > If anyone insists on the symmetry, a v4 could add || !ndo_hwtstamp_get. But before
> > I respin again, let's hear if this is really needed.  
> 
> The current way LGTM :)

Alright, but let's also follow up on this and add a check somewhere
during netdev registration to reject the asymmetric ops.
