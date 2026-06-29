Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858E23741;
	Mon, 29 Jun 2026 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716988; cv=none; b=opNQnOfH2A8Pn7vqdwEQHqOPWHAbr6VCbWNIXhJ9z2wY85vht/o/cX5wldSeaU2NhOM5oiaWRTrVyJUXxffVr0G25OMI88cJnx68IEgYYh/SFd5QCW0VTP3i64Kl9klEkjY1gFkpR7Qm6ow2YWYnmUyxuTX0Hj68lLXetNN460o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716988; c=relaxed/simple;
	bh=O9F//f1ueQySU+v5TuCixAtYeQ0MtL5Z16aEOxk3bwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anK3AIAEBJ6l9wFnrM9qmX0+eglTjyp0Nvrja35nmyfQV3Ihg20Gb2IPOv+EjVXPAdmJoK/8kK9vR3Afxn3z1GJ0thRsAV1yiA0BMTxvm0Cmqh9BpTUUl5cvRGaAVYENPYW0VjWkPXpwBzqUBuzD25RWOn3RWtEAsBcoH6iM2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asx27Un3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asx27Un3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B45E1F000E9;
	Mon, 29 Jun 2026 07:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782716987;
	bh=IWi+B3OSFP7qzMwsiEkIfGnlZFZLrTs1TR36uK0Jz1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Asx27Un3d8LyoXlJZ/yZRq4W60J7xtO3xE4G/9++x2ID7WpPBsrXXKxoVcP9PULmc
	 YIYDPU5QwquhakBJSNHYZ7CuSBvy4EfIo8HkHXbFSjJmm/G/9v26fokhsblkrQDKFv
	 njrg4oPBnwf0TdqSk8Nhyb3t9HuY0BG6yufuZjzySxh1ZWKFrRko0q24A7+r+TUg2r
	 w3XO6QzxelFQoMBtgzK+ZQrBteokDCZa455v1ce1fPxIFYf5wr7WIHzFpmj0zRgeTi
	 pmNTlEv0nDgKzLNWEzG+gYfi1lCpwWIwtZZGNDvo1oc04hESGgZqW0C6BKJLd2T/A8
	 +QNLvYunKbQKQ==
Date: Mon, 29 Jun 2026 09:09:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] dt-bindings: Fix bracket
Message-ID: <20260629-crystal-hilarious-trout-ee05ab@quoll>
References: <20260627091936.29809-1-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260627091936.29809-1-manuelebner@mailbox.org>

On Sat, Jun 27, 2026 at 11:19:36AM +0200, Manuel Ebner wrote:
> Add "(Alternate" to "ID)"

Why?

I see what you did in the diff, so why repeating it?

> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Best regards,
Krzysztof

