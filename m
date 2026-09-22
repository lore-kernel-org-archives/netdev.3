Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418E26982C;
	Tue, 22 Sep 2026 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036034; cv=none; b=jccwj6LuhQ5/qgJ7U/v9OG0lToeqFEBuaYCa5BDyMKIdp1R2WC1YyG3eVu57ATFT+27AiczN8p4/HCcW9ehR3hnzxngPZG3zS/K7XiPiCO9cV0cp3troDo8qYA+a3XXGK8YQ9CiMotQ22vNEFIpXp3c76Hq9opi/uznGX4mFGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036034; c=relaxed/simple;
	bh=qZTuDwtjf3PGBU5aADgBkN5KEgvxkDR5xVVFX4x08f4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuBZROQq0EdeUsVa9zPIAaCLTcBcQBQx2ovXQYj/ZKhjASv4ksFOHNmmDiUX72GLxWbtTj8aAtzMn0IhDZ+gTOTx95J+52AGw7ujMg/mhH766aSgtcVjp+Z5xjzhLGtkpSciS1rnB29nVZPIWLaREq6H5Hg37CPwJBxKxY2+x1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuQWSzrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuQWSzrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C287F1F000FF;
	Tue, 22 Sep 2026 00:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790036033;
	bh=qZTuDwtjf3PGBU5aADgBkN5KEgvxkDR5xVVFX4x08f4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IuQWSzrB7ruQRjn8Ijbgqlle3UCsArsqwqznWuNPoY0gC/vIrcg14PE3Wo121y6c5
	 zPQw+sP0kPLCGDJy+dajDNeeHOX0OdyDSrRCNM7P2SABAjglW7dBl1HSnSqzwTrjzi
	 vHeaPm3zVeGSsEBx47EP/bd13YiSfKh6W9LRu22yVgiX85DU8oMdfq4tXiBvuTc7XP
	 gSTFTyRamSidvx0aHCZJu8mVrUeDOqKCEkxZEhTbOPlcAwIg0PTAP9yoMRh+t7Zync
	 V8E12fVtR8ptmdt5jhCqGTHLZ4E8RxveiPV3z6Dw4Kx/OqTKr2mnmSNjzU54mU/YQF
	 fNxtJKTSGN4mg==
Date: Mon, 21 Sep 2026 17:13:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [net-next, v3 01/11] bnge: update HSI
Message-ID: <20260921171352.70326b27@kernel.org>
In-Reply-To: <20260917064548.773334-2-vikas.gupta@broadcom.com>
References: <20260917064548.773334-1-vikas.gupta@broadcom.com>
	<20260917064548.773334-2-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 12:15:38 +0530 Vikas Gupta wrote:
> Update HSI to support future patches implementing multi-RSS and
> NTUPLE-related features.

I'll apply this patch, no point wasting ML BW on reposting it
