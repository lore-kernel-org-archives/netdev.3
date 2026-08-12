Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B03253B73;
	Wed, 12 Aug 2026 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495727; cv=none; b=X+H1yVhRz8QSS+K7VZmDadRWVttJprWWARXgpUID7jibNvy4AI5u7qMcqTVZFxij/NdNf0SoIB79MLMXimxYfsCr/ETKn5gzmyZJLhUi90805YuQsxyjAQ+89jv1Ynv7n3X9zQjySjC2JC27JOSS3jMjusFtk2pJylktLeZKhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495727; c=relaxed/simple;
	bh=ujg5NaorRU47zge2hfUchCbTmMmn6te2SDfNQNLeugs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m00okUujZcF0NiAb1ehjsb7nPUuEDbtryq8oVMOS0PAJgaBDdS49kc4M6qIrXhUPJgRLckTOGoDxPBiH2ucPdIaW2tpABZSuNUjXmWp012eTDyyUYTOzTdGV0CXHg9LbVfWme3OiZpKzFD9THcIQISWYJMByjzp6C3tXSucoU4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdiOalBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdiOalBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC64D1F000E9;
	Wed, 12 Aug 2026 00:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786495726;
	bh=ujg5NaorRU47zge2hfUchCbTmMmn6te2SDfNQNLeugs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AdiOalBT27y/ojcOkRR2MD/GDvUSAT8bIfH5ExztCZW6F0mJPkmDQqtePO8nihA4+
	 yoT4bt/uApAR4h6Uvy3PuWO6IQSVo3y3Zp5A8KI9v6F+bxSdgxC5NRwZy35u0lZ2Og
	 Vc6zn9U+74QBL7MEFHDnIsEO5x/L9s/d4UtsCdFf5nJXWOUyEq57IQXmfCrPlx3J7x
	 H4vtQtRqwHIODsAA4/TslTC8us0G2WnvXR23z59//D9k9oQDIU0/8BBImTqq2w5mQP
	 rMf1RYZ4ZTaEQlKADQGTWia0N7ThgoRKeOwnmPIbp9XiWtt9Cv02kmLPK9wmwfGbwe
	 z54WgPMehMGxA==
Date: Tue, 11 Aug 2026 17:48:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH] MAINTAINERS: update entry for socfpga dwmac and
 gmii/sgmii
Message-ID: <20260811174845.13af4142@kernel.org>
In-Reply-To: <20260810125415.1717893-1-dinguyen@kernel.org>
References: <20260810125415.1717893-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 07:54:15 -0500 Dinh Nguyen wrote:
> Cc: dinguyen@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
> edumazet@google.com, kuba@kernel.org, devicetree@vger.kernel.org,
> linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
> conor+dt@kernel.org

I don't see Maxime on the CC list here. Please repost and add him.
Just a formality but without an ack and a CC it'd be a bit negligent
for me to apply this..
