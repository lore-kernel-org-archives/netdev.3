Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A866361974;
	Wed, 23 Sep 2026 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147562; cv=none; b=Xag/T4A4NYHRqhrh23qatpYFgVC5y6Jkcb6c5QNge6v5JXfqGJMnI9QYjapVKz5B/m0rEkqHg40wtb46HD3vJ0D9vxR1upAmBcUK01CWPUyzxRtpTcY8udwG2anR0twha/CEKEKfOBUoGNMoNmOBzzvBqJpNA2BBOXTUWHEnNB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147562; c=relaxed/simple;
	bh=aUQvWRNswOY0r9qFRS7l4qYatFpMGY/5OnhyCMM+q2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE0B+fRhGbC8TGSHhq6pSsXYjydqZpGtWFuolfFo8/rKhIMLi9g3Oz/n5f0VRn0Cunkbs666uq6RLEfkZCdm5SyIxXlRNzgQAXB//LVLesj68cu987VD9gEv7GYz114BS9WdZd78BdDl55Mepm9UksVF6Y5x/i5AbFuJDxEa5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLNONArh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLNONArh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111B71F000FF;
	Wed, 23 Sep 2026 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790147561;
	bh=X+oV1KMq3qgE16ONyrZlpyy/bGTkSWXzskYuTikO3wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iLNONArhrqjPaae5avg9VcLOTFCqgC6dMa0lLWXbwdn6h6o7veGdqI2w0leBu6+NA
	 4+RAOiPlc4cAWNYrFNwlOMwF9fhRBLXLarjmaPRaVhgbcxgWLO4T8WuHQ5aClKdH9x
	 xT0W0pwf7ZdjZsJIVuDkWwli4ag235JjZKJz+jbyPPDZAMMk+tx3pXoGIZbt8pK6tA
	 uYIEx16D3b+icN6Zs1IH7bfXaL0K0Sn1X1rMxOPiATJ/IhndGcXsADRubfv6pmKsUX
	 IWGy7Gz0ogYjc1kBQxjs322CGYCKEjy2gZZ+Hutk1q8mw8SgE+A4cR1aWxIkee3fVx
	 SE2uLx7qjebDQ==
Date: Wed, 23 Sep 2026 08:12:36 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: restore double VLAN port parameters on
 devlink reload
Message-ID: <20260923071236.GI13925@horms.kernel.org>
References: <20260921100000.1152575-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921100000.1152575-1-poros@redhat.com>

On Mon, Sep 21, 2026 at 12:00:00PM +0200, Petr Oros wrote:
> Set Port Parameters with the double VLAN flag is issued from probe and
> from ice_rebuild(), but not from the devlink reinit path. ice_init_hw()
> resets the PF there and the port ends up in single VLAN mode while the
> driver keeps operating in DVM, so outer VLAN tags requested through the
> Tx descriptor by the PF and by VFs are silently not inserted until the
> next probe.
> 
> Move the call into ice_init_dev(), which is shared by probe and reinit.
> 
> Fixes: 31c8db2c4fa7 ("ice: implement devlink reinit action")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

