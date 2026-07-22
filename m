Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4943CE49;
	Wed, 22 Jul 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740492; cv=none; b=FeKJbqRdBv/vecLbADOS8D97bIArUHfU/TV0FyTyYqtVNFc9y3TU1vmC1i3Qo6G8W+D7rc4ueGfRvp+q43KUBDiH4ufu5LO1L4cGBGq5xKr/pgAp80edCY6RxeznerrKjf+AYTEI1tRH4A/GlN4F6EARjovmsTTXVY3/j302dnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740492; c=relaxed/simple;
	bh=x9eOMkF29r6bTJZUTBpg0yL+NQKKJ0FnhkA0mrSlgNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WABMxyDq5U2d9Pr1hgi236kCB7oAyvHCKUTkngJNpFBl1Ls+SBq/1KEjRKZwD6tOW6ozLSjXFLe5TNLjeoMnKgfbj+Fd4x0/biF0tn+WsRenr4ymj07lMpZxkMpYwOcXIJ+e6rLMzLEGmM1A8t7wxXThJoUD8jnfBY4XkabfHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr9figoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr9figoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AA61F000E9;
	Wed, 22 Jul 2026 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740490;
	bh=JwD8ujU4IUVS9rMmKchL74t4es9VLDaWpCnugp9LUZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lr9figoOym8dshe/1H+GsL0l90tTWjLn+h2orHVHAoqkDgKsCAFBmvfhoGD1aZJDH
	 hQ9rK9B06ayKVsCkv825eKR9ZEcOAeMfqNGe/JK9wMmIRX9KSwSk2zVSFLApWmisdX
	 nk4M1EIE81PY0sQs7ByfDpySZj7xL+j3P9+yKCW5pqxSCvosiOwlEdypvRq9cRuVWQ
	 N/vNFxWWDFG6Zqax/gE72BjeNhDjY1gvB/nOu1ZKL/Oyecre2om1yGN7t7Er20hGJ8
	 nytc2UjwIs3AAnuGA/i3Jp5GcXhLo3kQAnJEHS4pg1dptZFfOAIa+Pmx9tHULNKzNR
	 I3CQVBkkjTiRw==
Date: Wed, 22 Jul 2026 10:14:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <20260722101449.43537aef@kernel.org>
In-Reply-To: <alaKsBXSK9tP__O8@makrotopia.org>
References: <cover.1783988826.git.daniel@makrotopia.org>
	<5d1614d1cd6b99bf0f0635c6370bbed10736a7fa.1783988826.git.daniel@makrotopia.org>
	<alaKsBXSK9tP__O8@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 20:14:56 +0100 Daniel Golle wrote:
> On Tue, Jul 14, 2026 at 01:51:02AM +0100, Daniel Golle wrote:
> [...]
> > +	if (!of_property_read_string_index(ds->dev->of_node, "compatible", 0,
> > +					   &compatible)) {
> > +		ret = devlink_info_version_fixed_put(req,
> > +						     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
> > +						     compatible);  
> 
> Review of the fwupd counterpart of this series[1] made me reconsider
> what the driver reports as the "asic.id" fixed version. The devicetree
> compatible string used here ("maxlinear,mxl86252") turned out to be an
> unfortunate choice as the comma is awkward for userspace consumers, so
> for v3 I plan to follow the mv88e6xxx example and report a chip name
> from a per-model info table instead:
> 
>   fixed:
>     asic.id MaxLinear MxL86252
> 
> Before sending v3 I would like to clarify the preferred format of the
> value. Existing implementations differ: mv88e6xxx reports for example
> "Marvell 88E6085", including the vendor name and a space, sja1105
> reports "SJA1105E", hellcreek reports "hellcreek", and bnxt and ionic
> report bare chip identifiers.
> 
> Documentation/networking/devlink/devlink-info.rst only describes
> "asic.id" as "ASIC design identifier" without any format constraints.
> 
> Userspace builds firmware matching identifiers from these values, in
> the case of fwupd for example
> 
>   MDIO_BUS\COMPONENT_fw&ASIC.ID_MaxLinear MxL86252
> 
> and while a space works there, such identifiers commonly avoid spaces
> in favour of underscores, hyphens or dots.
> 
> Is there a preference for new drivers? Should the vendor name be part
> of "asic.id" as done by mv88e6xxx, or would a single token such as
> "MxL86252" be more appropriate?
> 
> [1] https://github.com/fwupd/fwupd/pull/10667

The embedded drivers are probably doing it wrong, I wasn't paying
enough attention. devlink versions are supposed to be broken up into
components, the vendor name does not belong in asic id.

IIUC asic.id was supposed to be the numerical version of the design
(excluding revision, which is asic.rev). Something that's usually read
from a static CSR.
