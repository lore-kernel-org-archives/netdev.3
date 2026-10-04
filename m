Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3E3BE623;
	Sun,  4 Oct 2026 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138907; cv=pass; b=izn4rR/iX7j+lXh2b6Gk5PASPcNSe/FuYpFXoAERs5c8IxdkWVmvm+NvqrcLp8wDwss3llVa3EXOuMwMiTsqQ+mxrlnGoyOKYMAlaiKpkMNER6A5mVhPXHEYheODCH1EsWKnmaelKfkv5oHiLXE9jZwpb4aAaSNDW/U+QN/PEcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138907; c=relaxed/simple;
	bh=OSLk8TdlT4Ny1HhQrj63a9I/QALz/f0E1r/1Ao0DPSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxRF8X+18a3hhIiIgxo+DV10ED3AN4qAMMzXtv/RsjkquJWvTvLS1SNWxmcpSNzo5tOxBmQRBbtlzHVMGksuVaRljsDqITnuHNgPVtiol/OWdHI4KijRZI0a48/FBVSeefemAxAcXzir9vjpDKMJQXmt1CDhn4Bw52qAi4jVTeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=TSIKD1sU; arc=pass smtp.client-ip=136.143.169.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="TSIKD1sU"
ARC-Seal: i=1; a=rsa-sha256; t=1791138881; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kxXQK5ZFAZMj7gABHP5QDyQXIxXDO20bs10/ebGKuqtk2kC+IU3vcsL3zzywrmtDuf0R9YaPJsJfmLj4T53jJBi+BkAzHa6TwU7VrtKlyC5+uJJC/bCMPuX5wiQ9Mk2PTzKu3NU6LEJ1jnFGrbBelMUgTr/4N12GfZ/rH9+j2gY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791138881; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OSLk8TdlT4Ny1HhQrj63a9I/QALz/f0E1r/1Ao0DPSc=; 
	b=kbdvPv1iXUJ7NKYDLUfYQl2Igec+ZRNCrl6CJ54fMyspFR973u1AAo723okPyR9ct7UfUl0MckZBx+1dBYC8IsemOYMV/oHdUMp9bL/23S2Vnga/hhXG1H9RvPeV8aiXa/VTfKlO91R+f4Xsx8woXsgRxoMVEZeJT+e5UytVT8s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791138881;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OSLk8TdlT4Ny1HhQrj63a9I/QALz/f0E1r/1Ao0DPSc=;
	b=TSIKD1sUnetV5RXMGMvwlvIDkXHKV3vG0rL9qboWCsLfKAZiLqRvxI4V0rWEA4hE
	YNXGlqcH6aHep9uvFd2BcCWcHdJhldufePQgGhMBdrPTpTtoB25OrIAYa1/R9q7niRe
	KZHUWEkoUE3RQK1loLL9qtf+no84IdLtieaqaCOg=
Received: by smtp.zoho.eu with SMTPS id 1791138878601498.8940192033232;
	Sun, 4 Oct 2026 20:34:38 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: mask the MAC interrupt while
 resume resets the MAC
In-Reply-To: <17175b15-877c-4cbe-aca8-7c8d44eb667e@lunn.ch>
References: <20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv>
 <47a5be82-c09f-486b-a7e3-35e6edb89ad6@lunn.ch>
 <20261002043623.1304143-1-iav@iav.lv>
 <17175b15-877c-4cbe-aca8-7c8d44eb667e@lunn.ch>
Date: Sun, 04 Oct 2026 21:28:27 +0300
Message-ID: <20261004212827.irq-shut-reply@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Oct 04, 2026 at 04:42:23PM +0200, Andrew Lunn wrote:
> Is probe written this way? Does the needed code already exists, its
> just not used on resume when it should be?

Open is, by ordering: __stmmac_open() calls stmmac_hw_setup(), which
does the reset, and only then stmmac_request_irq(). stmmac_release()
frees the line again. MTU change, the ethtool ring and channel changes
and the reset subtask all go through release and open, so they get the
same ordering.

Resume is the only other caller of stmmac_hw_setup(), and the only one
that resets with the handler installed: nothing in suspend frees or
disables the line. The PM core disables it for the noirq phase only;
dpm_resume_noirq() enables it again before stmmac_resume() runs.

So there is no helper to reuse, only that ordering. The patch gives
resume the same with disable_irq()/enable_irq() instead of
free_irq()/request_irq().

--
Igor Velkov
