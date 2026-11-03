Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669070;
	b=C2QdBHHkVYN5FLAP87STxfkv41r33K9xjiUi6YB1vLOjwN//v3B5RX/e7S9v+tRn7cao
	 bVJ8KwzcVBjlbn/QoivLZO6amNt+Abpqa7Eyan9o8LSqVpplMufZgsKPeHKnLBnjqMJxx
	 Hk/aVDhzeWqcnU/h06Thk/A+xAsfjOdubGIdDhca+huY4kxZb32UqZh9pEzMT+fK/l4J6
	 KsPkwZu7KKnChM6unk8tjg6HSNWAgvwR5gWQ9siQ07U4RFQohMDec+i2KR+FPygYt77z7
	 iO7d0Y385bCPle7plawKdiUES5EirD5LhnlOEKMZ2vvrW/qr8JNS/pshCDqW9k00FCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669070;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=p5Nzo4zVImtwzM5jHraDEgWZ4rNYTRLIWlg6N9Tr6Ws=;
	b=PtiOOxo/5CW55ZscYVrJ5+OYyR7fZZxavEkSMlz9gO4m0984YWPIdhqjmtsfE8aWjMub
	 ojnMToFewyvHFbvZ4ezs3UHScBCFzrU20oBDRHHOe686FiuJOVPXt9OJVyRDW4G2CRRxx
	 XNLdrSUyMd6Q4SNbsEPd9tGaObBUswr4A3UDyNxRMhzg3MEAc6zINyz5Ih5miLdnxWN4K
	 Goz2BFWUFwGkC/TS2OP8h7YeIwuupNC1wAGp0TWIZvtXHFhR2R2ui75qSlZFei4QLbLo1
	 adjhNvfF51fHYM5j3IEGrL/R4WGW/Td6O5cEwGURQOXQrgA0jXFmyGUk+wEsKuqDqLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WZmZM8Ua;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49266606A324;
	Tue,  3 Nov 2026 01:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49266606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WZmZM8Ua
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p5Nzo4zVImtwzM5jHraDEgWZ4rNYTRLIWlg6N9Tr6Ws=; b=WZmZM8UaYFeB2tPI3A67FHdQAg
	jvzT8wplaqSqcKaMCl2c2I17nH2mkKD2Uj6ZuWuMbNHERq84hlyzmpV7Qx8treY36rbJI9aJ78Xx/
	dqrUBOMH88/RtiSvISiHyAy++uOHqYCqSYfIM/jIBwZJNtokSRyu1SKJgt2wg6okqp2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xO3Fs-00Dvwe-2z; Tue, 03 Nov 2026 02:24:04 +0100
Date: Tue, 3 Nov 2026 02:24:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romit Sagu <romit@romitsagu.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH net-next] net: sfp: add quirk for OEM
 SFP+ONU-XGSPON
Message-ID: <b94563d8-2414-4a59-9a04-d3fe671b02cb@lunn.ch>
References: <20261103011849.181392-1-romit@romitsagu.com>
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
In-Reply-To: <20261103011849.181392-1-romit@romitsagu.com>

On Tue, Nov 03, 2026 at 01:18:42AM +0000, Romit Sagu wrote:
> 
> This XGS-PON ONU stick (vendor OEM, part SFP+ONU-XGSPON)
> needs the same handling as other Potron-based modules. Without it,
> the module fails to connect and the kernal shows these errors:
> sfp sfp1: module transmit fault indicated
> sfp sfp1: module persistently indicates fault, disabling
> 
> This module requires TX_FAULT/LOS behaviour and boot delay tuning.
> Add a quirk using the existing sfp_fixup_potron.
> 
> Signed-off-by: Romit Sagu <romit@romitsagu.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
