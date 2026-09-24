Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205743A453F;
	Thu, 24 Sep 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250659; cv=none; b=LBIhkCL94aWGzfsE1MsTmlHgws3zc7KB516Vk0eLE4Dfb0j4G1mFPc/d8vohQLBtFzndbYkbdYtCbSVumqP/+i0Sq4x9Lev9wbqHuwWKh8Nsuhs6UJZpNRmwPGxENMrN0jRooOrki1CKYmiJEDq+5ejNet8pfQlxV3lWXe7K024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250659; c=relaxed/simple;
	bh=ecq7JztJXDK9igaefQFq9PmCo+3TsWm94W6Lf2Fk67s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gletH2KhF4MFKnnYMW0MNPdq7jb4WrlOYx++J5Zv8loIuNlu0BXBKZd5FZUH46ilthQel/+WLjNrYZMCc3DhHCMApmqJ9Orl/ote22RTOWylmyG8C6IaiINRvUPktvfLToAZCeNh+A0EeJ+oBOKYThRi7KDhXu2KDLuc5xxtV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKFAp8nh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKFAp8nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018B11F000FF;
	Thu, 24 Sep 2026 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250657;
	bh=ecq7JztJXDK9igaefQFq9PmCo+3TsWm94W6Lf2Fk67s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YKFAp8nhCjN76fQm/G+TpWiNwhOsVjZwFUvrwZymXNGOSITu7razc2DGKAW/xa0FQ
	 Bekd5eHk5VemAC2vWd2r/ubgA5qlrzwt01AWIuoIavbYPI5lxhnBmO2EP37dqHIISY
	 1TXFqghIsaP9TnwEhTdGZkXjif5rBH1iQypkW+rPR/iPhSFursS2ju1/er/MoUJ5+9
	 ZVKEi0HOkV15O9eYmYEJJq2eOqXua0p7TXHHZvGc5wNHmzglFk9CHel6dfoSEJe5Jz
	 4FDrWiE/0jO7n4qpwXfWKaGaPH1vQN2X57APtuf3QtqDC52AgVTV1h7AKsTxK1h1XI
	 8Y5HzSbWEMNnA==
Date: Thu, 24 Sep 2026 13:50:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alessandro Zini <alessandro.zini@siemens.com>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Qingfang Deng <qingfang.deng@linux.dev>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] dt-bindings: net: adi,ad3306: add
 reset-gpios property
Message-ID: <20260924-grinning-rampant-orca-8a8f26@quoll>
References: <20260918224934.51998-1-alessandro.zini@siemens.com>
 <20260918224934.51998-3-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918224934.51998-3-alessandro.zini@siemens.com>

On Sat, Sep 19, 2026 at 12:49:32AM +0200, Alessandro Zini wrote:
> The ADIN1140/AD3306 MAC-PHY has an active-low hardware reset pin, and the
> driver binds to the common OA TC6 library which is gaining support for an
> optional reset GPIO. As the schema uses "unevaluatedProperties: false", a
> board description using the property would otherwise be rejected.

Whatever library takes or does, will not generate any warnings. I do not
see at all how unevaluatedFalse is relevant here. There is no way
changing library C code causes any warnings. At least as of now.

Also, no properties should be added because some library gets its
support. You add the property because hardware has it.

If the first sentence is correct, then it is enough and keep only this.

> Add the optional reset-gpios property to describe the connection to that
> pin.

This is also redundant, directly implied by the first one.

With drpoping of both:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

