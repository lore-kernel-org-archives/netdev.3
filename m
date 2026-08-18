Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1121C227EA7;
	Tue, 18 Aug 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065163; cv=none; b=ihCtpBKzQxbvRrMEW1zuhFMhizMnoJ5Xo8OMxW/lbx1ZvtjRAm2XaSt5cHoDgj0Z7Quw1y4G5UnREJTAa2BiIYBmbThucLJAT7XibBVDx6DN1JPJveDIlY5FP3kIAyDsDsxAAP+ITgvCpjPAe+Dt5LFzwxrcdhsSlineDlt2LCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065163; c=relaxed/simple;
	bh=GOsA2hcjPYoPgv7s724VVmNz8zIWQj3x1PbRms1UMDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcL7+rB09yBbEp6yeWZXVi5quaiXAkjxlW3rEh1qZMFKFgdJKeR9bmhbmdj+BVsel6+7CA9oMD2ALg52qBSdYBTmKWxjElthSuFYTU1AaQpGAYlcpex0/xA55D5Of6XS/UlQUWjq5zIZZ6s8QNM0DWXHfi7JemkgZtCLEJdGyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWRylHit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWRylHit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393771F000E9;
	Tue, 18 Aug 2026 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065161;
	bh=znMe8y2/1+Ux6RnJpXYSJ0hUctmiKjlZwejuFsDP1aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oWRylHitVoBG6GwqwS3RxryHjB06rJff/e32cqfhisAz2IyMd72K0gKzWzgRLYv5/
	 UBJ3HbJuU528K1wFrf7TQZZl0V0jerTuEnEsHlCaAA4qq/YlvTOf0pxd12sdkCgdEX
	 nA44DLzJ538IC6IINvThiTS2gNs2oHHEI6DuxRp8MnOwHDncEbnz9KDFsDV0LzX0Pe
	 3A6R6lAjrOn9SO1lXhEkx1RW0LmgXVKKNqo5KYz/AUdVSIPP69RuJL8NhAnznRpEmM
	 W8/Y9xD/l7VsM++UoIsGxpkL6Ts18sxpcqP2VBrnjPcUIx5JNnww1BqV1eCZJcWtye
	 gJjLvSeOXnNsQ==
Date: Tue, 18 Aug 2026 07:59:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: pabeni@redhat.com
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, bjorn@mork.no,
 sander@svanheule.net
Subject: Re: [PATCH net-next v14 0/4] net: pse-pd: add Realtek PSE MCU
 support
Message-ID: <20260818075920.4580f583@kernel.org>
In-Reply-To: <178705861416.2079194.11658601794072677702.git-patchwork-notify@kernel.org>
References: <20260813222036.873930-1-jelonek.jonas@gmail.com>
	<178705861416.2079194.11658601794072677702.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 13:10:14 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
>   - [net-next,v14,1/4] dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
>     https://git.kernel.org/netdev/net-next/c/368990e9f6c6

Was this reviewed by device tree maintainers?
