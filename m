Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3E31F9B1
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783458836; cv=none; b=RiL4R6KS7czKRhuQ0eRAD+vAedxsk+ttQ0Q20esoFbnySPsXSuhFFLWuG8hJmoBaxusCpwoVLPdHEP2Mkb7F0aNegrgLDZcNncBbyPIUBN34jxerihmSsZIZfCmItvKKQxKLo2AOKzHfj8iZx7f3DigCADrmm/qv3kU1txcRzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783458836; c=relaxed/simple;
	bh=tkJFDun8ROmuLnNZ1rqcLbRSgaRN0Jp+2lE6McjBJVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=g5sXfTQBCoQHc2OlV745zqNeS9OQ3arOks048vrOjgImm/GxBGftHjIQhZ3BD5+DAD8DnzPv0Y8VH2OFMHhmE+Zzsk1D7Pd8b1T+bZABMnvrS1ZHUcALUXDBgaB34uJ1T8f+V9lCWdKkbF5MouvjgcEJ50bhx0q+2J0e7yq1xy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g+Ed3nNy; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g+Ed3nNy"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707211351euoutp0190a06f4adb6166f4d5b5e1ca8416bca1~AHlukccdD0717607176euoutp017
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 21:13:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707211351euoutp0190a06f4adb6166f4d5b5e1ca8416bca1~AHlukccdD0717607176euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783458831;
	bh=f6dDVyB9psyNYoQa6fpOddWiAy4i5cRkpJCqDed3Ch0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+Ed3nNyo5M80NkQfw4jAOTolFRfSoCAZrGKYdeQZ5srfwWVfaMd4reXeEstc1Azb
	 b8L6XWcV9buiqK5GEAIf8XG0g+VolaZoBhzREGML5sQnoI+Cba6uTW/I6hsTE7c679
	 gDI+2R5xkDNpwOoBSX5x36ODkRHE/2Cmwm/zxymY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1~AHlt4_tXc2809828098eucas1p2g;
	Tue,  7 Jul 2026 21:13:50 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260707211349eusmtip17f0e062b7abdf62ff97e46a43741acb5~AHlsxBQqi0242002420eusmtip1L;
	Tue,  7 Jul 2026 21:13:49 +0000 (GMT)
Date: Tue, 7 Jul 2026 23:13:46 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Stefan Agner <stefan@agner.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Ovidiu Panait
	<ovidiu.panait.rb@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup
 when opening the interface
Message-ID: <ak1rseUKTWFKzBib@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707195425.405989-1-stefan@agner.ch>
X-CMS-MailID: 20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----z0KHaxdBtqrNA0Il2CW.z4n_bpDWqNzZNiGZPVyhi_2U0Kf4=_8fd81_"
X-RootMTR: 20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1
X-EPHeader: CA
X-CMS-RootMailID: 20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1
References: <message-id-of-your-v1-mail>
	<20260707195425.405989-1-stefan@agner.ch>
	<CGME20260707211350eucas1p2c7d585a2f5cdcfdc3f1d9f7bcb1759e1@eucas1p2.samsung.com>

------z0KHaxdBtqrNA0Il2CW.z4n_bpDWqNzZNiGZPVyhi_2U0Kf4=_8fd81_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Please read
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
in this case 'don’t repost your patches within one 24h period'

Because:
- you have two patches now processing and no changes requested yet,
  nor did you get AI review that is currently employed
  https://patchwork.kernel.org/project/netdevbpf/patch/20260707195425.405989-1-stefan@agner.ch/
  and
  https://patchwork.kernel.org/project/netdevbpf/patch/20260707162146.73823-1-stefan@agner.ch/
- This change is actually broken - in previous patch rtnl_lock() was asserted
  by dev_ioctl(), but in this version it is not asserted anywhere and will
  trigger WARN_ONCE().
- Full tests within an hour is possible, but no need to rush patches
- Please spend time reviewing patches, as I spent few minutes to make sure
  you (or rather Fable AI) is correct that rtnl_lock() was asserted, so my
  review would be accurate (previous patch was ok, this is not).
- Please respond yourself to comments, take time to understand codebase.
  I would prefer not getting copy-paste answer from AI,
  we have Sashiko review for that.
- Missing link to previous thread, shown below
- Moving code to other lines does not justify dropping "Assisted by AI"

I am not maintainer, just random reviewer. Some maintainer will give input
surely soon.

But rule of thumb, do not repost patches till your patch gets
'Changes requested' in patchwork or like 2 weeks have passed
(maybe during vacation even longer, as currently there are >600 patches
pending review).

On Tue, Jul 07, 2026 at 09:54:25PM +0200, Stefan Agner wrote:
> Changes in v2:
> - Move the PHY resume from stmmac_change_mtu() into __stmmac_open() so
>   that it also counters the PHY suspend caused by __stmmac_release()
>   (suggested by Andrew Lunn), placed before stmmac_reset_queues_param()
>   to match the ordering used in stmmac_resume()

Missing link to previous thread

> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

BR
Jakub Raczynski 

------z0KHaxdBtqrNA0Il2CW.z4n_bpDWqNzZNiGZPVyhi_2U0Kf4=_8fd81_
Content-Type: text/plain; charset="utf-8"


------z0KHaxdBtqrNA0Il2CW.z4n_bpDWqNzZNiGZPVyhi_2U0Kf4=_8fd81_--
