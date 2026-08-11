Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC16380FD1;
	Tue, 11 Aug 2026 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455215; cv=none; b=VdTqGTadkBKdTBjAQmT/WSOViH3XZFSXu0niOi/5BCF+UTN+BGC92w8wRNS0HrbqUf1uGsdpe2N3q+xjawo38VwVEhw0eJHEk7nyQwsnhJQkQNQlPyaDqeNhXsEsuvyrg8MmTFH6ugSmz8pFbnbijPyRqG4dlKA4HynPD9FCBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455215; c=relaxed/simple;
	bh=URj9vqxr4q3xjVKIkem3E5lxea1cqhhIqdpiq+gQcVM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=XOFjqw2oYQGYHXi4hv5aH0bwL9LkuyTMKJdd3qw4kyH07ObRrTfbFYCd3CkofHcPFf3mY5VejDFqEKnzeJCBuyfI/0kjkabQ7hW07+/LCUoNRJOx6AhqJobJJsG0JYeG3ujzMBXLQNXJd4Ozy21LEU7c/BNyWJj9cFMaUFbKyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWeUh40U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWeUh40U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD131F000E9;
	Tue, 11 Aug 2026 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786455204;
	bh=7Sd30aEOhfQyIe7QL6M9oxQai+0BjkdiEwllSpjP77U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=mWeUh40URHxYc3olgIJ9JFK3oRYB6LqubUH6s6zOhDs+tJ/sYKt6vEkMEXNwp14Kf
	 f3ALoV4sH+dWHmz7YQv0SBvFIUiwzIO8NUfl2ShUO3HUPOZ60wnbhtv+xinPiEGkfn
	 Lw0PD1fMr08ABDDdAMJYESVyA3EksW2atGjCGm0FAczo4q0ZONOdLgMr4EtsegdBU+
	 EN1RotQotrAUJFc5KOp7J5C6fSqgpbkglfETMoQWZl9ldYl2UhUw8q7/AFEq3QwTSf
	 T+sICUA2kDmM8XTAYy7F6vo5XllAXpL6IbaVlAq6qZFyYE1RZzvuIn+d4inReyOFbg
	 Q0gCDiT3nDRaA==
Date: Tue, 11 Aug 2026 08:33:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
To: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
In-Reply-To: <20260811-wiznet-link-gpio-v4-2-4d5f7da885a8@marmottus.net>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
 <20260811-wiznet-link-gpio-v4-2-4d5f7da885a8@marmottus.net>
Message-Id: <178645520351.2042737.11129823914174003025.robh@kernel.org>
Subject: Re: [PATCH net-next v4 2/3] dt-bindings: net: wiznet,w5100: add
 link status interrupt


On Tue, 11 Aug 2026 14:34:34 +0200, Arthur Crépin Leblond wrote:
> Add an optional link status interrupt which can be connected to the
> LINKLED pin on the device to detect link status changes.
> 
> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
> ---
>  Documentation/devicetree/bindings/net/wiznet,w5100.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wiznet,w5100.yaml: properties:interrupts: {'maxItems': 2, 'items': [{'description': 'Main interrupt (INT pin on the device).'}, {'description': 'Optional interrupt for link status changes (LINKLED pin on w5500).'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260811-wiznet-link-gpio-v4-2-4d5f7da885a8@marmottus.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

