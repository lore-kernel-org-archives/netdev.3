Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E244AB8B;
	Wed,  5 Aug 2026 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931130; cv=none; b=cyBe11l+PCq1/jewRDJDO7FwLoXtrMgYjqDlEsSgY6Du3RriZLKtjktXfSBUwEtcEdD1TYrOXKRf8nBxubT8ppCchzl1K3cpL9RbzruMJnnvofSuQ2kE9vMsc1iF3IDfLywsuHKrpYxz5vmQ189qPk2+tYzlPRbQA9E+0QFlnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931130; c=relaxed/simple;
	bh=Fk3hNs76WqX9U6CYxFAidm5YNBT/Ngt7h3g3QuYwGYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHgHRCDobU8NcYhc66iQRdxDK2L7xApU8PHNAcZGRsl0Ha+xhN5bwQe+NmB79mMekIHO5ip7ZweoTtYYPtfN1W4DtR12mOXCOqHOOHC4+TarHVJde6h8VVZ85Q/EvkSwL8hkKk/MqwD1IgtiuKhxFCXbR58lFqjQwxKnDxYi2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RTjsmOm3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RTjsmOm3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JGcR/lbEf8yPFQbCQp9TAZMXMNGCZ8RZiKgPsiK7iEo=; b=RTjsmOm3N2w7fXrt35aOFenlzh
	H6a6VDRlF4Z0f3vIRcQTiPUYig2niSauZxUMhef/CBgfKQ+xo43tk5/ZJx/YpHQ0e/bEvJbdzvP7F
	UJpExrXmq1bCYogr7ekGptrgC6jMlmYX5T2cXeV08viRzfGCku3CTADn1JiMdzpAL3+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wraGR-00GA5V-U0; Wed, 05 Aug 2026 13:58:27 +0200
Date: Wed, 5 Aug 2026 13:58:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krishan Singh <krishanmohan298@gmail.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: Fix memory leak of hwmon_name on hwmon
 registration failure
Message-ID: <4effcfad-50db-43e4-9e6a-7227525cc53f@lunn.ch>
References: <20260805043643.194976-1-krishanmohan298@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805043643.194976-1-krishanmohan298@gmail.com>

On Wed, Aug 05, 2026 at 10:06:43AM +0530, Krishan Singh wrote:
>     hwmon_sanitize_name() allocates sfp->hwmon_name before
>     hwmon_device_register_with_info() is called. If the registration
>     fails, sfp->hwmon_dev is left as an error pointer while
>     sfp->hwmon_name remains allocated.
> 
>     Later, when the SFP module is removed, sfp_hwmon_remove() is still
>     called. However, it frees sfp->hwmon_name only when
>     !IS_ERR_OR_NULL(sfp->hwmon_dev) is true. Since sfp->hwmon_dev is an
>     error pointer in the failure case, the cleanup block is skipped and
>     hwmon_name is leaked.
> 
>     Fix this by cleaning up hwmon_name independently of hwmon_dev.
>     Continue to unregister the hwmon device only when hwmon_dev is valid,
>     but free hwmon_name whenever it is a valid allocated pointer.
> 
>     Fixes: 3f118c449c8e ("net: sfp: use hwmon_sanitize_name()")
>     Suggested-by: Andrew Lunn <andrew@lunn.ch>
>     Signed-off-by: Krishan Singh <krishanmohan298@gmail.com>
> ---

Please read

https://docs.kernel.org/process/submitting-patches.html

There should be a version number in the Subject: line, and under the
--- a version history.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

For netdev, we want the tree to be indicated in the Subject: line. For
this patch i would suggest net-next.

    Andrew

---
pw-bot: cr
