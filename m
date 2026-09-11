Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4149E12F;
	Fri, 11 Sep 2026 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127551; cv=none; b=okQgUn29qCX9AKgfoEN9fkCUGhXI5B+pBVHxnwQQh2fEY4dEleDg1UgYBUpXDNXqoyAYEAScWwBDqoAMA3P+NqYtjR5WSe03O7dRalt9kerbZeEI0ZJSgWfI32ucj16OjUfmJJZICz9Tt0vNfAfP85rGyfbU348H1yrjUTavQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127551; c=relaxed/simple;
	bh=xr1iQ+0ANjD4AhlQ8mUQMXP92Uraxm4SQUClYbCEmdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siXATfEKa6D1FG8VfUhgDGXTEwMoZ47+1V2GjeaGmCIdMAqzInmfgWxuRbrNy2K/JDoGG5XHw3pVNaNn/I+QNuIGwFGgvuei74iEk+kaltwql5GH8M6damz2nrvS6NcwSnCXPxa5T8otc6FNBN2kZEi9JwomUEM4OcqieDuobjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IS1534z5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IS1534z5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VnHi4B3D3EDHBd1o2lsdu30TZjWEe4IWwvich8nSuoI=; b=IS1534z5HHH3YbqZaAaY6//s+V
	FaKchLDA/hWx9lgYhMTLy2UmrylUXiPH7z7R9U+CXM4o0s3jZy0fjv2c2fZXMFaeRJFMabnjhV1D6
	AGvK8bwpW4kXcQioF91Zn2lxeF4Xe44H/GhsSJq0RNnW3nkd+KGEOsyJ+Ox4I8wrSEVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4znk-004gLh-Hw; Fri, 11 Sep 2026 13:52:16 +0200
Date: Fri, 11 Sep 2026 13:52:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com, wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: Re: [PATCH v16 2/2] dt-bindings: net: Document Motorcomm YT8824 PHY
 package
Message-ID: <4246e368-42f5-4037-8882-6ad87a85724e@lunn.ch>
References: <20260910074624.2426899-1-kyle.switch@motor-comm.com>
 <20260910074624.2426899-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910074624.2426899-3-kyle.switch@motor-comm.com>

> +  motorcomm,interface-mode:
> +    description: |
> +      PHY package interface mode.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - internal
> +      - usxgmii
> +    default: internal

You are not the first vendor to use usxgmii, a vendor property is not
required.. e.g. fsl-ls1028a-qds-13bb.dtso.

	 Andrew
