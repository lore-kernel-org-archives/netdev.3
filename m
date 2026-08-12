Received: from out-93wp-a48.jellyfish.systems (out-93wp-a48.jellyfish.systems [104.207.68.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3A46F4AD
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548561; cv=none; b=kfjw/nyvNv03u9nctjDMnzdqeZuzXbPAF4Y6WKxSaco1oXgne/0NuX4gWxwgY76jrUkOxxfFO4BxTYsBMmQaBjFkQk+JBqgXjOAZSXHCOeR8beCKtlAOIrzd8BpWASKsTitRAfeGhSBP8mpiPxXp+Eq0xdSJc3O4846kYeOSybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548561; c=relaxed/simple;
	bh=DGa8xWr/UyQk+yJRWzmlZUl+gJtKbBMzeArK3C2vgzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V13ggMwSxHuv3t6J7dgjl5KQox7tIUMn5D/MF1Be6Rqx4Ftd2LRojvgiGWBvZuLXK2Fi9GYZwvFRd07i8ZvWOYkr2HAUScdIZVr9HsdmAd5I1+4WoMURr88j26E8li9XmvOs0+2aYacQkpl3M+BeuIegWI/e1OOZfveDMaaILo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=104.207.68.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hKspJ4YrVz8sWN;
	Wed, 12 Aug 2026 15:28:40 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: Re: [PATCH v5 5/6] nfc: s3fwrn5: support the S3NRN4V variant
Date: Wed, 12 Aug 2026 17:28:25 +0200
Message-ID: <20260812152825.34300-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e9b0c679-6a50-48ba-8ce8-684bd4b5606b@ixit.cz>
References: <20260811220135.472380-1-jorijnvdgraaf@catcrafts.net> <20260811220135.472380-6-jorijnvdgraaf@catcrafts.net> <e9b0c679-6a50-48ba-8ce8-684bd4b5606b@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

On Wed, Aug 12, 2026 at 01:18:33PM +0200, David Heidelberg wrote:
> > Assisted-by: Claude:claude-opus-4-8
> > Assisted-by: Claude:claude-fable-5
> > Assisted-by: Claude:claude-opus-5
>
> Here's my mental model:
>
>   - It's good to know that you used an LLM (hence Assisted-by).
>   - Someone may want to reproduce some generated code, so knowing which model was
>     used is useful.
>   - When you put THREE ;-) models there, I think it's getting a bit useless, as
>     we don't know which part was generated or adjusted by which model. At this
>     point, it feels somewhat pointless.

coding-assistants.rst doesn't say what to do when multiple models are
used, and generated-content.rst says to choose transparency when in
doubt, so I kept the tags each patch had accumulated.

Currently I use claude-fable-5 as my coding assistant and
claude-opus-5 only reviews. Earlier I used the opus models for this
as well. Each tag was added when a model wrote code on a patch, then
deliberately carried forward across revisions.

> My recommendation would be to keep just one line for the model used for:
>
> a) the majority of the changes
> b) the last model used (at least for notable changes)
> c) the most powerful model doing the generation and/or review
>
> I personally don't mind either approach. There have been discussions about
> dropping Assisted-by completely, but so far it makes sense to me to keep it,
> just in moderation.

Agreed that three lines are ambiguous. Future patches will carry a
single Assisted-by line for the model actually being used as the
coding assistant, or just "Assisted-by: LLM" if the simplification
now in the docs tree lands [1]. The opus tags can be dropped from this series.

Thanks,
Jorijn

[1] https://lore.kernel.org/all/87qzkuahlr.fsf@trenco.lwn.net/
