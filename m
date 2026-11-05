Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845283;
	b=UOoxFiKV5BYU6IT+smrZGHcf34LvemVe5zGzPZ+76fuw3mkpYluVAAyk7ZjZj3WMvwSk
	 HuY9g2yp/1bsCky0zi7p95hHswTtRKxNd3aVI8v2T6zN2xFTrgfaGNiznSWbfteWxk5GO
	 Fl/ZmmsBD4o4TYf1BmRtkpKgRBdF0UmpyXHU+gAW0bHtqGi61SsVnTtbVeZJ+y7NtTrox
	 CgKf2T5OyK9jPX1LLy7+g7wzjFZXbI0OACsgpSIhlcnX3TyccZpFP1Pk8OBNSs2cpYR2C
	 dQ8wovPrzieXn7Yr/laq1NRjgk4SZToUTqSeeJl1U3JTO6RNJ3rahG9gArANdUBNyBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CPWvCpHCYoWPM5p3/a4KEe4RRG4SBGN/TGqMoA1qGPw=;
	b=uItRIKz9GDQoCBoyCyhvPwpRiPY9ZGo26cOy2Mf62mOYc4aIXjQ4KGyw6/r6ebj2ZLzz
	 y93ck1uvMU84oaXema69OX+59prqPk99t6i4xqdaaMc2BzoDZueMhCnBQ52rHFWWhowVB
	 Kwl1BvXgH2kDe2bHbCHPuk8i/rTKAdu4syGQ2gsqZqxud3vcjT2HqXDXWNfQX8aLkn4JS
	 C815vkViKmgqYL+8lNMnWAbHT2UHqD/H5/RuJehkRFtHFbW+alQQzWAUwOeeM5RL8IPSU
	 ku9DMBv8eQk9CeGckxAu+T/0XGU9BfS/V9UjwZv2ExrhJpuNLm1i8SF8MxA+r29eqaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=upYHlsIT;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4578606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 02:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4578606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=upYHlsIT
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so1829816eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 18:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845282; x=1794450082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CPWvCpHCYoWPM5p3/a4KEe4RRG4SBGN/TGqMoA1qGPw=;
        b=upYHlsITZy9Egx9YYgwt7G5l8ujPMJ2sprITqpQJ8YYIF0KpweIe0Y2XL8zE9ilu1i
         xs6ZGv/606sHvwgPSm0UCFDE6d2pAwyyxqzFkBRIITXNTMfbgZlbro5Kacp0ggGLCnDS
         77GIfh8EkEwq6VzYFJleOyqMPviwuHP8aHndDfCs2NtRl6xWHqJst+FFAZJR+bTFkUt4
         MNWK5iYz6b7T/q7rwNg0zLbbh8xRucO3mrtYT7bJv40h1kyRmQ3R8H3qg3s7Wxjeik3w
         4nvrJHb1DQdzPLxeqCDKUNIr6B2PETw3tQZku/Tzw1AuqnKQpvSPVkUHb8zIZWNaZX7o
         Pe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845282; x=1794450082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPWvCpHCYoWPM5p3/a4KEe4RRG4SBGN/TGqMoA1qGPw=;
        b=hX/Uc5cFdz4X6cMBdqmTiSxnv3WeAHCRpwggoZDq6zbsaA9+ALvpe99WVk37haPY5K
         2xFmvd8XLciY8n8FwKfwM3JnpebjWK88FS1yrgwSBuyVj+agbIhz1s9e54qjNi4HdHPT
         X39yLAq+XyNjyEcfQ9r7/oNOkboHk4sK5D6gF53N84DWsviYmx7viMI/Jy4tZh30mYVO
         RkA6v5W9BEzGj78oQc4hB10zs7eTMGYZTkNbEdcwmDnCkcY7lYHdY/YhaC5HeiAhMdwm
         gexZtVhOFJDJL95V2e+TQQvcjCz6/gnDtIbZ5d6xxPUYSYRv3Q5u7PGIRVpLbsgstm35
         h1wA==
X-Forwarded-Encrypted: i=1; AKwUvBxuU/MCosWMgUyxubNFDR8heuWTqSyTsIFJ20+ClwmULNgl8+oEe69pUow0us2pXG4S/J7ts0U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/h1PGYnPqp8ki6jZFzLuiOxGQhyGPTpS/2Q7Tx8oePzDh5INde
	snPIqwQOO5RyXcNR8fZND9iK8KH+7gst064Jw/N4VClgC4zuvzKxTbFw
X-Gm-Gg: AYBFou21zJgd2OL6LqjK0HT461+fiFua2szk9QlSFcEvCpqVzcIblhm5Ogl0bf4AIMO
	CNVE81UPWeF/AQ7O23sZRElTF/X4noeC5VVx0Zlxj45S20+5araeYwUC4AeuS1crkYpFNF49Y97
	xcXBFZZFOIVcnWNY868qO/qcke2LITd5maPOkfTcuvVnuDNsEAd2+gK9QZdeCE+0IGD0MVxmg3F
	VV0laiaXJg6zQGV52yS27hxTaJpL3Y/DKhPESjs/niCgeX1Nm9DH3dKWk7jIdWzLAkC+HkXNR1i
	8gfl6cP4SEzPcL7+sTtFJ/ReKHzmx3wqXIBd0PRh0CIDOfJ1z6WwBigN9jnqmMfDtMXLypGVGA4
	B5psunxT+eOWb7rjTob+i+gBiIzVmF4gOAHHmEiiF2e1yGK+dz48A5jr4Y0GlFvZRqH/emte2tR
	yZ5j0iORklGDKIKq/BQ2gwHhy7yVCE/MCP4spOQciPmKvxlVs8cmZOzRRa0LigcjMpRjvbgYfRU
	qlbV+TiM6/3Rn0HYZ3e5sOdPSb503N+M3sa16CcMAmYcQvqr5Giv3Ix2VSne48fmIxwFTcRrrUF
	m2ZnPr3WMK9CsTgO0MZdi+p9Splt
X-Received: by 2002:a05:701b:4186:10b0:137:5b9d:cf87 with SMTP id a92af1059eb24-1ac4f91ee96mr27294468c88.0.1793845281828;
        Wed, 04 Nov 2026 18:21:21 -0800 (PST)
Received: from gmail.com ([2a03:2880:9ff:71::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm11719698c88.8.2026.11.04.18.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:21:21 -0800 (PST)
Date: Wed, 4 Nov 2026 18:20:49 -0800
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: Peter Morrow <pdmorrow@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx4: drop the unused is_supported callback
Message-ID: <auvoAYT/rwFrzoSH@gmail.com>
References: <20261103122109.1798144-1-pdmorrow@gmail.com>
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
In-Reply-To: <20261103122109.1798144-1-pdmorrow@gmail.com>

On Tue, Nov 03, 2026 at 12:21:08PM +0000, Peter Morrow wrote:
> Since commit 557d80138618 ("net/mlx4: always create the eth and ib
> auxiliary devices"), both is_supported callbacks return true, so the
> checks in add_drivers() and delete_drivers() no longer decide
> anything. Drop the callbacks and keep the aux device table as an array
> of suffixes.
> 
> Tested with this change applied to 6.12.113 on an Azure VM with two
> ConnectX-3 VFs: both auxiliary devices are created at boot, and
> removing mlx4_ib, mlx4_en and mlx4_core deletes them cleanly.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Peter Morrow <pdmorrow@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/intf.c | 44 ++++-------------------
>  1 file changed, 6 insertions(+), 38 deletions(-)
> 

Reviewed-by: Narcisa Vasile <narcisav.kernel@gmail.com>
