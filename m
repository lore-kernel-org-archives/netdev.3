Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074665;
	b=VgQD1N0fHyXtz2ebYRtlAUbtSYGxOd/aGOWwjnV4N3CAY/jOKd01bXm+GDCCp2vFkuCe
	 MX1IhBTMuwVUaFs8dwRXXphEG0vmlIVuyRQvkvGeVscWGg+wIeAZrN/261BqZdZH3bSq+
	 +fpse+j3nzQcDJmiLCGFJ5x5i3nZqs2EGwGGcT6F7L/YB6v0l+G8Bc+zQcNxz9tNn3R2a
	 VovoOO6L/1Q6x4P1TrgbJQH/yuxnONKyNzuIN7RN6jhNK5nAzuicfSjOlA+X8FaerYTyc
	 ccEGRNx6YKFFHpkfmsok6k+scGzc90/oHjHUwV00gCk+cbCv+fWsPZ+tP/B1Cn59hag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074665;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=QXa9zPuXA8rkMsYvvuuKZtvoPATPnpClQ4XaIx2/zF4=;
	b=footZrQygu18/RXX9gQnWn7ZkIXRaXB2xsatufxPJyWTpNeKT57wkGo5L0UiIQGYJwtj
	 p4vZmYdqtynO9IfyIwt0Bxk2MwbYzKxrhsAzjIEYMz7PubjvHqPvJN5ClIDEcHPVBmKgv
	 AFxlu/o1pzTZjuQfdu5SOFg9VRpq0In1CNj4jDjScTg8AFZUpwY/eAvlGcfUaJTGOTMLo
	 EtwCpnOXI5MUuT9Ab74SSIPkfUz/C90ZQ70gOQtENpfp/1uocDP1vau35iDTCccgZQsod
	 NxIvDLA2KfI2nfj4nrvjpk0tHw5fmwWhe5QdhCioeqFQyZ1jjogyg+USKXlScq77DEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=eq1HoqyF;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05B606A32C;
	Sat,  7 Nov 2026 18:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F05B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=eq1HoqyF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QXa9zPuXA8rkMsYvvuuKZtvoPATPnpClQ4XaIx2/zF4=; b=eq1HoqyFQIvJLyReDT83mibARm
	BGgcdJ0JbC3NASn9nta9n0oNtzGHqCxRrlT9WxKqRxOeSTJ8Y3ic/a/FbZMUrVij3qacGwXj4IkBu
	UOeV2+mgVGR8R1qfkjHhmIgEEGnJZ1ynvSbxCCRoPPXycjD3MNSTtab7ceduuZvm5Pg0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPkm4-00EzOJ-1p; Sat, 07 Nov 2026 19:04:20 +0100
Date: Sat, 7 Nov 2026 19:04:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next 3/5] net: rnpgbe: Support copper link
 configuration
Message-ID: <a60f0f38-85c7-4453-8a9d-310db05f4615@lunn.ch>
References: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
 <D2E577671FEE0E12+20261106112533.44065-1-dong100@mucse.com>
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
In-Reply-To: <D2E577671FEE0E12+20261106112533.44065-1-dong100@mucse.com>

> @@ -236,7 +236,7 @@ int mucse_mbx_set_link(struct mucse_hw *hw, u32 advertising, bool autoneg,
>  
>  	len = le16_to_cpu(req.r.datalen);
>  	mutex_lock(&hw->mbx.lock);
> -	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
> +	err = mucse_write_mbx_coalesce_event(hw, req.dwords, len);
>  	mutex_unlock(&hw->mbx.lock);

This seems out of place.

     Andrew
