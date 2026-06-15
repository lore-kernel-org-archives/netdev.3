Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02A2F12A5;
	Mon, 15 Jun 2026 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556911; cv=none; b=JCd6HqRdrFRMo4X38uW53iR7GVWMTOf53vYYocAE878kjeg3Hqt1Fd+rwkCdccr0hJ12ZczFS/Jna0IhlD/KcGTY+fLiKaywDLxsw9DnHvcsiUaxx4820ymRgQ+H3hbkYga9EzCQei6CTPeaMafI/QmPlj0HKlL7zYY9OIyKqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556911; c=relaxed/simple;
	bh=lZwdFwKFAoSFzDCeOtIwcjmsxAiKODYH1oJfwjM6FdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUQfJktAhS7nn6VVSUCGUcBthHv7miOFgzuFwOqBRSv3fd274W63AqCu9XE1Ag7viEoPVXhihHcTeDHnmyCdVfaimaljpgUatVym69b3e44eZUo6IqGH7MnIN+AJYueU0wJV3zm/SmjClvxfi7LCKWB5joUS+Qt8+F+9VvO1mz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaW/WZcL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaW/WZcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B1B1F000E9;
	Mon, 15 Jun 2026 20:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781556910;
	bh=UHz2gVgEYhuDq6Px4YiBXlefN2X8uO6xuCskOVJmhjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OaW/WZcLc/H2DdGxZ/E06MAegjsy/nU6eXAk99WDWhzkJo92P1Gz8tL0IQu7E/HeJ
	 rsTxkpU159G0+pljiCQaum2cTb/JwZR2WE6zyNojTj1LOx44i03VRK1GgkBRx2LoyC
	 AogaF0jIvif1WwidakB5M8Pt2m98HCRauGxkxkct1J3HqAGqFy8xNT3vwi+rfbXZ/A
	 +HDRN0meUQ7ALXn2qeOqZcsuGKz1M+G288dlJBiln7DIK3f0E4/rZusxO/mMJ9hKC4
	 +JrwmYrEwcRR1FD9YNh/8Dh0CD1Tmv/x8bFqPztZfRmQ5GYW8jsL4y77+z3zL6Knm4
	 BhNug0kVkCVyw==
Date: Mon, 15 Jun 2026 13:55:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Cc: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Richard Cochran
 <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v5 05/15] net: ethernet: oa_tc6: Move constant
 definitions to header file
Message-ID: <20260615135508.692a7725@kernel.org>
In-Reply-To: <20260614-s2500-mac-phy-support-v5-5-89874b72f725@onsemi.com>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
	<20260614-s2500-mac-phy-support-v5-5-89874b72f725@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 10:00:21 -0700 Selvamani Rajagopal via B4 Relay
wrote:
> To help other source files within the module share the
> constant definitions, they are moved to a header file.
> 
> The memory map selector(MMS) values that are defined in
> in Table 6 of OPEN Alliance 10BASE-T1x Serial Interface
> specification and currently used are added.

If you're adding kdoc on functions the return value must be documented
(unless it's void of course):

Warning: drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c:34 No description found for return value of 'oa_tc6_ptp_register'
Warning: drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c:143 function parameter 'stats' not described in 'oa_tc6_get_ts_stats'
Warning: drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c:185 No description found for return value of 'oa_tc6_get_ts_info'


Please note that net-next is closed during the merge window, please
wait with the repost per: https://netdev.bots.linux.dev/net-next.html
-- 
pw-bot: cr
