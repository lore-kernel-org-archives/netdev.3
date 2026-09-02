Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFF45516A;
	Wed,  2 Sep 2026 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390246; cv=none; b=g+EdbDtukhlQRsZT0GA14Pb8RR6Cj5DvNvrVM2ozXbTAAYG/lbinKWuNFWUQpVXImT7aTWI/70Dpw/afPi9+PPh/PlUA1HOm7lhMDTfrcIL04JyeCyvIll71hu1vaJoilqKKiS02jD5penDVwPLAg/2z68wzWSnbY6F1jPguY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390246; c=relaxed/simple;
	bh=fLOCD+5R4PKyY+l9qrZ6uEA3P/ttz+llSOrF6ot8n/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujUcPr2YQU0zUdB8Xq1Ogzp3gQQVHcn7jm/NUfcdejSkiQlqChBQPbiJ3Z/oivy5x9ARrzQrT0ozLc4lBlhTJG9STkmNLl62jJbF7ueodv4UnkJuii38hhRSmWqqYoZKMvyRzgUMfZBMHkoQ6VRDNGDPbs9/R1r0gUw08WWFNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwaeCOLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwaeCOLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA821F000E9;
	Wed,  2 Sep 2026 23:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788390242;
	bh=O9USwUyIVj8l57p+FV9d0vog9PUYuCq9WSxhHsZLusI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XwaeCOLGaUUMU6tDOTz7QX+9PVeE/Jl8Gp3JjGFlcF9PBq3/m54t/V0BkSBYqXZjq
	 AeHdUQqTkOFkNWN0eWLlNf8o1YeE36PpHoOKgpZ4AejK9E2qgECbkfMWqmD1ScL90w
	 1iKOH3iWAdL+TzhuesZDI7DvA43kgiGektEUsNZAICkt71Mom2UMf6g2cn99hQGvJ/
	 Gm+OcgqvMJOe2QThafB4aPWjU9SKpydSHK8dqDKW7MAY/mqNI2ex/5Q8nNyVNVg3Ty
	 mZ2eZ3ol+1EJfLPUQ4aG/jQZTU/3Tz+AmF7AUYMGXHSq80hNIi6+9+ib9ijr4NGqvP
	 LJiEOdG6pOIRg==
Date: Wed, 2 Sep 2026 16:04:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Sviridkin <f@lex.la>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Eric Woudstra <ericwouds@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: air_en8811h: refuse a firmware blob that
 is not a multiple of 4
Message-ID: <20260902160401.48b1fe92@kernel.org>
In-Reply-To: <20260902080525.2211446-1-f@lex.la>
References: <20260902080525.2211446-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 08:05:25 +0000 Aleksei Sviridkin wrote:
> The download loop streams the blob into the MCU as 32-bit words and
> reads the last word past the end of a blob whose size is not a multiple
> of four. The shipped blobs happen to be aligned, so the overread never
> showed; a truncated or foreign file would carry up to three bytes of
> whatever follows it into the MCU. Reject it before the first write
> instead.

When you repost please explain how this was discovered, and tested.
