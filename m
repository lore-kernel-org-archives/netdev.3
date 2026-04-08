Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FCCA45;
	Wed,  8 Apr 2026 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610275; cv=none; b=kbWTECy0rorJkR6mWlINzR8zBgRDlry32JFOyuBj5E5LXu0YsKgX0qJOZGpCYCgvB/8kMj2h4Pduzglx7ANIuPyhgqL5qrNLvIkOS33m0pb8Af8Y0I+zXx7c16mz22G8sC2jNYxwEM7kh5WxrF3qRl+qX/Ou142jJ/dDNYDQqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610275; c=relaxed/simple;
	bh=Eg8v+sP3X1yp5UZjJGBpsFtcvbicVDyA9+mXPo5mCrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlg+HCXSy5lSpPXKeasNLQWOZZ46GeIb9qgWdJgYXM1C6QM2l06TEmU84hRZw7RbktAqq+axNZwNJeXgM22vnGeJDHaPGETInoAiUBaSt3maGmm2Gw1OEXMvWXuD5WwEBQkm7eBE830mvfAUY0FrsWOaBMd1TWa8wtDH4trOoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrTi5O32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrTi5O32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87EEC116C6;
	Wed,  8 Apr 2026 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610274;
	bh=Eg8v+sP3X1yp5UZjJGBpsFtcvbicVDyA9+mXPo5mCrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YrTi5O32IRI3mQtgu3DFbhjTBpgTKGtW7aNY2EhBkqZdOdi1zt86GMBEOLA/pCAeT
	 zYA5VuUmHLmKImYoCimMfEa8/H8AotQHfc4zukAYq02UnJuhxLHe/iiKn2VRXnx+LG
	 DvJ+n4sANQHR4hy3eouu67e0SZ5dLKg1jaxTi1O2K7qI+OCwbA5QrhZbcXubaYQF4F
	 rBPVDNH91pcj0s1X1cNqXGFvbBtTTBxA+glsfjqQP42krbNoBeptTDcZAP+ExNFSbY
	 Zy3By40qMwOZWNXQHMZZsBLcjBGSmuuhzDKTHFx4Auu1lHkJtpyFZhZQSbaZT6uQwj
	 gVY+WXFYFrrvg==
Date: Tue, 7 Apr 2026 18:04:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 kiran.kella@broadcom.com, sachin.suman@broadcom.com
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
Message-ID: <20260407180432.102073cf@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
	<20260406222305.4111170-2-akhilesh.samineni@broadcom.com>
	<willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Apr 2026 17:37:41 -0400 Willem de Bruijn wrote:
> > +	if (info->attrs[PSP_A_DEV_CRYPT_OFFSET])
> > +		new_config.crypt_offset =
> > +			nla_get_u8(info->attrs[PSP_A_DEV_CRYPT_OFFSET]);  
> 
> PSP defines a 6-bit field in 4 octet units. Does this need bounds checking?

More fundamentally, were we to support this -- is it a device property
or an assoc property? 
