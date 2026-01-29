Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916282D948A;
	Thu, 29 Jan 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703961; cv=none; b=IaCcts0siDethhLzl/z3ZrHxyyTIYntZO1zEkscllmE/J6WcH2b/s3CXxu6CjX6ioXpAwHaeTAJJ3b7iK+tSrMDvc8KYIDqZi45faNAf3IrhVxBLwFEG5n8DEVOFoI3DLkH9neMrctyulEqb5/fVYuagpSDvnAysu+hyz03PAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703961; c=relaxed/simple;
	bh=feCsBGPM+FB5KGBMZz36dWkNHaXgbwy6QMGW0PLeH5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEMJTFMx1DLDrMzYgwHBWRi+AxjhjVcMSZuu0eMUmZtQ8VkpXoN9XLpmdVl47rAEybSWJr1Ve6tGzfbXJNGT+suuPdL1B+r+nA1Oil4oZf/M8TjhbWtzE7Ga/GGnyhvvXaBaA1f1xZE7p/uhzhsZxOxxCMrdCPupeT0j2oocqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMZgMwzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMZgMwzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7976AC4CEF7;
	Thu, 29 Jan 2026 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703961;
	bh=feCsBGPM+FB5KGBMZz36dWkNHaXgbwy6QMGW0PLeH5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nMZgMwzgAsNZZf8bbfdwpL8IGipFaOvHOetjELv5rxExbu31uTJ7iHPZUGOPv5cBm
	 TG9ONF4aK3+bE+Me4MjibKYep4xfw7yJr5KA/bsFvkpKw6lrhXcGZaCFkcWIyumkKH
	 qZH8Nd1eiR0qZBVMZvVqXDdVsTX8Xmot+UlcSrHB4Loa9FaXfhR/M05Wpj5a/aOr9/
	 NOazzACT1+3Ac664s4mXtPnQX1F+C6c3shEBzdcgX0Omx0K2ZEToAo4LEDlqkpJnQU
	 WM2s4XI1H+l96gc0cE+5jjMrL7XDvh7EJ4YOuhdJngeKEED65PtmjoXKKygkKazxuW
	 aGP5JHETCRd9w==
Date: Thu, 29 Jan 2026 08:25:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Teresa Remmet <t.remmet@phytec.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis
 <afd@ti.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>
Subject: Re: [PATCH 2/2] net: phy: dp83867: add numeric io impedance DT
 property
Message-ID: <20260129082508.274f6e35@kernel.org>
In-Reply-To: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-2-8deccd658d16@phytec.de>
References: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
	<20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-2-8deccd658d16@phytec.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 15:13:34 +0100 Teresa Remmet wrote:
> +		} else {
>  			dp83867->io_impedance = -1; /* leave at default */
> +		};

drivers/net/phy/dp83867.c:534:3-4: Unneeded semicolon

reminder: please wait 24h between reposts on netdev:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pw-bot: cr
