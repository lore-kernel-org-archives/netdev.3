Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984F47DD55;
	Tue, 18 Aug 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070801; cv=none; b=UjeUBMGvOvZpyMgo2H9HAJIKjH4cU/rOHMF5OtESY5nCsC7Q7H+4fMj2+I1Bl8cvkB8rDxKmsnJk0T+WM/tZRq4n9JXWdjaeh75PMZue5R4uvAhE1DhRBBszVh20eM5+KG1FRxQpl8PrPj4jG6imzm5ExjFJw0kQBuGZcdeBOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070801; c=relaxed/simple;
	bh=4+9sH0Yw5YOVo0JvqkWMf4H9GsxjQUCXofEH8QzzP/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Noy2Il9rdNKDkJqWQ6+4TrYQq6DgjUXbY5DrOcdoE+6tJKKP7mzJfepNMVuPpBnAQ30GzuusEZ4UOxVN+pHx6yt4KYnSNSPy9Ru1Mu9kocX50crjiPiOZNxTORwmGBiLUwt3JK2XeMJOqBZSnP6NRbppeJ9bgfzj/28fN93vo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnA5paw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnA5paw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8991E1F000E9;
	Tue, 18 Aug 2026 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787070800;
	bh=P3Lo80pVg3Goq10yaPK5H61W6P+ocgGRO6a7s/Aw6b0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OnA5paw6z+6MRDADJ9B3BHdcm7ShgRjLQ5AfQE5BmYQcg328w1lijOb8OZP4hIhTX
	 5dNe9B6n83y9+jzt1bGsj3cH+BDpuGeSVYR5oiZwmWZAEQOEnmX6A6kwySpEGCgmkJ
	 4BcG2h2eyJkR6nN7VOgML37QTgASTF/oEd0KVSO9r+4gnderFbylmHsm62bB/CDidQ
	 Wo1GFHW6Zv09ZGnf3o7U0CdLACqmpnQYuZwBZ53Hl8fRxpUpWYCY2KbSDwrKASQYbF
	 yLTjU8Ddc086DG7LfYazgpo54o1oewpzEKzs0k6yU7KtcnbpScs8eNGBdILaUVpNSi
	 ixR0e27SlK7/A==
Date: Tue, 18 Aug 2026 09:33:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH net v6 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Message-ID: <20260818093318.68a6e099@kernel.org>
In-Reply-To: <DM5PR02MB33692A7DA56968540A3F950383A62@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
	<20260812-fix-race-condition-and-crash-v6-3-6cf90f4a271a@onsemi.com>
	<20260818090655.1e28cd61@kernel.org>
	<DM5PR02MB33692A7DA56968540A3F950383A62@DM5PR02MB3369.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 16:23:58 +0000 Selvamani Rajagopal wrote:
> > Also the "vendor code may inadvertently enable the queue"
> > is some vague indication of a race? I have no idea what "vendor code"
> > means here, this "library" has one user. If there is a race please fix
> > it. If there's not - please don't add confusing comments.  
> 
> It is not a race. If vendor's code (or even from command line) marks
> the interface "down" followed by "up", queue may be re-enabled.

Due to a link event? That's a run of the mill situation in drivers
and has to be handled by correctly ordering the events.
I think you shut down the IRQ first, so that's good, not sure if there's
anything else to worry about

> This use case was raised by AI review during the previous submission,
> which is a valid question. So I thought I should capture this in the
> comment.

The comment is confusing.
