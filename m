Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6313D0BE1;
	Thu, 16 Jul 2026 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199437; cv=none; b=pOhn+PKCi0AdO2XhbvAKdmkSiZIGpP9BSA3iqLmI94K0dkIaUSUXTAaF9+l3rVyAJIpdNEiKOEpbefh2C87+ILTMCfxmgTlnHHXd1MJZmR9iLDWBWPSeQHuEajVk/+nrpRTkMY3Siq5/+vLWpWXd04IyYEdQiCKhDM8DvD45djU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199437; c=relaxed/simple;
	bh=qYV6O8WLiUAVRIq9p5phVYx4RpSDa47S0zaEBo+iNZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwEvafjTTjVN39toQJlLuprPvdc6k56hdRhyPQqzjwge6EpwVl/1V20xID9NYoJCofmyhkloD6R3aJmBa/NSftNkYdff7KOOPJoU9mv4kPIySIHn3UwkNWatIDOhV6drvBykPNxAqfhGy7qjNLDaDsvfAqekhdcm/4yc4h4gl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwnJbz3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwnJbz3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E09F1F000E9;
	Thu, 16 Jul 2026 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784199435;
	bh=cuIxl/Ur1TuKbEfJfRVEKRh6y9+ljPg5aoWyN9FCFDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HwnJbz3TdM/RBA2x3LzGLLiWik36rNwrzAk56mzVYn0n5upuIpx1X4Zv6tZEQPQWE
	 6JIY+5+8hola72e53CP2fGV/EohqjCaWX2QqhvoFT8faeo2zwRV6tvz4pbwosf2kzl
	 2hV+WV0tPa6v+h5LUUPdcD2S8zrw9yg1VmmBb8U53mFerKQBmPhRP2u/vWX+lfFZee
	 AWZytuIig6UeWaW2IKXcEwPIBS2LeX3BDPOQXb3oDSQJyOn7dOY6fYaD4WK9wlyOD3
	 vCoOXvkJ6vGy6XzQZI4SNwI6xIaw78UaPsJcm9+lpIS+gN1dmU9tQuRa32b58AIKli
	 aDP7yBnA/dnGQ==
Date: Thu, 16 Jul 2026 11:57:09 +0100
From: Simon Horman <horms@kernel.org>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: various hwstamp
 fixes
Message-ID: <20260716105709.GI95246@horms.kernel.org>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>

On Fri, Jul 10, 2026 at 04:43:40PM +1000, Luke Howard wrote:
> Two fixes for improving the reliably of hardware timestamp acquisition
> on Marvell switches. In our tests this eliminated missed timestamps in
> ptp4l.
> 
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
> Changes in v2:
> - Lineraize SKBs before retrieving embedded timestamp
> - Hoist driver register lock out of per-frame loop
> - Link to v1: https://patch.msgid.link/20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

