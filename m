Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88905418340;
	Wed,  7 Oct 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363375; cv=none; b=UXq2mHgfcqvtCdZKIF7hTNaiMT5ljuCuSSP2Gg+J0c5NJu657jBwYVuyFGFB9wytp1IDfx0WxAapLveMLtkruemsTMvGbn1oJkZ6HhSJfgG1G/wopL2MTed7GpG+AeyWMx+eqaulNominjjxdjN9/HSa90XIDSRHrcZA1nbxgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363375; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2bpGziowGOD4IqwgT/d8yo+SSnd1R1b9V/+Sed5gjNllrChBA6Gn1a7kpzCqKEWqNzwDY4soe99MHpf1rfTINhs5p3J0MXT35HApOURNKIJE3CPcQLyveVcjPldLf8CqFMte+Pdlp4dT8h3/hi7x6mj+iprp/cJTpI2zm7YoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odVzmI6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odVzmI6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4472D1F0089B;
	Wed,  7 Oct 2026 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791363374;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odVzmI6J3aG13jtfoB+xU8DJnQc2Z73iZZ9UfV9ouNOhz6s2l5yFfnmqmvq2CqzaS
	 6u0CpkgM+sOIJFkuOot22Cizd4yku7ftPaZ4WN8KrD8Z0L57lPmT2t9kLP6DeMp0jY
	 IHdUwIz6rJxWy6nr6PFY2mdNxsqruaQuFBE6z2vx1fIKqcH3QXQFM6OcklbMgpON7N
	 uoV+niBOmxCuiWbGDiAqSja5gr8/LxyFRq3VrQ8qW2WaaHQqsbAV30S3K1/cl0zWOx
	 4E4fVmuz1bdEoSYORIkyRmYYCURgflxOEWQ6rfikLS38XuJPJtJoHSEVyq3NSGQRpQ
	 GYwMArtEqrGow==
From: netdev-bot+sinfo@kernel.org
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v3 0/8] net: bcmgenet: support larger MTUs
Date: Wed, 07 Oct 2026 08:56:12 +0000
Message-ID: <179136337262.2527009.9220130121409362777@kernel.org>
In-Reply-To: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
References: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
