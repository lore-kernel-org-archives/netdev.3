Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDA19E97B;
	Thu,  3 Sep 2026 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404176; cv=none; b=cZBJqbPRbn8zAVsXLOaGoAkconZnc/4hTqKYFF/pEDlQX5Fhk6WNFIelKL/aSlnF9mn+YEAhB9B/5p3TrxLbF3+nHSCUd3dkp4KLxglRCCraO4AypjXbwlcW3b7Lqs9UB+ZWZk/EqXaZ7CPUQMKvkdSjUf2Oyh7wR7DjmmFcJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404176; c=relaxed/simple;
	bh=jd8RM++VCtwDVeu5SoH118Tv7kJz9aWt1slZwem9IaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPtZx66T3UKyFx3OjBhe1mnJcUSQ5EKPa0OQncHMuAZyWWcnQ9NlkeCHkMjDeE7GQhFY/0SlW234Y3sIItIX5YUCtCcTD99EHojvRFY/mPUjUjtFJkbPwmKVnnN2BbMSvtaYpoL8Rim7ojatm47Ec3ohKhiZt3boREHlQL48GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSp/Afp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSp/Afp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A940D1F000E9;
	Thu,  3 Sep 2026 02:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788404174;
	bh=jd8RM++VCtwDVeu5SoH118Tv7kJz9aWt1slZwem9IaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JSp/Afp4wJRikFIAu9WM8QMPN4/y2lVVkPCCLD11Mkyrd+I6L5TRctMwQEehiHFj+
	 kGK5GEiKktE99jzS/Rql9XIoA6QjLb2nUkXZojAwKPxm6aS7B1i61Z0q++mESjQdu6
	 WGiVWpUvmNla54zSctOQOYcrIIid2NQ+pPb61lF8eoEormHIGzeXy3FQDDkqAWUwNG
	 BFg4b/ivg9i1gkQ6r4g/I0Zh3mtdP8ONjRXuUbJNMp8kSguSTsCEhC9p5t7yhM4lgY
	 hXVGrbHc7EyQyzpM+EYtc8E3Zc4z7DDxFe4pOJD8oYG8H/UxzpkiYf0DruQk6F3BTZ
	 H15l8xW4PePww==
Date: Wed, 2 Sep 2026 19:56:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 00/15] net: enetc: SR-IOV improvements and
 ENETC v4 VF support
Message-ID: <20260902195613.1e18b44c@kernel.org>
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 10:54:26 +0800 wei.fang@oss.nxp.com wrote:
> This series enhances SR-IOV support for ENETC v1 and adds VF support
> for ENETC v4. For ENETC v1, the trusted VF management and per-VF
> configuration query via ndo_get_vf_config() are added. For ENETC v4,
> preliminary VF support is introduced for i.MX94 and i.MX95 platforms.

You only replied to some of the AI feedback, should we assume that
feedback on patches 12/13/14 is legit and expect v4?
