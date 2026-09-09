Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65826AA91;
	Wed,  9 Sep 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914605; cv=none; b=A7m5w1ndUu6Iywn1OQdnf5d99yuw82GcU3W9wALXOBwD9VNv++7JE2oC5xTZ45vKipWqZsFIc7Q3W/qIZ/cNqdc/BqIiICmW9YLyQFWUJv8O/BeAEKSxiTvzdYa2ab0avxbxdNDTib42UCk5IeNtTFgpuKhodnnXLKO0voIIRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914605; c=relaxed/simple;
	bh=YiXeOXLDhp6HCTF+1UDnKEDXNGJLWlgo55tIVK6qy1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cy4uM112fCdUbyoT/d7Mlkr9NJCiA7LHkp3EMZijfSoRFCo+NmU/Zss1Q6TY3Ajvn8rXJLHE3L/mxhc07hzVQD4M9vbvuVUYakdxQc7/vdLKmcwr9TsUVraU+H1+jwwp0hwAxsCRrLVPuDsVs10oRGOZmVmCEjDJyYpcMpSGSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erOyfX+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erOyfX+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62781F00A3A;
	Wed,  9 Sep 2026 00:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914604;
	bh=A0AI/2Fxj+jNTDNBU+qLmOFELJBa4CI89P+ORcc4rvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=erOyfX+QQ+VDCMnnFUD5fyqYumbdIMwyqGV0O9C70AN++J+9c+DUAQ7U2WN2j14ac
	 Fogu6sw7wGhlRLE0zNZ7fDbsGcQmso3cHF/SXpMkruszcy0uziO1wNnznr36gymJFK
	 XpF1oHoIjqW02IjGxgeYogTmefGnkVeh78xCa4hcl3pIcwKyHRNLWau1kE0KZMXuCE
	 B70jc/9HW7/Cf1Z3M6YVfEgFDZXrMRYiaQfLh1RagBMu5hBQjZHgf4SjOvnVS02DlV
	 JC+FKLrjI1OaIIh4P+qG32NzreuHSG0I29YsrD5KqZod5trsFIAL0+zLJMkxfus23s
	 8B/r0KJFGmmTA==
Date: Tue, 8 Sep 2026 17:43:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Jan Havran (Advantech Czech)" <havran.jan@email.cz>, Hauke Mehrtens
 <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Daniel
 Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: lantiq_gswip: fix
 GSWIP_MDIO_PHY_FCONTX_EN value
Message-ID: <20260908174322.61223934@kernel.org>
In-Reply-To: <b7d56704-2aed-464f-8295-2ad70e4afa2c@bootlin.com>
References: <20260907134818.16670-1-havran.jan@email.cz>
	<20260907134818.16670-4-havran.jan@email.cz>
	<b7d56704-2aed-464f-8295-2ad70e4afa2c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 18:28:32 +0200 Maxime Chevallier wrote:
> On 9/7/26 15:48, Jan Havran (Advantech Czech) wrote:
> > Per the GSW145 data sheet, the FCONTX (bits 8:7) and FCONRX (bits 6:5)
> > flow-control fields of the PHY_ADDR_n register both encode 00 = AUTO,
> > 01 = EN, 10 = reserved, 11 = DIS. GSWIP_MDIO_PHY_FCONTX_EN was 0x0100,
> > i.e. field value 10 (the reserved encoding), instead of 0x0080 (01 = EN);
> > FCONRX_EN is already 0x0020 (01). Enabling tx flow control therefore wrote
> > the reserved value.
> > 
> > Set FCONTX_EN to 0x0080. The register is shared by all supported parts.
> > 
> > Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
> > Signed-off-by: Jan Havran (Advantech Czech) <havran.jan@email.cz>  
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Other than this last patch the series reads like net-next material 
to me TBH. New board enablement. Is that fair?

No need to repost either way.

And thanks for quick reviews!
