Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3E3DB319;
	Thu, 18 Jun 2026 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775159; cv=none; b=bRCe9ui1MtRJHWOWXAnFOWWkn5vvLceQPKJ+cj4b5G8HWIjeR+xhBc7xLCOoB7wMbZ5vFr0sFltG7PLZf/D1PR4jlAB79LZom+pTyA4yaM/VEF6iza/ubOlh7bKD2tUGdGrRmfnIRnlUAsGWXFzpU/tLV3Str3eP/8QAe8tCnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775159; c=relaxed/simple;
	bh=uSQDO0PCAJO4gKVbp7oxH3aAC+XDz+Rc8Xd3YIhsr90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO0S+Qfq1GsgSjO+5FIklLNoCwuOs5Utb4wHZebZE3tptn+d/u5qkSJvUUlFOEbT29Bcvxz0RvwpyciMbT+Kr7D6G4mhXfF20nLyytQmhPSY/lTKh/wZ5BqkN5M6Ffn+fKuJm2uXkj9SNGaurs0zEhtfSU4XZY/J6cj/bEyeoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bEdtXF0/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bEdtXF0/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KFgNOFHRT7gMIXe4BXoejHARqTbv7CawbNuZytFwkcg=; b=bEdtXF0/WJsoimzLg61UOJcGk/
	6ADpiiCywWyzucbuS591wn72+B6HsxValvjoPyrq79V43aQWgasmuqoGwesllX7KMSSnYeeJhOrAA
	XveL/jFDIvqc9OisWQ6A+43RltQpQBCDMbN15pNFkUJxKzodsipyi8UkRP3dgbt53vpSdg+qbISvD
	ttzjBNCKl9Ij8xKnfGQyAVlgqQ3v9wv2d+V4AgcEZu4d/AQE5+5qxu4gQDXign62Anm8sJ3j8VpNs
	TDd6S7e8r1azIZhnBgfSKJyC20ZgTmhAfAsm05j2P/PvtiQhYda9yDKF8GPIYURWEz+db1Cj/QQhW
	/O2W0u4g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wa96n-00FIJI-1v;
	Thu, 18 Jun 2026 09:32:25 +0000
Date: Thu, 18 Jun 2026 02:32:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sesidhar Baddela <sebaddel@cisco.com>
Subject: Re: [PATCH net-next v9 01/10] enic: verify firmware supports V2
 SR-IOV at probe time
Message-ID: <ajO56uu7WIK_eb6i@gmail.com>
References: <20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com>
 <20260617-enic-sriov-v2-admin-channel-v2-v9-1-37f5f5af4c93@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-enic-sriov-v2-admin-channel-v2-v9-1-37f5f5af4c93@cisco.com>
X-Debian-User: leitao

On Wed, Jun 17, 2026 at 06:53:24PM -0700, Satish Kharat wrote:
> During PF probe, query the firmware get-supported-feature interface
> to verify that the running firmware supports V2 SR-IOV. Firmware
> version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
> CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
> feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
> admin knows a firmware upgrade is needed.
> 
> VIC_FEATURE_SRIOV is assigned the explicit value 4 to match the
> firmware ABI.  Slot 3 (firmware's VIC_FEATURE_PTP) is reserved with
> a comment rather than a placeholder enum entry, since PTP is not
> used by the upstream driver.
> 
> Suggested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

FWIW: net-next is closed now.
https://lore.kernel.org/all/20260615085310.014e4e31@kernel.org/
