Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44A367F25;
	Wed,  9 Sep 2026 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977528; cv=none; b=ioNlIy+pw+CrNFAu3QUBUD33LXVlvgVux4o6AS8alqON3EyjQEya+tPMWZtfSvit2eyHLF/JSnPQWRlD3PtaMgfBe8viNchuaI65qBuHv0/tVCv/CEIzkSj5idRaPcuQ919QYHJ5xRv2tUNRCLbJn94msml9ur3Hfp755VHverU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977528; c=relaxed/simple;
	bh=9zPZ6G7kkcAtdLbZg+dhbXdH7HfF9/56YhLkUXcpxg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzWP4EDfXhwFomuNdu0t33LijcIB66PopctKfDY0KzZB1TUTcPzMMh7aw/nl4tkIjf/y1DosAwUcgojb4+7dUGaZYyfkrBAfEBBVjmwWz1yUYNfHgsdP57QXL/yN+9YBiSx5M1p8ZG3nzR3HSmBzi69lbDRhe/f69lCXLQDRnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVHaBX5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVHaBX5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C6B1F000FF;
	Wed,  9 Sep 2026 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977527;
	bh=66ShHtkoMTqityLdxEunWRMs889mzaL4MtS8HVOIhP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iVHaBX5Hxhx6vTNrkbqFgFE5mWoktO8KBSBgb7yjYEJRgSwGtggnfROuprHtTtOhY
	 Lz+1RmzSkRnMiU7S9PyG9gbAau90MTg5oxM5VVklzeLDGZnJMmgJI3/Q3Rj4kPk0+9
	 WGLQWxYvKlumW6Q6YOsFNSqUSLXvcwtj2wf+QaqayvGwFFPr/zijE06YcHPBN1vvAM
	 qTnaJLqhv/wSbIECP2kre2qqh00K2kQ/tfibhliDhUOFB17Va8S4fzQCxNm5ln/1Ti
	 5M+HMQ/I4SQ+3mqrirXLwzTJZj0l+VwtWpe10tJIUb6tuxC9C5JqYVgjvWk0KgpQV9
	 PH7mu3fzQk2vQ==
Date: Wed, 9 Sep 2026 19:12:01 +0100
From: Simon Horman <horms@kernel.org>
To: Esteban Urrutia <esteuwu@proton.me>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Nazar Kompanets <xlie7669@gmail.com>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] SM8450 IPA support
Message-ID: <20260909181201.GL40544@horms.kernel.org>
References: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
 <fa9794e3-d79e-4d77-8166-492d992154b4@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa9794e3-d79e-4d77-8166-492d992154b4@proton.me>

On Wed, Sep 09, 2026 at 03:12:51AM +0000, Esteban Urrutia wrote:
> On 9/9/26 12:10 AM, Esteban Urrutia wrote:
> > This series has been tested on the following SoCs:
> > - SM7475
> > - SM8450
> > - SM8475
> > In these the modem works as expected and no crashes occur.
> 
> I forgot to mention that this series depends on the following patch:
> https://lore.kernel.org/all/20260909-ipa-modem-drop-v1-1-0c9664f09c4a@proton.me/

Our CI isn't smart enough to pick up dependencies.
So you'll need to repost once that patch is present in net-next.
As is, patch 2/3 fails to build.

Also, I think the patch-set needs to be split up somehow
so the networking portions can be accepted into net-next
while the other patches go via a different subsystem.

For the net-next portion, please set the target tree in the subject
like this:

Subject: [PATCH v3 net-next] ...

For more information on the Netdev development process, please see:
https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested
