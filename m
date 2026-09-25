Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC13E51E8
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357047; cv=none; b=j3dCl0JIV1VDQTR7XD5MxqA+Q7IODv9vOBKnHdvwYdH/nnZl9jgYz9fL3jX4CZ/OPhXlvBi9O/zvF4m59Ci33R7Jlg31mzKZQUGa+UiAh/97zUJD2e4/otDNAn+UKzXYGaORKXHCK6HmF6aCJsMRY5TYR7MGR2OSLAQpefCn1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357047; c=relaxed/simple;
	bh=kvyKDngyhD+Uscl4HQdh72rLX//n3H/CxB7tRs43DU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsflGGRFtssDGxVGEhyqXvpPf5HnEVVdVe6u69H7wPsrGrE7+XFf8VDu7WyaVTHf88qCkwesdx5nvgXkSN7/lfzIBg0Sj1apPeCyK8tSzvG0KpbPLCDJCbbz4qISd1F6bY/yQXwxDBRvbfuiJa+JRJncYZyr/3tg5EFV4Qm09zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP4fKYYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP4fKYYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7ED1F000FF;
	Fri, 25 Sep 2026 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790357046;
	bh=faooqxYJPony5EWU+tgd2K06Gdx5SmkfQ0Z/baqGBaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OP4fKYYYvntsOjTmDTHk0+6+3gfdpNbExzjWXiCYT427MOPgI+yRvKLutwkquuzSf
	 ftpRKzLiz8Ctv313h7LqEiYhtZQ93aFkd+OY/K3T7mCSw0lvblIZ09xmQko3WUcoTU
	 5wqFK91x0ho4zQBKq0x+ky57YL01JXS9Av/cbCNNtqlflgDrzopkEeqQ8q7kkGlyrZ
	 N7RojuA5UlzwFOb0qlCw/ZyNCJMf14D9LJEthfPq8jk2sJYGOLJ1VJTK1cebcnotPK
	 5wJ7XoAKzp6hxRKPuWgoOPJUqPFLjSmT95gJaM3mkO6FWbRmT4iz1Qk9L2gxfi8RJj
	 U0FWPsvf7Gjxw==
Date: Fri, 25 Sep 2026 18:24:03 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net  v2 4/4] ixgbe: Implement PCI reset handler
Message-ID: <20260925172403.GV13925@horms.kernel.org>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
 <20260922113558.2288111-5-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113558.2288111-5-sergey.temerkhanov@intel.com>

On Tue, Sep 22, 2026 at 11:35:58AM +0000, Sergey Temerkhanov wrote:
> Implement PCI device reset handler to allow the network device to
> get re-initialized and function after a PCI-level reset.
> 
> This is necessary for the adapter to avoid TX queue timeouts
> occurring after the PCI reset is performed via sysfs during
> its operation.
> 
> The reset codepath may trigger a number of dependencies in the
> reset of the driver, so that it is necessary to check if
> the netdev is present and running there.
> 
> Fixes: 711d57796f5c ("PCI: expose function reset capability in sysfs")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

