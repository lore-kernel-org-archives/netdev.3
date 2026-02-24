Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14E36A014;
	Tue, 24 Feb 2026 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924624; cv=none; b=jclR+oWoHC51Kn7OI7PDj4yTqphppPOl8g9oEVDnt7dcyuZOnXKWyfo9GjKvKx1M9gwIACxzaki8nJJAHqG5+k1/87ND+WIFDzcvRjgb9w7H/tKdrQRaTjWcHjZgQF3M4OOufBQh+lMl04CKHsxmM/DwFDUoMbnCWyJ09BawicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924624; c=relaxed/simple;
	bh=bCAUlUrU7b/lK/XX51Q7Asfc1v6AxvxtJzC0VYV7Tjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCz0SbjVaL+vhUXY5yIUUVgc9I/oYquzXppzLpqFPERZFKu7RVgn3XRnIaJnjAnEuPGYXsJ2tj3fQHPrqHept2EWY1CnqVpUlWcpUoTLv1ewqUrAwnMUQ8F5r10O5SV73s7lyG1r0UO9rcD9B/+D1qY1CKW1qGOKOrAikXjF2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHsAx0dW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHsAx0dW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11445C116D0;
	Tue, 24 Feb 2026 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771924624;
	bh=bCAUlUrU7b/lK/XX51Q7Asfc1v6AxvxtJzC0VYV7Tjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHsAx0dWLSHJkafHRge8RZ0V4yirJ3gAMf/N81kkhweTDSqGb9srUWc+JZfWjBBLb
	 Alf5UujSbocRSNV4YjKev7eOzG3JkZSRqUONgq7lXZJJ196MhGWRWKS16iJMPegH0r
	 6Qlx3YRQ/dt1kMOQbxKgF7zFAS2nQvcQVnzdVPYclDiURMJkOuHILziTHmRmwxXi/I
	 56m3S42lUaoRE50Laieu9IDc8XFFYUyF++TU5DRlhFhwaA/+qwqZ53lNmDKaG+hUCe
	 UAc19eQqQsyNdMwG3wxEPHqkDwZMgmnsOVFHJTy8I8ovWxkKaHEimsABN8FytAeFdQ
	 k7SlI+NFO0VeQ==
Date: Tue, 24 Feb 2026 09:17:00 +0000
From: Simon Horman <horms@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] nfc: pn533: properly drop the usb interface
 reference on disconnect
Message-ID: <aZ1sjK3LwiLDt4F2@horms.kernel.org>
References: <2026022329-flashing-ought-7573@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022329-flashing-ought-7573@gregkh>

On Mon, Feb 23, 2026 at 12:28:30PM +0100, Greg Kroah-Hartman wrote:
> When the device is disconnected from the driver, there is a "dangling"
> reference count on the usb interface that was grabbed in the probe
> callback.  Fix this up by properly dropping the reference after we are
> done with it.
> 
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg,

As a fix, a Fixes tag seems appropriate.
This seems to have been there since the beginning, so perhaps this one:

Fixes: c46ee38620a2 ("NFC: pn533: add NXP pn533 nfc device driver")

That notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
