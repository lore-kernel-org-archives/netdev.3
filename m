Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404402;
	b=y7EAyWGYeYYg4e0wnB432pNKdk6hbUQmAC5qIDIK23oGgWHbGWLR5em17Z5CqVDAO6Hy
	 MUJeKyTQa2977VSW+DHQUPpcWyZCHHJqQnV3iZFYxLFaBwa4+PLN3/SJNUXydeg+U69e/
	 PsUCU9EZFsbyTHbGgqv7RipK3T73E0r6WOrm1OIF6gdcTqTqf21GqOLgKy72AaEFfcwhu
	 9o4dkl9bQ/0GuHmim7KJGyfRUidKCvLLVyV5xuZQT3OZ3OUxDuHBuwt7dota6WLEy9mgj
	 9YyJSX3XrTGOBsgAH8/7iLPTh5SyJPHWR9NFS5skdHK8oJruFxBlcKxI39VXQFEdkzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404402;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=/6HHvAwRP0bBA3afQXfQ1zDZEhkkb4+3EN2Lma0qsSc=;
	b=4Od/7kY61KiFtNbuFLpx9FLq+/gfigQxwXFew6VxqrWNnq/ItB6LJZwbIlsQTnp1kxPx
	 Erjk6YZRrHpHWrQmCPegRJZ294wKrIpC6VJtcV73V5wwc1VXrn0pTuBMd9ZJTG+/RfcA1
	 Dn9iM5bQY/4ygCu5Gp1L9yo7oQzZj7AEsx7QSa0cEY7lxTAY3ezsAdY3WucrmSJlMv9fP
	 8WNN7/BkIN3iTY/bzG1aRR7Jp4h36aL2jUQcjHWblQJ6zI0y2Tkqw32tpFFqx+8OIY1/I
	 Fr0ZWlV9PBfGfp7UCgejbBv38eg3H8sFfkON9MM97jcKBphb9zyqeLOf8V2vaBzZmmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Lc97omma;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AD606A324;
	Wed, 11 Nov 2026 13:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9AD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Lc97omma
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/6HHvAwRP0bBA3afQXfQ1zDZEhkkb4+3EN2Lma0qsSc=; b=Lc97omma4TNeqNUSseJ5Bp+oX5
	KzI27KDwxf9EscAcRG/4JoqUVgPaZuPNLllDrxjCGDsvAXak2o22KXE0HXjLbFOTgXVqh7I75JAJn
	Lt4zo/y1Oa7PKYccSob+dXWpdVY5xa/rcIbttq4uF3gTxkYsryRTg2nJOyHg4WBV3ZFg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xR8YI-00Fkxp-Qc; Wed, 11 Nov 2026 14:39:50 +0100
Date: Wed, 11 Nov 2026 14:39:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: Re: [PATCH net-next v2] net: phy: aquantia: Poll global status
 register for provision ID
Message-ID: <20881de9-927c-41c1-ae30-829382d531be@lunn.ch>
References: <20261111-aquantia-poll-global-status-register-v2-1-b602fc7e80a9@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-aquantia-poll-global-status-register-v2-1-b602fc7e80a9@oss.qualcomm.com>

> +	else if (ret)
> +		phydev_warn(phydev, "Firmware provisioning ID not ready; "
> +			    "interface mode detection may be incorrect\n");

Please don't split strings. Somebody is going to grep for "Firmware
provisioning ID not ready; interface mode detection may be incorrect"
when they see it in their logs and not be able to find it.

This is one exception we make to the 80 character rule.

    Andrew

---
pw-bot: cr
