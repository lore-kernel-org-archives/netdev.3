Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A333F585;
	Mon, 25 May 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704015; cv=none; b=aCDQtrOuv6TUHawNHiCCZnx3byBU8VVlOMf0lnqO7KNOvZoxT8HzCZeqWlXYDr9zdex62rP3QyRFwDFLoSrb6tiaILlTA3aJfGveeuj+ig3kGOsJwXt6wlabRSLda9MhaeEIWfyLvsa6DXnlpwPVzvrWGFc+Lm3W61mzskPQDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704015; c=relaxed/simple;
	bh=HGO6RWHBCJGuad05UMDXjVd8SiDTPsXFEudcMX0A4XE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=E7jNw9vQoj9x4MyoSlqtR2Qy+mytkKSOWJI/IT6f5IFjCSOgs38QL3rTF3c+ccdfcHW7cMgZQQIPwTv3cQF9qJAHcrsrwrFBg/oLhBIcIMpZ9tT78NIXrJkbWAXTNSsbYk8+PdCqRLZkdBKYyyWLr2j0dHAs6wqjML4owQWDEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=oqshXILg; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="oqshXILg"
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 944BC1002AB;
	Mon, 25 May 2026 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1779703654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70qsCwf9afpWCUvc1LMjVT/dnIDgU93Yo47dLm8jd6I=;
	b=oqshXILgxKl5szWS9B8CTaI2deqmSKHQq24N83UF7FKc5BxA4INDd++SCroOx00dF4yL5d
	8gcFyAZZANuVfVkm7sz2NntRMu4FRyR2z56YYNdpgik3ogAAfGob9zdb+qoJPkU1LXirzg
	gB5/KhnguFA/vG+6uHZo7ECSfFCRBs8=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id CD194360055;
	Mon, 25 May 2026 10:07:33 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 May 2026 12:07:33 +0200
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Alexander Couzens <lynxis@fe80.eu>, Daniel Golle
 <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Frank Wunderlich
 <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [RFC net PATCH v1] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes
 configuration
In-Reply-To: <20260409215509.si2dy63seo4iaspa@skbuf>
References: <20260409133344.129620-1-linux@fw-web.de>
 <20260409215509.si2dy63seo4iaspa@skbuf>
Message-ID: <64b40fbee19dc108752574419a38bcfc@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 4fca7f48-3824-442d-ac9d-7dba16a0e581

Am 2026-04-09 23:55, schrieb Vladimir Oltean:
> On Thu, Apr 09, 2026 at 03:33:42PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> Commit 8871389da151 introduces common pcs dts properties which writes
>> rx=normal,tx=normal polarity to register SGMSYS_QPHY_WRAP_CTRL of 
>> switch.
>> This is initialized with tx-bit set and so change inverts polarity
>> compared to before.
>> 
>> It looks like mt7531 has tx polarity inverted in hardware and set 
>> tx-bit
>> by default to restore the normal polarity.
>> 
>> Till this patch the register write was only called when 
>> mediatek,pnswap
>> property was set which cannot be done for switch because the fw-node 
>> param
>> was always NULL from switch driver in the mtk_pcs_lynxi_create call.
>> 
>> Do not configure switch side like it's done before.
>> 
>> Fixes: 8871389da151 ("net: pcs: pcs-mtk-lynxi: deprecate 
>> "mediatek,pnswap"")
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>> ---
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Hi,

just a gentle ping as i still not see this in torvalds/master.

regards Frank
