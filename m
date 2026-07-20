Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E8207A20
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591037; cv=none; b=m+629T+tKo8fwUSoSij33k5/7PTYo3o4QGQIB48V72Bgnf2N8uUtl+owSD98rZUEMNXW6iYdBk3dYEaXpHBTp0dEN/L5nQwvsgGMWj8h9IDXkvJo2ipF/+yUSnq5q4sAxyyKa+AxS80ByvvSzKzMWCaSmcoap1gnk8cooxhq5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591037; c=relaxed/simple;
	bh=PMGYjoAeCwUliVZvz4wdmA/3pM7L82O7KU10c5hv9bc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXAFbp2/9LPLl9M2OcjapD3YZmL+tHlkoaWLFfcptyrtM2t8W6i3Md2/i0CiVKZCUNX9mBR6iybvaG8ExcMeoKrQ5FL4xMHoi13qbun7k2a+l23tig9+RebcoNObtCI+ft4g+XzoezLQVdMMLplYPGrimGbGz0uaQpnKseSktcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjp5RO3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjp5RO3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F911F000E9;
	Mon, 20 Jul 2026 23:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591036;
	bh=9TirBaPU9y1Tf4K5d+psLkyEMr43bUuAXgakeQjBtt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fjp5RO3LoBMMSLP7vEXpXD1C7mtsz2GZfsJHkAhjj2YNEZA2ZJr9ZPz7S+GaTQPh4
	 vaEFPUNYiaqhQdmcn3hYOYjjRjEZaILK0wx9BXSuuS35zyg4B0KjYiHaRgsYqJrONW
	 bRrmtV8F/broeloSAt1zjRdM8E8Lb3AWtlFsPz4PhyTyvu7o3MrMYKn7GPUdYYkXHv
	 xX2tylNn3PgozykD3SATbgxTwpCvBs7DlzhtFN9mKefgZfS1aBLgkVqdWGAmn/UGPV
	 BJIbmhVkVpDiT8Qac0i9wxTml3O5GlXsQoxmiC1ynJcOeFypSxHVf3NV4pA9roofNj
	 AMn6xBgYjPt+Q==
Date: Mon, 20 Jul 2026 16:43:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Siddaraju DH <siddaraju.dh@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Andrew Lunn <andrew@lunn.ch>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, Shubham
 Das <Shubham.Das@intel.com>, Balaji Chintalapalle
 <balaji.chintalapalle@intel.com>, Vijay Srinivasan
 <vijay.srinivasan@intel.com>, Magnus Lindberg
 <magnus.k.lindberg@ericsson.com>, Niklas Damberg
 <niklas.damberg@ericsson.com>, Jonas Wirandi <jonas.wirandi@ericsson.com>,
 Siddaraju DH <siddarajudh@gmail.com>
Subject: Re: [PATCH v2 net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Message-ID: <20260720164355.3072df7d@kernel.org>
In-Reply-To: <20260703100537.1109838-1-siddaraju.dh@intel.com>
References: <20260703100537.1109838-1-siddaraju.dh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jul 2026 15:35:37 +0530 Siddaraju DH wrote:
> Add comment to clarify the physical media 10000baseCR follows.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.

This patch fell out of patchwork, due to vacations and conferences.
Please repost.
