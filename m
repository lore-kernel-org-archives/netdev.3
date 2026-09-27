Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670A3B1EFC
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528265; cv=none; b=kC89RhUDyprUG6H/nb4ibkSlGM+IQMoG73sNdvIqIWRbqidwkmJZ1meOyqAHCWQQd7M9Z3NbKtFZApWrgake1emz2e8Hf4uh2dArKig2q7DkYSQlE92P/shPdmNNTIx70aqEvql+Qi0gCSx5jHzygN6JAqKhinDImMk3Ofo4uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528265; c=relaxed/simple;
	bh=d8NY9cXAl2CqRZycQZ5C/x89CM3IjHBA+bcmhF1Inis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtamJVPpZr2Z2bxN8GbvUHq1ygCbhpUlGdgHGZG2i5a64ojRUefR7sRHsRERXzYUFktLlqBzdgGdUHt8oK5XAgvUD69LC1JDQgaWNYw6wgkgBoPvo+gXcdiwAGkOKwflYNrqmZhRNf2k1fKvUTWRcKTAUmkNggw1H/WhhXR8+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ezpf/HzS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ezpf/HzS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ePBL/fvjr5SEV5nsceRRbPoCB6A7DxoUoyX2lCN0IJA=; b=Ezpf/HzSx0hyt295HBpk4QQIUx
	BO1ZtcJs0RZlnqMRmwwGe0Z4z/1jO0t10yPv5owld90XXjuqSQT298oDDhjLqILWR87IGksgKro0d
	EWgj12AuqKkitUNBb8M3sWgAimYHDLMrrGVStHYVavzVYN1VpSA0frqVbfxEeo1vquf0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAsC3-007Xl8-6M; Sun, 27 Sep 2026 18:57:39 +0200
Date: Sun, 27 Sep 2026 18:57:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gaoyang Wei <yhyxwgy@gmail.com>
Cc: netdev@vger.kernel.org, pbs05 <xuziyougm@gmail.com>,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC] net: towards a generic PON framework
Message-ID: <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926174601.1675-1-yhyxwgy@gmail.com>

On Sun, Sep 27, 2026 at 01:46:01AM +0800, Gaoyang Wei wrote:
> Hi all,
> 
> Several efforts now support, or are working towards supporting,
> Passive Optical Network (PON) hardware on Linux and OpenWrt.

I have very little knowledge about PON....

> Raw OMCI PDUs are exposed through a dedicated net_device without a
> synthetic Ethernet header and are received and transmitted by
> userspace with AF_PACKET.

I'm not making a comment on putting this signalling code in user space
vs doing it in the kernel.  But having a dedicated net_device seems
wrong to me. However what you mentioned made me think of hostapd and
wpa_supplicant. Can that sort of model be used? It does not require an
additional interface by the side of the wifi interface.

	   Andrew

