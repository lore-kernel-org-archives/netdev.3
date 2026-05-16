Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385425D527;
	Sat, 16 May 2026 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778908907; cv=none; b=cSKzfWuvt0yn39FbtvK2i3AD0FIWLfs4XEKnHAtsKIAdM64YISXXrCBjxiqvSOlaR309Qvz3QLzUJznz331UhBleXHf/Uq2F/ZxZixUM3TK4Cw4Osn9B6QPT40qdwpxlph7/dd7EH9IyuKxUZWJx1qsOluXe4Rmp3upCY6c068I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778908907; c=relaxed/simple;
	bh=7YCan+YdCQL7Po5x92ZUlFEKUag/P+YkjqJZ4aopJjs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YNlQTcfdU8kKmUq/JCyoB1YAVyOG6/lpN1kYS5ciP/1w0/MaSuLGjgK7VnxC+7vL3J0TtKAmsKLcJVoQLEHcDeeuSE8aWVRwvf6lFUgmBDCqHzQvr4LtQTYp7Kw0HLqH6rj3kCxPnsgQPabTh/QY++BODLmDvV82wgxFnJU9yP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=l6Yfmwuq; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="l6Yfmwuq"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1FCAA0387;
	Sat, 16 May 2026 07:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1778908903; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bQol4ULV4fOwkE0qcMCv/ZNRjXNX1V25I7d9Q9P6Voc=;
	b=l6Yfmwuqov5bobFnyHIFOyrMyODzR8KujgEYX9LkAayptEMed0OW/3n9x8uoOSQifW8TC+
	/lNizyEQgysW0xTynp6zL/r097SuqScnwQw+/fhnjoWK0UWgUX0YnbcTvg/xuyvnhp27mg
	1sdD2ohak0DMiRRrvqq4CuLZi/9e/AM/r/Ja4ysVhTepZA3JFyL96/fM/nNt4onkGrwoQ7
	jJ1UNh+q+9KFhTkln0LnMJAgLjLd5sTpKxzz6S4ZmzVCoiGbKMc18Co7RH1p8yNVfsS5bA
	OOE1EwvWrezgtGnsH9jpC36W59OiarrYnd52GMthZ0ytUeK8i6gm9Yq2zgDsrw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 May 2026 07:21:41 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: honor eee_disabled_modes in phy_support_eee()
In-Reply-To: <20260516-devel-phy-support-eee-fix-v1-1-59debc00eda0@tipi-net.de>
References: <20260516-devel-phy-support-eee-fix-v1-1-59debc00eda0@tipi-net.de>
Message-ID: <7a4e0d4b27bf662034f7eb57de8e9ece@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 16.5.2026 06:51, Nicolai Buchwitz wrote:
> phy_support_eee() copies supported_eee into advertising_eee
> unconditionally, overwriting any filtering applied during phy_probe()
> based on DT eee-broken-* properties or driver-populated
> eee_disabled_modes. MAC drivers that call phy_support_eee() after
> probe (e.g. bcmgenet, fec, lan743x, lan78xx, r8169) then cause the PHY
> to advertise EEE for modes the user marked as broken.
> 
> The symptom is that ethtool --show-eee on the local interface reports
> "not supported" (supported & ~eee_disabled_modes is empty) while the
> link partner sees EEE negotiated and active.
> 
> phy_probe() already filters advertising_eee via eee_disabled_modes
> after calling of_set_phy_eee_broken(). Apply the same mask in
> phy_support_eee() so the filtering survives the copy.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC 
> support EEE")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---

> [...]


Sorry for the noise, this patch is missing the net prefix in the 
subject. Will resend as v2 with the correct prefix tomorrow. Still 
learning b4...

Have a nice weekend,
Nicolai
