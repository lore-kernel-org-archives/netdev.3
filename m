Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE03557F3
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732940; cv=none; b=prOthuJcI6c5xBVT8Wy0TBDeli9OOxN0O39ojH+QvIbPeov0flR2Y6ajJ/Pv9cG87E9XSYjUFP/WfiwXp7dZ8PQ5YE8l1SowZ9PjtAqoMBlW+WNVJtNkGNdcy4IuL+Ze0fYvQWWXLK3Bsi1yqjSjRyy3s2iU3O/jtcdXCikbvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732940; c=relaxed/simple;
	bh=w4wrYmtL3HjsdrXEom0b4cNqZ7oS86TzhgPJxwMnYDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2bPNVkcrn+8R+O8RpdNVTLaBtGGYWbMq1CkUsYO9AnkaKB/DZKQH6Ez15vc/639EAGldJcnkjomCFGQh0fIWDuK9QejiaVDTAEp0cSifkuNlfv89jfPvzqKMzDJKaxrX/uj1KlbB8qZAETFDM1fjZjyjS1LsboblWGdc8EPIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsxnI0ph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsxnI0ph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0611F000FF;
	Wed, 30 Sep 2026 01:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732933;
	bh=pIrJrbkQWIPYW72ttWtQU7r9GQD/sI6el/Cv2q8jrm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fsxnI0phzv0equeX0xy+ZSwmKkcAzBQzTxsCki2Ko4dIc50WLkdGtFRGAptCcukV9
	 Cg4bTqvRLg5wSECENfpqSXQLAVrQnCbvCawZiItqgu20Qz5PLOmq5e5XqGazK7UJ8d
	 fdyDZE77/dFLZ8+FTFn1EtwOoriVDGicLu+pn+35be/Ca51jn3tpOScJFNjjjh1dM6
	 CJXrQ/2etiv7CXeJqxnjbhXzI502nwkvXDlixsj//aQkxcNU+jfKIpCdW406DuP+vP
	 4ero2REk7OETw/5R4gKPOmulsJFJfVdh14epH0mLmt3JEcB1kR4FsOmTGQnARsKrhw
	 DQwgV2n4Mzxlg==
Date: Tue, 29 Sep 2026 18:48:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, Chenguang
 Zhao <zhaochenguang@kylinos.cn>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 1/3] net: libwx: keep NGBE OCP cards MAC enabled
Message-ID: <20260929184852.364dd9e6@kernel.org>
In-Reply-To: <20260924020149.30800-2-jiawenwu@trustnetic.com>
References: <20260924020149.30800-1-jiawenwu@trustnetic.com>
	<20260924020149.30800-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 10:01:47 +0800 Jiawen Wu wrote:
>  		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
> -		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
> +		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP) ||
> +		      (wx->mac.type == wx_mac_em && (wx->subsystem_device_id & 0xFF) == 0x40))) {

This condition looks way too magical for upstream

Add some wx_has_ncsi() helper and add it there?
At least then the meaning is clear, here it's next to WOL, no idea what
it's supposed to mean.
-- 
pw-bot: cr
