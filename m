Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59234388A;
	Thu, 16 Jul 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195017; cv=none; b=ZnTF3iXqsA84mFRpq4sFjLThMLhwvsKn40iMLCc1zWU31RSJRMCZWuuM1U3IAfZIaPmszuoZCUqOZalv/+fuUhd3WDbJWt9MH4q2Gl9Hyp38FaVkHRCVIHXc9i+nQIfZQKklh+uBFkIINqEhxMI+LKBarGUr9GvjZbEovn7cmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195017; c=relaxed/simple;
	bh=1ETinczDl/L+BTzESzf55cW0BDqTFAEeV6MzVTxvXg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgZx07+OLPe0auIiNOpgSJK1PkjLgWaEjvZjOSwK5mTVKbTluoEpDH/cHhyC4qQ7Q8rmTKJxvNgn/s79UYvzYCQPa6Izvh7+IBUwGVMoVu4MjVy/ewqefwvSvu7cr1iwHumxK8sS9JCxUNzJNepoSYCOXFdvcebzgMBuLXBcOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbsayLJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbsayLJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F171F000E9;
	Thu, 16 Jul 2026 09:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784195015;
	bh=xa7oUjZrLCf+DN9tGwMEWYLAXaxVqL8cCppbNujr6jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CbsayLJwDDT6hv8wcJMQPcBekENILegBN0OSjHhjVy+v8gn0CfXCgA4JRBf69qqAa
	 xvWbCfmZt1Ka1uyJQahNOfE4x0cDtzxc4rONiD/Lj2wZ5MaE+TklNop5dtSBitimTa
	 7UP8bTatSa4pjQtuLhk7QO6dlV1+fzoCfm4DmN2/vXBSTLPDZ+ZpHo8LGaC+2c7JBL
	 0toHQuCkKkNx1s90JOlE42UTiGxlqbhyLb40TctF66TtX2JGr0/cCO4Aa48h26ubli
	 HeLYtMLiYFNfKegHsb11r8ef2q5s6/GbGMWWfaDAUFqyteX9ovNmsSmW2RKDHXRWrF
	 CsZe5MMa0gCcw==
Date: Thu, 16 Jul 2026 10:43:31 +0100
From: Simon Horman <horms@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shaoxu Liu <shaoxul@foxmail.com>
Subject: Re: [PATCH net-next] rndis_host: add overflow check in
 rndis_rx_fixup()
Message-ID: <20260716094331.GD95246@horms.kernel.org>
References: <2026070900-denim-brook-52d4@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070900-denim-brook-52d4@gregkh>

On Thu, Jul 09, 2026 at 02:24:01PM +0200, Greg Kroah-Hartman wrote:
> From: Griffin Kroah-Hartman <griffin@kroah.com>
> 
> Add an overflow check to ensure that data_offset + data_len + 8 does not
> wrap, which would enable an OOB read of the USB data buffer.
> 
> Assisted-by: gkh_clanker_1000
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Shaoxu Liu <shaoxul@foxmail.com>
> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Simon Horman <horms@kernel.org>

