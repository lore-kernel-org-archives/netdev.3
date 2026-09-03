Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6234CFCA;
	Thu,  3 Sep 2026 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476963; cv=none; b=FQSjX5b0Y7yDG8sjVEyv0LUC6PPBg+y03wpK9WZ/vK4iZkyN47ndjHtwFyGG5yaJYhhNKlk45JqPr9+teBc9e+F4Oix3CH3SmnJt7Daa42GyD5dzdUEYTrtKEhsg2gkJNEsCIxetaSjTx/1AeKF9g/V9S2M7skSEMwgb122RaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476963; c=relaxed/simple;
	bh=6rcZAMWgIi+KZKSXFJ/0fk/gdtoBfa8p1RUDAQQsR40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9fs9bNRqCDlMHn5/DA5CO2TA5WjJIODOMZJNNqOCC5Lwj/MVd3ensMZb14Av5bTMMuKH2XmX9HUQ1sf4n5A/Q6V/gdXW4zMSJ5Zbfrj+EDCfnWa9VP2kgZX5dhm+0YgdIlym3H+jZQMMZqf3moiX98Slarf3naWownA71teFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMrFl5y1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMrFl5y1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EFC1F000E9;
	Thu,  3 Sep 2026 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476962;
	bh=7HebtJAgpTwpQUKv9N4H6F1loY4uPBv+ObzdRVGZik8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SMrFl5y1M2g1Fkz5yeymSelT+0xGT7v7eRGluKTynOLqMYIydyb5/dLpjI1rv8Z6F
	 gLOD9EVck7MPrRzD5oZ3H7fZi6vwf6NPtgWQAa+ZefgQLPCRyn9AO9EGvRUt+Xd5ju
	 fD9QHACdud0V6szt2J92dpEddAvh7/eYUgoDHubMJEMx06UDMTn3IjLGt3I2AGeNHP
	 PXICIl4VCLmFyydpT2dNWGjt/XSORbVHiphwASs2DUF3HpzzzidkDUzFaZdOeShZMe
	 TmKBeKQxAer4fnv3Qc6NGCYc8KZuq/YjDnwQEiTafjqjgaZVVgemTtYb1CjZ2p7kay
	 pTOs4tqBJ5lsA==
Date: Thu, 3 Sep 2026 16:09:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, j.bhargav.u@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tony@atomide.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
 simona.toaca@nxp.com
Subject: Re: [v3] dt-bindings: net: ti,davinci-emac: Convert to DT schema
Message-ID: <20260903160921.547dabf4@kernel.org>
In-Reply-To: <33fe3846-eb8d-4b0b-9355-46388c1db2d3@kernel.org>
References: <20260901-ti-davinci-emac-v3-1-db41e32f3f6d@gmail.com>
	<178844863252.3394541.10006643092711574384@kernel.org>
	<33fe3846-eb8d-4b0b-9355-46388c1db2d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 17:22:54 +0200 Krzysztof Kozlowski wrote:
> On 03/09/2026 17:17, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider:
> 
> Jakub and other netdev folks,
> 
> I got this week a lot of new netdev Sashiko emails on my mailbox. All of
> them escape filtering, because they do not use PATCH keyword. Can you
> please fix that? PATCH is essential... For now I will just add a filter
> to drop sashiko to dev null instead based on recipient, because I am not
> going to add filters classifying email as patch just because "From" is
> matching something.

Ugh, not the first time we have this bug either, sorry.
Should be fixed now.
