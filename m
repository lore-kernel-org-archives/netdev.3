Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564212B93;
	Fri, 27 Mar 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633015; cv=none; b=RbtqLCVFVJM4uJ0Ngbij39IeXfX1qGuMd4FHdqF8oPtdoXkrFDPKpbrEV1IEzG8hp4gDpP25wB8D0hv3w0uJ/twQqt3MxmqGtaXhwsiMM3WPhZSYhPaZHfOi8XMupoNbtGbX24ERvrKruc3jn+NYdIH+2NRnQaBnBEW3GUFMF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633015; c=relaxed/simple;
	bh=ThE33YvTtR5XRmErtYNSoLQ86Ni0iXf8og4Ha07NAu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGuuxj0l/L4y9WierJgmLQudVND+hc8RMdSFCGkt45MJsfh/BVEWDEUnLGOwI4agxR9728jzoEqbU/XLWvNgTQtYL62Ie47lpwsnoXpjqbYMRqYT+x/5w51Wa4kR8Mt2sy8iB2DVp0Vo6R8QvcRrFjf1lHza4iRkoaNC12tRw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1Tv35kD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1Tv35kD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE443C19423;
	Fri, 27 Mar 2026 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774633014;
	bh=ThE33YvTtR5XRmErtYNSoLQ86Ni0iXf8og4Ha07NAu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1Tv35kDTag8Fax10uEk56f8KFHfzMAgsXj/8B04YRO/+bR+rlipQ5Grhz5PKz6Fp
	 HBMkuZfhfDhjbGS0my7LngKHeJ36pa26rB9NAPyVbx84gkxHeqK0ii8fhh5kFlEab8
	 ZV2fRZX0A/XH4zbUKKJa6Xw8sqvIE1Ux4ZnzpBIIlTvopl/d1o0gXLT0h69Z2WSXkJ
	 fou6KcIgT1pol8R8ZiF9LvW7LKX4vTLB+gdOl/1FPeWxfG+E19JptvX0aGYa288D5o
	 o2Ys6kNLXDN7MH7qT5Ipy3LyE4/7F82dylRehu0h3ItltSO/18BL0eoVAV4/lR1eWW
	 zR3rGlXuqftww==
Date: Fri, 27 Mar 2026 10:36:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Dege <michael.dege@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 00/13] net: renesas: rswitch: R-Car S4 add
 VLAN aware switching
Message-ID: <20260327103650.7d483c03@kernel.org>
In-Reply-To: <20260327-rswitch_add_vlans-v2-0-d7f4358ca57a@renesas.com>
References: <20260327-rswitch_add_vlans-v2-0-d7f4358ca57a@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 09:27:30 +0100 Michael Dege wrote:
> Hello!
> 
> The current R-Car S4 rswitch driver only supports basic HW offloading
> for L2 switching/bridgeing. This patchset extends the driver with
> support for VLAN aware switching.
> 
> 1. For every port mode change from configuration to operation and
>    vice-versa you need to change to disabled mode first. The
>    functions rswitch_<port>_change_mode now take care of this. 
> 
> 2. In upcomming changes for adding vlan support struct net_device
>    will not be available in all cases, therefore use struct device
>    instead.
> 
> 3. Fix typo in register define macro and remove duplicate macro.
> 
> 4. Add register definitions needed fo vlan support.
> 
> 5. Add exception path for packets with unknown destitination MAC
>    addresses.
> 
> 6. Make the helper functions rswitch_reg_wait(),
>    rswitch_etha_change_mode() and rswitch_etha_change_mode()
>    available to the whole driver.
> 
> 7. Add basic start-up time initialization needed to support VLANs.
> 
> 8. Update ETHA and GWCA port HW initializations.
> 
> 9. Clean up is_rdev() rswitch_device checking.
> 
> 10. Provide struct rswitch_private to notifiers.
> 
> 11. Add handler for FDB notifications to configure bridge MAC address
>     to GWCA registers and update static MAC table entry.
> 
> 12. Add vlan support to L2 HW bridge.

coccicheck reports:

drivers/net/ethernet/renesas/rswitch_main.c:1590:11-66: duplicated argument to & or |
@@ -182,0 +184,3 @@
drivers/net/ethernet/renesas/rswitch_l2.c:350:5-8: WARNING: Unsigned expression compared with zero: err < 0
drivers/net/ethernet/renesas/rswitch_l2.c:380:5-8: WARNING: Unsigned expression compared with zero: err < 0
drivers/net/ethernet/renesas/rswitch_l2.c:465:5-8: WARNING: Unsigned expression compared with zero: err < 0

reminder: please do not post a new version of patches on netdev earlier
than a full 24h after previous posting.
