Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B13B3C17;
	Wed, 30 Sep 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746245; cv=none; b=qJCPeV7/g3OvU9ISU1qLumM8mYZ9CS+7ZyFjGs4Qor+bJroV6gXfCIIBku8jVj5q+zwC0TXyW1fKWJ92b351PcOlrkwjDc9TOLnPeaULJnPaCfi2lmRux5kxY7IqidZ66vASJ4StIhdoAAYhJPDoDcN6R+jWMdU0IwKZkjYdZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746245; c=relaxed/simple;
	bh=0KjSc7vBna+eDpH9max4wwdWuqVasSuo3ntbZ90YNi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r0d//oo0keituQrjlz+fmHv885H5MxdAlKXhF5Wi4z/eo7vPQxOSzTcUKfr6SnCOuIKp2jiNS52AvIs7L3YSFQZFmDu4Hex00BmQgnQk1N1tZx/FQV9iOLTS7OLGcqZzYNPKEvi5M3DsP7KcgyXOWpgYkBca7DCMi1w83Tyy1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8rvrTqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8rvrTqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FBE1F00893;
	Wed, 30 Sep 2026 05:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790746243;
	bh=Tbkvn8PG08e93g1emqhbUSApc9Iim7uFqR4oEVfWofY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=C8rvrTqgMKmhyDI15Lg7bxRbP/3DRwMw1kGDoD7xtKYkP3hE0ltfWR8KgjLNpkvKU
	 szsXEQexuXnVkVfAbMuRdSjIbnYCU0DIZ6m1KWsWIgq1MU/zw+FT/HW6l0+cJamWOB
	 tTtN1CpFZPgwJNdnSgBUclsmVQK3x/82cYnzdzBCVPiXLf/PVOSERtv9FuAOFS2lA/
	 StBtFvrKTw2tzvBaVq6rHU4Fwx6RplgYxTW1DvVgq7+uxSBXBcNzHxb5KaVKJiinVi
	 eU63XvHTd/3knrYDuscD7Y8SbeFMTavw3aOyAmVhj9iWJ05S9UiRA0fyFdGdPG2kGH
	 G3KaU3uiAJa3g==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Henrik Grimler <henrik.grimler@axis.com>
Cc: linux-arm-kernel@axis.com, kernel@axis.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Henrik Grimler <henrik@grimler.se>
In-Reply-To: <20260928-b4-artpec6-cleanup-v1-2-e3b75e10acc6@axis.com>
References: <20260928-b4-artpec6-cleanup-v1-2-e3b75e10acc6@axis.com>
Subject: Re: (subset) [PATCH 2/7] ARM: dts: axis: artpec6: align all
 continued lines
Message-Id: <179074623976.18076.8809897213040972245.b4-ty@b4>
Date: Wed, 30 Sep 2026 07:30:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 28 Sep 2026 14:04:48 +0200, Henrik Grimler wrote:
> dt-check-style in strict mode reports that there are a bunch of
> multiline properties that are not aligned, fix them to make the dts
> easier to follow. Fixes dt-check-style warnings like:
> 
>   axis/artpec6.dtsi:290: [continuation-alignment] continuation should align to column 34 (to < or ")
> 
> 
> [...]

Applied, thanks!

[2/7] ARM: dts: axis: artpec6: align all continued lines
      https://git.kernel.org/krzk/linux/c/60c916de7b3bf0ff2a4d1d31753a29765941ab89

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

