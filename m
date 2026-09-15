Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522383BB132;
	Tue, 15 Sep 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486660; cv=none; b=YL1fwh4DRoLrV9mYcgAcMtKYvJCv5/DwHfXHL0yiDcl5S66iS0x2QcAtXX+eA5tCgExW6l/OEQfb2GFoqiZkGovCwDZz+t2WGGsnEeqQZNZbsy1a+lAdXnARnwCQ2W380/o3pZySdjXxQu+Q6pFDd0vtHzhbVWqtezqg/SF/xTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486660; c=relaxed/simple;
	bh=DT+SWJ13NttiGG+Ep4psKjU5Tou3i+97dhAxqXxgAbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRaU/5MXJLJe3B4K81qCJNcBpw6lbzpyD0Zx5XDVUDUmUiwVm4ke67UFnzIFvmcYx/FTOMHvt5z8LVfmcKTV/DmiL7M7v3ka4FiGAIc0Mh5sxiOqK73s5e+B1HqoL9tLM+0FbbUVjEu/X7m3P2Dpx/hUNVaRXHzsj8p4KVCzGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t4ZkLUTT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t4ZkLUTT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XOFjEqSeg2fKDr1RwpSbootKD7M1VPsazqazY07Yljs=; b=t4ZkLUTTN2iaVtGfnkFxMGlSzV
	MTG81GiY1wSi67XuzzXBOoONYTu/w0ULC2PJ8P+d5t1xqfihTmT+BI5H/VUbsFp6Ohp2nKq4uQjF2
	HBM0Gc6smOWcW6SQccL2cAloTtyGXZz/eDQOgKVwR7jYpf+aCtLrzMBeEV8cqNCiAIJc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6VDp-005Iqc-OT; Tue, 15 Sep 2026 17:37:25 +0200
Date: Tue, 15 Sep 2026 17:37:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH v2] tg3: clean up PHYLIB resources on probe failure
Message-ID: <b8973293-8132-47d7-be28-972ec87b72d4@lunn.ch>
References: <20260914222246.29761-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914222246.29761-1-mhun512@gmail.com>

On Mon, Sep 14, 2026 at 06:22:46PM -0400, Myeonghun Pak wrote:
> tg3_get_invariants() can register an MDIO bus and connect a PHY for
> USE_PHYLIB devices. If tg3_init_one() later fails, its common error path
> releases the mappings and netdev without undoing those PHYLIB resources.
> 
> Disconnect the PHY and unregister the MDIO bus before the remaining
> teardown. The existing IS_CONNECTED and MDIOBUS_INITED flags make both
> helpers safe when initialization only completed partially.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 158d7abdae85 ("tg3: Add mdio bus registration")
> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Remove the redundant USE_PHYLIB guard; both cleanup helpers already
>   check their initialization flags, as discussed with Andrew Lunn.

That is not exactly what i said. I pointed out that tg3_mdio_init() is
not guarded by USE_PHYLIB. tg3_phy_init() is guarded by
USE_PHYLIB. Generally, you keep code symmetrical, the conditions you
apply to init should be also applied to fini. However, the existing
code is not great, tg3_remove_one() is not symmetrical. However, there
is no reason to make it worse.


    Andrew

---
pw-bot: cr
	
